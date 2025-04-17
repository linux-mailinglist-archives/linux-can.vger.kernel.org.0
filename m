Return-Path: <linux-can+bounces-3424-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3267A91318
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 07:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4C3189036F
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 05:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2B21EB1BF;
	Thu, 17 Apr 2025 05:44:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3291E834D;
	Thu, 17 Apr 2025 05:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868651; cv=none; b=sIv+rR+U8nMzv/lIAOmLGzMWr4Z6OdtPOzuA7a0/M0i2feFovjWLPF6zsGD+2PNAMrZI/56uGHl3tZ0AdzqtR4FNHiHVKkLLSlJYCpEhyCxhlb55ZXr9DFlgLLKXwa6+KJhUVG/5T0aeLW4zgBlBjAAJPecPwvIIHNDn0BrQh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868651; c=relaxed/simple;
	bh=aS7ocKXVIexsw2Fj8782iBmiXaBGV6HiDt4Hxz6s/xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBMe91AIrORsTBwRD9Phl6qK64bAl8C4GbmN21evd38uZZ7KaGSgKwNp5YPDXVhyNIbZvaLW6pMRGbcEe5zqfNUrvI8WYmnLMnzRG32xIu8NdtGsuQ5D0AgSIJx/sdMmZ4uIKYudjuzsjfTt96nmKOzO17exTthIYIaAciy6pGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: c+ZQ9WncTXexJO+x8B8Bxg==
X-CSE-MsgGUID: VDCg/QJ7TXCB6R1bfjVOlw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 14:44:08 +0900
Received: from localhost.localdomain (unknown [10.226.92.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2673644CC5C5;
	Thu, 17 Apr 2025 14:44:02 +0900 (JST)
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
Subject: [PATCH v9 07/19] can: rcar_canfd: Add rcar_canfd_setrnc()
Date: Thu, 17 Apr 2025 06:43:08 +0100
Message-ID: <20250417054320.14100-8-biju.das.jz@bp.renesas.com>
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

Add rcar_canfd_setrnc() to replace the macro RCANFD_GAFLCFG_SETRNC.
While at it, replace int->unsigned int for local variables offset, page
and num_rules in rcar_canfd_configure_afl_rules().

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v8->v9:
 * Collected tag.
 * Removed unneeded double space in rcar_canfd_setrnc().
v8:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 45d0c34f64f6..6b87c1548f68 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -90,10 +90,6 @@
 
 /* AFL Rx rules registers */
 
-/* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
-#define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
-	((x) << (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
-
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
 #define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))
@@ -677,6 +673,15 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 		can_free_echo_skb(ndev, i, NULL);
 }
 
+static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
+			      unsigned int num_rules)
+{
+	unsigned int shift = reg_gen4(gpriv, 16, 24) - (ch & 1) * reg_gen4(gpriv, 16, 8);
+	u32 rnc = num_rules << shift;
+
+	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch), rnc);
+}
+
 static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 {
 	if (is_gen4(gpriv)) {
@@ -785,7 +790,7 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
 static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 					   u32 ch, u32 rule_entry)
 {
-	int offset, page, num_rules = RCANFD_CHANNEL_NUMRULES;
+	unsigned int offset, page, num_rules = RCANFD_CHANNEL_NUMRULES;
 	u32 rule_entry_index = rule_entry % 16;
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
@@ -796,8 +801,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
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


