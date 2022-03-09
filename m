Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592244D2F44
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 13:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiCIMmf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 07:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiCIMme (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 07:42:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541C21768F1
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 04:41:36 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRvdG-0002dA-PE
        for linux-can@vger.kernel.org; Wed, 09 Mar 2022 13:41:34 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 3752046B7D
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 12:41:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E81FC46B79;
        Wed,  9 Mar 2022 12:41:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id dcc11341;
        Wed, 9 Mar 2022 12:41:32 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 01/21] can: gs_usb: use consistent one space indention
Date:   Wed,  9 Mar 2022 13:41:12 +0100
Message-Id: <20220309124132.291861-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309124132.291861-1-mkl@pengutronix.de>
References: <20220309124132.291861-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
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

With this patch a consistent one space indention throughout the whole
driver is used.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 38 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index d35749fad1ef..a63650b17931 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -21,14 +21,14 @@
 #include <linux/can/error.h>
 
 /* Device specific constants */
-#define USB_GSUSB_1_VENDOR_ID      0x1d50
-#define USB_GSUSB_1_PRODUCT_ID     0x606f
+#define USB_GSUSB_1_VENDOR_ID 0x1d50
+#define USB_GSUSB_1_PRODUCT_ID 0x606f
 
-#define USB_CANDLELIGHT_VENDOR_ID  0x1209
+#define USB_CANDLELIGHT_VENDOR_ID 0x1209
 #define USB_CANDLELIGHT_PRODUCT_ID 0x2323
 
-#define GSUSB_ENDPOINT_IN          1
-#define GSUSB_ENDPOINT_OUT         2
+#define GSUSB_ENDPOINT_IN 1
+#define GSUSB_ENDPOINT_OUT 2
 
 /* Device specific constants */
 enum gs_usb_breq {
@@ -87,11 +87,11 @@ struct gs_device_config {
 	__le32 hw_version;
 } __packed;
 
-#define GS_CAN_MODE_NORMAL               0
-#define GS_CAN_MODE_LISTEN_ONLY          BIT(0)
-#define GS_CAN_MODE_LOOP_BACK            BIT(1)
-#define GS_CAN_MODE_TRIPLE_SAMPLE        BIT(2)
-#define GS_CAN_MODE_ONE_SHOT             BIT(3)
+#define GS_CAN_MODE_NORMAL 0
+#define GS_CAN_MODE_LISTEN_ONLY BIT(0)
+#define GS_CAN_MODE_LOOP_BACK BIT(1)
+#define GS_CAN_MODE_TRIPLE_SAMPLE BIT(2)
+#define GS_CAN_MODE_ONE_SHOT BIT(3)
 
 struct gs_device_mode {
 	__le32 mode;
@@ -116,12 +116,12 @@ struct gs_identify_mode {
 	__le32 mode;
 } __packed;
 
-#define GS_CAN_FEATURE_LISTEN_ONLY      BIT(0)
-#define GS_CAN_FEATURE_LOOP_BACK        BIT(1)
-#define GS_CAN_FEATURE_TRIPLE_SAMPLE    BIT(2)
-#define GS_CAN_FEATURE_ONE_SHOT         BIT(3)
-#define GS_CAN_FEATURE_HW_TIMESTAMP     BIT(4)
-#define GS_CAN_FEATURE_IDENTIFY         BIT(5)
+#define GS_CAN_FEATURE_LISTEN_ONLY BIT(0)
+#define GS_CAN_FEATURE_LOOP_BACK BIT(1)
+#define GS_CAN_FEATURE_TRIPLE_SAMPLE BIT(2)
+#define GS_CAN_FEATURE_ONE_SHOT BIT(3)
+#define GS_CAN_FEATURE_HW_TIMESTAMP BIT(4)
+#define GS_CAN_FEATURE_IDENTIFY BIT(5)
 
 struct gs_device_bt_const {
 	__le32 feature;
@@ -1043,10 +1043,10 @@ static const struct usb_device_id gs_usb_table[] = {
 MODULE_DEVICE_TABLE(usb, gs_usb_table);
 
 static struct usb_driver gs_usb_driver = {
-	.name       = "gs_usb",
-	.probe      = gs_usb_probe,
+	.name = "gs_usb",
+	.probe = gs_usb_probe,
 	.disconnect = gs_usb_disconnect,
-	.id_table   = gs_usb_table,
+	.id_table = gs_usb_table,
 };
 
 module_usb_driver(gs_usb_driver);

base-commit: d82a6c5ef9dc0aab296936e1aa4ad28fd5162a55
-- 
2.34.1


