Return-Path: <linux-can+bounces-3340-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F7EA78C1E
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 12:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFEA18946BD
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 10:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359A053BE;
	Wed,  2 Apr 2025 10:23:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C35235BE8;
	Wed,  2 Apr 2025 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589391; cv=none; b=UGY6x/1DCOWgd9Ymv9DRIyyzlwEaTFLd4WLWeckocxKLcGsynv++btLWTzh8wtokSCR+38s/pf8l0BcTRwYmSh6gzWvwcMufdBqxyNw1U8DFZH1qWHGsByWmyR32LM33isN3UflxTEgqk7amuym8htEz9or2tIXUz/KmMRbC8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589391; c=relaxed/simple;
	bh=jtKsdUUKlIcdKd2BpXwIhgD6VAFFUTq0Rrd+HKolDM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZilqi9CumvVrxRJCbjd2bpoIknLAU1ITXPR8RdrUzGMwhJTuUTSDdKfB8SgVicOMfkN23blUHfHCFqVpphlBkeNtTsyEhhUhusrE1RNEKpmtH7z2Co8E033g6Tq0OZWOHqx8FJq51AJDSIivFmHBB6i3s/BoaDnueONbesfLRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: CY9UB0rwTu28wRfGrB4XfA==
X-CSE-MsgGUID: 6binXyi5QPGMbY+vsjnOjg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2025 19:23:08 +0900
Received: from localhost.localdomain (unknown [10.226.93.220])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 955C64222E70;
	Wed,  2 Apr 2025 19:23:05 +0900 (JST)
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
Subject: [PATCH v8 09/19] can: rcar_canfd: Add rnc_field_width variable to struct rcar_canfd_hw_info
Date: Wed,  2 Apr 2025 11:22:01 +0100
Message-ID: <20250402102226.28032-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250402102226.28032-1-biju.das.jz@bp.renesas.com>
References: <20250402102226.28032-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The shift and w value in rcar_canfd_setrnc() are dictated by the
field width:
  - R-Car Gen4 packs 2 values in a 32-bit word, using a field width
    of 16 bits,
  - R-Car Gen3 packs up to 4 values in a 32-bit word, using a field
    width of 8 bits.

Add rnc_field_width variable to struct rcar_canfd_hw_info to handle this
difference. The rnc_stride is 32 / rnc_field_width and the index parameter
w is calculated by ch / rnc_stride. The shift value in rcar_canfd_setrnc()
is computed by using (32 - (ch % rnc_stride + 1) * rnc_field_width).

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v7->v8:
 * Updated commit description.
v6->v7:
 * Collected tag.
v6:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index b2b87291dcf1..ee4d24646b2d 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -502,6 +502,7 @@
 struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
+	u8 rnc_field_width;
 	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
@@ -578,18 +579,21 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 };
 
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
+	.rnc_field_width = 8,
 	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
+	.rnc_field_width = 16,
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
+	.rnc_field_width = 8,
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
@@ -675,9 +679,10 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
 			      unsigned int num_rules)
 {
-	unsigned int shift = reg_gen4(gpriv, 16, 24) - (ch & 1) * reg_gen4(gpriv, 16, 8);
+	unsigned int rnc_stride = 32 / gpriv->info->rnc_field_width;
+	unsigned int shift = 32 - (ch % rnc_stride + 1) * gpriv->info->rnc_field_width;
+	unsigned int w = ch / rnc_stride;
 	u32 rnc = num_rules  << shift;
-	unsigned int w = ch / 2;
 
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(w), rnc);
 }
-- 
2.43.0


