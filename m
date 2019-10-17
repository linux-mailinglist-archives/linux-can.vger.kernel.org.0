Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCE7DB860
	for <lists+linux-can@lfdr.de>; Thu, 17 Oct 2019 22:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437240AbfJQUhT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Oct 2019 16:37:19 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:35790 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbfJQUhT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Oct 2019 16:37:19 -0400
Received: by mail-lf1-f51.google.com with SMTP id w6so2959119lfl.2
        for <linux-can@vger.kernel.org>; Thu, 17 Oct 2019 13:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q01z0QEcj5uA84wXlhZ28UVIZDz/MQ/iL4m0nkASTsc=;
        b=HWjs8FgyOT6RFj6ufPI8aGBD7hoWfJHA36S/hmwVcXyOkjOyiQ/INzygLHHfynOtV6
         KDJ2LO0xLYix/hvuz58G+dUZa4GAigv+FMr6Te5hzMXghGxNhiDbQwp54pLBZf3r4vzA
         HTQ5yWQ4V+F2i9k9dWkKiLF3ON4l0TC6oPK1w21F+ffF/+2EJqMw9VO+XUi5a6p5yRSU
         TnSKz2/MeBj6q7e4JqU+nYTFm065NxLymgV5BtF+S9fhw4d51B0xm37M5DO0Oa1/1vPn
         pRsBSKq0+xhs+8PHoBOKKnEJboKT6f3puneZ3UIuiBKdLhopfhlD/XAdpb0Yt23+cPB3
         b2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q01z0QEcj5uA84wXlhZ28UVIZDz/MQ/iL4m0nkASTsc=;
        b=J8+l7uozxt+FiOVMnagbCcobslYyNpEqEmh1ZrghJdeM//EMeyX0j2pCRs0QubyQNJ
         iNXnmnqqCC5HEDqyJ1yZW8VGSe/9cNEhKWuRqa0wPfmeHARcvRru0hcRtVb36gbg+zlf
         vb6zSb0teDq8PE4Q9HgTkCzdDyNYa2ubB5xpvyB9tT7sJQjUmAQ0xa+KLKp+HbcqWPtE
         pcF8H3j9qDnyyeX5J+tSn6m9qWLy/WLfLU7yB0t5h3+jhpq1gs80kx5tOrzDeeKHmzJq
         +JasgmUKrUFaZ0+1ywEq5LbdAHezQlWFA+ncSP6UhZ8c/GihDTP9rwBADn03Gc9Eq6ki
         /dIA==
X-Gm-Message-State: APjAAAWkG4Y0dsBPus9EFFEGkrm9EmN/UHdVmJnSkw7N+LpCZZeKb3WU
        bW0yyiMZaW8kf2Zow99nhQRVe00ehsp87+gopEU=
X-Google-Smtp-Source: APXvYqw5XmGg8GXL/C0aQ93qsrmlBysucOO9p7+ZDo1s9fCYAgtE+ZlFrwZ0gvK3r4Rc9PkfBEENw0PbtDjNHeJx+Hc=
X-Received: by 2002:a19:e018:: with SMTP id x24mr1774822lfg.191.1571344636254;
 Thu, 17 Oct 2019 13:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHChkrv6cKgNam-znKu_wOZm-y6gNkONmGWP6RFZpiSprq5_gQ@mail.gmail.com>
 <896bd824-1149-4229-a703-d2c946acd92b@pengutronix.de> <20191017074727.GA700@x1.vandijck-laurijssen.be>
 <CAHChkrsBMQy+=dQv-0JYqp7jrg3UvmQ_4JdR9WYrjAioNxfigw@mail.gmail.com>
In-Reply-To: <CAHChkrsBMQy+=dQv-0JYqp7jrg3UvmQ_4JdR9WYrjAioNxfigw@mail.gmail.com>
From:   Elenita Hinds <ecathinds@gmail.com>
Date:   Thu, 17 Oct 2019 15:37:04 -0500
Message-ID: <CAHChkrs8iH4+2ZiQUjaD7B9CcqjfbeRG-_3R2uT+FWGSr5kGPA@mail.gmail.com>
Subject: Re: c_can/d_can driver question
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I pulled in the c_can patches from the for-kurt branch (63574e9 thru
bf01f717) and tested on my device.
The number of overruns are noticeably fewer; however, the overall
system performance seems to have slowed down. For example,
the console response and Bluetooth data rate are noticeably slower.

