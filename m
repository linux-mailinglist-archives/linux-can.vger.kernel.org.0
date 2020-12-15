Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6092DAD94
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 13:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgLOM5P (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 07:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbgLOM5B (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 07:57:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93EDC0617A7
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 04:56:21 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kp9sK-0004xd-BX
        for linux-can@vger.kernel.org; Tue, 15 Dec 2020 13:56:20 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 60FFE5ADE4C
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 12:56:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 14EEB5ADE48;
        Tue, 15 Dec 2020 12:56:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a3108133;
        Tue, 15 Dec 2020 12:56:18 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 1/2] can: dev: add can_len2dll_len()
Date:   Tue, 15 Dec 2020 13:55:48 +0100
Message-Id: <20201215125549.540918-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c   | 21 +++++++++++++++++++++
 include/linux/can/dev.h |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 68f37ac54327..fa81e3067b3b 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -60,6 +60,27 @@ u8 can_len2dlc(u8 len)
 }
 EXPORT_SYMBOL_GPL(can_len2dlc);
 
+static const u8 len2dll_len[] = {
+	0, 1, 2, 3, 4, 5, 6, 7, 8,	/* 0 - 8 */
+	12, 12, 12, 12,			/* 9 - 12 */
+	16, 16, 16, 16,			/* 13 - 16 */
+	20, 20, 20, 20,			/* 17 - 20 */
+	24, 24, 24, 24,			/* 21 - 24 */
+	32, 32, 32, 32, 32, 32, 32, 32,	/* 25 - 32 */
+	40, 40, 40, 40, 40, 40, 40, 40,	/* 33 - 40 */
+	48, 48, 48, 48, 48, 48, 48, 48	/* 41 - 48 */
+};
+
+/* map the sanitized data length to an appropriate data link layer length */
+u8 can_len2dll_len(u8 len)
+{
+	if (len > ARRAY_SIZE(len2dll_len))
+		return CANFD_MAX_DLEN;
+
+	return len2dll_len[len];
+}
+EXPORT_SYMBOL_GPL(can_len2dll_len);
+
 #ifdef CONFIG_CAN_CALC_BITTIMING
 #define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
 
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 41ff31795320..27c359a00203 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -192,6 +192,9 @@ u8 can_dlc2len(u8 can_dlc);
 /* map the sanitized data length to an appropriate data length code */
 u8 can_len2dlc(u8 len);
 
+/* map the sanitized data length to an appropriate data link layer length */
+u8 can_len2dll_len(u8 len);
+
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 				    unsigned int txqs, unsigned int rxqs);
 #define alloc_candev(sizeof_priv, echo_skb_max) \
-- 
2.29.2


