Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1ADB2F95F7
	for <lists+linux-can@lfdr.de>; Sun, 17 Jan 2021 23:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbhAQWcP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 17 Jan 2021 17:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbhAQWcP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 17 Jan 2021 17:32:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106F0C061573
        for <linux-can@vger.kernel.org>; Sun, 17 Jan 2021 14:31:35 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l1Ga5-0001if-Hy
        for linux-can@vger.kernel.org; Sun, 17 Jan 2021 23:31:33 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 924455C5939
        for <linux-can@vger.kernel.org>; Sun, 17 Jan 2021 22:31:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1673C5C5935;
        Sun, 17 Jan 2021 22:31:32 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 29b39369;
        Sun, 17 Jan 2021 22:31:31 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] can: length: can_fd_len2dlc(): make legnth calculation readable again
Date:   Sun, 17 Jan 2021 23:31:30 +0100
Message-Id: <20210117223130.1972245-1-mkl@pengutronix.de>
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

In commit 652562e5ff06 ("can: length: can_fd_len2dlc(): simplify length
calculcation") the readability of the code degraded and became more error
prone. To counteract this, partially convert that patch and replace open coded
values (of the original code) with proper defines.

Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Fixes: 652562e5ff06 ("can: length: can_fd_len2dlc(): simplify length calculcation")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/length.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/length.c b/drivers/net/can/dev/length.c
index d35c4e82314d..f5509e48fe95 100644
--- a/drivers/net/can/dev/length.c
+++ b/drivers/net/can/dev/length.c
@@ -27,12 +27,14 @@ static const u8 len2dlc[] = {
 	13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
 	14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
 	14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
+	15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
+	15, 15, 15, 15, 15, 15, 15, 15	/* 57 - 64 */
 };
 
 /* map the sanitized data length to an appropriate data length code */
 u8 can_fd_len2dlc(u8 len)
 {
-	if (len >= ARRAY_SIZE(len2dlc))
+	if (unlikely(len > CANFD_MAX_LEN))
 		return CANFD_MAX_DLC;
 
 	return len2dlc[len];
-- 
2.29.2


