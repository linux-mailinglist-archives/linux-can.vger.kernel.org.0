Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 482C511546E
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 16:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfLFPjU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 10:39:20 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:45142 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfLFPjU (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 6 Dec 2019 10:39:20 -0500
Received: from linux-dev.peak.localnet (unknown [185.109.201.203])
        (Authenticated sender: stephane.grosjean)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id AE3A7B005AC;
        Fri,  6 Dec 2019 16:39:13 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 2/2] can/peak_usb/pcan_usb: add support of rxerr/txerr counters
Date:   Fri,  6 Dec 2019 16:38:03 +0100
Message-Id: <20191206153803.17725-3-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191206153803.17725-1-s.grosjean@peak-system.com>
References: <20191206153803.17725-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds the support of the rx/tx errors CAN counters to the
driver of the PCAN-USB PC-CAN interface from PEAK-System GmbH.

The PCAN-USB is capable of giving back the values of the rx/tx errors
counters, to provide more details and statistics to the linux-can layer.
Getting these values allows the driver to better tune CAN_ERR_CRTL_TX_xxx
and CAN_ERR_CRTL_RX_xxx bits in case of the interface enters any
CAN_STATE_ERROR_xxx state.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 133 +++++++++++++++++++++---
 1 file changed, 117 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index fedfa6f7a5e8..419cf2953a0d 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -41,6 +41,7 @@ MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB adapter");
 #define PCAN_USB_CMD_SN		6
 #define PCAN_USB_CMD_REGISTER	9
 #define PCAN_USB_CMD_EXT_VCC	10
+#define PCAN_USB_CMD_ERR_FR	11
 
 /* PCAN_USB_CMD_SET_BUS number arg */
 #define PCAN_USB_BUS_XCVER		2
@@ -82,6 +83,10 @@ MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB adapter");
 #define PCAN_USB_ERROR_QOVR		0x40
 #define PCAN_USB_ERROR_TXQFULL		0x80
 
+#define PCAN_USB_ERROR_BUS		(PCAN_USB_ERROR_BUS_LIGHT | \
+					 PCAN_USB_ERROR_BUS_HEAVY | \
+					 PCAN_USB_ERROR_BUS_OFF)
+
 /* SJA1000 modes */
 #define SJA1000_MODE_NORMAL		0x00
 #define SJA1000_MODE_INIT		0x01
@@ -101,11 +106,25 @@ MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB adapter");
 #define PCAN_USB_REC_TS			4
 #define PCAN_USB_REC_BUSEVT		5
 
+/* CAN bus events notifications selection mask */
+#define PCAN_USB_ERR_RXERR		0x02	/* ask for rxerr counter */
+#define PCAN_USB_ERR_TXERR		0x04	/* ask for txerr counter */
+
+/* This mask generates an usb packet each time the state of the bus changes.
+ * In other words, its interest is to know which side among rx and tx is
+ * responsible of the change of the bus state.
+ */
+#define PCAN_USB_BERR_MASK	(PCAN_USB_ERR_RXERR | PCAN_USB_ERR_TXERR)
+
+/* identify bus event packets with rx/tx error counters */
+#define PCAN_USB_ERR_CNT		0x80
+
 /* private to PCAN-USB adapter */
 struct pcan_usb {
 	struct peak_usb_device dev;
 	struct peak_time_ref time_ref;
 	struct timer_list restart_timer;
+	struct can_berr_counter bec;
 };
 
 /* incoming message context for decoding */
@@ -212,6 +231,16 @@ static int pcan_usb_set_silent(struct peak_usb_device *dev, u8 onoff)
 				 PCAN_USB_BUS_SILENT_MODE, args);
 }
 
