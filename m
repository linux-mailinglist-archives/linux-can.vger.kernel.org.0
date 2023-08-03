Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8499176E2BB
	for <lists+linux-can@lfdr.de>; Thu,  3 Aug 2023 10:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjHCIQR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 3 Aug 2023 04:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjHCIP4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 3 Aug 2023 04:15:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DFC5FF6
        for <linux-can@vger.kernel.org>; Thu,  3 Aug 2023 01:08:40 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qRTNu-0000Xo-CX
        for linux-can@vger.kernel.org; Thu, 03 Aug 2023 10:08:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D872720227F
        for <linux-can@vger.kernel.org>; Thu,  3 Aug 2023 08:08:36 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 0426C202246;
        Thu,  3 Aug 2023 08:08:34 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ace6ca82;
        Thu, 3 Aug 2023 08:08:32 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Frank Jungclaus <frank.jungclaus@esd.eu>,
        Simon Horman <horms@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 9/9] can: esd_usb: Add support for esd CAN-USB/3
Date:   Thu,  3 Aug 2023 10:08:30 +0200
Message-Id: <20230803080830.1386442-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803080830.1386442-1-mkl@pengutronix.de>
References: <20230803080830.1386442-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Frank Jungclaus <frank.jungclaus@esd.eu>

Add support for esd CAN-USB/3 and CAN FD to esd_usb.c.

Signed-off-by: Frank Jungclaus <frank.jungclaus@esd.eu>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/all/20230728150857.2374886-2-frank.jungclaus@esd.eu
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 275 ++++++++++++++++++++++++++++++----
 1 file changed, 244 insertions(+), 31 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 6201637ac0ff..41a0e4261d15 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * CAN driver for esd electronics gmbh CAN-USB/2 and CAN-USB/Micro
+ * CAN driver for esd electronics gmbh CAN-USB/2, CAN-USB/3 and CAN-USB/Micro
  *
  * Copyright (C) 2010-2012 esd electronic system design gmbh, Matthias Fuchs <socketcan@esd.eu>
  * Copyright (C) 2022-2023 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
@@ -19,17 +19,19 @@
 
 MODULE_AUTHOR("Matthias Fuchs <socketcan@esd.eu>");
 MODULE_AUTHOR("Frank Jungclaus <frank.jungclaus@esd.eu>");
-MODULE_DESCRIPTION("CAN driver for esd electronics gmbh CAN-USB/2 and CAN-USB/Micro interfaces");
+MODULE_DESCRIPTION("CAN driver for esd electronics gmbh CAN-USB/2, CAN-USB/3 and CAN-USB/Micro interfaces");
 MODULE_LICENSE("GPL v2");
 
 /* USB vendor and product ID */
 #define ESD_USB_ESDGMBH_VENDOR_ID	0x0ab4
 #define ESD_USB_CANUSB2_PRODUCT_ID	0x0010
 #define ESD_USB_CANUSBM_PRODUCT_ID	0x0011
+#define ESD_USB_CANUSB3_PRODUCT_ID	0x0014
 
 /* CAN controller clock frequencies */
 #define ESD_USB_2_CAN_CLOCK	(60 * MEGA) /* Hz */
 #define ESD_USB_M_CAN_CLOCK	(36 * MEGA) /* Hz */
+#define ESD_USB_3_CAN_CLOCK	(80 * MEGA) /* Hz */
 
 /* Maximum number of CAN nets */
 #define ESD_USB_MAX_NETS	2
@@ -44,6 +46,9 @@ MODULE_LICENSE("GPL v2");
 
 /* esd CAN message flags - dlc field */
 #define ESD_USB_RTR	BIT(4)
+#define ESD_USB_NO_BRS	BIT(4)
+#define ESD_USB_ESI	BIT(5)
+#define ESD_USB_FD	BIT(7)
 
 /* esd CAN message flags - id field */
 #define ESD_USB_EXTID	BIT(29)
@@ -65,6 +70,9 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_M_SJW_SHIFT	24
 #define ESD_USB_TRIPLE_SAMPLES	BIT(23)
 
+/* Transmitter Delay Compensation */
+#define ESD_USB_3_TDC_MODE_AUTO	0
+
 /* esd IDADD message */
 #define ESD_USB_ID_ENABLE	BIT(7)
 #define ESD_USB_MAX_ID_SEGMENT	64
@@ -88,6 +96,21 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_MAX_RX_URBS		4
 #define ESD_USB_MAX_TX_URBS		16 /* must be power of 2 */
 
