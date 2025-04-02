Return-Path: <linux-can+bounces-3338-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC45A78C32
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 12:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A6C3B2D02
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 10:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4409B235BE8;
	Wed,  2 Apr 2025 10:23:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9000F235BE4;
	Wed,  2 Apr 2025 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589384; cv=none; b=gkLXxojRhpmsv12SegJXlnKe1Tn0FO2UHgGA72BtyWotieopojc2N1kN/Qm1VJ9DYn8+BGzwO2sCerMYQiN9daBnmnLbUd8WjHyPj6mCCvAS1kd73euLAGRtBBdMxj5TokjWrNnzautQNHsQDTrL/RMlSavTT0GMMEubzfWL4sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589384; c=relaxed/simple;
	bh=0kq1G3DHhA9ffXoYE2ZCDUdX+emnmO/4xdi1UFZmiq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCAllzYEk6kjN6+9VvPADMAIeMaNzs0sj7SOidy2BljqYxt6SJYmoHwzbjdK4e8MK8DGupq3kIkP011RGjBJ2uk2r65LCQgoEQcUTPxbAt2UyrqYFWG4ZoNKFWWPMrkUa8t4yL5cSXfhzo8j21aN6wfDojYWl/u4pcUpcEclmVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: rJo7DCmARL6vP5+h3iUYIQ==
X-CSE-MsgGUID: RoF8yThlQO6+T3Go0hiWhw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2025 19:23:01 +0900
Received: from localhost.localdomain (unknown [10.226.93.220])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AEEF442241F9;
	Wed,  2 Apr 2025 19:22:58 +0900 (JST)
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
Subject: [PATCH v8 07/19] can: rcar_canfd: Add rcar_canfd_setrnc()
Date: Wed,  2 Apr 2025 11:21:59 +0100
Message-ID: <20250402102226.28032-8-biju.das.jz@bp.renesas.com>
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

Add rcar_canfd_setrnc() to replace the macro RCANFD_GAFLCFG_SETRNC.
While at it, replace int->unsigned int for local variables offset, page
and num_rules in rcar_canfd_configure_afl_rules().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v8:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 8205e4ada12e..98532f4031b1 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -89,10 +89,6 @@
 
 /* AFL Rx rules registers */
 
-/* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
-#define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
-	((x) << (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
-
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
 #define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))
@@ -676,6 +672,15 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 		can_free_echo_skb(ndev, i, NULL);
 }
 
+static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
+			      unsigned int num_rules)
+{
+	unsigned int shift = reg_gen4(gpriv, 16, 24) - (ch & 1) * reg_gen4(gpriv, 16, 8);
+	u32 rnc = num_rules  << shift;
+
+	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch), rnc);
+}
+
 static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 {
 	if (is_gen4(gpriv)) {
@@ -784,7 +789,7 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
 static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 					   u32 ch, u32 rule_entry)
 {
-	int offset, page, num_rules = RCANFD_CHANNEL_NUMRULES;
+	unsigned int offset, page, num_rules = RCANFD_CHANNEL_NUMRULES;
 	u32 rule_entry_index = rule_entry % 16;
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
@@ -795,8 +800,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 			    RCANFD_GAFLECTR_AFLDAE));
 
 	/* Write number of rules for channel */
-	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch),
-			   RCANFD_GAFLCFG_SETRNC(gpriv, ch, num_rules));
+	rcar_canfd_setrnc(gpriv, ch, num_rules);
 	if (is_gen4(gpriv))
 		offset = RCANFD_GEN4_GAFL_OFFSET;
 	else if (gpriv->fdmode)
-- 
2.43.0


