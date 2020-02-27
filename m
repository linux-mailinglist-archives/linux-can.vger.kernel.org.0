Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A6B1727D8
	for <lists+linux-can@lfdr.de>; Thu, 27 Feb 2020 19:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgB0Snw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 27 Feb 2020 13:43:52 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60976 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgB0Snw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 27 Feb 2020 13:43:52 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01RIhiZf129763;
        Thu, 27 Feb 2020 12:43:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582829024;
        bh=OHfOwg5rnPs6mGndmNwKyaJQl4IXGadGC0Or8nxVXto=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=r9kj42N4DEohw6+9SB/UoLFEgu6arNMRRMaPtaXep72e6VRoB9HhLVFelPjgBKczc
         Yt6Ox8XSpRDgYI6wnErG+AZY7OGAkhDb9mqEiBl7qAzmGsBFmF3C2LMNCK/sNQMwuE
         TXYzuRsJzwXHSK/VIngoWxDPYXqZd9h7ymPaLUi8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01RIhiXS025895
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Feb 2020 12:43:44 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 27
 Feb 2020 12:43:44 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 27 Feb 2020 12:43:43 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01RIhijk115497;
        Thu, 27 Feb 2020 12:43:44 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <mkl@pengutronix.de>, <wg@grandegger.com>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH can-next 2/2] net: m_can: Fix freeing of can device from peripherials
Date:   Thu, 27 Feb 2020 12:38:29 -0600
Message-ID: <20200227183829.21854-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227183829.21854-1-dmurphy@ti.com>
References: <20200227183829.21854-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fix leaking netdev device from peripherial devices.  The call to
allocate the netdev device is made from and managed by the peripherial.

Create a common function that peripherials can call to free the netdev
device when failures occur.

Fixes: d42f4e1d06d9 ("can: m_can: Create a m_can platform framework")
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/can/m_can/m_can.c          |  9 ++++---
 drivers/net/can/m_can/m_can.h          |  2 ++
 drivers/net/can/m_can/m_can_platform.c | 21 ++++++++++------
 drivers/net/can/m_can/tcan4x5x.c       | 35 ++++++++++++++++----------
 4 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 5794be1ef3ef..b1eca4aa59f8 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1796,6 +1796,12 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
 
+void m_can_class_free_dev(struct net_device *net)
+{
+	free_candev(net);
+}
+EXPORT_SYMBOL_GPL(m_can_class_free_dev);
+
 int m_can_class_register(struct m_can_classdev *m_can_dev)
 {
 	int ret;
@@ -1834,7 +1840,6 @@ int m_can_class_register(struct m_can_classdev *m_can_dev)
 	if (ret) {
 		if (m_can_dev->pm_clock_support)
 			pm_runtime_disable(m_can_dev->dev);
-		free_candev(m_can_dev->net);
 	}
 
 	return ret;
@@ -1892,8 +1897,6 @@ void m_can_class_unregister(struct m_can_classdev *m_can_dev)
 	unregister_candev(m_can_dev->net);
 
 	m_can_clk_stop(m_can_dev);
-
-	free_candev(m_can_dev->net);
 }
 EXPORT_SYMBOL_GPL(m_can_class_unregister);
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index c20a716b14cc..fa6dba3a893c 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -97,6 +97,7 @@ struct m_can_classdev {
 };
 
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev);
+void m_can_class_free_dev(struct net_device *net);
 int m_can_class_register(struct m_can_classdev *cdev);
 void m_can_class_unregister(struct m_can_classdev *cdev);
 void m_can_init_ram(struct m_can_classdev *priv);
@@ -104,4 +105,5 @@ void m_can_config_endisable(struct m_can_classdev *priv, bool enable);
 
 int m_can_class_suspend(struct device *dev);
 int m_can_class_resume(struct device *dev);
