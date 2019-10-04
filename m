Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 079CACB712
	for <lists+linux-can@lfdr.de>; Fri,  4 Oct 2019 11:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbfJDJKy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Oct 2019 05:10:54 -0400
Received: from mail.bitwise.fi ([109.204.228.163]:49668 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfJDJKy (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 4 Oct 2019 05:10:54 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Oct 2019 05:10:52 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 597A460064;
        Fri,  4 Oct 2019 12:03:43 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.bitwise.fi
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mail.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wFSGqdCHMa4e; Fri,  4 Oct 2019 12:03:40 +0300 (EEST)
Received: from localhost.sec.bitwise.fi (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id B48F860027;
        Fri,  4 Oct 2019 12:03:40 +0300 (EEST)
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-can@vger.kernel.org,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH] can: xilinx_can: avoid non-requested bus error frames
Date:   Fri,  4 Oct 2019 12:02:56 +0300
Message-Id: <20191004090256.13931-1-anssi.hannula@bitwise.fi>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Userspace can signal with CAN_CTRLMODE_BERR_REPORTING whether they need
reporting of bus errors (CAN_ERR_BUSERROR) or not.

However, xilinx_can driver currently always sends CAN_ERR_BUSERROR
frames to userspace on bus errors.

To improve performance on error conditions when bus error reporting is
not needed, avoid sending CAN_ERR_BUSERROR frames unless requested via
CAN_CTRLMODE_BERR_REPORTING.

The error interrupt is still kept enabled as there is no dedicated state
transition interrupt, but just disabling error frame submission still
yields a significant performance improvement. In a simple test with
continuous bus errors and no userspace programs reading/writing CAN I
saw system CPU load reduced by 1/3.

Tested on a ZynqMP board with CAN-FD v1.0.

Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
 drivers/net/can/xilinx_can.c | 84 +++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 911b34316c9d..9b9ec07f7e5b 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -471,6 +471,10 @@ static int xcan_chip_start(struct net_device *ndev)
 		return err;
 
 	/* Enable interrupts */
+	/* We enable the ERROR interrupt even with CAN_CTRLMODE_BERR_REPORTING
+	 * disabled as there is no dedicated interrupt for a state change to
+	 * ERROR_WARNING/ERROR_PASSIVE.
+	 */
 	ier = XCAN_IXR_TXOK_MASK | XCAN_IXR_BSOFF_MASK |
 		XCAN_IXR_WKUP_MASK | XCAN_IXR_SLP_MASK |
 		XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
@@ -981,11 +985,10 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
-	struct can_frame *cf;
-	struct sk_buff *skb;
+	struct can_frame cf;
 	u32 err_status;
 
-	skb = alloc_can_err_skb(ndev, &cf);
+	memset(&cf, 0, sizeof(cf));
 
 	err_status = priv->read_reg(priv, XCAN_ESR_OFFSET);
 	priv->write_reg(priv, XCAN_ESR_OFFSET, err_status);
@@ -996,32 +999,27 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 		/* Leave device in Config Mode in bus-off state */
 		priv->write_reg(priv, XCAN_SRR_OFFSET, XCAN_SRR_RESET_MASK);
 		can_bus_off(ndev);
-		if (skb)
-			cf->can_id |= CAN_ERR_BUSOFF;
+		cf.can_id |= CAN_ERR_BUSOFF;
 	} else {
 		enum can_state new_state = xcan_current_error_state(ndev);
 
 		if (new_state != priv->can.state)
-			xcan_set_error_state(ndev, new_state, skb ? cf : NULL);
+			xcan_set_error_state(ndev, new_state, &cf);
 	}
 
 	/* Check for Arbitration lost interrupt */
 	if (isr & XCAN_IXR_ARBLST_MASK) {
 		priv->can.can_stats.arbitration_lost++;
-		if (skb) {
-			cf->can_id |= CAN_ERR_LOSTARB;
-			cf->data[0] = CAN_ERR_LOSTARB_UNSPEC;
-		}
+		cf.can_id |= CAN_ERR_LOSTARB;
+		cf.data[0] = CAN_ERR_LOSTARB_UNSPEC;
 	}
 
 	/* Check for RX FIFO Overflow interrupt */
 	if (isr & XCAN_IXR_RXOFLW_MASK) {
 		stats->rx_over_errors++;
 		stats->rx_errors++;
-		if (skb) {
-			cf->can_id |= CAN_ERR_CRTL;
-			cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
-		}
+		cf.can_id |= CAN_ERR_CRTL;
+		cf.data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
 	}
 
 	/* Check for RX Match Not Finished interrupt */
@@ -1029,68 +1027,76 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 		stats->rx_dropped++;
 		stats->rx_errors++;
 		netdev_err(ndev, "RX match not finished, frame discarded\n");
-		if (skb) {
-			cf->can_id |= CAN_ERR_CRTL;
-			cf->data[1] |= CAN_ERR_CRTL_UNSPEC;
-		}
+		cf.can_id |= CAN_ERR_CRTL;
+		cf.data[1] |= CAN_ERR_CRTL_UNSPEC;
 	}
 
 	/* Check for error interrupt */
 	if (isr & XCAN_IXR_ERROR_MASK) {
-		if (skb)
-			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+		bool berr_reporting = !!(priv->can.ctrlmode &
+					 CAN_CTRLMODE_BERR_REPORTING);
+
+		if (berr_reporting)
+			cf.can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
 		/* Check for Ack error interrupt */
 		if (err_status & XCAN_ESR_ACKER_MASK) {
 			stats->tx_errors++;
-			if (skb) {
-				cf->can_id |= CAN_ERR_ACK;
-				cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+			if (berr_reporting) {
+				cf.can_id |= CAN_ERR_ACK;
+				cf.data[3] = CAN_ERR_PROT_LOC_ACK;
 			}
 		}
 
 		/* Check for Bit error interrupt */
 		if (err_status & XCAN_ESR_BERR_MASK) {
 			stats->tx_errors++;
-			if (skb) {
-				cf->can_id |= CAN_ERR_PROT;
-				cf->data[2] = CAN_ERR_PROT_BIT;
+			if (berr_reporting) {
+				cf.can_id |= CAN_ERR_PROT;
+				cf.data[2] = CAN_ERR_PROT_BIT;
 			}
 		}
 
 		/* Check for Stuff error interrupt */
 		if (err_status & XCAN_ESR_STER_MASK) {
 			stats->rx_errors++;
-			if (skb) {
-				cf->can_id |= CAN_ERR_PROT;
-				cf->data[2] = CAN_ERR_PROT_STUFF;
+			if (berr_reporting) {
+				cf.can_id |= CAN_ERR_PROT;
+				cf.data[2] = CAN_ERR_PROT_STUFF;
 			}
 		}
 
 		/* Check for Form error interrupt */
 		if (err_status & XCAN_ESR_FMER_MASK) {
 			stats->rx_errors++;
-			if (skb) {
-				cf->can_id |= CAN_ERR_PROT;
-				cf->data[2] = CAN_ERR_PROT_FORM;
+			if (berr_reporting) {
+				cf.can_id |= CAN_ERR_PROT;
+				cf.data[2] = CAN_ERR_PROT_FORM;
 			}
 		}
 
 		/* Check for CRC error interrupt */
 		if (err_status & XCAN_ESR_CRCER_MASK) {
 			stats->rx_errors++;
-			if (skb) {
-				cf->can_id |= CAN_ERR_PROT;
-				cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+			if (berr_reporting) {
+				cf.can_id |= CAN_ERR_PROT;
+				cf.data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 			}
 		}
 		priv->can.can_stats.bus_error++;
 	}
 
-	if (skb) {
-		stats->rx_packets++;
-		stats->rx_bytes += cf->can_dlc;
-		netif_rx(skb);
+	if (cf.can_id) {
+		struct can_frame *skb_cf;
+		struct sk_buff *skb = alloc_can_err_skb(ndev, &skb_cf);
+
+		if (skb) {
+			skb_cf->can_id |= cf.can_id;
+			memcpy(skb_cf->data, cf.data, CAN_ERR_DLC);
+			stats->rx_packets++;
+			stats->rx_bytes += CAN_ERR_DLC;
+			netif_rx(skb);
+		}
 	}
 
 	netdev_dbg(ndev, "%s: error status register:0x%x\n",
-- 
2.21.0

