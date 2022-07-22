Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AA457E051
	for <lists+linux-can@lfdr.de>; Fri, 22 Jul 2022 12:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiGVKyv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 22 Jul 2022 06:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiGVKyu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Jul 2022 06:54:50 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB5DBB5CE
        for <linux-can@vger.kernel.org>; Fri, 22 Jul 2022 03:54:49 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31e623a4ff4so43568687b3.4
        for <linux-can@vger.kernel.org>; Fri, 22 Jul 2022 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=83anTpvAcriCxl5eeShhwruDMWPSMYvFcBvP0pnITNE=;
        b=KLJUbrWZcI3vTBtasQgE5aNHPM+Rkoc6SLgeAFLcy1jNHdr9XT5zx2wMWx5EXWEUWP
         gW4MKRU5+Ukqf5xZBuIKd60gtKmcHGABwoWXzK2+hFq1jmppE05c79Wd5raOIsO4gWTb
         d8qbzWxHZ1g0wSG2lH7cxKNOk2rOr4Ov8bRXwFd8vkbchhcAXjT1Q/NfR3vzLAr1IQsT
         JKLMWfeD5N/GrnZVDdT0++PoUzumR0oodFd9zioJHMcuSMZjmquqcpiC/K8WyLK187sf
         fMFljAD8K0zalV6Kc36FeEBIbG2AAnRK8+H94w38DHTBvjLo5yFFiigaZkRBM4iE21IS
         r9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83anTpvAcriCxl5eeShhwruDMWPSMYvFcBvP0pnITNE=;
        b=bxb7SjSOu6a9HJ/FLqaCfX/Mk7FHs0faF5HjGJ34b654qNGR84K3DtxATpcnv/Ip3q
         6WsQL730RO5xQSKPSnFKwe5adfrC5rYkbriU7C1IFPUwIhc6bXwFJiVJTQSA/vnNDMVg
         oBBNxRJAAcS4UA4SkEdZDINSp/u3Ieu0QdkbYlSkfZufO2VdgH4H27eXr8U+Xq+48MdU
         i/cTmGB9PZoWZqbTdWDQDgRG6Z6pi91yVTtncRE/MX/anQ81O5tHcHXfWqj2X1btWbz/
         QVkgX61j8OzwsCYH7cN/guiXEARaPmmhZTkuovXh+Je+AmNjsbcd3HmoP3fUOaaJGhMl
         Pwwg==
X-Gm-Message-State: AJIora/egefObzTDU2/hWGgC7EXCIlNqhQvStmtXgekzLzjvrmkUaEli
        AcNAIsaaCVhICE0zWNpQYkZ5bETuYiZ+Kp0cPwurFBfah9GaKA==
X-Google-Smtp-Source: AGRyM1tobnr74VKhE7DQEiXsltCJbIoDFjRNBkp93xkBZ3ASN9IoIsPT2U7gGYxJJRNLWJktYYx8Dvi+KL56YkB0kK8=
X-Received: by 2002:a81:8349:0:b0:31e:732a:258a with SMTP id
 t70-20020a818349000000b0031e732a258amr2611795ywf.518.1658487288699; Fri, 22
 Jul 2022 03:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net> <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
 <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net> <20220721075309.l6uusnyk7xjkqd4g@pengutronix.de>
 <CAMZ6RqJTZ4o3dsaYG2s9boJ4By7QC55-N+0RszT9LNxRp3bYuA@mail.gmail.com>
 <ea8ffea6-1065-8526-4774-16d088ec7bf1@hartkopp.net> <CAMZ6Rq+NWFc4KmhCCpJ2LzTt8ap1U_FLrQ1L1RQgYNT0BD3w_Q@mail.gmail.com>
 <20220722072731.s3s7bkfn33zzzeni@pengutronix.de> <CAMZ6RqJcUtSyYbYnqAE87hrwL1G+cxGLKAZ_E4kvSW3Mq43tYg@mail.gmail.com>
 <20220722095853.jb3ko4qsktud5uob@pengutronix.de>