+
 #endif	/* _CAN_M_H_ */
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 8bd459317eba..275f87931529 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -86,34 +86,36 @@ static int m_can_plat_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	if (!priv) {
+		ret = -ENOMEM;
+		goto probe_fail;
+	}
 
 	mcan_class->device_data = priv;
 
 	ret = m_can_plat_get_clocks(priv, mcan_class);
 	if (ret)
-		return ret;
+		goto probe_fail;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
 	addr = devm_ioremap_resource(&pdev->dev, res);
 	irq = platform_get_irq_byname(pdev, "int0");
 	if (IS_ERR(addr) || irq < 0) {
 		ret = -EINVAL;
-		goto failed_ret;
+		goto probe_fail;
 	}
 
 	/* message ram could be shared */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
 	if (!res) {
 		ret = -ENODEV;
-		goto failed_ret;
+		goto probe_fail;
 	}
 
 	mram_addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!mram_addr) {
 		ret = -ENOMEM;
-		goto failed_ret;
+		goto probe_fail;
 	}
 
 	priv->base = addr;
@@ -132,9 +134,10 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	m_can_init_ram(mcan_class);
 
-	ret = m_can_class_register(mcan_class);
+	return m_can_class_register(mcan_class);
 
-failed_ret:
+probe_fail:
+	m_can_class_free_dev(mcan_class->net);
 	return ret;
 }
 
@@ -155,6 +158,8 @@ static int m_can_plat_remove(struct platform_device *pdev)
 
 	m_can_class_unregister(mcan_class);
 
+	m_can_class_free_dev(mcan_class->net);
+
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 37d53ecc560b..0b6acc3caf25 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -463,20 +463,26 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	if (!priv) {
+		ret = -ENOMEM;
+		goto probe_fail;
+	}
 
 	priv->power = devm_regulator_get_optional(&spi->dev, "vsup");
-	if (PTR_ERR(priv->power) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-	else
+	if (PTR_ERR(priv->power) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto probe_fail;
+	} else {
 		priv->power = NULL;
+	}
 
 	mcan_class->device_data = priv;
 
 	freq = tcan4x5x_get_clock(priv, mcan_class);
-	if (freq < 0)
-		return freq;
+	if (freq < 0) {
+		ret = -EINVAL;
+		goto probe_fail;
+	}
 
 	priv->reg_offset = TCAN4X5X_MCAN_OFFSET;
 	priv->mram_start = TCAN4X5X_MRAM_START;
@@ -498,32 +504,33 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	spi->bits_per_word = 32;
 	ret = spi_setup(spi);
 	if (ret)
-		return ret;
+		goto probe_fail;
 
 	priv->regmap = devm_regmap_init(&spi->dev, &tcan4x5x_bus,
 					&spi->dev, &tcan4x5x_regmap);
 
 	ret = tcan4x5x_power_enable(priv->power, 1);
 	if (ret)
-		return ret;
+		goto probe_fail;
 
 	ret = tcan4x5x_get_gpios(mcan_class);
 	if (ret)
-		goto out_power;
+		goto probe_fail;
 
 	ret = tcan4x5x_init(mcan_class);
 	if (ret)
-		goto out_power;
+		goto probe_fail;
 
 	ret = m_can_class_register(mcan_class);
 	if (ret)
-		goto out_power;
+		goto probe_fail;
 
 	netdev_info(mcan_class->net, "TCAN4X5X successfully initialized.\n");
 	return 0;
 
-out_power:
+probe_fail:
 	tcan4x5x_power_enable(priv->power, 0);
+	m_can_class_free_dev(mcan_class->net);
 	dev_err(&spi->dev, "Probe failed, err=%d\n", ret);
 	return ret;
 }
@@ -536,6 +543,8 @@ static int tcan4x5x_can_remove(struct spi_device *spi)
 
 	m_can_class_unregister(priv->mcan_dev);
 
+	m_can_class_free_dev(priv->mcan_dev->net);
+
 	return 0;
 }
 
-- 
2.25.0

