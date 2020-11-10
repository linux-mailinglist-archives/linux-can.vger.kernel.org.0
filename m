Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2960B2ADAC9
	for <lists+linux-can@lfdr.de>; Tue, 10 Nov 2020 16:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbgKJPtS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Nov 2020 10:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbgKJPtR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Nov 2020 10:49:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A392CC0613CF
        for <linux-can@vger.kernel.org>; Tue, 10 Nov 2020 07:49:17 -0800 (PST)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kcVtT-0005w8-LT; Tue, 10 Nov 2020 16:49:15 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, mailhol.vincent@wanadoo.fr,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v7 2/2] can-dev: add len8_dlc support for various CAN USB adapters
Date:   Tue, 10 Nov 2020 16:49:13 +0100
Message-Id: <20201110154913.1404582-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110154913.1404582-1-mkl@pengutronix.de>
References: <20201110154913.1404582-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

Support the Classical CAN raw DLC functionality to send and receive DLC
values from 9 .. 15 on various Classical CAN capable USB network drivers:

- gs_usb
- pcan_usb
- pcan_usb_fd
- usb_8dev

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/r/20201110101852.1973-9-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c               |  7 ++++---
 drivers/net/can/usb/peak_usb/pcan_usb.c    |  8 +++++---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 19 +++++++++++++------
 drivers/net/can/usb/usb_8dev.c             |  9 +++++----
 4 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 940589667a7f..dc0b9f65bbe3 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -331,7 +331,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 		cf->can_id = hf->can_id;
 
-		cf->len = can_cc_dlc2len(hf->len);
+		can_frame_set_cc_len(cf, hf->len, dev->can.ctrlmode);
 		memcpy(cf->data, hf->data, 8);
 
 		/* ERROR frames tell us information about the controller */
@@ -504,7 +504,8 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	cf = (struct can_frame *)skb->data;
 
 	hf->can_id = cf->can_id;
-	hf->len = cf->len;
+	hf->len = can_get_cc_dlc(cf, dev->can.ctrlmode);
+
 	memcpy(hf->data, cf->data, cf->len);
 
 	usb_fill_bulk_urb(urb, dev->udev,
@@ -858,7 +859,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	dev->can.bittiming_const = &dev->bt_const;
 	dev->can.do_set_bittiming = gs_usb_set_bittiming;
 
-	dev->can.ctrlmode_supported = 0;
+	dev->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
 
 	if (bt_const->feature & GS_CAN_FEATURE_LISTEN_ONLY)
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index ec34f87cc02c..e6c1e5d33924 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -734,7 +734,7 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 		cf->can_id = le16_to_cpu(tmp16) >> 5;
 	}
 
-	cf->len = can_cc_dlc2len(rec_len);
+	can_frame_set_cc_len(cf, rec_len, mc->pdev->dev.can.ctrlmode);
 
 	/* Only first packet timestamp is a word */
 	if (pcan_usb_decode_ts(mc, !mc->rec_ts_idx))
@@ -838,7 +838,8 @@ static int pcan_usb_encode_msg(struct peak_usb_device *dev, struct sk_buff *skb,
 	pc = obuf + PCAN_USB_MSG_HEADER_LEN;
 
 	/* status/len byte */
-	*pc = cf->len;
+	*pc = can_get_cc_dlc(cf, dev->can.ctrlmode);
+
 	if (cf->can_id & CAN_RTR_FLAG)
 		*pc |= PCAN_USB_STATUSLEN_RTR;
 
@@ -992,7 +993,8 @@ const struct peak_usb_adapter pcan_usb = {
 	.device_id = PCAN_USB_PRODUCT_ID,
 	.ctrl_count = 1,
 	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-			      CAN_CTRLMODE_BERR_REPORTING,
+			      CAN_CTRLMODE_BERR_REPORTING |
+			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_USB_CRYSTAL_HZ / 2 ,
 	},
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 761e78d8e647..b050226adae5 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -499,7 +499,9 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
 		if (!skb)
 			return -ENOMEM;
 
-		cfd->len = can_cc_dlc2len(pucan_msg_get_dlc(rm));
+		can_frame_set_cc_len((struct can_frame *)cfd,
+				     pucan_msg_get_dlc(rm),
+				     dev->can.ctrlmode);
 	}
 
 	cfd->can_id = le32_to_cpu(rm->can_id);
@@ -767,7 +769,8 @@ static int pcan_usb_fd_encode_msg(struct peak_usb_device *dev,
 			tx_msg_flags |= PUCAN_MSG_ERROR_STATE_IND;
 	} else {
 		/* CAND 2.0 frames */
-		len = cfd->len;
+		len = can_get_cc_dlc((struct can_frame *)cfd,
+				     dev->can.ctrlmode);
 
 		if (cfd->can_id & CAN_RTR_FLAG)
 			tx_msg_flags |= PUCAN_MSG_RTR;
@@ -1036,7 +1039,8 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	.device_id = PCAN_USBFD_PRODUCT_ID,
 	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
-			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
+			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
+			CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1108,7 +1112,8 @@ const struct peak_usb_adapter pcan_usb_chip = {
 	.device_id = PCAN_USBCHIP_PRODUCT_ID,
 	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
-		CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
+		CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
+		CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1180,7 +1185,8 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 	.device_id = PCAN_USBPROFD_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
-			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
+			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
+			CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1252,7 +1258,8 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 	.device_id = PCAN_USBX6_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
-			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
+			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
+			CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index 6517aaeb4bc0..3587bfcee13d 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -470,7 +470,7 @@ static void usb_8dev_rx_can_msg(struct usb_8dev_priv *priv,
 			return;
 
 		cf->can_id = be32_to_cpu(msg->id);
-		cf->len = can_cc_dlc2len(msg->dlc & 0xF);
+		can_frame_set_cc_len(cf, msg->dlc & 0xF, priv->can.ctrlmode);
 
 		if (msg->flags & USB_8DEV_EXTID)
 			cf->can_id |= CAN_EFF_FLAG;
@@ -637,7 +637,7 @@ static netdev_tx_t usb_8dev_start_xmit(struct sk_buff *skb,
 		msg->flags |= USB_8DEV_EXTID;
 
 	msg->id = cpu_to_be32(cf->can_id & CAN_ERR_MASK);
-	msg->dlc = cf->len;
+	msg->dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
 	memcpy(msg->data, cf->data, cf->len);
 	msg->end = USB_8DEV_DATA_END;
 
@@ -927,8 +927,9 @@ static int usb_8dev_probe(struct usb_interface *intf,
 	priv->can.do_set_mode = usb_8dev_set_mode;
 	priv->can.do_get_berr_counter = usb_8dev_get_berr_counter;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
-				      CAN_CTRLMODE_LISTENONLY |
-				      CAN_CTRLMODE_ONE_SHOT;
+				       CAN_CTRLMODE_LISTENONLY |
+				       CAN_CTRLMODE_ONE_SHOT |
+				       CAN_CTRLMODE_CC_LEN8_DLC;
 
 	netdev->netdev_ops = &usb_8dev_netdev_ops;
 
-- 
2.28.0

