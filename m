Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B163FCF521
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 10:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfJHIij (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 04:38:39 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:18265 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbfJHIij (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 8 Oct 2019 04:38:39 -0400
Received: from linux-dev.peak.localnet (unknown [185.109.201.203])
        (Authenticated sender: stephane.grosjean)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 34F72B005C8;
        Tue,  8 Oct 2019 10:38:32 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 2/2] can/peak_usb/pcan_usb: add support of rxerr/txerr counters
Date:   Tue,  8 Oct 2019 10:35:45 +0200
Message-Id: <20191008083545.4569-3-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008083545.4569-1-s.grosjean@peak-system.com>
References: <20191008083545.4569-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds the support of the rx/tx errors CAN counters to the
driver of the PCAN-USB PC-CAN interface from PEAK-System GmbH.

The PCAN-USB is internally equipped with a SJA1000 -like CAN controller,
therefore it is capable of giving back the values of the rx/tx errors
counters, to provide more details and statistics to the linux-can layer.
Moreover, getting these values allows the driver to better tune
CAN_ERR_CRTL_TX_xxx and CAN_ERR_CRTL_RX_xxx bits in case of
the interface enters the CAN_STATE_ERROR_xxx state.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 175 ++++++++++++++++++++++--
 1 file changed, 160 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index d2539c95adb6..b0b722cb327c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -66,6 +66,10 @@ MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB adapter");
 #define PCAN_USB_ERROR_QOVR		0x40
 #define PCAN_USB_ERROR_TXQFULL		0x80
 
+#define PCAN_USB_ERROR_BUS		(PCAN_USB_ERROR_BUS_LIGHT | \
+					 PCAN_USB_ERROR_BUS_HEAVY | \
+					 PCAN_USB_ERROR_BUS_OFF)
+
 /* SJA1000 modes */
 #define SJA1000_MODE_NORMAL		0x00
 #define SJA1000_MODE_INIT		0x01
@@ -85,11 +89,31 @@ MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB adapter");
 #define PCAN_USB_REC_TS			4
 #define PCAN_USB_REC_BUSEVT		5
 
+/* CAN bus errors notifications */
+#define PCAN_USB_ERR_ECC		0x01
+#define PCAN_USB_ERR_RXERR		0x02
+#define PCAN_USB_ERR_TXERR		0x04
+#define PCAN_USB_ERR_RXERR_CNT		0x08
+#define PCAN_USB_ERR_TXERR_CNT		0x10
+
+/* SJA1000 ECC register */
+#define ECC_SEG				0x1f
+#define ECC_DIR				0x20
+#define ECC_ERR				6
+#define ECC_BIT				0x00
+#define ECC_FORM			0x40
+#define ECC_STUFF			0x80
+#define ECC_MASK			0xc0
+
+/* SJA1000 Bus Error Interrupt */
+#define IRQ_BEI				0x80
+
 /* private to PCAN-USB adapter */
 struct pcan_usb {
 	struct peak_usb_device dev;
 	struct peak_time_ref time_ref;
 	struct timer_list restart_timer;
+	struct can_berr_counter bec;
 };
 
 /* incoming message context for decoding */
@@ -193,6 +217,16 @@ static int pcan_usb_set_silent(struct peak_usb_device *dev, u8 onoff)
 	return pcan_usb_send_cmd(dev, 3, 3, args);
 }
 
