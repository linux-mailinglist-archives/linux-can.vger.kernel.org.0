Return-Path: <linux-can+bounces-3010-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 992FEA54B13
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 13:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFAFE7A77AF
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C15120B1F3;
	Thu,  6 Mar 2025 12:43:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654231C7017;
	Thu,  6 Mar 2025 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265017; cv=none; b=L4B1yelEBzzVUGCKW9/LinQ8BH5JEwyHpQpSwdauiWZQo8hn9u/cEJWHYNbWfhAkMLAA0HUGfFkjNKfWuBebXF9Pwmr7wYtI5hp/TVsqd0H8uQAZci76jaqC06p7d/GZrdHslxgcBs5d2C8/95x34lLVyko7QqDgQ2XZdGaS7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265017; c=relaxed/simple;
	bh=B1jMQ0ZOXuUlElRPVEM1aFFZEzhpyUKC6X56sAIafj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgNt43Ldhwt7cTS7E1DR9fsEYMrPyNfu/Mpja+eCdi1Hrvk7hUJD38N7/uWBLpXYYbl2lD2bUlDOfG4JscQLoISS2liYfm8fZUcB9NR+5rHczgCoq5bc9+4ocSaFLp8rk00C/xVAlaUOanzK1QaMmBWs85nE1GrFkr+NfaY39P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: D6urN829Tp2LFKSS+cjVMg==
X-CSE-MsgGUID: n6weUaEESlSrQVKjcywrzw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Mar 2025 21:43:35 +0900
Received: from localhost.localdomain (unknown [10.226.92.10])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3D3B74281B0F;
	Thu,  6 Mar 2025 21:43:31 +0900 (JST)
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
Subject: [PATCH v4 08/11] can: rcar_canfd: Add shift table to struct rcar_canfd_hw_info
Date: Thu,  6 Mar 2025 12:42:47 +0000
Message-ID: <20250306124256.93033-9-biju.das.jz@bp.renesas.com>
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

R-Car Gen3 and Gen4 has some differences in the shift bits. Add a
shift table to handle these differences. After this drop the unused
functions reg_gen4() and is_gen4().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Added prefix RCANFD_* to enum rcar_canfd_shift_id.
v3:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 84 +++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index dd9d73b37d02..f84b88ccb1de 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -90,11 +90,13 @@
 /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
 #define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
 	(((x) & (gpriv)->info->mask_table[RCANFD_RNC_MASK]) << \
-	 (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
+	 ((gpriv)->info->shift_table[RCANFD_FIRST_RNC_SH] - ((n) & 1) * \
+	  (gpriv)->info->shift_table[RCANFD_SECOND_RNC_SH]))
 
 #define RCANFD_GAFLCFG_GETRNC(gpriv, n, x) \
-	(((x) >> (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8))) & \
-	 (gpriv)->info->mask_table[RCANFD_RNC_MASK])
+	(((x) >> ((gpriv)->info->shift_table[RCANFD_FIRST_RNC_SH] - ((n) & 1) * \
+		  (gpriv)->info->shift_table[RCANFD_SECOND_RNC_SH])) & \
+		  (gpriv)->info->mask_table[RCANFD_RNC_MASK])
 
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
@@ -117,13 +119,16 @@
 
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
 
@@ -188,10 +193,12 @@
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
 
@@ -233,10 +240,11 @@
 
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
@@ -530,11 +538,25 @@ enum rcar_canfd_mask_id {
 	RCANFD_CFTML_MASK,	/* Common FIFO TX Message Buffer Link */
 };
 
+enum rcar_canfd_shift_id {
+	RCANFD_FIRST_RNC_SH,	/* Rule Number for Channel x */
+	RCANFD_SECOND_RNC_SH,	/* Rule Number for Channel x + 1 */
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
 	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
@@ -658,8 +680,35 @@ static const u32 rcar_gen4_mask_table[] = {
 	[RCANFD_CFTML_MASK] = 0x1f,
 };
 
+static const u8 rcar_gen3_shift_table[] = {
+	[RCANFD_FIRST_RNC_SH] = 24,
+	[RCANFD_SECOND_RNC_SH] = 8,
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
+	[RCANFD_FIRST_RNC_SH] = 16,
+	[RCANFD_SECOND_RNC_SH] = 16,
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
 	.max_channels = 2,
 	.postdiv = 2,
@@ -668,6 +717,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.mask_table = rcar_gen4_mask_table,
+	.shift_table = rcar_gen4_shift_table,
 	.regs = rcar_gen4_regs,
 	.max_channels = 8,
 	.postdiv = 2,
@@ -678,6 +728,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.mask_table = rcar_gen3_mask_table,
+	.shift_table = rcar_gen3_shift_table,
 	.regs = rcar_gen3_regs,
 	.max_channels = 2,
 	.postdiv = 1,
@@ -685,17 +736,6 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
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


