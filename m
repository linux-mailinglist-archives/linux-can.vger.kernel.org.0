Return-Path: <linux-can+bounces-3169-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C369A6A228
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 10:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5493A9089
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5353215171;
	Thu, 20 Mar 2025 09:11:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9E91A238C;
	Thu, 20 Mar 2025 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461901; cv=none; b=J/dUqWGqqK2ptCbriyjq1BLHYHLLxu/78nvUi1WZpCsrlcdhjE4Vct3K2jiNJ30OdrpDqeswMJXqUH73IlmPsTmW6SejByHgMVeWj0HUy3pPlJtloBx0AK80gF7Zfep8OUAq+GV6ATEcpSs0a1Ej3yKUs9Bw1PlgHoLvDsQxmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461901; c=relaxed/simple;
	bh=aAzhxhyCNxbh+WZDifn3nlXqSZvgDG/FEgmfpxB3ARE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDLQXeUjPzQYo7WCNS9Y/hHs3AFvu6vRNOMIekQzq3q7PnAcbEsfzgXft7nAWpUOT1h5bl3yw6lhoS/r1bvDw+yA3YPjxYyOwSJoNQ3T/3pY509Ydg03wfWGNx0SZy94m6wV9P5eKUuZhtsJvYW+WABsJekxI1VvazdwGM9IWm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 1p7sWnBnQa66CInu2LB0Mw==
X-CSE-MsgGUID: UzBHuhRRSXasQPfwwZi/Fg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Mar 2025 18:11:39 +0900
Received: from localhost.localdomain (unknown [10.226.93.24])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7280F4001DAF;
	Thu, 20 Mar 2025 18:11:36 +0900 (JST)
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
Subject: [PATCH v6 07/18] can: rcar_canfd: Add rnc_stride variable to struct rcar_canfd_hw_info
Date: Thu, 20 Mar 2025 09:10:38 +0000
Message-ID: <20250320091101.33637-8-biju.das.jz@bp.renesas.com>
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

R-Car Gen4 packs 2 RNC values in a 32-bit word, whereas R-Car Gen3 packs
up to 4 values in a 32-bit word. Handle this difference by adding
rnc_stride variable to struct rcar_canfd_hw_info and update the macro
RCANFD_GAFLCFG.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5->v6:
 * Replaced RCANFD_RNC_PER_REG macro with rnc_stride variable.
 * Updated commit description
 * Dropped Rb tag.
v5:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 32d700962d69..0001c8043c25 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -291,7 +291,7 @@
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR			(0x0098)
 /* RSCFDnCFDGAFLCFG / RSCFDnGAFLCFG */
-#define RCANFD_GAFLCFG(ch)		(0x009c + (0x04 * ((ch) / 2)))
+#define RCANFD_GAFLCFG(gpriv, ch)	(0x009c + (0x04 * ((ch) / (gpriv)->info->rnc_stride)))
 /* RSCFDnCFDRMNB / RSCFDnRMNB */
 #define RCANFD_RMNB			(0x00a4)
 /* RSCFDnCFDRMND / RSCFDnRMND */
@@ -505,6 +505,7 @@ struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
 	u16 num_supported_rules;
+	u8 rnc_stride;
 	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
@@ -582,6 +583,7 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.num_supported_rules = 256,
+	.rnc_stride = 4,
 	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -589,6 +591,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.num_supported_rules = 512,
+	.rnc_stride = 2,
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -596,6 +599,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.num_supported_rules = 256,
+	.rnc_stride = 4,
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
@@ -797,7 +801,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 			    RCANFD_GAFLECTR_AFLDAE));
 
 	/* Write number of rules for channel */
-	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch),
+	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(gpriv, ch),
 			   RCANFD_GAFLCFG_SETRNC(gpriv, ch, num_rules));
 	if (is_gen4(gpriv))
 		offset = RCANFD_GEN4_GAFL_OFFSET;
-- 
2.43.0


