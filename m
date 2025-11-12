Return-Path: <linux-can+bounces-5354-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E47C51540
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 10:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700873B0690
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D44283FEE;
	Wed, 12 Nov 2025 09:17:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4416E2741C6
	for <linux-can@vger.kernel.org>; Wed, 12 Nov 2025 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939071; cv=none; b=NTv1DzTATyE4tG8s+nqNlIxzmHouu5aoIb6cOrK4D8+J78z9banIzWC57WJiJGMy+0PpdCVuuNhUFfJ1k741qsoSvsxqULKgCPLUjaJLK9YYlb1ez7uP8bTJR4KcDSVBf8rUhAq1HzamOgTrW0rHYa00Bkdjtzr0QCsKTJDwhoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939071; c=relaxed/simple;
	bh=BybLz8R/6E4SyXOF+fTFA74JdgAgAbvozI8MqTL2cz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pU/UVkQX2HmExaJT90WomMT0+V3hoDXgaXzyav7QkRldq4Szcn+UcCygpIPBScnF9nbjJquP46XN8nZcupU8hdDMEHHlR3jejiageQmqdi42r71u1Kqv1yOldharTN/0jA9m65kKrcsdaH25g2ltc1vgFqzcghOeFssLTqsg2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6yw-0007V6-Ew; Wed, 12 Nov 2025 10:17:38 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6yv-0003cM-31;
	Wed, 12 Nov 2025 10:17:37 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9072749D99B;
	Wed, 12 Nov 2025 09:17:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Maud Spierings <maudspierings@gocontroll.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/11] can: mcp251x: mcp251x_can_probe(): use dev_err_probe()
Date: Wed, 12 Nov 2025 10:13:44 +0100
Message-ID: <20251112091734.74315-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112091734.74315-1-mkl@pengutronix.de>
References: <20251112091734.74315-1-mkl@pengutronix.de>
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

From: Maud Spierings <maudspierings@gocontroll.com>

The currently used combination of dev_err() plus return leaves a loud error
in dmesg even when the error is a deferred probe which gets resolved later.
For example a supply that has not been probed yet.

Use dev_err_probe() to improve the handling/display of errors.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
Link: https://patch.msgid.link/20251030-mcp_err-v1-1-eecf737823b7@gocontroll.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 1e54e1a22702..fa97adf25b73 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1320,7 +1320,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	clk = devm_clk_get_optional(&spi->dev, NULL);
 	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+		return dev_err_probe(&spi->dev, PTR_ERR(clk), "Cannot get clock\n");
 
 	freq = clk_get_rate(clk);
 	if (freq == 0)
@@ -1328,7 +1328,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	/* Sanity check */
 	if (freq < 1000000 || freq > 25000000)
-		return -ERANGE;
+		return dev_err_probe(&spi->dev, -ERANGE, "clock frequency out of range\n");
 
 	/* Allocate can/net device */
 	net = alloc_candev(sizeof(struct mcp251x_priv), TX_ECHO_SKB_MAX);
@@ -1336,8 +1336,10 @@ static int mcp251x_can_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	ret = clk_prepare_enable(clk);
-	if (ret)
+	if (ret) {
+		dev_err_probe(&spi->dev, ret, "Cannot enable clock\n");
 		goto out_free;
+	}
 
 	net->netdev_ops = &mcp251x_netdev_ops;
 	net->ethtool_ops = &mcp251x_ethtool_ops;
@@ -1362,20 +1364,25 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	else
 		spi->max_speed_hz = spi->max_speed_hz ? : 10 * 1000 * 1000;
 	ret = spi_setup(spi);
-	if (ret)
+	if (ret) {
+		dev_err_probe(&spi->dev, ret, "Cannot set up spi\n");
 		goto out_clk;
+	}
 
 	priv->power = devm_regulator_get_optional(&spi->dev, "vdd");
 	priv->transceiver = devm_regulator_get_optional(&spi->dev, "xceiver");
 	if ((PTR_ERR(priv->power) == -EPROBE_DEFER) ||
 	    (PTR_ERR(priv->transceiver) == -EPROBE_DEFER)) {
 		ret = -EPROBE_DEFER;
+		dev_err_probe(&spi->dev, ret, "supply deferred\n");
 		goto out_clk;
 	}
 
 	ret = mcp251x_power_enable(priv->power, 1);
-	if (ret)
+	if (ret) {
+		dev_err_probe(&spi->dev, ret, "Cannot enable power\n");
 		goto out_clk;
+	}
 
 	priv->wq = alloc_workqueue("mcp251x_wq",
 				   WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
@@ -1409,21 +1416,24 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	/* Here is OK to not lock the MCP, no one knows about it yet */
 	ret = mcp251x_hw_probe(spi);
 	if (ret) {
-		if (ret == -ENODEV)
-			dev_err(&spi->dev, "Cannot initialize MCP%x. Wrong wiring?\n",
-				priv->model);
+		dev_err_probe(&spi->dev, ret, "Cannot initialize MCP%x. Wrong wiring?\n",
+			      priv->model);
 		goto error_probe;
 	}
 
 	mcp251x_hw_sleep(spi);
 
 	ret = register_candev(net);
-	if (ret)
+	if (ret) {
+		dev_err_probe(&spi->dev, ret, "Cannot register CAN device\n");
 		goto error_probe;
+	}
 
 	ret = mcp251x_gpio_setup(priv);
-	if (ret)
+	if (ret) {
+		dev_err_probe(&spi->dev, ret, "Cannot set up gpios\n");
 		goto out_unregister_candev;
+	}
 
 	netdev_info(net, "MCP%x successfully initialized.\n", priv->model);
 	return 0;
@@ -1442,7 +1452,6 @@ static int mcp251x_can_probe(struct spi_device *spi)
 out_free:
 	free_candev(net);
 
-	dev_err(&spi->dev, "Probe failed, err=%d\n", -ret);
 	return ret;
 }
 
-- 
2.51.0


