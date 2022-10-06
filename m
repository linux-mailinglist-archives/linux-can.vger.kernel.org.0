Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145135F6B9C
	for <lists+linux-can@lfdr.de>; Thu,  6 Oct 2022 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJFQZM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Oct 2022 12:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiJFQZG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2022 12:25:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA8223145
        for <linux-can@vger.kernel.org>; Thu,  6 Oct 2022 09:25:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ogTgB-0002q0-5u
        for linux-can@vger.kernel.org; Thu, 06 Oct 2022 18:24:59 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8A8D8F6646
        for <linux-can@vger.kernel.org>; Thu,  6 Oct 2022 16:24:58 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id EDB9BF663F;
        Thu,  6 Oct 2022 16:24:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2d0f16e3;
        Thu, 6 Oct 2022 16:24:56 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/6] can: gs_usb: add ability to enable / disable berr rerporting
Date:   Thu,  6 Oct 2022 18:24:50 +0200
Message-Id: <20221006162452.200322-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221006162452.200322-1-mkl@pengutronix.de>
References: <20221006162452.200322-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jeroen Hofstee <jhofstee@victronenergy.com>

The open source firmware candleLight report bus errors
unconditionally. This adds support to enable / disable bus error
reporting with the standard netlink property.

Not-Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 7c1f13a90419..ea85140fe3df 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -134,6 +134,7 @@ struct gs_device_config {
 /* GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX BIT(9) */
 /* GS_CAN_FEATURE_BT_CONST_EXT BIT(10) */
 /* GS_CAN_FEATURE_TERMINATION BIT(11) */
+#define GS_CAN_MODE_BERR_REPORTING BIT(12)
 
 struct gs_device_mode {
 	__le32 mode;
@@ -174,7 +175,8 @@ struct gs_device_termination_state {
 #define GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX BIT(9)
 #define GS_CAN_FEATURE_BT_CONST_EXT BIT(10)
 #define GS_CAN_FEATURE_TERMINATION BIT(11)
-#define GS_CAN_FEATURE_MASK GENMASK(11, 0)
+#define GS_CAN_FEATURE_BERR_REPORTING BIT(12)
+#define GS_CAN_FEATURE_MASK GENMASK(12, 0)
 
 /* internal quirks - keep in GS_CAN_FEATURE space for now */
 
@@ -919,6 +921,9 @@ static int gs_can_open(struct net_device *netdev)
 	if (ctrlmode & CAN_CTRLMODE_ONE_SHOT)
 		flags |= GS_CAN_MODE_ONE_SHOT;
 
+	if (ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		flags |= GS_CAN_MODE_BERR_REPORTING;
+
 	if (ctrlmode & CAN_CTRLMODE_FD)
 		flags |= GS_CAN_MODE_FD;
 
@@ -1223,6 +1228,9 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		}
 	}
 
+	if (feature & GS_CAN_FEATURE_BERR_REPORTING)
+		dev->can.ctrlmode_supported |= CAN_CTRLMODE_BERR_REPORTING;
+
 	/* The CANtact Pro from LinkLayer Labs is based on the
 	 * LPC54616 µC, which is affected by the NXP LPC USB transfer
 	 * erratum. However, the current firmware (version 2) doesn't
-- 
2.35.1


