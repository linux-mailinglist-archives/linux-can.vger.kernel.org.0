Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4674CCC435
	for <lists+linux-can@lfdr.de>; Fri,  4 Oct 2019 22:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfJDUah (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Oct 2019 16:30:37 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37263 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbfJDUah (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Oct 2019 16:30:37 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iGUDj-0003Pq-CX; Fri, 04 Oct 2019 22:30:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        Anssi Hannula <anssi.hannula@bitwise.fi>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2] can: xilinx_can: avoid non-requested bus error frames
Date:   Fri,  4 Oct 2019 22:30:33 +0200
Message-Id: <20191004203033.4582-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Anssi Hannula <anssi.hannula@bitwise.fi>

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
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

taking up Anssi Hannula's work.

changes since v1:
- xcan_err_interrupt(): use C99 initializers instead of memset() to
  initialize struct can_frame cf.
- xcan_err_interrupt(): convert initialization of berr_reporting to use
  "if".

Please test.

regards,
Marc

 drivers/net/can/xilinx_can.c | 89 +++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 8abc24e6c521..01e3faee71f2 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -470,7 +470,13 @@ static int xcan_chip_start(struct net_device *ndev)
 	if (err < 0)
 		return err;
 
-	/* Enable interrupts */
+	/* Enable interrupts
+	 *
+	 * We enable the ERROR interrupt even with
+	 * CAN_CTRLMODE_BERR_REPORTING disabled as there is no
+	 * dedicated interrupt for a state change to
+	 * ERROR_WARNING/ERROR_PASSIVE.
+	 */
 	ier = XCAN_IXR_TXOK_MASK | XCAN_IXR_BSOFF_MASK |
 		XCAN_IXR_WKUP_MASK | XCAN_IXR_SLP_MASK |
 		XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
@@ -980,12 +986,9 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
-	struct can_frame *cf;
-	struct sk_buff *skb;
+	struct can_frame cf = { };
 	u32 err_status;
 
-	skb = alloc_can_err_skb(ndev, &cf);
-
 	err_status = priv->read_reg(priv, XCAN_ESR_OFFSET);
 	priv->write_reg(priv, XCAN_ESR_OFFSET, err_status);
 
@@ -995,32 +998,27 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
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
@@ -1028,68 +1026,77 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
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
+		bool berr_reporting = false;
+
+		if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
+			berr_reporting = true;
+			cf.can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+		}
 
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
2.23.0