In-Reply-To: <20220722095853.jb3ko4qsktud5uob@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 22 Jul 2022 19:54:37 +0900
Message-ID: <CAMZ6Rq+GZTifSLqO6V_wErtx5U932cnTO2ktMSjnq_ybPCx91Q@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
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

On Fri. 22 Jul. 2022 at 18:58, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 22.07.2022 17:33:08, Vincent Mailhol wrote:
> > On Fri. 22 Jul. 2022 at 16:27, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > > On 22.07.2022 12:20:43, Vincent Mailhol wrote:
> > > > I do not buy your argument that you can not do sizeof(struct
> > > > canxl_frame) because of naming.
> > > >
> > > > With a flexible array member, I can do:
> > > >
> > > > struct canxl_frame {
> > > >          canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> > > >          __u8    flags; /* additional flags for CAN XL */
> > > >          __u8    sdt;   /* SDU (service data unit) type */
> > > >          __u16   len;   /* frame payload length in byte */
> > > >          __u32   af;    /* acceptance field */
> > > >          __u8    data[];
> > > > };
> > > >
> > > > void foo (int s)
> > > > {
> > > >          struct canxl_frame cxl_hdr = { 0 };
> > > >          struct canxl_frame *cxl1, *cxl2;
> > > >          size_t cxl2_data_len, cxl2_frame_len;
> > > >
> > > >          /* read header */
> > > >          assert(read(s, &cxl_hdr, sizeof(cxl_hdr)) == sizeof(cxl_hdr));
> > > >          cxl1 = malloc(sizeof(*cxl1) + cxl_hdr.len);
> > > >          memcpy(cxl1, &cxl_hdr, sizeof(cxl_hdr));
> > > >          /* read remaining data */
> > > >          assert(read(s, cxl1->data, cxl1->len) == cxl1->len);
> > >
> > > For performance reasons you probable don't want to split the read of a
> > > single CAN frame over 2 read() syscalls.
> >
> > ACK. I wrote the code to illustrate how to do header manipulations.
> > The goal of this example was not to be optimal but to show off how
> > sizeof(struct canxl_frame) could be used. Sorry if the example was not
> > natural and a bit too forced.
> >
> > > Also the CAN_RAW doesn't
> > > support "split"-read now, but could be extended.
> >
> > Interesting! I naively thought that split read() was handled at a
> > higher level of the socket API. I did not know that it was per
> > protocol.
>
> The CAN_RAW protocol implements raw_recvmsg():
>
> | https://elixir.bootlin.com/linux/latest/source/net/can/raw.c#L843
>
> > It could make sense to allow such split read() for CANXL.
>
> Then we have to track the number of already read bytes inside the
> socket. The POSIX API offers some interesting flags to recvmsg(). With
> MSG_PEEK you can read but not remove the read data from the queue and/or
> MSG_TRUNC to get the total size of the CAN frame.
>
> I have not tested these flags, but I think support for them has to be
> implemented in CAN_RAW, too.
>
> Also, we should have a look at the UDP code.

Here it is:
https://elixir.bootlin.com/linux/latest/source/net/ipv4/udp.c#L1846

The relevant function is sk_peek_offset:
https://elixir.bootlin.com/linux/latest/source/include/net/sock.h#L617

And to finish, there is an nearly eponym field in struct sock: sk_peek_off
https://elixir.bootlin.com/linux/latest/source/include/net/sock.h#L457

> > One example
> > I can directly think of is the Packet API. Correct me if I am wrong
> > but if writing generic code to dump packets on any interfaces, you do
> > not know in advance the MTU. And so, I guess you have to provide a
> > buffer of an arbitrary size. A generic program using a buffer of, let
> > say, 2048 bytes (one page) will not be enough to get a CANXL frame in
> > one single shot.
>
> Nitpick: the page size is arch and/or kernel config dependent and the
> smallest page size that Linux supports is 4k.

Arg, I did not have enough sleep.

By the way, do you have a preference between the flexible array member
and the data[CANXL_MAX_DLEN]? So far, I have been pushing the idea of
the flexible array member but if I am the only one to support this
idea, we can call it a day and use the data[CANXL_MAX_DLEN] approach.


Yours sincerely,
Vincent Mailhol
