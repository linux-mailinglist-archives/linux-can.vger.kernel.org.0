Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946DD739985
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 10:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjFVI1e (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 04:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjFVI12 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 04:27:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F6F2688
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 01:27:09 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qCFek-0002Ue-OU
        for linux-can@vger.kernel.org; Thu, 22 Jun 2023 10:27:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 955941DF386
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:27:03 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 76EBC1DF342;
        Thu, 22 Jun 2023 08:27:01 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ef50824e;
        Thu, 22 Jun 2023 08:27:00 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 05/33] can: esd_usb: Use consistent prefixes for macros
Date:   Thu, 22 Jun 2023 10:26:30 +0200
Message-Id: <20230622082658.571150-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622082658.571150-1-mkl@pengutronix.de>
References: <20230622082658.571150-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Frank Jungclaus <frank.jungclaus@esd.eu>

Add the consistent prefix ESD_USB_ to all macros defined within
esd_usb.c.
For macros specific to esd CAN-USB/2 use ESD_USB_2_ as prefix.
For macros specific to esd CAN-USB/Micro use ESD_USB_M_ as prefix.
Change the macro ESD_USB_3_SAMPLES to ESD_USB_TRIPLE_SAMPLES to not
mix up with the prefix ESD_USB_3_ which will be introduced for the
CAN-USB/3 device.