I also noticed that while the number of overruns decreased, the number
of errors increased:
BEFORE:
# ip -details -statistics link show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
UNKNOWN mode DEFAULT group default qlen 1000
    link/can  promiscuity 435268
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
      bitrate 250000 sample-point 0.875
      tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
      c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
      clock 24000000
      re-started bus-errors arbit-lost error-warn error-pass bus-off
      0          0          0          3          3          0
numtxqueues 435300 gso_max_size 435364 gso_max_segs 435400
    RX: bytes  packets  errors  dropped overrun mcast
    3086416    385802   1246    0       1246    0
    TX: bytes  packets  errors  dropped carrier collsns
    20         5        0       0       0       0

AFTER (use rx_offload in IRQ handler):
# ip -details -statistics link show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
UNKNOWN mode DEFAULT group default qlen 1000
    link/can  promiscuity 435268
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
      bitrate 250000 sample-point 0.875
      tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
      c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
      clock 24000000
      re-started bus-errors arbit-lost error-warn error-pass bus-off
      0          0          0          3          3          0
numtxqueues 435300 gso_max_size 435364 gso_max_segs 435400
    RX: bytes  packets  errors  dropped overrun mcast
    6366640    795839   27906   0       39      0
    TX: bytes  packets  errors  dropped carrier collsns
    20         5        0       0       0       0

--elenita

On Thu, Oct 17, 2019 at 11:13 AM Elenita Hinds <ecathinds@gmail.com> wrote:
>
> Thanks, Marc and Kurt.
>
> >> Can you give me a pointer to this driver? Are you talking about the
> >> mainline linux-3.1?
>
> I sit corrected on this one. Further investigation indicates that this
> driver (authored by TI for AM335x)  was never submitted to mainline
> Linux 3.1.
> Here is the link to the driver:
> https://github.com/calixtosystems/linux-am335x/tree/master/linux-am33x/drivers/net/can/d_can.
>
> >> The algorithm that tries to read the CAN frames in the correct order was
> >> added in v3.15. That algorithm should be ported to the rx-offload
> >> helper. This way the mailboxes can be read in interrupt context and not
> >> from NAPI (which runs in softirq context only).
> >>
> >> If this basically works, it can be extended to support 64 mailboxes.
> > I'm facing overflows, and have good results with the patchset I sent
> > last week. As Marc says, reading the mailboxes in NAPI softirq may cause
> > regular overflows.
>
> Ok.  I see the newer changes to the c_can driver and will be trying those.
>
> --elenita
>
>
> On Thu, Oct 17, 2019 at 2:47 AM Kurt Van Dijck
> <dev.kurt@vandijck-laurijssen.be> wrote:
> >
> > On wo, 16 okt 2019 23:01:41 +0200, Marc Kleine-Budde wrote:
> > > On 10/16/19 9:06 PM, Elenita Hinds wrote:
> > > > I'm hoping someone can help me with this ...
> > > >
> > > > The DCAN module I'm testing with supports 64 CAN messages and DMA. The
> > > > combined c_can/d_can driver seem to only support 16 RX message objects
> > > > and no DMA (as far as I can tell).
> > >
> > > ACK
> > >
> > > > I noticed that older Linux version
> > > > (3.1) implemented a separate d_can driver that supports both.  I'm
> > > > wondering why these were removed from the latest c_can/d_can files.
> > >
> > > Can you give me a pointer to this driver? Are you talking about the
> > > mainline linux-3.1?
> > >
> > > > The reason for this question is I'm seeing frame losses and I think it
> > > > is due to the driver. Increasing the socket buffer sizes did not have
> > > > any effect; the number is overruns was still pretty large.
> > > >
> > > > Any feedback would be appreciated.
> > >
> > > The problem with the c_can and d_can is, that it doesn't have a proper
> > > FIFO but only mailboxes. And these mailboxes don't implement a
> > > timestamp, so that it's not that easy to read messages in the correct order.
> > >
> > > Does the device support bus master DMA? As CAN messages are quite small,
> > > the overhead of setting up DMA might be too high.
> > >
> > > The algorithm that tries to read the CAN frames in the correct order was
> > > added in v3.15. That algorithm should be ported to the rx-offload
> > > helper. This way the mailboxes can be read in interrupt context and not
> > > from NAPI (which runs in softirq context only).
> > >
> > > If this basically works, it can be extended to support 64 mailboxes.
> >
> > I'm facing overflows, and have good results with the patchset I sent
> > last week. As Marc says, reading the mailboxes in NAPI softirq may cause
> > regular overflows.
> >
> > Kurt
