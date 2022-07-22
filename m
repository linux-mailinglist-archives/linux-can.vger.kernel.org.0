Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D18457E474
	for <lists+linux-can@lfdr.de>; Fri, 22 Jul 2022 18:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbiGVQcj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 22 Jul 2022 12:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbiGVQca (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Jul 2022 12:32:30 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9130E97D63
        for <linux-can@vger.kernel.org>; Fri, 22 Jul 2022 09:32:29 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i206so8914648ybc.5
        for <linux-can@vger.kernel.org>; Fri, 22 Jul 2022 09:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/+8hHkKoZG6sbtRbkFp/q2Kwxtk9GjTQelibie/4zM=;
        b=HUWIJB986WdQHGYBArmEvoib5ErJXPmluTcsS7RErSIslWE8ArrYm/2WcWrx1VMq4R
         BdwfR/4RvuWV892TkpvoYqP+JPfJZnxFRFnfuQ1tV41ziah2bFTKA5qXWJMCHEKyD6dJ
         ea8yYVen1OLJUYKdLCNkQAxSZGxznSxDhJRqVRFNK8QI4teSbj775F0VfIg6VWetYeo5
         pZQL6owLA4pAw761FOZkcDJ964oGqiV8vbug01oNItN8riHcPxCFMNX3C1AmQMYpdNYL
         aTvmk9Bw48dmMjCPpVvGKMSQRxtRfeEwaXiXk91w2cJ9Qkm/gWfz8wMPBS33I23EYtae
         LQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/+8hHkKoZG6sbtRbkFp/q2Kwxtk9GjTQelibie/4zM=;
        b=0CLdsAvYq7K1F2R7J2880R8QYKsroaVfwU2uxZJFP2K96YhxEG0VstwrN6ghzELaOs
         fyQFM/8PC/cLF7xBiS19Hva0kMGzVo38cAgKpflyOBYaLLALA/ji3tudkxkC0AUQDJ7k
         0oX6bU9MRG9rVEXSQX/IG2P2CErC191fluXi833/fIhxNq6/byvgeho7JgMm6Wal3aWx
         5fwVkdVbl6GtPvsYN9nVNXFqwhz6Z23YMfEriKv368ODxFJI0ZZyj/f2pD4N4KLgWKO4
         885mjBVOTgrd7CfJzrWA28SHYTE/d1UtnBbnPr3ZMBLiW5IL6E1MY84oRF2J3FxBzU1M
         LxXA==
X-Gm-Message-State: AJIora8PCxTFOfL9jtOVF5fZJDy4qJjDRiqKvLi9KgRay7VCBMyUrB8S
        uWNDjenY+S05hiDNSinM8U/mEeP9AKnzJkxE7dLmAY9lKgmfrA==
X-Google-Smtp-Source: AGRyM1vNCanR04mkdU/CyNmnMZ/PEFaIaWjh4zKZ4+w/kdqTvRXyLe/zklUDyFBiLLz+oK4E54cVuf8ch2Gt75bzwC8=
X-Received: by 2002:a5b:ad0:0:b0:670:81c5:1b52 with SMTP id
 a16-20020a5b0ad0000000b0067081c51b52mr709346ybr.20.1658507548664; Fri, 22 Jul
 2022 09:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net> <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
 <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net> <20220721075309.l6uusnyk7xjkqd4g@pengutronix.de>
 <CAMZ6RqJTZ4o3dsaYG2s9boJ4By7QC55-N+0RszT9LNxRp3bYuA@mail.gmail.com>
 <ea8ffea6-1065-8526-4774-16d088ec7bf1@hartkopp.net> <CAMZ6Rq+NWFc4KmhCCpJ2LzTt8ap1U_FLrQ1L1RQgYNT0BD3w_Q@mail.gmail.com>
 <20220722072731.s3s7bkfn33zzzeni@pengutronix.de> <CAMZ6RqJcUtSyYbYnqAE87hrwL1G+cxGLKAZ_E4kvSW3Mq43tYg@mail.gmail.com>
 <20220722095853.jb3ko4qsktud5uob@pengutronix.de> <CAMZ6Rq+GZTifSLqO6V_wErtx5U932cnTO2ktMSjnq_ybPCx91Q@mail.gmail.com>
 <0046f0e1-0bd4-0add-7759-ed459fd050fb@hartkopp.net>
In-Reply-To: <0046f0e1-0bd4-0add-7759-ed459fd050fb@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sat, 23 Jul 2022 01:32:17 +0900
Message-ID: <CAMZ6RqKn7W26LwaJmdJ-1cpF7bZScHEcUiscLjtGNbAd=1_OeA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat. 23 Jul. 2022 at 00:30, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 22.07.22 12:54, Vincent Mailhol wrote:
> > On Fri. 22 Jul. 2022 at 18:58, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> >> On 22.07.2022 17:33:08, Vincent Mailhol wrote:
> >>> On Fri. 22 Jul. 2022 at 16:27, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> >>>> On 22.07.2022 12:20:43, Vincent Mailhol wrote:
> >>>>> I do not buy your argument that you can not do sizeof(struct
> >>>>> canxl_frame) because of naming.
> >>>>>
> >>>>> With a flexible array member, I can do:
> >>>>>
> >>>>> struct canxl_frame {
> >>>>>           canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> >>>>>           __u8    flags; /* additional flags for CAN XL */
> >>>>>           __u8    sdt;   /* SDU (service data unit) type */
> >>>>>           __u16   len;   /* frame payload length in byte */
> >>>>>           __u32   af;    /* acceptance field */
> >>>>>           __u8    data[];
> >>>>> };
> >>>>>
> >>>>> void foo (int s)
> >>>>> {
> >>>>>           struct canxl_frame cxl_hdr = { 0 };
> >>>>>           struct canxl_frame *cxl1, *cxl2;
> >>>>>           size_t cxl2_data_len, cxl2_frame_len;
> >>>>>
> >>>>>           /* read header */
> >>>>>           assert(read(s, &cxl_hdr, sizeof(cxl_hdr)) == sizeof(cxl_hdr));
> >>>>>           cxl1 = malloc(sizeof(*cxl1) + cxl_hdr.len);
> >>>>>           memcpy(cxl1, &cxl_hdr, sizeof(cxl_hdr));
> >>>>>           /* read remaining data */
> >>>>>           assert(read(s, cxl1->data, cxl1->len) == cxl1->len);
> >>>>
> >>>> For performance reasons you probable don't want to split the read of a
> >>>> single CAN frame over 2 read() syscalls.
>
> Yes, two read() syscalls (with testing/asserting for the right size),
> one malloc() syscall, one memcpy().
>
> Alternatively I can offer ONE syscall with ONE single copy operation
> from kernel to userspace \o/
>
> read(s, &can.xl, sizeof(struct canxl_frame));

You just ignored what I wrote just below:
| I wrote the code to illustrate how to do header
| manipulations. The goal of this example was not to be optimal
| but to show off how sizeof(struct canxl_frame) could be used.

I was answering your "This is no sizeof(struct canxl_frame) anymore" comment.

You can do:
| struct canxl_frame *cxl = malloc(CANXL_MTU);
| read(s, cxl, CANXL_MTU);

In fact, the sizeof() will be mostly useful in the tx path when doing
write(), not in the rx when you will likely always provide a buffer of
maximum size. Now I regret sending my example.

> The more I read about splitting/peeking/testing, calculating of sizes,
> etc the more I like the simple struct canxl_frame with 2048 bytes of
> data that is specified to be truncated by definition.
>
> E.g. for candump or other usual CAN applications you can run with *one*
> static struct without any malloc(). This is not only a bridge for
> application programmers that have experiences in programming SocketCAN
> applications - it is just a safe and simple pattern that I would not
> like to give up for which improvement?

The possibility to do static declaration is the strongest argument in
your favor.

There is no easy way to do this with flexible array member aside maybe
of the convoluted:
| char buf[CANXL_MTU];
| struct canxl_frame *cxl = &(struct canxl_frame)buf;

But I do not see the problem of using dynamic memory. For a 2
kilobytes buffer, dynamic memory looks pretty standard to me. And one
more time, is there any precedent in the kernel uapi of not using
flexible array members for structures meant to hold more than one
kilobyte? For the tiny CAN(-FD) it made sense, the same argument does
not translate so easily when going from ~64B to ~2KB.

My main point is that your approach does not follow what I could
witness so far in the UAPI. You have not yet answered this point.

> In fact I don't know any SocketCAN application that uses malloc for CAN
> frames which likely introduces lags and affects the performance.

This argument is invalid. You can malloc() once at the beginning of
the program and reuse it for the entire lifetime (please forget my
previous code snippet which was not meant to be performant).
There is no way that a single malloc can introduce noticeable lags
compared to a static allocation.

> >>>
> >>> ACK. I wrote the code to illustrate how to do header manipulations.
> >>> The goal of this example was not to be optimal but to show off how
> >>> sizeof(struct canxl_frame) could be used. Sorry if the example was not
> >>> natural and a bit too forced.
> >>>
> >>>> Also the CAN_RAW doesn't
> >>>> support "split"-read now, but could be extended.
> >>>
> >>> Interesting! I naively thought that split read() was handled at a
> >>> higher level of the socket API. I did not know that it was per
> >>> protocol.
> >>
> >> The CAN_RAW protocol implements raw_recvmsg():
> >>
> >> | https://elixir.bootlin.com/linux/latest/source/net/can/raw.c#L843
> >>
> >>> It could make sense to allow such split read() for CANXL.
> >>
> >> Then we have to track the number of already read bytes inside the
> >> socket. The POSIX API offers some interesting flags to recvmsg(). With
> >> MSG_PEEK you can read but not remove the read data from the queue and/or
> >> MSG_TRUNC to get the total size of the CAN frame.
> >>
> >> I have not tested these flags, but I think support for them has to be
> >> implemented in CAN_RAW, too.
> >>
> >> Also, we should have a look at the UDP code.
> >
> > Here it is:
> > https://elixir.bootlin.com/linux/latest/source/net/ipv4/udp.c#L1846
> >
> > The relevant function is sk_peek_offset:
> > https://elixir.bootlin.com/linux/latest/source/include/net/sock.h#L617
> >
> > And to finish, there is an nearly eponym field in struct sock: sk_peek_off
> > https://elixir.bootlin.com/linux/latest/source/include/net/sock.h#L457
> >
> >>> One example
> >>> I can directly think of is the Packet API. Correct me if I am wrong
> >>> but if writing generic code to dump packets on any interfaces, you do
> >>> not know in advance the MTU. And so, I guess you have to provide a
> >>> buffer of an arbitrary size. A generic program using a buffer of, let
> >>> say, 2048 bytes (one page) will not be enough to get a CANXL frame in
> >>> one single shot.
> >>
> >> Nitpick: the page size is arch and/or kernel config dependent and the
> >> smallest page size that Linux supports is 4k.
> >
> > Arg, I did not have enough sleep.
> >
> > By the way, do you have a preference between the flexible array member
> > and the data[CANXL_MAX_DLEN]? So far, I have been pushing the idea of
> > the flexible array member but if I am the only one to support this
> > idea, we can call it a day and use the data[CANXL_MAX_DLEN] approach.
> >
> >
> > Yours sincerely,
> > Vincent Mailhol
