Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E54457EB91
	for <lists+linux-can@lfdr.de>; Sat, 23 Jul 2022 04:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiGWCkN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 22 Jul 2022 22:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiGWCkM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Jul 2022 22:40:12 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6CD6441
        for <linux-can@vger.kernel.org>; Fri, 22 Jul 2022 19:40:09 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id r3so10947350ybr.6
        for <linux-can@vger.kernel.org>; Fri, 22 Jul 2022 19:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qgZq5lFMVfobJWUiaiodOgXBZRDzkzAOMNX8PVp+R90=;
        b=JINqlR4jE9MX1AD2rFhuDipbLWYZkYC2fGn+M9R7pxiZO+sl7sH4R0Au2jPir7DgBV
         McFThPslPmWaZdW08dTwzTmQpiqGeb1napTr1x0aZATqA8o/5pP7NuAm2GbE7SncrWAs
         AhG9Q4uQMRwP8rw5zWwB1O0OkR6Hq8WdVgnp9XOS/M7JLHF0BvD5hbTaQHhBYhbY/0Ba
         Epwbi0jVEAJIE5Ezp32XpmZ/PjLsPPPYSEHAK8N2tHP536FO6PeVgFBPIMBOzuvhXlUh
         V0NNlrCFfuVLDlDKXFIhDCs5uVZUq6oXKuc7rjmgIwtNyg4Hz+p1+sSBgxZZvZ6+/+0k
         6agQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qgZq5lFMVfobJWUiaiodOgXBZRDzkzAOMNX8PVp+R90=;
        b=2Oz+Q83UeWrXMju6ldDwN4gJV4p0pUe7fGEhBG5WQLCAmyuJYfmtMlw7GgMNwv147T
         TBufZEiC5UOMBUivF+OOtTNAuEn6v+xBjKE923ufYAU9yodBmC0IgS0EsREBgwMpR9Xf
         fMDSriC6wtI/5WisMs0n0pOIuFd58Ow5QGRfDbKrusDgSxYu3jaAwkq4RupcXlTsL0P1
         EM5mrd6UtKuEXET/GJ1IxJdrMTe/Y92tBEo3I3hD2q9cFTo5bg7YjG4qWM4F2prwaTON
         IfwseiqvVHnoGCBrb1LA0rzg0eNzg+8OpzSaaBIfFpm/pbVr+WEZkjRzY/VRu3U6DxBz
         n7uQ==
X-Gm-Message-State: AJIora+7yxjgUP1fyfFiIeVKdmh/FqlRMM5QHZfP5F5fg0g76RIfaYHF
        q8DXUatdncSvxMAxyn7GOgtuCl3ZsW/qPcv979cpWoYsqlA=
X-Google-Smtp-Source: AGRyM1uTARRMZ7lmMpdWbThGcO/KfxSfQ0obPAy45P1v7Pi26qrJcBjxH7cZvLp6f3Kbae18iV3n9cpjhfmJ/bqaNd8=
X-Received: by 2002:a25:946:0:b0:670:ccc5:774a with SMTP id
 u6-20020a250946000000b00670ccc5774amr2210498ybm.381.1658544008612; Fri, 22
 Jul 2022 19:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net> <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
 <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net> <20220721075309.l6uusnyk7xjkqd4g@pengutronix.de>
 <CAMZ6RqJTZ4o3dsaYG2s9boJ4By7QC55-N+0RszT9LNxRp3bYuA@mail.gmail.com>
 <ea8ffea6-1065-8526-4774-16d088ec7bf1@hartkopp.net> <CAMZ6Rq+NWFc4KmhCCpJ2LzTt8ap1U_FLrQ1L1RQgYNT0BD3w_Q@mail.gmail.com>
 <20220722072731.s3s7bkfn33zzzeni@pengutronix.de> <CAMZ6RqJcUtSyYbYnqAE87hrwL1G+cxGLKAZ_E4kvSW3Mq43tYg@mail.gmail.com>
 <20220722095853.jb3ko4qsktud5uob@pengutronix.de> <CAMZ6Rq+GZTifSLqO6V_wErtx5U932cnTO2ktMSjnq_ybPCx91Q@mail.gmail.com>
 <0046f0e1-0bd4-0add-7759-ed459fd050fb@hartkopp.net> <CAMZ6RqKn7W26LwaJmdJ-1cpF7bZScHEcUiscLjtGNbAd=1_OeA@mail.gmail.com>
 <e4e74603-5db6-04bd-295e-2b20c96c39e7@hartkopp.net>
In-Reply-To: <e4e74603-5db6-04bd-295e-2b20c96c39e7@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sat, 23 Jul 2022 11:39:57 +0900
Message-ID: <CAMZ6RqLD-B87LN_1a2zhuPuPX1nENiDQQi+b34V9c-KP1gwtsg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 23 Jul. 2022 =C3=A0 03:52, Oliver Hartkopp <socketcan@hartkopp.net>=
 wrote:
