Return-Path: <linux-can+bounces-572-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF668BC752
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 08:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206461F219C7
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 06:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F609140399;
	Mon,  6 May 2024 06:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="cRLHDwwN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="K4FA/6j2"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460164AEF7;
	Mon,  6 May 2024 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714975223; cv=none; b=AX9L2dirMWpx2z1CR3ZWahlsyjAgcPB4bCQXp/pxzf6bBwM1Q03gN2+JXBHvdnS4HJwn1+W0QzxkSlNbHxXB9UE61yyr2pWAeEVlGpzr7SrwMOSwcG0WFeaV684rp87t2MQnfeRp4+HYAjTBca2GqdziLNfodqY7n4GJf89xGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714975223; c=relaxed/simple;
	bh=zpReWPDWnJPZSQwgBcrBsplUbkSPT5bkXuwcoqiJqBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hQul/R7U5kioTiI+2RDxXGL2lhyChiGeW5DsMLkZeOSynjrj5hgMoKipMrfFFiBwdadZBX6evrJwSzjyUprB7ZV09MHsrdnZLw7nIuneXcX4nN4oKVw6Wv2VTzezyA2K7V2q4tkc11xE+vQwz4uzktWU0sslzvQLVCwLy53i+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=cRLHDwwN; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=K4FA/6j2 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1714975221; x=1746511221;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=K1sB7lPF4/uybKuMuPZ9LkiESZoBBU5NzfBLROum6sU=;
  b=cRLHDwwNrqosoVWcYQr8IHc/XzwhRc0/gA5s75h09pZ7jE24/0cpcSmx
   JQTXtpXjbMvn1FP+oDFSgOJbBPnuqeVsQMsF19fuomxDtipfIJmHRI/XB
   TRu/OL/ZOwVGNz4AMazykTS9tkh5IX1oUaCWNFpVvsI5X+lY2KQA6UPPk
   RGTFqkgtNuu2J04w4dK0rXXAmuCZLEb/+8bnlauIE1k8tQ5l3RXBLsJep
   cYyVcOQCkSCV8kW2O0VnwcI/aC8zHiFQn1SJyb8ylSIzUVjdl0MkXXTLv
   Q5vYQhTsSMjeLSmoGMqMpgIHMFg3WZb2JLWT9+ZDWkiK94o7v+1v5rMbg
   g==;
X-CSE-ConnectionGUID: pJ5CULIuTC2tWYCOi3ux9g==
X-CSE-MsgGUID: 2ib0oUWRSg6MH36KZOJf1w==
X-IronPort-AV: E=Sophos;i="6.07,257,1708383600"; 
   d="scan'208";a="36751435"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 06 May 2024 08:00:18 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 52F1617014C;
	Mon,  6 May 2024 08:00:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1714975213;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=K1sB7lPF4/uybKuMuPZ9LkiESZoBBU5NzfBLROum6sU=;
	b=K4FA/6j2zJaRKN79OcbHg0pTAmez0iZnSFfvdOCJyb1fHUP9anUjCFaERLOhQA2aJBS+H7
	KywpJEfStye7dpxbVKh7ZcA3lKiyjlu2WYdwYO5nDLzNvlJ+gr5IBKhaswkUlBmgiUJ0+z
	hVvoubmH1kVOetLq10w8h3Mp0lIdT1gEPU0d04MWsH4QvZ4a7KjeQX+4VRG8OpjzUtOCG3
	xHQEqggC2cr4CuW57TEbOHOxwgH1MbZa9nGQFaBY8D4/rZSoExjg/kkWrT9sHpmF7TFxbb
	Lltgw1gRSdfAjF8Tw0RtKY3mlorpBGikOdkAA7Mor+L+jYtvlwrmAD1oGv9etA==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Mon, 06 May 2024 07:59:47 +0200
Subject: [PATCH v2 5/6] can: mcp251xfd: add gpio functionality
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-mcp251xfd-gpio-feature-v2-5-615b16fa8789@ew.tq-group.com>
References: <20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com>
In-Reply-To: <20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714975188; l=7313;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=zpReWPDWnJPZSQwgBcrBsplUbkSPT5bkXuwcoqiJqBQ=;
 b=Ga1cVakJe+rZqOztI7bS9fr99sD6mW+FFFiYUhJICnSRppL89NGHazD9/BSDIafWK+zIpEYV6
 iz+4n+xKgnMAYRtp8pNNeEmej/7RUCTlzTPOPCdviuj5jcicF586bwA
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

The mcp251xfd devices allow two pins to be configured as gpio. Add this
functionality to driver.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 173 +++++++++++++++++++++++++
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h      |   6 +
 2 files changed, 179 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 4739ad80ef2a..de301f3a2f4e 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -16,6 +16,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/gpio/driver.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
@@ -1768,6 +1769,172 @@ static int mcp251xfd_register_check_rx_int(struct mcp251xfd_priv *priv)
 	return 0;
 }
 
