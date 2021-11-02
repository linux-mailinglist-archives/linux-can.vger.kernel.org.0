Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC5344294F
	for <lists+linux-can@lfdr.de>; Tue,  2 Nov 2021 09:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhKBI22 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Nov 2021 04:28:28 -0400
Received: from mail-yb1-f181.google.com ([209.85.219.181]:39584 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBI22 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Nov 2021 04:28:28 -0400
Received: by mail-yb1-f181.google.com with SMTP id j75so23390100ybj.6
        for <linux-can@vger.kernel.org>; Tue, 02 Nov 2021 01:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jPq3m9uxg761Llk2jAOdzrSFsEubLMTUNccu/sS2zw=;
        b=YDawU+DE3DssF68bPJGlkK/rqq0bKQWGKE5FG1XaQgxddVF27bu9rxMLXxIp1VxYh/
         zl/GQtd+gIxxWLL1GWGYdgzuFmePK+Xyajil/6DR8Xo6fDROuus41OoU2mfyiggY1yHm
         UqvGdveLNF4CTX2E7jw+G73YCT7IeT8MQsGbs6syTVYkmka5PwQLwFy6G+pu+nm+5nae
         7jFkeOoXWNaikoTMX1dqW20CSZHKtalZRe8N9mPsI2pRFaCddeaDY0oBR0rSJfImDZ05
         myyYNdhtsMRf4d1osNOJoDZPjZ7HwtvXC1TmoBqAM/yfXM2lz6PZYzUQx5Znk87NOi/T
         PBhQ==
X-Gm-Message-State: AOAM530S4jJjhKHmuvkAqX86qXRrqyXQcz2wvonzaI4o7VkF9vyarwBd
        Vjy4+vSX6wayIfB0gIce10c2QE3F9OpHSiX+eOQ68eJ9q8k=
X-Google-Smtp-Source: ABdhPJyRY3UqwsKfVj0MRjt4weU2KTs9Z+JMsp4gB2irRVPUhu0i4X4joM4a6FdhF+oMjb+O7HITYABQJLGDWidPFEg=
X-Received: by 2002:a25:c792:: with SMTP id w140mr16855098ybe.131.1635841553282;
 Tue, 02 Nov 2021 01:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211101123125.67488-1-mailhol.vincent@wanadoo.fr> <ba2a284e-557a-454a-b699-1c80cfbc3947@hartkopp.net>
In-Reply-To: <ba2a284e-557a-454a-b699-1c80cfbc3947@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 2 Nov 2021 17:25:42 +0900
Message-ID: <CAMZ6RqK+ydkW7u5boQbwSeRCTEJLp96+4QP=XcbJ6t0mg7MbBw@mail.gmail.com>
Subject: Re: [PATCH v5] can: netlink: report the CAN controller mode supported flags
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

On Tue. 2 Nov 2021 at 03:43, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hi Vincent,
> On 01.11.21 13:31, Vincent Mailhol wrote:
> > Currently, the CAN netlink interface provides no easy ways to check
> > the capabilities of a given controller. The only method from the
> > command line is to try each CAN_CTRLMODE_* individually to check
> > whether the netlink interface returns an -EOPNOTSUPP error or not
> > (alternatively, one may find it easier to directly check the source
> > code of the driver instead...)
> >
> > This patch introduces a method for the user to check both the
> > supported and the static capabilities. The proposed method introduces
> > a new IFLA nest: IFLA_CAN_CTRLMODE_EXT which extends the current
> > IFLA_CAN_CTRLMODE. This is done to guaruanty a full forward and
>
> guaranty ?!?

to guarantee (forgot to run the spell checker...)

> > backward compatibility between the kernel and the user land
> > applications.
> >
> > The IFLA_CAN_CTRLMODE_EXT nest contains one single entry:
> > IFLA_CAN_CTRLMODE_SUPPORTED. Because this single entry is only used in
> > one direction: kernel to userland, no new struct nla_policy are
> > introduced.
> >
> > Below table explains how IFLA_CAN_CTRLMODE_SUPPORTED (hereafter:
> > "supported") and can_ctrlmode::flags (hereafter: "flags") allow us to
> > identify both the supported and the static capabilities, when masked
> > with any of the CAN_CTRLMODE_* bit flags:
>
> This is not clear to me.
>
> What I understood: You are using the existing 'struct can_ctrlmode'.
>
> But this struct looks like this:
>
> struct can_ctrlmode {
>          __u32 mask;
>          __u32 flags;
> };
>
> So 'mask' and 'flags' contain the capability information for the
> supported features according to the table below.
>
> And not 'supported' and 'flags', right?

I think you got confused between the v1~v4 patches and the v5. To
add to the confusion, I forgot to add a changelog to this
patch. Sorry for that.

In the v1~v4, can_ctrlmode::mask is indeed reused to report the
supported ctrlmodes (i.e. can_priv::ctrlmode_supported). In the
v5, can_ctrlmode::mask is kept unchanged meaning that in the
kernel to userland direction, can_ctrlmode::mask is always
zero. Instead, in v5, can_priv::ctrlmode_supported is reported
through a new IFLA entry: IFLA_CAN_CTRLMODE_SUPPORTED.

This v5 is a follow-up of Marc comments:
https://lore.kernel.org/linux-can/20211029124608.u7zbprvojifjpa7j@pengutronix.de/T/#m78118c94072083a6f8d2f0f769b120f847ac1384


> >   supported & flags &         Controller capabilities
> >   CAN_CTRLMODE_*      CAN_CTRLMODE_*
> >   -----------------------------------------------------------------------
> >   false               false           Feature not supported (always disabled)
> >   false               true            Static feature (always enabled)
> >   true                false           Feature supported but disabled
> >   true                true            Feature supported and enabled
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> > I will send a iproute2-next patch right after for those how would like
> > to try this.
> >
> > Hi Marc,
> >
> > Finally, I also implemented the IFLA_CAN_CTRLMODE_EXT solution as you
> > suggested in:
> >
> > https://lore.kernel.org/linux-can/20211029124608.u7zbprvojifjpa7j@pengutronix.de/T/#m78118c94072083a6f8d2f0f769b120f847ac1384
> >
> > I have a small preference with the v4 (reuse struct can_ctrlmode but
> > discard can_ctrlmode::supported in userland when it is zero). But at
> > the end, both the v4 and the v5 seem acceptable to me. So I let you
> > pick the one you prefer.
> >
> >
> > Yours sincerely,
> > Vincent Mailhol
> > ---
> >   drivers/net/can/dev/netlink.c    | 31 ++++++++++++++++++++++++++++++-
> >   include/uapi/linux/can/netlink.h | 13 +++++++++++++
> >   2 files changed, 43 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> > index 26c336808be5..7633d98e3912 100644
> > --- a/drivers/net/can/dev/netlink.c
> > +++ b/drivers/net/can/dev/netlink.c
> > @@ -21,6 +21,7 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
> >       [IFLA_CAN_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
> >       [IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
> >       [IFLA_CAN_TDC] = { .type = NLA_NESTED },
> > +     [IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
> >   };
> >
> >   static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
> > @@ -383,6 +384,12 @@ static size_t can_tdc_get_size(const struct net_device *dev)
> >       return size;
> >   }
> >
> > +static size_t can_ctrlmode_ext_get_size(void)
> > +{
> > +     return nla_total_size(0) +              /* nest IFLA_CAN_CTRLMODE_EXT */
> > +             nla_total_size(sizeof(u32));    /* IFLA_CAN_CTRLMODE_SUPPORTED */
> > +}
> > +
> >   static size_t can_get_size(const struct net_device *dev)
> >   {
> >       struct can_priv *priv = netdev_priv(dev);
> > @@ -415,6 +422,7 @@ static size_t can_get_size(const struct net_device *dev)
> >                                      priv->data_bitrate_const_cnt);
> >       size += sizeof(priv->bitrate_max);                      /* IFLA_CAN_BITRATE_MAX */
> >       size += can_tdc_get_size(dev);                          /* IFLA_CAN_TDC */
> > +     size += can_ctrlmode_ext_get_size();                    /* IFLA_CAN_CTRLMODE_EXT */
> >
> >       return size;
> >   }
> > @@ -472,6 +480,25 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
> >       return -EMSGSIZE;
> >   }
> >
> > +static int can_ctrlmode_ext_fill_info(struct sk_buff *skb,
> > +                                   const struct can_priv *priv)
> > +{
> > +     struct nlattr *nest;
> > +
> > +     nest = nla_nest_start(skb, IFLA_CAN_CTRLMODE_EXT);
> > +     if (!nest)
> > +             return -EMSGSIZE;
> > +
> > +     if (nla_put_u32(skb, IFLA_CAN_CTRLMODE_SUPPORTED,
> > +                     priv->ctrlmode_supported)) {
> > +             nla_nest_cancel(skb, nest);
> > +             return -EMSGSIZE;
> > +     }
> > +
> > +     nla_nest_end(skb, nest);
> > +     return 0;
> > +}
> > +
> >   static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
> >   {
> >       struct can_priv *priv = netdev_priv(dev);
> > @@ -531,7 +558,9 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
> >                    sizeof(priv->bitrate_max),
> >                    &priv->bitrate_max)) ||
> >
> > -         (can_tdc_fill_info(skb, dev))
> > +         can_tdc_fill_info(skb, dev) ||
> > +
> > +         can_ctrlmode_ext_fill_info(skb, priv)
> >           )
> >
> >               return -EMSGSIZE;
> > diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
> > index 75b85c60efb2..02ec32d69474 100644
> > --- a/include/uapi/linux/can/netlink.h
> > +++ b/include/uapi/linux/can/netlink.h
> > @@ -137,6 +137,7 @@ enum {
> >       IFLA_CAN_DATA_BITRATE_CONST,
> >       IFLA_CAN_BITRATE_MAX,
> >       IFLA_CAN_TDC,
> > +     IFLA_CAN_CTRLMODE_EXT,
> >
> >       /* add new constants above here */
> >       __IFLA_CAN_MAX,
> > @@ -166,6 +167,18 @@ enum {
> >       IFLA_CAN_TDC_MAX = __IFLA_CAN_TDC - 1
> >   };
> >
> > +/*
> > + * IFLA_CAN_CTRLMODE_EXT nest: controller mode extended parameters
> > + */
> > +enum {
> > +     IFLA_CAN_CTRLMODE_UNSPEC,
> > +     IFLA_CAN_CTRLMODE_SUPPORTED,    /* u32 */
> > +
> > +     /* add new constants above here */
> > +     __IFLA_CAN_CTRLMODE,
> > +     IFLA_CAN_CTRLMODE_MAX = __IFLA_CAN_CTRLMODE - 1
> > +};
> > +
> >   /* u16 termination range: 1..65535 Ohms */
> >   #define CAN_TERMINATION_DISABLED 0
> >
> >
