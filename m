Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843F6340409
	for <lists+linux-can@lfdr.de>; Thu, 18 Mar 2021 11:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhCRK4G (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Mar 2021 06:56:06 -0400
Received: from mail-yb1-f175.google.com ([209.85.219.175]:40379 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhCRKzg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Mar 2021 06:55:36 -0400
Received: by mail-yb1-f175.google.com with SMTP id c131so2083396ybf.7
        for <linux-can@vger.kernel.org>; Thu, 18 Mar 2021 03:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJGJw9eL9CZknjo6y6qoAyYJvMEW4/zwLcLqQdRZ2Ys=;
        b=GXyTaLsOrRlAH19Eg5ZU/21RWZ8nJHgBUoybGTVm2+x5X0TH3c+EowpqkFM72kvzNk
         XOKV/rSGxIofS1nDYUQE/QVQykFW1+2XQ6g4QzERncZcY+mAMvsgKF6b5lOqjCsNtIYx
         Tvw5MfBv0CatD++2vep2SJNbJHGMeWyhLUMFW34zhO3T74YvBWYfcN+/2MopWkT7Iykl
         eIERAPSnyxUBku2oKpxHS5CMfloO28hehnW5gbutCO4obvldRuL8FWbT9WlHsu0qiQFc
         6KOCkDt4Ic1INMW8nJwXD7BmNOlBJxoZIZ5IUbO0gEHK55+OuJ96vuwPlo6wD7Nh8iqA
         idsA==
X-Gm-Message-State: AOAM530pBRcNhDsswBMjkD/sMkhwqwp/h75Iimvt1MspFxpFOC822AW8
        SandgPpcz3ta6+L/Cy08eHQwFedjKy2SzsDe6F2dliO76CBmg5jE
X-Google-Smtp-Source: ABdhPJzRkpIQ1PnXRnvOINOKv3jaJDb7NiIgju+r46Ltyz6sYjnErB1JozmHVHgrEMosmDa5PChC7a38xMU9H8ianPw=
X-Received: by 2002:a25:3853:: with SMTP id f80mr11044324yba.514.1616064934287;
 Thu, 18 Mar 2021 03:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210309211904.3348700-1-mkl@pengutronix.de> <CAMZ6Rq+QNj6ajmTyqtZt0HnJjg95Y_Ud-eokhZj9AvN1dPpRYg@mail.gmail.com>
 <b4c7b62d-7004-7862-32e3-00f3bd73383c@hartkopp.net>
In-Reply-To: <b4c7b62d-7004-7862-32e3-00f3bd73383c@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 18 Mar 2021 19:55:23 +0900
Message-ID: <CAMZ6Rq+QYSh8QUnMRR5QSbnv0mHx-+vuqGbYd16nRXTs=M92Xg@mail.gmail.com>
Subject: Re: [PATCH can-next] can: dev: always create TX echo skb
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thur. 18 Mar 2021 at 19:21, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hi Vincent,
>
> On 18.03.21 11:03, Vincent MAILHOL wrote:
> > Hi Marc,
> >
> > On Wed. 10 Mar 2021 at 06:19, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> >>
> >> So far the creation of the TX echo skb was optional and can be
> >> controlled by the local sender of a CAN frame.
> >>
> >> It turns out that the TX echo CAN skb can be piggybacked to carry
> >> information in the driver from the TX- to the TX-complete handler.
> >>
> >> Several drivers already use the return value of
> >> can_get_echo_skb() (which is the length of the data field in the CAN
> >> frame) for their number of transferred bytes statistics. The
> >> statistics are not working if CAN echo skbs are disabled.
> >>
> >> Another use case is to calculate and set the CAN frame length on the
> >> wire, which is needed for BQL support in both the TX and TX-completion
> >> handler.
> >>
> >> For now in can_put_echo_skb(), which is called from the TX handler,
> >> the skb carrying the CAN frame is discarded if no TX echo is
> >> requested, leading to the above illustrated problems.
> >>
> >> This patch changes the can_put_echo_skb() function, so that the echo
> >> skb is always generated. If the sender requests no echo, the echo skb
> >> is consumed in __can_get_echo_skb() without being passed into the RX
> >> handler of the networking stack, but the CAN data length and CAN frame
> >> length information is properly returned.
> >>
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >> ---
> >>   drivers/net/can/dev/skb.c | 10 ++++++++--
> >>   1 file changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> >> index 6a64fe410987..22b0472a5fad 100644
> >> --- a/drivers/net/can/dev/skb.c
> >> +++ b/drivers/net/can/dev/skb.c
> >> @@ -45,7 +45,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
> >>          BUG_ON(idx >= priv->echo_skb_max);
> >>
> >>          /* check flag whether this packet has to be looped back */
> >> -       if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK ||
> >> +       if (!(dev->flags & IFF_ECHO) ||
> >>              (skb->protocol != htons(ETH_P_CAN) &&
> >>               skb->protocol != htons(ETH_P_CANFD))) {
> >>                  kfree_skb(skb);
> >> @@ -58,7 +58,6 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
> >>                          return -ENOMEM;
> >>
> >>                  /* make settings for echo to reduce code in irq context */
> >> -               skb->pkt_type = PACKET_BROADCAST;
> >>                  skb->ip_summed = CHECKSUM_UNNECESSARY;
> >>                  skb->dev = dev;
> >>
> >> @@ -111,6 +110,13 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
> >>
> >>                  priv->echo_skb[idx] = NULL;
> >>
> >> +               if (skb->pkt_type == PACKET_LOOPBACK) {
> >> +                       skb->pkt_type = PACKET_BROADCAST;
> >> +               } else {
> >> +                       dev_consume_skb_any(skb);
> >> +                       return NULL;
> >> +               }
> >> +
> >>                  return skb;
> >>          }
> >
> > I do see any particular issues on this patch at the moment,
> > however, while looking at the TX echo functionality, it reminded
> > me of a point which has always been a bit unclear to me: the
> > CAN_CTRLMODE_LOOPBACK. So let me go a bit off topic.
> >
> > Like all other controller's mode, I would expect the
> > CAN_CTRLMODE_LOOPBACK flag to do two things:
> >    - Announce that the device is capable of doing loopback
> >    - Control this feature (enable/disable it)
> >
> > But, by default, this flag is set to 0 unless the user
> > explicitly passes the "loopback on" argument when configuring
> > the device.
> >
> > So isn't this supposed to be an issue for all the drivers which
> > expect to get a TX loopback in order to trigger the TX completion
> > handler?
> >
> > Personally, for my driver, I would like to use the
> > can_set_static_ctrlmode() to force CAN_CTRLMODE_LOOPBACK so that
> > I do not need a different TX completion logic when
> > CAN_CTRLMODE_LOOPBACK is off.
> >
> > The issue is that because CAN_CTRLMODE_LOOPBACK is per default
> > off, doing:
> >    can_set_static_ctrlmode(netdev, CAN_CTRLMODE_LOOPBACK);
> > would lead to a
> >    RTNETLINK answers: Operation not supported
> > when configuring the device unless "loopback on" is explicitly
> > passed on the command line.
> >
> > At the moment, I have the feeling that many drivers just ignore
> > the value of this flag and activate the loopback regardless.
> >
> > Do you think that it would make sense to set
> > CAN_CTRLMODE_LOOPBACK by default to on?
>
> Definitely not.
>
> CAN_CTRLMODE_LOOPBACK defines that the CAN controller establishes a
> shortcut below the rx/tx bitstream engines on chip level. So the
> attached CAN transceiver is not in operation anymore.
>
> Please do not mix up CAN_CTRLMODE_LOOPBACK with the IFF_ECHO flag that
> echoes CAN frames in the sending host to reflect the correct CAN traffic
> e.g. in candump.

OK. I indeed totally misunderstood the meaning of that
CAN_CTRLMODE_LOOPBACK.

Thanks for the clarification. Now, I understand the meaning.


Yours sincerely,
Vincent
