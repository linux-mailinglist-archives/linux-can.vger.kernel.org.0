Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F9F14F24A
	for <lists+linux-can@lfdr.de>; Fri, 31 Jan 2020 19:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgAaSiH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 31 Jan 2020 13:38:07 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49248 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgAaSiH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2020 13:38:07 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00VIbrPi064181;
        Fri, 31 Jan 2020 12:37:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580495873;
        bh=1CLE5t35I9JOObXscYgWNJZH4eruW4hlu6p3toaDm7U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=db44KCjWi6bQpAf1rYr94vLvAwQ413tzA4St51wj9QiXio85oT+KcYoR3XuMEcyc/
         ri4mmODgiztq8FiDt8TPxSJiw5R4y+1T0fBqNogJT4ty/kLims5chn7zyhkvtN9c8Z
         DGNLG0Xa+nyuFAn77PJ8nHjXVlM0tEz6XRg6AzQU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00VIbrgH103823;
        Fri, 31 Jan 2020 12:37:53 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 31
 Jan 2020 12:37:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 31 Jan 2020 12:37:53 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00VIbrLE055578;
        Fri, 31 Jan 2020 12:37:53 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-kernel@vger.kernel.org>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <wg@grandegger.com>,
        <sriram.dash@samsung.com>
CC:     <davem@davemloft.net>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH linux-master 1/3] can: tcan4x5x: Move clock init to TCAN driver
Date:   Fri, 31 Jan 2020 12:34:31 -0600
Message-ID: <20200131183433.11041-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131183433.11041-1-dmurphy@ti.com>
References: <20200131183433.11041-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Move the clock discovery and initialization from the m_can framework to
the registrar.  This allows for registrars to have unique clock
initialization.  The TCAN device only needs the CAN clock reference.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/can/m_can/tcan4x5x.c | 78 ++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index eacd428e07e9..9821babef55e 100644
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
@@ -429,6 +431,27 @@ static struct m_can_ops tcan4x5x_ops = {
 	.clear_interrupts = tcan4x5x_clear_interrupts,
 };
 
+static int tcan4x5x_get_clock(struct tcan4x5x_priv *priv,
+			      struct m_can_classdev *m_can_dev)
+{
+	int freq;
+
+	priv->cclk = devm_clk_get(m_can_dev->dev, "cclk");
+	if (IS_ERR(priv->cclk)) {
+		dev_err(m_can_dev->dev, "no CAN clock source defined\n");
+		freq = TCAN4X5X_EXT_CLK_DEF;
+		priv->cclk = NULL;
+
+	} else {
+		freq = clk_get_rate(priv->cclk);
+		/* Sanity check */
+		if (freq < 20000000 || freq > TCAN4X5X_EXT_CLK_DEF)
+			return -ERANGE;
+	}
+
+	return freq;
+}
+
 static int tcan4x5x_can_probe(struct spi_device *spi)
 {
 	struct tcan4x5x_priv *priv;
@@ -451,17 +474,9 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	mcan_class->device_data = priv;
 
-	m_can_class_get_clocks(mcan_class);
-	if (IS_ERR(mcan_class->cclk)) {
-		dev_err(&spi->dev, "no CAN clock source defined\n");
-		freq = TCAN4X5X_EXT_CLK_DEF;
-	} else {
-		freq = clk_get_rate(mcan_class->cclk);
-	}
-
-	/* Sanity check */
-	if (freq < 20000000 || freq > TCAN4X5X_EXT_CLK_DEF)
-		return -ERANGE;
+	freq = tcan4x5x_get_clock(priv, mcan_class);
+	if (freq < 0)
+		return freq;
 
 	priv->reg_offset = TCAN4X5X_MCAN_OFFSET;
 	priv->mram_start = TCAN4X5X_MRAM_START;
@@ -483,14 +498,14 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	spi->bits_per_word = 32;
 	ret = spi_setup(spi);
 	if (ret)
-		goto out_clk;
+		return ret;
 
 	priv->regmap = devm_regmap_init(&spi->dev, &tcan4x5x_bus,
 					&spi->dev, &tcan4x5x_regmap);
 
 	ret = tcan4x5x_power_enable(priv->power, 1);
 	if (ret)
-		goto out_clk;
+		return ret;
 
 	ret = tcan4x5x_parse_config(mcan_class);
 	if (ret)
@@ -509,12 +524,6 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 out_power:
 	tcan4x5x_power_enable(priv->power, 0);
-out_clk:
-	if (!IS_ERR(mcan_class->cclk)) {
-		clk_disable_unprepare(mcan_class->cclk);
-		clk_disable_unprepare(mcan_class->hclk);
-	}
-
 	dev_err(&spi->dev, "Probe failed, err=%d\n", ret);
 	return ret;
 }
@@ -530,6 +539,37 @@ static int tcan4x5x_can_remove(struct spi_device *spi)
 	return 0;
 }
 
+static int __maybe_unused tcan4x5x_runtime_suspend(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct m_can_classdev *mcan_class = netdev_priv(ndev);
+	struct tcan4x5x_priv *priv = mcan_class->device_data;
+
+	m_can_class_suspend(dev);
+
+	if (priv->cclk)
+		clk_disable_unprepare(priv->cclk);
+
+	return 0;
+}
+
+static int __maybe_unused tcan4x5x_runtime_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct m_can_classdev *mcan_class = netdev_priv(ndev);
+	struct tcan4x5x_priv *priv = mcan_class->device_data;
+
+	if (priv->cclk)
+		return clk_prepare_enable(priv->cclk);
+
+	return 0;
+}
+
+static const struct dev_pm_ops m_can_pmops = {
+	SET_RUNTIME_PM_OPS(tcan4x5x_runtime_suspend,
+			   tcan4x5x_runtime_resume, NULL)
+};
+
 static const struct of_device_id tcan4x5x_of_match[] = {
 	{ .compatible = "ti,tcan4x5x", },
 	{ }
-- 
2.25.0

