Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4192C2F7D72
	for <lists+linux-can@lfdr.de>; Fri, 15 Jan 2021 15:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732816AbhAOOAr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Jan 2021 09:00:47 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:33079 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732697AbhAOOAr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Jan 2021 09:00:47 -0500
Received: by mail-yb1-f174.google.com with SMTP id o144so5129278ybc.0
        for <linux-can@vger.kernel.org>; Fri, 15 Jan 2021 06:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1cpG50O47ZMVauExlGS5GqxgQg/3AKAPDMvbbHTz50=;
        b=Nq0L4HYa/8NxhFWbialwJWgrfkTTd6FFy1JwNcdX/2Sgdg4jlHI6/vOfqJr4DGlGLa
         CYiHlJ1tZ+rlYwUYO8fvxHlgf6oNF5czMO8h+MQUBp4wx8GkaPycvGfKaz/18LNZLz5F
         AxhmpmgEdPAcyxcJbZciQoqONwzmgF+yozNNuVrB9DhpTsE+iMDgxXNNrYypjNQyc8Gq
         DrRdLR0/ghIO/jZ2vKmWyCdjDHeKP+stx/aIcL7rDuVp2Kib56WkU0oBWn2amEV6gmrY
         hYXj8X3PH6AUuRFmTh5blZSAgs8GgUg0A/6GteQqRaplVo45W+6SV7ZKDkWWWB4Ii2ea
         EsHA==
X-Gm-Message-State: AOAM532pWW9OVpoWTibFwnqRhvNzK9NGjGYwVzBsdm/kYlCW8J8Mtm7f
        8KDAmbrcxaog3IO1G35HnJAllK+Pt8lNeqOd1J8=
X-Google-Smtp-Source: ABdhPJxXAllFS1gvLN6zAQSpmOqCv24vy4dDgxzTaYYS7iqehFeCSpAaf4pQO4sL+qsRRuvXuRNyVQLYuE3h2bZOqio=
X-Received: by 2002:a25:f30a:: with SMTP id c10mr17668395ybs.514.1610719205375;
 Fri, 15 Jan 2021 06:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20210112130538.14912-1-mailhol.vincent@wanadoo.fr>
 <20210112130538.14912-2-mailhol.vincent@wanadoo.fr> <981eb251-1573-5852-4b16-2e207eb3c4da@hartkopp.net>
 <CAMZ6RqKeGVsF+CcqoAWC7JXEo2oLTS5E5B3Jk4oeiF9XWEC3Sw@mail.gmail.com>
 <3daf39cb-2835-379d-86df-91b17282594a@pengutronix.de> <47a39992-2368-1403-e55c-3bee4793b91c@hartkopp.net>
 <7b41612e-6c99-a713-5285-a044402066bd@pengutronix.de>
In-Reply-To: <7b41612e-6c99-a713-5285-a044402066bd@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 15 Jan 2021 22:59:54 +0900
Message-ID: <CAMZ6RqLFLtcGQsnRLPF8VD4=OhSArM3HVT_2MNG-9HVBuPMV=Q@mail.gmail.com>
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

On Fri. 15 Jan 2021 at 22:44, Marc Kleine-Budde <mkl@pengutronix.de> wrote
> On 1/15/21 2:01 PM, Oliver Hartkopp wrote:
> > -DaveM
> > -JacubK
> > -netdev
> >
> > @Vincent: No need for cross posting and putting the networking
> > maintainers in CC for these really deep CAN driver specific topics IHMO

I just used to include whatever was listed by
scripts/get_maintainer.pl

Noted and thanks for the hint, I will be more careful in the
future on who I include.

