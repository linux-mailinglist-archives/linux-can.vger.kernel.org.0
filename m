Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A164D6052D0
	for <lists+linux-can@lfdr.de>; Thu, 20 Oct 2022 00:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiJSWKf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Oct 2022 18:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiJSWK1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Oct 2022 18:10:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0F7152039
        for <linux-can@vger.kernel.org>; Wed, 19 Oct 2022 15:10:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1olHGa-0001ki-IQ
        for linux-can@vger.kernel.org; Thu, 20 Oct 2022 00:10:24 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 1531D104206
        for <linux-can@vger.kernel.org>; Wed, 19 Oct 2022 22:10:24 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 139EE1041FF;
        Wed, 19 Oct 2022 22:10:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 58f2f9bb;
        Wed, 19 Oct 2022 22:10:18 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 4/7] can: gs_usb: document GS_CAN_FEATURE_BERR_REPORTING
Date:   Thu, 20 Oct 2022 00:10:13 +0200
Message-Id: <20221019221016.1659260-5-mkl@pengutronix.de>
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

From: Jeroen Hofstee <jhofstee@victronenergy.com>

Document the new feature ("GS_CAN_FEATURE_BERR_REPORTING") that
indicates that the bus error reporting in the CAN controller can
switched on and off with the GS_CAN_MODE_BERR_REPORTING mode bit in
the GS_USB_BREQ_MODE control message.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
Link: https://lore.kernel.org/all/20221019213035.1607752-5-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index f9e2b394c71e..68e474a762c5 100644
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
 
-- 
2.35.1


