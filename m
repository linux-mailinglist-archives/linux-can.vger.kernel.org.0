Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945DD5BDC0D
	for <lists+linux-can@lfdr.de>; Tue, 20 Sep 2022 07:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiITFIz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Sep 2022 01:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiITFIy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Sep 2022 01:08:54 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBD65A3E9
        for <linux-can@vger.kernel.org>; Mon, 19 Sep 2022 22:08:53 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id g20so423961ljg.7
        for <linux-can@vger.kernel.org>; Mon, 19 Sep 2022 22:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zrjoY2Swj7pqgj5x5oj/g4QI5FARtTdyyblnOIltrBY=;
        b=dyqA7OqNlF4PSlfq7iqXz8EHIEeGThIHGxJ8OoYnMLC5dZBGwLXpYBsakdHr45QWmN
         WRCHpc9nWPaSoh1bxdwZ4VIi++5bmONXxvZDD7TXp0rxVN6Unl/lvBOWjPq9GWBsIP8L
         qs00Vg0wU6Ju9iOX/Q1OCBQ6O2+Qq9uneRY74DclstcmsgmkG1wmIqWAFDpagOfYiWNY
         cmcwILUgRGaHK9zHajUM3VMeGXY8Gp4Wdv6KJOvDHmCZzOriXVhFQrWqXiVq8VnKeNoT
         3ZgIhg1yB4uDbekE38iwxHUL1z1BYkR5ftRu/kIlDdHkqLkBp+JGBfu1XrEUhGdl4a7I
         wi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zrjoY2Swj7pqgj5x5oj/g4QI5FARtTdyyblnOIltrBY=;
        b=Yozmb800FacGuVyCodlmNLKj7xWC8+SzmXcmdaDGszEy3IXx9lSmPyuq7cOcuUs/IQ
         mfNujjS/xubtfhIkS+2Nhia4+XzJbgieZK0qZVzKn8uoQu3+fob6ODSiqaDiTJhLaRP6
         mwXP7XmSs3ytxrQMZykwcnbszvpvvfda1h1S48Jn5sK3fE7U/OIGw3qz5P/kqQVgu31x
         /320oCRRHmDgcOs+Cz0OK7P73OahMMIrO8MV/4sf7uSakX5NqADxTlyNqUjLsxj4+PEk
         voCsJxltLe9Ya1rxngMkr4lBc3273GvG9L8IhimoesB74CKciCcgOs7EAQEtLOMG3qWM
         Dleg==
X-Gm-Message-State: ACrzQf3lKKmWrFKQCZdD5LN7jxLXJqtC3QXBNQcBrmbNPega9fbWPuX1
        BfPVcCUhVgAC1Vb6DftKwoQ=
X-Google-Smtp-Source: AMsMyM5WK/bUHQYOOM6ZxNgM4F1AljCKCiiT04TMjoRwKmDS4FrvjdIOZ8PG7h9ZgbL2xmwCdkHymQ==
X-Received: by 2002:a2e:8484:0:b0:25e:c325:c94f with SMTP id b4-20020a2e8484000000b0025ec325c94fmr6621218ljh.310.1663650531180;
        Mon, 19 Sep 2022 22:08:51 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b00498f570aef2sm115503lfg.209.2022.09.19.22.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 22:08:50 -0700 (PDT)
Message-ID: <66157118-30e6-13af-a0b2-33ec469f1cbc@gmail.com>
Date:   Tue, 20 Sep 2022 07:08:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, dariobin@libero.it,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
 <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
 <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
 <02aeeca7-5958-60f1-3011-fa3aae4ef6b5@gmail.com>
 <CAMZ6RqJPo4t_J+OTqVSX_1-+81-j6LAF-NNxwBNeSAyqHGFBsg@mail.gmail.com>
From:   Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <CAMZ6RqJPo4t_J+OTqVSX_1-+81-j6LAF-NNxwBNeSAyqHGFBsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

On 9/20/22 03:23, Vincent Mailhol wrote:
> On Tue. 20 Sep. 2022 at 08:43, Jacob Kroon <jacob.kroon@gmail.com> wrote:
>> Hi Marc and Dario,
>>
>> On 9/16/22 06:14, Jacob Kroon wrote:
>> ...> What I do know is that if I revert commit:
>>>
>>> "can: c_can: cache frames to operate as a true FIFO"
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=387da6bc7a826cc6d532b1c0002b7c7513238d5f
>>>
>>> then everything looks good. I don't get any BUG messages, and the host
>>> has been running overnight without problems, so it seems to have fixed
>>> the network interface lockup as well.
>>
>> I ran the kernel *with* the commit above, and also with the following patch:
>>
>>> diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
>>> index 52671d1ea17d..4375dc70e21f 100644
>>> --- a/drivers/net/can/c_can/c_can_main.c
>>> +++ b/drivers/net/can/c_can/c_can_main.c
>>> @@ -1,3 +1,4 @@
>>> +#define DEBUG
>>>   /*
>>>    * CAN bus driver for Bosch C_CAN controller
>>>    *
>>> @@ -469,8 +470,15 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
>>>        if (c_can_get_tx_free(tx_ring) == 0)
>>>                netif_stop_queue(dev);
>>>
>>> -     if (idx < c_can_get_tx_tail(tx_ring))
>>> +     netdev_dbg(dev, "JAKR:%d:%d:%d:%d\n", idx,
>>> +                                           c_can_get_tx_head(tx_ring),
>>> +                                           c_can_get_tx_tail(tx_ring),
>>> +                                           c_can_get_tx_free(tx_ring));
>>> +
>>> +     if (idx < c_can_get_tx_tail(tx_ring)) {
>>>                cmd &= ~IF_COMM_TXRQST; /* Cache the message */
>>> +             netdev_dbg(dev, "JAKR:Caching messages\n");
>>> +     }
>>>
>>>        /* Store the message in the interface so we can call
>>>         * can_put_echo_skb(). We must do this before we enable
>>
>> and I've uploaded the entire log I could capture from /dev/kmsg, right
>> up to the hang, here:
>>
>> https://pastebin.com/6hvAcPc9
>>
>> What looks odd to me right from the start is that sometimes when idx
>> rolls over to 0, and *only* when it rolls over to 0, the CAN frame gets
>> cached because "idx < c_can_get_tx_tail(tx_ring)".
> 
> This looks like a classic integer wraparound issue. A cast to s32
> should do the trick:
>    (s32)idx - c_can_get_tx_tail(tx_ring) < 0
> 
> This is not tested. I let you double check. You can refer to this
> function for an example:
> https://elixir.bootlin.com/linux/v5.19/source/drivers/net/can/usb/etas_es58x/es58x_core.c#L336
> 

I tried that change but there is no change in behaviour, and I don't see 
why it would make a difference since both expressions "idx" and 
"c_can_get_tx_tail(tx_ring)" are unsigned expressions to begin with.

Regards,
Jacob
