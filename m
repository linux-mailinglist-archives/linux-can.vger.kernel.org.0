Return-Path: <linux-can+bounces-2959-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8745A444B2
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 16:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E1F19C4615
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 15:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C69140E3C;
	Tue, 25 Feb 2025 15:41:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC483155757;
	Tue, 25 Feb 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498095; cv=none; b=SXLck9FFmDusmmg79lx+sS4LqkF9o0fYsVy+uh3DJwAy50Pi/85Xs0njy4G8iY+Q96i9Ps57YqKLX5TmknPXPeiHi7o/RDMXBDhDt5ECRK8dJlstfVsFKjeIzfIJyBv3ICnH3CcD4/wRfgX5iVeWIvuds9cz0qHpeE7hpmxexfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498095; c=relaxed/simple;
	bh=7pXez+U2Hd4alAA58FvqOity5qsVYS/bcJgi/zvG7cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ls/WW58HD6mZZBOvw9fvosPnzpYinSu3eS/oJPINpl4pADl7pNDH77/5zavcS8HSVbGHs3f7S5MxErtff3DVLd/X/SeEH/53v9L/H4+EdqAoovoidEeq+lnqN2C+eIYAQFRRvNJjVo7UTgaxV3IZZJ3Xhp6NIQGYHZVu6DKLbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: JlNiz2/CQCSrZgiW/0mn5Q==
X-CSE-MsgGUID: IoQDn8byQBOjIETVBpiILA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Feb 2025 00:41:33 +0900
Received: from localhost.localdomain (unknown [10.226.92.81])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B173B400FC34;
	Wed, 26 Feb 2025 00:41:30 +0900 (JST)
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
Subject: [PATCH v3 07/11] can: rcar_canfd: Add mask table to struct rcar_canfd_hw_info
Date: Tue, 25 Feb 2025 15:40:46 +0000
Message-ID: <20250225154058.59116-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225154058.59116-1-biju.das.jz@bp.renesas.com>
References: <20250225154058.59116-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

R-Car Gen3 and Gen4 has some differences in the mask bits. Add a
mask table to handle these differences.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 68 +++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 268b9b8835c4..fcf5cb93f57c 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -82,25 +82,24 @@
 #define RCANFD_GERFL_DEF		BIT(0)
 
 #define RCANFD_GERFL_ERR(gpriv, x) \
-	((x) & (reg_gen4(gpriv, RCANFD_GERFL_EEF0_7, \
-			 RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1)) | \
-		RCANFD_GERFL_MES | \
+	((x) & ((gpriv)->info->mask_table[EEF_MASK_ID] | RCANFD_GERFL_MES | \
 		((gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0)))
 
 /* AFL Rx rules registers */
 
 /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
 #define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
-	(((x) & reg_gen4(gpriv, 0x1ff, 0xff)) << \
+	(((x) & (gpriv)->info->mask_table[RNC_MASK_ID]) << \
 	 (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
 
 #define RCANFD_GAFLCFG_GETRNC(gpriv, n, x) \
 	(((x) >> (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8))) & \
-	 reg_gen4(gpriv, 0x1ff, 0xff))
+	 (gpriv)->info->mask_table[RNC_MASK_ID])
 
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
-#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))
+#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & \
+					 (gpriv)->info->mask_table[AFLPN_MASK_ID])
 
 /* RSCFDnCFDGAFLIDj / RSCFDnGAFLIDj */
 #define RCANFD_GAFLID_GAFLLB		BIT(29)
@@ -118,13 +117,13 @@
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x7f, 0x1f)) << reg_gen4(gpriv, 25, 24))
+	(((x) & (gpriv)->info->mask_table[NTSEG2_MASK_ID]) << reg_gen4(gpriv, 25, 24))
 
 #define RCANFD_NCFG_NTSEG1(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0xff, 0x7f)) << reg_gen4(gpriv, 17, 16))
+	(((x) & (gpriv)->info->mask_table[NTSEG1_MASK_ID]) << reg_gen4(gpriv, 17, 16))
 
 #define RCANFD_NCFG_NSJW(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x7f, 0x1f)) << reg_gen4(gpriv, 10, 11))
+	(((x) & (gpriv)->info->mask_table[NSJW_MASK_ID]) << reg_gen4(gpriv, 10, 11))
 
 #define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
 
@@ -186,13 +185,13 @@
 #define RCANFD_CERFL_ERR(x)		((x) & (0x7fff)) /* above bits 14:0 */
 
 /* RSCFDnCFDCmDCFG */
