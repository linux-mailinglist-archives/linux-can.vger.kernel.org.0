Return-Path: <linux-can+bounces-2832-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D236A39994
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 11:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62BBE188A67F
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 10:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF862376E2;
	Tue, 18 Feb 2025 10:50:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B036F23717F;
	Tue, 18 Feb 2025 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875846; cv=none; b=Q3JuOuTVMWWDRO+D1PLiaCFNijjKKRqK1buQtcsJV3S0a9N1+alnyExq07DE/p/jWUoBehw6Elzmm+70ysjes9Xs4s/PHafLjwStv3vecXuWJLoMBDL3QULTpwJT9G0i9gkOxZ20EORmXHyXp4vtVUzE6UiXGNyCzXj35sj6c8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875846; c=relaxed/simple;
	bh=xvVSZbatOPZKYjEbqQy6plTmw1bmYSPjHJUUx/AHLvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iECAfu5d3B3X66bBVo8jJULVv584plOuKQQe8OZJNy9Ezhz3VKJCHZkOcf2B2Y5nUwmPRMtCMytVZR1DzwvULzrlbYZ/8Im7d6Ug0uOl9qVCzCv2gX3bUiirE/7AnVmi2GreA4/PTaNJPVElTayXL9uAcgn+phx3gEQbOedlh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: oQHW2zD+Qn6dBTY6hXpRGg==
X-CSE-MsgGUID: xUt1/C5XRHaLEa7ttMGtBg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 18 Feb 2025 19:50:44 +0900
Received: from localhost.localdomain (unknown [10.226.92.208])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 72AFB42A5EA4;
	Tue, 18 Feb 2025 19:50:41 +0900 (JST)
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
Subject: [PATCH 07/11] can: rcar_canfd: Add only_internal_clks variable to struct rcar_canfd_hw_info
Date: Tue, 18 Feb 2025 10:49:57 +0000
Message-ID: <20250218105007.66358-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218105007.66358-1-biju.das.jz@bp.renesas.com>
References: <20250218105007.66358-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All SoCs supports extenal clock, but RZ/G3E has only internal clocks. Add
only_internal_clks to struct rcar_canfd_hw_info to handle this difference.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index c49cb25da94f..d19044f07cb9 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -517,6 +517,7 @@ struct rcar_canfd_hw_info {
 	unsigned shared_global_irqs:1;	/* Has shared global irqs */
 	unsigned multi_channel_irqs:1;	/* Has multiple channel irqs */
 	unsigned gen4_type:1;		/* Has gen4 type reg layout */
+	unsigned only_internal_clks:1;	/* Has only internal clocks */
 };
 
 /* Channel priv data */
@@ -1943,7 +1944,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		fcan_freq = clk_get_rate(gpriv->can_clk) / info->postdiv;
 	} else {
 		fcan_freq = clk_get_rate(gpriv->can_clk);
-		gpriv->extclk = true;
+		gpriv->extclk = !gpriv->info->only_internal_clks;
 	}
 
 	addr = devm_platform_ioremap_resource(pdev, 0);
-- 
2.43.0


