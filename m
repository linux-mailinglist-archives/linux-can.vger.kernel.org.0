Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8561357764D
	for <lists+linux-can@lfdr.de>; Sun, 17 Jul 2022 15:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiGQNHn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 17 Jul 2022 09:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiGQNHn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 17 Jul 2022 09:07:43 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC4412629
        for <linux-can@vger.kernel.org>; Sun, 17 Jul 2022 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658063257;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PkTyuX+v5+VsCgfnL7GcyDs6SQV3YrqU2bxbqJg0iPg=;
    b=P379k95IZ7motSLpIBDTVas9oVvlwT7Y1Ah+Aj9xFzgmFbHvxLD4KfBFtjxytGTyUg
    IyA3Wtf9LaBocDs56jnte9Vqkho8be44Up0O6q3Imc/oPyEC+M5c2rYEMhquGcHps1Tz
    P+QBmPJye2qRqkMhEixm6o3yuBQ4WDyj+0ZFFX/IbiQr7ncD1NX5ax15ldpYzB8O7QYx
    K4ZbYTZQ+d+gge057/ef8xjYWDQDJSCKLxYiXP46JVcveIyDSSPi5R9L9H114Spy+Kvp
    LgE9GaIo3cBrHctv0ZlPYZHYnzKYY5jgsZV27Zwpu5T3YUzOI7Fr2/+qA9xxwYbYsf/f
    aZ7Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6HD7bB6M
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 17 Jul 2022 15:07:37 +0200 (CEST)
Message-ID: <b93ef7c8-9960-ff38-71af-168f26f1af0c@hartkopp.net>
Date:   Sun, 17 Jul 2022 15:07:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 3/5] can: dev: add CAN XL support
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20220714160541.2071-1-socketcan@hartkopp.net>
 <20220714160541.2071-4-socketcan@hartkopp.net>
 <20220714200601.mklari3b6uvb7b2e@pengutronix.de>
 <c731143e-f476-b2f8-c08c-df66339d98f8@hartkopp.net>
 <CAMZ6RqJ0=PhrJUHaZR6QNWkv2vx690AiwPF2RLv1ou_JGX1qxg@mail.gmail.com>
 <931b0b22-dbe6-454b-8281-4f94856288a1@hartkopp.net>
 <CAMZ6RqKdBPQ4xD4TcYgsbxAYJBq-5NMr4QsvaLomoirMx2haGA@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqKdBPQ4xD4TcYgsbxAYJBq-5NMr4QsvaLomoirMx2haGA@mail.gmail.com>
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



On 15.07.22 10:28, Vincent Mailhol wrote:
> On Fri. 15 Jul. 2022 at 15:51, Oliver Hartkopp <socketcan@hartkopp.net> wrote:


>> But then you would have to name it struct canxlhdr or canxl_hdr to
>> follow this pattern, right?
>>
>> And this is my other problem. The struct canxl_frame should be able to
>> contain a CAN XL frame (as can[fd]_frame do).
>>
>> I'm fine with introducing e.g. a
>>
>> struct canxl_hdr {
>>          canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>>          __u8    flags; /* additional flags for CAN XL */
>>          __u8    sdt;   /* SDU (service data unit) type */
>>          __u16   len;   /* frame payload length in byte */
>>          __u32   af;    /* acceptance field */
>>          __u8    data[];
>> };
>>
>> and propose the suggested use-patterns.
> 
> No, you misunderstood my comment. The ipdhr and tcphdr was to
> illustrate the fact that it is not uncommon to build some data
> structure on your own. In those two examples, the hdr suffix is used
> because there is no payload (i.e. no data field in the struct).
> 
> In our case, it would be:
> 
> struct canxl_hdr {
>          canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>          __u8    flags; /* additional flags for CAN XL */
>          __u8    sdt;   /* SDU (service data unit) type */
>          __u16   len;   /* frame payload length in byte */
>          __u32   af;    /* acceptance field */
> };
> struct canxl {
>          struct canxl_hdr hdr;
>          __u8    data[];
> }
> 
> Which is equivalent to:
> 
> struct canxl {
>          canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>          __u8    flags; /* additional flags for CAN XL */
>          __u8    sdt;   /* SDU (service data unit) type */
>          __u16   len;   /* frame payload length in byte */
>          __u32   af;    /* acceptance field */
>          __u8    data[];
> };
> 

Unfortunately not really.

You have the same memory layout but you can access the content in a 
different way:

struct canxl cxl1; (the first one)

cxl1.hdr.flags


struct canxl cxl2; (the second one)

cxl2.flags

:-/

It would be cool to handle and define

struct canxl_hdr

that could be used in

struct canxl_frame (containing data[2048])

and

struct canxl_msg (containing data[])

But this might confuse programmers even more.


Regards,
Oliver
