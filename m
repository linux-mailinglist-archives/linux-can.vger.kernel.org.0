Return-Path: <linux-can+bounces-3133-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFC1A64F25
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 13:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C662172911
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 12:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D601238D32;
	Mon, 17 Mar 2025 12:37:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BAB23A563;
	Mon, 17 Mar 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215042; cv=none; b=nPjzcxILarPeOb8hkV55nD2SPQcslb0T4NG0731adntG1qYXulWv2uP7yvyuRwhr8qjbW/4DsHhZ0cYwJtBp96U72aTAn30psWaTgcYfHaDN+xaa3wluLfFpljNUqHOhHoPL8SI/8FiIGxV20gpXArszkVmTMjlcnP7C4v4gEhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215042; c=relaxed/simple;
	bh=fV6kvEgrb14MbNUiyZNKsFkmY/f+OMpm6veaoFZBUWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bM0lgRErgUlPyt1sMpmAo1MS7S3BcJ7orkiZLEuc9YJPKCxTOGYumxuPFODwWVUc3iQ5YFtIKRrenUq6uLxlI8xfCPL+2Df7Ncxtwh5rU49gdhcVqpfvdJxQ+7R/leluq6DVsqFMFZQhoHfOG2qpfUmxpZEtkFBgIZsgVfqNlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: UkYShSVLQKizQAX7mazOHg==
X-CSE-MsgGUID: ttcNOiciRZ65mxcbrLJeeg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Mar 2025 21:37:20 +0900
Received: from localhost.localdomain (unknown [10.226.92.84])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 61A1F4000FBD;
	Mon, 17 Mar 2025 21:37:17 +0900 (JST)
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
Subject: [PATCH v5 14/16] can: rcar_canfd: Add only_internal_clks variable to struct rcar_canfd_hw_info
Date: Mon, 17 Mar 2025 12:36:08 +0000
Message-ID: <20250317123619.70988-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All existing SoCs support an external clock, but RZ/G3E has only internal
clocks. Add only_internal_clks to struct rcar_canfd_hw_info to handle this
difference.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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
 drivers/net/can/rcar/rcar_canfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 4ba8e51242d3..5b07e3724fff 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -555,6 +555,7 @@ struct rcar_canfd_hw_info {
 	unsigned multi_channel_irqs:1;	/* Has multiple channel irqs */
 	unsigned ch_interface_mode:1;	/* Has channel interface mode */
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
+	unsigned only_internal_clks:1;	/* Has only internal clocks */
 };
 
 /* Channel priv data */
@@ -2041,7 +2042,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		fcan_freq = clk_get_rate(gpriv->can_clk) / info->postdiv;
 	} else {
 		fcan_freq = clk_get_rate(gpriv->can_clk);
-		gpriv->extclk = true;
+		gpriv->extclk = !gpriv->info->only_internal_clks;
 	}
 
 	addr = devm_platform_ioremap_resource(pdev, 0);
-- 
2.43.0


