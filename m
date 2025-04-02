Return-Path: <linux-can+bounces-3336-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B5A78C1D
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 12:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C17C18950AF
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F7023642E;
	Wed,  2 Apr 2025 10:22:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41E7236A6D;
	Wed,  2 Apr 2025 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589377; cv=none; b=ktBZya/benPmyysSQ8K29n537yq+7jxUifwePKQwZ8gwuGWos8PdtxImOpZAEIITqPhtznlx8cZYbkufvM9e9zQrr9MYxIGERe4SiOdF/sj7VBMObwQEd0hff3MErbrJMV/y0jIE7lbWN6hvE66ddTK/VGXzEQEMgpvwx8a1wMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589377; c=relaxed/simple;
	bh=yIBwMbzqJ6zOnHdUv2lIo8hse+8X/W1xeHcs+N9gr2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmuHIRc354ErypAFKTlY5KVPgzl112V37OjI/7M0gs6s2GUbqsMtUknlAILpgS1N51N/SPXe7kNNVOb9An2A+457m9pQQIW0/HRBJj6bbUdRTGQFycXPUTfQ90t/q5lnGIrc2RDQY3HdGLK4qHT34DGqRUMubkvle1AythlLjcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: oVpfX/v4Tl+wiWHhRDlm1Q==
X-CSE-MsgGUID: N0wFbfd1ToSUur9w+BMjYg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2025 19:22:54 +0900
Received: from localhost.localdomain (unknown [10.226.93.220])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A202342241E7;
	Wed,  2 Apr 2025 19:22:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-can@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v8 05/19] can: rcar_canfd: Update RCANFD_GERFL_ERR macro
Date: Wed,  2 Apr 2025 11:21:57 +0100
Message-ID: <20250402102226.28032-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250402102226.28032-1-biju.das.jz@bp.renesas.com>
References: <20250402102226.28032-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the macro RCANFD_GERFL_EEF0_7->RCANFD_GERFL_EEF. The macros
RCANFD_GERFL_EEF* in RCANFD_GERFL_ERR can be replaced by FIELD_PREP() and
drop the redundant macro RCANFD_GERFL_EEF(ch).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v7->v8:
 * Updated commit description.
 * Replaced the macro RCANFD_GERFL_EEF0_7->RCANFD_GERFL_EEF.
 * Dropped the redundant macro RCANFD_GERFL_EEF(ch).
 * Dropped the tag.
v6->v7:
 * No change.
v5->v6:
 * Collected tag.
v5:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 565a91c2ca83..34b918e8ec1c 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -74,18 +74,18 @@
 #define RCANFD_GSTS_GNOPM		(BIT(0) | BIT(1) | BIT(2) | BIT(3))
 
 /* RSCFDnCFDGERFL / RSCFDnGERFL */
-#define RCANFD_GERFL_EEF0_7		GENMASK(23, 16)
-#define RCANFD_GERFL_EEF(ch)		BIT(16 + (ch))
+#define RCANFD_GERFL_EEF		GENMASK(23, 16)
 #define RCANFD_GERFL_CMPOF		BIT(3)	/* CAN FD only */
 #define RCANFD_GERFL_THLES		BIT(2)
 #define RCANFD_GERFL_MES		BIT(1)
 #define RCANFD_GERFL_DEF		BIT(0)
 
 #define RCANFD_GERFL_ERR(gpriv, x) \
-	((x) & (reg_gen4(gpriv, RCANFD_GERFL_EEF0_7, \
-			 RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1)) | \
-		RCANFD_GERFL_MES | \
-		((gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0)))
+({\
+	typeof(gpriv) (_gpriv) = (gpriv); \
+	((x) & ((FIELD_PREP(RCANFD_GERFL_EEF, (_gpriv)->channels_mask)) | \
+		RCANFD_GERFL_MES | ((_gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0))); \
+})
 
 /* AFL Rx rules registers */
 
@@ -938,7 +938,7 @@ static void rcar_canfd_global_error(struct net_device *ndev)
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
 	gerfl = rcar_canfd_read(priv->base, RCANFD_GERFL);
-	if (gerfl & RCANFD_GERFL_EEF(ch)) {
+	if (gerfl & FIELD_PREP(RCANFD_GERFL_EEF, ch)) {
 		netdev_dbg(ndev, "Ch%u: ECC Error flag\n", ch);
 		stats->tx_dropped++;
 	}
-- 
2.43.0


