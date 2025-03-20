Return-Path: <linux-can+bounces-3173-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B5DA6A233
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 10:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7190A3B17A4
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410FE219A8E;
	Thu, 20 Mar 2025 09:11:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647BC214A97;
	Thu, 20 Mar 2025 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461915; cv=none; b=MlK6Is/C+M0UrTBkJv6ysymMyw3vXUAS9c8O6bld1IElFGjX3PNNTZvu8FKhyjvLK06+soWg2skniJal6tjDvvCEoKkWimpje47iw9e58FKh3yMgUtPQF4Mz0RmLfwMXDfY67WR493ZGIDx7F9KxsLUzU8b8u/UPV4ALY8xC2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461915; c=relaxed/simple;
	bh=cqVRuVpPC9AFPbAtGOKapvbmaLHVZ1rWqPDdp4biIOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7HFzt8361+GeIzhMz+o0bce5u7Hd+jp+dLtO7EZXeJHgz6SozBDk/8tnLCXnXsVGsZtO26W///0c7TSg6kulCFhmy9eZaMf9nvtFHEHAH31iwA7GZKCJg/x467eyDhPPlIOrUrLphnCGeAxlRZ+la0OfhfBpv04q8bXravq7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: vtXTLPPFSDS0Qu2dkQxrSQ==
X-CSE-MsgGUID: vYJ9L0nVQvm+rNYsbp5woQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Mar 2025 18:11:53 +0900
Received: from localhost.localdomain (unknown [10.226.93.24])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 436104001B61;
	Thu, 20 Mar 2025 18:11:50 +0900 (JST)
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
Subject: [PATCH v6 11/18] can: rcar_canfd: Add {nom,data}_bittiming variables to struct rcar_canfd_hw_info
Date: Thu, 20 Mar 2025 09:10:42 +0000
Message-ID: <20250320091101.33637-12-biju.das.jz@bp.renesas.com>
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

Both R-Car Gen4 and R-Car Gen3 have different bit timing parameters
Add {nom,data}_bittiming variables to struct rcar_canfd_hw_info to
handle this difference.

Since the mask used in the macros are max value - 1, replace that
aswell.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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


