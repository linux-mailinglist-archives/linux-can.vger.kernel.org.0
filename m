Return-Path: <linux-can+bounces-4235-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B664B264DA
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 14:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FE11CC3162
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 12:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862E62FCC18;
	Thu, 14 Aug 2025 12:02:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F822FCC14;
	Thu, 14 Aug 2025 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172944; cv=none; b=jnedPnOv5Z+P43eIV7ASG+4fdwkRhLbbFcGq7UCaCeDJLx3BBiGSYybXWW+VCzdIxJUCsPAFsnLagMO4dbq4XlH7Z7ximBE3KTS6CHQezWY4jr6VQ9klLY7o6itkLRSGnBK98cCIkzOwID1O2AurrphKABwb+LGIB4K3WHDFLNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172944; c=relaxed/simple;
	bh=VpZo0OMgEK7g4eWTG6KbsFhKY1DCsp/kh2Z3/bD9nE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwhpfn11RiybGed5uCydY0YSfR9Fh+Xgp9WLsmVaoHhpoA8X74rnwvj4hg5yKVb7AO2W+ZN8F9omg76z90EvPIKYPjlFXKjBZn8VWvJhG0p9Q2JxVlkzX/IWbn7Rqm9oYOVGnMB5Q/G2AX2KEiSkc01KFmrLJYAyufQMPoEUgRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5777C4CEF6;
	Thu, 14 Aug 2025 12:02:22 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/9] can: rcar_can: Convert to Runtime PM
Date: Thu, 14 Aug 2025 14:02:01 +0200
Message-ID: <ae8fdd96d926ddd2c699ec2795a4c9937c3f3bc3.1755172404.git.geert+renesas@glider.be>
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

The R-Car CAN module is part of a Clock Domain on all supported SoCs.
Hence convert its driver from explicit clock management to Runtime PM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_can.c | 46 +++++++++++++++++----------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 57030992141cc523..aecbb02c7dc9c90a 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -16,6 +16,7 @@
 #include <linux/can/dev.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 
 #define RCAR_CAN_DRV_NAME	"rcar_can"
 
@@ -92,7 +93,6 @@ struct rcar_can_priv {
 	struct net_device *ndev;
 	struct napi_struct napi;
 	struct rcar_can_regs __iomem *regs;
-	struct clk *clk;
 	struct clk *can_clk;
 	u32 tx_head;
 	u32 tx_tail;
@@ -506,10 +506,10 @@ static int rcar_can_open(struct net_device *ndev)
 	struct rcar_can_priv *priv = netdev_priv(ndev);
 	int err;
 
-	err = clk_prepare_enable(priv->clk);
+	err = pm_runtime_resume_and_get(ndev->dev.parent);
 	if (err) {
 		netdev_err(ndev,
-			   "failed to enable peripheral clock, error %d\n",
+			   "pm_runtime_resume_and_get() failed, error %d\n",
 			   err);
 		goto out;
 	}
@@ -517,7 +517,7 @@ static int rcar_can_open(struct net_device *ndev)
 	if (err) {
 		netdev_err(ndev, "failed to enable CAN clock, error %d\n",
 			   err);
-		goto out_clock;
+		goto out_rpm;
 	}
 	err = open_candev(ndev);
 	if (err) {
@@ -539,8 +539,8 @@ static int rcar_can_open(struct net_device *ndev)
 	close_candev(ndev);
 out_can_clock:
 	clk_disable_unprepare(priv->can_clk);
-out_clock:
-	clk_disable_unprepare(priv->clk);
+out_rpm:
+	pm_runtime_put(ndev->dev.parent);
 out:
 	return err;
 }
@@ -578,7 +578,7 @@ static int rcar_can_close(struct net_device *ndev)
 	free_irq(ndev->irq, ndev);
 	napi_disable(&priv->napi);
 	clk_disable_unprepare(priv->can_clk);
-	clk_disable_unprepare(priv->clk);
+	pm_runtime_put(ndev->dev.parent);
 	close_candev(ndev);
 	return 0;
 }
@@ -721,12 +721,15 @@ static int rcar_can_get_berr_counter(const struct net_device *ndev,
 	struct rcar_can_priv *priv = netdev_priv(ndev);
 	int err;
 
-	err = clk_prepare_enable(priv->clk);
+	err = pm_runtime_resume_and_get(ndev->dev.parent);
 	if (err)
 		return err;
+
 	bec->txerr = readb(&priv->regs->tecr);
 	bec->rxerr = readb(&priv->regs->recr);
-	clk_disable_unprepare(priv->clk);
+
+	pm_runtime_put(ndev->dev.parent);
+
 	return 0;
 }
 
@@ -770,13 +773,6 @@ static int rcar_can_probe(struct platform_device *pdev)
 
 	priv = netdev_priv(ndev);
 
-	priv->clk = devm_clk_get(dev, "clkp1");
-	if (IS_ERR(priv->clk)) {
-		err = PTR_ERR(priv->clk);
-		dev_err(dev, "cannot get peripheral clock, error %d\n", err);
-		goto fail_clk;
-	}
-
 	if (!(BIT(clock_select) & RCAR_SUPPORTED_CLOCKS)) {
 		err = -EINVAL;
 		dev_err(dev, "invalid CAN clock selected\n");
@@ -806,16 +802,20 @@ static int rcar_can_probe(struct platform_device *pdev)
 
 	netif_napi_add_weight(ndev, &priv->napi, rcar_can_rx_poll,
 			      RCAR_CAN_NAPI_WEIGHT);
+
+	pm_runtime_enable(dev);
+
 	err = register_candev(ndev);
 	if (err) {
 		dev_err(dev, "register_candev() failed, error %d\n", err);
-		goto fail_candev;
+		goto fail_rpm;
 	}
 
 	dev_info(dev, "device registered (IRQ%d)\n", ndev->irq);
 
 	return 0;
-fail_candev:
+fail_rpm:
+	pm_runtime_disable(dev);
 	netif_napi_del(&priv->napi);
 fail_clk:
 	free_candev(ndev);
@@ -829,6 +829,7 @@ static void rcar_can_remove(struct platform_device *pdev)
 	struct rcar_can_priv *priv = netdev_priv(ndev);
 
 	unregister_candev(ndev);
+	pm_runtime_disable(&pdev->dev);
 	netif_napi_del(&priv->napi);
 	free_candev(ndev);
 }
@@ -852,22 +853,23 @@ static int rcar_can_suspend(struct device *dev)
 	writew(ctlr, &priv->regs->ctlr);
 	priv->can.state = CAN_STATE_SLEEPING;
 
-	clk_disable(priv->clk);
+	pm_runtime_put(dev);
 	return 0;
 }
 
 static int rcar_can_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
-	struct rcar_can_priv *priv = netdev_priv(ndev);
 	int err;
 
 	if (!netif_running(ndev))
 		return 0;
 
-	err = clk_enable(priv->clk);
+	err = pm_runtime_resume_and_get(dev);
 	if (err) {
-		netdev_err(ndev, "clk_enable() failed, error %d\n", err);
+		netdev_err(ndev,
+			   "pm_runtime_resume_and_get() failed, error %d\n",
+			   err);
 		return err;
 	}
 
-- 
2.43.0


