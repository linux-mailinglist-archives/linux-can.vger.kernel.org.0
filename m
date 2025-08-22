Return-Path: <linux-can+bounces-4313-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B679B314FA
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 12:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE28604FB1
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29994285CBA;
	Fri, 22 Aug 2025 10:17:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C921ABC9;
	Fri, 22 Aug 2025 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857844; cv=none; b=C3QwXrD0o9beghPmlFIDfkbQZnZjZR2KoyQk2DBTUq9850psdA/o68g8fOfEvdorYEz2vtn3qBj3cmqbvO1J3DQu77rvorKl6I+c+to0u7Q/Zq9i6c0nvEj8/jd3MN1rHzOfa2WHLoGB7PJthx26BfycJ0YjDEiAVfokNBwY/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857844; c=relaxed/simple;
	bh=y8iHfDYnT+ebTrkYFSTHXVZ8TVOUCY2XWkJNZ1oxxUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPkY1RaQF18YRrQ8Y/ICqf460MH22I7KZCU9NguiIngHEaabjd4dmuJ1dbhRDYCAbvqZ6dbz4xd6bTQ1JPtyJ51+N+yawlx1gmZZ6wRR/nvoe5AA8UqELtX638BmOK/ImEMTCRQUz2hcvVnAi6zkdlf0McPzwqKPvRCcN6Igg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C890C4CEF1;
	Fri, 22 Aug 2025 10:17:22 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 03/11] can: rcar_can: Convert to Runtime PM
Date: Fri, 22 Aug 2025 12:17:04 +0200
Message-ID: <68bfa5480a79c17c6ceec4fb073f33872e7ff5d0.1755857536.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755857536.git.geert+renesas@glider.be>
References: <cover.1755857536.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The R-Car CAN module is part of a Clock Domain on all supported SoCs.
Hence convert its driver from explicit clock management to Runtime PM.

While at it, use %pe to format error codes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Convert to %pe.
---
 drivers/net/can/rcar/rcar_can.c | 48 ++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 57030992141cc523..15dbaa52a7b135d9 100644
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
@@ -506,18 +506,17 @@ static int rcar_can_open(struct net_device *ndev)
 	struct rcar_can_priv *priv = netdev_priv(ndev);
 	int err;
 
-	err = clk_prepare_enable(priv->clk);
+	err = pm_runtime_resume_and_get(ndev->dev.parent);
 	if (err) {
-		netdev_err(ndev,
-			   "failed to enable peripheral clock, error %d\n",
-			   err);
+		netdev_err(ndev, "pm_runtime_resume_and_get() failed %pe\n",
+			   ERR_PTR(err));
 		goto out;
 	}
 	err = clk_prepare_enable(priv->can_clk);
 	if (err) {
 		netdev_err(ndev, "failed to enable CAN clock, error %d\n",
 			   err);
-		goto out_clock;
+		goto out_rpm;
 	}
 	err = open_candev(ndev);
 	if (err) {
@@ -539,8 +538,8 @@ static int rcar_can_open(struct net_device *ndev)
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
@@ -578,7 +577,7 @@ static int rcar_can_close(struct net_device *ndev)
 	free_irq(ndev->irq, ndev);
 	napi_disable(&priv->napi);
 	clk_disable_unprepare(priv->can_clk);
-	clk_disable_unprepare(priv->clk);
+	pm_runtime_put(ndev->dev.parent);
 	close_candev(ndev);
 	return 0;
 }
@@ -721,12 +720,15 @@ static int rcar_can_get_berr_counter(const struct net_device *ndev,
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
 
@@ -770,13 +772,6 @@ static int rcar_can_probe(struct platform_device *pdev)
 
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
@@ -806,16 +801,20 @@ static int rcar_can_probe(struct platform_device *pdev)
 
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
@@ -829,6 +828,7 @@ static void rcar_can_remove(struct platform_device *pdev)
 	struct rcar_can_priv *priv = netdev_priv(ndev);
 
 	unregister_candev(ndev);
+	pm_runtime_disable(&pdev->dev);
 	netif_napi_del(&priv->napi);
 	free_candev(ndev);
 }
@@ -852,22 +852,22 @@ static int rcar_can_suspend(struct device *dev)
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
+		netdev_err(ndev, "pm_runtime_resume_and_get() failed %pe\n",
+			   ERR_PTR(err));
 		return err;
 	}
 
-- 
2.43.0


