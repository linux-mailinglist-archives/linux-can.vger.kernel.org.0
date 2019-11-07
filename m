Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88C6F2EA0
	for <lists+linux-can@lfdr.de>; Thu,  7 Nov 2019 13:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKGM5q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 7 Nov 2019 07:57:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41683 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKGM5q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 7 Nov 2019 07:57:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id p26so2642634pfq.8
        for <linux-can@vger.kernel.org>; Thu, 07 Nov 2019 04:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CenMgMhmVHd87U1RWjXhLJq6VgiF+BXIOe7omCE7A5M=;
        b=coU5V5pXAnM7G9KyoSEUHHTz66KNz5zL6UBvPNwsg7E0AXUTg/+UwmLX4lGtVrGBmE
         MxY4YGoy4b7wRthJN0yR5ObTU6/Trf66lHAjn6ph/vhacn+Xn6ZtzvBo4BZmws0+T7Rw
         41V/bxl97fYtrQFO/uOUy/co/wTREqafQk2JP/OjdbUxyuo2DqfAN7Wm4jOef2G6dxAv
         CnLRrcjqMPa3b8yAQMFxKoswjAW0/puMOfeETbePePqjDixiQRTQx2R8ghIWgW613Dwy
         Haspaw5YJIbz4raoeMa67e5YmZKf1Ong5SEfa5XbREa4eN5e94ioMoKZyYwISmZrz6j1
         yrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=CenMgMhmVHd87U1RWjXhLJq6VgiF+BXIOe7omCE7A5M=;
        b=PvgBCIfEtMlnqev3BsiFnozYHUK/VHaPqyvPn+5hJ6gd4SU9SqiF3UZqFHE021h4JI
         NgW4YpQjcSdkruBhZDizYGn70V5mqaGbYvAid/jjuRkvct5fIi27bAQVlsNdq1IxLsmZ
         i7PNf1lkXzPc0G7t2scZ6wtzpJgWw+qvjWXoYRdMdh9XK6VfxeRq2jQXE7xiULi9UvJY
         EbcP++ifj5ZBU5vf4dL9V1ybbPFl8eCiJWr+x0h+KHZKAnjCClPhbUK9WOyocBMczxdn
         KCMMo2rhBVT7GD6jcy5d+GhQh4UpCB/hDVtdvZd2fXOO1hdu9tdy7E81gvKwYdEmuTXQ
         SQ8A==
X-Gm-Message-State: APjAAAWb/1n0in/b/UpdkYqpsrXT7og5dSGwcYUUzavkT1llrmw29rXb
        Oib3P+h6PDV1Gto05DUH82ss1V6BqEw1rYiqjMNL1+OT2KI=
X-Google-Smtp-Source: APXvYqwKnHXMI2Y4Qo1ZVNW/tOLysGX5uFa2rRxtsL+yraPWG5u4r1QeUK8lRewkDLEF4hlGbG53Yrjtrqsd1gnKyIY=
X-Received: by 2002:a63:d951:: with SMTP id e17mr4225591pgj.243.1573131463605;
 Thu, 07 Nov 2019 04:57:43 -0800 (PST)
MIME-Version: 1.0
References: <CADNXvDw5KDju9pHaRY1_6T-GgoOo=T2i4FZJRvd0GuP0jZis=g@mail.gmail.com>
 <CADNXvDy5qj0=tUQ1h_aN4UuCRtnXQ+4y55+JSKneyx9-C1CyBA@mail.gmail.com>
 <7e91f790-22f5-070c-f56d-a432779c7e4d@hartkopp.net> <D5447E34-0D39-470F-A4FF-D9530F91359E@vandijck-laurijssen.be>
 <f11ebe09-1ce9-0b4c-2c6c-f6a0d2383696@hartkopp.net> <CADNXvDzewkO8L-3LYNtt=JsMTmf8rw5uOaquF5mB2OS_5fKaTA@mail.gmail.com>
 <85e46c24-0b0c-3109-3ee9-07914cca6d7b@hartkopp.net> <20191106215943.GA5341@x1.vandijck-laurijssen.be>
 <CADNXvDzwe9nYpfaDb-m191RvPoZXa9GixbXjZ-ZP7UoMnXV9Lw@mail.gmail.com>
In-Reply-To: <CADNXvDzwe9nYpfaDb-m191RvPoZXa9GixbXjZ-ZP7UoMnXV9Lw@mail.gmail.com>
From:   Jaroslav Beran <jara.beran@gmail.com>
Date:   Thu, 7 Nov 2019 13:57:30 +0100
Message-ID: <CADNXvDyy=AF0a0FBWyXwLwpazqOxx4nqEOLD9XvEw8vbk4Ts7Q@mail.gmail.com>
Subject: Fwd: Fwd: Return value of write() in BUS-OFF state
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

