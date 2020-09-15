Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EFD26B1D8
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 00:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgIOWhA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Sep 2020 18:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbgIOWfo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 18:35:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01431C06121E
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2020 15:35:38 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIJXz-0002Tb-8W; Wed, 16 Sep 2020 00:35:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dejin Zheng <zhengdejin5@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 17/37] can: ti_hecc: convert to devm_platform_ioremap_resource_byname()
Date:   Wed, 16 Sep 2020 00:35:07 +0200
Message-Id: <20200915223527.1417033-18-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915223527.1417033-1-mkl@pengutronix.de>
References: <20200915223527.1417033-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Dejin Zheng <zhengdejin5@gmail.com>

Use the function devm_platform_ioremap_resource_byname() to simplify
source code which calls the functions platform_get_resource_byname()
and devm_ioremap_resource(). Remove also a few error messages which
became unnecessary with this software refactoring.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
Link: https://lore.kernel.org/r/20200420132207.8536-1-zhengdejin5@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ti_hecc.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index fc76f7ad735a..1d63006c97bc 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -857,7 +857,7 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	struct net_device *ndev = (struct net_device *)0;
 	struct ti_hecc_priv *priv;
 	struct device_node *np = pdev->dev.of_node;
-	struct resource *res, *irq;
+	struct resource *irq;
 	struct regulator *reg_xceiver;
 	int err = -ENODEV;
 
@@ -878,39 +878,22 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	priv = netdev_priv(ndev);
 
 	/* handle hecc memory */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hecc");
-	if (!res) {
-		dev_err(&pdev->dev, "can't get IORESOURCE_MEM hecc\n");
-		return -EINVAL;
-	}
-
-	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	priv->base = devm_platform_ioremap_resource_byname(pdev, "hecc");
 	if (IS_ERR(priv->base)) {
 		dev_err(&pdev->dev, "hecc ioremap failed\n");
 		return PTR_ERR(priv->base);
 	}
 
 	/* handle hecc-ram memory */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hecc-ram");
-	if (!res) {
-		dev_err(&pdev->dev, "can't get IORESOURCE_MEM hecc-ram\n");
-		return -EINVAL;
-	}
-
-	priv->hecc_ram = devm_ioremap_resource(&pdev->dev, res);
+	priv->hecc_ram = devm_platform_ioremap_resource_byname(pdev,
+							       "hecc-ram");
 	if (IS_ERR(priv->hecc_ram)) {
 		dev_err(&pdev->dev, "hecc-ram ioremap failed\n");
 		return PTR_ERR(priv->hecc_ram);
 	}
 
 	/* handle mbx memory */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mbx");
-	if (!res) {
-		dev_err(&pdev->dev, "can't get IORESOURCE_MEM mbx\n");
-		return -EINVAL;
-	}
-
-	priv->mbx = devm_ioremap_resource(&pdev->dev, res);
+	priv->mbx = devm_platform_ioremap_resource_byname(pdev, "mbx");
 	if (IS_ERR(priv->mbx)) {
 		dev_err(&pdev->dev, "mbx ioremap failed\n");
 		return PTR_ERR(priv->mbx);
-- 
2.28.0

