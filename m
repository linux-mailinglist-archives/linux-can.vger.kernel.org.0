Return-Path: <linux-can+bounces-2960-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ABBA444B6
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 16:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F343BF1D8
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 15:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5237E156F3A;
	Tue, 25 Feb 2025 15:41:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60432156677;
	Tue, 25 Feb 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498099; cv=none; b=osa5VwHvvDDfA1trwi5Fc9ybty1Y90xRwU73q8jybiugYnGzpao32cCqBsuiUI+Ja3rQCldFgqKLZQcjG/xeTuBPnTpeJrXFSV0CtskxlP6fHa57uwdcUUyKVHBL8J+ounZupReOrhg5R8nbczYkmFXV67GRPfwVmcAZID6Zoao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498099; c=relaxed/simple;
	bh=rQQwaJB6gdYV+odV6nITgaVljTBm4bLDn+ey+A7SQRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLUnExi+PQsAqFIQF/e2b2bDcQODqQ4y5+FxeeiDYklqP9/8iqobAEtQGErLvHO6fVoIw9VyPWE0g+itNGjzSWfkDrhio8Rf9avaxlT1y6/k40/DeC64X24d0RXLD1fcmxcJtxhC8XHtBC3hcMFIxk/+jRZF3yEzBGos0X4Lep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: gXhwBeRdSqus1aSNnFpB3Q==
X-CSE-MsgGUID: 6yv3LkaBTsWjcN6tMDa2Lg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Feb 2025 00:41:37 +0900
Received: from localhost.localdomain (unknown [10.226.92.81])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 29E37400FC34;
	Wed, 26 Feb 2025 00:41:33 +0900 (JST)
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
Subject: [PATCH v3 08/11] can: rcar_canfd: Add shift table to struct rcar_canfd_hw_info
Date: Tue, 25 Feb 2025 15:40:47 +0000
Message-ID: <20250225154058.59116-9-biju.das.jz@bp.renesas.com>
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

R-Car Gen3 and Gen4 has some differences in the shift bits. Add a
shift table to handle these differences. After this drop the unused
functions reg_gen4() and is_gen4().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 78 ++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index fcf5cb93f57c..09a9e548b022 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -90,11 +90,13 @@
 /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
 #define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
 	(((x) & (gpriv)->info->mask_table[RNC_MASK_ID]) << \
-	 (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
+	 ((gpriv)->info->shift_table[FIRST_RNC_SH] - ((n) & 1) * \
+	  (gpriv)->info->shift_table[SECOND_RNC_SH]))
 
 #define RCANFD_GAFLCFG_GETRNC(gpriv, n, x) \
-	(((x) >> (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8))) & \
-	 (gpriv)->info->mask_table[RNC_MASK_ID])
+	(((x) >> ((gpriv)->info->shift_table[FIRST_RNC_SH] - ((n) & 1) * \
+		  (gpriv)->info->shift_table[SECOND_RNC_SH])) & \
+		  (gpriv)->info->mask_table[RNC_MASK_ID])
 
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
@@ -117,13 +119,13 @@
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
-	(((x) & (gpriv)->info->mask_table[NTSEG2_MASK_ID]) << reg_gen4(gpriv, 25, 24))
+	(((x) & (gpriv)->info->mask_table[NTSEG2_MASK_ID]) << (gpriv)->info->shift_table[NTSEG2_SH])
 
 #define RCANFD_NCFG_NTSEG1(gpriv, x) \
-	(((x) & (gpriv)->info->mask_table[NTSEG1_MASK_ID]) << reg_gen4(gpriv, 17, 16))
+	(((x) & (gpriv)->info->mask_table[NTSEG1_MASK_ID]) << (gpriv)->info->shift_table[NTSEG1_SH])
 
 #define RCANFD_NCFG_NSJW(gpriv, x) \
-	(((x) & (gpriv)->info->mask_table[NSJW_MASK_ID]) << reg_gen4(gpriv, 10, 11))
+	(((x) & (gpriv)->info->mask_table[NSJW_MASK_ID]) << (gpriv)->info->shift_table[NSJW_SH])
 
 #define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
 
@@ -188,10 +190,10 @@
 #define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & (gpriv)->info->mask_table[DSJW_MASK_ID]) << 24)
 
 #define RCANFD_DCFG_DTSEG2(gpriv, x) \
