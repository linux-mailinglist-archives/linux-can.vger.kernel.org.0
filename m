Return-Path: <linux-can+bounces-3177-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB13EA6A239
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 10:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF4077A35A8
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 09:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33616215171;
	Thu, 20 Mar 2025 09:12:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E581A238C;
	Thu, 20 Mar 2025 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461929; cv=none; b=h/JRpo0hbmUhyGBk3kgXeOYZPhXx5+vFjzFBICqDSPYOApsKbcp6MmQhX0oEVwSzqCbGsXRuRi4+Ir8mnGLPia8Qoipri2e5JSeLDs+xLlRVo+GbDaiYalPH9PNyoKAK0U3ifZb4AwyDSSknoKL7PC5D1HCLc3Vs2YwHhC8Kk9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461929; c=relaxed/simple;
	bh=wWhs9an/r/o7+tvaz7/p1jmXK1gzOvbXl5W+n0wXkeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ7L1bU65aNYboUvNwEH2M2rWnZ3+X4YlOmcqLRNWcNcIu2OKfkKU91eBHzKk+krUhcU8UHBYxrmmO5Ek335vpbZRMGLHwUBBr4/Wqo4TwspmbxCCGFmf+NBNgZfGfStku/hkfEa5ox+/tGDoW8RK8tsBahT7rSMYqxFesstCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: XE8IO61QSS6QfR/SYUiZxw==
X-CSE-MsgGUID: s3qTMI6YTUGAQ3QZ/fEqag==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Mar 2025 18:12:06 +0900
Received: from localhost.localdomain (unknown [10.226.93.24])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0BCD24005B59;
	Thu, 20 Mar 2025 18:12:03 +0900 (JST)
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
Subject: [PATCH v6 15/18] can: rcar_canfd: Add shift table to struct rcar_canfd_hw_info
Date: Thu, 20 Mar 2025 09:10:46 +0000
Message-ID: <20250320091101.33637-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320091101.33637-1-biju.das.jz@bp.renesas.com>
References: <20250320091101.33637-1-biju.das.jz@bp.renesas.com>
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
v5->v6:
 * No change.
v4->v5:
 * Collected tag.
 * Dropped RCANFD_FIRST_RNC_SH and RCANFD_SECOND_RNC_SH by using a
   formula (32 - (n % rnc_per_reg + 1) * rnc_field_width.
v3->v4:
 * Added prefix RCANFD_* to enum rcar_canfd_shift_id.
v3:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 69 ++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index a96cf499f04b..20e591421cc6 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -111,13 +111,16 @@
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 25, 24))
+	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << \
+	 (gpriv)->info->shift_table[RCANFD_NTSEG2_SH])
 
 #define RCANFD_NCFG_NTSEG1(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 17, 16))
+	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << \
+	 (gpriv)->info->shift_table[RCANFD_NTSEG1_SH])
 
 #define RCANFD_NCFG_NSJW(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << reg_gen4(gpriv, 10, 11))
+	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << \
+	 (gpriv)->info->shift_table[RCANFD_NSJW_SH])
 
 #define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
 
@@ -182,10 +185,12 @@
 #define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & ((gpriv)->info->data_bittiming->sjw_max - 1)) << 24)
 
 #define RCANFD_DCFG_DTSEG2(gpriv, x) \
-	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 16, 20))
+	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << \
+	 (gpriv)->info->shift_table[RCANFD_DTSEG2_SH])
 
 #define RCANFD_DCFG_DTSEG1(gpriv, x) \
-	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 8, 16))
+	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << \
+	 (gpriv)->info->shift_table[RCANFD_DTSEG1_SH])
 
 #define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
 
@@ -227,10 +232,10 @@
 
 /* RSCFDnCFDCFCCk */
 #define RCANFD_CFCC_CFTML(gpriv, x)	\
-	(((x) & (gpriv)->info->max_cftml) << reg_gen4(gpriv, 16, 20))
-#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
+	(((x) & (gpriv)->info->max_cftml) << (gpriv)->info->shift_table[RCANFD_CFTML_SH])
+#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << (gpriv)->info->shift_table[RCANFD_CFM_SH])
 #define RCANFD_CFCC_CFIM		BIT(12)
-#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
+#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << (gpriv)->info->shift_table[RCANFD_CFDC_SH])
 #define RCANFD_CFCC_CFPLS(x)		(((x) & 0x7) << 4)
 #define RCANFD_CFCC_CFTXIE		BIT(2)
 #define RCANFD_CFCC_CFE			BIT(0)
@@ -511,12 +516,24 @@ enum rcar_canfd_reg_offset_id {
 	RCANFD_CFOFFSET,	/* Transmit/receive FIFO buffer access ID register */
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
 	const struct can_bittiming_const *nom_bittiming;
 	const struct can_bittiming_const *data_bittiming;
 	const u16 *regs;
+	const u8 *shift_table;
 	u16 num_supported_rules;
 	u8 rnc_stride;
 	u8 rnc_field_width;
@@ -643,10 +660,33 @@ static const u16 rcar_gen4_regs[] = {
 	[RCANFD_CFOFFSET] = 0x6400,
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
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
 	.regs = rcar_gen3_regs,
+	.shift_table = rcar_gen3_shift_table,
 	.num_supported_rules = 256,
 	.rnc_stride = 4,
 	.rnc_field_width = 8,
@@ -661,6 +701,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
 	.regs = rcar_gen4_regs,
+	.shift_table = rcar_gen4_shift_table,
 	.num_supported_rules = 512,
 	.rnc_stride = 2,
 	.rnc_field_width = 16,
@@ -677,6 +718,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
 	.regs = rcar_gen3_regs,
+	.shift_table = rcar_gen3_shift_table,
 	.num_supported_rules = 256,
 	.rnc_stride = 4,
 	.rnc_field_width = 8,
@@ -688,17 +730,6 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
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


