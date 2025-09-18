Return-Path: <linux-can+bounces-4741-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6161B8438F
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 12:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B79D3A553C
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 10:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB2F2F90CE;
	Thu, 18 Sep 2025 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="C7kzHhb1"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2872A2E7651
	for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192411; cv=none; b=qOqcmrXEhwy4kTzrAzqRJDyg1DCvkgwr+5GIiVGnZ7FtzY1hsXuEhgsgh0qvFlN/11coNcmyb+tIodApM7I/wa1oftA0flOUGT3g0MFxtS/ubFnvn5HlsTnjtaUfKd1TnFy4lHv2RbF1P+eg8J+agxbGiOYuhahRYsFAvozPEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192411; c=relaxed/simple;
	bh=XVqqCBkwm/ssm9tGz5Xg/OAtvJ6BnaZKy/zr6x0t32Y=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtr3lBM56ZRSJ60uVBA5hMxyId0MX7HufK7yPt+dhruQUsBqYiZKoqeLt4ACjy4W7LIhhlgEQzJ/7hq8/UnDgrKswsK94u2LCL0uUi0zfBMfDTxdiQppSjjXGOPD1H9X0vR4KWRMIPSlof5e7ODnK6ckEuZcGHdiUhBqw8J87Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=C7kzHhb1; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5783a776a77so1140193e87.1
        for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 03:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758192406; x=1758797206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4DN5nEjseCE7cGcG3iV255Wk1+Y0Hrh3r/JaVmcefc=;
        b=C7kzHhb1XQoiNvb2xNpJow6y+FXL65IM9ZfLwbyrNdZmBTTfLg4agQwAgAX8YNNMAZ
         xBf4e7kYDoR7B+kn7t7Vp3aM3SpmkYz7Nh6ZNWM5rKRXZBhyG8leTNXgt01GIF+1ohG2
         Yqj1Lbkx5kgUhmcgA5yvLx5wRsX1yaMMlHWi0BoPeV41KRJY8e0JqLpPcrnKH/gS5wUL
         /PHqF0kmphwpaoCvnGATP9gicTSVrDwT7xCa0tGxPjbP7B/iU+6BlPs2EfxQob5Qb+Oq
         anZlT6BO6iG5hBg0iS7Jgrbmt4B+AVu5brTLQCNLgzZwwoN15snrvkiu7tyhYq2ZkD75
         FFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192406; x=1758797206;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4DN5nEjseCE7cGcG3iV255Wk1+Y0Hrh3r/JaVmcefc=;
        b=ielcRcRa/I9wBFwLb2YmjYh3BbFkcfB4o5MbRP5BXCPnYgAb3DfdSIVn5lqCXYd7yV
         pJM5/BoPdjkppPq6ctxm2rFOxlP8zND1A0DtlFpx6VclXLxObnsQDs4YZ5oX6s1FO6Yk
         bJK9DO+IXztvIXaTQQpeSJNEIyplC+vQO3E37D0lUxJnnr9S9L+5eG7HtHKohEUjeqcG
         ud9okFpqfRvfru1xM2YxnwKnlTYE0ANOmq9/XMFCW1ilZX2LBNbs7qKGBEhY9b1amLzU
         pyDUfav5FpLK2kmYpoIWI0YFF0zDi1oVbyx5olTrXTsdXyYsb3vZu0SPbkkRijCvZaq0
         a1aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpW7bMHo+DlgsWZ7S16AMGwRMXMa6wEJ4Jk8XxAd4JXqchn5lPyyejlv0cOsiDWQraDURXJSk6k78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwThPCvGIUrLy/U4zFFLv7KycPQIVjVIXEZZXsoKvAtlUI7pQS2
	DG/BTXZ7LBXQ+pC7+f+aYE6Jo63QcjAQAwCBFYHjibuZ2BFNLaaMvC6OPQL2pZm8XPjrei8/gME
	rIrPI6cI0D6XmMNPByPHkMs45JlbuBEtNdegl94qZHw==
X-Gm-Gg: ASbGnct0SEDcBOzxlXadNkN9y3Xh7N8VgHcT1TCgGKvZD+HCvAcHoXFmLmfUEwV5Ixr
	vBdAf1sQGzMNAjtDS0VgRPPgsSJi0746IV/ZoI91yfK/BvR+8J5VtbB+esd4qQEOE/mtM/QZg22
	xX6F8edrvati6q7nHsbaACmMrHu2hBJWixQVa68tdYy1Scleswqi/z16K90wSis3JKa1a4bkvM2
	lXbO+Y5oCuZ8CKIHLpBa9meMXa0daeEhaDx
