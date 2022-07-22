Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C6F57E3C9
	for <lists+linux-can@lfdr.de>; Fri, 22 Jul 2022 17:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiGVPa3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 22 Jul 2022 11:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiGVPa2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Jul 2022 11:30:28 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9C920F67
        for <linux-can@vger.kernel.org>; Fri, 22 Jul 2022 08:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658503825;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WDDz8izOrhXjtFRH958AOUKizk8Ewhm8lx/GePAGWSY=;
    b=U2LV/saTEbkLnX8kP05/TLU4NEHwHp7dcJg6z4NSg7vcONnCf813AvYjuOPmpG1h+i
    NuDZSXGqv/OnAqAL9hZhYyDNHmpuo8OLiL0WrRvSt72SBYwLjkb6mSOIYLVZw6Pv0IMm
    bwwbxLRRrP1cnCTADYQqkkfLPkYlD6IPJVLix4yNQ6HNudOMpCoC3ZuUcNNAKE2PqaUP
    JUEU6wiSVLF11GMiKLOsKPsnqoWhGE3C250kMurUBaruy2XT7/34Q4dCdkd3n+RajvWF
    OFq/eiOzAEWuf6xZSCV4hIJm6PLRvy9dvxTr8CPe6F6QyHWhwz/lR0VsVrW9Wos4TqUJ
    mM1w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id jdcffay6MFUP6tt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 22 Jul 2022 17:30:25 +0200 (CEST)
Message-ID: <0046f0e1-0bd4-0add-7759-ed459fd050fb@hartkopp.net>
Date:   Fri, 22 Jul 2022 17:30:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net>
 <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
 <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net>
 <20220721075309.l6uusnyk7xjkqd4g@pengutronix.de>
 <CAMZ6RqJTZ4o3dsaYG2s9boJ4By7QC55-N+0RszT9LNxRp3bYuA@mail.gmail.com>
 <ea8ffea6-1065-8526-4774-16d088ec7bf1@hartkopp.net>
 <CAMZ6Rq+NWFc4KmhCCpJ2LzTt8ap1U_FLrQ1L1RQgYNT0BD3w_Q@mail.gmail.com>
 <20220722072731.s3s7bkfn33zzzeni@pengutronix.de>
 <CAMZ6RqJcUtSyYbYnqAE87hrwL1G+cxGLKAZ_E4kvSW3Mq43tYg@mail.gmail.com>
 <20220722095853.jb3ko4qsktud5uob@pengutronix.de>
 <CAMZ6Rq+GZTifSLqO6V_wErtx5U932cnTO2ktMSjnq_ybPCx91Q@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6Rq+GZTifSLqO6V_wErtx5U932cnTO2ktMSjnq_ybPCx91Q@mail.gmail.com>
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



