Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857152A9A78
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgKFRLU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:11:20 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:50317 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgKFRLU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:11:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id B0846FFC32
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 17:02:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eoCDpLFflaw2 for <linux-can@vger.kernel.org>;
        Fri,  6 Nov 2020 18:02:53 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 01/17] can: ems_usb: Fixed warnings given by checkpatch.pl and fixed some outdated comments
Date:   Fri,  6 Nov 2020 18:01:50 +0100
Message-Id: <20201106170206.32162-2-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 74 ++++++++++++++---------------------
 1 file changed, 30 insertions(+), 44 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 4f52810bebf8..c6ea82b01418 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*
- * CAN driver for EMS Dr. Thomas Wuensche CPC-USB/ARM7
+/* CAN driver for EMS Dr. Thomas Wuensche CPC-USB/ARM7
  *
- * Copyright (C) 2004-2009 EMS Dr. Thomas Wuensche
+ * Copyright (C) 2004-2020 EMS Dr. Thomas Wuensche
  */
 #include <linux/signal.h>
 #include <linux/slab.h>
@@ -15,6 +14,7 @@
 #include <linux/can/error.h>
 
 MODULE_AUTHOR("Sebastian Haas <haas@ems-wuensche.com>");
+MODULE_AUTHOR("Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>");
 MODULE_DESCRIPTION("CAN driver for EMS Dr. Thomas Wuensche CAN/USB interfaces");
 MODULE_LICENSE("GPL v2");
 
@@ -55,7 +55,7 @@ MODULE_LICENSE("GPL v2");
 #define CPC_CMD_TYPE_CLEAR_MSG_QUEUE 8  /* clear CPC_MSG queue */
 #define CPC_CMD_TYPE_CLEAR_CMD_QUEUE 28 /* clear CPC_CMD queue */
 
-#define CPC_CC_TYPE_SJA1000 2 /* Philips basic CAN controller */
+#define CPC_CC_TYPE_SJA1000 2 /* NXP CAN controller */
 
 #define CPC_CAN_ECODE_ERRFRAME 0x01 /* Ecode type */
 
@@ -64,8 +64,7 @@ MODULE_LICENSE("GPL v2");
 #define CPC_OVR_EVENT_CANSTATE  0x02
 #define CPC_OVR_EVENT_BUSERROR  0x04
 
-/*
- * If the CAN controller lost a message we indicate it with the highest bit
+/* If the CAN controller lost a message we indicate it with the highest bit
  * set in the count field.
  */
 #define CPC_OVR_HW 0x80
@@ -98,8 +97,7 @@ MODULE_LICENSE("GPL v2");
 
 #define SJA1000_DEFAULT_OUTPUT_CONTROL 0xDA
 
-/*
- * The device actually uses a 16MHz clock to generate the CAN clock
+/* CPC-USB/ARM7 actually uses a 16MHz clock to generate the CAN clock
  * but it expects SJA1000 bit settings based on 8MHz (is internally
  * converted).
  */
@@ -108,8 +106,7 @@ MODULE_LICENSE("GPL v2");
 #define CPC_TX_QUEUE_TRIGGER_LOW	25
 #define CPC_TX_QUEUE_TRIGGER_HIGH	35
 
-/*
- * CAN-Message representation in a CPC_MSG. Message object type is
+/* CAN-Message representation in a CPC_MSG. Message object type is
  * CPC_MSG_TYPE_CAN_FRAME or CPC_MSG_TYPE_RTR_FRAME or
  * CPC_MSG_TYPE_EXT_CAN_FRAME or CPC_MSG_TYPE_EXT_RTR_FRAME.
  */
