Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C646A6052CE
	for <lists+linux-can@lfdr.de>; Thu, 20 Oct 2022 00:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiJSWKd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Oct 2022 18:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiJSWK0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Oct 2022 18:10:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C7214DF1E
        for <linux-can@vger.kernel.org>; Wed, 19 Oct 2022 15:10:24 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1olHGY-0001jv-Tu
        for linux-can@vger.kernel.org; Thu, 20 Oct 2022 00:10:22 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5D9AA1041FD
        for <linux-can@vger.kernel.org>; Wed, 19 Oct 2022 22:10:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4623B1041F9;
        Wed, 19 Oct 2022 22:10:21 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 79510e77;
        Wed, 19 Oct 2022 22:10:18 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 2/7] can: gs_usb: gs_can_open(): sort checks for ctrlmode
Date:   Thu, 20 Oct 2022 00:10:11 +0200
Message-Id: <20221019221016.1659260-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221019221016.1659260-1-mkl@pengutronix.de>
References: <20221019221016.1659260-1-mkl@pengutronix.de>
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
support One Shot Mode. The One Shot mode is only available and to be
activated by the user, if the device specifies the feature bit
GS_CAN_FEATURE_ONE_SHOT.

Link: https://lore.kernel.org/all/20221019213035.1607752-3-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index aa6c84b7db06..5dad0ebb3d3e 100644
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