> On 22.07.22 18:32, Vincent Mailhol wrote:
> > On Sat. 23 Jul. 2022 at 00:30, Oliver Hartkopp <socketcan@hartkopp.net>=
 wrote:
> >> On 22.07.22 12:54, Vincent Mailhol wrote:
> >>> On Fri. 22 Jul. 2022 at 18:58, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:
> >>>> On 22.07.2022 17:33:08, Vincent Mailhol wrote:
> >>>>> On Fri. 22 Jul. 2022 at 16:27, Marc Kleine-Budde <mkl@pengutronix.d=
e> wrote:
> >>>>>> On 22.07.2022 12:20:43, Vincent Mailhol wrote:
> >>>>>>> I do not buy your argument that you can not do sizeof(struct
> >>>>>>> canxl_frame) because of naming.
> >>>>>>>
> >>>>>>> With a flexible array member, I can do:
> >>>>>>>
> >>>>>>> struct canxl_frame {
> >>>>>>>            canid_t prio;  /* 11 bit priority for arbitration (can=
id_t) */
> >>>>>>>            __u8    flags; /* additional flags for CAN XL */
> >>>>>>>            __u8    sdt;   /* SDU (service data unit) type */
> >>>>>>>            __u16   len;   /* frame payload length in byte */
> >>>>>>>            __u32   af;    /* acceptance field */
> >>>>>>>            __u8    data[];
> >>>>>>> };
> >>>>>>>
> >>>>>>> void foo (int s)
> >>>>>>> {
> >>>>>>>            struct canxl_frame cxl_hdr =3D { 0 };
> >>>>>>>            struct canxl_frame *cxl1, *cxl2;
> >>>>>>>            size_t cxl2_data_len, cxl2_frame_len;
> >>>>>>>
> >>>>>>>            /* read header */
> >>>>>>>            assert(read(s, &cxl_hdr, sizeof(cxl_hdr)) =3D=3D sizeo=
f(cxl_hdr));
> >>>>>>>            cxl1 =3D malloc(sizeof(*cxl1) + cxl_hdr.len);
> >>>>>>>            memcpy(cxl1, &cxl_hdr, sizeof(cxl_hdr));
> >>>>>>>            /* read remaining data */
> >>>>>>>            assert(read(s, cxl1->data, cxl1->len) =3D=3D cxl1->len=
);
> >>>>>>
> >>>>>> For performance reasons you probable don't want to split the read =
of a
> >>>>>> single CAN frame over 2 read() syscalls.
> >>
> >> Yes, two read() syscalls (with testing/asserting for the right size),
> >> one malloc() syscall, one memcpy().
> >>
> >> Alternatively I can offer ONE syscall with ONE single copy operation
> >> from kernel to userspace \o/
> >>
> >> read(s, &can.xl, sizeof(struct canxl_frame));
> >
> > You just ignored what I wrote just below:
> > | I wrote the code to illustrate how to do header
> > | manipulations. The goal of this example was not to be optimal
> > | but to show off how sizeof(struct canxl_frame) could be used.
> >
> > I was answering your "This is no sizeof(struct canxl_frame) anymore" co=
mment.
> >
> > You can do:
> > | struct canxl_frame *cxl =3D malloc(CANXL_MTU);
> > | read(s, cxl, CANXL_MTU);
> >
> > In fact, the sizeof() will be mostly useful in the tx path when doing
> > write(), not in the rx when you will likely always provide a buffer of
> > maximum size. Now I regret sending my example.
> >
> >> The more I read about splitting/peeking/testing, calculating of sizes,
> >> etc the more I like the simple struct canxl_frame with 2048 bytes of
> >> data that is specified to be truncated by definition.
> >>
> >> E.g. for candump or other usual CAN applications you can run with *one=
*
> >> static struct without any malloc(). This is not only a bridge for
> >> application programmers that have experiences in programming SocketCAN
> >> applications - it is just a safe and simple pattern that I would not
> >> like to give up for which improvement?
> >
> > The possibility to do static declaration is the strongest argument in
> > your favor.
>
> Yes. And it is a good argument.
>
> > There is no easy way to do this with flexible array member aside maybe
> > of the convoluted:
> > | char buf[CANXL_MTU];
> > | struct canxl_frame *cxl =3D &(struct canxl_frame)buf;
> >
> > But I do not see the problem of using dynamic memory. For a 2
> > kilobytes buffer, dynamic memory looks pretty standard to me.
>
> I do see a problem with it and definitely have another personal
> preference. So far I did not need dynamic memory to process CAN content
> in CAN applications which is a good (and required) pattern for embedded
> automotive applications and allows to port concepts and code between
> these two worlds.

ACK that for safety application (as of ISO 26262) static declaration
are prefered (and nearly mandatory at ASIL C and D levels) but the
Linux kernel is not designed for safety.
If your kernel uses dynamic memory allocations, then your application
will not be safer (as of ISO 26262) with static declarations.

I do not believe it will be a problem when porting code from an
embedded application to Socket CAN. It is not the same structure, not
the same field names, not the same API so you have to rewrite the code
related to the declaration, initialization and the read()/write()
regardless. The only part which is portable is the processing of
canxl_frame::data and this part could be ported regardless if you use
dynamic or static memory application.

> > And one
> > more time, is there any precedent in the kernel uapi of not using
> > flexible array members for structures meant to hold more than one
> > kilobyte? For the tiny CAN(-FD) it made sense, the same argument does
> > not translate so easily when going from ~64B to ~2KB.
>
> Because of what?

Because of consistency.

> IMO it is a proper follow up of the current CAN_RAW API.
>
> > My main point is that your approach does not follow what I could
> > witness so far in the UAPI. You have not yet answered this point.
>
> There is an ioctl:
>
> https://manpages.debian.org/testing/manpages-de-dev/ioctl_list.2.de.html
>
> 0x4FA44308      SNDCTL_COPR_SENDMSG     const struct copr_msg *
> 0x8FA44309      SNDCTL_COPR_RCVMSG      struct copr_msg *
>
> include/uapi/linux/soundcard.h
>
> typedef struct copr_msg {
>                  int len;
>                  unsigned char data[4000];
>          } copr_msg;

OK. So the best example you found was introduced in Linux 1.x (around
end of 1995!) and already violates the Linux coding guidelines by
using typedef.
Ref: https://elixir.bootlin.com/linux/1.3.9/source/include/linux/soundcard.=
h#L638
Ref: https://www.kernel.org/doc/html/latest/process/coding-style.html#typed=
efs

So I guess you just found the exception that proves the rule.

> >> In fact I don't know any SocketCAN application that uses malloc for CA=
N
> >> frames which likely introduces lags and affects the performance.
> >
> > This argument is invalid. You can malloc() once at the beginning of
> > the program and reuse it for the entire lifetime (please forget my
> > previous code snippet which was not meant to be performant).
> > There is no way that a single malloc can introduce noticeable lags
> > compared to a static allocation.
>
> As described above omitting dynamic memory as a whole is a valid
> pattern. And so far no one needs dynamic memory or has to be encouraged
> to use it.
>
> With the API of truncated CAN XL frames you can do whatever you want
> (even make use of malloc()) on the user space side.
>
> I don't see any real argument to leave the established pattern.
>
> You probably might feel that I don't like dynamic arrays or have some
> problems of making use of it. This is not the case:
>
> include/uapi/linux/can/bcm.h
>
> struct bcm_msg_head {
>          __u32 opcode;
>          __u32 flags;
>          __u32 count;
>          struct bcm_timeval ival1, ival2;
>          canid_t can_id;
>          __u32 nframes;
>          struct can_frame frames[0];
> };
>
>
> Which leads to:
>
> linux-can/can-tests/bcm/tst-bcm-filter.c
>
> struct {
>          struct bcm_msg_head msg_head;
>          struct can_frame frame[4];
> } txmsg, rxmsg;
>
>
> txmsg.msg_head.opcode  =3D RX_SETUP;
> txmsg.msg_head.can_id  =3D 0x042;
> txmsg.msg_head.flags   =3D SETTIMER|RX_FILTER_ID;
> txmsg.msg_head.ival1.tv_sec =3D 1;
> txmsg.msg_head.ival1.tv_usec =3D 0;
> txmsg.msg_head.ival2.tv_sec =3D 0;
> txmsg.msg_head.ival2.tv_usec =3D 0;
> txmsg.msg_head.nframes =3D 0;
>
> But this is something different to me than having a struct canxl_frame
> without data - especially as it requires at least one data byte
> (CANXL_MIN_DLEN) to be a valid CAN XL frame.
>
> struct canxl_frame {
>          canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>          __u8    flags; /* additional flags for CAN XL */
>          __u8    sdt;   /* SDU (service data unit) type */
>          __u16   len;   /* frame payload length in byte */
>          __u32   af;    /* acceptance field */
>          __u8    data[CANXL_MIN_DLEN];
> };
>
> A truncated CAN XL frame structure with a data section that contains as
> much valid bytes as given in the len element is the exact representation
> of what you will see on the wire.
>
> For some reason you seem to stick on this (even invalid) "UAPI is using
> dynamic arrays" stuff instead of enhancing and improving the established
> handy and safe pattern for CAN frames.

Please define what you mean as "safe". SocketCAN is not safe by ISO
26262 standard. And in a non safety critical context, static memory
allocation is equally as safe as dynamic memory allocation (i.e. both
are not safe): if you have no memory left, an application, even if
using static declaration, will not start.

This debate is going to a dead end. I do not see one of us fully
convincing the other. As I stated before, the data[CANXL_MIN_DLEN] is
not bad and has the big merit of allowing static declaration. While my
preference definitely goes to the flexible array member, I will not
veto your idea. I think it was important to have this debate.
With that said, I leave the final decision to the mailing list. If
other people prefer the data[CANXL_MIN_DLEN] over the flexible array
member, or if no one other than the two of us care, then let's use
your approach!


Yours sincerely,
Vincent Mailhol