-	(((x) & (gpriv)->info->mask_table[DTSEG2_MASK_ID]) << reg_gen4(gpriv, 16, 20))
+	(((x) & (gpriv)->info->mask_table[DTSEG2_MASK_ID]) << (gpriv)->info->shift_table[DTSEG2_SH])
 
 #define RCANFD_DCFG_DTSEG1(gpriv, x) \
-	(((x) & (gpriv)->info->mask_table[DTSEG1_MASK_ID]) << reg_gen4(gpriv, 8, 16))
+	(((x) & (gpriv)->info->mask_table[DTSEG1_MASK_ID]) << (gpriv)->info->shift_table[DTSEG1_SH])
 
 #define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
 
@@ -233,10 +235,10 @@
 
 /* RSCFDnCFDCFCCk */
 #define RCANFD_CFCC_CFTML(gpriv, x)	\
-	(((x) & (gpriv)->info->mask_table[CFTML_MASK_ID]) << reg_gen4(gpriv, 16, 20))
-#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
+	(((x) & (gpriv)->info->mask_table[CFTML_MASK_ID]) << (gpriv)->info->shift_table[CFTML_SH])
+#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << (gpriv)->info->shift_table[CFM_SH])
 #define RCANFD_CFCC_CFIM		BIT(12)
-#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
+#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << (gpriv)->info->shift_table[CFDC_SH])
 #define RCANFD_CFCC_CFPLS(x)		(((x) & 0x7) << 4)
 #define RCANFD_CFCC_CFTXIE		BIT(2)
 #define RCANFD_CFCC_CFE			BIT(0)
@@ -530,11 +532,25 @@ enum rcar_canfd_mask_id {
 	CFTML_MASK_ID,	/* Common FIFO TX Message Buffer Link */
 };
 
+enum rcar_canfd_shift_id {
+	FIRST_RNC_SH,	/* Rule Number for Channel x */
+	SECOND_RNC_SH,	/* Rule Number for Channel x + 1 */
+	NTSEG2_SH,	/* Nominal Bit Rate Time Segment 2 Control */
+	NTSEG1_SH,	/* Nominal Bit Rate Time Segment 1 Control */
+	NSJW_SH,	/* Nominal Bit Rate Resynchronization Jump Width Control */
+	DTSEG2_SH,	/* Data Bit Rate Time Segment 2 Control */
+	DTSEG1_SH,	/* Data Bit Rate Time Segment 1 Control */
+	CFTML_SH,	/* Common FIFO TX Message Buffer Link */
+	CFM_SH,		/* Common FIFO Mode */
+	CFDC_SH,	/* Common FIFO Depth Configuration */
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
@@ -658,8 +674,35 @@ static const u32 rcar_gen4_mask_table[] = {
 	[CFTML_MASK_ID] = 0x1f,
 };
 
+static const u8 rcar_gen3_shift_table[] = {
+	[FIRST_RNC_SH] = 24,
+	[SECOND_RNC_SH] = 8,
+	[NTSEG2_SH] = 24,
+	[NTSEG1_SH] = 16,
+	[NSJW_SH] = 11,
+	[DTSEG2_SH] = 20,
+	[DTSEG1_SH] = 16,
+	[CFTML_SH] = 20,
+	[CFM_SH] = 16,
+	[CFDC_SH] = 8,
+};
+
+static const u8 rcar_gen4_shift_table[] = {
+	[FIRST_RNC_SH] = 16,
+	[SECOND_RNC_SH] = 16,
+	[NTSEG2_SH] = 25,
+	[NTSEG1_SH] = 17,
+	[NSJW_SH] = 10,
+	[DTSEG2_SH] = 16,
+	[DTSEG1_SH] = 8,
+	[CFTML_SH] = 16,
+	[CFM_SH] = 8,
+	[CFDC_SH] = 21,
+};
+
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.mask_table = rcar_gen3_mask_table,
+	.shift_table = rcar_gen3_shift_table,
 	.regs = rcar_gen3_regs,
 	.max_channels = 2,
 	.postdiv = 2,
@@ -668,6 +711,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.mask_table = rcar_gen4_mask_table,
+	.shift_table = rcar_gen4_shift_table,
 	.regs = rcar_gen4_regs,
 	.max_channels = 8,
 	.postdiv = 2,
@@ -678,6 +722,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.mask_table = rcar_gen3_mask_table,
+	.shift_table = rcar_gen3_shift_table,
 	.regs = rcar_gen3_regs,
 	.max_channels = 2,
 	.postdiv = 1,
@@ -685,17 +730,6 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
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


