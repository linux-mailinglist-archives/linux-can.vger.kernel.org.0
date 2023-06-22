Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6814773998E
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 10:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjFVI1g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 04:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjFVI1b (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 04:27:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668CF1FFC
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 01:27:11 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qCFen-0002YW-BZ
        for linux-can@vger.kernel.org; Thu, 22 Jun 2023 10:27:09 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6B0D71DF3AD
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:27:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 0827B1DF350;
        Thu, 22 Jun 2023 08:27:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id da398c40;
        Thu, 22 Jun 2023 08:27:00 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Frank Jungclaus <frank.jungclaus@esd.eu>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 09/33] can: esd_usb: Make use of kernel macros BIT() and GENMASK()
Date:   Thu, 22 Jun 2023 10:26:34 +0200
Message-Id: <20230622082658.571150-10-mkl@pengutronix.de>
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

Make use of kernel macros BIT() and GENMASK().

Signed-off-by: Frank Jungclaus <frank.jungclaus@esd.eu>
Link: https://lore.kernel.org/r/20230523173105.3175086-2-frank.jungclaus@esd.eu
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 1399b832ea3f..d40a04db7458 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -67,23 +67,23 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_TRIPLE_SAMPLES	BIT(23)
 
 /* esd IDADD message */
-#define ESD_USB_ID_ENABLE	0x80
+#define ESD_USB_ID_ENABLE	BIT(7)
 #define ESD_USB_MAX_ID_SEGMENT	64
 
 /* SJA1000 ECC register (emulated by usb firmware) */
-#define ESD_USB_SJA1000_ECC_SEG		0x1F
-#define ESD_USB_SJA1000_ECC_DIR		0x20
-#define ESD_USB_SJA1000_ECC_ERR		0x06
+#define ESD_USB_SJA1000_ECC_SEG		GENMASK(4, 0)
+#define ESD_USB_SJA1000_ECC_DIR		BIT(5)
+#define ESD_USB_SJA1000_ECC_ERR		BIT(2, 1)
 #define ESD_USB_SJA1000_ECC_BIT		0x00
-#define ESD_USB_SJA1000_ECC_FORM	0x40
-#define ESD_USB_SJA1000_ECC_STUFF	0x80
-#define ESD_USB_SJA1000_ECC_MASK	0xc0
+#define ESD_USB_SJA1000_ECC_FORM	BIT(6)
+#define ESD_USB_SJA1000_ECC_STUFF	BIT(7)
+#define ESD_USB_SJA1000_ECC_MASK	GENMASK(7, 6)
 
 /* esd bus state event codes */
-#define ESD_USB_BUSSTATE_MASK	0xc0
-#define ESD_USB_BUSSTATE_WARN	0x40
-#define ESD_USB_BUSSTATE_ERRPASSIVE	0x80
-#define ESD_USB_BUSSTATE_BUSOFF	0xc0
+#define ESD_USB_BUSSTATE_MASK	GENMASK(7, 6)
+#define ESD_USB_BUSSTATE_WARN	BIT(6)
+#define ESD_USB_BUSSTATE_ERRPASSIVE	BIT(7)
+#define ESD_USB_BUSSTATE_BUSOFF	GENMASK(7, 6)
 
 #define ESD_USB_RX_BUFFER_SIZE		1024
 #define ESD_USB_MAX_RX_URBS		4
@@ -652,9 +652,9 @@ static int esd_usb_start(struct esd_usb_net_priv *priv)
 	msg->filter.net = priv->index;
 	msg->filter.option = ESD_USB_ID_ENABLE; /* start with segment 0 */
 	for (i = 0; i < ESD_USB_MAX_ID_SEGMENT; i++)
-		msg->filter.mask[i] = cpu_to_le32(0xffffffff);
+		msg->filter.mask[i] = cpu_to_le32(GENMASK(31, 0));
 	/* enable 29bit extended IDs */
-	msg->filter.mask[ESD_USB_MAX_ID_SEGMENT] = cpu_to_le32(0x00000001);
+	msg->filter.mask[ESD_USB_MAX_ID_SEGMENT] = cpu_to_le32(BIT(0));
 
 	err = esd_usb_send_msg(dev, msg);
 	if (err)
@@ -796,7 +796,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	context->echo_index = i;
 
 	/* hnd must not be 0 - MSB is stripped in txdone handling */
-	msg->tx.hnd = 0x80000000 | i; /* returned in TX done message */
+	msg->tx.hnd = BIT(31) | i; /* returned in TX done message */
 
 	usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 2), buf,
 			  msg->hdr.len * sizeof(u32), /* convert to # of bytes */
-- 
2.40.1


