Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6012FAB3F
	for <lists+linux-can@lfdr.de>; Mon, 18 Jan 2021 21:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394005AbhARUTL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Jan 2021 15:19:11 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:19480 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394295AbhARUSM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Jan 2021 15:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1611000848;
        s=strato-dkim-0002; d=hartkopp.net;
        h=Message-Id:Date:Subject:Cc:To:From:From:Subject:Sender;
        bh=EhBMkvJ3yuR6EyGTsq8jkc5HymjvGGi7M0JZTEqkWUk=;
        b=GtGlp66+LYLwtW8uo6ROXOo54vNiaerGvyp00q6GpiiGejCFuJvXMCUKahySlVbm0M
        F2q9GgnzeCG0ZjZfWiEakKv0r2zFbhSVQ10GKjTqdRfsPUj/qwYC0p2TVNvi2EyrY73Q
        DVUaoLeIvn529nssiIU2ikwkYtKg2+JOF03KMbYvndCUkQfaA3UXto9bVg5UGDAGXY3a
        eqe9wKnR+He+Fjg+lRXRvGnlpPYxqZ2vO5sl+ZY9LJVm+BL8mnoI9+DaqiYZgjFzeVtw
        Tt8hSHP44Wp5GSTAJMB/aJ6YBIw8M8MCwG3vMfoa76WyMT0bhQplaGonwwrOZIGIAStI
        L3mw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0lO8DsfULo/S3TWrh0eM="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id k075acx0IKE6e3z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 18 Jan 2021 21:14:06 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3] can: length: can_fd_len2dlc(): make length calculation readable again
Date:   Mon, 18 Jan 2021 21:13:46 +0100
Message-Id: <20210118201346.79422-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In commit 652562e5ff06 ("can: length: can_fd_len2dlc(): simplify length
calculcation") the readability of the code degraded and became more error
prone. To counteract this, partially convert that patch and replace open coded
values (of the original code) with proper defines.
Also double check the correct length mapping table size at build time.

Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Fixes: 652562e5ff06 ("can: length: can_fd_len2dlc(): simplify length calculcation")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/length.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/length.c b/drivers/net/can/dev/length.c
index d35c4e82314d..d085cb26d00d 100644
--- a/drivers/net/can/dev/length.c
+++ b/drivers/net/can/dev/length.c
@@ -25,16 +25,21 @@ static const u8 len2dlc[] = {
 	11, 11, 11, 11,			/* 17 - 20 */
 	12, 12, 12, 12,			/* 21 - 24 */
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
+	/* check for length mapping table size at build time */
+	BUILD_BUG_ON(ARRAY_SIZE(len2dlc) < CANFD_MAX_DLEN + 1);
+
+	if (unlikely(len > CANFD_MAX_DLEN))
 		return CANFD_MAX_DLC;
 
 	return len2dlc[len];
 }
 EXPORT_SYMBOL_GPL(can_fd_len2dlc);
-- 
2.29.2

