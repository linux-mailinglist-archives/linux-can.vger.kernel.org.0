Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B18572A9A
	for <lists+linux-can@lfdr.de>; Wed, 13 Jul 2022 03:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiGMBHs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 21:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiGMBHr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 21:07:47 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DBBC74A5
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 18:07:45 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31c8a1e9e33so98389717b3.5
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCtG+EeTUSr5LOECfEw9sr1s8DRBm9oDgeILAWoYp1Q=;
        b=N5JGZU1S9DAxvv/lamBanOPuKDfXqV0nI12A8n616Gc/oq2L5TzYUn6oQ1JQ49E/W3
         BbIxQsgfmeRzBxpkJjRVAMWl5NRG9PnxCqirD3TS0i3iIexZ1rAmBpPp3OZZvD3kYZ7v
         2fvPEdppVDvJPDTyvOowrVJ7uP8dWyEbMpoYFQdGyt+6qYoHz4ZIWUiywvnkb8ST8S1T
         Phs+n+CHU8LYLXIQ/CWsEnUhDU0s8k0v3aB4dxoI0bSDou/kVy1r8xjdu7qTrmS1ClHZ
         jn8QuTrvVddyfaI9RW2kKhFNIrmj22HaeH5OOnYHhz2epc7eokX2hZiXtJos547ZkMCD
         HuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCtG+EeTUSr5LOECfEw9sr1s8DRBm9oDgeILAWoYp1Q=;
        b=uqJRqWPx+YWEKvdQK//IbASwPegPSqRFwLFpPxXkAj1GCVq0e2UGNTypTmXhqDK8XM
         zgEQz2KUhpXtMj662ilF3E0rMae8hS/WKBeh89mhFnjN+SGMW5bCkeeZxJZyycOGo6Qw
         SjZEfaWTl8hyEg/M1agp+q/HCCgMfK+Z6X9fGfpGntQacZ8zPyFL3MA1rf9hZ8tmKlZd
         XSYSKIm13m0sU4+JaE9OddseJiGT8V0ObtYreWezOe8DJVfpLe/e+InZ0wG8U0U+he2O
         S59/EdgbwLe97V8R3kQAuVeOGfeF7qh/H4mLkgC05Uv3h58Ktb7UG0sJITFsTCuAB4IL
         ac2g==
X-Gm-Message-State: AJIora/VTVDhQUkptzxOhO8zA7MffaNLtUs3XP6dRM6xFviIbdM34t7g
        EoXQEqiX/yapPSeWRou5U7m+p6V7yn7A2PNDxG7duA9XPY8JNQ==
X-Google-Smtp-Source: AGRyM1vCZ9qCwgzjh07my3KKsZ+WKqJ/Wh75bGj00SDAABr877G2Glhg2izhHDAVeFoLTZJYgw3zn0GsBBN7DwHCbo4=
X-Received: by 2002:a0d:f247:0:b0:31d:68b1:5a16 with SMTP id
 b68-20020a0df247000000b0031d68b15a16mr1339696ywf.191.1657674464976; Tue, 12
 Jul 2022 18:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-2-socketcan@hartkopp.net> <CAMZ6RqLqDFqdtKsp6jGhnTtWRrf6HC5HiLuJUSCRNkDXqVfCzA@mail.gmail.com>
 <f00a4c5d-c4e6-06a2-76c0-53105d3465f2@hartkopp.net> <CAMZ6RqLVvYCoBF67VtqUSJHAxBHvEmK2-o8NCD7REZj1ywXf7w@mail.gmail.com>
 <521fe0a3-a9ad-60ac-3ec6-30f0da228032@hartkopp.net> <CAMZ6RqJhjkVgZgmfk7btYK+bLtqnbvGBYTnssy28ZWqyfyqppw@mail.gmail.com>
 <89f90d61-35a4-59a2-231b-4372d4dca25c@hartkopp.net> <CAMZ6Rq+LqfUhLcg6909=239a+Asm6aO-bPqpar2tQ_fs0EmiUQ@mail.gmail.com>
 <b866e05b-a548-132c-4427-7a4d21d12172@hartkopp.net>
