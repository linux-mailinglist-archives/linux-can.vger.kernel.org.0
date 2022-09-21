Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F6F5E53E7
	for <lists+linux-can@lfdr.de>; Wed, 21 Sep 2022 21:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIUTjf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Sep 2022 15:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIUTjX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Sep 2022 15:39:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9D0A1D7A
        for <linux-can@vger.kernel.org>; Wed, 21 Sep 2022 12:39:23 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ob5Z3-000204-Js
        for linux-can@vger.kernel.org; Wed, 21 Sep 2022 21:39:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 07A84E8DC5
        for <linux-can@vger.kernel.org>; Wed, 21 Sep 2022 19:39:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D4FD9E8DBF;
        Wed, 21 Sep 2022 19:39:12 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9a478666;
        Wed, 21 Sep 2022 19:39:02 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/3] can: gs_usb: gs_cmd_reset(): rename variable holding struct gs_can pointer to dev
Date:   Wed, 21 Sep 2022 21:39:00 +0200
Message-Id: <20220921193902.575416-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921193902.575416-1-mkl@pengutronix.de>
References: <20220921193902.575416-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Most of the driver uses the variable "dev" to point to the struct
gs_can. Use the same name in gs_cmd_reset(), too. Rename gsdev to dev.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 6b7ced4bff3d..bf0a1da27f76 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -358,10 +358,10 @@ static struct gs_tx_context *gs_get_tx_context(struct gs_can *dev,
 	return NULL;
 }
 
-static int gs_cmd_reset(struct gs_can *gsdev)
+static int gs_cmd_reset(struct gs_can *dev)
 {
 	struct gs_device_mode *dm;
-	struct usb_interface *intf = gsdev->iface;
+	struct usb_interface *intf = dev->iface;
 	int rc;
 
 	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
@@ -374,7 +374,7 @@ static int gs_cmd_reset(struct gs_can *gsdev)
 			     usb_sndctrlpipe(interface_to_usbdev(intf), 0),
 			     GS_USB_BREQ_MODE,
 			     USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
-			     gsdev->channel, 0, dm, sizeof(*dm), 1000);
+			     dev->channel, 0, dm, sizeof(*dm), 1000);
 
 	kfree(dm);
 
-- 
2.35.1


