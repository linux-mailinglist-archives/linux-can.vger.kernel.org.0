Return-Path: <linux-can+bounces-3132-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F0CA64F23
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 13:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09093ABBD4
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D3A23AE96;
	Mon, 17 Mar 2025 12:37:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306A723A98E;
	Mon, 17 Mar 2025 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215039; cv=none; b=TsGFmFoE6gzHPNMMf5NFi4qRAEl2vEgweeMtELxZ7rf7tyibGAqZwY4fTqMNDd90Vh9Sb88omsQ9tqKlR4zbWA/1G/VgEVyI/G3pVtxo6tId2+B/FI3qQqhpBw/7q1hKTrJKX4os/KYqqvpjiHMuFAXcYekJRaem94KXEsSwgQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215039; c=relaxed/simple;
	bh=m3WpGh5dSzvFcaK51daUXrmf5Z/36gs6BWhks6Wuzso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axAoXEM572vtrYbvbWYhaOYm1qyD5MTzB6ihvIeBfFkjBfG/9CoJiEPYqPl87lVMGM/5ZbhBvsi/KImbs01L7ugDnpDvjPCYYqopjlSjFaODIEciF3oq8pkSmUTR9Q/yapJUvUtmZ0EBknHN/RTtbo3MEfwjozScZxgFIiLlkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 3S3MFlAgQteVuZPSWLkeTg==
X-CSE-MsgGUID: v99Aud2VRO+YH+OoIcuPOg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Mar 2025 21:37:16 +0900
Received: from localhost.localdomain (unknown [10.226.92.84])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id EC2CC400618A;
	Mon, 17 Mar 2025 21:37:13 +0900 (JST)
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
Subject: [PATCH v5 13/16] can: rcar_canfd: Add shift table to struct rcar_canfd_hw_info
Date: Mon, 17 Mar 2025 12:36:07 +0000
Message-ID: <20250317123619.70988-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

