Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD2D1178D1
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 22:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLIVrW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 16:47:22 -0500
Received: from first.geanix.com ([116.203.34.67]:55928 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLIVrW (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Dec 2019 16:47:22 -0500
Received: from [192.168.100.11] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 19860444;
        Mon,  9 Dec 2019 21:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575928019; bh=MV5vVV1gTL2ZzRBTBWFqyUQWxBZYW022PoD8XpX+7WI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TmVRtc/KcEGpLLFUTkvUl/eox3KHOD5IwbrQRSYaNIxRyxNeN/segGPqrw8SbjynT
         Hkk+183qyLcEmktvGFWoEooxGag2wwS8VFhemkWMoVm3wpBVoOYNS7OzjR5z0fBUUL
         5N+Z/ORRFPXeY92RX/Z6vwoJaKktjPybKfzbLl/MxU6rWMQq//8yZhhMdjqOND1whc
         3Ilde8SG2rvNTcXLwZEVi+athCBP3gepwKUNNGRlykKLN/9E4IbLDSuDavut2uuwgE
         /iJgV0iD7KgqoCqKuDl2uKfrawMBPoeZnaLWHtJqNflMyIYucYjc9uTWWhZRg2Cz7V
         4Kjr/Oi/KytCw==
Subject: Re: [PATCH v2 2/2] can: m_can: tcan4x5x: reset device before register
 access
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de,
        linux-can@vger.kernel.org
Cc:     martin@geanix.com
References: <20191209192440.998659-1-sean@geanix.com>
 <20191209192440.998659-2-sean@geanix.com>
 <17908fc8-550b-4832-5b43-7a5ea387a12f@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <10dab7ae-dcfa-2aec-2146-df24ec1e8686@geanix.com>
Date:   Mon, 9 Dec 2019 22:47:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <17908fc8-550b-4832-5b43-7a5ea387a12f@ti.com>
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



On 09/12/2019 22.27, Dan Murphy wrote:
> Sean
> 
> On 12/9/19 1:24 PM, Sean Nyekjaer wrote:
>> It's a good idea to reset a ip-block/spi device before using it,
>> this patch will reset the device.
> 
> $subject says 2/2 where is 1/2?

Here?
https://www.spinics.net/lists/linux-can/msg03020.html

I have them in a thread, in thunderbird...

> 
> 
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> ---
>> Changes since v1:
>>   - Added toggle of reset pin with required delay
>>   - Only toggle reset pin if it exist
>>
>>   drivers/net/can/m_can/tcan4x5x.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/m_can/tcan4x5x.c 
>> b/drivers/net/can/m_can/tcan4x5x.c
>> index 3c30209ca84c..5b26e494a7db 100644
>> --- a/drivers/net/can/m_can/tcan4x5x.c
>> +++ b/drivers/net/can/m_can/tcan4x5x.c
>> @@ -363,8 +363,15 @@ static int tcan4x5x_parse_config(struct 
>> m_can_classdev *cdev)
>>       tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
>>                                  GPIOD_OUT_LOW);
>> -    if (IS_ERR(tcan4x5x->reset_gpio))
>> +    if (IS_ERR(tcan4x5x->reset_gpio)) {
>>           tcan4x5x->reset_gpio = NULL;
>> +    } else {
>> +        gpiod_set_value(tcan4x5x->reset_gpio, 1);
>> +
>> +        /* tpulse_width minimum 30us */
>> +        usleep_range(30, 100);
>> +        gpiod_set_value(tcan4x5x->reset_gpio, 0);
> 
> I would still prefer a function that can be called.

I will post a V3 with a function :)

/Sean