Link: https://lore.kernel.org/all/CAMZ6RqLaDNy-fZ2G0+QMhUEckkXLL+ZyELVSDFmqpd++aBzZQg@mail.gmail.com/
Suggested-by: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Signed-off-by: Frank Jungclaus <frank.jungclaus@esd.eu>
Link: https://lore.kernel.org/r/20230519195600.420644-4-frank.jungclaus@esd.eu
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 198 +++++++++++++++++-----------------
 1 file changed, 99 insertions(+), 99 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 310cae5c4648..b7d5a82d602b 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -23,33 +23,33 @@ MODULE_DESCRIPTION("CAN driver for esd electronics gmbh CAN-USB/2 and CAN-USB/Mi
 MODULE_LICENSE("GPL v2");
 
 /* USB vendor and product ID */
-#define USB_ESDGMBH_VENDOR_ID	0x0ab4
-#define USB_CANUSB2_PRODUCT_ID	0x0010
-#define USB_CANUSBM_PRODUCT_ID	0x0011
+#define ESD_USB_ESDGMBH_VENDOR_ID	0x0ab4
+#define ESD_USB_CANUSB2_PRODUCT_ID	0x0010
+#define ESD_USB_CANUSBM_PRODUCT_ID	0x0011
 
 /* CAN controller clock frequencies */
-#define ESD_USB2_CAN_CLOCK	(60 * MEGA) /* Hz */
-#define ESD_USBM_CAN_CLOCK	(36 * MEGA) /* Hz */
+#define ESD_USB_2_CAN_CLOCK	(60 * MEGA) /* Hz */
+#define ESD_USB_M_CAN_CLOCK	(36 * MEGA) /* Hz */
 
 /* Maximum number of CAN nets */
 #define ESD_USB_MAX_NETS	2
 
 /* USB commands */
-#define CMD_VERSION		1 /* also used for VERSION_REPLY */
-#define CMD_CAN_RX		2 /* device to host only */
-#define CMD_CAN_TX		3 /* also used for TX_DONE */
-#define CMD_SETBAUD		4 /* also used for SETBAUD_REPLY */
-#define CMD_TS			5 /* also used for TS_REPLY */
-#define CMD_IDADD		6 /* also used for IDADD_REPLY */
+#define ESD_USB_CMD_VERSION		1 /* also used for VERSION_REPLY */
+#define ESD_USB_CMD_CAN_RX		2 /* device to host only */
+#define ESD_USB_CMD_CAN_TX		3 /* also used for TX_DONE */
+#define ESD_USB_CMD_SETBAUD		4 /* also used for SETBAUD_REPLY */
+#define ESD_USB_CMD_TS			5 /* also used for TS_REPLY */
+#define ESD_USB_CMD_IDADD		6 /* also used for IDADD_REPLY */
 
 /* esd CAN message flags - dlc field */
 #define ESD_RTR	BIT(4)
 
 
 /* esd CAN message flags - id field */
-#define ESD_EXTID	BIT(29)
-#define ESD_EVENT	BIT(30)
-#define ESD_IDMASK	GENMASK(28, 0)
+#define ESD_USB_EXTID	BIT(29)
+#define ESD_USB_EVENT	BIT(30)
+#define ESD_USB_IDMASK	GENMASK(28, 0)
 
 /* esd CAN event ids */
 #define ESD_EV_CAN_ERROR_EXT	2 /* CAN controller specific diagnostic data */
@@ -59,35 +59,35 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_UBR	BIT(31) /* User Bit Rate (controller BTR) in bits 0..27 */
 #define ESD_USB_NO_BAUDRATE	GENMASK(30, 0) /* bit rate unconfigured */
 
-/* bit timing CAN-USB/2 */
-#define ESD_USB2_TSEG1_SHIFT	16
-#define ESD_USB2_TSEG2_SHIFT	20
-#define ESD_USB2_SJW_SHIFT	14
-#define ESD_USBM_SJW_SHIFT	24
-#define ESD_USB2_3_SAMPLES	BIT(23)
+/* bit timing esd CAN-USB */
+#define ESD_USB_2_TSEG1_SHIFT	16
+#define ESD_USB_2_TSEG2_SHIFT	20
+#define ESD_USB_2_SJW_SHIFT	14
+#define ESD_USB_M_SJW_SHIFT	24
+#define ESD_USB_TRIPLE_SAMPLES	BIT(23)
 
 /* esd IDADD message */
-#define ESD_ID_ENABLE		0x80
-#define ESD_MAX_ID_SEGMENT	64
+#define ESD_USB_ID_ENABLE	0x80
+#define ESD_USB_MAX_ID_SEGMENT	64
 
 /* SJA1000 ECC register (emulated by usb firmware) */
-#define SJA1000_ECC_SEG		0x1F
-#define SJA1000_ECC_DIR		0x20
-#define SJA1000_ECC_ERR		0x06
-#define SJA1000_ECC_BIT		0x00
-#define SJA1000_ECC_FORM	0x40
-#define SJA1000_ECC_STUFF	0x80
-#define SJA1000_ECC_MASK	0xc0
+#define ESD_USB_SJA1000_ECC_SEG		0x1F
+#define ESD_USB_SJA1000_ECC_DIR		0x20
+#define ESD_USB_SJA1000_ECC_ERR		0x06
+#define ESD_USB_SJA1000_ECC_BIT		0x00
+#define ESD_USB_SJA1000_ECC_FORM	0x40
+#define ESD_USB_SJA1000_ECC_STUFF	0x80
+#define ESD_USB_SJA1000_ECC_MASK	0xc0
 
 /* esd bus state event codes */
-#define ESD_BUSSTATE_MASK	0xc0
-#define ESD_BUSSTATE_WARN	0x40
-#define ESD_BUSSTATE_ERRPASSIVE	0x80
-#define ESD_BUSSTATE_BUSOFF	0xc0
+#define ESD_USB_BUSSTATE_MASK	0xc0
+#define ESD_USB_BUSSTATE_WARN	0x40
+#define ESD_USB_BUSSTATE_ERRPASSIVE	0x80
+#define ESD_USB_BUSSTATE_BUSOFF	0xc0
 
-#define RX_BUFFER_SIZE		1024
-#define MAX_RX_URBS		4
-#define MAX_TX_URBS		16 /* must be power of 2 */
+#define ESD_USB_RX_BUFFER_SIZE		1024
+#define ESD_USB_MAX_RX_URBS		4
+#define ESD_USB_MAX_TX_URBS		16 /* must be power of 2 */
 
 struct header_msg {
 	u8 len; /* len is always the total message length in 32bit words */
@@ -156,7 +156,7 @@ struct id_filter_msg {
 	u8 cmd;
 	u8 net;
 	u8 option;
-	__le32 mask[ESD_MAX_ID_SEGMENT + 1];
+	__le32 mask[ESD_USB_MAX_ID_SEGMENT + 1];
 };
 
 struct set_baudrate_msg {
@@ -180,8 +180,8 @@ union __packed esd_usb_msg {
 };
 
 static struct usb_device_id esd_usb_table[] = {
-	{USB_DEVICE(USB_ESDGMBH_VENDOR_ID, USB_CANUSB2_PRODUCT_ID)},
-	{USB_DEVICE(USB_ESDGMBH_VENDOR_ID, USB_CANUSBM_PRODUCT_ID)},
+	{USB_DEVICE(ESD_USB_ESDGMBH_VENDOR_ID, ESD_USB_CANUSB2_PRODUCT_ID)},
+	{USB_DEVICE(ESD_USB_ESDGMBH_VENDOR_ID, ESD_USB_CANUSBM_PRODUCT_ID)},
 	{}
 };
 MODULE_DEVICE_TABLE(usb, esd_usb_table);
@@ -202,8 +202,8 @@ struct esd_usb {
 	int net_count;
 	u32 version;
 	int rxinitdone;
-	void *rxbuf[MAX_RX_URBS];
-	dma_addr_t rxbuf_dma[MAX_RX_URBS];
+	void *rxbuf[ESD_USB_MAX_RX_URBS];
+	dma_addr_t rxbuf_dma[ESD_USB_MAX_RX_URBS];
 };
 
 struct esd_usb_net_priv {
@@ -211,7 +211,7 @@ struct esd_usb_net_priv {
 
 	atomic_t active_tx_jobs;
 	struct usb_anchor tx_submitted;
-	struct esd_tx_urb_context tx_contexts[MAX_TX_URBS];
+	struct esd_tx_urb_context tx_contexts[ESD_USB_MAX_TX_URBS];
 
 	struct esd_usb *usb;
 	struct net_device *netdev;
@@ -226,7 +226,7 @@ static void esd_usb_rx_event(struct esd_usb_net_priv *priv,
 	struct net_device_stats *stats = &priv->netdev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
-	u32 id = le32_to_cpu(msg->rx.id) & ESD_IDMASK;
+	u32 id = le32_to_cpu(msg->rx.id) & ESD_USB_IDMASK;
 
 	if (id == ESD_EV_CAN_ERROR_EXT) {
 		u8 state = msg->rx.ev_can_err_ext.status;
@@ -255,15 +255,15 @@ static void esd_usb_rx_event(struct esd_usb_net_priv *priv,
 
 			priv->old_state = state;
 
-			switch (state & ESD_BUSSTATE_MASK) {
-			case ESD_BUSSTATE_BUSOFF:
+			switch (state & ESD_USB_BUSSTATE_MASK) {
+			case ESD_USB_BUSSTATE_BUSOFF:
 				new_state = CAN_STATE_BUS_OFF;
 				can_bus_off(priv->netdev);
 				break;
-			case ESD_BUSSTATE_WARN:
+			case ESD_USB_BUSSTATE_WARN:
 				new_state = CAN_STATE_ERROR_WARNING;
 				break;
-			case ESD_BUSSTATE_ERRPASSIVE:
+			case ESD_USB_BUSSTATE_ERRPASSIVE:
 				new_state = CAN_STATE_ERROR_PASSIVE;
 				break;
 			default:
@@ -285,14 +285,14 @@ static void esd_usb_rx_event(struct esd_usb_net_priv *priv,
 
 			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
-			switch (ecc & SJA1000_ECC_MASK) {
-			case SJA1000_ECC_BIT:
+			switch (ecc & ESD_USB_SJA1000_ECC_MASK) {
+			case ESD_USB_SJA1000_ECC_BIT:
 				cf->data[2] |= CAN_ERR_PROT_BIT;
 				break;
-			case SJA1000_ECC_FORM:
+			case ESD_USB_SJA1000_ECC_FORM:
 				cf->data[2] |= CAN_ERR_PROT_FORM;
 				break;
-			case SJA1000_ECC_STUFF:
+			case ESD_USB_SJA1000_ECC_STUFF:
 				cf->data[2] |= CAN_ERR_PROT_STUFF;
 				break;
 			default:
@@ -300,11 +300,11 @@ static void esd_usb_rx_event(struct esd_usb_net_priv *priv,
 			}
 
 			/* Error occurred during transmission? */
-			if (!(ecc & SJA1000_ECC_DIR))
+			if (!(ecc & ESD_USB_SJA1000_ECC_DIR))
 				cf->data[2] |= CAN_ERR_PROT_TX;
 
 			/* Bit stream position in CAN frame as the error was detected */
-			cf->data[3] = ecc & SJA1000_ECC_SEG;
+			cf->data[3] = ecc & ESD_USB_SJA1000_ECC_SEG;
 		}
 
 		if (skb) {
@@ -331,7 +331,7 @@ static void esd_usb_rx_can_msg(struct esd_usb_net_priv *priv,
 
 	id = le32_to_cpu(msg->rx.id);
 
-	if (id & ESD_EVENT) {
+	if (id & ESD_USB_EVENT) {
 		esd_usb_rx_event(priv, msg);
 	} else {
 		skb = alloc_can_skb(priv->netdev, &cf);
@@ -340,11 +340,11 @@ static void esd_usb_rx_can_msg(struct esd_usb_net_priv *priv,
 			return;
 		}
 
-		cf->can_id = id & ESD_IDMASK;
+		cf->can_id = id & ESD_USB_IDMASK;
 		can_frame_set_cc_len(cf, msg->rx.dlc & ~ESD_RTR,
 				     priv->can.ctrlmode);
 
-		if (id & ESD_EXTID)
+		if (id & ESD_USB_EXTID)
 			cf->can_id |= CAN_EFF_FLAG;
 
 		if (msg->rx.dlc & ESD_RTR) {
@@ -371,7 +371,7 @@ static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
 	if (!netif_device_present(netdev))
 		return;
 
-	context = &priv->tx_contexts[msg->txdone.hnd & (MAX_TX_URBS - 1)];
+	context = &priv->tx_contexts[msg->txdone.hnd & (ESD_USB_MAX_TX_URBS - 1)];
 
 	if (!msg->txdone.status) {
 		stats->tx_packets++;
@@ -383,7 +383,7 @@ static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
 	}
 
 	/* Release context */
-	context->echo_index = MAX_TX_URBS;
+	context->echo_index = ESD_USB_MAX_TX_URBS;
 	atomic_dec(&priv->active_tx_jobs);
 
 	netif_wake_queue(netdev);
@@ -418,7 +418,7 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 		msg = (union esd_usb_msg *)(urb->transfer_buffer + pos);
 
 		switch (msg->hdr.cmd) {
-		case CMD_CAN_RX:
+		case ESD_USB_CMD_CAN_RX:
 			if (msg->rx.net >= dev->net_count) {
 				dev_err(dev->udev->dev.parent, "format error\n");
 				break;
@@ -427,7 +427,7 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 			esd_usb_rx_can_msg(dev->nets[msg->rx.net], msg);
 			break;
 
-		case CMD_CAN_TX:
+		case ESD_USB_CMD_CAN_TX:
 			if (msg->txdone.net >= dev->net_count) {
 				dev_err(dev->udev->dev.parent, "format error\n");
 				break;
@@ -448,7 +448,7 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 
 resubmit_urb:
 	usb_fill_bulk_urb(urb, dev->udev, usb_rcvbulkpipe(dev->udev, 1),
-			  urb->transfer_buffer, RX_BUFFER_SIZE,
+			  urb->transfer_buffer, ESD_USB_RX_BUFFER_SIZE,
 			  esd_usb_read_bulk_callback, dev);
 
 	retval = usb_submit_urb(urb, GFP_ATOMIC);
@@ -557,7 +557,7 @@ static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
 	if (dev->rxinitdone)
 		return 0;
 
-	for (i = 0; i < MAX_RX_URBS; i++) {
+	for (i = 0; i < ESD_USB_MAX_RX_URBS; i++) {
 		struct urb *urb = NULL;
 		u8 *buf = NULL;
 		dma_addr_t buf_dma;
@@ -569,7 +569,7 @@ static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
 			break;
 		}
 
-		buf = usb_alloc_coherent(dev->udev, RX_BUFFER_SIZE, GFP_KERNEL,
+		buf = usb_alloc_coherent(dev->udev, ESD_USB_RX_BUFFER_SIZE, GFP_KERNEL,
 					 &buf_dma);
 		if (!buf) {
 			dev_warn(dev->udev->dev.parent,
@@ -582,7 +582,7 @@ static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
 
 		usb_fill_bulk_urb(urb, dev->udev,
 				  usb_rcvbulkpipe(dev->udev, 1),
-				  buf, RX_BUFFER_SIZE,
+				  buf, ESD_USB_RX_BUFFER_SIZE,
 				  esd_usb_read_bulk_callback, dev);
 		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 		usb_anchor_urb(urb, &dev->rx_submitted);
@@ -590,7 +590,7 @@ static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
 		err = usb_submit_urb(urb, GFP_KERNEL);
 		if (err) {
 			usb_unanchor_urb(urb);
-			usb_free_coherent(dev->udev, RX_BUFFER_SIZE, buf,
+			usb_free_coherent(dev->udev, ESD_USB_RX_BUFFER_SIZE, buf,
 					  urb->transfer_dma);
 			goto freeurb;
 		}
@@ -612,7 +612,7 @@ static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
 	}
 
 	/* Warn if we've couldn't transmit all the URBs */
-	if (i < MAX_RX_URBS) {
+	if (i < ESD_USB_MAX_RX_URBS) {
 		dev_warn(dev->udev->dev.parent,
 			 "rx performance may be slow\n");
 	}
@@ -647,14 +647,14 @@ static int esd_usb_start(struct esd_usb_net_priv *priv)
 	 * the number of the starting bitmask (0..64) to the filter.option
 	 * field followed by only some bitmasks.
 	 */
-	msg->hdr.cmd = CMD_IDADD;
-	msg->hdr.len = 2 + ESD_MAX_ID_SEGMENT;
+	msg->hdr.cmd = ESD_USB_CMD_IDADD;
+	msg->hdr.len = 2 + ESD_USB_MAX_ID_SEGMENT;
 	msg->filter.net = priv->index;
-	msg->filter.option = ESD_ID_ENABLE; /* start with segment 0 */
-	for (i = 0; i < ESD_MAX_ID_SEGMENT; i++)
+	msg->filter.option = ESD_USB_ID_ENABLE; /* start with segment 0 */
+	for (i = 0; i < ESD_USB_MAX_ID_SEGMENT; i++)
 		msg->filter.mask[i] = cpu_to_le32(0xffffffff);
 	/* enable 29bit extended IDs */
-	msg->filter.mask[ESD_MAX_ID_SEGMENT] = cpu_to_le32(0x00000001);
+	msg->filter.mask[ESD_USB_MAX_ID_SEGMENT] = cpu_to_le32(0x00000001);
 
 	err = esd_usb_send_msg(dev, msg);
 	if (err)
@@ -683,8 +683,8 @@ static void unlink_all_urbs(struct esd_usb *dev)
 
 	usb_kill_anchored_urbs(&dev->rx_submitted);
 
-	for (i = 0; i < MAX_RX_URBS; ++i)
-		usb_free_coherent(dev->udev, RX_BUFFER_SIZE,
+	for (i = 0; i < ESD_USB_MAX_RX_URBS; ++i)
+		usb_free_coherent(dev->udev, ESD_USB_RX_BUFFER_SIZE,
 				  dev->rxbuf[i], dev->rxbuf_dma[i]);
 
 	for (i = 0; i < dev->net_count; i++) {
@@ -693,8 +693,8 @@ static void unlink_all_urbs(struct esd_usb *dev)
 			usb_kill_anchored_urbs(&priv->tx_submitted);
 			atomic_set(&priv->active_tx_jobs, 0);
 
-			for (j = 0; j < MAX_TX_URBS; j++)
-				priv->tx_contexts[j].echo_index = MAX_TX_URBS;
+			for (j = 0; j < ESD_USB_MAX_TX_URBS; j++)
+				priv->tx_contexts[j].echo_index = ESD_USB_MAX_TX_URBS;
 		}
 	}
 }
@@ -760,7 +760,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	msg = (union esd_usb_msg *)buf;
 
 	msg->hdr.len = 3; /* minimal length */
-	msg->hdr.cmd = CMD_CAN_TX;
+	msg->hdr.cmd = ESD_USB_CMD_CAN_TX;
 	msg->tx.net = priv->index;
 	msg->tx.dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
 	msg->tx.id = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
@@ -769,15 +769,15 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 		msg->tx.dlc |= ESD_RTR;
 
 	if (cf->can_id & CAN_EFF_FLAG)
-		msg->tx.id |= cpu_to_le32(ESD_EXTID);
+		msg->tx.id |= cpu_to_le32(ESD_USB_EXTID);
 
 	for (i = 0; i < cf->len; i++)
 		msg->tx.data[i] = cf->data[i];
 
 	msg->hdr.len += (cf->len + 3) >> 2;
 
-	for (i = 0; i < MAX_TX_URBS; i++) {
-		if (priv->tx_contexts[i].echo_index == MAX_TX_URBS) {
+	for (i = 0; i < ESD_USB_MAX_TX_URBS; i++) {
+		if (priv->tx_contexts[i].echo_index == ESD_USB_MAX_TX_URBS) {
 			context = &priv->tx_contexts[i];
 			break;
 		}
@@ -809,7 +809,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	atomic_inc(&priv->active_tx_jobs);
 
 	/* Slow down tx path */
-	if (atomic_read(&priv->active_tx_jobs) >= MAX_TX_URBS)
+	if (atomic_read(&priv->active_tx_jobs) >= ESD_USB_MAX_TX_URBS)
 		netif_stop_queue(netdev);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
@@ -859,18 +859,18 @@ static int esd_usb_close(struct net_device *netdev)
 		return -ENOMEM;
 
 	/* Disable all IDs (see esd_usb_start()) */
-	msg->hdr.cmd = CMD_IDADD;
-	msg->hdr.len = 2 + ESD_MAX_ID_SEGMENT;
+	msg->hdr.cmd = ESD_USB_CMD_IDADD;
+	msg->hdr.len = 2 + ESD_USB_MAX_ID_SEGMENT;
 	msg->filter.net = priv->index;
-	msg->filter.option = ESD_ID_ENABLE; /* start with segment 0 */
-	for (i = 0; i <= ESD_MAX_ID_SEGMENT; i++)
+	msg->filter.option = ESD_USB_ID_ENABLE; /* start with segment 0 */
+	for (i = 0; i <= ESD_USB_MAX_ID_SEGMENT; i++)
 		msg->filter.mask[i] = 0;
 	if (esd_usb_send_msg(priv->usb, msg) < 0)
 		netdev_err(netdev, "sending idadd message failed\n");
 
 	/* set CAN controller to reset mode */
 	msg->hdr.len = 2;
-	msg->hdr.cmd = CMD_SETBAUD;
+	msg->hdr.cmd = ESD_USB_CMD_SETBAUD;
 	msg->setbaud.net = priv->index;
 	msg->setbaud.rsvd = 0;
 	msg->setbaud.baud = cpu_to_le32(ESD_USB_NO_BAUDRATE);
@@ -928,27 +928,27 @@ static int esd_usb2_set_bittiming(struct net_device *netdev)
 	canbtr |= (bt->brp - 1) & (btc->brp_max - 1);
 
 	if (le16_to_cpu(priv->usb->udev->descriptor.idProduct) ==
-	    USB_CANUSBM_PRODUCT_ID)
-		sjw_shift = ESD_USBM_SJW_SHIFT;
+	    ESD_USB_CANUSBM_PRODUCT_ID)
+		sjw_shift = ESD_USB_M_SJW_SHIFT;
 	else
-		sjw_shift = ESD_USB2_SJW_SHIFT;
+		sjw_shift = ESD_USB_2_SJW_SHIFT;
 
 	canbtr |= ((bt->sjw - 1) & (btc->sjw_max - 1))
 		<< sjw_shift;
 	canbtr |= ((bt->prop_seg + bt->phase_seg1 - 1)
 		   & (btc->tseg1_max - 1))
-		<< ESD_USB2_TSEG1_SHIFT;
+		<< ESD_USB_2_TSEG1_SHIFT;
 	canbtr |= ((bt->phase_seg2 - 1) & (btc->tseg2_max - 1))
-		<< ESD_USB2_TSEG2_SHIFT;
+		<< ESD_USB_2_TSEG2_SHIFT;
 	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
-		canbtr |= ESD_USB2_3_SAMPLES;
+		canbtr |= ESD_USB_TRIPLE_SAMPLES;
 
 	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
 	msg->hdr.len = 2;
-	msg->hdr.cmd = CMD_SETBAUD;
+	msg->hdr.cmd = ESD_USB_CMD_SETBAUD;
 	msg->setbaud.net = priv->index;
 	msg->setbaud.rsvd = 0;
 	msg->setbaud.baud = cpu_to_le32(canbtr);
@@ -994,7 +994,7 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 	int err = 0;
 	int i;
 
-	netdev = alloc_candev(sizeof(*priv), MAX_TX_URBS);
+	netdev = alloc_candev(sizeof(*priv), ESD_USB_MAX_TX_URBS);
 	if (!netdev) {
 		dev_err(&intf->dev, "couldn't alloc candev\n");
 		err = -ENOMEM;
@@ -1006,8 +1006,8 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 	init_usb_anchor(&priv->tx_submitted);
 	atomic_set(&priv->active_tx_jobs, 0);
 
-	for (i = 0; i < MAX_TX_URBS; i++)
-		priv->tx_contexts[i].echo_index = MAX_TX_URBS;
+	for (i = 0; i < ESD_USB_MAX_TX_URBS; i++)
+		priv->tx_contexts[i].echo_index = ESD_USB_MAX_TX_URBS;
 
 	priv->usb = dev;
 	priv->netdev = netdev;
@@ -1019,10 +1019,10 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 		CAN_CTRLMODE_BERR_REPORTING;
 
 	if (le16_to_cpu(dev->udev->descriptor.idProduct) ==
-	    USB_CANUSBM_PRODUCT_ID)
-		priv->can.clock.freq = ESD_USBM_CAN_CLOCK;
+	    ESD_USB_CANUSBM_PRODUCT_ID)
+		priv->can.clock.freq = ESD_USB_M_CAN_CLOCK;
 	else {
-		priv->can.clock.freq = ESD_USB2_CAN_CLOCK;
+		priv->can.clock.freq = ESD_USB_2_CAN_CLOCK;
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 	}
 
@@ -1085,7 +1085,7 @@ static int esd_usb_probe(struct usb_interface *intf,
 	}
 
 	/* query number of CAN interfaces (nets) */
-	msg->hdr.cmd = CMD_VERSION;
+	msg->hdr.cmd = ESD_USB_CMD_VERSION;
 	msg->hdr.len = 2;
 	msg->version.rsvd = 0;
 	msg->version.flags = 0;
-- 
2.40.1


