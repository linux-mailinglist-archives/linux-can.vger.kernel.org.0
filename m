Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1052F1062
	for <lists+linux-can@lfdr.de>; Mon, 11 Jan 2021 11:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbhAKKq7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jan 2021 05:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbhAKKq6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jan 2021 05:46:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140A5C0617A6
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 02:45:44 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kyuhi-00054Z-Nn
        for linux-can@vger.kernel.org; Mon, 11 Jan 2021 11:45:42 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7B02F5BF7BE
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 10:45:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E6F515BF7AB;
        Mon, 11 Jan 2021 10:45:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e14dc261;
        Mon, 11 Jan 2021 10:45:34 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next v2 08/15] can: length: can_fd_len2dlc(): simplify length calculcation
Date:   Mon, 11 Jan 2021 11:45:22 +0100
Message-Id: <20210111104529.657057-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111104529.657057-1-mkl@pengutronix.de>
References: <20210111104529.657057-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

If the length paramter in len2dlc() exceeds the size of the len2dlc array, we
return 0xF. This is equal to the last 16 members of the array.

This patch removes these members from the array, uses ARRAY_SIZE() for the
length check, and returns CANFD_MAX_DLC (which is 0xf).

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/length.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/length.c b/drivers/net/can/dev/length.c
index 5e7d481717ea..d695a3bee1ed 100644
--- a/drivers/net/can/dev/length.c
+++ b/drivers/net/can/dev/length.c
@@ -27,15 +27,13 @@ static const u8 len2dlc[] = {
 	13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
 	14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
 	14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
-	15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
-	15, 15, 15, 15, 15, 15, 15, 15	/* 57 - 64 */
 };
 
 /* map the sanitized data length to an appropriate data length code */
 u8 can_fd_len2dlc(u8 len)
 {
-	if (unlikely(len > 64))
-		return 0xF;
+	if (len > ARRAY_SIZE(len2dlc))
+		return CANFD_MAX_DLC;
 
 	return len2dlc[len];
 }
-- 
2.29.2


