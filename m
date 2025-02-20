Return-Path: <linux-can+bounces-2901-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8DAA3DACE
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 14:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A86F16F1A6
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 13:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29A81F7545;
	Thu, 20 Feb 2025 13:04:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8361F6694;
	Thu, 20 Feb 2025 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056699; cv=none; b=coKKkT4NeXTmeAH5h/oG+MZ7Tw144GTWgLoJxG3qlU1brkoDbZz1+T0uesV5KvjkWJG1sLqL8TOk+rX5ZYSn4bVVIWrJjvkU8POEN/mRc+XHvfbTwQ0ptE+oMrhiWMHOzAbZv+XFP66ivayVzWxNtKp2nDbVbpY3ZwhLaGRCzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056699; c=relaxed/simple;
	bh=Akk6srXG20NqYY2lsjMlHfVFPw1xFZdnBRw2HFC0a+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMnRqXn+q3b/dQmj4U2dl1FiN72uszlYRVcYjg/ocfbLLvlBY5htZuEmz8LZMyF1bBDHIm8qd3nJK7BNWP3itzLCXc1PkleEtxgXBQxMzpQoMDgXL0wzSJ+N7BTfRHUb4C4w9TOWJ1fVM37k13d+0BmMozymf+ZoRMZ/SHu7/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: CGE1nMMcTwWoChvtSd+THA==
X-CSE-MsgGUID: FkgdgEySQ9Wz8FxRzb66Bg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Feb 2025 22:04:56 +0900
Received: from localhost.localdomain (unknown [10.226.92.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E909942B36D8;
	Thu, 20 Feb 2025 22:04:53 +0900 (JST)
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
Subject: [PATCH v2 5/7] can: rcar_canfd: Add only_internal_clks variable to struct rcar_canfd_hw_info
Date: Thu, 20 Feb 2025 13:04:21 +0000
Message-ID: <20250220130427.217342-6-biju.das.jz@bp.renesas.com>
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

All SoCs supports extenal clock, but RZ/G3E has only internal clocks. Add
only_internal_clks to struct rcar_canfd_hw_info to handle this difference.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/net/can/rcar/rcar_canfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 13eb6aa6ae45..f353a9d560e8 100644
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


