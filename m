Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16403292AA8
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 17:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgJSPmq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Oct 2020 11:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730374AbgJSPmp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 11:42:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC466C0613D6
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2020 08:42:43 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kUXJ3-0000nY-UV; Mon, 19 Oct 2020 17:42:42 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-rfc 10/12] can: tcan4x5x: Move clock init to TCAN driver
Date:   Mon, 19 Oct 2020 17:42:31 +0200
Message-Id: <20201019154233.1262589-11-mkl@pengutronix.de>
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

Move the clock discovery and initialization from the m_can framework to the
registrar. This allows for registrars to have unique clock initialization.
The TCAN device only needs the CAN clock reference.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Link: http://lore.kernel.org/r/20200131183433.11041-2-dmurphy@ti.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x.c | 64 +++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index a2144bbcd486..a75ba0a6afc8 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -124,6 +124,8 @@ struct tcan4x5x_priv {
 	struct gpio_desc *device_state_gpio;
 	struct regulator *power;
 
+	struct clk *cclk;
+
 	/* Register based ip */
 	int mram_start;
 	int reg_offset;
@@ -429,7 +431,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 {
 	struct tcan4x5x_priv *priv;
 	struct m_can_classdev *mcan_class;
-	int freq, ret;
+	u32 freq;
+	int ret;
 
 	mcan_class = m_can_class_allocate_dev(&spi->dev);
 	if (!mcan_class)
@@ -451,16 +454,21 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	mcan_class->device_data = priv;
 
-	m_can_class_get_clocks(mcan_class);
-	if (IS_ERR(mcan_class->cclk)) {
+	priv->cclk = devm_clk_get_optional(&spi->dev, "cclk");
+	if (IS_ERR(priv->cclk)) {
+		return PTR_ERR(priv->cclk);
+	} else if (!priv->cclk) {
 		dev_err(&spi->dev, "no CAN clock source defined\n");
 		freq = TCAN4X5X_EXT_CLK_DEF;
 	} else {
-		freq = clk_get_rate(mcan_class->cclk);
+		freq = clk_get_rate(priv->cclk);
 	}
 
 	/* Sanity check */
 	if (freq < 20000000 || freq > TCAN4X5X_EXT_CLK_DEF) {
+		dev_err(&spi->dev,
+			"Oscillator frequency (%u Hz) is too low or high.\n",
+			freq);
 		ret = -ERANGE;
 		goto out_m_can_class_free_dev;
 	}
@@ -485,18 +493,18 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	spi->bits_per_word = 32;
 	ret = spi_setup(spi);
 	if (ret)
-		goto out_clk;
+		goto out_m_can_class_free_dev;
 
 	priv->regmap = devm_regmap_init(&spi->dev, &tcan4x5x_bus,
 					&spi->dev, &tcan4x5x_regmap);
 	if (IS_ERR(priv->regmap)) {
 		ret = PTR_ERR(priv->regmap);
-		goto out_clk;
+		goto out_m_can_class_free_dev;
 	}
 
 	ret = tcan4x5x_power_enable(priv->power, 1);
 	if (ret)
-		goto out_clk;
+		goto out_m_can_class_free_dev;
 
 	ret = tcan4x5x_get_gpios(mcan_class);
 	if (ret)
@@ -515,11 +523,6 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 out_power:
 	tcan4x5x_power_enable(priv->power, 0);
-out_clk:
-	if (!IS_ERR(mcan_class->cclk)) {
-		clk_disable_unprepare(mcan_class->cclk);
-		clk_disable_unprepare(mcan_class->hclk);
-	}
  out_m_can_class_free_dev:
 	m_can_class_free_dev(mcan_class->net);
 	dev_err(&spi->dev, "Probe failed, err=%d\n", ret);
@@ -540,6 +543,41 @@ static int tcan4x5x_can_remove(struct spi_device *spi)
 	return 0;
 }
 
+static int __maybe_unused tcan4x5x_runtime_suspend(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct m_can_classdev *mcan_class = netdev_priv(ndev);
+	struct tcan4x5x_priv *priv = mcan_class->device_data;
+	int err;
+
+	err = m_can_class_suspend(dev);
+	if (err)
+		return err;
+
+	clk_disable_unprepare(priv->cclk);
+
+	return 0;
+}
+
+static int __maybe_unused tcan4x5x_runtime_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct m_can_classdev *mcan_class = netdev_priv(ndev);
+	struct tcan4x5x_priv *priv = mcan_class->device_data;
+	int err;
+
+	err = clk_prepare_enable(priv->cclk);
+	if (err)
+		return err;
+
+	return m_can_class_resume(dev);
+}
+
+static const struct dev_pm_ops tcan4x5x_pmops = {
+	SET_RUNTIME_PM_OPS(tcan4x5x_runtime_suspend,
+			   tcan4x5x_runtime_resume, NULL)
+};
+
 static const struct of_device_id tcan4x5x_of_match[] = {
 	{ .compatible = "ti,tcan4x5x", },
 	{ }
@@ -559,7 +597,7 @@ static struct spi_driver tcan4x5x_can_driver = {
 	.driver = {
 		.name = DEVICE_NAME,
 		.of_match_table = tcan4x5x_of_match,
-		.pm = NULL,
+		.pm = &tcan4x5x_pmops,
 	},
 	.id_table = tcan4x5x_id_table,
 	.probe = tcan4x5x_can_probe,
-- 
2.28.0

