Return-Path: <linux-can+bounces-3126-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 175DDA64F16
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 13:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52C927A2D39
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EA723959F;
	Mon, 17 Mar 2025 12:36:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EB3238D32;
	Mon, 17 Mar 2025 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215018; cv=none; b=Hy6LELTOX98oJRW5RwYkYbCLESqALAFpcxtOvibFVTknrbOJF9D2JCzKN9poKjYl0VN5YdnWbzYMf6bAbpq1AU1HOgcA0mjOx4Qvm6PyV+FzJ+M34LcXYyDiEavXj7z1W0ZKDKt4dXjXoSYkZD+nEbcbZVnac7mJmCYDo7kCop0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215018; c=relaxed/simple;
	bh=8NDATBTqucGSrLm2zWU1yepxdtkdhWZ9GJaKLPAtz4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioIQ6ALCS1OAAQ7OAcSTDyMewHszq77TmLkz0+a5DR9lHfuiSUHFP+rjPCJvVJM8gVSJwmATvgikwHiy24Cox86V2oox1UJOvsgHET/xapr3WbGzoY2MeNwHn/9cV7gtlRS/eerlYkedD+BvJTBIyg34AFeP0sH77fwr9z0Ef3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: lInGvbcUQ/mO3JgrzaUqdw==
X-CSE-MsgGUID: knhl0fruQK6SBTH8oMiiZA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Mar 2025 21:36:56 +0900
Received: from localhost.localdomain (unknown [10.226.92.84])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 625684000FBD;
	Mon, 17 Mar 2025 21:36:53 +0900 (JST)
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
Subject: [PATCH v5 07/16] can: rcar_canfd: Add rnc_field_width variable to struct rcar_canfd_hw_info
Date: Mon, 17 Mar 2025 12:36:01 +0000
Message-ID: <20250317123619.70988-8-biju.das.jz@bp.renesas.com>
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

R-Car Gen4 packs 2 RNC values in a 32-bit word, whereas R-Car Gen3 packs
up to 4 values in a 32-bit word. Handle this difference by adding
rnc_field_width variable to struct rcar_canfd_hw_info and update the macro
RCANFD_GAFLCFG.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 32d700962d69..924a116cd9ab 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -85,6 +85,7 @@
 		((gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0)))
 
 /* AFL Rx rules registers */
+#define RCANFD_RNC_PER_REG(gpriv)	(32 / (gpriv)->info->rnc_field_width)
 
 /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
 #define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
@@ -291,7 +292,7 @@
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR			(0x0098)
 /* RSCFDnCFDGAFLCFG / RSCFDnGAFLCFG */
-#define RCANFD_GAFLCFG(ch)		(0x009c + (0x04 * ((ch) / 2)))
+#define RCANFD_GAFLCFG(gpriv, ch)	(0x009c + (0x04 * ((ch) / RCANFD_RNC_PER_REG(gpriv))))
 /* RSCFDnCFDRMNB / RSCFDnRMNB */
 #define RCANFD_RMNB			(0x00a4)
 /* RSCFDnCFDRMND / RSCFDnRMND */
@@ -505,6 +506,7 @@ struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
 	u16 num_supported_rules;
+	u8 rnc_field_width;
 	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
@@ -582,6 +584,7 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.num_supported_rules = 256,
+	.rnc_field_width = 8,
 	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -589,6 +592,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.num_supported_rules = 512,
+	.rnc_field_width = 16,
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -596,6 +600,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.num_supported_rules = 256,
+	.rnc_field_width = 8,
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
@@ -797,7 +802,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 			    RCANFD_GAFLECTR_AFLDAE));
 
 	/* Write number of rules for channel */
-	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch),
+	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(gpriv, ch),
 			   RCANFD_GAFLCFG_SETRNC(gpriv, ch, num_rules));
 	if (is_gen4(gpriv))
 		offset = RCANFD_GEN4_GAFL_OFFSET;
-- 
2.43.0


