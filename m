Return-Path: <linux-can+bounces-20-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C66CC7EADC7
	for <lists+linux-can@lfdr.de>; Tue, 14 Nov 2023 11:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033931C20A80
	for <lists+linux-can@lfdr.de>; Tue, 14 Nov 2023 10:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAD91863F;
	Tue, 14 Nov 2023 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1VLhXwj3"
X-Original-To: linux-can@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB316412
	for <linux-can@vger.kernel.org>; Tue, 14 Nov 2023 10:16:05 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419E4D59
	for <linux-can@vger.kernel.org>; Tue, 14 Nov 2023 02:16:02 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c72e275d96so73003141fa.2
        for <linux-can@vger.kernel.org>; Tue, 14 Nov 2023 02:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699956960; x=1700561760; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S66K1VSLqdDY4G6GRPiKeVmO5YV98+bwwbj3xy8sc9k=;
        b=1VLhXwj3EOIruxOGDfwi8mkuNo8DbIUZ3e99bnBOXkKkB5GYKKcjnHn/0oHrNF1Uua
         T4NPzbQT2MS4AuVz8rdMQ0nwnExhXM+JFcKz5NAoCP7VP8HkaKsphJbG4bMg4A4NdP5/
         2hnS0GUjU4MsBpWLl3v63vfoRvVpqbIR3K/DFUukONZY4VHWUx5ffzcpCimC4EdVcoiQ
         /xs2l+bvQ0WiHQFnOAh0/wsvpQUSBmGz5VVHm4gcxhYHY0nUefMdh5ka/X4Lq4y8iA8G
         v1NbzzEp4OwURej0XOxm1qcrEYY7XuflA0CmEJKTuAtTz8LGtjEMc7CsBOpVLVrxO07/
         55Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699956960; x=1700561760;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S66K1VSLqdDY4G6GRPiKeVmO5YV98+bwwbj3xy8sc9k=;
        b=PsLKULa0pn07A3tovwMgtPbQuj/ixs041KAeKZPK3Pc3mEM81fear5zaeECXLRJbHC
         sPuTZFj5/or5Qu3GYZrc2VJDff9BxaWxSb3FaqJdtcoGaaW8xQMiFvewLIV3Bavih37/
         i35aH46EDLXKeQ6ck0+ErGr1xWSjyvM5EwJPwUTooIrxsnpMsrIaVvmcNjs28KsmYBSD
         hTlzXkJu5g8wVAolcqE3SbQoYX1IrQGi7pCBgPik0jJRkyFiuma9PgDghGC3nMKgn1cr
         Cl5cg0tWK4IKBWE/Au1xuou920FtW1pcB2FmAs4fcfcrikiyXaQPxW0p5/1WyhUm8+sL
         1yHQ==
X-Gm-Message-State: AOJu0YwufhGyTYLSMrZPK4h8cTS3M5sk8IojUS5XdLvp5jfT6gDNjWAF
	9eAtcJyI3/xxhk3m8zcDB9La6w==
X-Google-Smtp-Source: AGHT+IFpFePXPUj6r47XrvY+6vIyAtnVXiV3+sXFtpZsCWqUCGTVFu8vWiDXyJWPzaMTzGRi0imnzg==
X-Received: by 2002:a2e:9d03:0:b0:2c5:2df8:d321 with SMTP id t3-20020a2e9d03000000b002c52df8d321mr1319633lji.36.1699956960430;
        Tue, 14 Nov 2023 02:16:00 -0800 (PST)
Received: from blmsp ([2001:4091:a246:821e:4988:9c5:5b9:1020])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c470e00b0040a47091602sm13109300wmo.31.2023.11.14.02.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 02:16:00 -0800 (PST)
Date: Tue, 14 Nov 2023 11:15:59 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] can: tcan4x5x: support resuming from rx interrupt
 signal
Message-ID: <20231114101559.5wqnhdmklarr3lgv@blmsp>
References: <20231113131452.214961-1-martin@geanix.com>
 <20231113131452.214961-3-martin@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231113131452.214961-3-martin@geanix.com>