-#define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & reg_gen4(gpriv, 0xf, 0x7)) << 24)
+#define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & (gpriv)->info->mask_table[DSJW_MASK_ID]) << 24)
 
 #define RCANFD_DCFG_DTSEG2(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x0f, 0x7)) << reg_gen4(gpriv, 16, 20))
+	(((x) & (gpriv)->info->mask_table[DTSEG2_MASK_ID]) << reg_gen4(gpriv, 16, 20))
 
 #define RCANFD_DCFG_DTSEG1(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x1f, 0xf)) << reg_gen4(gpriv, 8, 16))
+	(((x) & (gpriv)->info->mask_table[DTSEG1_MASK_ID]) << reg_gen4(gpriv, 8, 16))
 
 #define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
 
@@ -234,7 +233,7 @@
 
 /* RSCFDnCFDCFCCk */
 #define RCANFD_CFCC_CFTML(gpriv, x)	\
-	(((x) & reg_gen4(gpriv, 0x1f, 0xf)) << reg_gen4(gpriv, 16, 20))
+	(((x) & (gpriv)->info->mask_table[CFTML_MASK_ID]) << reg_gen4(gpriv, 16, 20))
 #define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
 #define RCANFD_CFCC_CFIM		BIT(12)
 #define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
@@ -518,9 +517,23 @@ enum rcar_canfd_reg_offset_id {
 	CFOFFSET,	/* Transmit/receive FIFO buffer access ID register */
 };
 
+enum rcar_canfd_mask_id {
+	EEF_MASK_ID,	/* Global Error Flag */
+	RNC_MASK_ID,	/* Rule Number for Channel */
+	AFLPN_MASK_ID,	/* Acceptance Filter List Page Number */
+	NTSEG2_MASK_ID,	/* Nominal Bit Rate Time Segment 2 Control */
+	NTSEG1_MASK_ID,	/* Nominal Bit Rate Time Segment 1 Control */
+	NSJW_MASK_ID,	/* Nominal Bit Rate Resynchronization Jump Width Control */
+	DSJW_MASK_ID,	/* Data Bit Rate Resynchronization Jump Width Control */
+	DTSEG2_MASK_ID,	/* Data Bit Rate Time Segment 2 Control */
+	DTSEG1_MASK_ID,	/* Data Bit Rate Time Segment 1 Control */
+	CFTML_MASK_ID,	/* Common FIFO TX Message Buffer Link */
+};
+
 struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
+	const u32 *mask_table;
 	const u16 *regs;
 	u8 max_channels;
 	u8 postdiv;
@@ -619,7 +632,34 @@ static const u16 rcar_gen4_regs[] = {
 	[CFOFFSET] = 0x6400,
 };
 
+static const u32 rcar_gen3_mask_table[] = {
+	[EEF_MASK_ID] = RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1),
+	[RNC_MASK_ID] = 0xff,
+	[AFLPN_MASK_ID] = 0x1f,
+	[NTSEG2_MASK_ID] = 0x1f,
+	[NTSEG1_MASK_ID] = 0x7f,
+	[NSJW_MASK_ID] = 0x1f,
+	[DSJW_MASK_ID] = 0x7,
+	[DTSEG2_MASK_ID] = 0x7,
+	[DTSEG1_MASK_ID] = 0xf,
+	[CFTML_MASK_ID] = 0xf,
+};
+
+static const u32 rcar_gen4_mask_table[] = {
+	[EEF_MASK_ID] = RCANFD_GERFL_EEF0_7,
+	[RNC_MASK_ID] = 0x1ff,
+	[AFLPN_MASK_ID] = 0x7f,
+	[NTSEG2_MASK_ID] = 0x7f,
+	[NTSEG1_MASK_ID] = 0xff,
+	[NSJW_MASK_ID] = 0x7f,
+	[DSJW_MASK_ID] = 0xf,
+	[DTSEG2_MASK_ID] = 0xf,
+	[DTSEG1_MASK_ID] = 0x1f,
+	[CFTML_MASK_ID] = 0x1f,
+};
+
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
+	.mask_table = rcar_gen3_mask_table,
 	.regs = rcar_gen3_regs,
 	.max_channels = 2,
 	.postdiv = 2,
@@ -627,6 +667,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
+	.mask_table = rcar_gen4_mask_table,
 	.regs = rcar_gen4_regs,
 	.max_channels = 8,
 	.postdiv = 2,
@@ -636,6 +677,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
+	.mask_table = rcar_gen3_mask_table,
 	.regs = rcar_gen3_regs,
 	.max_channels = 2,
 	.postdiv = 1,
-- 
2.43.0


