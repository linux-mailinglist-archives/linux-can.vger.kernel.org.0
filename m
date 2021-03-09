Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C003332E2C
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 19:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCISWz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 13:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhCISWv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 13:22:51 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064A8C06174A;
        Tue,  9 Mar 2021 10:22:50 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x4so22005459lfu.7;
        Tue, 09 Mar 2021 10:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nPcKXNtUEVOXwaBBJEtR6Bl/12Ymo4LlBYKDQmcyiIs=;
        b=k4KMZ2viAP4DmQIxJDKBBn1WXTr02JDJzyuq7hUYNtUbK01fkDwM3qInYlRPiZfrWk
         tR5LzER8rbt+kjaT2A192hn33oJJhSQIxZHul9RJ1egI9BXuc7vLcQEYcAKLIFDhtO0v
         EbxHcPi7EH5SdlVto3wmuFIgjhUnGUIVU6ehZ3cAX3uq99IA4L1IUc9x89xD+ceN98gw
         N2OtOOAferpXGw4DCSuOV5FsMH0r3dykkFStktVAdxeMtTyL2GdffjrGxom/AfK6hAf2
         asVwSP7tTbUEby14RgSFs+ZrH3SVHBmIHK42fXTYYevaotnBRcnbqqYbC4xug2U3NT6i
         v3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nPcKXNtUEVOXwaBBJEtR6Bl/12Ymo4LlBYKDQmcyiIs=;
        b=R+3Q4cCsI0iQQKCudYxfB2xTZ4sfYZBJqFEdbKZkkjvgZFeKVIXxGe4JPKgnw05jsD
         AtBKMGHl7yHXqdduoSd1E7vLN9vp23riO8X1OLTv3X/JXCwtRoRR0JPX4KaQb4/D5Fxp
         TpIYU373yUaQPlUCgSMFAJW3fWc2TS7S2L35dUH29oktWhZG9pPLkj1msq6aAyfXeK8/
         bYlbjKlsQIzRMNU7Mkl4wNTccFBRb7dnnlf6zWwvdu5p+dpRmRQTE5QzmzTPAqhLECRc
         2zWC2EESdbqHg9LzHMq2HQ7eJeqonMuTmXvZ3+B9IAVATrMa+dgm1ARSkqPc+wHNVssC
         QlBw==
X-Gm-Message-State: AOAM53223YmKp79f/YlT8eIHRrDwRWqbkiu0+B/gVIvyb0cqTGI93sbi
        Lc+XXUoH5kX7XGJI3LFW00cRiCPN4bmhFw==
X-Google-Smtp-Source: ABdhPJwWJf5k7Z6vwmOswpO5RhCPnxK/mGkhuY3focuVVIxpamv75nNJY1n/XMLism6s7eWUUWjD1g==
X-Received: by 2002:a05:6512:3185:: with SMTP id i5mr17724391lfe.653.1615314168934;
        Tue, 09 Mar 2021 10:22:48 -0800 (PST)