@@ -139,7 +136,6 @@ struct cpc_sja1000_params {
 struct cpc_can_params {
 	u8 cc_type;
 
-	/* Will support M16C CAN controller in the future */
 	union {
 		struct cpc_sja1000_params sja1000;
 	} cc_params;
@@ -177,8 +173,7 @@ struct cpc_can_error {
 	} cc;
 };
 
-/*
- * Structure containing RX/TX error counter. This structure is used to request
+/* Structure containing RX/TX error counter. This structure is used to request
  * the values of the CAN controllers TX and RX error counter.
  */
 struct cpc_can_err_counter {
@@ -206,8 +201,7 @@ struct __packed ems_cpc_msg {
 	} msg;
 };
 
-/*
- * Table of devices that work with this driver
+/* Table of devices that work with this driver
  * NOTE: This driver supports only CPC-USB/ARM7 (LPC2119) yet.
  */
 static struct usb_device_id ems_usb_table[] = {
@@ -302,7 +296,7 @@ static void ems_usb_rx_can_msg(struct ems_usb *dev, struct ems_cpc_msg *msg)
 	struct net_device_stats *stats = &dev->netdev->stats;
 
 	skb = alloc_can_skb(dev->netdev, &cf);
-	if (skb == NULL)
+	if (!skb)
 		return;
 
 	cf->can_id = le32_to_cpu(msg->msg.can_msg.id);
@@ -332,7 +326,7 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 	struct net_device_stats *stats = &dev->netdev->stats;
 
 	skb = alloc_can_err_skb(dev->netdev, &cf);
-	if (skb == NULL)
+	if (!skb)
 		return;
 
 	if (msg->type == CPC_MSG_TYPE_CAN_STATE) {
@@ -400,8 +394,7 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 	netif_rx(skb);
 }
 
-/*
- * callback for bulk IN urb
+/* Callback for bulk IN urb
  */
 static void ems_usb_read_bulk_callback(struct urb *urb)
 {
@@ -486,8 +479,7 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 			   "failed resubmitting read bulk urb: %d\n", retval);
 }
 
-/*
- * callback for bulk IN urb
+/* Callback for bulk IN urb
  */
 static void ems_usb_write_bulk_callback(struct urb *urb)
 {
@@ -495,15 +487,19 @@ static void ems_usb_write_bulk_callback(struct urb *urb)
 	struct ems_usb *dev;
 	struct net_device *netdev;
 
-	BUG_ON(!context);
-
-	dev = context->dev;
-	netdev = dev->netdev;
-
 	/* free up our allocated buffer */
 	usb_free_coherent(urb->dev, urb->transfer_buffer_length,
 			  urb->transfer_buffer, urb->transfer_dma);
 
+	if (!context) {
+		// Should definitely not happen
+		printk(KERN_ERR "%s with no context\n", __func__);
+		return;
+	}
+
+	dev = context->dev;
+	netdev = dev->netdev;
+
 	atomic_dec(&dev->active_tx_urbs);
 
 	if (!netif_device_present(netdev))
@@ -522,11 +518,9 @@ static void ems_usb_write_bulk_callback(struct urb *urb)
 
 	/* Release context */
 	context->echo_index = MAX_TX_URBS;
-
 }
 
-/*
- * Send the given CPC command synchronously
+/* Send the given CPC command synchronously
  */
 static int ems_usb_command_msg(struct ems_usb *dev, struct ems_cpc_msg *msg)
 {
@@ -545,8 +539,7 @@ static int ems_usb_command_msg(struct ems_usb *dev, struct ems_cpc_msg *msg)
 			    &actual_length, 1000);
 }
 
-/*
- * Change CAN controllers' mode register
+/* Change CAN controllers' mode register
  */
 static int ems_usb_write_mode(struct ems_usb *dev, u8 mode)
 {
@@ -555,8 +548,7 @@ static int ems_usb_write_mode(struct ems_usb *dev, u8 mode)
 	return ems_usb_command_msg(dev, &dev->active_params);
 }
 
-/*
- * Send a CPC_Control command to change behaviour when interface receives a CAN
+/* Send a CPC_Control command to change behaviour when interface receives a CAN
  * message, bus error or CAN state changed notifications.
  */
 static int ems_usb_control_cmd(struct ems_usb *dev, u8 val)
@@ -573,8 +565,7 @@ static int ems_usb_control_cmd(struct ems_usb *dev, u8 val)
 	return ems_usb_command_msg(dev, &cmd);
 }
 
-/*
- * Start interface
+/* Start interface
  */
 static int ems_usb_start(struct ems_usb *dev)
 {
@@ -718,7 +709,6 @@ static int ems_usb_open(struct net_device *netdev)
 		return err;
 	}
 
-
 	netif_start_queue(netdev);
 
 	return 0;
@@ -779,8 +769,7 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 		}
 	}
 
-	/*
-	 * May never happen! When this happens we'd more URBs in flight as
+	/* May never happen! When this happens we'd more URBs in flight as
 	 * allowed (MAX_TX_URBS).
 	 */
 	if (!context) {
@@ -832,8 +821,7 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 		}
 	}
 
-	/*
-	 * Release our reference to this URB, the USB core will eventually free
+	/* Release our reference to this URB, the USB core will eventually free
 	 * it entirely.
 	 */
 	usb_free_urb(urb);
@@ -954,8 +942,7 @@ static void init_params_sja1000(struct ems_cpc_msg *msg)
 	sja1000->mode = SJA1000_MOD_RM;
 }
 
-/*
- * probe function for new CPC-USB devices
+/* probe function for new CPC-USB devices
  */
 static int ems_usb_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
@@ -1042,8 +1029,7 @@ static int ems_usb_probe(struct usb_interface *intf,
 	return err;
 }
 
-/*
- * called by the usb core when the device is removed from the system
+/* Called by the usb core when the device is removed from the system
  */
 static void ems_usb_disconnect(struct usb_interface *intf)
 {
-- 
2.26.2

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