> > On 15.01.21 08:26, Marc Kleine-Budde wrote:
> >> On 1/15/21 1:41 AM, Vincent MAILHOL wrote:
> >>> On Fri. 15 Jan 2021 at 02:23, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >>>>
> >>>> Hi Vincent,
> >>>>
> >>>> On 12.01.21 14:05, Vincent Mailhol wrote:
> >>>>> This driver supports the ES581.4, ES582.1 and ES584.1 interfaces from
> >>>>> ETAS GmbH (https://www.etas.com/en/products/es58x.php).
> >>>>
> >>>> (..)
> >>>>
> >>>>> diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
> >>>>> new file mode 100644
> >>>>> index 000000000000..6b9534f23c96
> >>>>> --- /dev/null
> >>>>> +++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
> >>>>
> >>>> (..)
> >>>>
> >>>>> +static void es58x_fd_print_bittiming(struct net_device *netdev,
> >>>>> +                                  struct es58x_fd_bittiming
> >>>>> +                                  *es58x_fd_bittiming, char *type)
> >>>>> +{
> >>>>> +     netdev_vdbg(netdev, "bitrate %s    = %d\n", type,
> >>>>> +                 le32_to_cpu(es58x_fd_bittiming->bitrate));
> >>>>> +     netdev_vdbg(netdev, "tseg1 %s      = %d\n", type,
> >>>>> +                 le16_to_cpu(es58x_fd_bittiming->tseg1));
> >>>>> +     netdev_vdbg(netdev, "tseg2 %s      = %d\n", type,
> >>>>> +                 le16_to_cpu(es58x_fd_bittiming->tseg2));
> >>>>> +     netdev_vdbg(netdev, "brp %s        = %d\n", type,
> >>>>> +                 le16_to_cpu(es58x_fd_bittiming->brp));
> >>>>> +     netdev_vdbg(netdev, "sjw %s        = %d\n", type,
> >>>>> +                 le16_to_cpu(es58x_fd_bittiming->sjw));
> >>>>> +}
> >>>>
> >>>> What is the reason for this code?
> >>>>
> >>>> These values can be retrieved with the 'ip' tool and are probably
> >>>> interesting for development - but not in the final code.
> >>>
> >>> First thing, I used netdev_vdbg() (verbose debug). That macro
> >>> will only produce code if VERBOSE_DEBUG is defined. Normal users
> >>> will not see those. So yes, this is mostly for development.
> >>>
> >>> Also, just realised that netdev_vdbg() is barely used
> >>> anywhere (only three files use it:
> >>> https://elixir.bootlin.com/linux/v5.11-rc3/C/ident/netdev_vdbg).
> >>>
> >>> I guess that I will remove it :)
> >>>
> >
> > Thanks! That will remove some more code in the background too.
> >
> >>>>> +
> >>>>> +static void es58x_fd_print_conf(struct net_device *netdev,
> >>>>> +                             struct es58x_fd_tx_conf_msg *tx_conf_msg)
> >>>>> +{
> >>>>> +     es58x_fd_print_bittiming(netdev, &tx_conf_msg->nominal_bittiming,
> >>>>> +                              "nominal");
> >>>>> +     netdev_vdbg(netdev, "samples_per_bit    = %d\n",
> >>>>> +                 tx_conf_msg->samples_per_bit);
> >>>>> +     netdev_vdbg(netdev, "sync_edge          = %d\n",
> >>>>> +                 tx_conf_msg->sync_edge);
> >>>>> +     netdev_vdbg(netdev, "physical_layer     = %d\n",
> >>>>> +                 tx_conf_msg->physical_layer);
> >>>>> +     netdev_vdbg(netdev, "self_reception     = %d\n",
> >>>>> +                 tx_conf_msg->self_reception_mode);
> >>>>> +     netdev_vdbg(netdev, "ctrlmode           = %d\n", tx_conf_msg->ctrlmode);
> >>>>> +     netdev_vdbg(netdev, "canfd_enabled      = %d\n",
> >>>>> +                 tx_conf_msg->canfd_enabled);
> >>>>> +     if (tx_conf_msg->canfd_enabled) {
> >>>>> +             es58x_fd_print_bittiming(netdev,
> >>>>> +                                      &tx_conf_msg->data_bittiming, "data");
> >>>>> +             netdev_vdbg(netdev,
> >>>>> +                         "Transmitter Delay Compensation        = %d\n",
> >>>>> +                         tx_conf_msg->tdc);
> >>>>> +             netdev_vdbg(netdev,
> >>>>> +                         "Transmitter Delay Compensation Offset = %d\n",
> >>>>> +                         le16_to_cpu(tx_conf_msg->tdco));
> >>>>> +             netdev_vdbg(netdev,
> >>>>> +                         "Transmitter Delay Compensation Filter = %d\n",
> >>>>> +                         le16_to_cpu(tx_conf_msg->tdcf));
> >>>>> +     }
> >>>>> +}
> >>>>
> >>>> Same here.
> >>>>
> >>>> Either the information can be retrieved with the 'ip' tool OR the are
> >>>> not necessary as set to some reasonable default anyway
> >>>
> >>> Ack, will remove.
> >>>
> >>>> OR we should
> >>>> implement the functionality in the general CAN driver infrastructure.
> >>>
> >>> Would make sense to me to add the tdco (Transmitter Delay
> >>> Compensation Offset). Ref: ISO 11898-1 section
> >>> 11.3.3 "Transmitter delay compensation"
> >>>
> >>> I would just like your opinion on one topic: the tdco is specific
> >>> to CAN FD. If we add it, we have two choices:
> >>>    1. put it in struct can_bittiming: that will mean that we will
> >>>       have an unused field for classical CAN (field bittiming of
> >>>       struct can_priv).
> >>>    2. put it in struct can_priv (but outside of struct
> >>>       can_bittiming): no unused field but less pretty.
> >>
> >> 3. Deprecate struct can_bittiming as the user space interface
> >>     and transfer each member individually via netlink. Extend
> >>     the kernel-only can_bittiming by the tdc related
> >>     parameters, and add these to the new netlink interface.

Wow, didn't see that third option coming!

By "extend the kernel-only can_bittiming by the tdc related
parameters" do you mean to still use a single struct
can_bittiming for classical CAN and CAN FD with the tdc
parameters in both (a bit like what I suggested in 1.)?


Yours sincerely,
Vincent

> > I also saw the current netlink interface as the problem here.
> >
> > But even when 'deprecating' the old interface we still need to provide
> > the API, right?
>
> ACK
>
> > Would therefore the new parameters overwrite the content which is
> > transferred by can_bittiming or how would you like to make sure the
> > mixed content remains consistent?
>
> For my use case the API is extended and should not contain conflicting data. I
> think it's 3 steps to convert the kernel (where the 2.* and the 3.* have to be
> done atomically):
>
> 1.
> Introduce a new struct can_bittiming_kernel_const, with tseg1_{min,max} replaced
> by prop_seg_{min,max} and phase_seg1_{min,max}.
>
> 2.1.
> Convert drivers to  use new struct can_bittiming_kernel_const.
>
> 2.2.
> Convert existing CAN-netlink interface to translate between old usersapce struct
> can_bittiming_const and new struct can_bittiming_kernel_const:
>
> new -> old:
> > old->phase_seg1_{min,max} = new->prop_seg_{min,max} + phase_seg1_{min,max}
>
> old -> new:
> > new->prop_seg_{min,max} = old->tseg1_{min,max} / 2;
> > new->phase_seg1_{min,max} = old->tseg1_{min,max} - new->prop_seg;
>
> 3.1.
> Add new netlink parsing that works with struct can_bittiming_kernel_const
>
> 3.2.
> Add netlink validity check, so that either old or new API is used in a single
> netlink call.
>
>
> >> I prefer this, as I want to extend the bittiming_const in this way, too. There
> >> are CAN controllers, where the bit timing calculation:
> >>
> >>>     bt->prop_seg = tseg1 / 2;
> >>>     bt->phase_seg1 = tseg1 - bt->prop_seg;
> >>
> >> doesn't work anymore, as they have asymmetric prog_seg and phase_seg1, so that
> >> splitting tseg1 in half doesn't work anymore.
> >
> > Interesting.
>
> The flexcan driver works around the problem this way:
>
> >       /* CBT[EPSEG1] is 5 bit long and CBT[EPROPSEG] is 6 bit
> >        * long. The can_calc_bittiming() tries to divide the tseg1
> >        * equally between phase_seg1 and prop_seg, which may not fit
> >        * in CBT register. Therefore, if phase_seg1 is more than
> >        * possible value, increase prop_seg and decrease phase_seg1.
> >        */
> >       if (bt->phase_seg1 > 0x20) {
> >               bt->prop_seg += (bt->phase_seg1 - 0x20);
> >               bt->phase_seg1 = 0x20;
> >       }
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
