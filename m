Return-Path: <linux-can+bounces-4915-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B17B98CAC
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46021733B6
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DAF284670;
	Wed, 24 Sep 2025 08:21:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5C284890
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702103; cv=none; b=Oj2eMpqFANBPYeKd/q5Clxz7NOMMb0oqd/JFn6AiiDqaQvJ9GSV6R1+LNEDhvfFTPwXbeFFjm/GMlIeBpALBr/PoHfXoTiWSpzh8auUsWEA72X4Ia4eHGnHrY180Ik5WmjDymIaEkUnB4/NvIUZKGwhdnhIZvPQiaVvP1XtdQP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702103; c=relaxed/simple;
	bh=M/ntwWkRcMSeeAuxA1GvbveI4LPTahtD5a0uxKFl5Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K49Hm/f/5sF2U2UU7aMKodgIecPbVr5XBWfg/zoQoREv0chNRTFWoncmczphv+pIlQhQ17vOtJKfSLviAnbkH7T8baEHat4kBzOyAmpQRt3UxQd6TSa3zYoNZt4mRUqa0WXdTUfef1TJkswaj2SsbHOy0lSx6M1mfPa1jEt4KK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-0001Dz-BU; Wed, 24 Sep 2025 10:21:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkc-000DvG-0Q;
	Wed, 24 Sep 2025 10:21:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1D7BE47887A;
	Wed, 24 Sep 2025 08:21:08 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/48] can: rcar_can: Convert to Runtime PM
Date: Wed, 24 Sep 2025 10:06:28 +0200
Message-ID: <20250924082104.595459-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The R-Car CAN module is part of a Clock Domain on all supported SoCs.
Hence convert its driver from explicit clock management to Runtime PM.

While at it, use %pe to format error codes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/68bfa5480a79c17c6ceec4fb073f33872e7ff5d0.1755857536.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c | 48 ++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 57030992141c..15dbaa52a7b1 100644
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
2.51.0


