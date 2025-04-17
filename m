Return-Path: <linux-can+bounces-3434-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE6A9132D
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 07:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C0818871F4
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 05:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0661EB1BE;
	Thu, 17 Apr 2025 05:45:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9642195FE8;
	Thu, 17 Apr 2025 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868703; cv=none; b=YiMZFhkuH9e/jKr6ryH62th7dDY/Rth5+xeAgXS+MFErTbstT2gwxqkWNKR9ihawGvSYsrn25JgDkd8H95B+Jk5JPWUnZzQWHY4DkE+2IGeFxy5Vc8TEyC3SjorhWKo/RtAFSHlHB2JussAs+ampjkO2iZNvOqeFmGJXPiEp57Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868703; c=relaxed/simple;
	bh=JOvEk0ZxMSTjwN40XaFrosO11fpdRre+GryZqJAMFdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6G4XyCw0pjEhLjNHLey9YiYsytoiB3vA0inpUwj8DzZmJS8sVDBgi4Pk7ibeYFS+U98yhaFwdXXaiZzVLdNBrOk9qUtX56u/WVsKniaWb684vUQ7X4XwUphqMrt8sOdVxDJDsTSzR4quizuDXojIe8+wvqCJQUImhDh+nG8/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: sAmASyWEQXWIkQP4rOD51g==
X-CSE-MsgGUID: HlB/JQYCQKShfFB1bKbZJg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 14:45:00 +0900
Received: from localhost.localdomain (unknown [10.226.92.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 14A1F409A288;
	Thu, 17 Apr 2025 14:44:55 +0900 (JST)
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
Subject: [PATCH v9 17/19] can: rcar_canfd: Add external_clk variable to struct rcar_canfd_hw_info
Date: Thu, 17 Apr 2025 06:43:18 +0100
Message-ID: <20250417054320.14100-18-biju.das.jz@bp.renesas.com>
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

All existing SoCs support an external clock, but RZ/G3E has only internal
clocks. Add external_clk variable to struct rcar_canfd_hw_info to handle
this difference.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v8->v9:
 * No change.
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
index 67f7b5f6376c..0bf0e88dfe25 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -541,6 +541,7 @@ struct rcar_canfd_hw_info {
 	unsigned multi_channel_irqs:1;	/* Has multiple channel irqs */
 	unsigned ch_interface_mode:1;	/* Has channel interface mode */
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
+	unsigned external_clk:1;	/* Has external clock */
 };
 
 /* Channel priv data */
@@ -690,6 +691,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.shared_global_irqs = 1,
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
+	.external_clk = 1,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -705,6 +707,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.shared_global_irqs = 1,
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
+	.external_clk = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -720,6 +723,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.multi_channel_irqs = 1,
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
+	.external_clk = 1,
 };
 
 /* Helper functions */
@@ -2048,7 +2052,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		fcan_freq = clk_get_rate(gpriv->can_clk) / info->postdiv;
 	} else {
 		fcan_freq = clk_get_rate(gpriv->can_clk);
-		gpriv->extclk = true;
+		gpriv->extclk = gpriv->info->external_clk;
 	}
 
 	addr = devm_platform_ioremap_resource(pdev, 0);
-- 
2.43.0


