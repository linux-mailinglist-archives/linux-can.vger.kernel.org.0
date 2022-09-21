Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B376A5E53E8
	for <lists+linux-can@lfdr.de>; Wed, 21 Sep 2022 21:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIUTjg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Sep 2022 15:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiIUTjZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Sep 2022 15:39:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C71A2626
        for <linux-can@vger.kernel.org>; Wed, 21 Sep 2022 12:39:24 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ob5Z4-00020N-Jh
        for linux-can@vger.kernel.org; Wed, 21 Sep 2022 21:39:22 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 04AECE8DC8
        for <linux-can@vger.kernel.org>; Wed, 21 Sep 2022 19:39:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 01EFBE8DC3;
        Wed, 21 Sep 2022 19:39:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8e2b8f0b;
        Wed, 21 Sep 2022 19:39:03 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/3] can: gs_usb: gs_make_candev(): clean up error handling
Date:   Wed, 21 Sep 2022 21:39:02 +0200
Message-Id: <20220921193902.575416-4-mkl@pengutronix.de>
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

Introduce a label to free the allocated candev in case of an error and
make use of if. Fix a memory leak if the extended bit timing cannot be
read. Extend the error messages to print the number of the failing
channel and the symbolic error name.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index be4530e288d1..17e1ac2ffc19 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1096,8 +1096,8 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	if (rc) {
 		dev_err(&intf->dev,
-			"Couldn't get bit timing const for channel (err=%d)\n",
-			rc);
+			"Couldn't get bit timing const for channel %d (%pe)\n",
+			channel, ERR_PTR(rc));
 		return ERR_PTR(rc);
 	}
 
@@ -1210,9 +1210,9 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 					  1000, GFP_KERNEL);
 		if (rc) {
 			dev_err(&intf->dev,
-				"Couldn't get extended bit timing const for channel (err=%d)\n",
-				rc);
-			return ERR_PTR(rc);
+				"Couldn't get extended bit timing const for channel %d (%pe)\n",
+				channel, ERR_PTR(rc));
+			goto out_free_candev;
 		}
 
 		strcpy(dev->data_bt_const.name, KBUILD_MODNAME);
@@ -1232,12 +1232,17 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	rc = register_candev(dev->netdev);
 	if (rc) {
-		free_candev(dev->netdev);
-		dev_err(&intf->dev, "Couldn't register candev (err=%d)\n", rc);
-		return ERR_PTR(rc);
+		dev_err(&intf->dev,
+			"Couldn't register candev for channel %d (%pe)\n",
+			channel, ERR_PTR(rc));
+		goto out_free_candev;
 	}
 
 	return dev;
+
+ out_free_candev:
+	free_candev(dev->netdev);
+	return ERR_PTR(rc);
 }
 
 static void gs_destroy_candev(struct gs_can *dev)
-- 
2.35.1


