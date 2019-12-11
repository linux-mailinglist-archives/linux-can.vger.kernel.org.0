Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6228C11AD40
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 15:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfLKOUe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 09:20:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:32870 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfLKOUd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Dec 2019 09:20:33 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBEKS59056326;
        Wed, 11 Dec 2019 08:20:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576074028;
        bh=2Lv+6TYdicksBnWCCqNUc/T8hG5fr56Rkx51jpxrtE8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=RMEZa5ZDKBeyQB78cRY4yX/eXK7x5/hB2Korpu0CeG51W8W14lEsgoHC/lJWG4I6K
         yTmMOZsfG1NUGhpIWdYwVemiCUOfH5nxfo933b24GvuKoq+Ia58O57hNnXJZ/WmwpD
         jf4IktxwVYmHHE3eVNRwWSFB3cD+Bvw0tEUMeJB0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBEKSbk000630;
        Wed, 11 Dec 2019 08:20:28 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 08:20:27 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 08:20:27 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBEKRxR029163;
        Wed, 11 Dec 2019 08:20:27 -0600
Subject: Re: [PATCH v6 1/2] can: tcan4x5x: reset device before register access
To:     Sean Nyekjaer <sean@geanix.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
References: <20191211135852.320650-1-sean@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <8d0b7661-6413-1ee5-4225-323bd8be102d@ti.com>
Date:   Wed, 11 Dec 2019 08:18:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211135852.320650-1-sean@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/11/19 7:58 AM, Sean Nyekjaer wrote:
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
> Changes since v5:
>   - Removed braces for single statement if's
>
>   Sorry for the mess :)
>
>   drivers/net/can/m_can/tcan4x5x.c | 27 ++++++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index 6676ecec48c3..dcfa85edc787 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -166,6 +166,28 @@ static void tcan4x5x_check_wake(struct tcan4x5x_priv *priv)
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
> +		ret = regmap_write(priv->regmap, TCAN4X5X_CONFIG,
> +				   TCAN4X5X_SW_RESET);
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
> @@ -351,6 +373,7 @@ static int tcan4x5x_disable_wake(struct m_can_classdev *cdev)
>   static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>   {
>   	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
> +	int ret;
>   
>   	tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
>   						    GPIOD_OUT_HIGH);
> @@ -366,7 +389,9 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>   	if (IS_ERR(tcan4x5x->reset_gpio))
>   		tcan4x5x->reset_gpio = NULL;
>   
> -	usleep_range(700, 1000);
> +	ret = tcan4x5x_reset(tcan4x5x);
> +	if (ret)
> +		return ret;
>   
>   	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
>   							      "device-state",


Acked-by: Dan Murphy <dmurphy@ti.com>

