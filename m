Return-Path: <linux-can+bounces-3009-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE31A54B1C
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 13:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03ACB3AFF5F
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5CA20A5D3;
	Thu,  6 Mar 2025 12:43:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB74D20B7F4;
	Thu,  6 Mar 2025 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265013; cv=none; b=lUhVmbYpxsOyxKJl5hEU/NidarVzxLUtWXWnYHK6JXHUR6kbEAPFBmmubfIO18kr/6wbPISmLtIB3nDt/WreTtzPqzbYyjFaEV3soW1gs9HTutgc1dszBmagMNWmR0W9dIp02RxdiMolt67Q2SXSDHekaeTZL/7o+6ZkNrKVJfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265013; c=relaxed/simple;
	bh=qs6Hftn/pe44WOGUEq3okvI3Ynv33/n8CLCy5ESrne8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGvkvlSN6HjUJbuoZnZ86swGhMeWLAzIxPsFXvCtHwKdJG+37nDtkT0oCFOb1MZ6aUtJ7UTEwrrFGF/Ml6eWqJFu9CXLRFavfHjIy5fF01eBxOM12mWXKIMzNfuoi2LqJAwiMtbtyVwMPNc87TZLDQ5uNTz6SmQyzf2/dfZpUSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: S63kKNAZSH2bwNtZdzuixg==
X-CSE-MsgGUID: zA4eSNcJT8+WGFwhHb1ajQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Mar 2025 21:43:31 +0900
Received: from localhost.localdomain (unknown [10.226.92.10])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C36EF4281B03;
	Thu,  6 Mar 2025 21:43:28 +0900 (JST)
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
Subject: [PATCH v4 07/11] can: rcar_canfd: Add mask table to struct rcar_canfd_hw_info
Date: Thu,  6 Mar 2025 12:42:46 +0000
Message-ID: <20250306124256.93033-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
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
v3->v4:
 * Added prefix RCANFD_* to enum rcar_canfd_mask_id.
v3:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 68 +++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index f7c78b1a2684..dd9d73b37d02 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -82,25 +82,24 @@
 #define RCANFD_GERFL_DEF		BIT(0)
 
 #define RCANFD_GERFL_ERR(gpriv, x) \
-	((x) & (reg_gen4(gpriv, RCANFD_GERFL_EEF0_7, \
-			 RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1)) | \
-		RCANFD_GERFL_MES | \
+	((x) & ((gpriv)->info->mask_table[RCANFD_EEF_MASK] | RCANFD_GERFL_MES | \
 		((gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0)))
 
 /* AFL Rx rules registers */
 
 /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
 #define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
-	(((x) & reg_gen4(gpriv, 0x1ff, 0xff)) << \
+	(((x) & (gpriv)->info->mask_table[RCANFD_RNC_MASK]) << \
 	 (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
 
 #define RCANFD_GAFLCFG_GETRNC(gpriv, n, x) \
 	(((x) >> (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8))) & \
-	 reg_gen4(gpriv, 0x1ff, 0xff))
+	 (gpriv)->info->mask_table[RCANFD_RNC_MASK])
 
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
-#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))
+#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & \
+					 (gpriv)->info->mask_table[RCANFD_AFLPN_MASK])
 
 /* RSCFDnCFDGAFLIDj / RSCFDnGAFLIDj */
 #define RCANFD_GAFLID_GAFLLB		BIT(29)
@@ -118,13 +117,13 @@
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x7f, 0x1f)) << reg_gen4(gpriv, 25, 24))
+	(((x) & (gpriv)->info->mask_table[RCANFD_NTSEG2_MASK]) << reg_gen4(gpriv, 25, 24))
 
 #define RCANFD_NCFG_NTSEG1(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0xff, 0x7f)) << reg_gen4(gpriv, 17, 16))
+	(((x) & (gpriv)->info->mask_table[RCANFD_NTSEG1_MASK]) << reg_gen4(gpriv, 17, 16))
 
 #define RCANFD_NCFG_NSJW(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x7f, 0x1f)) << reg_gen4(gpriv, 10, 11))
+	(((x) & (gpriv)->info->mask_table[RCANFD_NSJW_MASK]) << reg_gen4(gpriv, 10, 11))
 
 #define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
 
@@ -186,13 +185,13 @@
 #define RCANFD_CERFL_ERR(x)		((x) & (0x7fff)) /* above bits 14:0 */
 
 /* RSCFDnCFDCmDCFG */
