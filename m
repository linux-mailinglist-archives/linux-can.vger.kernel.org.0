Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9022811AC5A
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 14:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfLKNps (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 08:45:48 -0500
Received: from first.geanix.com ([116.203.34.67]:59410 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729540AbfLKNps (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 11 Dec 2019 08:45:48 -0500
Received: from [192.168.100.11] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id DBE07490;
        Wed, 11 Dec 2019 13:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1576071917; bh=xUobQmKgY+EI7r3ZAeQzzGu6v7YmBhd5S3xXW07A9RI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dpEg6h3/yG2K0XMk6n2Bc+3MqFDGsErJLJ/FIapDIqXkGvTIfTUCLGioPOTFTl2dT
         IPSP/Q9mgjHTuezD6YuXW6S2qPndM+2Dd+Y2AM9Q80kVAhjUiu3EamyG4LYJRxeJbI
         vZTzULJxMn4yGguPuU+8D+tJdN5XhsNKktu+bES2Qi76j94NO+ggLB9Xxq1UAwzfTD
         1jQTVD7LADaSo2DBhbFoGoXOCBhzva0d9cNWPhEz9UvkhXnv/IWGhzq2n/JnXDIeTj
         RkCyOJffJ+1G30MOVVLqfiwHGdoB0EJD4bzN2zJCkdLYalzxb/N5sg6zpyvjMmU4g3
         MGspy0l5fFMdQ==
Subject: Re: [PATCH v5 1/2] can: tcan4x5x: reset device before register access
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de,
        linux-can@vger.kernel.org
Cc:     martin@geanix.com
References: <20191211133926.319015-1-sean@geanix.com>
 <46e8b6e5-6f17-6965-09a7-8f413bfb256f@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <5a8b70ce-b8ac-4ff5-c1bd-56fadbdf7993@geanix.com>
Date:   Wed, 11 Dec 2019 14:45:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <46e8b6e5-6f17-6965-09a7-8f413bfb256f@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 11/12/2019 14.39, Dan Murphy wrote:
> Sean
> 
> On 12/11/19 7:39 AM, Sean Nyekjaer wrote:
>> It's a good idea to reset a ip-block/spi device before using it, this
>> patch will reset the device.
>>
>> And a generic reset function if needed elsewhere.
>>
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Changes since v3:
>>   - added reset if the reset_gpio is not avaliable
>>
>> Changes since v4:
>>   - added error handling for the SPI I/O
>>
>>   drivers/net/can/m_can/tcan4x5x.c | 29 +++++++++++++++++++++++++++--
>>   1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/m_can/tcan4x5x.c 
>> b/drivers/net/can/m_can/tcan4x5x.c
>> index b6b2feca9e8f..032d110e0870 100644
>> --- a/drivers/net/can/m_can/tcan4x5x.c
>> +++ b/drivers/net/can/m_can/tcan4x5x.c
>> @@ -166,6 +166,27 @@ static void tcan4x5x_check_wake(struct 
>> tcan4x5x_priv *priv)
>>       }
>>   }
>> +static int tcan4x5x_reset(struct tcan4x5x_priv *priv)
>> +{
>> +    int ret = 0;
>> +
>> +    if (priv->reset_gpio) {
>> +        gpiod_set_value(priv->reset_gpio, 1);
>> +
>> +        /* tpulse_width minimum 30us */
>> +        usleep_range(30, 100);
>> +        gpiod_set_value(priv->reset_gpio, 0);
>> +    } else {
>> +        ret = regmap_write(priv->regmap, TCAN4X5X_CONFIG, 
>> TCAN4X5X_SW_RESET);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    usleep_range(700, 1000);
>> +
>> +    return ret;
>> +}
>> +
>>   static int regmap_spi_gather_write(void *context, const void *reg,
>>                      size_t reg_len, const void *val,
>>                      size_t val_len)
>> @@ -351,6 +372,7 @@ static int tcan4x5x_disable_wake(struct 
>> m_can_classdev *cdev)
>>   static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>>   {
>>       struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
>> +    int ret;
>>       tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, 
>> "device-wake",
>>                               GPIOD_OUT_HIGH);
>> @@ -363,10 +385,13 @@ static int tcan4x5x_parse_config(struct 
>> m_can_classdev *cdev)
>>       tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
>>                                  GPIOD_OUT_LOW);
>> -    if (IS_ERR(tcan4x5x->reset_gpio))
>> +    if (IS_ERR(tcan4x5x->reset_gpio)) {
>>           tcan4x5x->reset_gpio = NULL;
>> +    }
> 
> Why did you add brackets?
> 
> This is not needed for single statement if's

Oh just legacy from V4... V6 then ...
