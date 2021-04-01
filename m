Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E279135116D
	for <lists+linux-can@lfdr.de>; Thu,  1 Apr 2021 11:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhDAJFC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Apr 2021 05:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbhDAJEh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Apr 2021 05:04:37 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2FBC0613E6
        for <linux-can@vger.kernel.org>; Thu,  1 Apr 2021 02:04:37 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id a143so1039564ybg.7
        for <linux-can@vger.kernel.org>; Thu, 01 Apr 2021 02:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0F6+eMF+kuq5hQz9pa+aehaK0LlUU7GBN/azxzxKDU=;
        b=CxZ8gfXrNu58YhpvJDYDpcqKCCOyZhytIuJI+PBgySEgc47qknVKrpPoBFKEvO37jV
         FEeFnMq7cpYJ8yGzhG7rHWlmSvhWugn7ndy99+f7mcVb1ICpWog+u3BRa4MZI+uz37i6
         8xicesvykKvh1xtr5wAatLCFaYSe+N5QtVROAbYD6h3JSRmeAyvMSeRaIvAYrrLX09ru
         plCkGSIwfJ455vX6p2tao1c2DDNIQLPMp3RNcAI3CDt/i+HbcKWKBBWo62HM191T+3YH
         yFnq+FmzHHwpVxObruQw5sahQUx0HRR4ysW4fQ45xf99jdsB01+f++20e2jQy6WlmLyT
         jYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0F6+eMF+kuq5hQz9pa+aehaK0LlUU7GBN/azxzxKDU=;
        b=EpVe6QUdIaedyauPwsswIlC7YTIySc+5sMCaCcl9A+iH8men2+GJ1+VXuPiTPUaWSc
         P/Oa2EEvMGatOl1KRqfi3XSUKu9Jn7ePSqmaj9CMu7lvje6r39mrEwJodjCdXq3ZAamM
         0JKqopP9/Q8Ue1BRu/ezEOpojlF3lPGWmcixVCs0zGAC/mkb8RGxIHFdTEBBtu41Omnd
         6eQUlNX9G99ea7SKjY8Ti8yDsXDk8Fqr84NGBiEzKj+rMCae0mwNEJgie68mMrw2zIdL
         dywmy+oWme6Mw2r67yUb+b3YqdGHLz4bDcKPsa0LjQboumR0eH7hX92R88tEjzytZTov
         BffQ==
X-Gm-Message-State: AOAM530CQiTCA7mRHF6U6d5/D5Ychc2OIErITVQiSQE3k4Bn6lvGG1rN
        q84f/pJ+DLdh0P1KdKbkwhe4cFhA/Xkm105zV5lpHBVT4rQNEHjH
X-Google-Smtp-Source: ABdhPJw08H0PaNOA0OLP2rpVX87et24aLige+63PDHugTCzhrD5kPMYK/VVBsNF9/DrkqHqqWxJJZHb1E6PlSMHR/9A=
X-Received: by 2002:a25:ae8c:: with SMTP id b12mr10252162ybj.173.1617267876492;
 Thu, 01 Apr 2021 02:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAAfyv37vMxhN2B1uR5xUzZwVzAqrQOyPA6stWYj_5346xO0s3A@mail.gmail.com>
 <20210331083744.pui7rtjexvejjvf6@pengutronix.de>
In-Reply-To: <20210331083744.pui7rtjexvejjvf6@pengutronix.de>
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Thu, 1 Apr 2021 11:04:25 +0200
Message-ID: <CAAfyv35tCPxf0KSOk3=mcq6j2yB0DLUrN3AJ6sJtreZmTYZdGQ@mail.gmail.com>
Subject: Re: m_can error/overrun frames on high speed
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,
On Wed, Mar 31, 2021 at 10:37 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 28.03.2021 08:31:14, Belisko Marek wrote:
> > I have a beaglebone based board and I'm performing some tests.
>
> As far as I know the beagle bone boards all have d_can controllers, not
> m_can.
Yes sorry it was typo.
>
> > I discovered that when set bitrate to 500k during replaying can file
> > from PC to board ip detect 4-5 error/overrun frames. When comparing
> > the original file with received one few lines in candump are missing.
> > When decreased can speed to 125KB replaying the same file no
> > error/overruns are detected and files are the same. I'm not can expert
> > thus I'm asking for some advice on how to debug such phenomena. I'm
> > using mainline 4.12 kernel which shows this symptom. I compared
> > changes with the latest mainline kernel and there are few patches only
> > which seems can influence can behavior (others are only cosmetical). I
> > took :
> >
> > 3cb3eaac52c0f145d895f4b6c22834d5f02b8569 - can: c_can: c_can_poll():
> > only read status register after status IRQ
> > 23c5a9488f076bab336177cd1d1a366bd8ddf087 - can: c_can: D_CAN:
> > c_can_chip_config(): perform a sofware reset on open
> > 6f12001ad5e79d0a0b08c599731d45c34cafd376 - can: c_can: C_CAN: add bus
> > recovery events
> >
> > I know most of the answers for such issues is to try latest kernel
> > (i'm in process trying 5.10).
>
> That's going into the right direction. Please try the lastest
> net-next/master, which includes this merge:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=9c0ee085c49c11381dcbd609ea85e902eab88a92
I tried to build this kernel and when run on my target and run on
other side cangen can0 -g0 (at 500kb bitrate) after some time I see on
receiving side:
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP
mode DEFAULT group default qlen 10
    link/can  promiscuity 0
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
          bitrate 500000 sample-point 0.875
          tq 125 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
          c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
          clock 24000000
          re-started bus-errors arbit-lost error-warn error-pass bus-off
          0          0          0          0          0          0
    numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
    RX: bytes  packets  errors  dropped overrun mcast
    6300263    999976   4       0       4       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0

errors/overrun frames. My theory is that before napi handling of
received data we disable interrupts and when we process received
messages and re-enable irq again we can see overrun because reading of
data can be slow.
Is there anything I can tune to have it read faster? Thanks.
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

BR,

marek
