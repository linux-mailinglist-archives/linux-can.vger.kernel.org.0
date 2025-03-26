Return-Path: <linux-can+bounces-3231-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70171A71698
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 13:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2F6174400
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 12:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D911DE3C1;
	Wed, 26 Mar 2025 12:21:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701741DF963;
	Wed, 26 Mar 2025 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991680; cv=none; b=eBWzM13z7c6cPPrqWLXbDn1twof3E1LfYx2TWmVq02SjQHJ0Jx5/9P3ftvTDQkIapDKf2n/YhJsoEnyQlGWlQzYyBJraFw2BEEVfSde3InudsBMyn5Q05oA+UiseikmsvK3uMKRDblV4zHlWzj0rWJ76h+ziDa+VZU40NZe7InU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991680; c=relaxed/simple;
	bh=/h0/GwO8iEZ0rlUPZab7dy4ECfbH8lLFIzs3CJXJjhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDPDj+kEAviFf5hA7u1Zf9j5lHxaJvpcD493MXCPVWhQk33WCWFW+UCpM83p6bw8OOJ7erE1U1gLwe56z3AlzMDVcoj7TpYUrQVrnxtbadKG9ATsdBt+1BKkeXxLPAsynMGsTgFpBuF9skSFywdRJXdqMK3HzfFLVb5cZdR4Gcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: USWJUceiQLWFw1OMM1YEpg==
X-CSE-MsgGUID: psrj5hQ2Rlepfpj6xakwpQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Mar 2025 21:21:18 +0900
Received: from localhost.localdomain (unknown [10.226.92.116])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2649240104CB;
	Wed, 26 Mar 2025 21:21:14 +0900 (JST)
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
Subject: [PATCH v7 18/18] can: rcar_canfd: Add RZ/G3E support
Date: Wed, 26 Mar 2025 12:19:53 +0000
Message-ID: <20250326122003.122976-19-biju.das.jz@bp.renesas.com>
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

The CAN-FD IP found on the RZ/G3E SoC is similar to R-Car Gen4, but
it has no external clock instead it has clk_ram, it has 6 channels
and supports 20 interrupts. Add support for RZ/G3E CAN-FD driver.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * No change.
v5->v6:
 * Collected tag
 * Updated r9a09g047_hw_info table. 
v4->v5:
 * Updated error description as "cannot get enabled ram clock"
 * Updated r9a09g047_hw_info table.  
v3->v4:
 * No change.
v2->v3:
 * Replaced gen4_type entry with mask_table, shift_table, regs,
   ch_interface_mode and shared_can_reg.
v1->v2:
 * No change.
---
 drivers/net/can/rcar/rcar_canfd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 91f5649078c6..243eaf6c24c4 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -730,6 +730,24 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.multi_channel_irqs = 1,
 };
 
+static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.regs = rcar_gen4_regs,
+	.shift_table = rcar_gen4_shift_table,
+	.num_supported_rules = 512,
+	.rnc_stride = 2,
+	.rnc_field_width = 16,
+	.max_aflpn = 63,
+	.max_cftml = 31,
+	.max_channels = 6,
+	.postdiv = 1,
+	.multi_channel_irqs = 1,
+	.ch_interface_mode = 1,
+	.shared_can_regs = 1,
+	.only_internal_clks = 1,
+};
+
 /* Helper functions */
 static inline void rcar_canfd_update(u32 mask, u32 val, u32 __iomem *reg)
 {
@@ -1963,6 +1981,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
+	struct clk *clk_ram;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2052,6 +2071,11 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		gpriv->extclk = !gpriv->info->only_internal_clks;
 	}
 
+	clk_ram = devm_clk_get_optional_enabled(dev, "ram_clk");
+	if (IS_ERR(clk_ram))
+		return dev_err_probe(dev, PTR_ERR(clk_ram),
+				     "cannot get enabled ram clock\n");
+
 	addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(addr)) {
 		err = PTR_ERR(addr);
@@ -2214,6 +2238,7 @@ static SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
+	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
 	{ .compatible = "renesas,rcar-gen4-canfd", .data = &rcar_gen4_hw_info },
 	{ .compatible = "renesas,rzg2l-canfd", .data = &rzg2l_hw_info },
-- 
2.43.0


