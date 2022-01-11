Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2441048B2B9
	for <lists+linux-can@lfdr.de>; Tue, 11 Jan 2022 17:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242269AbiAKQ6w (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jan 2022 11:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbiAKQ6v (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jan 2022 11:58:51 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660C6C061748
        for <linux-can@vger.kernel.org>; Tue, 11 Jan 2022 08:58:51 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j11so58579074lfg.3
        for <linux-can@vger.kernel.org>; Tue, 11 Jan 2022 08:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VUh4EGQd2mpMCt69/uN9G3DPSpqP0qgCqhvdDSm0YX0=;
        b=uX2WVJR/v2yBgVoM05Em7Fo26WKnXSFbQxo0tV31bmJFJuGsclisqU3B1sqy6gWOOl
         arLp5ZNMsEfy7jQ+2BKUKpMVn7ro0tfdP/vEK3qh1iDxccih1NDRyvDF1vZC+jFL+o17
         jkSuBIrwhxuzKFYqZcP5K3/8ny5oXKsdSy60b1NUDcVTzRACFsaC9WAALQySfEFDgykr
         1rH99c/RYh5bcr6t1wqpzkx2nULsduRHZhKnz1RxvQ3+x5Z67Q2y8KuLC4xms+iVAMWb
         vBrLSKmlMMr+JB/8hwW7LAx3rufHz92EceAX/6nL0xl1cDNvIMPOUqTZrAqMxmxMK3V9
         9zXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VUh4EGQd2mpMCt69/uN9G3DPSpqP0qgCqhvdDSm0YX0=;
        b=B4nRk0eIyvfcMyedCtojvXxHkor5TY3iMNc6qHTpcJAIFbElxwK6vnyvKaJCxIkBL3
         c4lbePoUvKfIVizmVvtlwyFe9NHT01fQcSo6cpK56510CaeuXfFO0HpIXBiuUfaR8WXa
         Gf+dCGbGsNhvKAWCL+DJPAARPKzoKml6Tf+jxR9ErjfupvTJc0fRfZRA4ptdV7W9xE1w
         83Eq9BOXJd+RdKUv1LwE0lUx4slGR6Er0oaTDBrv/ynhOo9shXs7qLwRRdLbWCEB7IMX
         WJdDZtOiKlED3LD3IqygOa4uy7Eb7LuNFgp9KNJt+eArs8UBLsrTMAMvSMW5oK6RaSPJ
         wlBQ==
X-Gm-Message-State: AOAM530BirUMOfyTiDRQ4ozuuR646Gnv4pF9ZzHibw2JQl39J4Wzs5nv
        alv+yY1+/ME0939LavL3mAgk7A==
X-Google-Smtp-Source: ABdhPJzx1Trs5bpDCvEywbuBUfhJFyyAofq0QrP+LNlsuKFnHowYxLIi7NvbhHzsgAOFENpl8I5qcw==
X-Received: by 2002:a05:6512:323a:: with SMTP id f26mr3978835lfe.238.1641920329663;
        Tue, 11 Jan 2022 08:58:49 -0800 (PST)
Received: from [192.168.1.213] (81.5.110.253.dhcp.mipt-telecom.ru. [81.5.110.253])
        by smtp.googlemail.com with ESMTPSA id x14sm1365087ljh.15.2022.01.11.08.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 08:58:49 -0800 (PST)
Subject: Re: [PATCH v2 2/3] can: sun4i_can: add support for R40 CAN controller
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-can@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
References: <20220111155709.56501-1-boger@wirenboard.com>
 <20220111155709.56501-3-boger@wirenboard.com>
 <20220111162422.62d0ceb0@donnerap.cambridge.arm.com>
From:   Evgeny Boger <boger@wirenboard.com>
Message-ID: <e6b51670-1e08-abff-8bb8-b920e68ec118@wirenboard.com>
Date:   Tue, 11 Jan 2022 19:58:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111162422.62d0ceb0@donnerap.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

11.01.2022 19:24, Andre Przywara пишет:
> On Tue, 11 Jan 2022 18:57:08 +0300
> Evgeny Boger <boger@wirenboard.com> wrote:
>
> Hi,
>
>> Allwinner R40 (also known as A40i, T3, V40) has a CAN controller. The
>> controller is the same as in earlier A10 and A20 SoCs, but needs reset
>> line to be deasserted before use.
>>
>> This patch adds a new compatible for R40 CAN controller. Depending
>> on the compatible, reset line can be requested from DT.
>>
>> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
>> ---
>>   drivers/net/can/sun4i_can.c | 61 ++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 60 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
>> index 54aa7c25c4de..24a61326915e 100644
>> --- a/drivers/net/can/sun4i_can.c
>> +++ b/drivers/net/can/sun4i_can.c
>> @@ -61,6 +61,7 @@
>>   #include <linux/of.h>
>>   #include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/reset.h>
>>   
>>   #define DRV_NAME "sun4i_can"
>>   
>> @@ -200,10 +201,20 @@
>>   #define SUN4I_CAN_MAX_IRQ	20
>>   #define SUN4I_MODE_MAX_RETRIES	100
>>   
>> +/**
>> + * struct sun4ican_quirks - Differences between SoC variants.
>> + *
>> + * @has_reset: SoC needs reset deasserted.
>> + */
>> +struct sun4ican_quirks {
>> +	bool		has_reset;
>> +};
>> +
>>   struct sun4ican_priv {
>>   	struct can_priv can;
>>   	void __iomem *base;
>>   	struct clk *clk;
>> +	struct reset_control *reset;
>>   	spinlock_t cmdreg_lock;	/* lock for concurrent cmd register writes */
>>   };
>>   
>> @@ -702,6 +713,13 @@ static int sun4ican_open(struct net_device *dev)
>>   		goto exit_irq;
>>   	}
>>   
>> +	/* software reset deassert */
>> +	err = reset_control_deassert(priv->reset);
>> +	if (err) {
>> +		netdev_err(dev, "could not deassert CAN reset\n");
>> +		goto exit_soft_reset;
>> +	}
>> +
>>   	/* turn on clocking for CAN peripheral block */
>>   	err = clk_prepare_enable(priv->clk);
>>   	if (err) {
>> @@ -723,6 +741,8 @@ static int sun4ican_open(struct net_device *dev)
>>   exit_can_start:
>>   	clk_disable_unprepare(priv->clk);
>>   exit_clock:
>> +	reset_control_assert(priv->reset);
>> +exit_soft_reset:
>>   	free_irq(dev->irq, dev);
>>   exit_irq:
>>   	close_candev(dev);
>> @@ -736,6 +756,7 @@ static int sun4ican_close(struct net_device *dev)
>>   	netif_stop_queue(dev);
>>   	sun4i_can_stop(dev);
>>   	clk_disable_unprepare(priv->clk);
>> +	reset_control_assert(priv->reset);
>>   
>>   	free_irq(dev->irq, dev);
>>   	close_candev(dev);
>> @@ -750,8 +771,27 @@ static const struct net_device_ops sun4ican_netdev_ops = {
>>   	.ndo_start_xmit = sun4ican_start_xmit,
>>   };
>>   
>> +static const struct sun4ican_quirks sun4ican_quirks_a10 = {
>> +	.has_reset = false,
>> +};
>> +
>> +static const struct sun4ican_quirks sun4ican_quirks_r40 = {
>> +	.has_reset = true,
>> +};
>> +
>>   static const struct of_device_id sun4ican_of_match[] = {
>> -	{.compatible = "allwinner,sun4i-a10-can"},
>> +	{
>> +		.compatible = "allwinner,sun4i-a10-can",
>> +		.data = &sun4ican_quirks_a10
>> +	},
>> +	{
>> +		.compatible = "allwinner,sun7i-a20-can",
>> +		.data = &sun4ican_quirks_a10
>> +	},
> This one looks unnecessary, the binding says that it must be paired with
> the A10 fallback.
> We should only add an A20 compatible match if there is really a reason,
> otherwise it encourages people to produce DTs with *only* the A20
> compatible (violating the binding).

Right, thank you! Since this series has been around for a couple of 
months already,
and changes in v2 are trivial, would it make sense to submit v3 right away?


> Cheers,
> Andre
>
>> +	{
>> +		.compatible = "allwinner,sun8i-r40-can",
>> +		.data = &sun4ican_quirks_r40
>> +	},
>>   	{},
>>   };
>>   
>> @@ -771,10 +811,28 @@ static int sun4ican_probe(struct platform_device *pdev)
>>   {
>>   	struct device_node *np = pdev->dev.of_node;
>>   	struct clk *clk;
>> +	struct reset_control *reset = NULL;
>>   	void __iomem *addr;
>>   	int err, irq;
>>   	struct net_device *dev;
>>   	struct sun4ican_priv *priv;
>> +	const struct sun4ican_quirks *quirks;
>> +
>> +	quirks = of_device_get_match_data(&pdev->dev);
>> +	if (!quirks) {
>> +		dev_err(&pdev->dev, "failed to determine the quirks to use\n");
>> +		err = -ENODEV;
>> +		goto exit;
>> +	}
>> +
>> +	if (quirks->has_reset) {
>> +		reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
>> +		if (IS_ERR(reset)) {
>> +			dev_err(&pdev->dev, "unable to request reset\n");
>> +			err = PTR_ERR(reset);
>> +			goto exit;
>> +		}
>> +	}
>>   
>>   	clk = of_clk_get(np, 0);
>>   	if (IS_ERR(clk)) {
>> @@ -818,6 +876,7 @@ static int sun4ican_probe(struct platform_device *pdev)
>>   				       CAN_CTRLMODE_3_SAMPLES;
>>   	priv->base = addr;
>>   	priv->clk = clk;
>> +	priv->reset = reset;
>>   	spin_lock_init(&priv->cmdreg_lock);
>>   
>>   	platform_set_drvdata(pdev, dev);

