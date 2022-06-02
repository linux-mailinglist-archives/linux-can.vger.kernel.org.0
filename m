Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D699553B696
	for <lists+linux-can@lfdr.de>; Thu,  2 Jun 2022 12:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiFBKHc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Jun 2022 06:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiFBKHb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Jun 2022 06:07:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FF11D5191
        for <linux-can@vger.kernel.org>; Thu,  2 Jun 2022 03:07:29 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m25so1397413lji.11
        for <linux-can@vger.kernel.org>; Thu, 02 Jun 2022 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C8Q+8pGq2/N/nHrd03FaGOpzHue5p6EytlJ7o2yBFlI=;
        b=b1cwUjh00MoFVhuTXi6r5VoEZ/11cJUWkx1zF8MOrmYipAe6j94727JrUpA8TB0yMI
         e95TrO/f+WebYROunc36sKlqvDgdN+Ie3y1m9g37ChmUgrog1ja0qkYF+JvuxsrRy2iL
         s1g2U12uCRmZVTnsgXIdcX6UmN3SENzCxG3De4XegZM4UYKHaik1ZMgpMAnE1qFsctbl
         Y3cx3s5O7p04bsTaOVWFWY9K3BGZGTRO7lCEh8qcgLRgYME3YCCL9i3I9M11bvW9Q1MR
         71qOfpeldFeI/30IMK3DJtYkGpltuNKEqDlfm/BfAHNr1qCM2VBFqtmlIpVhEmGL9GSu
         PbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C8Q+8pGq2/N/nHrd03FaGOpzHue5p6EytlJ7o2yBFlI=;
        b=KiNGdFEG38rFCaZSBys9dnx3C9pt9CIb4sTYy+FPT7iQcDz8xCJfCZxiTLllQVvfqE
         sGVhroJWfigfSZVz44vtUWyoj+0JAWXecA172sgDVPULyTlWhNnIr3q8oycNXlwEz1v/
         ug3oIpRJGDxMR45mhi8nrUvhzq4E00fO6ZCsAi0Iv0XEK9+0R3aY3flAiYYdQiGgonWi
         kyAApAefhwSJELybhLWcCT5bvKAOjaZxduwBAfgfimKJ/9zSkEmZPfPDZsKIaBiFyk+n
         CPdQSOy9S1XelPB4MNGpkLdQkl9gIuWD7F2AJimZgkKagTUGQT323Jm7UzxxOvvHDC3Q
         RrFQ==
X-Gm-Message-State: AOAM532wSCH7IeACDL+WlAJjc8YARDl77HWgocGq0ttGqYUSzuMkXH94
        UZFc/D70G24apG44qMIQQPz0fw==
X-Google-Smtp-Source: ABdhPJwIF9DiGF4LZaiVt7OG7puN0eKw4ymbjs3SOADoHEarvcvYRotIckAq/zfNrg0j64m0k83GvA==
X-Received: by 2002:a05:651c:2326:b0:253:cd05:55bc with SMTP id bi38-20020a05651c232600b00253cd0555bcmr42029638ljb.374.1654164447617;
        Thu, 02 Jun 2022 03:07:27 -0700 (PDT)
Received: from [192.168.16.143] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id f14-20020ac2508e000000b00478d3369261sm963199lfm.7.2022.06.02.03.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 03:07:27 -0700 (PDT)
Message-ID: <03414303-1235-e9fd-a644-cf0eb8d0debd@kvaser.com>
Date:   Thu, 2 Jun 2022 12:07:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2] can: kvaser_usb: kvaser_usb_leaf: Fix CAN clock
 frequency regression
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        stable@vger.kernel.org
References: <20220602063031.415858-1-extja@kvaser.com>
 <20220602063031.415858-2-extja@kvaser.com>
 <20220602080257.243x4brmkjgve5kr@pengutronix.de>
 <a4866c5a-5516-06cb-fa1a-83e5014f6d36@kvaser.com>
 <20220602095409.2ytxs4y6o7ctbcp7@pengutronix.de>
From:   Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <20220602095409.2ytxs4y6o7ctbcp7@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 6/2/22 11:54, Marc Kleine-Budde wrote:
> On 02.06.2022 11:22:31, Jimmy Assarsson wrote:
>>>> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
>>>> index e67658b53d02..5880e9719c9d 100644
>>>> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
>>>> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
>>>> @@ -94,10 +94,14 @@
>>>>    static inline bool kvaser_is_leaf(const struct usb_device_id *id)
>>>>    {
>>>> -	return (id->idProduct >= USB_LEAF_DEVEL_PRODUCT_ID &&
>>>> -		id->idProduct <= USB_CAN_R_PRODUCT_ID) ||
>>>> -		(id->idProduct >= USB_LEAF_LITE_V2_PRODUCT_ID &&
>>>> -		 id->idProduct <= USB_LEAF_PRODUCT_ID_END);
>>>> +	return id->idProduct >= USB_LEAF_DEVEL_PRODUCT_ID &&
>>>> +	       id->idProduct <= USB_CAN_R_PRODUCT_ID;
>>>> +}
>>>> +
>>>> +static inline bool kvaser_is_leafimx(const struct usb_device_id *id)
>>>> +{
>>>> +	return id->idProduct >= USB_LEAF_LITE_V2_PRODUCT_ID &&
>>>> +	       id->idProduct <= USB_LEAF_PRODUCT_ID_END;
>>>>    }
>>>
>>> Is this getting a bit complicated now?
>>> In this driver we have:
>>>
>>> 1) struct usb_device_id::driver_info
>>> 2) kvaser_is_*()
>>>
>>> which is used to set
>>>
>>> 3) dev->card_data.leaf.family
>>> 4) dev->ops
>>>
>>> and now you're adding:
>>>
>>> 5) dev->card_data.quirks
>>>
>>> which then affects
>>>
>>> 6) dev->cfg
>>>
>>> The straight forward way would be to define a struct that describes the
>>> a device completely:
>>>
>>> struct kvaser_driver_info {
>>>          u32 quirks;        /* KVASER_USB_HAS_ */
>>>          enum kvaser_usb_leaf_family;
>>>          const struct kvaser_usb_dev_*ops;
>>>          const struct kvaser_usb_dev_*cfg;
>>> };
>>>
>>> and then assign that to every device listed in the kvaser_usb_table.
>>
>> Thanks for the feedback!
>> I agree, but I prefer if we can keep assigning dev->cfg based on the
>> information that we get from the device.
> 
> Ok, if you cannot tell from the USB product ID.

It should be possible, but it will eliminate the risk of me setting
wrong cfg. I don't got access to all the different devices, especially
not the old ones.

>> So we get:
>> struct kvaser_driver_info {
>>          u32 quirks;        /* KVASER_USB_HAS_ */
> 
> That holds the existing quirks and the new one.

Yep!

>>          enum kvaser_usb_leaf_family;
>>          const struct kvaser_usb_dev_*ops;
>> };
>> And quirks and family still affect dev->cfg.
> 
> ...as is depends on sw_options read from the device?

Correct.

Best regards,
jimmy