-#define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & reg_gen4(gpriv, 0xf, 0x7)) << 24)
+#define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & (gpriv)->info->mask_table[RCANFD_DSJW_MASK]) << 24)
 
 #define RCANFD_DCFG_DTSEG2(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x0f, 0x7)) << reg_gen4(gpriv, 16, 20))
+	(((x) & (gpriv)->info->mask_table[RCANFD_DTSEG2_MASK]) << reg_gen4(gpriv, 16, 20))
 
 #define RCANFD_DCFG_DTSEG1(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x1f, 0xf)) << reg_gen4(gpriv, 8, 16))
+	(((x) & (gpriv)->info->mask_table[RCANFD_DTSEG1_MASK]) << reg_gen4(gpriv, 8, 16))
 
 #define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
 
@@ -234,7 +233,7 @@
 
 /* RSCFDnCFDCFCCk */
 #define RCANFD_CFCC_CFTML(gpriv, x)	\
-	(((x) & reg_gen4(gpriv, 0x1f, 0xf)) << reg_gen4(gpriv, 16, 20))
+	(((x) & (gpriv)->info->mask_table[RCANFD_CFTML_MASK]) << reg_gen4(gpriv, 16, 20))
 #define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
 #define RCANFD_CFCC_CFIM		BIT(12)
 #define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
@@ -518,9 +517,23 @@ enum rcar_canfd_reg_offset_id {
 	RCANFD_CFOFFSET,	/* Transmit/receive FIFO buffer access ID register */
 };
 
+enum rcar_canfd_mask_id {
+	RCANFD_EEF_MASK,	/* Global Error Flag */
+	RCANFD_RNC_MASK,	/* Rule Number for Channel */
+	RCANFD_AFLPN_MASK,	/* Acceptance Filter List Page Number */
+	RCANFD_NTSEG2_MASK,	/* Nominal Bit Rate Time Segment 2 Control */
+	RCANFD_NTSEG1_MASK,	/* Nominal Bit Rate Time Segment 1 Control */
+	RCANFD_NSJW_MASK,	/* Nominal Bit Rate Resynchronization Jump Width Control */
+	RCANFD_DSJW_MASK,	/* Data Bit Rate Resynchronization Jump Width Control */
+	RCANFD_DTSEG2_MASK,	/* Data Bit Rate Time Segment 2 Control */
+	RCANFD_DTSEG1_MASK,	/* Data Bit Rate Time Segment 1 Control */
+	RCANFD_CFTML_MASK,	/* Common FIFO TX Message Buffer Link */
+};
+
 struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
+	const u32 *mask_table;
 	const u16 *regs;
 	u8 max_channels;
 	u8 postdiv;
@@ -619,7 +632,34 @@ static const u16 rcar_gen4_regs[] = {
 	[RCANFD_CFOFFSET] = 0x6400,
 };
 
+static const u32 rcar_gen3_mask_table[] = {
+	[RCANFD_EEF_MASK] = RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1),
+	[RCANFD_RNC_MASK] = 0xff,
+	[RCANFD_AFLPN_MASK] = 0x1f,
+	[RCANFD_NTSEG2_MASK] = 0x1f,
+	[RCANFD_NTSEG1_MASK] = 0x7f,
+	[RCANFD_NSJW_MASK] = 0x1f,
+	[RCANFD_DSJW_MASK] = 0x7,
+	[RCANFD_DTSEG2_MASK] = 0x7,
+	[RCANFD_DTSEG1_MASK] = 0xf,
+	[RCANFD_CFTML_MASK] = 0xf,
+};
+
+static const u32 rcar_gen4_mask_table[] = {
+	[RCANFD_EEF_MASK] = RCANFD_GERFL_EEF0_7,
+	[RCANFD_RNC_MASK] = 0x1ff,
+	[RCANFD_AFLPN_MASK] = 0x7f,
+	[RCANFD_NTSEG2_MASK] = 0x7f,
+	[RCANFD_NTSEG1_MASK] = 0xff,
+	[RCANFD_NSJW_MASK] = 0x7f,
+	[RCANFD_DSJW_MASK] = 0xf,
+	[RCANFD_DTSEG2_MASK] = 0xf,
+	[RCANFD_DTSEG1_MASK] = 0x1f,
+	[RCANFD_CFTML_MASK] = 0x1f,
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