In-Reply-To: <b866e05b-a548-132c-4427-7a4d21d12172@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 13 Jul 2022 10:07:57 +0900
Message-ID: <CAMZ6RqLGWB-afDmZfV+qJU2g=XUycFS1o9j6EwqRVg_dyf4eOw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] can: canxl: introduce CAN XL data structure
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 13 Jul. 2022 at 04:24, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 12.07.22 16:31, Vincent Mailhol wrote:
> > On Tue. 12 Jul. 2022 at 21:30, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >> On 12.07.22 12:19, Vincent Mailhol wrote:
> >>> On Tue. 12 Jul. 2022 at 18:31, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >>
> >>>>>> +/* truncated CAN XL structs must contain at least 64 data bytes */
> >>>>>> +#define CANXL_MINTU    (CANXL_MTU - CANXL_MAX_DLEN + CANFD_MAX_DLEN)
> >>>>>
> >>>>> I did not get the concept of the "truncated CAN XL structs". The valid
> >>>>> data field lengths are 1 to 2048, right? I did not get where this 64
> >>>>> comes from.
> >>>>> Your formula is equivalent to
> >>>>> #define CANXL_MINTU    (sizeof(struct canxl_frame) + CANFD_MAX_DLEN)
> >>>>
> >>>> No. CANXL_MINTU becomes sizeof(struct canfd_frame) + sizeof(af)
> >>>>
> >>>> So I wanted some size value that is 'more than' CANFD_MTU so that you
> >>>> know that you have read a CANXL frame.
> >>>>
> >>>> Even if the cxf->len would be 14 you would at least copy a struct
> >>>> canxl_frame with data[64].
> >>>
> >>> OK, I finally got your point. Your concern is that if skb->len could
> >>> be equal or less than CANFD_MTU, then there would be a collision.
> >>>
> >>> My approach here would be to stop using the MTU correlation to
> >>> differentiate between CAN(-FD) and CANXL. Instead, I suggest using
> >>> can{fd,xl}_frame::flags. If can{fd,xl}_frame has a CANXL flag set,
> >>> then it is a CANXL frame regardless of the value of skb->len. If the
> >>> CANXL flag is not set, then skb->len is used to differentiate between
> >>> Classic CAN and CAN FD (so that we remain compatible with the
> >>> existing). That way, no need to impose a minimum length of
> >>> CANFD_MAX_DLEN.
> >>
> >> Hm, that sounds interesting! I like that as it looks clear and simple.
> >>
> >> Need to pick a coffee
> >
> > Two years ago, it was a beer:
> > https://lore.kernel.org/linux-can/a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net/
> >
> > Now it is coffee. Seems that you change your drinking habits (just kidding) ;-)
>
> That depends on the daytime ;-)
>
> In Germany there's a saying:
> "Kein Bier vor vier!"
> (no beer before 4pm)
>
> But a friend of my dad has a clock in his garage with only '4's on the
> watchface to make this test always return true :-D

He, he, he! I had an argument with a German friend a long time ago. We
concluded that I was always past 4 p.m. somewhere in the world. This
works especially great for imported beers which you can drink at the
foreign timezone (to pay homage of course!)

> >> to think about potential (security) effects ... ;-)
> >
> > If we require a socket option as you already did (c.f.
> > CAN_RAW_XL_FRAMES), I do not see a security risk.
> >
> > If not using the socket option, then a user who activates CAN_XL at
> > the netlink level and who runs a legacy application in which struct
> > can_frame is declared on the stack and not initialised would be at
> > risk. can_frame::__pad could contain garbage data which could be
> > interpreted as a valid CAN_XL flag. From that point, the garbage
> > values in can_frame::__res0 and can_frame::len8_dlc would be
> > interpreted as an CANXL length.
> >
> > The only requirement is that all applications which will use a mix of
> > CANXL and non-CANXL frames shall make sure that no garbage values are
> > present in can_frame::__pad or canfd_frame::flags. Coding guidelines
> > such as MISRA and good static analyzers should also be able to catch
> > this.
>
> Yes. This was exactly my concern. But we can not assume that user space
> application is friendly or follows any MISRA guidelines.

Well, if we document than can_frame::__pad shall be zero for mix
usages (i.e. comments in struct can_frame and updated kernel doc),
then we would have done our due diligence. From that point, if people
ignore the documentation *and* do not follow best practices for safety
application development, I wouldn't cry.

If we absolutely want to prevent struct can_frame to be interpreted as
a canxl_frame due to some stack garbage, we can add one
padding/reserved field like that:

struct canxl_frame {
        canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
        __u8    sdt;   /* SDU (service data unit) type */
        __u8    flags; /* additional flags for CAN XL */
        __u16   len;   /* frame payload length in byte */
        __u32   af;    /* acceptance field */
        __u32 __res; /* reserved field. Shall be zero */
        __u8    data[] __attribute__((aligned(8)));
};

This way, the minimum transfer unit of CANXL is 17 bytes (16 for
header and 1 for data) which is exactly one byte more than can_frame
(and we get back the 8 bytes alignment \o/)