Hi Martin,

On Mon, Nov 13, 2023 at 02:14:51PM +0100, Martin Hundebøll wrote:
> Implement the "wakeup-source" device tree property, so the chip is left
> running when suspending, and its rx interrupt is used as a wakeup source
> to resume operation.
> 
> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
> 
> Change in v3:
>  * Updated to use the property in struct m_can_classdev instead of
>    passing parameters to suspend/resume functions.
> 
> Change in v2:
>  * Added `static` keyword to dev_pm_ops sturcture
> 
>  drivers/net/can/m_can/tcan4x5x-core.c | 34 +++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> index 870ab4aef610..0f4c2ac7e4f6 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -411,7 +411,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>  	priv->spi = spi;
>  
>  	mcan_class->pm_clock_support = 0;
> -	mcan_class->pm_wake_source = 0;
> +	mcan_class->pm_wake_source = device_property_read_bool(&spi->dev, "wakeup-source");
>  	mcan_class->can.clock.freq = freq;
>  	mcan_class->dev = &spi->dev;
>  	mcan_class->ops = &tcan4x5x_ops;
> @@ -460,6 +460,9 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>  		goto out_power;
>  	}
>  
> +	if (mcan_class->pm_wake_source)
> +		device_init_wakeup(&spi->dev, true);
> +

You are automatically enabling the device for wakeup here.

What do you think about using ethtool's wake-on-lan settings to actually
enable tcan as a wakeup source? So the devicetree would describe if the
hardware is capable of wakeups and the software (ethtool) can be used by
the user to decide if CAN wakeups should be enabled.

I am currently working on something similar for m_can, where m_can can
be the wakeup source from very deep sleep states. However I can't keep
the wakeup source always enabled. So this is a kind of a conflict for me
in this patch. Also I would need to use the wakeup-source flag in m_can
device nodes as well.

I can share my work later as well, so we can find a good solution that
works in both cases.

Best,
Markus

>  	ret = m_can_class_register(mcan_class);
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed registering m_can device %pe\n",
> @@ -488,6 +491,29 @@ static void tcan4x5x_can_remove(struct spi_device *spi)
>  	m_can_class_free_dev(priv->cdev.net);
>  }
>  
> +static int __maybe_unused tcan4x5x_suspend(struct device *dev)
> +{
> +	struct m_can_classdev *cdev = dev_get_drvdata(dev);
> +	struct spi_device *spi = to_spi_device(dev);
> +
> +	if (cdev->pm_wake_source)
> +		enable_irq_wake(spi->irq);
> +
> +	return m_can_class_suspend(dev);
> +}
> +
> +static int __maybe_unused tcan4x5x_resume(struct device *dev)
> +{
> +	struct m_can_classdev *cdev = dev_get_drvdata(dev);
> +	struct spi_device *spi = to_spi_device(dev);
> +	int ret = m_can_class_resume(dev);
> +
> +	if (cdev->pm_wake_source)
> +		disable_irq_wake(spi->irq);
> +
> +	return ret;
> +}
> +
>  static const struct of_device_id tcan4x5x_of_match[] = {
>  	{
>  		.compatible = "ti,tcan4x5x",
> @@ -506,11 +532,15 @@ static const struct spi_device_id tcan4x5x_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, tcan4x5x_id_table);
>  
> +static const struct dev_pm_ops tcan4x5x_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(tcan4x5x_suspend, tcan4x5x_resume)
> +};
> +
>  static struct spi_driver tcan4x5x_can_driver = {
>  	.driver = {
>  		.name = KBUILD_MODNAME,
>  		.of_match_table = tcan4x5x_of_match,
> -		.pm = NULL,
> +		.pm = &tcan4x5x_pm_ops,
>  	},
>  	.id_table = tcan4x5x_id_table,
>  	.probe = tcan4x5x_can_probe,
> -- 
> 2.42.0
> 

