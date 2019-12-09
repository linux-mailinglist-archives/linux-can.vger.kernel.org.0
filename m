Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B1A11728E
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 18:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfLIROM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 12:14:12 -0500
Received: from first.geanix.com ([116.203.34.67]:39214 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfLIROM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Dec 2019 12:14:12 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 7016B406;
        Mon,  9 Dec 2019 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575911630; bh=NqPsVClmp3YQr3Y9qmkuhk2wxoq2n+m1P4DimYA9d7w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AkwsMoR7mHDsaLx65nLllMJLYPgt7+X/KJL4q0T37oM4u+rjfT38kWm9w4OKqoNnB
         A5ozHFzc5UpFHJHKaQltX0W7hv8HdzMvChXynyyztPF4gD/n0gkjD8SpW60y+Nl/um
         hQMF5csgI34NGDVJNBuKNScKbbDfcZ9XZ8hAU3K9khX8iGtkRoVVjrUa2YFnNdlUgB
         bW9Vcq8ci9q/Z72uJRphUV8g3SHBn0ZgwJ6XubESpiqZ/5z9+CwibGB4WarTcIoweb
         tuhb91QBamRMEtEzgFUCiPvPv9z57D+NJJd/BzqFM0WgapfJxFMeaXqmvAytRncvF/
         SvXXrE/yppIew==
Subject: Re: [PATCH 2/2] can: m_can: tcan4x5x: reset device before register
 access
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de,
        linux-can@vger.kernel.org
Cc:     martin@geanix.com
References: <20191209084808.908116-1-sean@geanix.com>
 <20191209084808.908116-2-sean@geanix.com>
 <233a4bad-1439-3e7c-18c5-a7b5c5bb1a0c@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <3196f5db-6b05-6e11-764f-04506bb92149@geanix.com>
Date:   Mon, 9 Dec 2019 18:14:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <233a4bad-1439-3e7c-18c5-a7b5c5bb1a0c@ti.com>
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



On 09/12/2019 14.00, Dan Murphy wrote:
> Sean
> 
> On 12/9/19 2:48 AM, Sean Nyekjaer wrote:
>> It's a good idea to reset a ip-block/spi device before using it,
>> this patch will reset the device.
>>
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> ---
>>   drivers/net/can/m_can/tcan4x5x.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/m_can/tcan4x5x.c 
>> b/drivers/net/can/m_can/tcan4x5x.c
>> index 7f26c2d53f8c..dd812d40d475 100644
>> --- a/drivers/net/can/m_can/tcan4x5x.c
>> +++ b/drivers/net/can/m_can/tcan4x5x.c
>> @@ -361,14 +361,15 @@ static int tcan4x5x_parse_config(struct 
>> m_can_classdev *cdev)
>>           tcan4x5x_disable_wake(cdev);
>>       }
>> -
>>       tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
>> -                               GPIOD_OUT_LOW);
>> +                               GPIOD_OUT_HIGH);
>>       if (IS_ERR(tcan4x5x->reset_gpio))
>>           tcan4x5x->reset_gpio = NULL;
>>       usleep_range(700, 1000);
>> +    gpiod_set_value(tcan4x5x->reset_gpio, 0);
> 
> I was looking to add a common function to properly do the reset with the 
> delay.
> 
> This way if resets are needed in other calls then the proper reset 
> sequence is available.
> 
> Also this call  and the sleep assumes that the reset GPIO is available 
> but they are optional.
> 
> Dan
> 

Hi Dan,

I'm also removing the 700us delay after reset I added in the previous 
patch, ups.

And I will put the gpiod_set_value inside the if statement, that way it 
will stay optional :)

Will post a V2

/Sean