+/* send the cmd to be notified from bus errors */
+static int pcan_usb_set_err_frame(struct peak_usb_device *dev, u8 err_mask)
+{
+	u8 args[PCAN_USB_CMD_ARGS_LEN] = {
+		[0] = err_mask,
+	};
+
+	return pcan_usb_send_cmd(dev, 11, 2, args);
+}
+
 static int pcan_usb_set_ext_vcc(struct peak_usb_device *dev, u8 onoff)
 {
 	u8 args[PCAN_USB_CMD_ARGS_LEN] = {
@@ -426,7 +460,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 			new_state = CAN_STATE_BUS_OFF;
 			break;
 		}
-		if (n & (PCAN_USB_ERROR_RXQOVR | PCAN_USB_ERROR_QOVR)) {
+		if (n & ~PCAN_USB_ERROR_BUS) {
 			/*
 			 * trick to bypass next comparison and process other
 			 * errors
@@ -450,7 +484,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 			new_state = CAN_STATE_ERROR_WARNING;
 			break;
 		}
-		if (n & (PCAN_USB_ERROR_RXQOVR | PCAN_USB_ERROR_QOVR)) {
+		if (n & ~PCAN_USB_ERROR_BUS) {
 			/*
 			 * trick to bypass next comparison and process other
 			 * errors
@@ -489,15 +523,23 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 
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
 
@@ -508,10 +550,19 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 
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
@@ -533,6 +584,74 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 	return 0;
 }
 
+static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 ir,
+				   u8 status_len)
+{
+	struct pcan_usb *pdev = mc->pdev;
+
+	/* process bus error interrupt */
+	if (ir & IRQ_BEI) {
+		struct net_device_stats *stats = &mc->netdev->stats;
+		struct sk_buff *skb;
+		struct can_frame *cf;
+		u8 ecc = mc->ptr[0];
+
+		/* save rx/tx error counters from data bytes */
+		pdev->bec.rxerr = mc->ptr[1];
+		pdev->bec.txerr = mc->ptr[2];
+
+		/* allocate an skb to store the error frame */
+		skb = alloc_can_err_skb(mc->netdev, &cf);
+		if (!skb)
+			return -ENOMEM;
+
+		cf->data[6] = pdev->bec.txerr;
+		cf->data[7] = pdev->bec.rxerr;
+
+		/* The PCAN-USB is equipped with a SJA1000, thus copy from
+		 * sja1000.c how to handle the BEI:
+		 */
+		pdev->dev.can.can_stats.bus_error++;
+		stats->rx_errors++;
+
+		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+
+		/* set error type according to 1st data byte (ECC) */
+		switch (ecc & ECC_MASK) {
+		case ECC_BIT:
+			cf->data[2] |= CAN_ERR_PROT_BIT;
+			break;
+		case ECC_FORM:
+			cf->data[2] |= CAN_ERR_PROT_FORM;
+			break;
+		case ECC_STUFF:
+			cf->data[2] |= CAN_ERR_PROT_STUFF;
+			break;
+		default:
+			break;
+		}
+
+		/* set error location */
+		cf->data[3] = ecc & ECC_SEG;
+
+		/* Error occurred during transmission? */
+		if ((ecc & ECC_DIR) == 0)
+			cf->data[2] |= CAN_ERR_PROT_TX;
+		if (status_len & PCAN_USB_STATUSLEN_TIMESTAMP) {
+			struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
+
+			peak_usb_get_ts_time(&mc->pdev->time_ref, mc->ts16,
+					     &hwts->hwtstamp);
+		}
+
+		stats->rx_packets++;
+		stats->rx_bytes += cf->can_dlc;
+		netif_rx(skb);
+	}
+
+	return 0;
+}
+
 /*
  * decode non-data usb message
  */
@@ -587,9 +706,9 @@ static int pcan_usb_decode_status(struct pcan_usb_msg_context *mc,
 		break;
 
 	case PCAN_USB_REC_BUSEVT:
-		/* error frame/bus event */
-		if (n & PCAN_USB_ERROR_TXQFULL)
-			netdev_dbg(mc->netdev, "device Tx queue full)\n");
+		err = pcan_usb_handle_bus_evt(mc, n, status_len);
+		if (err)
+			return err;
 		break;
 	default:
 		netdev_err(mc->netdev, "unexpected function %u\n", f);
@@ -773,20 +892,45 @@ static int pcan_usb_encode_msg(struct peak_usb_device *dev, struct sk_buff *skb,
 	return 0;
 }
 
+/* socket callback used to copy berr counters values receieved through USB */
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
+	/* be notified on any error counter change */
+	err = pcan_usb_set_err_frame(dev, PCAN_USB_ERR_ECC |
+				     PCAN_USB_ERR_RXERR | PCAN_USB_ERR_TXERR |
+				     PCAN_USB_ERR_RXERR_CNT |
+				     PCAN_USB_ERR_TXERR_CNT);
+	if (err)
+		netdev_warn(dev->netdev,
+			    "CAN bus error counters not available (err %u)\n",
+			    err);
+
 	/* if revision greater than 3, can put silent mode on/off */
 	if (dev->device_rev > 3) {
-		int err;
-
 		err = pcan_usb_set_silent(dev,
 				dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY);
 		if (err)
@@ -906,4 +1050,5 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
 	.dev_restart_async = pcan_usb_restart_async,
+	.do_get_berr_counter = pcan_usb_get_berr_counter,
 };
-- 
2.20.1

