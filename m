Return-Path: <linux-can+bounces-2903-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077EA3DAD2
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 14:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09E416F946
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547E1F7545;
	Thu, 20 Feb 2025 13:05:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFDC1F6694;
	Thu, 20 Feb 2025 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056706; cv=none; b=ZDRUIUEP5Ev7i0+q02aaIcK28oy+oscQ53wtaXMXoFkuMYmlmXkJy3SzLdI6WJeegu7zzvArkovwYjLTp7C1MC8hau/NWZFrt1QgBGH4oRFnWGqUKBpucZOrRLwmm+EOKuaxlwnPQEZhXiLMET0uSLYW0hiKhueW994PX6UZ160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056706; c=relaxed/simple;
	bh=clsoHouoGOfq6VRePgM5/+uiMLZhzape7XlSvjtzISA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqBHRe5CuRT3mhyvurO7tRt2Ssv4yOLRm7t6vf9yTAEUkNku+/7pF3sZgg8/clGDsvC/9QaJpBLvJSdMSbe3G1FqfuOjQwUnDwVvsbJVuRpGksHx5V6rGpiNaWTYSpvi4EZij3b9wDF7gJ+sh+jSrZVyrLtbzDxppoT/Tjm8iGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: DgD8et3ASrOxYQXB5+v3rg==
X-CSE-MsgGUID: asbsuzU2RkG5aThDPEyIjg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Feb 2025 22:05:04 +0900
Received: from localhost.localdomain (unknown [10.226.92.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1AE0E42B36D6;
	Thu, 20 Feb 2025 22:05:00 +0900 (JST)
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
Subject: [PATCH v2 7/7] can: rcar_canfd: Add RZ/G3E support
Date: Thu, 20 Feb 2025 13:04:23 +0000
Message-ID: <20250220130427.217342-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220130427.217342-1-biju.das.jz@bp.renesas.com>
References: <20250220130427.217342-1-biju.das.jz@bp.renesas.com>
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
v1->v2:
 * No change.
---
 drivers/net/can/rcar/rcar_canfd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index bf2561168e98..667d091bbcc9 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -607,6 +607,14 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.multi_channel_irqs = 1,
 };
 
+static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
+	.max_channels = 6,
+	.postdiv = 1,
+	.multi_channel_irqs = 1,
+	.gen4_type = 1,
+	.only_internal_clks = 1,
+};
+
 /* Helper functions */
 static inline bool is_gen4(struct rcar_canfd_global *gpriv)
 {
@@ -1861,6 +1869,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
+	struct clk *clk_ram;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -1950,6 +1959,11 @@ static int rcar_canfd_probe(struct platform_device *pdev)
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
@@ -2112,6 +2126,7 @@ static SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
+	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
 	{ .compatible = "renesas,rcar-gen4-canfd", .data = &rcar_gen4_hw_info },
 	{ .compatible = "renesas,rzg2l-canfd", .data = &rzg2l_hw_info },
-- 
2.43.0


