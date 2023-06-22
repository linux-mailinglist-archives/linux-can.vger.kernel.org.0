Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD872739986
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 10:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjFVI1a (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 04:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjFVI1U (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 04:27:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DBB1BE2
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 01:27:06 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qCFei-0002Ro-ST
        for linux-can@vger.kernel.org; Thu, 22 Jun 2023 10:27:04 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A41001DF364
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:27:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2E2EE1DF33C;
        Thu, 22 Jun 2023 08:27:01 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6bbbe0e7;
        Thu, 22 Jun 2023 08:27:00 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/33] can: esd_usb: Make use of existing kernel macros
Date:   Thu, 22 Jun 2023 10:26:28 +0200
Message-Id: <20230622082658.571150-4-mkl@pengutronix.de>
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

Make use of existing kernel macros:
- Use the unit suffixes from linux/units.h for the controller clock
frequencies
- Use the BIT() and the GENMASK() macro to set specific bits in some
  constants
- Use CAN_MAX_DLEN (instead of directly using the value 8) for the
maximum CAN payload length

Additionally:
- Spend some commenting for the previously changed constants
- Add the current year to the copyright notice
- While adding the header linux/units.h to the list of include files
also sort that list alphabetically

Suggested-by: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/CAMZ6RqLaDNy-fZ2G0+QMhUEckkXLL+ZyELVSDFmqpd++aBzZQg@mail.gmail.com/
Link: https://lore.kernel.org/all/CAMZ6RqKdg5YBufa0C+ttzJvoG=9yuti-8AmthCi4jBbd08JEtw@mail.gmail.com/
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://lore.kernel.org/all/20230518-grower-film-ea8b5f853f3e-mkl@pengutronix.de/
Signed-off-by: Frank Jungclaus <frank.jungclaus@esd.eu>
Link: https://lore.kernel.org/r/20230519195600.420644-2-frank.jungclaus@esd.eu
[mkl: remove hex constants in comments after BIT()]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 40 ++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index d33bac3a6c10..93c2351d1e3c 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -3,18 +3,19 @@
  * CAN driver for esd electronics gmbh CAN-USB/2 and CAN-USB/Micro
  *
  * Copyright (C) 2010-2012 esd electronic system design gmbh, Matthias Fuchs <socketcan@esd.eu>
- * Copyright (C) 2022 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
+ * Copyright (C) 2022-2023 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
  */
-#include <linux/ethtool.h>
-#include <linux/signal.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/netdevice.h>
-#include <linux/usb.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
+#include <linux/ethtool.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/signal.h>
+#include <linux/slab.h>
+#include <linux/units.h>
+#include <linux/usb.h>
 
 MODULE_AUTHOR("Matthias Fuchs <socketcan@esd.eu>");
 MODULE_AUTHOR("Frank Jungclaus <frank.jungclaus@esd.eu>");
@@ -27,8 +28,8 @@ MODULE_LICENSE("GPL v2");
 #define USB_CANUSBM_PRODUCT_ID	0x0011
 
 /* CAN controller clock frequencies */
-#define ESD_USB2_CAN_CLOCK	60000000
-#define ESD_USBM_CAN_CLOCK	36000000
+#define ESD_USB2_CAN_CLOCK	(60 * MEGA) /* Hz */
+#define ESD_USBM_CAN_CLOCK	(36 * MEGA) /* Hz */
 
 /* Maximum number of CAN nets */
 #define ESD_USB_MAX_NETS	2
@@ -42,20 +43,21 @@ MODULE_LICENSE("GPL v2");
 #define CMD_IDADD		6 /* also used for IDADD_REPLY */
 
 /* esd CAN message flags - dlc field */
-#define ESD_RTR			0x10
+#define ESD_RTR	BIT(4)
+
 
 /* esd CAN message flags - id field */
-#define ESD_EXTID		0x20000000
-#define ESD_EVENT		0x40000000
-#define ESD_IDMASK		0x1fffffff
+#define ESD_EXTID	BIT(29)
+#define ESD_EVENT	BIT(30)
+#define ESD_IDMASK	GENMASK(28, 0)
 
 /* esd CAN event ids */
 #define ESD_EV_CAN_ERROR_EXT	2 /* CAN controller specific diagnostic data */
 
 /* baudrate message flags */
-#define ESD_USB_UBR		0x80000000
-#define ESD_USB_LOM		0x40000000
-#define ESD_USB_NO_BAUDRATE	0x7fffffff
+#define ESD_USB_LOM	BIT(30) /* Listen Only Mode */
+#define ESD_USB_UBR	BIT(31) /* User Bit Rate (controller BTR) in bits 0..27 */
+#define ESD_USB_NO_BAUDRATE	GENMASK(30, 0) /* bit rate unconfigured */
 
 /* bit timing CAN-USB/2 */
 #define ESD_USB2_TSEG1_MIN	1
@@ -70,7 +72,7 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB2_BRP_MIN	1
 #define ESD_USB2_BRP_MAX	1024
 #define ESD_USB2_BRP_INC	1
-#define ESD_USB2_3_SAMPLES	0x00800000
+#define ESD_USB2_3_SAMPLES	BIT(23)
 
 /* esd IDADD message */
 #define ESD_ID_ENABLE		0x80
@@ -128,7 +130,7 @@ struct rx_msg {
 	__le32 ts;
 	__le32 id; /* upper 3 bits contain flags */
 	union {
-		u8 data[8];
+		u8 data[CAN_MAX_DLEN];
 		struct {
 			u8 status; /* CAN Controller Status */
 			u8 ecc;    /* Error Capture Register */
@@ -145,7 +147,7 @@ struct tx_msg {
 	u8 dlc;
 	u32 hnd;	/* opaque handle, not used by device */
 	__le32 id; /* upper 3 bits contain flags */
-	u8 data[8];
+	u8 data[CAN_MAX_DLEN];
 };
 
 struct tx_done_msg {
-- 
2.40.1