R-Car Gen3 and Gen4 have some differences in the shift bits. Add a
shift table to handle these differences. After this drop the unused
functions reg_gen4() and is_gen4().

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * Collected tag.
 * Dropped RCANFD_FIRST_RNC_SH and RCANFD_SECOND_RNC_SH by using a
   formula (32 - (n % rnc_per_reg + 1) * rnc_field_width.
v3->v4:
 * Added prefix RCANFD_* to enum rcar_canfd_shift_id.
v3:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 70 ++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index e019e941122f..4ba8e51242d3 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -112,13 +112,16 @@
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
-	(((x) & (gpriv)->info->mask_table[RCANFD_NTSEG2_MASK]) << reg_gen4(gpriv, 25, 24))
+	(((x) & (gpriv)->info->mask_table[RCANFD_NTSEG2_MASK]) << \
+	 (gpriv)->info->shift_table[RCANFD_NTSEG2_SH])
 
 #define RCANFD_NCFG_NTSEG1(gpriv, x) \
-	(((x) & (gpriv)->info->mask_table[RCANFD_NTSEG1_MASK]) << reg_gen4(gpriv, 17, 16))
+	(((x) & (gpriv)->info->mask_table[RCANFD_NTSEG1_MASK]) << \
+	 (gpriv)->info->shift_table[RCANFD_NTSEG1_SH])
 
 #define RCANFD_NCFG_NSJW(gpriv, x) \
-	(((x) & (gpriv)->info->mask_table[RCANFD_NSJW_MASK]) << reg_gen4(gpriv, 10, 11))
+	(((x) & (gpriv)->info->mask_table[RCANFD_NSJW_MASK]) << \
+	 (gpriv)->info->shift_table[RCANFD_NSJW_SH])
 
 #define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
 
@@ -183,10 +186,12 @@
 #define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & (gpriv)->info->mask_table[RCANFD_DSJW_MASK]) << 24)
 
 #define RCANFD_DCFG_DTSEG2(gpriv, x) \
-	(((x) & (gpriv)->info->mask_table[RCANFD_DTSEG2_MASK]) << reg_gen4(gpriv, 16, 20))
+	(((x) & (gpriv)->info->mask_table[RCANFD_DTSEG2_MASK]) << \
+	 (gpriv)->info->shift_table[RCANFD_DTSEG2_SH])
 
 #define RCANFD_DCFG_DTSEG1(gpriv, x) \
-	(((x) & (gpriv)->info->mask_table[RCANFD_DTSEG1_MASK]) << reg_gen4(gpriv, 8, 16))
+	(((x) & (gpriv)->info->mask_table[RCANFD_DTSEG1_MASK]) << \
+	 (gpriv)->info->shift_table[RCANFD_DTSEG1_SH])
 
 #define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
 
@@ -228,10 +233,11 @@
 
 /* RSCFDnCFDCFCCk */
 #define RCANFD_CFCC_CFTML(gpriv, x)	\
-	(((x) & (gpriv)->info->mask_table[RCANFD_CFTML_MASK]) << reg_gen4(gpriv, 16, 20))
-#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
+	(((x) & (gpriv)->info->mask_table[RCANFD_CFTML_MASK]) << \
+	 (gpriv)->info->shift_table[RCANFD_CFTML_SH])
+#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << (gpriv)->info->shift_table[RCANFD_CFM_SH])
 #define RCANFD_CFCC_CFIM		BIT(12)
-#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
+#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << (gpriv)->info->shift_table[RCANFD_CFDC_SH])
 #define RCANFD_CFCC_CFPLS(x)		(((x) & 0x7) << 4)
 #define RCANFD_CFCC_CFTXIE		BIT(2)
 #define RCANFD_CFCC_CFE			BIT(0)
@@ -523,11 +529,23 @@ enum rcar_canfd_mask_id {
 	RCANFD_CFTML_MASK,	/* Common FIFO TX Message Buffer Link */
 };
 
+enum rcar_canfd_shift_id {
+	RCANFD_NTSEG2_SH,	/* Nominal Bit Rate Time Segment 2 Control */
+	RCANFD_NTSEG1_SH,	/* Nominal Bit Rate Time Segment 1 Control */
+	RCANFD_NSJW_SH,		/* Nominal Bit Rate Resynchronization Jump Width Control */
+	RCANFD_DTSEG2_SH,	/* Data Bit Rate Time Segment 2 Control */
+	RCANFD_DTSEG1_SH,	/* Data Bit Rate Time Segment 1 Control */
+	RCANFD_CFTML_SH,	/* Common FIFO TX Message Buffer Link */
+	RCANFD_CFM_SH,		/* Common FIFO Mode */
+	RCANFD_CFDC_SH,		/* Common FIFO Depth Configuration */
+};
+
 struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
 	const u32 *mask_table;
 	const u16 *regs;
+	const u8 *shift_table;
 	u16 num_supported_rules;
 	u8 rnc_field_width;
 	u8 max_channels;
@@ -649,8 +667,31 @@ static const u32 rcar_gen4_mask_table[] = {
 	[RCANFD_CFTML_MASK] = 0x1f,
 };
 
+static const u8 rcar_gen3_shift_table[] = {
+	[RCANFD_NTSEG2_SH] = 24,
+	[RCANFD_NTSEG1_SH] = 16,
+	[RCANFD_NSJW_SH] = 11,
+	[RCANFD_DTSEG2_SH] = 20,
+	[RCANFD_DTSEG1_SH] = 16,
+	[RCANFD_CFTML_SH] = 20,
+	[RCANFD_CFM_SH] = 16,
+	[RCANFD_CFDC_SH] = 8,
+};
+
+static const u8 rcar_gen4_shift_table[] = {
+	[RCANFD_NTSEG2_SH] = 25,
+	[RCANFD_NTSEG1_SH] = 17,
+	[RCANFD_NSJW_SH] = 10,
+	[RCANFD_DTSEG2_SH] = 16,
+	[RCANFD_DTSEG1_SH] = 8,
+	[RCANFD_CFTML_SH] = 16,
+	[RCANFD_CFM_SH] = 8,
+	[RCANFD_CFDC_SH] = 21,
+};
+
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.mask_table = rcar_gen3_mask_table,
+	.shift_table = rcar_gen3_shift_table,
 	.regs = rcar_gen3_regs,
 	.num_supported_rules = 256,
 	.rnc_field_width = 8,
@@ -661,6 +702,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.mask_table = rcar_gen4_mask_table,
+	.shift_table = rcar_gen4_shift_table,
 	.regs = rcar_gen4_regs,
 	.num_supported_rules = 512,
 	.rnc_field_width = 16,
@@ -673,6 +715,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.mask_table = rcar_gen3_mask_table,
+	.shift_table = rcar_gen3_shift_table,
 	.regs = rcar_gen3_regs,
 	.num_supported_rules = 256,
 	.rnc_field_width = 8,
@@ -682,17 +725,6 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 };
 
 /* Helper functions */
-static inline bool is_gen4(struct rcar_canfd_global *gpriv)
-{
-	return gpriv->info == &rcar_gen4_hw_info;
-}
-
-static inline u32 reg_gen4(struct rcar_canfd_global *gpriv,
-			   u32 gen4, u32 not_gen4)
-{
-	return is_gen4(gpriv) ? gen4 : not_gen4;
-}
-
 static inline void rcar_canfd_update(u32 mask, u32 val, u32 __iomem *reg)
 {
 	u32 data = readl(reg);
-- 
2.43.0


