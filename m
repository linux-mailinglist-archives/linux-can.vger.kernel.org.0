Return-Path: <linux-can+bounces-3429-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EA6A91319
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 07:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2480188BB6C
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 05:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6981E32C6;
	Thu, 17 Apr 2025 05:44:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7EB1DE2DB;
	Thu, 17 Apr 2025 05:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868677; cv=none; b=I/nYrtTkGqJc8Zmoijbt6ecRNMkPQdb5t9OnCkXjZ4Pa6iE5mYE6o4fNGiJhtHU4UmKRI1urduLAI8OUVCvFE6NUhK4djJiBGtxKKm1nXQGqa32eALe2s123EUjVPwIJyp15h8uXk27FO6ZgOHUjcqLrxJXUOhB9FnDuWBLUFMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868677; c=relaxed/simple;
	bh=PPP6fGiugWnwulhQcyC/jPxa9CkJZPyDWCm7aR5YCac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXqUxoopLqqVZxFWaiklVy2lSjzzv09HMZlHtcyBlFCmLC/1TPfV6ntnPSoav7gxP8KGjDdPoR3P7tv96U6Bu9Zyuz+GOEnh+9OarZwtLWCjP65lwvRUmDcKqQ/MeYjx9kIlllkGjhxp5ysuS4iHvKIiynPgLa0BLMXtu0+lmcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 4QMsgL4gQPuIs1VGYDA9hg==
X-CSE-MsgGUID: MKD4a88RQ3m7XrSWYuyJSQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 14:44:34 +0900
Received: from localhost.localdomain (unknown [10.226.92.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B4B1340373CF;
	Thu, 17 Apr 2025 14:44:29 +0900 (JST)
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
Subject: [PATCH v9 12/19] can: rcar_canfd: Add {nom,data}_bittiming variables to struct rcar_canfd_hw_info
Date: Thu, 17 Apr 2025 06:43:13 +0100
Message-ID: <20250417054320.14100-13-biju.das.jz@bp.renesas.com>
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

Both R-Car Gen4 and R-Car Gen3 have different bit timing parameters
Add {nom,data}_bittiming variables to struct rcar_canfd_hw_info to
handle this difference.

Since the mask used in the macros are max value - 1, replace that
as well.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v8->v9:
 * No change.
v7->v8:
 * Collected tag.
v6->v7:
 * Collected tag.
 * Updated 'aswell'->'as well' in commit description.
v6:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 53 ++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 5465fa897223..d8380f38cdde 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -110,13 +110,13 @@
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x7f, 0x1f)) << reg_gen4(gpriv, 25, 24))
+	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 25, 24))
 
 #define RCANFD_NCFG_NTSEG1(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0xff, 0x7f)) << reg_gen4(gpriv, 17, 16))
+	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 17, 16))
 
 #define RCANFD_NCFG_NSJW(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x7f, 0x1f)) << reg_gen4(gpriv, 10, 11))
+	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << reg_gen4(gpriv, 10, 11))
 
 #define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
 
@@ -178,13 +178,13 @@
 #define RCANFD_CERFL_ERR(x)		((x) & (0x7fff)) /* above bits 14:0 */
 
 /* RSCFDnCFDCmDCFG */
-#define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & reg_gen4(gpriv, 0xf, 0x7)) << 24)
+#define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & ((gpriv)->info->data_bittiming->sjw_max - 1)) << 24)
 
 #define RCANFD_DCFG_DTSEG2(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x0f, 0x7)) << reg_gen4(gpriv, 16, 20))
+	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 16, 20))
 
 #define RCANFD_DCFG_DTSEG1(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x1f, 0xf)) << reg_gen4(gpriv, 8, 16))
+	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 8, 16))
 
 #define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
 
@@ -506,6 +506,8 @@
 struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
+	const struct can_bittiming_const *nom_bittiming;
+	const struct can_bittiming_const *data_bittiming;
 	u8 rnc_field_width;
 	u8 max_aflpn;
 	u8 max_cftml;
@@ -546,7 +548,7 @@ struct rcar_canfd_global {
 };
 
 /* CAN FD mode nominal rate constants */
-static const struct can_bittiming_const rcar_canfd_nom_bittiming_const = {
+static const struct can_bittiming_const rcar_canfd_gen3_nom_bittiming_const = {
 	.name = RCANFD_DRV_NAME,
 	.tseg1_min = 2,
 	.tseg1_max = 128,
@@ -558,8 +560,20 @@ static const struct can_bittiming_const rcar_canfd_nom_bittiming_const = {
 	.brp_inc = 1,
 };
 
+static const struct can_bittiming_const rcar_canfd_gen4_nom_bittiming_const = {
+	.name = RCANFD_DRV_NAME,
+	.tseg1_min = 2,
+	.tseg1_max = 256,
+	.tseg2_min = 2,
+	.tseg2_max = 128,
+	.sjw_max = 128,
+	.brp_min = 1,
+	.brp_max = 1024,
+	.brp_inc = 1,
+};
+
 /* CAN FD mode data rate constants */
-static const struct can_bittiming_const rcar_canfd_data_bittiming_const = {
+static const struct can_bittiming_const rcar_canfd_gen3_data_bittiming_const = {
 	.name = RCANFD_DRV_NAME,
 	.tseg1_min = 2,
 	.tseg1_max = 16,
@@ -571,6 +585,18 @@ static const struct can_bittiming_const rcar_canfd_data_bittiming_const = {
 	.brp_inc = 1,
 };
 
+static const struct can_bittiming_const rcar_canfd_gen4_data_bittiming_const = {
+	.name = RCANFD_DRV_NAME,
+	.tseg1_min = 2,
+	.tseg1_max = 32,
+	.tseg2_min = 2,
+	.tseg2_max = 16,
+	.sjw_max = 16,
+	.brp_min = 1,
+	.brp_max = 256,
+	.brp_inc = 1,
+};
+
 /* Classical CAN mode bitrate constants */
 static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 	.name = RCANFD_DRV_NAME,
@@ -585,6 +611,8 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 };
 
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
@@ -594,6 +622,8 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
 	.rnc_field_width = 16,
 	.max_aflpn = 127,
 	.max_cftml = 31,
@@ -603,6 +633,8 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
@@ -1799,9 +1831,8 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	}
 
 	if (gpriv->fdmode) {
-		priv->can.bittiming_const = &rcar_canfd_nom_bittiming_const;
-		priv->can.data_bittiming_const =
-			&rcar_canfd_data_bittiming_const;
+		priv->can.bittiming_const = gpriv->info->nom_bittiming;
+		priv->can.data_bittiming_const = gpriv->info->data_bittiming;
 
 		/* Controller starts in CAN FD only mode */
 		err = can_set_static_ctrlmode(ndev, CAN_CTRLMODE_FD);
-- 
2.43.0


