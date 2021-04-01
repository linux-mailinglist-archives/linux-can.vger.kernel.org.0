Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8E035126A
	for <lists+linux-can@lfdr.de>; Thu,  1 Apr 2021 11:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhDAJhD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Apr 2021 05:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbhDAJgs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Apr 2021 05:36:48 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7D1C0613E6
        for <linux-can@vger.kernel.org>; Thu,  1 Apr 2021 02:36:48 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j198so1102205ybj.11
        for <linux-can@vger.kernel.org>; Thu, 01 Apr 2021 02:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Xz3Mh2cWKnCKZIV31A5c3WXpbx68f8SkyNLLHSMuHA=;
        b=KlTsRdRqzGE9EgRXqiSTNmYIHT4gf9k8uCvXriuWMXgKQwUra39ToekJlRU+W1OTPk
         DsJFdCfoZO0E7dPIStjlNQGcgBFwkTjSm5kjXFkSYU5J6N+bvDW+n+KdoNVbRUnIKRAA
         d+0MVNEwqYszYz0bXOW/vGTLYFcEvKv/3m5P5U7Om4Uh/DfT4hSCArj1YcjS2Ui29WD7
         pAsVayDaviXO4PRP/mblYe5OO64ZWKIoHv5buHrRfN7UZmNi4y+arbJ2nJOsTJ8O9AYr
         cjVNae4ZP8Vi+wUeiLh1CpEdWDGkYA5XnV37ngxHJHUMFWw7poWG637pHI7hAdpayErt
         CxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Xz3Mh2cWKnCKZIV31A5c3WXpbx68f8SkyNLLHSMuHA=;
        b=Oz1VdSTDmOcuxcPBO3bL93sYUvMgPJu0xC+Qebf8qdb49L43GBRbhACcF+N9DaNwtN
         a65wYDrON3qEZ6bCof3GaGm4pvJN8JfpCdD31HG1dRwC4oul/skZuR+EsaF8jaMmc31m
         bvco87x4VPahwJdNluValdIGtxbbSjYK3WoEqpBUeP0A6sqeObm5SV9GGDErt3ErphvB
         KrbhNANxMdKuHlAgeHq9h4+tNtQ5rk775XaoREgbgrP+8HSGGOoWR31dFIGcdhCmvluF
         6w8Grbg4VQpFGTg3nmcQdiL1ekAdACwwyIu1nN26H+EuGxVL4VWXOaqUM+sSHS/OiK+5
         BLzA==
X-Gm-Message-State: AOAM531rcXoFHyU3hvl+jg+SQpqub8ANW8oTbPoRJecel9pmRuXcSlc5
        kd83c3vOgs6OArTcgm+k+Q1br1LrF2EA8IVdOjQ=
X-Google-Smtp-Source: ABdhPJyapoH8+opQFWbD3de4NCVrr18BmoQnmAlVHiP4anRTRPUsu8KNtf5lsUMhplpb7ur18TzqQ543SxE4qM6u2Ns=
X-Received: by 2002:a25:b682:: with SMTP id s2mr9893725ybj.407.1617269807678;
 Thu, 01 Apr 2021 02:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAAfyv37vMxhN2B1uR5xUzZwVzAqrQOyPA6stWYj_5346xO0s3A@mail.gmail.com>
 <20210331083744.pui7rtjexvejjvf6@pengutronix.de> <CAAfyv35tCPxf0KSOk3=mcq6j2yB0DLUrN3AJ6sJtreZmTYZdGQ@mail.gmail.com>
 <20210401092352.usi3jngorhmpdrsd@pengutronix.de>
In-Reply-To: <20210401092352.usi3jngorhmpdrsd@pengutronix.de>
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Thu, 1 Apr 2021 11:36:36 +0200
Message-ID: <CAAfyv34uQKqMmvuUuHVTjLBY50tLcwg=rs+=4zGgPuDOS3kKCg@mail.gmail.com>
Subject: Re: m_can error/overrun frames on high speed
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi.

On Thu, Apr 1, 2021 at 11:23 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 01.04.2021 11:04:25, Belisko Marek wrote:
> > > As far as I know the beagle bone boards all have d_can controllers, not
> > > m_can.
> > Yes sorry it was typo.
>
> No problem, just wanted to be sure :)
>
> > > > I discovered that when set bitrate to 500k during replaying can file
> > > > from PC to board ip detect 4-5 error/overrun frames. When comparing
> > > > the original file with received one few lines in candump are missing.
> > > > When decreased can speed to 125KB replaying the same file no
> > > > error/overruns are detected and files are the same. I'm not can expert
> > > > thus I'm asking for some advice on how to debug such phenomena. I'm
> > > > using mainline 4.12 kernel which shows this symptom. I compared
> > > > changes with the latest mainline kernel and there are few patches only
> > > > which seems can influence can behavior (others are only cosmetical). I
> > > > took :
> > > >
> > > > 3cb3eaac52c0f145d895f4b6c22834d5f02b8569 - can: c_can: c_can_poll():
> > > > only read status register after status IRQ
> > > > 23c5a9488f076bab336177cd1d1a366bd8ddf087 - can: c_can: D_CAN:
> > > > c_can_chip_config(): perform a sofware reset on open
> > > > 6f12001ad5e79d0a0b08c599731d45c34cafd376 - can: c_can: C_CAN: add bus
> > > > recovery events
> > > >
> > > > I know most of the answers for such issues is to try latest kernel
> > > > (i'm in process trying 5.10).
> > >
> > > That's going into the right direction. Please try the lastest
> > > net-next/master, which includes this merge:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=9c0ee085c49c11381dcbd609ea85e902eab88a92
>
> > I tried to build this kernel and when run on my target and run on
> > other side cangen can0 -g0 (at 500kb bitrate) after some time I see on
> > receiving side:
>
> Does the current net-next lead to fewer lost frames than your original
> kernel? I mean does it make the situation better?
Nope the situation is more less same. I'm just curious as this code is
there for years and nobody complains about missing frames ;).
I tried 4.12 mainline, 4.19 TI-SDK kernel, latest stable 5.10 and
linux-net-next.
>
> > 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP
> > mode DEFAULT group default qlen 10
> >     link/can  promiscuity 0
> >     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
> >           bitrate 500000 sample-point 0.875
> >           tq 125 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
> >           c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
> >           clock 24000000
> >           re-started bus-errors arbit-lost error-warn error-pass bus-off
> >           0          0          0          0          0          0
> >     numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
> >     RX: bytes  packets  errors  dropped overrun mcast
> >     6300263    999976   4       0       4       0
> >     TX: bytes  packets  errors  dropped carrier collsns
> >     0          0        0       0       0       0
> >
> > errors/overrun frames. My theory is that before napi handling of
> > received data we disable interrupts and when we process received
> > messages and re-enable irq again we can see overrun because reading of
> > data can be slow.
>
> Yes, I assume the same problem.
>
> > Is there anything I can tune to have it read faster? Thanks.
>
> I don't think it can be done with tuning. To work around this problem,
> you can convert the c_can driver to the rx-offload infrastructure. You
> do the RX from the CAN HW in the IRQ handler, but pass it to the
> networking stack in NAPI. This dance is needed, as otherwise the
> networking stack messes up the order of received CAN frames.
OK thanks a lot for hint I'll investigate and report back.
>
> There even is an old branch that implemented that, but was never merged:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=c_can
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

BR,

marek
