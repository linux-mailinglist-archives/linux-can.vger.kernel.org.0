Return-Path: <linux-can+bounces-4234-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B43AB264DC
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 14:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B732A2894
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 12:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84932FCBFD;
	Thu, 14 Aug 2025 12:02:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96072FC892;
	Thu, 14 Aug 2025 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172942; cv=none; b=HUiJemq0DXJHFSmcoj/+GX9WEzrJ8mvTJ+a5CpyyuRWOy7l2L/8qPhlH7QKul/hrM9A5IINWQITGBbqZG6uW9/dFG/Jjw5vv9h/RUtOmFTSzKVjdrIkCFVd73kzEhX7SdRg0CWjSpcBnIEHBPnZO1lsrmxFvPZJ/+MlcBdyfEEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172942; c=relaxed/simple;
	bh=ZgmFd4XABtbHXDDYQlMhGGPwgjB0MyJAYKsdEm3WWVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4O3IvMVQbFFA2wpZWLdSR//AuUsFPdS/9dmoCiMHO2Vu+H9eW19ywDkCP4Tw+BpMTxhel/DOfoOOZA00UtjxNxILHZSPdibXVt8fVs5Ecy1+cHlqsfgS7RCLrr7cClHlDu6wib1oeLGpPKpvrMl3ErmHpFQvZ2YBlfIISX0xA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A53C4CEED;
	Thu, 14 Aug 2025 12:02:21 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/9] can: rcar_can: Add helper variable dev to rcar_can_probe()
Date: Thu, 14 Aug 2025 14:02:00 +0200
Message-ID: <d56c94d4483c7b2830c565e0f02b7e6f48a873be.1755172404.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755172404.git.geert+renesas@glider.be>
References: <cover.1755172404.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rcar_can_probe() has many users of "pdev->dev".  Introduce a shorthand
to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_can.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 5b0b495d127cdcb3..57030992141cc523 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -738,6 +738,7 @@ static const char * const clock_names[] = {
 
 static int rcar_can_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct rcar_can_priv *priv;
 	struct net_device *ndev;
 	void __iomem *addr;
@@ -745,7 +746,7 @@ static int rcar_can_probe(struct platform_device *pdev)
 	int err = -ENODEV;
 	int irq;
 
-	of_property_read_u32(pdev->dev.of_node, "renesas,can-clock-select",
+	of_property_read_u32(dev->of_node, "renesas,can-clock-select",
 			     &clock_select);
 
 	irq = platform_get_irq(pdev, 0);
@@ -762,30 +763,29 @@ static int rcar_can_probe(struct platform_device *pdev)
 
 	ndev = alloc_candev(sizeof(struct rcar_can_priv), RCAR_CAN_FIFO_DEPTH);
 	if (!ndev) {
-		dev_err(&pdev->dev, "alloc_candev() failed\n");
+		dev_err(dev, "alloc_candev() failed\n");
 		err = -ENOMEM;
 		goto fail;
 	}
 
 	priv = netdev_priv(ndev);
 
-	priv->clk = devm_clk_get(&pdev->dev, "clkp1");
+	priv->clk = devm_clk_get(dev, "clkp1");
 	if (IS_ERR(priv->clk)) {
 		err = PTR_ERR(priv->clk);
-		dev_err(&pdev->dev, "cannot get peripheral clock, error %d\n",
-			err);
+		dev_err(dev, "cannot get peripheral clock, error %d\n", err);
 		goto fail_clk;
 	}
 
 	if (!(BIT(clock_select) & RCAR_SUPPORTED_CLOCKS)) {
 		err = -EINVAL;
-		dev_err(&pdev->dev, "invalid CAN clock selected\n");
+		dev_err(dev, "invalid CAN clock selected\n");
 		goto fail_clk;
 	}
-	priv->can_clk = devm_clk_get(&pdev->dev, clock_names[clock_select]);
+	priv->can_clk = devm_clk_get(dev, clock_names[clock_select]);
 	if (IS_ERR(priv->can_clk)) {
 		err = PTR_ERR(priv->can_clk);
-		dev_err(&pdev->dev, "cannot get CAN clock, error %d\n", err);
+		dev_err(dev, "cannot get CAN clock, error %d\n", err);
 		goto fail_clk;
 	}
 
@@ -802,18 +802,17 @@ static int rcar_can_probe(struct platform_device *pdev)
 	priv->can.do_get_berr_counter = rcar_can_get_berr_counter;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
 	platform_set_drvdata(pdev, ndev);
-	SET_NETDEV_DEV(ndev, &pdev->dev);
+	SET_NETDEV_DEV(ndev, dev);
 
 	netif_napi_add_weight(ndev, &priv->napi, rcar_can_rx_poll,
 			      RCAR_CAN_NAPI_WEIGHT);
 	err = register_candev(ndev);
 	if (err) {
-		dev_err(&pdev->dev, "register_candev() failed, error %d\n",
-			err);
+		dev_err(dev, "register_candev() failed, error %d\n", err);
 		goto fail_candev;
 	}
 
-	dev_info(&pdev->dev, "device registered (IRQ%d)\n", ndev->irq);
+	dev_info(dev, "device registered (IRQ%d)\n", ndev->irq);
 
 	return 0;
 fail_candev:
-- 
2.43.0


