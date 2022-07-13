Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD1573D79
	for <lists+linux-can@lfdr.de>; Wed, 13 Jul 2022 22:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiGMUCQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Jul 2022 16:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiGMUCP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Jul 2022 16:02:15 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A622CCA0
        for <linux-can@vger.kernel.org>; Wed, 13 Jul 2022 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657742532;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ma3brChzxgu2VSqq09trHWpxnYLZucztYG38pSgmVzc=;
    b=NnyUZzl2V86EB77V+ErHCxYYLyX9WfRjTGShENccI6tQBHsAzTbnCI/epLWePdRUfy
    Fvsc+a1zoN/aBm+EF3OhCY8oBii8IQrkhq9ihH/ND1fwjfwzFINJU9ySdq5LjGiyR8cd
    iBgrjpNuwc4IozYISSw9GZ537eM11U4XaYqqaWq+QSaxJYZSZ+meMERMivE67jAon+JB
    JXtRvaEK7UtckV8elhGYIlCwbxh/crmwO8Fbk/wxUMFwTBAvlksavuf+VGuLlQ0L6PUD
    LPoqa3E89PDjkpl/oX7qHDRTs7v02MbLmfmBQJvwwmtrCw808x6vgAA5lwxu3C7iq0lp
    kuyw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6DK2C3du
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 13 Jul 2022 22:02:12 +0200 (CEST)
Message-ID: <16457321-6a4f-4830-17aa-d6efd7a39555@hartkopp.net>
Date:   Wed, 13 Jul 2022 22:02:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 1/5] can: canxl: introduce CAN XL data structure
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-2-socketcan@hartkopp.net>
 <CAMZ6RqLqDFqdtKsp6jGhnTtWRrf6HC5HiLuJUSCRNkDXqVfCzA@mail.gmail.com>
 <f00a4c5d-c4e6-06a2-76c0-53105d3465f2@hartkopp.net>
 <CAMZ6RqLVvYCoBF67VtqUSJHAxBHvEmK2-o8NCD7REZj1ywXf7w@mail.gmail.com>
 <521fe0a3-a9ad-60ac-3ec6-30f0da228032@hartkopp.net>
 <CAMZ6RqJhjkVgZgmfk7btYK+bLtqnbvGBYTnssy28ZWqyfyqppw@mail.gmail.com>
 <89f90d61-35a4-59a2-231b-4372d4dca25c@hartkopp.net>
 <CAMZ6Rq+LqfUhLcg6909=239a+Asm6aO-bPqpar2tQ_fs0EmiUQ@mail.gmail.com>
 <b866e05b-a548-132c-4427-7a4d21d12172@hartkopp.net>
 <CAMZ6RqLGWB-afDmZfV+qJU2g=XUycFS1o9j6EwqRVg_dyf4eOw@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqLGWB-afDmZfV+qJU2g=XUycFS1o9j6EwqRVg_dyf4eOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 13.07.22 03:07, Vincent Mailhol wrote:
> On Wed. 13 Jul. 2022 at 04:24, Oliver Hartkopp <socketcan@hartkopp.net> wrote:


> Well, if we document than can_frame::__pad shall be zero for mix
> usages (i.e. comments in struct can_frame and updated kernel doc),
> then we would have done our due diligence. From that point, if people
> ignore the documentation *and* do not follow best practices for safety
> application development, I wouldn't cry.

Right. As long as we did not enable CAN_XL we do not need to take care. 
And introducing the restriction to set __pad to zero together with the 
new CAN_XL option seems legit.

> If we absolutely want to prevent struct can_frame to be interpreted as
> a canxl_frame due to some stack garbage, we can add one
> padding/reserved field like that:
> 
> struct canxl_frame {
>          canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>          __u8    sdt;   /* SDU (service data unit) type */
>          __u8    flags; /* additional flags for CAN XL */
>          __u16   len;   /* frame payload length in byte */
>          __u32   af;    /* acceptance field */
>          __u32 __res; /* reserved field. Shall be zero */
>          __u8    data[] __attribute__((aligned(8)));
> };
> 
> This way, the minimum transfer unit of CANXL is 17 bytes (16 for
> header and 1 for data) which is exactly one byte more than can_frame
> (and we get back the 8 bytes alignment \o/)
> 
> This would only leave the risk of having some garbage in
> canfd_frame::flags, e.g. if user does:
> 
>          struct canfd_frame cfd; /* declared on the stack and not initialized */
>          cfd.flags |= <some_flags> /* use |= instead of = */
> 
> But this is already risky for plain CAN-FD.

Hm, this brings me to an even more weird idea:

struct canxl_frame {
         canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
         __u8    sec:1, /* SEC bit */
                 xltag:7; /* all bits set */
         __u8    sdt;   /* SDU (service data unit) type */
         __u16   len;   /* frame payload length in byte */
         __u32   af;    /* acceptance field */
         __u8    data[CANXL_MAX_DLEN];
};

We could set the first byte (former len element) to a value of 0x7F and 
define the SEC bit as 0x80.

This would mean that we use the former length element to indicate the 
CAN XL frame as no CAN/CANFD frame can have a length of 127 and above.

Not sure if it makes sense to define some bits as depicted above, or if 
we should define a __u8 xlsec ?

Where we define

#define CANXL_TAG 0x7F
#define CANXL_SEC 0x80

which has to be set in the xlsec element then.

With this move we get rid of any flags problems (we only need the SEC 
bit anyway) and define a clear 'escape value' in the former length element.

(..)

>>
>> You are right about the inconsistency. But it needs to be
>>
>> #define CANXL_MIN_DLEN 1
>> #define CANXL_MAX_DLEN 2048
>>
>> to fit the CAN/CANFD definitions.
> 
> ACK.
> 
>>>> #define CANXL_MTU sizeof(struct canxl_frame)
>>>> #define CANXL_HEAD_SZ (CANXL_MTU - CANXL_MAXDLEN)
>>>> #define CANXL_MINTU (CANXL_HEAD_SZ + CANXL_MINDLEN)
>>>
>>> I need to think twice about all that, all the different alternatives
>>> (allow or not garbage, data as flexible member array vs.
>>> data[CANXL_DLEN]). Now it is a bit late, so I will continue to think
>>> about all that tomorrow.
>>
>> I would suggest to not allow garbage and have skbuff::len and
>> canxl_frame::len in sync.
>>
>> When a userspace application writes more bytes than needed by
>> canxl_frame::len, then that garbage is cropped to the needed size.
> 
> Cropped by whom? My point is to allow userspace to leave garbage. I am
> totally OK with cropping the frames as soon as they enter the kernel.

That was exactly what I wanted to say :-D

- be very strict inside the kernel
- and crop the userspace garbage away when entering the kernel

> On the other hand, the kernel shall always return cropped frames to
> the userland. To summarize, skb and data len synchronisation is
> optional for userland but mandatory for kernel drivers.

ACK!

Best regards,
Oliver

