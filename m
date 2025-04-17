Return-Path: <linux-can+bounces-3431-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEDFA91326
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 07:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B26C67A8BBB
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 05:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399E21DEFD4;
	Thu, 17 Apr 2025 05:44:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448B81B043C;
	Thu, 17 Apr 2025 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868687; cv=none; b=aFw/QpYs1994TP9WjfTDog3NBr+jvf4S31sJ4mInw6WvSrpjQRBcrTYADUhB1jdHsKCUWPWKyYtBUSbEcSzEhc11MGyeZq+Ap6GazQ3NLu7uDpP3fWwrbe4zyqM4Y19WZXfYb0F5GuzDlBjHvuY2Mcvt5tkimj55RsNXqnZdanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868687; c=relaxed/simple;
	bh=31vnM5HroAwVYkt/RiAg7X+lPlU4Lvly/tlJs41eIks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jm/1SWLUuU6fo9MsYf3WeyxuE9VmT5xlkUYhMl0a0FaC71nW506jOFzyEER8CjLlxmCIfmxVyjxXMxPkrhwaQzWs5gFdSADtHqzzpBm27Xc4lX5Fp25VlTrVq9WusCN4sdnNRBKwTi3/ousx8ejEE5kA3R+2RJ22b6AHaWDeMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: YZ/KluwoSIGHUCqz8UoX2A==
X-CSE-MsgGUID: 6qcxj7vyTKCKDEt4NCa0LQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 14:44:45 +0900
Received: from localhost.localdomain (unknown [10.226.92.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4AF6844E4CB4;
	Thu, 17 Apr 2025 14:44:40 +0900 (JST)
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
Subject: [PATCH v9 14/19] can: rcar_canfd: Add shared_can_regs variable to struct rcar_canfd_hw_info
Date: Thu, 17 Apr 2025 06:43:15 +0100
Message-ID: <20250417054320.14100-15-biju.das.jz@bp.renesas.com>
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

R-Car Gen4 has shared regs for both CAN-FD and Classical CAN operations.
Add shared_can_regs variable to struct rcar_canfd_hw_info to handle this
difference.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v8->v9:
 * No change.
v7->v8:
 * Updated {rzg2l,rcar_gen3}_hw_info with shared_can_regs = 0.
 * Collected tag.
v6->v7:
 * No change.
v5->v6:
 * No change.
v4->v5:
 * Collected tag.
 * Replaced the variable name shared_can_reg->shared_can_regs.
v3->v4:
 * No change.
v3:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 25c00abee9cc..7e0f84596807 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -517,6 +517,7 @@ struct rcar_canfd_hw_info {
 	unsigned shared_global_irqs:1;	/* Has shared global irqs */
 	unsigned multi_channel_irqs:1;	/* Has multiple channel irqs */
 	unsigned ch_interface_mode:1;	/* Has channel interface mode */
+	unsigned shared_can_regs:1;	/* Has shared classical can registers */
 };
 
 /* Channel priv data */
@@ -621,6 +622,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 	.ch_interface_mode = 0,
+	.shared_can_regs = 0,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -633,6 +635,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 	.ch_interface_mode = 1,
+	.shared_can_regs = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -645,6 +648,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
 	.ch_interface_mode = 0,
+	.shared_can_regs = 0,
 };
 
 /* Helper functions */
@@ -855,7 +859,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 
 	/* Write number of rules for channel */
 	rcar_canfd_setrnc(gpriv, ch, num_rules);
-	if (is_gen4(gpriv))
+	if (gpriv->info->shared_can_regs)
 		offset = RCANFD_GEN4_GAFL_OFFSET;
 	else if (gpriv->fdmode)
 		offset = RCANFD_F_GAFL_OFFSET;
@@ -1391,7 +1395,7 @@ static void rcar_canfd_set_bittiming(struct net_device *dev)
 			   brp, sjw, tseg1, tseg2);
 	} else {
 		/* Classical CAN only mode */
-		if (is_gen4(gpriv)) {
+		if (gpriv->info->shared_can_regs) {
 			cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) |
 			       RCANFD_NCFG_NBRP(brp) |
 			       RCANFD_NCFG_NSJW(gpriv, sjw) |
@@ -1556,7 +1560,7 @@ static netdev_tx_t rcar_canfd_start_xmit(struct sk_buff *skb,
 
 	dlc = RCANFD_CFPTR_CFDLC(can_fd_len2dlc(cf->len));
 
-	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || is_gen4(gpriv)) {
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
 		rcar_canfd_write(priv->base,
 				 RCANFD_F_CFID(gpriv, ch, RCANFD_CFFIFO_IDX), id);
 		rcar_canfd_write(priv->base,
@@ -1615,7 +1619,7 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 	u32 ch = priv->channel;
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
-	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || is_gen4(gpriv)) {
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
 		id = rcar_canfd_read(priv->base, RCANFD_F_RFID(gpriv, ridx));
 		dlc = rcar_canfd_read(priv->base, RCANFD_F_RFPTR(gpriv, ridx));
 
@@ -1666,7 +1670,7 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 		cf->len = can_cc_dlc2len(RCANFD_RFPTR_RFDLC(dlc));
 		if (id & RCANFD_RFID_RFRTR)
 			cf->can_id |= CAN_RTR_FLAG;
-		else if (is_gen4(gpriv))
+		else if (gpriv->info->shared_can_regs)
 			rcar_canfd_get_data(priv, cf, RCANFD_F_RFDF(gpriv, ridx, 0));
 		else
 			rcar_canfd_get_data(priv, cf, RCANFD_C_RFDF(ridx, 0));
-- 
2.43.0


