Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A751E3234E1
	for <lists+linux-can@lfdr.de>; Wed, 24 Feb 2021 02:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhBXBGg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Feb 2021 20:06:36 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:39955 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbhBXAGl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Feb 2021 19:06:41 -0500
Received: by mail-yb1-f174.google.com with SMTP id c131so52208ybf.7
        for <linux-can@vger.kernel.org>; Tue, 23 Feb 2021 16:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ob1ifamVEUqkO6WMYRQn8pEi+9UY+qX/obk03BohRww=;
        b=BesWqDH0FEFPSKbiT+WDiNyOeTuiydvWvKvpqu92OjWzgO84cYtaQrkEppqOUGHDhG
         G1m++yvtWlgmt+ajdR3GB1wrSjaB4MpitxmD3vBokmLtOXH1CbaYDeHAEsUHiizh9Fa7
         a8AFxwUAmwrOjlRNFVnxZinpeSw6Zv+Hht/A0zOA3NbSEewGsFlpwSbyqKGL+r7D6nh6
         11uCBa6YqTuwWv8m5k/q3UvBvFgISE/3YKzhAOlYCABHunH5dTVFaHHqmnHBEP1o6lwz
         ssG0ss2CFheW/n7WHzWc0/lyK3fl8TIpVQwpyhUKsxu/YFX5ilI4ojLNPAc6TaCUv6SW
         iZEQ==
X-Gm-Message-State: AOAM531unSvJ6adnx/82+0oKD9YN5TW5jtJZfzSj9F/BUcH6KlAHdKlv
        +0r3JhT7ChTtGZsA+TqlB61iI8DCRTaTFdY6ioQ=
X-Google-Smtp-Source: ABdhPJz7RMLAo4gdXl1OtLnIurrOAVTegTAYb8tfVLru7Rmw/iTBb7VdFSEPhIVcJJbhPZvfDmZaseeIabjq4XbUNEI=
X-Received: by 2002:a25:850f:: with SMTP id w15mr43859054ybk.487.1614125159144;
 Tue, 23 Feb 2021 16:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20210223162852.218041-1-mailhol.vincent@wanadoo.fr>
 <20210223162852.218041-4-mailhol.vincent@wanadoo.fr> <20210223194730.mswiinbzwuo26bt6@pengutronix.de>
In-Reply-To: <20210223194730.mswiinbzwuo26bt6@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 24 Feb 2021 09:05:48 +0900
Message-ID: <CAMZ6RqKhA=iNuiCJ3_Sv3kmrv=bfzVSWnQ_1KSu6ryLaL=J-uQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] can: netlink: move '=' operators back to previous
 line (checkpatch fix)
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Wed. 24 Feb 2021 at 04:47, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 24.02.2021 01:28:50, Vincent Mailhol wrote:
> > Fix the warning triggered by having an '=' at the beginning of the
> > line and add one indentation to fix the alignment.
> >
> > Extract of ./scripts/checkpatch.pl -f drivers/net/can/dev/netlink.c:
> >
> > CHECK: Assignment operator '=' should be on the previous line
> > +       [IFLA_CAN_BITTIMING_CONST]
> > +                               = { .len = sizeof(struct can_bittiming_const) },
> >
> > CHECK: Assignment operator '=' should be on the previous line
> > +       [IFLA_CAN_DATA_BITTIMING]
> > +                               = { .len = sizeof(struct can_bittiming) },
> >
> > CHECK: Assignment operator '=' should be on the previous line
> > +       [IFLA_CAN_DATA_BITTIMING_CONST]
> > +                               = { .len = sizeof(struct can_bittiming_const) },
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> >  drivers/net/can/dev/netlink.c | 26 ++++++++++++--------------
> >  1 file changed, 12 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> > index 867f6be31230..75851fab7ff5 100644
> > --- a/drivers/net/can/dev/netlink.c
> > +++ b/drivers/net/can/dev/netlink.c
> > @@ -8,20 +8,18 @@
> >  #include <net/rtnetlink.h>
> >
> >  static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
> > -     [IFLA_CAN_STATE]        = { .type = NLA_U32 },
> > -     [IFLA_CAN_CTRLMODE]     = { .len = sizeof(struct can_ctrlmode) },
> > -     [IFLA_CAN_RESTART_MS]   = { .type = NLA_U32 },
> > -     [IFLA_CAN_RESTART]      = { .type = NLA_U32 },
> > -     [IFLA_CAN_BITTIMING]    = { .len = sizeof(struct can_bittiming) },
> > -     [IFLA_CAN_BITTIMING_CONST]
> > -                             = { .len = sizeof(struct can_bittiming_const) },
> > -     [IFLA_CAN_CLOCK]        = { .len = sizeof(struct can_clock) },
> > -     [IFLA_CAN_BERR_COUNTER] = { .len = sizeof(struct can_berr_counter) },
> > -     [IFLA_CAN_DATA_BITTIMING]
> > -                             = { .len = sizeof(struct can_bittiming) },
> > -     [IFLA_CAN_DATA_BITTIMING_CONST]
> > -                             = { .len = sizeof(struct can_bittiming_const) },
> > -     [IFLA_CAN_TERMINATION]  = { .type = NLA_U16 },
>
> What about having only one space before and after the "="? Otherwise if
> another entry is added wich is longer, the aligning would be broken again...

Yes sir!

I do not have a strong preference between one style or the
other. Will resend the patch with a single space instead of
tabulations.

> > +     [IFLA_CAN_STATE]                = { .type = NLA_U32 },
> > +     [IFLA_CAN_CTRLMODE]             = { .len = sizeof(struct can_ctrlmode) },
> > +     [IFLA_CAN_RESTART_MS]           = { .type = NLA_U32 },
> > +     [IFLA_CAN_RESTART]              = { .type = NLA_U32 },
> > +     [IFLA_CAN_BITTIMING]            = { .len = sizeof(struct can_bittiming) },
> > +     [IFLA_CAN_BITTIMING_CONST]      = { .len = sizeof(struct can_bittiming_const) },
> > +     [IFLA_CAN_CLOCK]                = { .len = sizeof(struct can_clock) },
> > +     [IFLA_CAN_BERR_COUNTER]         = { .len = sizeof(struct can_berr_counter) },
> > +     [IFLA_CAN_DATA_BITTIMING]       = { .len = sizeof(struct can_bittiming) },
> > +     [IFLA_CAN_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
> > +     [IFLA_CAN_TERMINATION]          = { .type = NLA_U16 },
> > +     [IFLA_CAN_TERMINATION]          = { .type = NLA_U16 },
> >  };
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