+#ifdef CONFIG_GPIOLIB
+static const char * const mcp251xfd_gpio_names[] = {"GPIO0", "GPIO1"};
+
+static int mcp251xfd_gpio_request(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 pin_mask = MCP251XFD_REG_IOCON_PM0 << offset;
+	int ret;
+
+	if (priv->rx_int && offset == 1) {
+		netdev_err(priv->ndev, "Can't use GPIO 1 with RX-INT!\n");
+		return -EINVAL;
+	}
+
+	ret = pm_runtime_resume_and_get(priv->ndev->dev.parent);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				  pin_mask, pin_mask);
+}
+
+static void mcp251xfd_gpio_free(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+
+	pm_runtime_put(priv->ndev->dev.parent);
+}
+
+static int mcp251xfd_gpio_get_direction(struct gpio_chip *chip,
+					unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 mask = MCP251XFD_REG_IOCON_TRIS0 << offset;
+	u32 val;
+
+	regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
+
+	if (mask & val)
+		return GPIO_LINE_DIRECTION_IN;
+
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int mcp251xfd_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 mask = MCP251XFD_REG_IOCON_GPIO0 << offset;
+	u32 val;
+
+	regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
+
+	return !!(mask & val);
+}
+
+static int mcp251xfd_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
+				       unsigned long *bit)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
+	if (ret)
+		return ret;
+
+	*bit = FIELD_GET(MCP251XFD_REG_IOCON_GPIO_MASK, val) & *mask;
+
+	return 0;
+}
+
+static int mcp251xfd_gpio_direction_output(struct gpio_chip *chip,
+					   unsigned int offset, int value)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 dir_mask = MCP251XFD_REG_IOCON_TRIS0 << offset;
+	u32 val_mask = MCP251XFD_REG_IOCON_LAT0 << offset;
+	u32 val;
+
+	if (value)
+		val = val_mask;
+	else
+		val = 0;
+
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				  dir_mask | val_mask, val);
+}
+
+static int mcp251xfd_gpio_direction_input(struct gpio_chip *chip,
+					  unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 dir_mask = MCP251XFD_REG_IOCON_TRIS0 << offset;
+
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				  dir_mask, dir_mask);
+}
+
+static void mcp251xfd_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			       int value)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 val_mask = MCP251XFD_REG_IOCON_LAT0 << offset;
+	u32 val;
+	int ret;
+
+	if (value)
+		val = val_mask;
+	else
+		val = 0;
+
+	ret = regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				 val_mask, val);
+	if (ret)
+		dev_warn(&priv->spi->dev,
+			 "Failed to set GPIO %u: %d\n", offset, ret);
+}
+
+static void mcp251xfd_gpio_set_multiple(struct gpio_chip *chip, unsigned long *mask,
+					unsigned long *bits)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 val;
+	int ret;
+
+	val = FIELD_PREP(MCP251XFD_REG_IOCON_LAT_MASK, *bits);
+
+	ret = regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				 MCP251XFD_REG_IOCON_LAT_MASK, val);
+	if (ret)
+		dev_warn(&priv->spi->dev, "Failed to set GPIOs %d\n", ret);
+}
+
+static int mcp251fdx_gpio_setup(struct mcp251xfd_priv *priv)
+{
+	struct gpio_chip *gc = &priv->gc;
+
+	if (!device_property_present(&priv->spi->dev, "gpio-controller"))
+		return 0;
+
+	gc->label = dev_name(&priv->spi->dev);
+	gc->parent = &priv->spi->dev;
+	gc->owner = THIS_MODULE;
+	gc->request = mcp251xfd_gpio_request;
+	gc->free = mcp251xfd_gpio_free;
+	gc->get_direction = mcp251xfd_gpio_get_direction;
+	gc->direction_output = mcp251xfd_gpio_direction_output;
+	gc->direction_input = mcp251xfd_gpio_direction_input;
+	gc->get = mcp251xfd_gpio_get;
+	gc->get_multiple = mcp251xfd_gpio_get_multiple;
+	gc->set = mcp251xfd_gpio_set;
+	gc->set_multiple = mcp251xfd_gpio_set_multiple;
+	gc->base = -1;
+	gc->can_sleep = true;
+	gc->ngpio = ARRAY_SIZE(mcp251xfd_gpio_names);
+	gc->names = mcp251xfd_gpio_names;
+
+	return devm_gpiochip_add_data(&priv->spi->dev, gc, priv);
+}
+#else
+static inline int mcp251fdx_gpio_setup(struct mcp251xfd_priv *priv)
+{
+	return 0;
+}
+#endif
+
 static int
 mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
 			      u32 *effective_speed_hz_slow,
@@ -2141,6 +2308,12 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	if (err)
 		goto out_free_candev;
 
+	err = mcp251fdx_gpio_setup(priv);
+	if (err) {
+		dev_err_probe(&spi->dev, err, "Failed to register gpio-controller.\n");
+		goto out_free_candev;
+	}
+
 	err = mcp251xfd_register(priv);
 	if (err) {
 		dev_err_probe(&spi->dev, err, "Failed to detect %s.\n",
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 75d5a8a25415..dc34da848f00 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -15,6 +15,7 @@
 #include <linux/can/dev.h>
 #include <linux/can/rx-offload.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/regmap.h>
@@ -337,8 +338,10 @@
 #define MCP251XFD_REG_IOCON_PM0 BIT(24)
 #define MCP251XFD_REG_IOCON_GPIO1 BIT(17)
 #define MCP251XFD_REG_IOCON_GPIO0 BIT(16)
+#define MCP251XFD_REG_IOCON_GPIO_MASK GENMASK(17, 16)
 #define MCP251XFD_REG_IOCON_LAT1 BIT(9)
 #define MCP251XFD_REG_IOCON_LAT0 BIT(8)
+#define MCP251XFD_REG_IOCON_LAT_MASK GENMASK(9, 8)
 #define MCP251XFD_REG_IOCON_XSTBYEN BIT(6)
 #define MCP251XFD_REG_IOCON_TRIS1 BIT(1)
 #define MCP251XFD_REG_IOCON_TRIS0 BIT(0)
@@ -660,6 +663,9 @@ struct mcp251xfd_priv {
 
 	struct mcp251xfd_devtype_data devtype_data;
 	struct can_berr_counter bec;
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gc;
+#endif
 };
 
 #define MCP251XFD_IS(_model) \

-- 
2.34.1