+/* send the cmd to be notified from bus errors */
+static int pcan_usb_set_err_frame(struct peak_usb_device *dev, u8 err_mask)
+{
+	u8 args[PCAN_USB_CMD_ARGS_LEN] = {
+		[0] = err_mask,
+	};
+
+	return pcan_usb_send_cmd(dev, PCAN_USB_CMD_ERR_FR, PCAN_USB_SET, args);
+}
+
 static int pcan_usb_set_ext_vcc(struct peak_usb_device *dev, u8 onoff)
 {
 	u8 args[PCAN_USB_CMD_ARGS_LEN] = {
@@ -445,7 +474,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 			new_state = CAN_STATE_BUS_OFF;
 			break;
 		}
-		if (n & (PCAN_USB_ERROR_RXQOVR | PCAN_USB_ERROR_QOVR)) {
+		if (n & ~PCAN_USB_ERROR_BUS) {
 			/*
 			 * trick to bypass next comparison and process other
 			 * errors
@@ -469,7 +498,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 			new_state = CAN_STATE_ERROR_WARNING;
 			break;
 		}
-		if (n & (PCAN_USB_ERROR_RXQOVR | PCAN_USB_ERROR_QOVR)) {
+		if (n & ~PCAN_USB_ERROR_BUS) {
 			/*
 			 * trick to bypass next comparison and process other
 			 * errors
@@ -508,29 +537,50 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 
 	case CAN_STATE_ERROR_PASSIVE:
 		cf->can_id |= CAN_ERR_CRTL;
-		cf->data[1] |= CAN_ERR_CRTL_TX_PASSIVE |
-			       CAN_ERR_CRTL_RX_PASSIVE;
+		cf->data[1] = (mc->pdev->bec.txerr > mc->pdev->bec.rxerr) ?
+				CAN_ERR_CRTL_TX_PASSIVE :
+				CAN_ERR_CRTL_RX_PASSIVE;
+		cf->data[6] = mc->pdev->bec.txerr;
+		cf->data[7] = mc->pdev->bec.rxerr;
+
 		mc->pdev->dev.can.can_stats.error_passive++;
 		break;
 
 	case CAN_STATE_ERROR_WARNING:
 		cf->can_id |= CAN_ERR_CRTL;
-		cf->data[1] |= CAN_ERR_CRTL_TX_WARNING |
-			       CAN_ERR_CRTL_RX_WARNING;
+		cf->data[1] = (mc->pdev->bec.txerr > mc->pdev->bec.rxerr) ?
+				CAN_ERR_CRTL_TX_WARNING :
+				CAN_ERR_CRTL_RX_WARNING;
+		cf->data[6] = mc->pdev->bec.txerr;
+		cf->data[7] = mc->pdev->bec.rxerr;
+
 		mc->pdev->dev.can.can_stats.error_warning++;
 		break;
 
 	case CAN_STATE_ERROR_ACTIVE:
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->data[1] = CAN_ERR_CRTL_ACTIVE;
+
+		/* sync local copies of rxerr/txerr counters */
+		mc->pdev->bec.txerr = 0;
+		mc->pdev->bec.rxerr = 0;
 		break;
 
 	default:
 		/* CAN_STATE_MAX (trick to handle other errors) */
-		cf->can_id |= CAN_ERR_CRTL;
-		cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
-		mc->netdev->stats.rx_over_errors++;
-		mc->netdev->stats.rx_errors++;
+		if (n & PCAN_USB_ERROR_TXQFULL)
+			netdev_dbg(mc->netdev, "device Tx queue full)\n");
+
+		if (n & PCAN_USB_ERROR_RXQOVR) {
+			netdev_dbg(mc->netdev, "data overrun interrupt\n");
+			cf->can_id |= CAN_ERR_CRTL;
+			cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
+			mc->netdev->stats.rx_over_errors++;
+			mc->netdev->stats.rx_errors++;
+		}
+
+		cf->data[6] = mc->pdev->bec.txerr;
+		cf->data[7] = mc->pdev->bec.rxerr;
 
 		new_state = mc->pdev->dev.can.state;
 		break;
@@ -552,6 +602,30 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 	return 0;
 }
 
+/* decode bus event usb packet: first byte contains rxerr while 2nd one contains
+ * txerr.
+ */
+static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 ir)
+{
+	struct pcan_usb *pdev = mc->pdev;
+
+	/* acccording to the content of the packet */
+	switch (ir) {
+	case PCAN_USB_ERR_CNT:
+
+		/* save rx/tx error counters from in the device context */
+		pdev->bec.rxerr = mc->ptr[0];
+		pdev->bec.txerr = mc->ptr[1];
+		break;
+
+	default:
+		/* reserved */
+		break;
+	}
+
+	return 0;
+}
+
 /*
  * decode non-data usb message
  */
@@ -606,9 +680,10 @@ static int pcan_usb_decode_status(struct pcan_usb_msg_context *mc,
 		break;
 
 	case PCAN_USB_REC_BUSEVT:
-		/* error frame/bus event */
-		if (n & PCAN_USB_ERROR_TXQFULL)
-			netdev_dbg(mc->netdev, "device Tx queue full)\n");
+		/* bus event notifications (get rxerr/txerr) */
+		err = pcan_usb_handle_bus_evt(mc, n);
+		if (err)
+			return err;
 		break;
 	default:
 		netdev_err(mc->netdev, "unexpected function %u\n", f);
@@ -792,20 +867,44 @@ static int pcan_usb_encode_msg(struct peak_usb_device *dev, struct sk_buff *skb,
 	return 0;
 }
 
+/* socket callback used to copy berr counters values received through USB */
+static int pcan_usb_get_berr_counter(const struct net_device *netdev,
+				     struct can_berr_counter *bec)
+{
+	struct peak_usb_device *dev = netdev_priv(netdev);
+	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
+
+	*bec = pdev->bec;
+
+	/* must return 0 */
+	return 0;
+}
+
 /*
  * start interface
  */
 static int pcan_usb_start(struct peak_usb_device *dev)
 {
 	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
+	int err;
 
 	/* number of bits used in timestamps read from adapter struct */
 	peak_usb_init_time_ref(&pdev->time_ref, &pcan_usb);
 
+	pdev->bec.rxerr = 0;
+	pdev->bec.txerr = 0;
+
+	/* be notified on error counter changes (if requested by user) */
+	if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
+		err = pcan_usb_set_err_frame(dev, PCAN_USB_BERR_MASK);
+		if (err)
+			netdev_warn(dev->netdev,
+				    "Asking for BERR reporting error %u\n",
+				    err);
+	}
+
 	/* if revision greater than 3, can put silent mode on/off */
 	if (dev->device_rev > 3) {
-		int err;
-
 		err = pcan_usb_set_silent(dev,
 				dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY);
 		if (err)
@@ -892,7 +991,8 @@ const struct peak_usb_adapter pcan_usb = {
 	.name = "PCAN-USB",
 	.device_id = PCAN_USB_PRODUCT_ID,
 	.ctrl_count = 1,
-	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
+	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
+			      CAN_CTRLMODE_BERR_REPORTING,
 	.clock = {
 		.freq = PCAN_USB_CRYSTAL_HZ / 2 ,
 	},
@@ -925,4 +1025,5 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
 	.dev_restart_async = pcan_usb_restart_async,
+	.do_get_berr_counter = pcan_usb_get_berr_counter,
 };
-- 
2.20.1

