Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1077611AC4C
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 14:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfLKNmD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 08:42:03 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45336 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbfLKNmC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Dec 2019 08:42:02 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBDfsb2027302;
        Wed, 11 Dec 2019 07:41:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576071714;
        bh=RJg+MbeRQAcGFLMA2ySXOgmyC/4IwbH+Fw+H4OqZrlw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=P/umedNjezWnvviSiidIgfk8ROKEwJE4fxqjH+3NWY2KxdSYA7gP4UNcMfxJNGB8W
         vHw/oXimA+MjDLMgqAFT/6+ql7y+gW+U9nqbWmAjEmoZz1Qp34mCIFaslS81nYsgWB
         Qqr8QkFT7Zs/Zq5F7f/7DHiYMB1DVY3GKjKB6f0c=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBDfsbI061945;
        Wed, 11 Dec 2019 07:41:54 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 07:41:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 07:41:53 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBDfrW4081725;
        Wed, 11 Dec 2019 07:41:53 -0600
Subject: Re: [PATCH v5 1/2] can: tcan4x5x: reset device before register access
To:     Sean Nyekjaer <sean@geanix.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
CC:     <martin@geanix.com>
References: <20191211133926.319015-1-sean@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <46e8b6e5-6f17-6965-09a7-8f413bfb256f@ti.com>
Date:   Wed, 11 Dec 2019 07:39:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211133926.319015-1-sean@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/11/19 7:39 AM, Sean Nyekjaer wrote:
> It's a good idea to reset a ip-block/spi device before using it, this
> patch will reset the device.
>
> And a generic reset function if needed elsewhere.
>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes since v3:
>   - added reset if the reset_gpio is not avaliable
>
> Changes since v4:
>   - added error handling for the SPI I/O
>
>   drivers/net/can/m_can/tcan4x5x.c | 29 +++++++++++++++++++++++++++--
>   1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index b6b2feca9e8f..032d110e0870 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -166,6 +166,27 @@ static void tcan4x5x_check_wake(struct tcan4x5x_priv *priv)
>   	}
>   }
>   
> +static int tcan4x5x_reset(struct tcan4x5x_priv *priv)
> +{
> +	int ret = 0;
> +
> +	if (priv->reset_gpio) {
> +		gpiod_set_value(priv->reset_gpio, 1);
> +
> +		/* tpulse_width minimum 30us */
> +		usleep_range(30, 100);
> +		gpiod_set_value(priv->reset_gpio, 0);
> +	} else {
> +		ret = regmap_write(priv->regmap, TCAN4X5X_CONFIG, TCAN4X5X_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	usleep_range(700, 1000);
> +
> +	return ret;
> +}
> +
>   static int regmap_spi_gather_write(void *context, const void *reg,
>   				   size_t reg_len, const void *val,
>   				   size_t val_len)
> @@ -351,6 +372,7 @@ static int tcan4x5x_disable_wake(struct m_can_classdev *cdev)
>   static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>   {
>   	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
> +	int ret;
>   
>   	tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
>   						    GPIOD_OUT_HIGH);
> @@ -363,10 +385,13 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>   
>   	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
>   						       GPIOD_OUT_LOW);
> -	if (IS_ERR(tcan4x5x->reset_gpio))
> +	if (IS_ERR(tcan4x5x->reset_gpio)) {
>   		tcan4x5x->reset_gpio = NULL;
> +	}
>   

Why did you add brackets?

This is not needed for single statement if's

Dan