---------- Forwarded message ---------
From: Jaroslav Beran <jara.beran@gmail.com>
Date: Wed, Nov 6, 2019 at 11:09 PM
Subject: Re: Fwd: Return value of write() in BUS-OFF state
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>


On Wed, Nov 6, 2019 at 10:59 PM Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
>
> On wo, 06 nov 2019 22:15:50 +0100, Oliver Hartkopp wrote:
> >
> >
> >
> > On 06/11/2019 18.23, Jaroslav Beran wrote:
> > >On Wed, Nov 6, 2019 at 3:26 PM Oliver Hartkopp <socketcan@hartkopp.net=
> wrote:
> > >>
> > >>
> > >>
> > >>On 06/11/2019 12.23, Kurt Van Dijck wrote:
> > >>>
> > >>>
> > >>>On 6 November 2019 12:12:39 GMT+01:00, Oliver Hartkopp <socketcan@ha=
rtkopp.net> wrote:
> > >>>>Hello Jaroslav,
> > >>>>
> > >>>>On 05/11/2019 22.46, Jaroslav Beran wrote:
> > >>>>
> > >>>>>So far I've learned this issue is most probably caused by upper (n=
et
> > >>>>>and can) layers (so this is not specific for certain controller
> > >>>>>driver). When a driver calls can_bus_off, it sets carrier-off and
> > >>>>>triggers linkwatch_* actions that deactivate net queues and
> > >>>>substitute
> > >>>>>a struct qdisc with `noop_qdisc`. Upon sending a frame, it's enque=
ue
> > >>>>>function - noop_enqueue - just returns NET_XMIT_CN, which is
> > >>>>>transformed by net_xmit_errno macro to zero, that's passed by
> > >>>>>net/can/af_can.c:can_send up to a userspace caller of write as
> > >>>>>success.
> > >>>>
> > >>>>Hm.
> > >>>>
> > >>>>>According to description for qdisc return codes in
> > >>>>>include/linux/netdevice.h, NET_XMIT_CN stands for `congestion
> > >>>>>notification` and further
> > >>>>>
> > >>>>>/* NET_XMIT_CN is special. It does not guarantee that this packet =
is
> > >>>>lost. It
> > >>>>>    * indicates that the device will soon be dropping packets, or
> > >>>>already drops
> > >>>>>    * some packets of the same priority; prompting us to send less
> > >>>>aggressively. */
> > >>>>>
> > >>>>>
> > >>>>>Is this behavior appropriate for a node in BUS-OFF state? I'd rath=
er
> > >>>>>expect such controller would be always dropping all frames (not ju=
st
> > >>>>>soon and some) until reset.
> > >>>>
> > >>>>The common use of the net_xmit_errno macro probably really does not=
 fit
> > >>>>
> > >>>>to the CAN specialties ...
> > >>>>
> > >>>>>In current situation a caller of write gets success even if his fr=
ame
> > >>>>>is lost for sure. Is there any specific reason for this? Of course=
 he
> > >>>>>can be notified by receiving error frame, but why don't just retur=
n
> > >>>>>error in can_send?
> > >>>>
> > >>>>Yes. It makes sense to forward the carrier-off state that is thankf=
ully
> > >>>>
> > >>>>provided by the linkwatch triggers to the user space.
> > >>>>
> > >>>>Looking to man(2) send we should provide -ENOBUFS in the case of
> > >>>>carrier-off state, right?
> > >>>ENOBUFS seems a bad indication. What about ENETDOWN instead?
> > >>
> > >>ENETDOWN shows that the interface is "down" which does not fit the
> > >>current situation.
>
> ack. ENETDOWN was a bad suggestion.
>
> > >>
> > >>The interface is "up" but the carrier is "off".
> > >>
> > >>man(2) send says:
> > >>
> > >>ENOBUFS
> > >>        The output queue for a network interface was full.  This  gen=
er=E2=80=90
> > >>        ally  indicates  that the interface has stopped sending, but =
may
> > >>        be caused by transient congestion.  (Normally, this does not =
oc=E2=80=90
> > >>        cur  in  Linux.  Packets are just silently dropped when a dev=
ice
> > >>        queue overflows.)
> > >>
> > >>Fits to me !?
> > >>
> > >
> > >I don't know, neither option doesn't perfectly fit for the carrier-off
> > >state to me.
> > >
> > >What about choosing another code like ENOSPC or EIO to distinguish
> > >bus-off from other recoverable conditions?
> >
> > I must admit that the ability to distinguish the return values would be
> > cool.
>
> ack. busoff is completely different from 'on buffers'
>
> >
> > But when you check the man pages from either send() or write() you'll s=
ee
> > that ENOSPC or EIO have a description that fit even worse.
>
> ENETUNREACH? I'm just picking values that suit more.

Yeah, I couldn't find anything better than ENETUNREACH. Already sent a patc=
h.
