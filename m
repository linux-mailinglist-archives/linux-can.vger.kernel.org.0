Return-Path: <linux-can+bounces-3224-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E097A71692
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 13:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F042170FA9
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 12:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9F61A238D;
	Wed, 26 Mar 2025 12:20:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C410282EB;
	Wed, 26 Mar 2025 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991655; cv=none; b=JRoyfO/sjn2Li7oMGp8d9JR1XVf3quYLjD00XwDH/uk0UexAbjDT/UkXI47BHpO24s6VOCfzimkBG7D06f28LOwWXnCZs7/GM6gc9wX5NlK3+HNAPyBGJJ1eZf+3I2M9o0cLgTOAB9dN9Q3zq/CHqKOmZCEsHkW7XXFko5WZcP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991655; c=relaxed/simple;
	bh=62C5D/L5IjG/dnZyz4XkNie7BGjk/0BGeqfQN53ULNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pt4c16JK9vZKSD9vklnd8EU0LMdqpWXp+5GBnoXH8xBbeKqSXpMdeNTnPiHvjdSDES7EkevaVTGCpVsCyBi5s9E3Ild7pnGdU8KEjeQcYpPlNoUzMaMOjMw4sBdb4wJEdWhXoBRW5AfUPFfymGCM3KHkQ88oMnXr/Xk8Bn8lXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: QNV17cOiT2el0lPB/wp9xg==
X-CSE-MsgGUID: pMEGSn81TVq5H1pDjb+SAg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Mar 2025 21:20:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.116])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DC32240104FA;
	Wed, 26 Mar 2025 21:20:50 +0900 (JST)
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
Subject: [PATCH v7 11/18] can: rcar_canfd: Add {nom,data}_bittiming variables to struct rcar_canfd_hw_info
Date: Wed, 26 Mar 2025 12:19:46 +0000
Message-ID: <20250326122003.122976-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
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
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * Collected tag.
 * Updated 'aswell'->'as well' in commit description.
v6:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 53 ++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index c37fb85fe478..7e7f3c3307ae 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -111,13 +111,13 @@
 
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
 
@@ -179,13 +179,13 @@
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
 
@@ -504,6 +504,8 @@
 struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
+	const struct can_bittiming_const *nom_bittiming;
+	const struct can_bittiming_const *data_bittiming;
 	u16 num_supported_rules;
 	u8 rnc_stride;
 	u8 rnc_field_width;
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
 	.num_supported_rules = 256,
 	.rnc_stride = 4,
 	.rnc_field_width = 8,
@@ -596,6 +624,8 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
 	.num_supported_rules = 512,
 	.rnc_stride = 2,
 	.rnc_field_width = 16,
@@ -607,6 +637,8 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
 	.num_supported_rules = 256,
 	.rnc_stride = 4,
 	.rnc_field_width = 8,
@@ -1795,9 +1827,8 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
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


