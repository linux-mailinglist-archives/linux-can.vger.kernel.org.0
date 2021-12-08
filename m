Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E034546D2E2
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 13:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhLHMGC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 07:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhLHMGC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 07:06:02 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210C7C061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 04:02:29 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id bi37so5178614lfb.5
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 04:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kC5P6y9BFiZN5sKxwviufKoKVbQ9BgUivoYFtH7R5nQ=;
        b=e76Bjwxls5CNxD0C5eJGwZjUAGRTwj9o2JXpjWn5ideHSNaB+dSQxOxlAhb/GdE1A6
         /A6HCPbYTHNtbhmkSKc3D/Dx+6k1DsislXPimNKO3Io/Htg+c9VfZQG+k+rBku5VMmdm
         TuPv+JziW8SV7NFYsbgTPUVf9jmKeEdchB3ByqmWv8k0hbjYG5bMn7pmJVqJe70IexMo
         DEYU5hTe7uHPhwEV+vF+0coHTzQV0BYhuI3J/7Pc5snaQ7Z1B51Pg3OFIwwMmYHrCJ8l
         nB4bGzg5mdG77CccW0qzLTGSuobk0V+JBoB6iu/BHQbeOfp6A1nzWweS5dt8YaWCY6zA
         Vfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kC5P6y9BFiZN5sKxwviufKoKVbQ9BgUivoYFtH7R5nQ=;
        b=EyH5U+KoY+bRSqfGm15lbBRuhKMAvRP60icC23OaP8x08aNMG0eFdfNw06Hzdy6bxS
         ec3GyYwoJTUPZOfpC8jzLDh1pLG5KxruCktaJJdhJ1tIpcoyxkJFJRwSMlmJ2fBI3FQC
         9R5yHgRNYh6VIGZYSiCaHljKDsu+wQKq6hlUkHiS1S/eo1dKnxJ4LYIccFoGhteRsC9W
         3RYu20WMD7qwfFMo7yoIMPoZq6A1y8uWW2dMwM6WlHYMuxzNlEuG9+ZMSx8lT5xYiAgr
         +Dh3K3LEQ9q/ooMRhNODaN0tAeT+iOoJHPLmDn9eWDh9ObNKup9W9btHcS2CST1GFDXS
         43YA==
X-Gm-Message-State: AOAM531CycHhxyQuBv9NNk71jlCTwVn1iBi/4qpuCooTec4d0H/dT9Z3
        Zewt8DLXfBGh3nVupEWtQ04aAw==
X-Google-Smtp-Source: ABdhPJwvsbAGIVnxratNL+KcjB5FBtpvsahSab8SHRZerWrIJ8NxNH7nT3nS9+N9wEaTabZ7iutDQA==
X-Received: by 2002:a05:6512:4022:: with SMTP id br34mr49092900lfb.530.1638964946586;
        Wed, 08 Dec 2021 04:02:26 -0800 (PST)
Received: from [10.0.6.3] (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id s4sm234958lfp.198.2021.12.08.04.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 04:02:26 -0800 (PST)
Subject: Re: [PATCH v2 3/3] can: kvaser_usb: Get CAN clock frequency from
 device
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
References: <20211208110940.185629-1-extja@kvaser.com>
 <20211208110940.185629-4-extja@kvaser.com>
 <20211208111738.d4gb3n4axxmt7kil@pengutronix.de>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <9d88bdb6-7d4d-a0d6-4739-52113e66f7cc@kvaser.com>
Date:   Wed, 8 Dec 2021 13:02:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20211208111738.d4gb3n4axxmt7kil@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-12-08 12:17, Marc Kleine-Budde wrote:
> On 08.12.2021 12:09:40, Jimmy Assarsson wrote:
>> Get the CAN clock frequency from device, since the various Kvaser Leaf
>> products use different CAN clocks.
>>
>> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
>> ---
>> Changes in v2:
>>    - Rebased on [PATCH v5 0/5] fix statistics and payload issues for
>>      error [1] series.
>>
>> [1]
>> https://lore.kernel.org/all/20211207121531.42941-1-mailhol.vincent@wanadoo.fr
>>
>>   .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 69 ++++++++++++++++---
>>   1 file changed, 60 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>> index 533e25cb4337..093c092226b6 100644
>> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>> @@ -29,10 +29,12 @@
>>   
>>   #include "kvaser_usb.h"
>>   
>> -/* Forward declaration */
>> -static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg;
>> +/* Forward declarations */
>> +static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_8mhz;
>> +static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_16mhz;
>> +static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_24mhz;
>> +static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_32mhz;
> 
> Can you re-arrange the code, so that you don't need the forward
> declarations?
> 
> Marc

Fixed in v3;
https://lore.kernel.org/all/20211208115607.202859-1-extja@kvaser.com

Best regards,
jimmy
