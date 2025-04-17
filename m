Return-Path: <linux-can+bounces-3436-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BDBA91331
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 07:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0820317E98B
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 05:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79911E7C38;
	Thu, 17 Apr 2025 05:45:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B889C179A7;
	Thu, 17 Apr 2025 05:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868713; cv=none; b=QEC/hf80I3iibfaavG3p2R+3Og2m+aI0q9Nkw54a0E+5tw0nJixf5NdPm7CgUZ00WwvrU00FCCYgVZgzwUP3VCWbKekSlm7AXv79C/QYZxrVoN3H6RRY8I/V+yipHcjFif2kpbZu33o6HwHaZ6ThCHjHhF94J1gu6qoTSk8QyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868713; c=relaxed/simple;
	bh=hKljaHKyZTE04MHAij+pfZXy6OCT4wDM9UWUfuMMCXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCziqS8AjTsbjWKSGv0POQq2iCLkR5xROgcLPpPbBVDGTv5gxZriw7YYN8w6Jj5pXgVpJq1DHOCniqkORHkRho1twp0uJMjJe1EAZYwvC6vi9W8XxDYdUVFALv0SNlHpT6w8l0FpOPe6TCaSLRw82X73bFuc8yvFFnlrKhlq8BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: lqEideBSTtaFLIberh49LQ==
X-CSE-MsgGUID: OQCtVt0VSvyuXB/ldBT+LA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 14:45:11 +0900
Received: from localhost.localdomain (unknown [10.226.92.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AAD7F44E7E38;
	Thu, 17 Apr 2025 14:45:06 +0900 (JST)
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
Subject: [PATCH v9 19/19] can: rcar_canfd: Add RZ/G3E support
Date: Thu, 17 Apr 2025 06:43:20 +0100
Message-ID: <20250417054320.14100-20-biju.das.jz@bp.renesas.com>
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

The CAN-FD IP found on the RZ/G3E SoC is similar to R-Car Gen4, but
it has no external clock instead it has clk_ram, it has 6 channels
and supports 20 interrupts. Add support for RZ/G3E CAN-FD driver.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v8->v9:
 * No change.
v7->v8:
 * Collected tag.
v6->v7:
 * No change.
v5->v6:
 * Collected tag.
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
 drivers/net/can/rcar/rcar_canfd.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 6a9c970364cb..27d503ac87dc 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -726,6 +726,22 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.external_clk = 1,
 };
 
+static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.regs = &rcar_gen4_regs,
+	.sh = &rcar_gen4_shift_data,
+	.rnc_field_width = 16,
+	.max_aflpn = 63,
+	.max_cftml = 31,
+	.max_channels = 6,
+	.postdiv = 1,
+	.multi_channel_irqs = 1,
+	.ch_interface_mode = 1,
+	.shared_can_regs = 1,
+	.external_clk = 0,
+};
+
 /* Helper functions */
 static inline void rcar_canfd_update(u32 mask, u32 val, u32 __iomem *reg)
 {
@@ -1969,6 +1985,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
+	struct clk *clk_ram;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2058,6 +2075,11 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		gpriv->extclk = gpriv->info->external_clk;
 	}
 
+	clk_ram = devm_clk_get_optional_enabled(dev, "ram_clk");
+	if (IS_ERR(clk_ram))
+		return dev_err_probe(dev, PTR_ERR(clk_ram),
+				     "cannot get enabled ram clock\n");
+
 	addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(addr)) {
 		err = PTR_ERR(addr);
@@ -2220,6 +2242,7 @@ static SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
+	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
 	{ .compatible = "renesas,rcar-gen4-canfd", .data = &rcar_gen4_hw_info },
 	{ .compatible = "renesas,rzg2l-canfd", .data = &rzg2l_hw_info },
-- 
2.43.0


