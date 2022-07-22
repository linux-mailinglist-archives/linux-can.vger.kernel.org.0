Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B3E57E6DB
	for <lists+linux-can@lfdr.de>; Fri, 22 Jul 2022 20:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbiGVSws (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 22 Jul 2022 14:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiGVSwq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Jul 2022 14:52:46 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3561A895A
        for <linux-can@vger.kernel.org>; Fri, 22 Jul 2022 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658515961;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=oGwghrzhWAGesDYCrWR9faYNg9miktfJ7qX61WKGJes=;
    b=as+aqqsfrQNHS9xrehvEIX50er3K2R086YncSePtUUeKRpCazZdlg/gyoMn4SuyIbw
    WY4N5LPXwR2tZsPFNv9qkm5XWDEv1Vhu+LkCEJONfxnkwxE42f6iJNr4InEapg4T9DzK
    LHHI03kVtlQHCJlQVGQt6XIWKndEJC3t1ZrenCi/WrcioxX/k0GwGA71BDD+HbrpaJmo
    98kmUUuZY6rb3Nd0EQ8Ph0Ner43VCasX12Y2owF7bGU1AGzMMLqE2dlDMP/oN7uyAb1J
    55+bU4stV5JBx7bWQdaSo5kSABmkVWNsZWfHalHYMjNzE783m+2P2FvNhZgdYJAwM8TC
    ZVUg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id jdcffay6MIqf74Q
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 22 Jul 2022 20:52:41 +0200 (CEST)
Message-ID: <e4e74603-5db6-04bd-295e-2b20c96c39e7@hartkopp.net>
Date:   Fri, 22 Jul 2022 20:52:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
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
 <0046f0e1-0bd4-0add-7759-ed459fd050fb@hartkopp.net>
 <CAMZ6RqKn7W26LwaJmdJ-1cpF7bZScHEcUiscLjtGNbAd=1_OeA@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqKn7W26LwaJmdJ-1cpF7bZScHEcUiscLjtGNbAd=1_OeA@mail.gmail.com>
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



On 22.07.22 18:32, Vincent Mailhol wrote:
> On Sat. 23 Jul. 2022 at 00:30, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> On 22.07.22 12:54, Vincent Mailhol wrote:
>>> On Fri. 22 Jul. 2022 at 18:58, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>>> On 22.07.2022 17:33:08, Vincent Mailhol wrote:
>>>>> On Fri. 22 Jul. 2022 at 16:27, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>>>>> On 22.07.2022 12:20:43, Vincent Mailhol wrote:
>>>>>>> I do not buy your argument that you can not do sizeof(struct
>>>>>>> canxl_frame) because of naming.
>>>>>>>
>>>>>>> With a flexible array member, I can do:
>>>>>>>
>>>>>>> struct canxl_frame {
>>>>>>>            canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>>>>>>>            __u8    flags; /* additional flags for CAN XL */
>>>>>>>            __u8    sdt;   /* SDU (service data unit) type */
>>>>>>>            __u16   len;   /* frame payload length in byte */
>>>>>>>            __u32   af;    /* acceptance field */
>>>>>>>            __u8    data[];
>>>>>>> };
>>>>>>>
>>>>>>> void foo (int s)
>>>>>>> {
>>>>>>>            struct canxl_frame cxl_hdr = { 0 };
>>>>>>>            struct canxl_frame *cxl1, *cxl2;
>>>>>>>            size_t cxl2_data_len, cxl2_frame_len;
>>>>>>>
>>>>>>>            /* read header */
>>>>>>>            assert(read(s, &cxl_hdr, sizeof(cxl_hdr)) == sizeof(cxl_hdr));
>>>>>>>            cxl1 = malloc(sizeof(*cxl1) + cxl_hdr.len);
>>>>>>>            memcpy(cxl1, &cxl_hdr, sizeof(cxl_hdr));
>>>>>>>            /* read remaining data */
>>>>>>>            assert(read(s, cxl1->data, cxl1->len) == cxl1->len);
>>>>>>
>>>>>> For performance reasons you probable don't want to split the read of a
>>>>>> single CAN frame over 2 read() syscalls.
>>
>> Yes, two read() syscalls (with testing/asserting for the right size),
>> one malloc() syscall, one memcpy().
>>
>> Alternatively I can offer ONE syscall with ONE single copy operation
>> from kernel to userspace \o/
>>
>> read(s, &can.xl, sizeof(struct canxl_frame));
> 
> You just ignored what I wrote just below:
> | I wrote the code to illustrate how to do header
> | manipulations. The goal of this example was not to be optimal
> | but to show off how sizeof(struct canxl_frame) could be used.
> 
> I was answering your "This is no sizeof(struct canxl_frame) anymore" comment.
> 
> You can do:
> | struct canxl_frame *cxl = malloc(CANXL_MTU);
> | read(s, cxl, CANXL_MTU);
> 
> In fact, the sizeof() will be mostly useful in the tx path when doing
> write(), not in the rx when you will likely always provide a buffer of
> maximum size. Now I regret sending my example.
> 
>> The more I read about splitting/peeking/testing, calculating of sizes,
>> etc the more I like the simple struct canxl_frame with 2048 bytes of
>> data that is specified to be truncated by definition.
>>
>> E.g. for candump or other usual CAN applications you can run with *one*
>> static struct without any malloc(). This is not only a bridge for
>> application programmers that have experiences in programming SocketCAN
>> applications - it is just a safe and simple pattern that I would not
>> like to give up for which improvement?
> 
> The possibility to do static declaration is the strongest argument in
> your favor.

Yes. And it is a good argument.

> There is no easy way to do this with flexible array member aside maybe
> of the convoluted:
> | char buf[CANXL_MTU];
> | struct canxl_frame *cxl = &(struct canxl_frame)buf;
> 
> But I do not see the problem of using dynamic memory. For a 2
> kilobytes buffer, dynamic memory looks pretty standard to me.

I do see a problem with it and definitely have another personal 
preference. So far I did not need dynamic memory to process CAN content 
in CAN applications which is a good (and required) pattern for embedded 
automotive applications and allows to port concepts and code between 
these two worlds.

> And one
> more time, is there any precedent in the kernel uapi of not using
> flexible array members for structures meant to hold more than one
> kilobyte? For the tiny CAN(-FD) it made sense, the same argument does
> not translate so easily when going from ~64B to ~2KB.

Because of what?

IMO it is a proper follow up of the current CAN_RAW API.

> My main point is that your approach does not follow what I could
> witness so far in the UAPI. You have not yet answered this point.

There is an ioctl:

https://manpages.debian.org/testing/manpages-de-dev/ioctl_list.2.de.html

0x4FA44308 	SNDCTL_COPR_SENDMSG 	const struct copr_msg *
0x8FA44309 	SNDCTL_COPR_RCVMSG 	struct copr_msg *

include/uapi/linux/soundcard.h

typedef struct copr_msg {
                 int len;
                 unsigned char data[4000];
         } copr_msg;


>> In fact I don't know any SocketCAN application that uses malloc for CAN
>> frames which likely introduces lags and affects the performance.
> 
> This argument is invalid. You can malloc() once at the beginning of
> the program and reuse it for the entire lifetime (please forget my
> previous code snippet which was not meant to be performant).
> There is no way that a single malloc can introduce noticeable lags
> compared to a static allocation.

As described above omitting dynamic memory as a whole is a valid 
pattern. And so far no one needs dynamic memory or has to be encouraged 
to use it.

With the API of truncated CAN XL frames you can do whatever you want 
(even make use of malloc()) on the user space side.

I don't see any real argument to leave the established pattern.

You probably might feel that I don't like dynamic arrays or have some 
problems of making use of it. This is not the case:

include/uapi/linux/can/bcm.h

struct bcm_msg_head {
         __u32 opcode;
         __u32 flags;
         __u32 count;
         struct bcm_timeval ival1, ival2;
         canid_t can_id;
         __u32 nframes;
         struct can_frame frames[0];
};


Which leads to:

linux-can/can-tests/bcm/tst-bcm-filter.c

struct {
         struct bcm_msg_head msg_head;
         struct can_frame frame[4];
} txmsg, rxmsg;


txmsg.msg_head.opcode  = RX_SETUP;
txmsg.msg_head.can_id  = 0x042;
txmsg.msg_head.flags   = SETTIMER|RX_FILTER_ID;
txmsg.msg_head.ival1.tv_sec = 1;
txmsg.msg_head.ival1.tv_usec = 0;
txmsg.msg_head.ival2.tv_sec = 0;
txmsg.msg_head.ival2.tv_usec = 0;
txmsg.msg_head.nframes = 0;

But this is something different to me than having a struct canxl_frame 
without data - especially as it requires at least one data byte 
(CANXL_MIN_DLEN) to be a valid CAN XL frame.

struct canxl_frame {
         canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
         __u8    flags; /* additional flags for CAN XL */
         __u8    sdt;   /* SDU (service data unit) type */
         __u16   len;   /* frame payload length in byte */
         __u32   af;    /* acceptance field */
         __u8    data[CANXL_MIN_DLEN];
};

A truncated CAN XL frame structure with a data section that contains as 
much valid bytes as given in the len element is the exact representation 
of what you will see on the wire.

For some reason you seem to stick on this (even invalid) "UAPI is using 
dynamic arrays" stuff instead of enhancing and improving the established 
handy and safe pattern for CAN frames.

Regards,
Oliver