+/* Modes for CAN-USB/3, to be used for esd_usb_3_set_baudrate_msg_x.mode */
+#define ESD_USB_3_BAUDRATE_MODE_DISABLE		0 /* remove from bus */
+#define ESD_USB_3_BAUDRATE_MODE_INDEX		1 /* ESD (CiA) bit rate idx */
+#define ESD_USB_3_BAUDRATE_MODE_BTR_CTRL	2 /* BTR values (controller)*/
+#define ESD_USB_3_BAUDRATE_MODE_BTR_CANONICAL	3 /* BTR values (canonical) */
+#define ESD_USB_3_BAUDRATE_MODE_NUM		4 /* numerical bit rate */
+#define ESD_USB_3_BAUDRATE_MODE_AUTOBAUD	5 /* autobaud */
+
+/* Flags for CAN-USB/3, to be used for esd_usb_3_set_baudrate_msg_x.flags */
+#define ESD_USB_3_BAUDRATE_FLAG_FD	BIT(0) /* enable CAN FD mode */
+#define ESD_USB_3_BAUDRATE_FLAG_LOM	BIT(1) /* enable listen only mode */
+#define ESD_USB_3_BAUDRATE_FLAG_STM	BIT(2) /* enable self test mode */
+#define ESD_USB_3_BAUDRATE_FLAG_TRS	BIT(3) /* enable triple sampling */
+#define ESD_USB_3_BAUDRATE_FLAG_TXP	BIT(4) /* enable transmit pause */
+
 struct esd_usb_header_msg {
 	u8 len; /* total message length in 32bit words */
 	u8 cmd;
@@ -122,6 +145,7 @@ struct esd_usb_rx_msg {
 	__le32 id; /* upper 3 bits contain flags */
 	union {
 		u8 data[CAN_MAX_DLEN];
+		u8 data_fd[CANFD_MAX_DLEN];
 		struct {
 			u8 status; /* CAN Controller Status */
 			u8 ecc;    /* Error Capture Register */
@@ -138,7 +162,10 @@ struct esd_usb_tx_msg {
 	u8 dlc;
 	u32 hnd;	/* opaque handle, not used by device */
 	__le32 id; /* upper 3 bits contain flags */
-	u8 data[CAN_MAX_DLEN];
+	union {
+		u8 data[CAN_MAX_DLEN];
+		u8 data_fd[CANFD_MAX_DLEN];
+	};
 };
 
 struct esd_usb_tx_done_msg {
@@ -166,6 +193,50 @@ struct esd_usb_set_baudrate_msg {
 	__le32 baud;
 };
 
+/* CAN-USB/3 baudrate configuration, used for nominal as well as for data bit rate */
+struct esd_usb_3_baudrate_cfg {
+	__le16 brp;	/* bit rate pre-scaler */
+	__le16 tseg1;	/* time segment before sample point */
+	__le16 tseg2;	/* time segment after sample point */
+	__le16 sjw;	/* synchronization jump Width */
+};
+
+/* In principle, the esd CAN-USB/3 supports Transmitter Delay Compensation (TDC),
+ * but currently only the automatic TDC mode is supported by this driver.
+ * An implementation for manual TDC configuration will follow.
+ *
+ * For information about struct esd_usb_3_tdc_cfg, see
+ * NTCAN Application Developers Manual, 6.2.25 NTCAN_TDC_CFG + related chapters
+ * https://esd.eu/fileadmin/esd/docs/manuals/NTCAN_Part1_Function_API_Manual_en_56.pdf
+ */
+struct esd_usb_3_tdc_cfg {
+	u8 tdc_mode;	/* transmitter delay compensation mode  */
+	u8 ssp_offset;	/* secondary sample point offset in mtq */
+	s8 ssp_shift;	/* secondary sample point shift in mtq */
+	u8 tdc_filter;	/* TDC filter in mtq */
+};
+
+/* Extended version of the above set_baudrate_msg for a CAN-USB/3
+ * to define the CAN bit timing configuration of the CAN controller in
+ * CAN FD mode as well as in Classical CAN mode.
+ *
+ * The payload of this command is a NTCAN_BAUDRATE_X structure according to
+ * esd electronics gmbh, NTCAN Application Developers Manual, 6.2.15 NTCAN_BAUDRATE_X
+ * https://esd.eu/fileadmin/esd/docs/manuals/NTCAN_Part1_Function_API_Manual_en_56.pdf
+ */
+struct esd_usb_3_set_baudrate_msg_x {
+	u8 len;	/* total message length in 32bit words */
+	u8 cmd;
+	u8 net;
+	u8 rsvd;	/*reserved */
+	/* Payload ... */
+	__le16 mode;	/* mode word, see ESD_USB_3_BAUDRATE_MODE_xxx */
+	__le16 flags;	/* control flags, see ESD_USB_3_BAUDRATE_FLAG_xxx */
+	struct esd_usb_3_tdc_cfg tdc;	/* TDC configuration */
+	struct esd_usb_3_baudrate_cfg nom;	/* nominal bit rate */
+	struct esd_usb_3_baudrate_cfg data;	/* data bit rate */
+};
+
 /* Main message type used between library and application */
 union __packed esd_usb_msg {
 	struct esd_usb_header_msg hdr;
@@ -175,12 +246,14 @@ union __packed esd_usb_msg {
 	struct esd_usb_tx_msg tx;
 	struct esd_usb_tx_done_msg txdone;
 	struct esd_usb_set_baudrate_msg setbaud;
+	struct esd_usb_3_set_baudrate_msg_x setbaud_x;
 	struct esd_usb_id_filter_msg filter;
 };
 
 static struct usb_device_id esd_usb_table[] = {
 	{USB_DEVICE(ESD_USB_ESDGMBH_VENDOR_ID, ESD_USB_CANUSB2_PRODUCT_ID)},
 	{USB_DEVICE(ESD_USB_ESDGMBH_VENDOR_ID, ESD_USB_CANUSBM_PRODUCT_ID)},
+	{USB_DEVICE(ESD_USB_ESDGMBH_VENDOR_ID, ESD_USB_CANUSB3_PRODUCT_ID)},
 	{}
 };
 MODULE_DEVICE_TABLE(usb, esd_usb_table);
@@ -321,9 +394,10 @@ static void esd_usb_rx_can_msg(struct esd_usb_net_priv *priv,
 {
 	struct net_device_stats *stats = &priv->netdev->stats;
 	struct can_frame *cf;
+	struct canfd_frame *cfd;
 	struct sk_buff *skb;
-	int i;
 	u32 id;
+	u8 len;
 
 	if (!netif_device_present(priv->netdev))
 		return;
@@ -333,27 +407,42 @@ static void esd_usb_rx_can_msg(struct esd_usb_net_priv *priv,
 	if (id & ESD_USB_EVENT) {
 		esd_usb_rx_event(priv, msg);
 	} else {
-		skb = alloc_can_skb(priv->netdev, &cf);
+		if (msg->rx.dlc & ESD_USB_FD) {
+			skb = alloc_canfd_skb(priv->netdev, &cfd);
+		} else {
+			skb = alloc_can_skb(priv->netdev, &cf);
+			cfd = (struct canfd_frame *)cf;
+		}
+
 		if (skb == NULL) {
 			stats->rx_dropped++;
 			return;
 		}
 
-		cf->can_id = id & ESD_USB_IDMASK;
-		can_frame_set_cc_len(cf, msg->rx.dlc & ~ESD_USB_RTR,
-				     priv->can.ctrlmode);
+		cfd->can_id = id & ESD_USB_IDMASK;
+
+		if (msg->rx.dlc & ESD_USB_FD) {
+			/* masking by 0x0F is already done within can_fd_dlc2len() */
+			cfd->len = can_fd_dlc2len(msg->rx.dlc);
+			len = cfd->len;
+			if ((msg->rx.dlc & ESD_USB_NO_BRS) == 0)
+				cfd->flags |= CANFD_BRS;
+			if (msg->rx.dlc & ESD_USB_ESI)
+				cfd->flags |= CANFD_ESI;
+		} else {
+			can_frame_set_cc_len(cf, msg->rx.dlc & ~ESD_USB_RTR, priv->can.ctrlmode);
+			len = cf->len;
+			if (msg->rx.dlc & ESD_USB_RTR) {
+				cf->can_id |= CAN_RTR_FLAG;
+				len = 0;
+			}
+		}
 
 		if (id & ESD_USB_EXTID)
-			cf->can_id |= CAN_EFF_FLAG;
+			cfd->can_id |= CAN_EFF_FLAG;
 
-		if (msg->rx.dlc & ESD_USB_RTR) {
-			cf->can_id |= CAN_RTR_FLAG;
-		} else {
-			for (i = 0; i < cf->len; i++)
-				cf->data[i] = msg->rx.data[i];
-
-			stats->rx_bytes += cf->len;
-		}
+		memcpy(cfd->data, msg->rx.data_fd, len);
+		stats->rx_bytes += len;
 		stats->rx_packets++;
 
 		netif_rx(skb);
@@ -728,7 +817,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	struct esd_usb *dev = priv->usb;
 	struct esd_tx_urb_context *context = NULL;
 	struct net_device_stats *stats = &netdev->stats;
-	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	union esd_usb_msg *msg;
 	struct urb *urb;
 	u8 *buf;
@@ -762,20 +851,29 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	msg->hdr.len = offsetof(struct esd_usb_tx_msg, data) / sizeof(u32);
 	msg->hdr.cmd = ESD_USB_CMD_CAN_TX;
 	msg->tx.net = priv->index;
-	msg->tx.dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
-	msg->tx.id = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
 
-	if (cf->can_id & CAN_RTR_FLAG)
-		msg->tx.dlc |= ESD_USB_RTR;
+	if (can_is_canfd_skb(skb)) {
+		msg->tx.dlc = can_fd_len2dlc(cfd->len);
+		msg->tx.dlc |= ESD_USB_FD;
 
-	if (cf->can_id & CAN_EFF_FLAG)
+		if ((cfd->flags & CANFD_BRS) == 0)
+			msg->tx.dlc |= ESD_USB_NO_BRS;
+	} else {
+		msg->tx.dlc = can_get_cc_dlc((struct can_frame *)cfd, priv->can.ctrlmode);
+
+		if (cfd->can_id & CAN_RTR_FLAG)
+			msg->tx.dlc |= ESD_USB_RTR;
+	}
+
+	msg->tx.id = cpu_to_le32(cfd->can_id & CAN_ERR_MASK);
+
+	if (cfd->can_id & CAN_EFF_FLAG)
 		msg->tx.id |= cpu_to_le32(ESD_USB_EXTID);
 
-	for (i = 0; i < cf->len; i++)
-		msg->tx.data[i] = cf->data[i];
+	memcpy(msg->tx.data_fd, cfd->data, cfd->len);
 
 	/* round up, then divide by 4 to add the payload length as # of 32bit words */
-	msg->hdr.len += DIV_ROUND_UP(cf->len, sizeof(u32));
+	msg->hdr.len += DIV_ROUND_UP(cfd->len, sizeof(u32));
 
 	for (i = 0; i < ESD_USB_MAX_TX_URBS; i++) {
 		if (priv->tx_contexts[i].echo_index == ESD_USB_MAX_TX_URBS) {
@@ -962,6 +1060,105 @@ static int esd_usb_2_set_bittiming(struct net_device *netdev)
 	return err;
 }
 
+/* Nominal bittiming constants, see
+ * Microchip SAM E70/S70/V70/V71, Data Sheet, Rev. G - 07/2022
+ * 48.6.8 MCAN Nominal Bit Timing and Prescaler Register
+ */
+static const struct can_bittiming_const esd_usb_3_nom_bittiming_const = {
+	.name = "esd_usb_3",
+	.tseg1_min = 2,
+	.tseg1_max = 256,
+	.tseg2_min = 2,
+	.tseg2_max = 128,
+	.sjw_max = 128,
+	.brp_min = 1,
+	.brp_max = 512,
+	.brp_inc = 1,
+};
+
+/* Data bittiming constants, see
+ * Microchip SAM E70/S70/V70/V71, Data Sheet, Rev. G - 07/2022
+ * 48.6.4 MCAN Data Bit Timing and Prescaler Register
+ */
+static const struct can_bittiming_const esd_usb_3_data_bittiming_const = {
+	.name = "esd_usb_3",
+	.tseg1_min = 2,
+	.tseg1_max = 32,
+	.tseg2_min = 1,
+	.tseg2_max = 16,
+	.sjw_max = 8,
+	.brp_min = 1,
+	.brp_max = 32,
+	.brp_inc = 1,
+};
+
+static int esd_usb_3_set_bittiming(struct net_device *netdev)
+{
+	const struct can_bittiming_const *nom_btc = &esd_usb_3_nom_bittiming_const;
+	const struct can_bittiming_const *data_btc = &esd_usb_3_data_bittiming_const;
+	struct esd_usb_net_priv *priv = netdev_priv(netdev);
+	struct can_bittiming *nom_bt = &priv->can.bittiming;
+	struct can_bittiming *data_bt = &priv->can.data_bittiming;
+	struct esd_usb_3_set_baudrate_msg_x *baud_x;
+	union esd_usb_msg *msg;
+	u16 flags = 0;
+	int err;
+
+	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	baud_x = &msg->setbaud_x;
+
+	/* Canonical is the most reasonable mode for SocketCAN on CAN-USB/3 ... */
+	baud_x->mode = cpu_to_le16(ESD_USB_3_BAUDRATE_MODE_BTR_CANONICAL);
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		flags |= ESD_USB_3_BAUDRATE_FLAG_LOM;
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		flags |= ESD_USB_3_BAUDRATE_FLAG_TRS;
+
+	baud_x->nom.brp = cpu_to_le16(nom_bt->brp & (nom_btc->brp_max - 1));
+	baud_x->nom.sjw = cpu_to_le16(nom_bt->sjw & (nom_btc->sjw_max - 1));
+	baud_x->nom.tseg1 = cpu_to_le16((nom_bt->prop_seg + nom_bt->phase_seg1)
+					& (nom_btc->tseg1_max - 1));
+	baud_x->nom.tseg2 = cpu_to_le16(nom_bt->phase_seg2 & (nom_btc->tseg2_max - 1));
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+		baud_x->data.brp = cpu_to_le16(data_bt->brp & (data_btc->brp_max - 1));
+		baud_x->data.sjw = cpu_to_le16(data_bt->sjw & (data_btc->sjw_max - 1));
+		baud_x->data.tseg1 = cpu_to_le16((data_bt->prop_seg + data_bt->phase_seg1)
+						 & (data_btc->tseg1_max - 1));
+		baud_x->data.tseg2 = cpu_to_le16(data_bt->phase_seg2 & (data_btc->tseg2_max - 1));
+		flags |= ESD_USB_3_BAUDRATE_FLAG_FD;
+	}
+
+	/* Currently this driver only supports the automatic TDC mode */
+	baud_x->tdc.tdc_mode = ESD_USB_3_TDC_MODE_AUTO;
+	baud_x->tdc.ssp_offset = 0;
+	baud_x->tdc.ssp_shift = 0;
+	baud_x->tdc.tdc_filter = 0;
+
+	baud_x->flags = cpu_to_le16(flags);
+	baud_x->net = priv->index;
+	baud_x->rsvd = 0;
+
+	/* set len as # of 32bit words */
+	msg->hdr.len = sizeof(struct esd_usb_3_set_baudrate_msg_x) / sizeof(u32);
+	msg->hdr.cmd = ESD_USB_CMD_SETBAUD;
+
+	netdev_dbg(netdev,
+		   "ctrlmode=%#x/%#x, esd-net=%u, esd-mode=%#x, esd-flags=%#x\n",
+		   priv->can.ctrlmode, priv->can.ctrlmode_supported,
+		   priv->index, le16_to_cpu(baud_x->mode), flags);
+
+	err = esd_usb_send_msg(priv->usb, msg);
+
+	kfree(msg);
+	return err;
+}
+
 static int esd_usb_get_berr_counter(const struct net_device *netdev,
 				    struct can_berr_counter *bec)
 {
@@ -1019,16 +1216,32 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 		CAN_CTRLMODE_CC_LEN8_DLC |
 		CAN_CTRLMODE_BERR_REPORTING;
 
-	if (le16_to_cpu(dev->udev->descriptor.idProduct) ==
-	    ESD_USB_CANUSBM_PRODUCT_ID)
+	switch (le16_to_cpu(dev->udev->descriptor.idProduct)) {
+	case ESD_USB_CANUSB3_PRODUCT_ID:
+		priv->can.clock.freq = ESD_USB_3_CAN_CLOCK;
+		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
+		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
+		priv->can.bittiming_const = &esd_usb_3_nom_bittiming_const;
+		priv->can.data_bittiming_const = &esd_usb_3_data_bittiming_const;
+		priv->can.do_set_bittiming = esd_usb_3_set_bittiming;
+		priv->can.do_set_data_bittiming = esd_usb_3_set_bittiming;
+		break;
+
+	case ESD_USB_CANUSBM_PRODUCT_ID:
 		priv->can.clock.freq = ESD_USB_M_CAN_CLOCK;
-	else {
+		priv->can.bittiming_const = &esd_usb_2_bittiming_const;
+		priv->can.do_set_bittiming = esd_usb_2_set_bittiming;
+		break;
+
+	case ESD_USB_CANUSB2_PRODUCT_ID:
+	default:
 		priv->can.clock.freq = ESD_USB_2_CAN_CLOCK;
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
+		priv->can.bittiming_const = &esd_usb_2_bittiming_const;
+		priv->can.do_set_bittiming = esd_usb_2_set_bittiming;
+		break;
 	}
 
-	priv->can.bittiming_const = &esd_usb_2_bittiming_const;
-	priv->can.do_set_bittiming = esd_usb_2_set_bittiming;
 	priv->can.do_set_mode = esd_usb_set_mode;
 	priv->can.do_get_berr_counter = esd_usb_get_berr_counter;
 
-- 
2.40.1