X-Google-Smtp-Source: AGHT+IHxBqYYKRgDXZ9Dhxc49mfxCa2jy2ihInGuA+js7QsWtXsgWolEja58+bOuOWNUxcHCefSpFtMFNOl415IGxJc=
X-Received: by 2002:a05:6512:3042:b0:55f:4839:d049 with SMTP id
 2adb3069b0e04-5779ac2b2c3mr1455199e87.39.1758192406237; Thu, 18 Sep 2025
 03:46:46 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Sep 2025 05:46:44 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Sep 2025 05:46:44 -0500
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20250918064903.241372-6-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com> <20250918064903.241372-6-viken.dadhaniya@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 05:46:44 -0500
X-Gm-Features: AS18NWCc5q4WPW5KXMv4YgdUI2GDWsy35XSnSqBywmNMbFE0fV54rNh06zfR5FY
Message-ID: <CAMRc=Mf2ycyKbL35bdy5m1WBEap7Bu8OO2Q9AdZYgc04Uynf8g@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] can: mcp251xfd: add gpio functionality
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com, 
	Gregor Herburger <gregor.herburger@ew.tq-group.com>, mkl@pengutronix.de, mani@kernel.org, 
	thomas.kopp@microchip.com, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org, 
	brgl@bgdev.pl, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sep 2025 08:49:02 +0200, Viken Dadhaniya
<viken.dadhaniya@oss.qualcomm.com> said:
> From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
>
> The mcp251xfd devices allow two pins to be configured as gpio. Add this
> functionality to driver.
>
> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
> Tested-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 179 ++++++++++++++++++
>  drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   4 +
>  2 files changed, 183 insertions(+)
>
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index ea41f04ae1a6..8c253091f498 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -16,6 +16,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/device.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> @@ -1797,6 +1798,178 @@ static int mcp251xfd_register_check_rx_int(struct mcp251xfd_priv *priv)
>  	return 0;
>  }
>
> +#ifdef CONFIG_GPIOLIB

Any reason why you don't just depend on GPIOLIB in Kconfig? There's no
reason to make it optional if the device always has the GPIO pins.

> +static const char * const mcp251xfd_gpio_names[] = { "GPIO0", "GPIO1" };
> +
> +static int mcp251xfd_gpio_request(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
> +	u32 pin_mask = MCP251XFD_REG_IOCON_PM(offset);
> +	int ret;
> +
> +	if (priv->rx_int && offset == 1) {
> +		netdev_err(priv->ndev, "Can't use GPIO 1 with RX-INT!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(priv->ndev->dev.parent);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
> +				  pin_mask, pin_mask);
> +}
> +
> +static void mcp251xfd_gpio_free(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
> +
> +	pm_runtime_put(priv->ndev->dev.parent);
> +}
> +
> +static int mcp251xfd_gpio_get_direction(struct gpio_chip *chip,
> +					unsigned int offset)
> +{
> +	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
> +	u32 mask = MCP251XFD_REG_IOCON_TRIS(offset);
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (mask & val)
> +		return GPIO_LINE_DIRECTION_IN;
> +
> +	return GPIO_LINE_DIRECTION_OUT;
> +}
> +
> +static int mcp251xfd_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
> +	u32 mask = MCP251XFD_REG_IOCON_GPIO(offset);
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
> +	if (ret)
> +		return ret;
> +
> +	return !!(mask & val);
> +}
> +
> +static int mcp251xfd_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
> +				       unsigned long *bit)
> +{
> +	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
> +	if (ret)
> +		return ret;
> +
> +	*bit = FIELD_GET(MCP251XFD_REG_IOCON_GPIO_MASK, val) & *mask;
> +
> +	return 0;
> +}
> +
> +static int mcp251xfd_gpio_direction_output(struct gpio_chip *chip,
> +					   unsigned int offset, int value)
> +{
> +	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
> +	u32 dir_mask = MCP251XFD_REG_IOCON_TRIS(offset);
> +	u32 val_mask = MCP251XFD_REG_IOCON_LAT(offset);
> +	u32 val;
> +
> +	if (value)
> +		val = val_mask;
> +	else
> +		val = 0;
> +
> +	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
> +				  dir_mask | val_mask, val);
> +}
> +
> +static int mcp251xfd_gpio_direction_input(struct gpio_chip *chip,
> +					  unsigned int offset)
> +{
> +	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
> +	u32 dir_mask = MCP251XFD_REG_IOCON_TRIS(offset);
> +
> +	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
> +				  dir_mask, dir_mask);
> +}
> +
> +static void mcp251xfd_gpio_set(struct gpio_chip *chip, unsigned int offset,
> +			       int value)

