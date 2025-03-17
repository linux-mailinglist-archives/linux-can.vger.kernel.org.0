Return-Path: <linux-can+bounces-3131-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6963A64F22
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 13:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9248F3AC184
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 12:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A152D238D32;
	Mon, 17 Mar 2025 12:37:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20DC23A9BE;
	Mon, 17 Mar 2025 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215035; cv=none; b=nZ7J7vUpbH05iav9lu3hM9jvbcDDt5vaU1ZRCeLQjl/JAOvoEHNEKojcBv+HeZkj5DxzwNao7qt7dEpSBXiMNjTKLCggbHg6nKy5VRe0rYeZaSLTbQUCi14fDkAQaOr05dZgisdJndhnl6fr4SU40nqMxSa1azfmMO9U/AfuLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215035; c=relaxed/simple;
	bh=Nv5+0cns8vTbgbBpI16yIxPCqsnU4zDlSeB/+jwwAAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQc5KKYWBfjfbFIJwVOyLef19nHLNlc8WumifR8/Rs7mi3fhscJnt3qzQcVmkm9CEIo46BSXIQMWJOfsKYosEI2qhHzETej3/0p/gvFJTZ8EXh5NSh9KIcZnIAQLjphNUIGHWkWNCCCDtnYKQMQk/1uTlfnYNMXoKRQteUdyGU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: zh6hy9PzTPysaNE3X6z2jQ==
X-CSE-MsgGUID: 4AZ3iS+2TcK/0+ta0lH7tg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Mar 2025 21:37:13 +0900
Received: from localhost.localdomain (unknown [10.226.92.84])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 86555400618A;
	Mon, 17 Mar 2025 21:37:10 +0900 (JST)
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
Subject: [PATCH v5 12/16] can: rcar_canfd: Add mask table to struct rcar_canfd_hw_info
Date: Mon, 17 Mar 2025 12:36:06 +0000
Message-ID: <20250317123619.70988-13-biju.das.jz@bp.renesas.com>
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

R-Car Gen3 and Gen4 have some differences in the mask bits. Add a
mask table to handle these differences.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * Improved commit description by replacing has->have.
 * Collected tag.
 * Dropped RCANFD_EEF_MASK and RCANFD_RNC_MASK as it is taken
   care by gpriv->channels_mask and info->num_supported_rules.
v3->v4:
 * Added prefix RCANFD_* to enum rcar_canfd_mask_id.
v3:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 53 ++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 1ba79f424fb3..e019e941122f 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -94,7 +94,7 @@
 
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
-#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))
+#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & (gpriv)->info->mask_table[RCANFD_AFLPN_MASK])
 
 /* RSCFDnCFDGAFLIDj / RSCFDnGAFLIDj */
 #define RCANFD_GAFLID_GAFLLB		BIT(29)
@@ -112,13 +112,13 @@
 
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
 
@@ -180,13 +180,13 @@
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
 
@@ -228,7 +228,7 @@
 
 /* RSCFDnCFDCFCCk */
 #define RCANFD_CFCC_CFTML(gpriv, x)	\
-	(((x) & reg_gen4(gpriv, 0x1f, 0xf)) << reg_gen4(gpriv, 16, 20))
+	(((x) & (gpriv)->info->mask_table[RCANFD_CFTML_MASK]) << reg_gen4(gpriv, 16, 20))
 #define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
 #define RCANFD_CFCC_CFIM		BIT(12)
 #define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
@@ -512,9 +512,21 @@ enum rcar_canfd_reg_offset_id {
 	RCANFD_CFOFFSET,	/* Transmit/receive FIFO buffer access ID register */
 };
 
+enum rcar_canfd_mask_id {
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
 	u16 num_supported_rules;
 	u8 rnc_field_width;
@@ -615,7 +627,30 @@ static const u16 rcar_gen4_regs[] = {
 	[RCANFD_CFOFFSET] = 0x6400,
 };
 
+static const u32 rcar_gen3_mask_table[] = {
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
 	.num_supported_rules = 256,
 	.rnc_field_width = 8,
@@ -625,6 +660,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
+	.mask_table = rcar_gen4_mask_table,
 	.regs = rcar_gen4_regs,
 	.num_supported_rules = 512,
 	.rnc_field_width = 16,
@@ -636,6 +672,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
+	.mask_table = rcar_gen3_mask_table,
 	.regs = rcar_gen3_regs,
 	.num_supported_rules = 256,
 	.rnc_field_width = 8,
-- 
2.43.0


