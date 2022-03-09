Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D774D2F47
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiCIMmp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 07:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiCIMmn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 07:42:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3D41768FF
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 04:41:44 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRvdP-0002r8-5B
        for linux-can@vger.kernel.org; Wed, 09 Mar 2022 13:41:43 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id BEE4E46BEA
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 12:41:39 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5774B46BDA;
        Wed,  9 Mar 2022 12:41:39 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 743d7ca1;
        Wed, 9 Mar 2022 12:41:33 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Ben Evans <benny.j.evans92@gmail.com>,
        Peter Fink <pfink@christ-es.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 21/21] can: gs_usb: add VID/PID for ABE CAN Debugger devices
Date:   Wed,  9 Mar 2022 13:41:32 +0100
Message-Id: <20220309124132.291861-22-mkl@pengutronix.de>
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

From: Ben Evans <benny.j.evans92@gmail.com>

Add support for ABE CAN Debugger devices using the gs_usb driver.

Signed-off-by: Ben Evans <benny.j.evans92@gmail.com>
Signed-off-by: Peter Fink <pfink@christ-es.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 816b4d8b1182..67408e316062 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -31,6 +31,9 @@
 #define USB_CES_CANEXT_FD_VENDOR_ID 0x1cd2
 #define USB_CES_CANEXT_FD_PRODUCT_ID 0x606f
 
+#define USB_ABE_CANDEBUGGER_FD_VENDOR_ID 0x16d0
+#define USB_ABE_CANDEBUGGER_FD_PRODUCT_ID 0x10b8
+
 #define GSUSB_ENDPOINT_IN 1
 #define GSUSB_ENDPOINT_OUT 2
 
@@ -1238,6 +1241,8 @@ static const struct usb_device_id gs_usb_table[] = {
 				      USB_CANDLELIGHT_PRODUCT_ID, 0) },
 	{ USB_DEVICE_INTERFACE_NUMBER(USB_CES_CANEXT_FD_VENDOR_ID,
 				      USB_CES_CANEXT_FD_PRODUCT_ID, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(USB_ABE_CANDEBUGGER_FD_VENDOR_ID,
+				      USB_ABE_CANDEBUGGER_FD_PRODUCT_ID, 0) },
 	{} /* Terminating entry */
 };
 
-- 
2.34.1


