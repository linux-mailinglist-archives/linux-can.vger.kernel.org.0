Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B587A57D3DD
	for <lists+linux-can@lfdr.de>; Thu, 21 Jul 2022 21:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiGUTKD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Jul 2022 15:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiGUTKB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Jul 2022 15:10:01 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B108CEBD
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658430596;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BtqRHcqs6vyelBQAxMBQ2/3RYJYRuzDo6rJoG0fioLU=;
    b=krUu/Qt454GX5SvsnHsYH5SNCbEbpvG2XsPBHZC4gVozsNqvo84oJMbyE/tcaw1XmV
    YJg9fz8mQUxK4wUg6JW2tW93AfSVuuDoT4jXrbuMk/ZfrRdUliO+W+48YU4eYwg6stfv
    ZGwLtJluaiUisxPq0bAEO4M+bzmCXUln+JNsUZCLR4jQhREGaLKDIRJ1H/IFNyOI8iaw
    7H1RxN3v+iuKTZi9deYTWjCBryhaTreXg4b9lyH/sJqBB13jTSkNsVJQ9MuwD56JB4N3
    +LVusI0iOJjFMABXDdhFjQosRrKERhfNTjLNnn19lXx51IMb4f0NXBY+piTcPO5M+TtI
    /oCA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id jdcffay6LJ9u4Wz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 21 Jul 2022 21:09:56 +0200 (CEST)
Message-ID: <ea8ffea6-1065-8526-4774-16d088ec7bf1@hartkopp.net>
Date:   Thu, 21 Jul 2022 21:09:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <20220719112748.3281-1-socketcan@hartkopp.net>
 <20220719112748.3281-4-socketcan@hartkopp.net>
 <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com>
 <f8ec078d-44c9-9f8c-800f-058e4c735003@hartkopp.net>
 <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net>
 <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
 <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net>
 <20220721075309.l6uusnyk7xjkqd4g@pengutronix.de>
 <CAMZ6RqJTZ4o3dsaYG2s9boJ4By7QC55-N+0RszT9LNxRp3bYuA@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqJTZ4o3dsaYG2s9boJ4By7QC55-N+0RszT9LNxRp3bYuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 21.07.22 10:14, Vincent Mailhol wrote:
> On Thu. 21 Jul. 2022 at 16:53, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>> On 21.07.2022 09:36:21, Oliver Hartkopp wrote:
>>> Btw. How should we finally name the 'non data' header of CAN XL?
>>>
>>> 1. CANXL_HEADER_SIZE
>>> 2. CANXL_HEAD_SIZE
>>> 3. CANXL_HDR_SIZE
>>> 4. CANXL_HDR_SZ <- currently in the patches
>>> 5. CANXL_HD_SZ
>>>
>>> I think it has to be 'head' and not 'header'.
>>
>> Header! Header is in front of data.
> 
> I am also part of the header team! By analogy with:
> https://en.wikipedia.org/wiki/IPv4#Header
> 
>>> In skbs we also have head and tail.
>>
>> Yes, but they point at the head or tail of the buffer allocated with the
>> skb.
>>
>>> So I would vote for 2 or 5 with a tendency to 5.
>>
>> 3, 1, 4
> 
> My top vote goes to:
> 6. No macro, instead use flexible array member and do sizeof(struct canxl_frame)

This is no sizeof(struct canxl_frame) anymore with the use of a flexible 
array because a valid "CAN XL frame" has data (at least one byte and up 
to 2048 byte).

You might name it

struct canxl_header {
         canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
         __u8    flags; /* additional flags for CAN XL */
         __u8    sdt;   /* SDU (service data unit) type */
         __u16   len;   /* frame payload length in byte */
         __u32   af;    /* acceptance field */
         __u8    data[];
};

But then you can't build a struct canxl_frame anymore in the way that 
you can access the elements as you can do it today:

struct canxl_frame {
          struct canxl_header xldhr;
          data[CANXL_MAX_DLEN];
};

struct canxl_frame cfx;

=> cfx.xlhdr.len

Which is not cfx.len anymore what is a known pattern from struct 
can[fd]_frame from CAN application programmers and simple to use.

The only new thing is the possibility to handle a truncated data[] 
section. That should be feasible to learn.

> I do not like the SZ abbreviation either, so my next choices will be 3 then 1.
> 
> To recap: 6, 3, 1.

Then CANXL_HDR_SIZE wins :-)

Regards,
Oliver
