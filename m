Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F6B352AE6
	for <lists+linux-can@lfdr.de>; Fri,  2 Apr 2021 15:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhDBNCY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Apr 2021 09:02:24 -0400
Received: from mail-yb1-f179.google.com ([209.85.219.179]:46841 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhDBNCY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Apr 2021 09:02:24 -0400
Received: by mail-yb1-f179.google.com with SMTP id 8so5017057ybc.13
        for <linux-can@vger.kernel.org>; Fri, 02 Apr 2021 06:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIg0i6CmYh4n4awmgUOl25efgfB/lH0FnDU+1uIse9A=;
        b=XgNXSj7V4qgdYDBmvOdorKa48vkxhGeqCe4Jh4Ip360ndL/ghLluo+w2FQrkUNGy9M
         r7ve1fVyxw6+qdyL/C5K2L83D8epUUfU70GQ1TLTvN2nvPeT8aXQGLqlJnkSWD0i9Qvo
         HtH3Q1uhJgvwsDBI+ZQuu7NEvLArnOc3qL9H6QWZkaso6AQbsLaB3QRVAuCqGYmvFaQz
         E20U8IKolXrRolqsTg2wplZ8gtffnXlITO1w0p7fZscNQ9dxvqmRXMR6eqx6ySzl8brJ
         OONSdpx2XwAzelhaWVlFok3101cJ70NTuXSckn7OC5IsSMyNVLKyynitlp5B0/Wq4YsS
         5mwg==
X-Gm-Message-State: AOAM532DMgr18wqoX2fXy7q+wlFF4u5xK/D7sqfnf08L0T2i7ehO6ZuY
        t1nFgcEsM6HAZAvr4ok395akp7VSfeHkVYFr3hg=
X-Google-Smtp-Source: ABdhPJxFlNOVjUvC+qwxWxtDTQtZlBs5UwHbNsQUZpOSCwnv7F0OlItO7iTh35G/PacVl25wKqDcVU+5AF6Zff+Mo20=
X-Received: by 2002:a25:7a02:: with SMTP id v2mr17763881ybc.514.1617368541407;
 Fri, 02 Apr 2021 06:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210321104103.213308-1-mailhol.vincent@wanadoo.fr>
 <20210321104103.213308-2-mailhol.vincent@wanadoo.fr> <20210329123636.5xrgzdxyt54y7coe@pengutronix.de>
 <CAMZ6RqKeEoNGN0iZUfEG8x=FMHu4d2ZE=0QPiOxSXTrXFjg9rg@mail.gmail.com> <20210402104735.ucv6it3pk4ze4umy@pengutronix.de>
In-Reply-To: <20210402104735.ucv6it3pk4ze4umy@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 2 Apr 2021 22:02:10 +0900
Message-ID: <CAMZ6RqKM8FBwNMxnO-D6zTCs32Fc-KB=8+7O2wtDH=hcoTVX6g@mail.gmail.com>
Subject: Re: [PATCH v14 1/4] can: etas_es58x: add core support for ETAS ES58X
 CAN USB interfaces
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 2 Apr 2021 at 19:47, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 02.04.2021 18:56:33, Vincent MAILHOL wrote:
> > > > +int es58x_rx_err_msg(struct net_device *netdev, enum es58x_err error,
> > > > +                  enum es58x_event event, u64 timestamp)
> > > > +{
> > > > +     struct es58x_priv *priv = es58x_priv(netdev);
> > > > +     struct can_priv *can = netdev_priv(netdev);
> > > > +     struct can_device_stats *can_stats = &can->can_stats;
> > > > +     struct can_frame *cf;
> > >
> > > = NULL;
> > >
> > > So that the if (cf) properly works...
> >
> > I actually expected cfto be set to NULL when an error
> > occurred (same as skb).
> >
> > But indeed, cf is not initialised if the allocation fails. I was
> > wondering if it would not be better to make both alloc_can_skb()
> > and and alloc_canfd_skb() set cf to NULL. That would remove a
> > pitfall.
>
> Makes sense.
>
> > If you like the idea, I can submit a patch.
>
> Sorry creating this drive by patch. The patch description took longer
> than the actual patch :)

This is often the case for any patches where the diff is one or two lines!

[...]
>
> > > > +/**
> > > > + * es58x_open() - Open and start network device.
> > > > + * @netdev: CAN network device.
> > > > + *
> > > > + * Called when the network transitions to the up state.
> > > > + *
> > > > + * Return: zero on success, errno when any error occurs.
> > > > + */
> > > > +static int es58x_open(struct net_device *netdev)
> > > > +{
> > > > +     int ret;
> > > > +
> > > > +     ret = open_candev(netdev);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ret = es58x_enable_channel(netdev);
> > > > +     if (ret)
> > > > +             return ret;
> > >
> > > Please do an as complete as possible reset and configuration during
> > > open(). If there is any error a ifdown/ifup should fix it. Here on a USB
> > > device with multiple interfaces it's not as easy as on devices with only
> > > one CAN interface.
> >
> > ACK.
> >
> > I will use a function as below to check if all interfaces are
> > down.
> >
> > static bool es58x_are_all_channels_closed(struct es58x_device *es58x_dev)
> > {
> >     int i;
> >
> >     for (i = 0; i < es58x_dev->num_can_ch; i++) {
> >         struct can_priv *can_priv = netdev_priv(es58x_dev->netdev[i]);
> >         if (can_priv->state != CAN_STATE_STOPPED)
> >             return false;
> >     }
> >     return true;
> > }
> >
> > I will modify both es58x_open() and es58x_close().
>
> Have a look at
> https://elixir.bootlin.com/linux/v5.11/source/include/linux/kref.h
>
> I'm not sure if kref is overkill here :)

There is indeed a race condition in which the above function
might return true when it is not supposed to.

I checked the struct kref and the refcount_t, but here, I think
that a simple atomic_t is enough because there is no risk of
saturation.

Something like:
|     if (atomic_inc_return(opened_channel_cnt) == 1)
|         /* configure */
and
|     if (atomic_dec_and_test(opened_channel_cnt))
|         /* release */

[...]

Yours sincerely,
Vincent
