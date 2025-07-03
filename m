Return-Path: <linux-can+bounces-3944-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC480AF8029
	for <lists+linux-can@lfdr.de>; Thu,  3 Jul 2025 20:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09CF6E1893
	for <lists+linux-can@lfdr.de>; Thu,  3 Jul 2025 18:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBFF2F3C1D;
	Thu,  3 Jul 2025 18:34:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AC02F3642;
	Thu,  3 Jul 2025 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567672; cv=none; b=NqcwXKSVPYNg4+3RWxxD5HUadBK/yKL214hPrhTLkyevuWcQ4Ll+vNQiaDfi/fHHLFQ4g3DlXYOJeMo6J+NoKxJSlLYtQjFkmBJOa+jldf3nP5A9XgzfoG892K5OrGGdOjO+xy2WyrnnLEcEDEn/oVp44l8xnOByvk7qijuvo+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567672; c=relaxed/simple;
	bh=enB6xdyzQt0K45AZvlEkNlpG5oBCVCg9hDk367egnUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJwjrnoBcD5bzRnHKNvPKUdu5U59hy7Gp5GmWTduPyrj4YdCKuUBmLu/L0AGJfvNzhtSBZ3a+W/tTRdEqx/kr73p/d7aPKKIL983oD0+1bTmh0bbFTOohq9uycjpnhK+Nu+7XB1u2FTIhM9yvu+WGNnUEFcxusdqQApkFA1K3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: FwpyXaTdQ02/Hfrcp9NBjA==
X-CSE-MsgGUID: hEcYzn7mTzqGFBBUjzJKFQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Jul 2025 03:34:27 +0900
Received: from localhost.localdomain (unknown [10.226.92.64])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D3CFE401D165;
	Fri,  4 Jul 2025 03:34:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 3/4] can: rcar_canfd: Replace RCANFD_NCFG_* and RCANFD_DCFG_* macros
Date: Thu,  3 Jul 2025 19:34:01 +0100
Message-ID: <20250703183411.332828-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703183411.332828-1-biju.das.jz@bp.renesas.com>
References: <20250703183411.332828-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace RCANFD_NCFG_* and RCANFD_DCFG_* macros with functions for
simplifying the computation of configuration register.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 57 +++++++++++++++----------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index ce355f79e6b6..b5b059e83374 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -108,18 +108,6 @@
 #define RCANFD_CFG_TSEG1(x)		(((x) & 0xf) << 16)
 #define RCANFD_CFG_BRP(x)		(((x) & 0x3ff) << 0)
 
-/* RSCFDnCFDCmNCFG - CAN FD only */
-#define RCANFD_NCFG_NTSEG2(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << (gpriv)->info->sh->ntseg2)
-
-#define RCANFD_NCFG_NTSEG1(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << (gpriv)->info->sh->ntseg1)
-
-#define RCANFD_NCFG_NSJW(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << (gpriv)->info->sh->nsjw)
-
-#define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
-
 /* RSCFDnCFDCmCTR / RSCFDnCmCTR */
 #define RCANFD_CCTR_CTME		BIT(24)
 #define RCANFD_CCTR_ERRD		BIT(23)
@@ -177,17 +165,6 @@
 
 #define RCANFD_CERFL_ERR(x)		((x) & (0x7fff)) /* above bits 14:0 */
 
-/* RSCFDnCFDCmDCFG */
-#define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & ((gpriv)->info->data_bittiming->sjw_max - 1)) << 24)
-
-#define RCANFD_DCFG_DTSEG2(gpriv, x) \
-	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << (gpriv)->info->sh->dtseg2)
-
-#define RCANFD_DCFG_DTSEG1(gpriv, x) \
-	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << (gpriv)->info->sh->dtseg1)
-
-#define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
-
 /* RSCFDnCFDCmFDCFG */
 #define RCANFD_GEN4_FDCFG_CLOE		BIT(30)
 #define RCANFD_GEN4_FDCFG_FDOE		BIT(28)
@@ -736,6 +713,32 @@ static void rcar_canfd_update_bit_reg(void __iomem *addr, u32 mask, u32 val)
 	rcar_canfd_update(mask, val, addr);
 }
 
+static inline u32 rcar_canfd_compute_nominal_bit_rate_cfg(const struct rcar_canfd_hw_info *info,
+							  u16 tseg1, u16 brp, u16 sjw, u16 tseg2)
+{
+	u32 ntseg2, ntseg1, nsjw, nbrp;
+
+	ntseg2 = (tseg2 & (info->nom_bittiming->tseg2_max - 1)) << info->sh->ntseg2;
+	ntseg1 = (tseg1 & (info->nom_bittiming->tseg1_max - 1)) << info->sh->ntseg1;
+	nsjw = (sjw & (info->nom_bittiming->sjw_max - 1)) << info->sh->nsjw;
+	nbrp = brp & GENMASK(9, 0);
+
+	return (ntseg1 | nbrp | nsjw | ntseg2);
+}
+
+static inline u32 rcar_canfd_compute_data_bit_rate_cfg(const struct rcar_canfd_hw_info *info,
+						       u16 tseg1, u16 brp, u16 sjw, u16 tseg2)
+{
+	u32 dtseg2, dtseg1, dsjw, dbrp;
+
+	dtseg2 = (tseg2 & (info->data_bittiming->tseg2_max - 1)) << info->sh->dtseg2;
+	dtseg1 = (tseg1 & (info->data_bittiming->tseg1_max - 1)) << info->sh->dtseg1;
+	dsjw = (sjw & (info->data_bittiming->sjw_max - 1)) << 24;
+	dbrp = brp & GENMASK(7, 0);
+
+	return (dtseg1 | dbrp | dsjw | dtseg2);
+}
+
 static void rcar_canfd_get_data(struct rcar_canfd_channel *priv,
 				struct canfd_frame *cf, u32 off)
 {
@@ -1413,8 +1416,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	tseg2 = bt->phase_seg2 - 1;
 
 	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
-		cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) | RCANFD_NCFG_NBRP(brp) |
-		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
+		cfg = rcar_canfd_compute_nominal_bit_rate_cfg(gpriv->info, tseg1, brp, sjw, tseg2);
 	} else {
 		cfg = (RCANFD_CFG_TSEG1(tseg1) | RCANFD_CFG_BRP(brp) |
 		       RCANFD_CFG_SJW(sjw) | RCANFD_CFG_TSEG2(tseg2));
@@ -1430,10 +1432,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	sjw = dbt->sjw - 1;
 	tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
 	tseg2 = dbt->phase_seg2 - 1;
-
-	cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
-	       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
-
+	cfg = rcar_canfd_compute_data_bit_rate_cfg(gpriv->info, tseg1, brp, sjw, tseg2);
 	writel(cfg, &gpriv->fcbase[ch].dcfg);
 
 	/* Transceiver Delay Compensation */
-- 
2.43.0