On 22.07.22 12:54, Vincent Mailhol wrote:
> On Fri. 22 Jul. 2022 at 18:58, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>> On 22.07.2022 17:33:08, Vincent Mailhol wrote:
>>> On Fri. 22 Jul. 2022 at 16:27, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>>> On 22.07.2022 12:20:43, Vincent Mailhol wrote:
>>>>> I do not buy your argument that you can not do sizeof(struct
>>>>> canxl_frame) because of naming.
>>>>>
>>>>> With a flexible array member, I can do:
>>>>>
>>>>> struct canxl_frame {
>>>>>           canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>>>>>           __u8    flags; /* additional flags for CAN XL */
>>>>>           __u8    sdt;   /* SDU (service data unit) type */
>>>>>           __u16   len;   /* frame payload length in byte */
>>>>>           __u32   af;    /* acceptance field */
>>>>>           __u8    data[];
>>>>> };
>>>>>
>>>>> void foo (int s)
>>>>> {
>>>>>           struct canxl_frame cxl_hdr = { 0 };
>>>>>           struct canxl_frame *cxl1, *cxl2;
>>>>>           size_t cxl2_data_len, cxl2_frame_len;
>>>>>
>>>>>           /* read header */
>>>>>           assert(read(s, &cxl_hdr, sizeof(cxl_hdr)) == sizeof(cxl_hdr));
>>>>>           cxl1 = malloc(sizeof(*cxl1) + cxl_hdr.len);
>>>>>           memcpy(cxl1, &cxl_hdr, sizeof(cxl_hdr));
>>>>>           /* read remaining data */
>>>>>           assert(read(s, cxl1->data, cxl1->len) == cxl1->len);
>>>>
>>>> For performance reasons you probable don't want to split the read of a
>>>> single CAN frame over 2 read() syscalls.

Yes, two read() syscalls (with testing/asserting for the right size), 
one malloc() syscall, one memcpy().

Alternatively I can offer ONE syscall with ONE single copy operation 
from kernel to userspace \o/

read(s, &can.xl, sizeof(struct canxl_frame));

The more I read about splitting/peeking/testing, calculating of sizes, 
etc the more I like the simple struct canxl_frame with 2048 bytes of 
data that is specified to be truncated by definition.

E.g. for candump or other usual CAN applications you can run with *one* 
static struct without any malloc(). This is not only a bridge for 
application programmers that have experiences in programming SocketCAN 
applications - it is just a safe and simple pattern that I would not 
like to give up for which improvement?

In fact I don't know any SocketCAN application that uses malloc for CAN 
frames which likely introduces lags and affects the performance.

Best regards,
Oliver

>>>
>>> ACK. I wrote the code to illustrate how to do header manipulations.
>>> The goal of this example was not to be optimal but to show off how
>>> sizeof(struct canxl_frame) could be used. Sorry if the example was not
>>> natural and a bit too forced.
>>>
>>>> Also the CAN_RAW doesn't
>>>> support "split"-read now, but could be extended.
>>>
>>> Interesting! I naively thought that split read() was handled at a
>>> higher level of the socket API. I did not know that it was per
>>> protocol.
>>
>> The CAN_RAW protocol implements raw_recvmsg():
>>
>> | https://elixir.bootlin.com/linux/latest/source/net/can/raw.c#L843
>>
>>> It could make sense to allow such split read() for CANXL.
>>
>> Then we have to track the number of already read bytes inside the
>> socket. The POSIX API offers some interesting flags to recvmsg(). With
>> MSG_PEEK you can read but not remove the read data from the queue and/or
>> MSG_TRUNC to get the total size of the CAN frame.
>>
>> I have not tested these flags, but I think support for them has to be
>> implemented in CAN_RAW, too.
>>
>> Also, we should have a look at the UDP code.
> 
> Here it is:
> https://elixir.bootlin.com/linux/latest/source/net/ipv4/udp.c#L1846
> 
> The relevant function is sk_peek_offset:
> https://elixir.bootlin.com/linux/latest/source/include/net/sock.h#L617
> 
> And to finish, there is an nearly eponym field in struct sock: sk_peek_off
> https://elixir.bootlin.com/linux/latest/source/include/net/sock.h#L457
> 
>>> One example
>>> I can directly think of is the Packet API. Correct me if I am wrong
>>> but if writing generic code to dump packets on any interfaces, you do
>>> not know in advance the MTU. And so, I guess you have to provide a
>>> buffer of an arbitrary size. A generic program using a buffer of, let
>>> say, 2048 bytes (one page) will not be enough to get a CANXL frame in
>>> one single shot.
>>
>> Nitpick: the page size is arch and/or kernel config dependent and the
>> smallest page size that Linux supports is 4k.
> 
> Arg, I did not have enough sleep.
> 
> By the way, do you have a preference between the flexible array member
> and the data[CANXL_MAX_DLEN]? So far, I have been pushing the idea of
> the flexible array member but if I am the only one to support this
> idea, we can call it a day and use the data[CANXL_MAX_DLEN] approach.
> 
> 
> Yours sincerely,
> Vincent Mailhol