Received: from [192.168.16.194] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id a28sm2280191ljn.45.2021.03.09.10.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 10:22:48 -0800 (PST)
Subject: Re: [RESEND v12] can: usb: etas_es58X: add support for ETAS ES58X CAN
 USB interfaces
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        open list <linux-kernel@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
References: <20210309120946.1640-1-mailhol.vincent@wanadoo.fr>
 <20210309120946.1640-2-mailhol.vincent@wanadoo.fr>
 <45c0b0cc-bfd6-5180-7ad9-51eebc9de3c9@gmail.com>
 <CAMZ6RqJ8j0yqw1Sa1dbLpakBSuKie5xpYMpg6oQFG_MuE3sWkw@mail.gmail.com>
 <CAMZ6Rq+xJv+NVHAUYjT+-MLeO+Owoo03T2hzaA9tOKLstxU0uA@mail.gmail.com>
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
Message-ID: <d5b7f0c5-68d4-364f-b2ff-6cd003c70cb4@gmail.com>
Date:   Tue, 9 Mar 2021 19:22:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <CAMZ6Rq+xJv+NVHAUYjT+-MLeO+Owoo03T2hzaA9tOKLstxU0uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-03-09 19:18, Vincent MAILHOL wrote:
> On Wed. 10 Mar 2021 at 03:11, Vincent MAILHOL
> <mailhol.vincent@wanadoo.fr> wrote:
>>
>> On Wed. 10 Mar 2021 at 02:27, Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:
>>>
>>> Hi Vincent,
>>>
>>> On 2021-03-09 13:09, Vincent Mailhol wrote:
>>>> This driver supports the ES581.4, ES582.1 and ES584.1 interfaces from
>>>> ETAS GmbH (https://www.etas.com/en/products/es58x.php).
>>> ...
>>>> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
>>>> new file mode 100644
>>>> index 000000000000..31f907a7b75f
>>>> --- /dev/null
>>>> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
>>> ...
>>>> +/**
>>>> + * es58x_add_skb_idx() - Increment an index of the loopback FIFO.
>>>> + * @priv: ES58X private parameters related to the network device.
>>>> + * @idx: address of the index to be incremented.
>>>> + * @a: the increment. Must be positive and less or equal to
>>>> + *   @priv->can.echo_skb_max.
>>>> + *
>>>> + * Do a modulus addition: set *@idx to (*@idx + @a) %
>>>> + * @priv->can.echo_skb_max.
>>>> + *
>>>> + * Rationale: the modulus operator % takes a decent amount of CPU
>>>> + * cycles (c.f. other division functions such as
>>>> + * include/linux/math64.h:iter_div_u64_rem()).
>>>> + */
>>>> +static __always_inline void es58x_add_skb_idx(struct es58x_priv *priv,
>>>> +                                           u16 *idx, u16 a)
>>>
>>> Never used?
>>
>> Indeed, this is a leftover. Should have been removed in v11 when I
>> made the device FIFO size a power of two.
>> I was not warned by the compiler, probably because this is an inline function.
>>
>>> ...
>>>> +/**
>>>> + * es58x_get_product_info() - Get the product information and print them.
>>>> + * @es58x_dev: ES58X device.
>>>> + *
>>>> + * Do a synchronous call to get the product information.
>>>> + *
>>>> + * Return: zero on success, errno when any error occurs.
>>>> + */
>>>> +static int es58x_get_product_info(struct es58x_device *es58x_dev)
>>>> +{
>>>> +     struct usb_device *udev = es58x_dev->udev;
>>>> +     const int es58x_prod_info_idx = 6;
>>>> +     /* Empirical tests show a prod_info length of maximum 83,
>>>> +      * below should be more than enough.
>>>> +      */
>>>> +     const size_t prod_info_len = 127;
>>>> +     char *prod_info;
>>>> +     int ret;
>>>> +
>>>> +     prod_info = kmalloc(prod_info_len, GFP_KERNEL);
>>>> +     if (!prod_info)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     ret = usb_string(udev, es58x_prod_info_idx, prod_info, prod_info_len);
>>>> +     if (ret < 0) {
>>>> +             dev_err(es58x_dev->dev,
>>>> +                     "%s: Could not read the product info: %pe\n",
>>>> +                     __func__, ERR_PTR(ret));
>>>
>>> Missing free
>>
>> Absolutely!
>>
>>>> +             return ret;
>>>> +     } else if (ret >= prod_info_len - 1) {
>>>> +             dev_warn(es58x_dev->dev,
>>>> +                      "%s: Buffer is too small, result might be truncated\n",
>>>> +                      __func__);
>>>> +     }
>>>> +     dev_info(es58x_dev->dev, "Product info: %s\n", prod_info);
>>>> +     kfree(prod_info);
>>>> +
>>>> +     return 0;
>>>> +}
>>
>> Thanks for the two findings, both will be fixed in v13.
> 
> Out of curiosity, did you find the two issues throughout a code
> review or did you use any kind of static analysis tool?

Code review.
