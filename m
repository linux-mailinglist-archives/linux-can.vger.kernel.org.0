Return-Path: <linux-can+bounces-3229-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7C3A7167F
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 13:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E4E3B9B32
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 12:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF64E1DF969;
	Wed, 26 Mar 2025 12:21:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DA81E1C2B;
	Wed, 26 Mar 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991673; cv=none; b=Y7SwogOuSl+llRnkLlm22Jp7ZHtE20NCAGLrhxt6ItE3DLzUV3Ge5kpkUFB020uUBTzMrhsX50PtYs1hpHaUSAEV8dm3MmqUa6S4UICb5Of5DoBS6763QnIQeYttXWRpVtqAmMhKKH4eHPwwNLb0IblL0t1mBVc2hLcwnycHlZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991673; c=relaxed/simple;
	bh=GCA/h7JXBbPrRaHZaqh353DSOW6ZlzcWmmyGRY6jYq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5pxJM4oLLCJij+xDcplvGt9JR0FsTZaB9ZmWZH0JWrXFW4nze2QvhNV5TlQSpNpfQFtvrVD64ZEMWbNJH2JQHgsBoqCV5ymEOgWkbKFRcNKBs1qYUL1A3sh4LcaYLaBiqKDYAcb+liDGvSvVE9R9YypEWCJEtXOEZ99AMYKDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: FILwTVt3SaC0X2Q/+fRqRw==
X-CSE-MsgGUID: 74VXc3QTQiuO/fg9Pe7QFw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Mar 2025 21:21:11 +0900
Received: from localhost.localdomain (unknown [10.226.92.116])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 40C4240104CB;
	Wed, 26 Mar 2025 21:21:08 +0900 (JST)
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
Subject: [PATCH v7 16/18] can: rcar_canfd: Add only_internal_clks variable to struct rcar_canfd_hw_info
Date: Wed, 26 Mar 2025 12:19:51 +0000
Message-ID: <20250326122003.122976-17-biju.das.jz@bp.renesas.com>
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

All existing SoCs support an external clock, but RZ/G3E has only internal
clocks. Add only_internal_clks to struct rcar_canfd_hw_info to handle this
difference.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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
 drivers/net/can/rcar/rcar_canfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 20e591421cc6..7ad27087a176 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -546,6 +546,7 @@ struct rcar_canfd_hw_info {
 	unsigned multi_channel_irqs:1;	/* Has multiple channel irqs */
 	unsigned ch_interface_mode:1;	/* Has channel interface mode */
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
+	unsigned only_internal_clks:1;	/* Has only internal clocks */
 };
 
 /* Channel priv data */
@@ -2045,7 +2046,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		fcan_freq = clk_get_rate(gpriv->can_clk) / info->postdiv;
 	} else {
 		fcan_freq = clk_get_rate(gpriv->can_clk);
-		gpriv->extclk = true;
+		gpriv->extclk = !gpriv->info->only_internal_clks;
 	}
 
 	addr = devm_platform_ioremap_resource(pdev, 0);
-- 
2.43.0


