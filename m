Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3193B4425
	for <lists+linux-can@lfdr.de>; Fri, 25 Jun 2021 15:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhFYNNi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Jun 2021 09:13:38 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:35480 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231512AbhFYNNh (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 25 Jun 2021 09:13:37 -0400
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id D2AA65FF67;
        Fri, 25 Jun 2021 15:10:41 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 5/5] can: peak_usb: upgrades the handling of bus state changes
Date:   Fri, 25 Jun 2021 15:09:31 +0200
Message-Id: <20210625130931.27438-6-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210625130931.27438-1-s.grosjean@peak-system.com>
References: <20210625130931.27438-1-s.grosjean@peak-system.com>
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
 drivers/net/can/usb/peak_usb/pcan_usb.c | 169 ++++++------------------
 1 file changed, 41 insertions(+), 128 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 7d18bc6911f5..1ab3be8dbb83 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -453,146 +453,59 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
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
+	if (n & PCAN_USB_ERROR_TXQFULL) {
+		netdev_dbg(mc->netdev, "device Tx queue full)\n");
 		return 0;
 	}
 
-	/* donot post any error if current state didn't change */
-	if (mc->pdev->dev.can.state == new_state)
-		return 0;
-
 	/* allocate an skb to store the error frame */
 	skb = alloc_can_err_skb(mc->netdev, &cf);
 	if (!skb)
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
+		return 0;
 
-	case CAN_STATE_ERROR_ACTIVE:
+	if (n & PCAN_USB_ERROR_RXQOVR) {
+		/* data overrun interrupt */
+		netdev_dbg(mc->netdev, "data overrun interrupt\n");
 		cf->can_id |= CAN_ERR_CRTL;
-		cf->data[1] = CAN_ERR_CRTL_ACTIVE;
+		cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
+		mc->netdev->stats.rx_over_errors++;
+		mc->netdev->stats.rx_errors++;
+	}
 
-		/* sync local copies of rxerr/txerr counters */
-		mc->pdev->bec.txerr = 0;
-		mc->pdev->bec.rxerr = 0;
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
+	}
 
-	default:
-		/* CAN_STATE_MAX (trick to handle other errors) */
-		if (n & PCAN_USB_ERROR_TXQFULL)
-			netdev_dbg(mc->netdev, "device Tx queue full)\n");
-
-		if (n & PCAN_USB_ERROR_RXQOVR) {
-			netdev_dbg(mc->netdev, "data overrun interrupt\n");
-			cf->can_id |= CAN_ERR_CRTL;
-			cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
-			mc->netdev->stats.rx_over_errors++;
-			mc->netdev->stats.rx_errors++;
-		}
+	/* handle change of state */
+	if (new_state != mc->pdev->dev.can.state) {
+		enum can_state tx_state =
+			(mc->pdev->bec.txerr >= mc->pdev->bec.rxerr) ?
+				new_state : 0;
+		enum can_state rx_state =
+			(mc->pdev->bec.txerr <= mc->pdev->bec.rxerr) ?
+				new_state : 0;
 
-		cf->data[6] = mc->pdev->bec.txerr;
-		cf->data[7] = mc->pdev->bec.rxerr;
+		can_change_state(mc->netdev, cf, tx_state, rx_state);
 
-		new_state = mc->pdev->dev.can.state;
-		break;
+		/* things must be done even in case of OOM */
+		if (new_state == CAN_STATE_BUS_OFF)
+			can_bus_off(mc->netdev);
 	}
 
-	mc->pdev->dev.can.state = new_state;
-
 	if (status_len & PCAN_USB_STATUSLEN_TIMESTAMP) {
 		struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
 
@@ -921,14 +834,14 @@ static int pcan_usb_start(struct peak_usb_device *dev)
 	pdev->bec.rxerr = 0;
 	pdev->bec.txerr = 0;
 
-	/* be notified on error counter changes (if requested by user) */
-	if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
-		err = pcan_usb_set_err_frame(dev, PCAN_USB_BERR_MASK);
-		if (err)
-			netdev_warn(dev->netdev,
-				    "Asking for BERR reporting error %u\n",
-				    err);
-	}
+	/* always ask the device for BERR reporting, to be able to switch from
+	 * WARNING to PASSIVE state
+	 */
+	err = pcan_usb_set_err_frame(dev, PCAN_USB_BERR_MASK);
+	if (err)
+		netdev_warn(dev->netdev,
+			    "Asking for BERR reporting error %u\n",
+			    err);
 
 	/* if revision greater than 3, can put silent mode on/off */
 	if (dev->device_rev > 3) {
-- 
2.25.1

