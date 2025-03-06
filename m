Return-Path: <linux-can+bounces-3013-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E72A54B1E
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 13:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414D93AB5E3
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8731C7017;
	Thu,  6 Mar 2025 12:43:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B3220A5D3;
	Thu,  6 Mar 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265028; cv=none; b=nAxLwP6bAkp32IkADidzGrOwRF+x7iwAVok1kbmnJeA5THavMxULwinGha+2B/peDMQa/oEWV3Du87rqyts0uSiKsmWpcNpN0qJo8PMz4DWpUeh48VbYExkDRC8BI9fgtPdKjQ4xEbFXhnI13CtmMz+sRSB44o4S3TwAcc02yR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265028; c=relaxed/simple;
	bh=lQ+GyHswV9LdJO32EpZa4ZjymxbNpCbMX0wYomVNl58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltn0+MzTFzYcx0vJhJlQ8QeONE/mZ7LzBCphlpnnpErUa0b6XPz7K4N5wHYY2iWg0mknwjLzuJAzO5YYYJEmbgt3bb4Pb3kwtuL6kjKPsG7F5k6WwiSZmW57BGVIqe2az9IwpLbSZFE2EAFOuYuyl8bvb1b3a3NPHR3QouLf5WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: Bao+8xMlRnK2RiwlaEet6g==
X-CSE-MsgGUID: xx+BV1n0Tn2ax0ozd8KY/Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Mar 2025 21:43:45 +0900
Received: from localhost.localdomain (unknown [10.226.92.10])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 774354281B0D;
	Thu,  6 Mar 2025 21:43:42 +0900 (JST)
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
Subject: [PATCH v4 11/11] can: rcar_canfd: Add RZ/G3E support
Date: Thu,  6 Mar 2025 12:42:50 +0000
Message-ID: <20250306124256.93033-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
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
v3->v4:
 * No change.
v2->v3:
 * Replaced gen4_type entry with mask_table, shift_table, regs,
   ch_interface_mode and shared_can_reg.
v1->v2:
 * No change.
---
 drivers/net/can/rcar/rcar_canfd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 862f06b4b91e..68b15f3ab14f 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -736,6 +736,18 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
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
@@ -1979,6 +1991,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
+	struct clk *clk_ram;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2068,6 +2081,11 @@ static int rcar_canfd_probe(struct platform_device *pdev)
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
@@ -2230,6 +2248,7 @@ static SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
+	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
 	{ .compatible = "renesas,rcar-gen4-canfd", .data = &rcar_gen4_hw_info },
 	{ .compatible = "renesas,rzg2l-canfd", .data = &rzg2l_hw_info },
-- 
2.43.0