You must be rebased on pre v6.17 code, this will not compile with current
mainline.

> +{
> +	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
> +	u32 val_mask = MCP251XFD_REG_IOCON_LAT(offset);
> +	u32 val;
> +	int ret;
> +
> +	if (value)
> +		val = val_mask;
> +	else
> +		val = 0;
> +
> +	ret = regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
> +				 val_mask, val);
> +	if (ret)
> +		dev_err(&priv->spi->dev, "Failed to set GPIO %u: %d\n",
> +			offset, ret);
> +}
> +
> +static void mcp251xfd_gpio_set_multiple(struct gpio_chip *chip, unsigned long *mask,
> +					unsigned long *bits)
> +{

Same here, the setter callbacks now return int.

> +	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
> +	u32 val;
> +	int ret;
> +
> +	val = FIELD_PREP(MCP251XFD_REG_IOCON_LAT_MASK, *bits);
> +
> +	ret = regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
> +				 MCP251XFD_REG_IOCON_LAT_MASK, val);
> +	if (ret)
> +		dev_err(&priv->spi->dev, "Failed to set GPIOs %d\n", ret);
> +}
> +
> +static int mcp251fdx_gpio_setup(struct mcp251xfd_priv *priv)
> +{
> +	struct gpio_chip *gc = &priv->gc;
> +
> +	if (!device_property_present(&priv->spi->dev, "gpio-controller"))
> +		return 0;
> +
> +	gc->label = dev_name(&priv->spi->dev);
> +	gc->parent = &priv->spi->dev;
> +	gc->owner = THIS_MODULE;
> +	gc->request = mcp251xfd_gpio_request;
> +	gc->free = mcp251xfd_gpio_free;
> +	gc->get_direction = mcp251xfd_gpio_get_direction;
> +	gc->direction_output = mcp251xfd_gpio_direction_output;
> +	gc->direction_input = mcp251xfd_gpio_direction_input;
> +	gc->get = mcp251xfd_gpio_get;
> +	gc->get_multiple = mcp251xfd_gpio_get_multiple;
> +	gc->set = mcp251xfd_gpio_set;
> +	gc->set_multiple = mcp251xfd_gpio_set_multiple;
> +	gc->base = -1;
> +	gc->can_sleep = true;
> +	gc->ngpio = ARRAY_SIZE(mcp251xfd_gpio_names);
> +	gc->names = mcp251xfd_gpio_names;
> +
> +	return devm_gpiochip_add_data(&priv->spi->dev, gc, priv);
> +}
> +#else
> +static inline int mcp251fdx_gpio_setup(struct mcp251xfd_priv *priv)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int
>  mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
>  			      u32 *effective_speed_hz_slow,
> @@ -1930,6 +2103,12 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
>
>  	mcp251xfd_ethtool_init(priv);
>
> +	err = mcp251fdx_gpio_setup(priv);
> +	if (err) {
> +		dev_err_probe(&priv->spi->dev, err, "Failed to register gpio-controller.\n");
> +		goto out_runtime_disable;
> +	}
> +
>  	err = register_candev(ndev);
>  	if (err)
>  		goto out_runtime_disable;
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> index bd28510a6583..fd9e005708e4 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> @@ -15,6 +15,7 @@
>  #include <linux/can/dev.h>
>  #include <linux/can/rx-offload.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/kernel.h>
>  #include <linux/netdevice.h>
>  #include <linux/regmap.h>
> @@ -676,6 +677,9 @@ struct mcp251xfd_priv {
>
>  	struct mcp251xfd_devtype_data devtype_data;
>  	struct can_berr_counter bec;
> +#ifdef CONFIG_GPIOLIB
> +	struct gpio_chip gc;
> +#endif
>  };
>
>  #define MCP251XFD_IS(_model) \
> --
> 2.34.1
>
>

Bart

