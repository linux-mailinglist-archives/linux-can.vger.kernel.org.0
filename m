Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534E92F025E
	for <lists+linux-can@lfdr.de>; Sat,  9 Jan 2021 18:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbhAIRlo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 9 Jan 2021 12:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbhAIRlo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 9 Jan 2021 12:41:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F073C0617A7
        for <linux-can@vger.kernel.org>; Sat,  9 Jan 2021 09:40:25 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kyIDv-0004n9-Io
        for linux-can@vger.kernel.org; Sat, 09 Jan 2021 18:40:23 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 3D40A5BE8C5
        for <linux-can@vger.kernel.org>; Sat,  9 Jan 2021 17:40:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id EB4D15BE89F;
        Sat,  9 Jan 2021 17:40:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8bcdbc3e;
        Sat, 9 Jan 2021 17:40:14 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 07/13] can: length: convert to kernel coding style
Date:   Sat,  9 Jan 2021 18:40:07 +0100
Message-Id: <20210109174013.534145-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109174013.534145-1-mkl@pengutronix.de>
References: <20210109174013.534145-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch converts the file into the kernel coding style.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/length.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/dev/length.c b/drivers/net/can/dev/length.c
index 540d40dc0bc2..4bf3847ec508 100644
--- a/drivers/net/can/dev/length.c
+++ b/drivers/net/can/dev/length.c
@@ -8,8 +8,10 @@
 
 /* CAN DLC to real data length conversion helpers */
 
-static const u8 dlc2len[] = {0, 1, 2, 3, 4, 5, 6, 7,
-			     8, 12, 16, 20, 24, 32, 48, 64};
+static const u8 dlc2len[] = {
+	0, 1, 2, 3, 4, 5, 6, 7,
+	8, 12, 16, 20, 24, 32, 48, 64
+};
 
 /* get data length from raw data length code (DLC) */
 u8 can_fd_dlc2len(u8 dlc)
@@ -18,16 +20,18 @@ u8 can_fd_dlc2len(u8 dlc)
 }
 EXPORT_SYMBOL_GPL(can_fd_dlc2len);
 
-static const u8 len2dlc[] = {0, 1, 2, 3, 4, 5, 6, 7, 8,		/* 0 - 8 */
-			     9, 9, 9, 9,			/* 9 - 12 */
-			     10, 10, 10, 10,			/* 13 - 16 */
-			     11, 11, 11, 11,			/* 17 - 20 */
-			     12, 12, 12, 12,			/* 21 - 24 */
-			     13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
-			     14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
-			     14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
-			     15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
-			     15, 15, 15, 15, 15, 15, 15, 15};	/* 57 - 64 */
+static const u8 len2dlc[] = {
+	0, 1, 2, 3, 4, 5, 6, 7, 8,	/* 0 - 8 */
+	9, 9, 9, 9,			/* 9 - 12 */
+	10, 10, 10, 10,			/* 13 - 16 */
+	11, 11, 11, 11,			/* 17 - 20 */
+	12, 12, 12, 12,			/* 21 - 24 */
+	13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
+	14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
+	14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
+	15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
+	15, 15, 15, 15, 15, 15, 15, 15	/* 57 - 64 */
+};
 
 /* map the sanitized data length to an appropriate data length code */
 u8 can_fd_len2dlc(u8 len)
-- 
2.29.2


