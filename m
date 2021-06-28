Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE6D3B6088
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 16:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhF1OZg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 10:25:36 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:18756 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233682AbhF1OYH (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 28 Jun 2021 10:24:07 -0400
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 10BC05FFA3;
        Mon, 28 Jun 2021 16:21:07 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH v2 1/2] can: peak_usb: upgrades the handling of bus state changes
Date:   Mon, 28 Jun 2021 16:20:42 +0200
Message-Id: <20210628142043.15034-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch updates old code by using the functions published since by the
socket-can module. In particular, this new code better manages the change
of bus state by also using the value of the error counters that the driver
now systematically asks for when initializing the channel.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
v2:
 - do the statistics and state update, even if the allocation of the skb
   fails.

 drivers/net/can/usb/peak_usb/pcan_usb.c | 161 ++++++------------------
 1 file changed, 38 insertions(+), 123 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 7d18bc6911f5..4c3e18ca3181 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -453,146 +453,61 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 {
 	struct sk_buff *skb;
 	struct can_frame *cf;
-	enum can_state new_state;
+	enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
 
 	/* ignore this error until 1st ts received */
 	if (n == PCAN_USB_ERROR_QOVR)
 		if (!mc->pdev->time_ref.tick_count)
 			return 0;
 
-	new_state = mc->pdev->dev.can.state;
-
-	switch (mc->pdev->dev.can.state) {
-	case CAN_STATE_ERROR_ACTIVE:
-		if (n & PCAN_USB_ERROR_BUS_LIGHT) {
-			new_state = CAN_STATE_ERROR_WARNING;
-			break;
-		}
-		fallthrough;
-
-	case CAN_STATE_ERROR_WARNING:
-		if (n & PCAN_USB_ERROR_BUS_HEAVY) {
-			new_state = CAN_STATE_ERROR_PASSIVE;
-			break;
-		}
-		if (n & PCAN_USB_ERROR_BUS_OFF) {
-			new_state = CAN_STATE_BUS_OFF;
-			break;
-		}
-		if (n & ~PCAN_USB_ERROR_BUS) {
-			/*
-			 * trick to bypass next comparison and process other
-			 * errors
-			 */
-			new_state = CAN_STATE_MAX;
-			break;
-		}
-		if ((n & PCAN_USB_ERROR_BUS_LIGHT) == 0) {
-			/* no error (back to active state) */
-			new_state = CAN_STATE_ERROR_ACTIVE;
-			break;
-		}
-		break;
-
-	case CAN_STATE_ERROR_PASSIVE:
-		if (n & PCAN_USB_ERROR_BUS_OFF) {
-			new_state = CAN_STATE_BUS_OFF;
-			break;
-		}
-		if (n & PCAN_USB_ERROR_BUS_LIGHT) {
-			new_state = CAN_STATE_ERROR_WARNING;
-			break;
-		}
-		if (n & ~PCAN_USB_ERROR_BUS) {
-			/*
-			 * trick to bypass next comparison and process other
-			 * errors
-			 */
-			new_state = CAN_STATE_MAX;
-			break;
-		}
-
-		if ((n & PCAN_USB_ERROR_BUS_HEAVY) == 0) {
-			/* no error (back to warning state) */
-			new_state = CAN_STATE_ERROR_WARNING;
-			break;
-		}
-		break;
-
-	default:
-		/* do nothing waiting for restart */
-		return 0;
-	}
-
-	/* donot post any error if current state didn't change */
-	if (mc->pdev->dev.can.state == new_state)
-		return 0;
-
 	/* allocate an skb to store the error frame */
 	skb = alloc_can_err_skb(mc->netdev, &cf);
-	if (!skb)
-		return -ENOMEM;
-
-	switch (new_state) {
-	case CAN_STATE_BUS_OFF:
-		cf->can_id |= CAN_ERR_BUSOFF;
-		mc->pdev->dev.can.can_stats.bus_off++;
-		can_bus_off(mc->netdev);
-		break;
-
-	case CAN_STATE_ERROR_PASSIVE:
-		cf->can_id |= CAN_ERR_CRTL;
-		cf->data[1] = (mc->pdev->bec.txerr > mc->pdev->bec.rxerr) ?
-				CAN_ERR_CRTL_TX_PASSIVE :
-				CAN_ERR_CRTL_RX_PASSIVE;
-		cf->data[6] = mc->pdev->bec.txerr;
-		cf->data[7] = mc->pdev->bec.rxerr;
-
-		mc->pdev->dev.can.can_stats.error_passive++;
-		break;
-
-	case CAN_STATE_ERROR_WARNING:
-		cf->can_id |= CAN_ERR_CRTL;
-		cf->data[1] = (mc->pdev->bec.txerr > mc->pdev->bec.rxerr) ?
-				CAN_ERR_CRTL_TX_WARNING :
-				CAN_ERR_CRTL_RX_WARNING;
-		cf->data[6] = mc->pdev->bec.txerr;
-		cf->data[7] = mc->pdev->bec.rxerr;
-
-		mc->pdev->dev.can.can_stats.error_warning++;
-		break;
 
-	case CAN_STATE_ERROR_ACTIVE:
-		cf->can_id |= CAN_ERR_CRTL;
-		cf->data[1] = CAN_ERR_CRTL_ACTIVE;
-
-		/* sync local copies of rxerr/txerr counters */
-		mc->pdev->bec.txerr = 0;
-		mc->pdev->bec.rxerr = 0;
-		break;
-
-	default:
-		/* CAN_STATE_MAX (trick to handle other errors) */
-		if (n & PCAN_USB_ERROR_TXQFULL)
-			netdev_dbg(mc->netdev, "device Tx queue full)\n");
-
-		if (n & PCAN_USB_ERROR_RXQOVR) {
-			netdev_dbg(mc->netdev, "data overrun interrupt\n");
+	if (n & PCAN_USB_ERROR_RXQOVR) {
+		/* data overrun interrupt */
+		netdev_dbg(mc->netdev, "data overrun interrupt\n");
+		mc->netdev->stats.rx_over_errors++;
+		mc->netdev->stats.rx_errors++;
+		if (skb) {
 			cf->can_id |= CAN_ERR_CRTL;
 			cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
-			mc->netdev->stats.rx_over_errors++;
-			mc->netdev->stats.rx_errors++;
 		}
+	}
 
-		cf->data[6] = mc->pdev->bec.txerr;
-		cf->data[7] = mc->pdev->bec.rxerr;
+	if (n & PCAN_USB_ERROR_TXQFULL)
+		netdev_dbg(mc->netdev, "device Tx queue full)\n");
 
-		new_state = mc->pdev->dev.can.state;
-		break;
+	if (n & PCAN_USB_ERROR_BUS_OFF) {
+		new_state = CAN_STATE_BUS_OFF;
+	} else if (n & PCAN_USB_ERROR_BUS_HEAVY) {
+		new_state = ((mc->pdev->bec.txerr >= 128) ||
+			     (mc->pdev->bec.rxerr >= 128)) ?
+				CAN_STATE_ERROR_PASSIVE :
+				CAN_STATE_ERROR_WARNING;
+	} else {
+		new_state = CAN_STATE_ERROR_ACTIVE;
 	}
 
-	mc->pdev->dev.can.state = new_state;
+	/* handle change of state */
+	if (new_state != mc->pdev->dev.can.state) {
+		if (skb) {
+			enum can_state tx_state =
+				(mc->pdev->bec.txerr >= mc->pdev->bec.rxerr) ?
+					new_state : 0;
+			enum can_state rx_state =
+				(mc->pdev->bec.txerr <= mc->pdev->bec.rxerr) ?
+					new_state : 0;
+
+			can_change_state(mc->netdev, cf, tx_state, rx_state);
+		}
+
+		/* things must be done even in case of OOM */
+		if (new_state == CAN_STATE_BUS_OFF)
+			can_bus_off(mc->netdev);
+	}
 
+	if (!skb)
+		return -ENOMEM;
 	if (status_len & PCAN_USB_STATUSLEN_TIMESTAMP) {
 		struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
 
-- 
2.25.1

