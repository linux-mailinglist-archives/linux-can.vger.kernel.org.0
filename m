Return-Path: <linux-can+bounces-3348-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D7DA78C39
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 12:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A073B32E1
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3C9235BE8;
	Wed,  2 Apr 2025 10:23:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5108C236458;
	Wed,  2 Apr 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589417; cv=none; b=OQ+BB4wXfT2GWgFwAlZR0xCrihuFnRdasYxr+0eY5qkz03dwkbREc5PoYRBZDOPJ++Ejgnqs8hPW6U2raNyQv+VruF+/SiAqsYrGoRQAr+nXBBZz4bgZRyUfEIb9d11dlOjXPonNFHHiwQSop1q/z5NdzA5g0nvvgkznRetiEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589417; c=relaxed/simple;
	bh=7fIh0qAmuWaknqgBDZFudnSDW33VQKb/IMN9ZUEM8EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bjdwt7ybE2QW8s7TpsTMpy8bO1BTCPEljNuYtGdfjz6cEO0pSp0CsVDv8iJA7jj9kx28PKYRY9T6b48V2z2H8hI9Oh38Tpv5wp6aHgc7UlHAITOuMqcaNxtdOG3VzWOcSNJBTq6V35lAXB4592B/DainaWrp+5k+eot6YdaWVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: tVklE34bS+O9c7IyKS3YKg==
X-CSE-MsgGUID: UPiPBUzdSyC349w5xfu3OQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2025 19:23:35 +0900
Received: from localhost.localdomain (unknown [10.226.93.220])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2547C4224218;
	Wed,  2 Apr 2025 19:23:32 +0900 (JST)
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
Subject: [PATCH v8 17/19] can: rcar_canfd: Add external_clk variable to struct rcar_canfd_hw_info
Date: Wed,  2 Apr 2025 11:22:09 +0100
Message-ID: <20250402102226.28032-18-biju.das.jz@bp.renesas.com>
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

All existing SoCs support an external clock, but RZ/G3E has only internal
clocks. Add external_clk variable to struct rcar_canfd_hw_info to handle
this difference.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v7->v8:
 * Renamed only_internal_clks->external_clk to avoid negation.
 * Updated commit description.
 * Updated rcar_canfd_hw_info tables.
 * Collected tag.
v6->v7:
 * No change.
v5->v6:
 * No change.
v4->v5:
 * Collected tag.
 * Improved commit description by "All SoCs supports extenal clock"->
   "All existing SoCs support an external clock".
v3->v4:
 * No change.
v2->v3:
 * No change
v1->v2:
 * No change.
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 5c46bc0e352f..11dd3730e98c 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -540,6 +540,7 @@ struct rcar_canfd_hw_info {
 	unsigned multi_channel_irqs:1;	/* Has multiple channel irqs */
 	unsigned ch_interface_mode:1;	/* Has channel interface mode */
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
+	unsigned external_clk:1;	/* Has external clock */
 };
 
 /* Channel priv data */
@@ -689,6 +690,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.shared_global_irqs = 1,
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
+	.external_clk = 1,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -704,6 +706,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.shared_global_irqs = 1,
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
+	.external_clk = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -719,6 +722,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.multi_channel_irqs = 1,
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
+	.external_clk = 1,
 };
 
 /* Helper functions */
@@ -2047,7 +2051,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		fcan_freq = clk_get_rate(gpriv->can_clk) / info->postdiv;
 	} else {
 		fcan_freq = clk_get_rate(gpriv->can_clk);
-		gpriv->extclk = true;
+		gpriv->extclk = gpriv->info->external_clk;
 	}
 
 	addr = devm_platform_ioremap_resource(pdev, 0);
-- 
2.43.0


