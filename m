Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F53738507
	for <lists+linux-can@lfdr.de>; Wed, 21 Jun 2023 15:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjFUN3c (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Jun 2023 09:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjFUN3b (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Jun 2023 09:29:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E441981
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 06:29:24 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qBxti-0006ZI-W3
        for linux-can@vger.kernel.org; Wed, 21 Jun 2023 15:29:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8C4F51DE8C2
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 13:29:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E9FC81DE865;
        Wed, 21 Jun 2023 13:29:16 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 186cb684;
        Wed, 21 Jun 2023 13:29:16 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/33] can: esd_usb: Replace hardcoded message length given to USB commands
Date:   Wed, 21 Jun 2023 15:28:48 +0200
Message-Id: <20230621132914.412546-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621132914.412546-1-mkl@pengutronix.de>
References: <20230621132914.412546-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Frank Jungclaus <frank.jungclaus@esd.eu>

Replace all hardcoded values supplied to the len element of
esd_usb_msg (and its siblings) by more readable expressions, based on
sizeof(), offsetof(), etc.
Also spend documentation / comments that the len element of esd_usb_msg
is in multiples of 32bit words and not in bytes.

Link: https://lore.kernel.org/all/CAMZ6RqLaDNy-fZ2G0+QMhUEckkXLL+ZyELVSDFmqpd++aBzZQg@mail.gmail.com/
Suggested-by: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Signed-off-by: Frank Jungclaus <frank.jungclaus@esd.eu>
Link: https://lore.kernel.org/r/20230519195600.420644-6-frank.jungclaus@esd.eu
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 40 ++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 842e4dd187d4..c10fa578a5b0 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -90,13 +90,13 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_MAX_TX_URBS		16 /* must be power of 2 */
 
 struct esd_usb_header_msg {
-	u8 len; /* len is always the total message length in 32bit words */
+	u8 len; /* total message length in 32bit words */
 	u8 cmd;
 	u8 rsvd[2];
 };
 
 struct esd_usb_version_msg {
-	u8 len;
+	u8 len; /* total message length in 32bit words */
 	u8 cmd;
 	u8 rsvd;
 	u8 flags;
@@ -104,7 +104,7 @@ struct esd_usb_version_msg {
 };
 
 struct esd_usb_version_reply_msg {
-	u8 len;
+	u8 len; /* total message length in 32bit words */
 	u8 cmd;
 	u8 nets;
 	u8 features;
@@ -115,7 +115,7 @@ struct esd_usb_version_reply_msg {
 };
 
 struct esd_usb_rx_msg {
-	u8 len;
+	u8 len; /* total message length in 32bit words */
 	u8 cmd;
 	u8 net;
 	u8 dlc;
@@ -133,7 +133,7 @@ struct esd_usb_rx_msg {
 };
 
 struct esd_usb_tx_msg {
-	u8 len;
+	u8 len; /* total message length in 32bit words */
 	u8 cmd;
 	u8 net;
 	u8 dlc;
@@ -143,7 +143,7 @@ struct esd_usb_tx_msg {
 };
 
 struct esd_usb_tx_done_msg {
-	u8 len;
+	u8 len; /* total message length in 32bit words */
 	u8 cmd;
 	u8 net;
 	u8 status;
@@ -152,15 +152,15 @@ struct esd_usb_tx_done_msg {
 };
 
 struct esd_usb_id_filter_msg {
-	u8 len;
+	u8 len; /* total message length in 32bit words */
 	u8 cmd;
 	u8 net;
 	u8 option;
-	__le32 mask[ESD_USB_MAX_ID_SEGMENT + 1];
+	__le32 mask[ESD_USB_MAX_ID_SEGMENT + 1]; /* +1 for 29bit extended IDs */
 };
 
 struct esd_usb_set_baudrate_msg {
-	u8 len;
+	u8 len; /* total message length in 32bit words */
 	u8 cmd;
 	u8 net;
 	u8 rsvd;
@@ -438,7 +438,7 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 			break;
 		}
 
-		pos += msg->hdr.len << 2;
+		pos += msg->hdr.len * sizeof(u32); /* convert to # of bytes */
 
 		if (pos > urb->actual_length) {
 			dev_err(dev->udev->dev.parent, "format error\n");
@@ -532,7 +532,7 @@ static int esd_usb_send_msg(struct esd_usb *dev, union esd_usb_msg *msg)
 	return usb_bulk_msg(dev->udev,
 			    usb_sndbulkpipe(dev->udev, 2),
 			    msg,
-			    msg->hdr.len << 2,
+			    msg->hdr.len * sizeof(u32), /* convert to # of bytes */
 			    &actual_length,
 			    1000);
 }
@@ -648,7 +648,7 @@ static int esd_usb_start(struct esd_usb_net_priv *priv)
 	 * field followed by only some bitmasks.
 	 */
 	msg->hdr.cmd = ESD_USB_CMD_IDADD;
-	msg->hdr.len = 2 + ESD_USB_MAX_ID_SEGMENT;
+	msg->hdr.len = sizeof(struct esd_usb_id_filter_msg) / sizeof(u32); /* # of 32bit words */
 	msg->filter.net = priv->index;
 	msg->filter.option = ESD_USB_ID_ENABLE; /* start with segment 0 */
 	for (i = 0; i < ESD_USB_MAX_ID_SEGMENT; i++)
@@ -759,7 +759,8 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 
 	msg = (union esd_usb_msg *)buf;
 
-	msg->hdr.len = 3; /* minimal length */
+	/* minimal length as # of 32bit words */
+	msg->hdr.len = offsetof(struct esd_usb_tx_msg, data) / sizeof(u32);
 	msg->hdr.cmd = ESD_USB_CMD_CAN_TX;
 	msg->tx.net = priv->index;
 	msg->tx.dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
@@ -774,7 +775,8 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	for (i = 0; i < cf->len; i++)
 		msg->tx.data[i] = cf->data[i];
 
-	msg->hdr.len += (cf->len + 3) >> 2;
+	/* round up, then divide by 4 to add the payload length as # of 32bit words */
+	msg->hdr.len += DIV_ROUND_UP(cf->len, sizeof(u32));
 
 	for (i = 0; i < ESD_USB_MAX_TX_URBS; i++) {
 		if (priv->tx_contexts[i].echo_index == ESD_USB_MAX_TX_URBS) {
@@ -797,7 +799,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	msg->tx.hnd = 0x80000000 | i; /* returned in TX done message */
 
 	usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 2), buf,
-			  msg->hdr.len << 2,
+			  msg->hdr.len * sizeof(u32), /* convert to # of bytes */
 			  esd_usb_write_bulk_callback, context);
 
 	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
@@ -860,7 +862,7 @@ static int esd_usb_close(struct net_device *netdev)
 
 	/* Disable all IDs (see esd_usb_start()) */
 	msg->hdr.cmd = ESD_USB_CMD_IDADD;
-	msg->hdr.len = 2 + ESD_USB_MAX_ID_SEGMENT;
+	msg->hdr.len = sizeof(struct esd_usb_id_filter_msg) / sizeof(u32);/* # of 32bit words */
 	msg->filter.net = priv->index;
 	msg->filter.option = ESD_USB_ID_ENABLE; /* start with segment 0 */
 	for (i = 0; i <= ESD_USB_MAX_ID_SEGMENT; i++)
@@ -869,7 +871,7 @@ static int esd_usb_close(struct net_device *netdev)
 		netdev_err(netdev, "sending idadd message failed\n");
 
 	/* set CAN controller to reset mode */
-	msg->hdr.len = 2;
+	msg->hdr.len = sizeof(struct esd_usb_set_baudrate_msg) / sizeof(u32); /* # of 32bit words */
 	msg->hdr.cmd = ESD_USB_CMD_SETBAUD;
 	msg->setbaud.net = priv->index;
 	msg->setbaud.rsvd = 0;
@@ -947,7 +949,7 @@ static int esd_usb_2_set_bittiming(struct net_device *netdev)
 	if (!msg)
 		return -ENOMEM;
 
-	msg->hdr.len = 2;
+	msg->hdr.len = sizeof(struct esd_usb_set_baudrate_msg) / sizeof(u32); /* # of 32bit words */
 	msg->hdr.cmd = ESD_USB_CMD_SETBAUD;
 	msg->setbaud.net = priv->index;
 	msg->setbaud.rsvd = 0;
@@ -1086,7 +1088,7 @@ static int esd_usb_probe(struct usb_interface *intf,
 
 	/* query number of CAN interfaces (nets) */
 	msg->hdr.cmd = ESD_USB_CMD_VERSION;
-	msg->hdr.len = 2;
+	msg->hdr.len = sizeof(struct esd_usb_version_msg) / sizeof(u32); /* # of 32bit words */
 	msg->version.rsvd = 0;
 	msg->version.flags = 0;
 	msg->version.drv_version = 0;
-- 
2.40.1