This would only leave the risk of having some garbage in
canfd_frame::flags, e.g. if user does:

        struct canfd_frame cfd; /* declared on the stack and not initialized */
        cfd.flags |= <some_flags> /* use |= instead of = */

But this is already risky for plain CAN-FD.

> Following your flexible length with CANXL_XLF idea you may forge a CAN
> XL frame inside a Classical CAN frame. But then we simply need to treat
> it as CAN XL frame any apply the other sanity checks.
>
> >> E.g. we would need to keep skb->len and canxl_frame::len in sync now.
> >
> > Not necessarily. The only strong condition is that:
> >      skb_buff::len + sizeof(struct canxl_frame) < canxl_frame::len
> >
> > If it is equal, then perfect, we are optimal. If greater, it just
> > means that there is some garbage data. If the condition is not met, we
> > just drop the skb of course.
> >
> > Technically, we could remove canxl_frame::len and use below formula to
> > derive the data length:
> >      len = skb_buff::len - sizeof(struct canxl_frame)
> >
> > In that case, the user must do all the length calculations correctly.
> > This would be close to how TCP/IP frames are managed. But personally,
> > I do not recommend removing canxl_frame::len.
> >
> > Having both skb_buff::len and canxl_frame::len in sync is a design
> > choice, not a necessity. I am still thinking of the implications and
> > what is best between allowing garbage or forcing the two lengths to be
> > in sync.
>
> Ok.
>
> (..)
>
> >> I still would suggest to have the struct canxl_frame contain the 2048
> >> byte of data (data[CANXL_MAXDLEN]) - as the entire CAN XL frame is
> >> defined like this in the CAN XL spec. This would be also in common with
> >> CAN/CANFD.
> >>
> >> E.g. when reading into the struct canxl_frame you always have a defined
> >> data structure which can contain a complete CAN XL frame.
> >
> > If we go this way, then I would allow the user to put garbage (i.e.
> > not having the two lengths in sync).
> > The rationale would be that we actually already allow such garbage
> > values for CAN and CAN-FD. Also, this way, the user who has zero clues
> > about the flexible array member property would simply do:
> >
> >     struct canxl_frame cxl = { 0 };
> >      /* ... */
>
> (len and CANXL_XLF would have needed to be set here)
ACK.
> >      write(socket, &cxl, sizeof(cxl));
> >
> > and it would work.
>
> Yes.
>
>
> > The advanced user who understand what is going on
> > can still do:
> >
> >     struct canxl_frame cxl = { 0 };
> >      /* ... */
> >      write(socket, &cxl, CANXL_HEAD_SZ + cxl.len);
> >
>
> ACK. I think this is feasible and easy to understand.
>
> >> But if you get or send less than that size (when reading/writing) this
> >> would be ok now (with your idea with CANXL_XLF set).
> >>
> >>
> >> E.g.
> >>
> >> #define CANXL_MINDLEN 1
> >> #define CANXL_MAXDLEN 2048
> >
> > To be consistent with CAN_DLEN and CANFD_DLEN names:
> > #define CANXL_DLEN 2048
>
> You are right about the inconsistency. But it needs to be
>
> #define CANXL_MIN_DLEN 1
> #define CANXL_MAX_DLEN 2048
>
> to fit the CAN/CANFD definitions.

ACK.

> >> #define CANXL_MTU sizeof(struct canxl_frame)
> >> #define CANXL_HEAD_SZ (CANXL_MTU - CANXL_MAXDLEN)
> >> #define CANXL_MINTU (CANXL_HEAD_SZ + CANXL_MINDLEN)
> >
> > I need to think twice about all that, all the different alternatives
> > (allow or not garbage, data as flexible member array vs.
> > data[CANXL_DLEN]). Now it is a bit late, so I will continue to think
> > about all that tomorrow.
>
> I would suggest to not allow garbage and have skbuff::len and
> canxl_frame::len in sync.
>
> When a userspace application writes more bytes than needed by
> canxl_frame::len, then that garbage is cropped to the needed size.

Cropped by whom? My point is to allow userspace to leave garbage. I am
totally OK with cropping the frames as soon as they enter the kernel.
On the other hand, the kernel shall always return cropped frames to
the userland. To summarize, skb and data len synchronisation is
optional for userland but mandatory for kernel drivers.

> When less data is provided than required by canxl_frame::len this could
> lead to an error.
>
> > But overall, I like the direction this thread is taking ;-)
>
> Yep!
>
> (..)

Yours sincerely,
Vincent Mailhol
