Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B503C7B34E2
	for <lists+linux-can@lfdr.de>; Fri, 29 Sep 2023 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjI2O1O (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Sep 2023 10:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjI2O1N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 29 Sep 2023 10:27:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4BAF9
        for <linux-can@vger.kernel.org>; Fri, 29 Sep 2023 07:27:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-307d20548adso12531088f8f.0
        for <linux-can@vger.kernel.org>; Fri, 29 Sep 2023 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695997630; x=1696602430; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x1HV2GzMWdJ/ycYV1useQ7pJi/nIT7T9AXkztCfJUU8=;
        b=HnPPFmvclU3xEvZ+HEPuwVFL+4tr51aoikL2ZE4q//zzp/lz2qzSFC+X69jAsDyMmp
         s6tMQUuQqcf6o2BhkzKHddx8w0xdN/YhCfL7aa7+2drtTsLPxSLGDY5PjPgbAzfsQb4u
         ne/FJ3G+2bXjP7smsHe9m/lhmnq0IaugZ9vUHbKg7+P83cGYHelDpjahWQKLT5HpiqTJ
         IPdy++6DUcw5EugrAm8J1wZyhZEEaXSnNTMpqHdJkc5lI1UXkDnWKFQqV7TAWZt0xF2r
         WaJ+GVMr/mjDyFUK+PJ3D3SVBbqtX4SRpEp/touQH3KuTRoJusafcBcolKn5aCaAgexf
         JVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997630; x=1696602430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1HV2GzMWdJ/ycYV1useQ7pJi/nIT7T9AXkztCfJUU8=;
        b=c7pW+/Fz2/2RTAWxwyFqLEdbmPUf0Vo9VDfx+O0nO9nWN1Psc8eztjo32SLNBPCoQV
         G9HAKiYZ5CF+aZHXIxVclMTcSUmPPOw7aU/BYWKsjhIAdoB2iWTUQLS+VAQ4qLHA5qbK
         37hGbpP2gDKJWKwJReSiJQz2q4AEcow9FX8a9JA1YLfa9iXRABdUitUq7VX4zfYx9OEM
         /jZ6Zs/ptLqjvq9btk2heaG1WYPKM2h+r51tePvqsPSNwPUB5h483jUydNLdy9BWAeet
         CCcohMdWbC1RK+ZCQJuk2THxlg8BZdvDZfLPeTFck674eWk6FcRSHj4DGAkh7x9vW/iP
         ZxXQ==
X-Gm-Message-State: AOJu0YyyIp3p5rZCFaY1GHQc07XzCCia03PoupEjUubhjqPn7n50lf7L
        RCfTeRkOMayO7WsRQCkvnPvURw==
X-Google-Smtp-Source: AGHT+IH9P1ngp0xoW0oWSBcKjuGJ1+UT30n2Pa8ulVyLu6bRDOBhG+X+94vn6gVpV/rEa2IDqSOtog==
X-Received: by 2002:adf:db4b:0:b0:319:7428:9ca0 with SMTP id f11-20020adfdb4b000000b0031974289ca0mr3596833wrj.61.1695997630122;
        Fri, 29 Sep 2023 07:27:10 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:8222:872:4a5b:b69c:1318])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c204c00b00403bbe69629sm1548411wmg.31.2023.09.29.07.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:27:09 -0700 (PDT)
Date:   Fri, 29 Sep 2023 16:27:08 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc:     linux-can@vger.kernel.org,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Dong Aisheng <b29396@freescale.com>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v2 2/2] can: tcan4x5x: support resuming from rx interrupt
 signal
Message-ID: <20230929142708.4fn7slq6ao2k5riw@blmsp>
References: <20230919122841.3803289-1-martin@geanix.com>
 <20230919122841.3803289-2-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919122841.3803289-2-martin@geanix.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Martin,

On Tue, Sep 19, 2023 at 02:28:33PM +0200, Martin Hundebøll wrote:
> Implement the "wakeup-source" device tree property, so the chip is left
> running when suspending, and its rx interrupt is used as a wakeup source
> to resume operation.

I think you need to add a patch in your series to update the binding
documentation in Documentation/devicetree/bindings/net/can/tcan4x5x.txt
with the wakeup-source property.

Best,
Markus

> 
> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
> 
> Change since v1:
>  * Added `static` keyword to dev_pm_ops sturcture
> 
>  drivers/net/can/m_can/tcan4x5x-core.c | 34 ++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> index 8a4143809d33..ccb279af22bb 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -459,6 +459,9 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>  		goto out_power;
>  	}
>  
> +	if (device_property_read_bool(&spi->dev, "wakeup-source"))
> +		device_init_wakeup(&spi->dev, true);
> +
>  	ret = m_can_class_register(mcan_class);
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed registering m_can device %pe\n",
> @@ -487,6 +490,31 @@ static void tcan4x5x_can_remove(struct spi_device *spi)
>  	m_can_class_free_dev(priv->cdev.net);
>  }
>  
> +static int __maybe_unused tcan4x5x_suspend(struct device *dev)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +
> +	if (device_may_wakeup(dev)) {
> +		enable_irq_wake(spi->irq);
> +
> +		return m_can_class_suspend(dev, true);
> +	}
> +
> +	return m_can_class_suspend(dev, false);
> +}
> +
> +static int __maybe_unused tcan4x5x_resume(struct device *dev)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	bool wake_source = device_may_wakeup(dev);
> +	int ret = m_can_class_resume(dev, wake_source);
> +
> +	if (wake_source)
> +		disable_irq_wake(spi->irq);
> +
> +	return ret;
> +}
> +
>  static const struct of_device_id tcan4x5x_of_match[] = {
>  	{
>  		.compatible = "ti,tcan4x5x",
> @@ -505,11 +533,15 @@ static const struct spi_device_id tcan4x5x_id_table[] = {
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
