Return-Path: <linux-can+bounces-2963-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5117A444BB
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 16:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9353BF91A
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEE81624CD;
	Tue, 25 Feb 2025 15:41:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C726156677;
	Tue, 25 Feb 2025 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498109; cv=none; b=XQcQtTSsbVrIyISysRHusfadOOaRTikONSUqk+3elFIG2qPCiDtLjl65Rx4vX6YnaJ8cp+iEPc8BqiTh36pZTrM2kw/2Ub/43tMyHcNf76s1A7UcOLzduHR18TIe8uVGu5C0TxxXalIfEL++Do5Ice/M8xHbTk3Pe2E0sH6ESHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498109; c=relaxed/simple;
	bh=JP62AUftG8RtnsNHSpdB3CFp+Xj3n7jqjoXVID0fWzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fj2lhpklU9DbqUAGbDt8C+vhutk++KC+OgmMCOccrgFJWyLGGT6EyQe1C0YdWhAxRamBiip33G8cA9QQkb9Lmrydhr8D4zd+tHRP3fV3U206tmQqlOm6iqayCYy8mAK5Mh8MtXcHdV3mY7S8qFWS5PRSWGhx0bKceOJkwYSfjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: xznwHZHtSeaN0U9FPl63vA==
X-CSE-MsgGUID: pemhZoXhSt26GoJ1aE29Og==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Feb 2025 00:41:47 +0900
Received: from localhost.localdomain (unknown [10.226.92.81])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 73CA7400FD08;
	Wed, 26 Feb 2025 00:41:44 +0900 (JST)
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
Subject: [PATCH v3 11/11] can: rcar_canfd: Add RZ/G3E support
Date: Tue, 25 Feb 2025 15:40:50 +0000
Message-ID: <20250225154058.59116-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225154058.59116-1-biju.das.jz@bp.renesas.com>
References: <20250225154058.59116-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CAN-FD IP found on the RZ/G3E SoC is similar to R-Car Gen4, but
it has no external clock instead it has clk_ram, it has 6 channels
and supports 20 interrupts. Add support for RZ/G3E CAN-FD driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Replaced gen4_type entry with mask_table, shift_table, regs,
   ch_interface_mode and shared_can_reg.
v1->v2:
 * No change.
---
 drivers/net/can/rcar/rcar_canfd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 48fead44556c..290e5a231ea3 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -730,6 +730,18 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.multi_channel_irqs = 1,
 };
 
+static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
+	.mask_table = rcar_gen4_mask_table,
+	.shift_table = rcar_gen4_shift_table,
+	.regs = rcar_gen4_regs,
+	.max_channels = 6,
+	.postdiv = 1,
+	.multi_channel_irqs = 1,
+	.ch_interface_mode = 1,
+	.shared_can_reg = 1,
+	.only_internal_clks = 1,
+};
+
 /* Helper functions */
 static inline void rcar_canfd_update(u32 mask, u32 val, u32 __iomem *reg)
 {
@@ -1973,6 +1985,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
+	struct clk *clk_ram;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2062,6 +2075,11 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		gpriv->extclk = !gpriv->info->only_internal_clks;
 	}
 
+	clk_ram = devm_clk_get_optional_enabled(dev, "ram_clk");
+	if (IS_ERR(clk_ram))
+		return dev_err_probe(dev, PTR_ERR(clk_ram),
+				     "cannot get ram clock\n");
+
 	addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(addr)) {
 		err = PTR_ERR(addr);
@@ -2224,6 +2242,7 @@ static SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
+	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
 	{ .compatible = "renesas,rcar-gen4-canfd", .data = &rcar_gen4_hw_info },
 	{ .compatible = "renesas,rzg2l-canfd", .data = &rzg2l_hw_info },
-- 
2.43.0


