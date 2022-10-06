Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04E85F6BA1
	for <lists+linux-can@lfdr.de>; Thu,  6 Oct 2022 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiJFQZV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Oct 2022 12:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiJFQZG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2022 12:25:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC00233AF
        for <linux-can@vger.kernel.org>; Thu,  6 Oct 2022 09:25:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ogTgA-0002pV-Hm
        for linux-can@vger.kernel.org; Thu, 06 Oct 2022 18:24:58 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E263DF663D
        for <linux-can@vger.kernel.org>; Thu,  6 Oct 2022 16:24:57 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5E209F6638;
        Thu,  6 Oct 2022 16:24:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id caf1a094;
        Thu, 6 Oct 2022 16:24:56 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/6] can: gs_usb: gs_can_open(): sort checks for ctrlmode
Date:   Thu,  6 Oct 2022 18:24:48 +0200
Message-Id: <20221006162452.200322-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221006162452.200322-1-mkl@pengutronix.de>
References: <20221006162452.200322-1-mkl@pengutronix.de>
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

Sort the checks for dev->can.ctrlmode by values of CAN_CTRLMODE_*, so
that it's clear where to add new checks.

While there, remove the comment that the Atmel UC3C hardware doesn't
support One Shot Mode. One Shot Mode is only available to be activated
by the user, if the device specifies the GS_CAN_FEATURE_ONE_SHOT.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 53293086faf0..57daf46b2aec 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -843,8 +843,6 @@ static int gs_can_open(struct net_device *netdev)
 
 	ctrlmode = dev->can.ctrlmode;
 	if (ctrlmode & CAN_CTRLMODE_FD) {
-		flags |= GS_CAN_MODE_FD;
-
 		if (dev->feature & GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX)
 			dev->hf_size_tx = struct_size(hf, canfd_quirk, 1);
 		else
@@ -915,14 +913,14 @@ static int gs_can_open(struct net_device *netdev)
 	if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		flags |= GS_CAN_MODE_LISTEN_ONLY;
 
-	/* Controller is not allowed to retry TX
-	 * this mode is unavailable on atmels uc3c hardware
-	 */
+	if (ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		flags |= GS_CAN_MODE_TRIPLE_SAMPLE;
+
 	if (ctrlmode & CAN_CTRLMODE_ONE_SHOT)
 		flags |= GS_CAN_MODE_ONE_SHOT;
 
-	if (ctrlmode & CAN_CTRLMODE_3_SAMPLES)
-		flags |= GS_CAN_MODE_TRIPLE_SAMPLE;
+	if (ctrlmode & CAN_CTRLMODE_FD)
+		flags |= GS_CAN_MODE_FD;
 
 	/* if hardware supports timestamps, enable it */
 	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-- 
2.35.1


