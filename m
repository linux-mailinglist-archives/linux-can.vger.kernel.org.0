Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508FC11ABFF
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 14:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfLKNXe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 08:23:34 -0500
Received: from first.geanix.com ([116.203.34.67]:58426 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbfLKNXe (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 11 Dec 2019 08:23:34 -0500
Received: from [192.168.100.11] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 1D87D490;
        Wed, 11 Dec 2019 13:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1576070584; bh=rHJD+Es7winoteB5Bb/MaXfVEOAlt6k0dYTzTObV3UI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BoZHdNCP0FeNep5vfYJDYOrlTc5/shto9Js8YyIUlpeEMpey226+xsxx4xGy9giu2
         xyEr82a+RTMsExmeRA4WtYVn3c0mbs0weQxX8/ckMnHfO/OymINyCBf3sdxQwprwin
         cJXGLkPmK0WOLca769GE5pHjYIZ63lSMN6JAqfczWzafF4njQhnNEh00fZp7fLSJWe
         0Ga0/LTxdohFdvtud6Sl0ExJ4zE/M2AGKaOLsC83YaLqHc+c+wdTaFnghsxIDzfqZi
         sBwydxu3kWZldmRRjaaPL3z8NgTY71BDfebg9Lp4D752sqKfTnR4WlaSG4VvFAQyTQ
         AadNb03fVOKCw==
Subject: Re: [PATCH v4 1/2] can: tcan4x5x: reset device before register access
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de,
        linux-can@vger.kernel.org
Cc:     martin@geanix.com
References: <20191211131223.292455-1-sean@geanix.com>
 <80e94af5-1a49-887e-c31e-e0c3629f105a@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <d09833b0-c8dc-756a-0c31-54879cea7153@geanix.com>
Date:   Wed, 11 Dec 2019 14:23:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <80e94af5-1a49-887e-c31e-e0c3629f105a@ti.com>
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



On 11/12/2019 14.17, Dan Murphy wrote:
> Sean
> 
> On 12/11/19 7:12 AM, Sean Nyekjaer wrote:
>> It's a good idea to reset a ip-block/spi device before using it, this
>> patch will reset the device.
>>
>> Added a generic reset function if needed elsewhere.
>>
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Changes v3:
>>   - added reset if the reset_gpio is not avaliable
>>
>>   drivers/net/can/m_can/tcan4x5x.c | 19 +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/m_can/tcan4x5x.c 
>> b/drivers/net/can/m_can/tcan4x5x.c
>> index b6b2feca9e8f..960a16aca7ca 100644
>> --- a/drivers/net/can/m_can/tcan4x5x.c
>> +++ b/drivers/net/can/m_can/tcan4x5x.c
>> @@ -166,6 +166,21 @@ static void tcan4x5x_check_wake(struct 
>> tcan4x5x_priv *priv)
>>       }
>>   }
>> +static void tcan4x5x_reset(struct tcan4x5x_priv *priv)
>> +{
>> +    if (priv->reset_gpio) {
>> +        gpiod_set_value(priv->reset_gpio, 1);
>> +
>> +        /* tpulse_width minimum 30us */
>> +        usleep_range(30, 100);
>> +        gpiod_set_value(priv->reset_gpio, 0);
>> +    } else {
>> +        regmap_write(priv->regmap, TCAN4X5X_CONFIG, TCAN4X5X_SW_RESET);
> 
> error handling especially for the I/O
> 

Oh sorry. The regmap went OK for me when i did the testing... ;-)

I'll post a V5 :)

/Sean
