Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7C3739989
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 10:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjFVI1b (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 04:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjFVI1V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 04:27:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235351FDF
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 01:27:07 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qCFej-0002S8-7U
        for linux-can@vger.kernel.org; Thu, 22 Jun 2023 10:27:05 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D76BA1DF36B
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:27:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4D0C11DF33E;
        Thu, 22 Jun 2023 08:27:01 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c6907d16;
        Thu, 22 Jun 2023 08:27:00 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/33] can: esd_usb: Replace initializer macros used for struct can_bittiming_const
Date:   Thu, 22 Jun 2023 10:26:29 +0200
Message-Id: <20230622082658.571150-5-mkl@pengutronix.de>
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

Replace the macros used to initialize the members of struct
can_bittiming_const with direct values. Then also use those struct
members to do the calculations in esd_usb2_set_bittiming().

Link: https://lore.kernel.org/all/CAMZ6RqLaDNy-fZ2G0+QMhUEckkXLL+ZyELVSDFmqpd++aBzZQg@mail.gmail.com/
Suggested-by: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Signed-off-by: Frank Jungclaus <frank.jungclaus@esd.eu>
Link: https://lore.kernel.org/r/20230519195600.420644-3-frank.jungclaus@esd.eu
[mkl: esd_usb2_set_bittiming() use esd_usb2_bittiming_const instead of priv->can.bittiming_const]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 93c2351d1e3c..310cae5c4648 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -60,18 +60,10 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_NO_BAUDRATE	GENMASK(30, 0) /* bit rate unconfigured */
 
 /* bit timing CAN-USB/2 */
-#define ESD_USB2_TSEG1_MIN	1
-#define ESD_USB2_TSEG1_MAX	16
 #define ESD_USB2_TSEG1_SHIFT	16
-#define ESD_USB2_TSEG2_MIN	1
-#define ESD_USB2_TSEG2_MAX	8
 #define ESD_USB2_TSEG2_SHIFT	20
-#define ESD_USB2_SJW_MAX	4
 #define ESD_USB2_SJW_SHIFT	14
 #define ESD_USBM_SJW_SHIFT	24
-#define ESD_USB2_BRP_MIN	1
-#define ESD_USB2_BRP_MAX	1024
-#define ESD_USB2_BRP_INC	1
 #define ESD_USB2_3_SAMPLES	BIT(23)
 
 /* esd IDADD message */
@@ -909,18 +901,19 @@ static const struct ethtool_ops esd_usb_ethtool_ops = {
 
 static const struct can_bittiming_const esd_usb2_bittiming_const = {
 	.name = "esd_usb2",
-	.tseg1_min = ESD_USB2_TSEG1_MIN,
-	.tseg1_max = ESD_USB2_TSEG1_MAX,
-	.tseg2_min = ESD_USB2_TSEG2_MIN,
-	.tseg2_max = ESD_USB2_TSEG2_MAX,
-	.sjw_max = ESD_USB2_SJW_MAX,
-	.brp_min = ESD_USB2_BRP_MIN,
-	.brp_max = ESD_USB2_BRP_MAX,
-	.brp_inc = ESD_USB2_BRP_INC,
+	.tseg1_min = 1,
+	.tseg1_max = 16,
+	.tseg2_min = 1,
+	.tseg2_max = 8,
+	.sjw_max = 4,
+	.brp_min = 1,
+	.brp_max = 1024,
+	.brp_inc = 1,
 };
 
 static int esd_usb2_set_bittiming(struct net_device *netdev)
 {
+	const struct can_bittiming_const *btc = &esd_usb2_bittiming_const;
 	struct esd_usb_net_priv *priv = netdev_priv(netdev);
 	struct can_bittiming *bt = &priv->can.bittiming;
 	union esd_usb_msg *msg;
@@ -932,7 +925,7 @@ static int esd_usb2_set_bittiming(struct net_device *netdev)
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		canbtr |= ESD_USB_LOM;
 
-	canbtr |= (bt->brp - 1) & (ESD_USB2_BRP_MAX - 1);
+	canbtr |= (bt->brp - 1) & (btc->brp_max - 1);
 
 	if (le16_to_cpu(priv->usb->udev->descriptor.idProduct) ==
 	    USB_CANUSBM_PRODUCT_ID)
@@ -940,12 +933,12 @@ static int esd_usb2_set_bittiming(struct net_device *netdev)
 	else
 		sjw_shift = ESD_USB2_SJW_SHIFT;
 
-	canbtr |= ((bt->sjw - 1) & (ESD_USB2_SJW_MAX - 1))
+	canbtr |= ((bt->sjw - 1) & (btc->sjw_max - 1))
 		<< sjw_shift;
 	canbtr |= ((bt->prop_seg + bt->phase_seg1 - 1)
-		   & (ESD_USB2_TSEG1_MAX - 1))
+		   & (btc->tseg1_max - 1))
 		<< ESD_USB2_TSEG1_SHIFT;
-	canbtr |= ((bt->phase_seg2 - 1) & (ESD_USB2_TSEG2_MAX - 1))
+	canbtr |= ((bt->phase_seg2 - 1) & (btc->tseg2_max - 1))
 		<< ESD_USB2_TSEG2_SHIFT;
 	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
 		canbtr |= ESD_USB2_3_SAMPLES;
-- 
2.40.1


