Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B014D2F49
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 13:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiCIMmj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 07:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiCIMmi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 07:42:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4293F1768EF
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 04:41:40 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRvdK-0002jE-JG
        for linux-can@vger.kernel.org; Wed, 09 Mar 2022 13:41:38 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8ABF546BAD
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 12:41:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4522C46BAA;
        Wed,  9 Mar 2022 12:41:37 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7d71a04e;
        Wed, 9 Mar 2022 12:41:33 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 11/21] can: gs_usb: document the PAD_PKTS_TO_MAX_PKT_SIZE feature
Date:   Wed,  9 Mar 2022 13:41:22 +0100
Message-Id: <20220309124132.291861-12-mkl@pengutronix.de>
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

The widely used open source firmware candleLight supports padding the
USB packets to max packet size to improve performance on Windows
systems.

This patch documents the bit.

Link: https://github.com/candle-usb/candleLight_fw/pull/7
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index e739980589d7..52c84792361e 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -97,6 +97,7 @@ struct gs_device_config {
 #define GS_CAN_MODE_HW_TIMESTAMP BIT(4)
 /* GS_CAN_FEATURE_IDENTIFY BIT(5) */
 /* GS_CAN_FEATURE_USER_ID BIT(6) */
+#define GS_CAN_MODE_PAD_PKTS_TO_MAX_PKT_SIZE BIT(7)
 
 struct gs_device_mode {
 	__le32 mode;
@@ -128,6 +129,7 @@ struct gs_identify_mode {
 #define GS_CAN_FEATURE_HW_TIMESTAMP BIT(4)
 #define GS_CAN_FEATURE_IDENTIFY BIT(5)
 #define GS_CAN_FEATURE_USER_ID BIT(6)
+#define GS_CAN_FEATURE_PAD_PKTS_TO_MAX_PKT_SIZE BIT(7)
 
 struct gs_device_bt_const {
 	__le32 feature;
-- 
2.34.1


