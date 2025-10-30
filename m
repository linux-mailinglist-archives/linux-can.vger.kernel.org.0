Return-Path: <linux-can+bounces-5286-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF114C1EB0C
	for <lists+linux-can@lfdr.de>; Thu, 30 Oct 2025 08:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41D184E33D8
	for <lists+linux-can@lfdr.de>; Thu, 30 Oct 2025 07:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B259335097;
	Thu, 30 Oct 2025 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOAz0xsk"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00462335091;
	Thu, 30 Oct 2025 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761808078; cv=none; b=RiQTXLhpQN33Q+/QQROFFkE7i6uuUBiqJUywPJr4PDz0bk1wWJ54236AILHzKLsh6MMpa8uGax6QzO7hhdyW5zRpc31GRfUneyM7n1HySQaTGidfhldGzdsbMhxRCxAy8QdeWClivzrbYBiqdyDEh82p9Qwo+540+maNLQE6u0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761808078; c=relaxed/simple;
	bh=ipLpVtkSZXmlBFR2EviXdNceYMtpLlgeI6yDHRxnKRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pGtY+tmUf8Sl8pjaZnshvgUtgA1YNX9jOynYd5KGCN9RWojKFc3tb8aTywN6EyjRowmhoUiRUYGRL2T47dxK0MAU8W+qY79MbGzjTnMHIk0EnVp3Vu9T8KAPOOjUgfxf5lraiZep95RtON8Wxp3JJeFqsjENM+dY8jNQychHR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOAz0xsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 825B2C4CEF1;
	Thu, 30 Oct 2025 07:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761808077;
	bh=ipLpVtkSZXmlBFR2EviXdNceYMtpLlgeI6yDHRxnKRk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=FOAz0xskRH2ndTBgwKEuPzwHUdaOaGVkxXElJb1tVTf9NDfBpFjXB81jin0YaL3Tj
	 pB697jahyGLl7DwA55ZoYTBtbuJKLGRwH5RS1PDQGXKsgmg8+ggxmBFZzsCQl84cil
	 1OJzK3B0c1V5459NqZ+2hK0qMqhbOytrkYZTtSHi0tU/ItcKwaR+VaOjgseJXA6zMQ
	 6UrRhoXrMfQzMdjnyHJd2V9WYhxAkXzwH4M/kpJP62wJjFs79DQFYWTYZ2Bhv/M32K
	 zhiFBNCybPjjh2SVCQIGgfxWAeyO0veLFFQhPD4owEmMQtnKuPKZ9sfhzlJ6gGa2jI
	 88s5YkgD+sYMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E680CCF9F6;
	Thu, 30 Oct 2025 07:07:57 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Thu, 30 Oct 2025 08:07:42 +0100
Subject: [PATCH] net: can: mcp251x: use dev_err_probe() in probe
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-mcp_err-v1-1-eecf737823b7@gocontroll.com>
X-B4-Tracking: v=1; b=H4sIAL4OA2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA2MD3dzkgvjUoiLdNLNEY8PUpKRUE/NEJaDqgqLUtMwKsEnRsbW1ADw
 ycApZAAAA
X-Change-ID: 20251030-mcp_err-f6a31ebbe47a
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761808076; l=3745;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=7SQx5+xuTmbRP2jC1wr5GUv3U4vwif5G7XletYOqjvM=;
 b=ajEC4nBLTA9I/eM7uEBSr4UY3zwgPURL28Oc1vZrtNHrN+r1aYzTOc0fCUk3mcDsIkoLu1vBm
 nxT+mb8Zr9bCRo61rJ+jIATfekBzhDYcYITa6yj7nAhslll9CFMEwYC
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

The currently used combination of dev_err plus return leaves a loud
error in dmesg even when the error is a deferred probe which gets
resolved later. For example a supply that has not been probed yet.

Use dev_err_probe to improve the handling/display of errors.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
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
 

---
base-commit: 131f3d9446a6075192cdd91f197989d98302faa6
change-id: 20251030-mcp_err-f6a31ebbe47a

Best regards,
-- 
Maud Spierings <maudspierings@gocontroll.com>



