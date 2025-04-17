Return-Path: <linux-can+bounces-3433-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D44FA91329
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 07:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D713A6968
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 05:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09621E8348;
	Thu, 17 Apr 2025 05:44:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9421DFD86;
	Thu, 17 Apr 2025 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868697; cv=none; b=RoD14GMg3sWnNY8nwXEa2UT6TqCOXW40rahrKkYTkmLk1to2jXhUwYPBrbVC5r3mkI55vQTSHf3PDspZ/XHyHGT4Wa+Zabyq1cvIN7hqeXR1guYDbFZ57MGBqtdjKfttsu3yNs3Q5QKjZrjy/nMu74ocNoJkUYUraI7tnU7wXuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868697; c=relaxed/simple;
	bh=2e16g4d3Zt2H25dNDHGiVhtGfuzNzAseFelJwaXHsS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gs5i0YyUeXtwSvHkkrG0XCk1hU+bXQdvb8CN5Jx1OyUWBh5rZZGUjBWd2jgwVd48Of3GlYO5jSGXeZi/RxFx6KSY9w/wCqdAQYhwz8I30P1BM0qf2tqfaYSkE86gPlMl3n3Eq3W9cGfT/7dHhdnkzCuZnwdqxlH4zPRo5MC+GYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: n4wjMIxkS42iDBw28h6XKg==
X-CSE-MsgGUID: sibOiuNxRgyWQZOfr5eaGA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 14:44:55 +0900
Received: from localhost.localdomain (unknown [10.226.92.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C96FB44DBA2E;
	Thu, 17 Apr 2025 14:44:50 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	u.kleine-koenig@baylibre.com,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Simon Horman <horms@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v9 16/19] can: rcar_canfd: Add sh variable to struct rcar_canfd_hw_info
Date: Thu, 17 Apr 2025 06:43:17 +0100
Message-ID: <20250417054320.14100-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417054320.14100-1-biju.das.jz@bp.renesas.com>
References: <20250417054320.14100-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

R-Car Gen3 and Gen4 have some differences in the shift bits. Introduce a
struct rcar_canfd_shift_data to hold these values and add the struct
rcar_canfd_shift_data variable sh to struct rcar_canfd_hw_info to handle
these differences. After this, drop the unused functions reg_gen4() and
is_gen4().

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v8->v9:
 * Collected tag..
v7->v8:
 * Updated commit description.
 * Started using struct rcar_canfd_shift_data instead of LUT.
 * Dropped the tag.
v6->v7:
 * No change.
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
 drivers/net/can/rcar/rcar_canfd.c | 64 ++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index fbfe2d6484f1..67f7b5f6376c 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -110,13 +110,13 @@
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 25, 24))
+	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << (gpriv)->info->sh->ntseg2)
 
 #define RCANFD_NCFG_NTSEG1(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 17, 16))
+	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << (gpriv)->info->sh->ntseg1)
 
 #define RCANFD_NCFG_NSJW(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << reg_gen4(gpriv, 10, 11))
+	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << (gpriv)->info->sh->nsjw)
 
 #define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
 
@@ -181,10 +181,10 @@
 #define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & ((gpriv)->info->data_bittiming->sjw_max - 1)) << 24)
 
 #define RCANFD_DCFG_DTSEG2(gpriv, x) \
-	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 16, 20))
+	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << (gpriv)->info->sh->dtseg2)
 
 #define RCANFD_DCFG_DTSEG1(gpriv, x) \
-	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 8, 16))
+	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << (gpriv)->info->sh->dtseg1)
 
 #define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
 
@@ -228,11 +228,11 @@
 #define RCANFD_CFCC_CFTML(gpriv, cftml) \
 ({\
 	typeof(gpriv) (_gpriv) = (gpriv); \
-	(((cftml) & (_gpriv)->info->max_cftml) << reg_gen4(_gpriv, 16, 20)); \
+	(((cftml) & (_gpriv)->info->max_cftml) << (_gpriv)->info->sh->cftml); \
 })
-#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
+#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << (gpriv)->info->sh->cfm)
 #define RCANFD_CFCC_CFIM		BIT(12)
-#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
+#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << (gpriv)->info->sh->cfdc)
 #define RCANFD_CFCC_CFPLS(x)		(((x) & 0x7) << 4)
 #define RCANFD_CFCC_CFTXIE		BIT(2)
 #define RCANFD_CFCC_CFE			BIT(0)
@@ -515,10 +515,22 @@ struct rcar_canfd_regs {
 	u16 cfoffset;	/* Transmit/receive FIFO buffer access ID register */
 };
 
+struct rcar_canfd_shift_data {
+	u8 ntseg2;	/* Nominal Bit Rate Time Segment 2 Control */
+	u8 ntseg1;	/* Nominal Bit Rate Time Segment 1 Control */
+	u8 nsjw;	/* Nominal Bit Rate Resynchronization Jump Width Control */
+	u8 dtseg2;	/* Data Bit Rate Time Segment 2 Control */
+	u8 dtseg1;	/* Data Bit Rate Time Segment 1 Control */
+	u8 cftml;	/* Common FIFO TX Message Buffer Link */
+	u8 cfm;		/* Common FIFO Mode */
+	u8 cfdc;	/* Common FIFO Depth Configuration */
+};
+
 struct rcar_canfd_hw_info {
 	const struct can_bittiming_const *nom_bittiming;
 	const struct can_bittiming_const *data_bittiming;
 	const struct rcar_canfd_regs *regs;
+	const struct rcar_canfd_shift_data *sh;
 	u8 rnc_field_width;
 	u8 max_aflpn;
 	u8 max_cftml;
@@ -643,10 +655,33 @@ static const struct rcar_canfd_regs rcar_gen4_regs = {
 	.cfoffset = 0x6400,
 };
 
+static const struct rcar_canfd_shift_data rcar_gen3_shift_data = {
+	.ntseg2 = 24,
+	.ntseg1 = 16,
+	.nsjw = 11,
+	.dtseg2 = 20,
+	.dtseg1 = 16,
+	.cftml = 20,
+	.cfm = 16,
+	.cfdc = 8,
+};
+
+static const struct rcar_canfd_shift_data rcar_gen4_shift_data = {
+	.ntseg2 = 25,
+	.ntseg1 = 17,
+	.nsjw = 10,
+	.dtseg2 = 16,
+	.dtseg1 = 8,
+	.cftml = 16,
+	.cfm = 8,
+	.cfdc = 21,
+};
+
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
 	.regs = &rcar_gen3_regs,
+	.sh = &rcar_gen3_shift_data,
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
@@ -661,6 +696,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
 	.regs = &rcar_gen4_regs,
+	.sh = &rcar_gen4_shift_data,
 	.rnc_field_width = 16,
 	.max_aflpn = 127,
 	.max_cftml = 31,
@@ -675,6 +711,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
 	.regs = &rcar_gen3_regs,
+	.sh = &rcar_gen3_shift_data,
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
@@ -686,17 +723,6 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
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


