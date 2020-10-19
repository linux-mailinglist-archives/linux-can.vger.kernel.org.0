Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838CD292AA9
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 17:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgJSPmq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Oct 2020 11:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbgJSPmp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 11:42:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342BCC0613D7
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2020 08:42:44 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kUXJ4-0000nY-8b; Mon, 19 Oct 2020 17:42:42 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-rfc 11/12] can: m_can_platform: Move clock discovery and init to platform
Date:   Mon, 19 Oct 2020 17:42:32 +0200
Message-Id: <20201019154233.1262589-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019154233.1262589-1-mkl@pengutronix.de>
References: <20201019154233.1262589-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>

Move the clock discovery and init to the platform driver as the platform driver
needs an additional clock to the CAN clock to be initilialized and managed.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Link: http://lore.kernel.org/r/20200131183433.11041-3-dmurphy@ti.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can_platform.c | 35 ++++++++++++++++++++------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 161cb9be018c..b5b7b77909d3 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -12,6 +12,9 @@
 struct m_can_plat_priv {
 	void __iomem *base;
 	void __iomem *mram_base;
+
+	struct clk *hclk;
+	struct clk *cclk;
 };
 
 static u32 iomap_read_reg(struct m_can_classdev *cdev, int reg)
@@ -53,6 +56,22 @@ static struct m_can_ops m_can_plat_ops = {
 	.read_fifo = iomap_read_fifo,
 };
 
+static int m_can_plat_get_clocks(struct m_can_plat_priv *priv,
+				 struct m_can_classdev *mcan_class)
+{
+	int ret = 0;
+
+	priv->hclk = devm_clk_get(mcan_class->dev, "hclk");
+
+	priv->cclk = devm_clk_get(mcan_class->dev, "cclk");
+	if (IS_ERR(priv->cclk)) {
+		dev_err(mcan_class->dev, "no clock found\n");
+		ret = -ENODEV;
+	}
+
+	return ret;
+}
+
 static int m_can_plat_probe(struct platform_device *pdev)
 {
 	struct m_can_classdev *mcan_class;
@@ -74,7 +93,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	mcan_class->device_data = priv;
 
-	ret = m_can_class_get_clocks(mcan_class);
+	ret = m_can_plat_get_clocks(priv, mcan_class);
 	if (ret)
 		goto probe_fail;
 
@@ -104,7 +123,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	mcan_class->net->irq = irq;
 	mcan_class->pm_clock_support = 1;
-	mcan_class->can.clock.freq = clk_get_rate(mcan_class->cclk);
+	mcan_class->can.clock.freq = clk_get_rate(priv->cclk);
 	mcan_class->dev = &pdev->dev;
 
 	mcan_class->ops = &m_can_plat_ops;
@@ -150,9 +169,10 @@ static int __maybe_unused m_can_runtime_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct m_can_classdev *mcan_class = netdev_priv(ndev);
+	struct m_can_plat_priv *priv = mcan_class->device_data;
 
-	clk_disable_unprepare(mcan_class->cclk);
-	clk_disable_unprepare(mcan_class->hclk);
+	clk_disable_unprepare(priv->cclk);
+	clk_disable_unprepare(priv->hclk);
 
 	return 0;
 }
@@ -161,15 +181,16 @@ static int __maybe_unused m_can_runtime_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct m_can_classdev *mcan_class = netdev_priv(ndev);
+	struct m_can_plat_priv *priv = mcan_class->device_data;
 	int err;
 
-	err = clk_prepare_enable(mcan_class->hclk);
+	err = clk_prepare_enable(priv->hclk);
 	if (err)
 		return err;
 
-	err = clk_prepare_enable(mcan_class->cclk);
+	err = clk_prepare_enable(priv->cclk);
 	if (err)
-		clk_disable_unprepare(mcan_class->hclk);
+		clk_disable_unprepare(priv->hclk);
 
 	return err;
 }
-- 
2.28.0

