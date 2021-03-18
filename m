Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16733402A9
	for <lists+linux-can@lfdr.de>; Thu, 18 Mar 2021 11:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCRKDQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Mar 2021 06:03:16 -0400
Received: from mail-yb1-f170.google.com ([209.85.219.170]:43068 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhCRKDM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Mar 2021 06:03:12 -0400
Received: by mail-yb1-f170.google.com with SMTP id u75so1924753ybi.10
        for <linux-can@vger.kernel.org>; Thu, 18 Mar 2021 03:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ysxm+f3DcM/Jk5RY2cdHDBr6MjC8CH1FDRB72v4sZWE=;
        b=WERPDWu4A/dBMQhd46FGoZv3X7ZaUsz/Qk6Bzop27Qbpnsm0Y+piWxeCQAUbgoQkBg
         FfFQ4iF86rKfWOZjjPq23Vf6lvWHQo7PAZ1PtsGvTeelkNDi8itCYMGp4sqY0kOVrbDz
         RGllVpArPp+2Tq+alTCtkHtOgPS4OVB2Fv0U9GggM2Rla58DFZ0QmGocToaJKggB7x+r
         +uENqWk30KLdBrxFtsCPIz9GxV2HJ9k6WYcYYkTM2rh7ydp8W5fIsUFaSgeK55JlCKax
         APttbvQ4veRmUcO9vNz4FNktWcjcH0pLOtqz4MeBRWOLuE3ETAEFCFe8wPsPGdIL0CiE
         b2LA==
X-Gm-Message-State: AOAM530lQgGAfn2oIgy9ugtPU1Tl5zmflMcfQyyYfopepVM946NhzEyw
        MT+YSlhhFRlJZ5pKes6l9d4DLQV9shbBw1pKFITs4k4ezGRGJg==
X-Google-Smtp-Source: ABdhPJzzMNhqraQECaVzzTu70tHIWfPgXG68E2O/U0tSMC9QD7OPgzmEHuNdSO+T/ZpHBSnU0knZLWET3+umF5MdvsI=
X-Received: by 2002:a05:6902:4b2:: with SMTP id r18mr10694938ybs.226.1616061791301;
 Thu, 18 Mar 2021 03:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210309211904.3348700-1-mkl@pengutronix.de>
In-Reply-To: <20210309211904.3348700-1-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 18 Mar 2021 19:03:00 +0900
Message-ID: <CAMZ6Rq+QNj6ajmTyqtZt0HnJjg95Y_Ud-eokhZj9AvN1dPpRYg@mail.gmail.com>
Subject: Re: [PATCH can-next] can: dev: always create TX echo skb
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Wed. 10 Mar 2021 at 06:19, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> So far the creation of the TX echo skb was optional and can be
> controlled by the local sender of a CAN frame.
>
> It turns out that the TX echo CAN skb can be piggybacked to carry
> information in the driver from the TX- to the TX-complete handler.
>
> Several drivers already use the return value of
> can_get_echo_skb() (which is the length of the data field in the CAN
> frame) for their number of transferred bytes statistics. The
> statistics are not working if CAN echo skbs are disabled.
>
> Another use case is to calculate and set the CAN frame length on the
> wire, which is needed for BQL support in both the TX and TX-completion
> handler.
>
> For now in can_put_echo_skb(), which is called from the TX handler,
> the skb carrying the CAN frame is discarded if no TX echo is
> requested, leading to the above illustrated problems.
>
> This patch changes the can_put_echo_skb() function, so that the echo
> skb is always generated. If the sender requests no echo, the echo skb
> is consumed in __can_get_echo_skb() without being passed into the RX
> handler of the networking stack, but the CAN data length and CAN frame
> length information is properly returned.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/dev/skb.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 6a64fe410987..22b0472a5fad 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -45,7 +45,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>         BUG_ON(idx >= priv->echo_skb_max);
>
>         /* check flag whether this packet has to be looped back */
> -       if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK ||
> +       if (!(dev->flags & IFF_ECHO) ||
>             (skb->protocol != htons(ETH_P_CAN) &&
>              skb->protocol != htons(ETH_P_CANFD))) {
>                 kfree_skb(skb);
> @@ -58,7 +58,6 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>                         return -ENOMEM;
>
>                 /* make settings for echo to reduce code in irq context */
> -               skb->pkt_type = PACKET_BROADCAST;
>                 skb->ip_summed = CHECKSUM_UNNECESSARY;
>                 skb->dev = dev;
>
> @@ -111,6 +110,13 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
>
>                 priv->echo_skb[idx] = NULL;
>
> +               if (skb->pkt_type == PACKET_LOOPBACK) {
> +                       skb->pkt_type = PACKET_BROADCAST;
> +               } else {
> +                       dev_consume_skb_any(skb);
> +                       return NULL;
> +               }
> +
>                 return skb;
>         }

I do see any particular issues on this patch at the moment,
however, while looking at the TX echo functionality, it reminded
me of a point which has always been a bit unclear to me: the
CAN_CTRLMODE_LOOPBACK. So let me go a bit off topic.

Like all other controller's mode, I would expect the
CAN_CTRLMODE_LOOPBACK flag to do two things:
  - Announce that the device is capable of doing loopback
  - Control this feature (enable/disable it)

But, by default, this flag is set to 0 unless the user
explicitly passes the "loopback on" argument when configuring
the device.

So isn't this supposed to be an issue for all the drivers which
expect to get a TX loopback in order to trigger the TX completion
handler?

Personally, for my driver, I would like to use the
can_set_static_ctrlmode() to force CAN_CTRLMODE_LOOPBACK so that
I do not need a different TX completion logic when
CAN_CTRLMODE_LOOPBACK is off.

The issue is that because CAN_CTRLMODE_LOOPBACK is per default
off, doing:
  can_set_static_ctrlmode(netdev, CAN_CTRLMODE_LOOPBACK);
would lead to a
  RTNETLINK answers: Operation not supported
when configuring the device unless "loopback on" is explicitly
passed on the command line.

At the moment, I have the feeling that many drivers just ignore
the value of this flag and activate the loopback regardless.

Do you think that it would make sense to set
CAN_CTRLMODE_LOOPBACK by default to on?


Yours sincerely,
Vincent
