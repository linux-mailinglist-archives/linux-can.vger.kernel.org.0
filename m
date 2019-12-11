Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEE911AC62
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 14:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfLKNrQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 08:47:16 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46058 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfLKNrQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Dec 2019 08:47:16 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBDlAZF028854;
        Wed, 11 Dec 2019 07:47:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576072030;
        bh=hRXYBHFflnf1YrsVZJ/T67XWyS49J6LA8mN1meKiokQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LSdn0QkhOxSWCFwJNLmmiCqGIyxQadpMEGjMK4trReiV3LavG8sLSrEe1jtHWoLNJ
         WRFeIrdHFnEQNs2gMb0Vh01ump8tDajgzuO7mYxFiqm0XjLmgSRkmnJBh1so4QCMOB
         jZ3zHz3Cm+FmGNgxkHOCUGD9MWVFb+ibDlty097Y=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBBDlAXB101886
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Dec 2019 07:47:10 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 07:47:09 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 07:47:09 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBDl9BE095569;
        Wed, 11 Dec 2019 07:47:09 -0600
Subject: Re: [PATCH v5 1/2] can: tcan4x5x: reset device before register access
To:     Sean Nyekjaer <sean@geanix.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
CC:     <martin@geanix.com>
References: <20191211133926.319015-1-sean@geanix.com>
 <46e8b6e5-6f17-6965-09a7-8f413bfb256f@ti.com>
 <5a8b70ce-b8ac-4ff5-c1bd-56fadbdf7993@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <15047970-30e3-8fe0-c714-4064d3e50114@ti.com>
Date:   Wed, 11 Dec 2019 07:44:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <5a8b70ce-b8ac-4ff5-c1bd-56fadbdf7993@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/11/19 7:45 AM, Sean Nyekjaer wrote:
>
>
> On 11/12/2019 14.39, Dan Murphy wrote:
>> Sean
>>
>> On 12/11/19 7:39 AM, Sean Nyekjaer wrote:
>>> It's a good idea to reset a ip-block/spi device before using it, this
>>> patch will reset the device.
>>>
>>> And a generic reset function if needed elsewhere.
>>>
>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> ---
>>> Changes since v3:
>>>   - added reset if the reset_gpio is not avaliable
>>>
>>> Changes since v4:
>>>   - added error handling for the SPI I/O
>>>
>>>   drivers/net/can/m_can/tcan4x5x.c | 29 +++++++++++++++++++++++++++--
>>>   1 file changed, 27 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/can/m_can/tcan4x5x.c 
>>> b/drivers/net/can/m_can/tcan4x5x.c
>>> index b6b2feca9e8f..032d110e0870 100644
>>> --- a/drivers/net/can/m_can/tcan4x5x.c
>>> +++ b/drivers/net/can/m_can/tcan4x5x.c
>>> @@ -166,6 +166,27 @@ static void tcan4x5x_check_wake(struct 
>>> tcan4x5x_priv *priv)
>>>       }
>>>   }
>>> +static int tcan4x5x_reset(struct tcan4x5x_priv *priv)
>>> +{
>>> +    int ret = 0;
>>> +
>>> +    if (priv->reset_gpio) {
>>> +        gpiod_set_value(priv->reset_gpio, 1);
>>> +
>>> +        /* tpulse_width minimum 30us */
>>> +        usleep_range(30, 100);
>>> +        gpiod_set_value(priv->reset_gpio, 0);
>>> +    } else {
>>> +        ret = regmap_write(priv->regmap, TCAN4X5X_CONFIG, 
>>> TCAN4X5X_SW_RESET);
>>> +        if (ret)
>>> +            return ret;
>>> +    }
>>> +
>>> +    usleep_range(700, 1000);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>   static int regmap_spi_gather_write(void *context, const void *reg,
>>>                      size_t reg_len, const void *val,
>>>                      size_t val_len)
>>> @@ -351,6 +372,7 @@ static int tcan4x5x_disable_wake(struct 
>>> m_can_classdev *cdev)
>>>   static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>>>   {
>>>       struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
>>> +    int ret;
>>>       tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, 
>>> "device-wake",
>>>                               GPIOD_OUT_HIGH);
>>> @@ -363,10 +385,13 @@ static int tcan4x5x_parse_config(struct 
>>> m_can_classdev *cdev)
>>>       tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, 
>>> "reset",
>>>                                  GPIOD_OUT_LOW);
>>> -    if (IS_ERR(tcan4x5x->reset_gpio))
>>> +    if (IS_ERR(tcan4x5x->reset_gpio)) {
>>>           tcan4x5x->reset_gpio = NULL;
>>> +    }
>>
>> Why did you add brackets?
>>
>> This is not needed for single statement if's
>
> Oh just legacy from V4... V6 then ...

I went back to v4 this was not a change in that version.

Dan

