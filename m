Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFE52F8ABB
	for <lists+linux-can@lfdr.de>; Sat, 16 Jan 2021 03:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbhAPCcD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Jan 2021 21:32:03 -0500
Received: from mail-yb1-f177.google.com ([209.85.219.177]:36918 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbhAPCcC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Jan 2021 21:32:02 -0500
Received: by mail-yb1-f177.google.com with SMTP id z1so6895566ybr.4
        for <linux-can@vger.kernel.org>; Fri, 15 Jan 2021 18:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJc9XfaqyZ7M+ROsydcQmdbEqxWY4jRZ/yXGG8a8CYY=;
        b=I94wiTBDg8VwemmDoThE/13+mjVjHDAgmDORotvXsZFkbIJpLLvA/cNSVS1F/P5ZWk
         /sU2nT9n9YnZ4aPKkZ4k+fM54ocYvR2W1fnGbp8dTJ8YXNWjoXnLoZsMyr4r9D6fqMwF
         JIndzxGhWeRdh1e1Yx8GWR2zkPpyy1zHbZwuLsXniZyj6VHnkeqYE1KjlNkeaJyjvntq
         YkON2+PZOQh87lwJzfJ/cIk+gRXd2rSkksm7OEsPpS2gYbcoFwhL5Ks9qVOxwqDM7pSO
         +okbCGwJgL3pLEQtWPqNP9qu/YnlN32YsvwOqLp9KCuVOvokj5ZfTosq9tB/888AfyKY
         iRCw==
X-Gm-Message-State: AOAM532aow8tChQhyvzJsMwK8NpWM3S2hjv+ssLgi1pmFUiTftSVsS9D
        8VHM6dDaReNkkzr4kGHNeho7PKpqDvshuPNrP28YAu9NGw6gbA==
X-Google-Smtp-Source: ABdhPJw04CmIO0zeHpTWBb7mNcqWKnLABr1lZ5JjavVkNoPIVorjSbgrqHoklNSnNki9cxKUw+IlIA4xLG5bKumD14Q=
X-Received: by 2002:a25:5583:: with SMTP id j125mr20129545ybb.307.1610764281051;
 Fri, 15 Jan 2021 18:31:21 -0800 (PST)
MIME-Version: 1.0
References: <20210112130538.14912-1-mailhol.vincent@wanadoo.fr>
 <20210112130538.14912-2-mailhol.vincent@wanadoo.fr> <981eb251-1573-5852-4b16-2e207eb3c4da@hartkopp.net>
 <CAMZ6RqKeGVsF+CcqoAWC7JXEo2oLTS5E5B3Jk4oeiF9XWEC3Sw@mail.gmail.com>
 <3daf39cb-2835-379d-86df-91b17282594a@pengutronix.de> <47a39992-2368-1403-e55c-3bee4793b91c@hartkopp.net>
 <7b41612e-6c99-a713-5285-a044402066bd@pengutronix.de> <CAMZ6RqLFLtcGQsnRLPF8VD4=OhSArM3HVT_2MNG-9HVBuPMV=Q@mail.gmail.com>
 <580003bc-af06-9d97-dfd1-aa56e306943a@pengutronix.de> <CAMZ6RqJ4dpbQdh96xSJyyVg_Ztzt0dw2z8Bn+e32vzq2=y1Gyg@mail.gmail.com>
 <b3088f7e-b5f1-a5bf-4e6c-a14cd1dec25b@pengutronix.de> <a175e052-b721-54df-812b-9880f78cde9b@pengutronix.de>
In-Reply-To: <a175e052-b721-54df-812b-9880f78cde9b@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 16 Jan 2021 11:31:10 +0900
Message-ID: <CAMZ6RqKTwK8-ztqJ576MG0VcBLmf+HCKmv-xzetcb+_d4PQ+7Q@mail.gmail.com>
Subject: Re: [PATCH v10 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun. 16 Jan 2021 at 04:00, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 1/15/21 7:27 PM, Marc Kleine-Budde wrote:
> >>> Option 4:
> >>> We can introduce a struct can_bitiming_fd with the first member being the struct
> >>> can_bitiming and add tdc related variables after that. This way we can use the
> >>> same function to calculate the bit timing on both CAN and CAN-FD.
> >>
> >> While option 3 is slightly easier, my preference will go to option 4.
> >
> > We still need the netlink enhancement from option 3.
>
> Just tried option 4.
>
> > diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> > index 7faf6a37d5b2..bf2326fe22a1 100644
> > --- a/include/linux/can/dev.h
> > +++ b/include/linux/can/dev.h
> > @@ -32,6 +32,10 @@ enum can_mode {
> >         CAN_MODE_SLEEP
> >  };
> >
> > +struct canfd_bittiming {
> > +       struct can_bittiming dbt;
>
> tdc to be added here....
>
> > +};
> > +
> >  /*
> >   * CAN common private data
> >   */
> > @@ -39,7 +43,8 @@ struct can_priv {
> >         struct net_device *dev;
> >         struct can_device_stats can_stats;
> >
> > -       struct can_bittiming bittiming, data_bittiming;
> > +       struct can_bittiming bittiming;
> > +       struct canfd_bittiming data_bittiming;
> >         const struct can_bittiming_const *bittiming_const,
> >                 *data_bittiming_const;
> >         const u16 *termination_const;
>
> But I had to add that ".dbt" everywhere....
>
> > --- a/drivers/net/can/dev/dev.c
> > +++ b/drivers/net/can/dev/dev.c
> > @@ -345,8 +345,8 @@ int open_candev(struct net_device *dev)
> >
> >         /* For CAN FD the data bitrate has to be >= the arbitration bitrate */
> >         if ((priv->ctrlmode & CAN_CTRLMODE_FD) &&
> > -           (!priv->data_bittiming.bitrate ||
> > -            priv->data_bittiming.bitrate < priv->bittiming.bitrate)) {
> > +           (!priv->data_bittiming.dbt.bitrate ||
> > +            priv->data_bittiming.dbt.bitrate < priv->bittiming.bitrate)) {
> >                 netdev_err(dev, "incorrect/missing data bit-timing\n");
> >                 return -EINVAL;
> >         }
> > diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> > index 3ae884cdf677..c8341cbd8a66 100644
> > --- a/drivers/net/can/dev/netlink.c
> > +++ b/drivers/net/can/dev/netlink.c
> > @@ -239,7 +239,7 @@ static size_t can_get_size(const struct net_device *dev)
> >         size += nla_total_size(sizeof(u32));                    /* IFLA_CAN_RESTART_MS */
> >         if (priv->do_get_berr_counter)                          /* IFLA_CAN_BERR_COUNTER */
> >                 size += nla_total_size(sizeof(struct can_berr_counter));
> > -       if (priv->data_bittiming.bitrate)                       /* IFLA_CAN_DATA_BITTIMING */
> > +       if (priv->data_bittiming.dbt.bitrate)                   /* IFLA_CAN_DATA_BITTIMING */
> >                 size += nla_total_size(sizeof(struct can_bittiming));
> >         if (priv->data_bittiming_const)                         /* IFLA_CAN_DATA_BITTIMING_CONST */
> >                 size += nla_total_size(sizeof(struct can_bittiming_const));
> > @@ -286,7 +286,7 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
> >              !priv->do_get_berr_counter(dev, &bec) &&
> >              nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
> >
> > -           (priv->data_bittiming.bitrate &&
> > +           (priv->data_bittiming.dbt.bitrate &&
> >              nla_put(skb, IFLA_CAN_DATA_BITTIMING,
> >                      sizeof(priv->data_bittiming), &priv->data_bittiming)) ||
> >
>
> And that's not even everything.

I also expected that many lines would have to be changed:
  $ grep -R data_bittiming drivers/net/can/dev | wc -l
  15
And (full kernel tree):
  $ grep -R data_bittiming | wc -l
  126

But those changes are all trivial, that's why I liked the idea.

> I think best it to add a "struct can_tdc" directly to the struct can_priv. Then
> add a netlink interface that returns the existing can_bittiming and the can_tdc,
> not as a struct, but each member with a separate tag (or whatever it's called).

Not a bad idea, still need to think about the pros and cons.

For now, I will use the "struct can_tdc" in my RFC. Right now, I
will not be working on the netlink interface immediately. I will
first focus on modifying the ES58X driver's FIFO and go back to
the netlink interface later.


Yours sincerely,
Vincent

> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
>
