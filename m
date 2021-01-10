Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF422F0513
	for <lists+linux-can@lfdr.de>; Sun, 10 Jan 2021 05:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbhAJE15 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Sat, 9 Jan 2021 23:27:57 -0500
Received: from mail-yb1-f177.google.com ([209.85.219.177]:35938 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbhAJE15 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 9 Jan 2021 23:27:57 -0500
Received: by mail-yb1-f177.google.com with SMTP id y4so13602101ybn.3
        for <linux-can@vger.kernel.org>; Sat, 09 Jan 2021 20:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pN3JA2+m18y+ibS4E+/PlMGOXJCErqZ4kjHZ4e+NRWc=;
        b=H+ZBKOlkZjxG08J+Pa4yDcpFBuFRfzkpTTsA6nsqHUIWZZ0rPaKpf/nR4jq71nc9bh
         Hdm/xCJKdYDicGFLXX2SYFvjvne+tRelIF04auFWnVGQ1w7nw34yPY6x02ZnuFfoeesK
         bB+fO8G6NtDXzG6NKEAO6dHNZzTT/oMBhVa+v3//UiicYdJqNKlLOBMxoVtzIy/IAWkz
         A7u9aFbZaytK5/VGcVGJzHk+jyxW2ccznBYGmH7mIe+XC49W9BJ8x3U+90oe2dAKgcDl
         Ukc8D137p6SvyLd6gF9/78SGnv0FTJH2uVoWX7P+XTTH7soD/HUGgigkmp5VKmhxyP3d
         veVA==
X-Gm-Message-State: AOAM531Ul/6JeexpHpoHbl4bxM/ztlHYuERIRfbqxOaxMJv5XCwiOJb6
        YV+kyWJJtMtIao22mj8brcRY+Irrq+p4UpcBqXs=
X-Google-Smtp-Source: ABdhPJyE6chULvJpbY1ZkNiN/yRD5rM4M6e0CYyqfOc9aK7839yDjVmf5eDxjKnlbV75OR2HV6dZeBpVuB+lobpAqks=
X-Received: by 2002:a25:7c05:: with SMTP id x5mr16301553ybc.487.1610252835380;
 Sat, 09 Jan 2021 20:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20210109174013.534145-1-mkl@pengutronix.de> <20210109174013.534145-7-mkl@pengutronix.de>
In-Reply-To: <20210109174013.534145-7-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 10 Jan 2021 13:27:04 +0900
Message-ID: <CAMZ6RqJYXqG_v+g-iGBBsUJg7n_apHUJGCJpbteDnbFmbBk2XA@mail.gmail.com>
Subject: Re: [net-next 06/13] can: dev: move netlink related code into
 seperate file
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Le dim. 10 janv. 2021 à 02:40, Marc Kleine-Budde <mkl@pengutronix.de> a écrit :
>
> This patch moves the netlink related code of the CAN device infrastructure into
> a separate file.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/dev/dev.c     | 370 +--------------------------------
>  drivers/net/can/dev/netlink.c | 379 ++++++++++++++++++++++++++++++++++
>  include/linux/can/dev.h       |   6 +
>  3 files changed, 388 insertions(+), 367 deletions(-)
>  create mode 100644 drivers/net/can/dev/netlink.c
>
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index fe71ff9ef8c9..f580f0ac6497 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -14,10 +14,8 @@
>  #include <linux/can/can-ml.h>
>  #include <linux/can/dev.h>
>  #include <linux/can/skb.h>
> -#include <linux/can/netlink.h>
>  #include <linux/can/led.h>
>  #include <linux/of.h>
> -#include <net/rtnetlink.h>
>
>  #define MOD_DESC "CAN device driver interface"
>
> @@ -223,7 +221,7 @@ void can_bus_off(struct net_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(can_bus_off);
>
> -static void can_setup(struct net_device *dev)
> +void can_setup(struct net_device *dev)
>  {
>         dev->type = ARPHRD_CAN;
>         dev->mtu = CAN_MTU;
> @@ -399,368 +397,6 @@ void close_candev(struct net_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(close_candev);
>
> -/* CAN netlink interface */
> -static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
> -       [IFLA_CAN_STATE]        = { .type = NLA_U32 },
> -       [IFLA_CAN_CTRLMODE]     = { .len = sizeof(struct can_ctrlmode) },
> -       [IFLA_CAN_RESTART_MS]   = { .type = NLA_U32 },
> -       [IFLA_CAN_RESTART]      = { .type = NLA_U32 },
> -       [IFLA_CAN_BITTIMING]    = { .len = sizeof(struct can_bittiming) },
> -       [IFLA_CAN_BITTIMING_CONST]
> -                               = { .len = sizeof(struct can_bittiming_const) },
> -       [IFLA_CAN_CLOCK]        = { .len = sizeof(struct can_clock) },
> -       [IFLA_CAN_BERR_COUNTER] = { .len = sizeof(struct can_berr_counter) },
> -       [IFLA_CAN_DATA_BITTIMING]
> -                               = { .len = sizeof(struct can_bittiming) },
> -       [IFLA_CAN_DATA_BITTIMING_CONST]
> -                               = { .len = sizeof(struct can_bittiming_const) },
> -       [IFLA_CAN_TERMINATION]  = { .type = NLA_U16 },
> -};
> -
> -static int can_validate(struct nlattr *tb[], struct nlattr *data[],
> -                       struct netlink_ext_ack *extack)
> -{
> -       bool is_can_fd = false;
> -
> -       /* Make sure that valid CAN FD configurations always consist of
> -        * - nominal/arbitration bittiming
> -        * - data bittiming
> -        * - control mode with CAN_CTRLMODE_FD set
> -        */
> -
> -       if (!data)
> -               return 0;
> -
> -       if (data[IFLA_CAN_CTRLMODE]) {
> -               struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
> -
> -               is_can_fd = cm->flags & cm->mask & CAN_CTRLMODE_FD;
> -       }
> -
> -       if (is_can_fd) {
> -               if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
> -                       return -EOPNOTSUPP;
> -       }
> -
> -       if (data[IFLA_CAN_DATA_BITTIMING]) {
> -               if (!is_can_fd || !data[IFLA_CAN_BITTIMING])
> -                       return -EOPNOTSUPP;
> -       }
> -
> -       return 0;
> -}
> -
> -static int can_changelink(struct net_device *dev, struct nlattr *tb[],
> -                         struct nlattr *data[],
> -                         struct netlink_ext_ack *extack)
> -{
> -       struct can_priv *priv = netdev_priv(dev);
> -       int err;
> -
> -       /* We need synchronization with dev->stop() */
> -       ASSERT_RTNL();
> -
> -       if (data[IFLA_CAN_BITTIMING]) {
> -               struct can_bittiming bt;
> -
> -               /* Do not allow changing bittiming while running */
> -               if (dev->flags & IFF_UP)
> -                       return -EBUSY;
> -
> -               /* Calculate bittiming parameters based on
> -                * bittiming_const if set, otherwise pass bitrate
> -                * directly via do_set_bitrate(). Bail out if neither
> -                * is given.
> -                */
> -               if (!priv->bittiming_const && !priv->do_set_bittiming)
> -                       return -EOPNOTSUPP;
> -
> -               memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
> -               err = can_get_bittiming(dev, &bt,
> -                                       priv->bittiming_const,
> -                                       priv->bitrate_const,
> -                                       priv->bitrate_const_cnt);
> -               if (err)
> -                       return err;
> -
> -               if (priv->bitrate_max && bt.bitrate > priv->bitrate_max) {
> -                       netdev_err(dev, "arbitration bitrate surpasses transceiver capabilities of %d bps\n",
> -                                  priv->bitrate_max);
> -                       return -EINVAL;
> -               }
> -
> -               memcpy(&priv->bittiming, &bt, sizeof(bt));
> -
> -               if (priv->do_set_bittiming) {
> -                       /* Finally, set the bit-timing registers */
> -                       err = priv->do_set_bittiming(dev);
> -                       if (err)
> -                               return err;
> -               }
> -       }
> -
> -       if (data[IFLA_CAN_CTRLMODE]) {
> -               struct can_ctrlmode *cm;
> -               u32 ctrlstatic;
> -               u32 maskedflags;
> -
> -               /* Do not allow changing controller mode while running */
> -               if (dev->flags & IFF_UP)
> -                       return -EBUSY;
> -               cm = nla_data(data[IFLA_CAN_CTRLMODE]);
> -               ctrlstatic = priv->ctrlmode_static;
> -               maskedflags = cm->flags & cm->mask;
> -
> -               /* check whether provided bits are allowed to be passed */
> -               if (cm->mask & ~(priv->ctrlmode_supported | ctrlstatic))
> -                       return -EOPNOTSUPP;
> -
> -               /* do not check for static fd-non-iso if 'fd' is disabled */
> -               if (!(maskedflags & CAN_CTRLMODE_FD))
> -                       ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
> -
> -               /* make sure static options are provided by configuration */
> -               if ((maskedflags & ctrlstatic) != ctrlstatic)
> -                       return -EOPNOTSUPP;
> -
> -               /* clear bits to be modified and copy the flag values */
> -               priv->ctrlmode &= ~cm->mask;
> -               priv->ctrlmode |= maskedflags;
> -
> -               /* CAN_CTRLMODE_FD can only be set when driver supports FD */
> -               if (priv->ctrlmode & CAN_CTRLMODE_FD)
> -                       dev->mtu = CANFD_MTU;
> -               else
> -                       dev->mtu = CAN_MTU;
> -       }
> -
> -       if (data[IFLA_CAN_RESTART_MS]) {
> -               /* Do not allow changing restart delay while running */
> -               if (dev->flags & IFF_UP)
> -                       return -EBUSY;
> -               priv->restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
> -       }
> -
> -       if (data[IFLA_CAN_RESTART]) {
> -               /* Do not allow a restart while not running */
> -               if (!(dev->flags & IFF_UP))
> -                       return -EINVAL;
> -               err = can_restart_now(dev);
> -               if (err)
> -                       return err;
> -       }
> -
> -       if (data[IFLA_CAN_DATA_BITTIMING]) {
> -               struct can_bittiming dbt;
> -
> -               /* Do not allow changing bittiming while running */
> -               if (dev->flags & IFF_UP)
> -                       return -EBUSY;
> -
> -               /* Calculate bittiming parameters based on
> -                * data_bittiming_const if set, otherwise pass bitrate
> -                * directly via do_set_bitrate(). Bail out if neither
> -                * is given.
> -                */
> -               if (!priv->data_bittiming_const && !priv->do_set_data_bittiming)
> -                       return -EOPNOTSUPP;
> -
> -               memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
> -                      sizeof(dbt));
> -               err = can_get_bittiming(dev, &dbt,
> -                                       priv->data_bittiming_const,
> -                                       priv->data_bitrate_const,
> -                                       priv->data_bitrate_const_cnt);
> -               if (err)
> -                       return err;
> -
> -               if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
> -                       netdev_err(dev, "canfd data bitrate surpasses transceiver capabilities of %d bps\n",
> -                                  priv->bitrate_max);
> -                       return -EINVAL;
> -               }
> -
> -               memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
> -
> -               if (priv->do_set_data_bittiming) {
> -                       /* Finally, set the bit-timing registers */
> -                       err = priv->do_set_data_bittiming(dev);
> -                       if (err)
> -                               return err;
> -               }
> -       }
> -
> -       if (data[IFLA_CAN_TERMINATION]) {
> -               const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
> -               const unsigned int num_term = priv->termination_const_cnt;
> -               unsigned int i;
> -
> -               if (!priv->do_set_termination)
> -                       return -EOPNOTSUPP;
> -
> -               /* check whether given value is supported by the interface */
> -               for (i = 0; i < num_term; i++) {
> -                       if (termval == priv->termination_const[i])
> -                               break;
> -               }
> -               if (i >= num_term)
> -                       return -EINVAL;
> -
> -               /* Finally, set the termination value */
> -               err = priv->do_set_termination(dev, termval);
> -               if (err)
> -                       return err;
> -
> -               priv->termination = termval;
> -       }
> -
> -       return 0;
> -}
> -
> -static size_t can_get_size(const struct net_device *dev)
> -{
> -       struct can_priv *priv = netdev_priv(dev);
> -       size_t size = 0;
> -
> -       if (priv->bittiming.bitrate)                            /* IFLA_CAN_BITTIMING */
> -               size += nla_total_size(sizeof(struct can_bittiming));
> -       if (priv->bittiming_const)                              /* IFLA_CAN_BITTIMING_CONST */
> -               size += nla_total_size(sizeof(struct can_bittiming_const));
> -       size += nla_total_size(sizeof(struct can_clock));       /* IFLA_CAN_CLOCK */
> -       size += nla_total_size(sizeof(u32));                    /* IFLA_CAN_STATE */
> -       size += nla_total_size(sizeof(struct can_ctrlmode));    /* IFLA_CAN_CTRLMODE */
> -       size += nla_total_size(sizeof(u32));                    /* IFLA_CAN_RESTART_MS */
> -       if (priv->do_get_berr_counter)                          /* IFLA_CAN_BERR_COUNTER */
> -               size += nla_total_size(sizeof(struct can_berr_counter));
> -       if (priv->data_bittiming.bitrate)                       /* IFLA_CAN_DATA_BITTIMING */
> -               size += nla_total_size(sizeof(struct can_bittiming));
> -       if (priv->data_bittiming_const)                         /* IFLA_CAN_DATA_BITTIMING_CONST */
> -               size += nla_total_size(sizeof(struct can_bittiming_const));
> -       if (priv->termination_const) {
> -               size += nla_total_size(sizeof(priv->termination));              /* IFLA_CAN_TERMINATION */
> -               size += nla_total_size(sizeof(*priv->termination_const) *       /* IFLA_CAN_TERMINATION_CONST */
> -                                      priv->termination_const_cnt);
> -       }
> -       if (priv->bitrate_const)                                /* IFLA_CAN_BITRATE_CONST */
> -               size += nla_total_size(sizeof(*priv->bitrate_const) *
> -                                      priv->bitrate_const_cnt);
> -       if (priv->data_bitrate_const)                           /* IFLA_CAN_DATA_BITRATE_CONST */
> -               size += nla_total_size(sizeof(*priv->data_bitrate_const) *
> -                                      priv->data_bitrate_const_cnt);
> -       size += sizeof(priv->bitrate_max);                      /* IFLA_CAN_BITRATE_MAX */
> -
> -       return size;
> -}
> -
> -static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
> -{
> -       struct can_priv *priv = netdev_priv(dev);
> -       struct can_ctrlmode cm = {.flags = priv->ctrlmode};
> -       struct can_berr_counter bec;
> -       enum can_state state = priv->state;
> -
> -       if (priv->do_get_state)
> -               priv->do_get_state(dev, &state);
> -
> -       if ((priv->bittiming.bitrate &&
> -            nla_put(skb, IFLA_CAN_BITTIMING,
> -                    sizeof(priv->bittiming), &priv->bittiming)) ||
> -
> -           (priv->bittiming_const &&
> -            nla_put(skb, IFLA_CAN_BITTIMING_CONST,
> -                    sizeof(*priv->bittiming_const), priv->bittiming_const)) ||
> -
> -           nla_put(skb, IFLA_CAN_CLOCK, sizeof(priv->clock), &priv->clock) ||
> -           nla_put_u32(skb, IFLA_CAN_STATE, state) ||
> -           nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
> -           nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
> -
> -           (priv->do_get_berr_counter &&
> -            !priv->do_get_berr_counter(dev, &bec) &&
> -            nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
> -
> -           (priv->data_bittiming.bitrate &&
> -            nla_put(skb, IFLA_CAN_DATA_BITTIMING,
> -                    sizeof(priv->data_bittiming), &priv->data_bittiming)) ||
> -
> -           (priv->data_bittiming_const &&
> -            nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
> -                    sizeof(*priv->data_bittiming_const),
> -                    priv->data_bittiming_const)) ||
> -
> -           (priv->termination_const &&
> -            (nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination) ||
> -             nla_put(skb, IFLA_CAN_TERMINATION_CONST,
> -                     sizeof(*priv->termination_const) *
> -                     priv->termination_const_cnt,
> -                     priv->termination_const))) ||
> -
> -           (priv->bitrate_const &&
> -            nla_put(skb, IFLA_CAN_BITRATE_CONST,
> -                    sizeof(*priv->bitrate_const) *
> -                    priv->bitrate_const_cnt,
> -                    priv->bitrate_const)) ||
> -
> -           (priv->data_bitrate_const &&
> -            nla_put(skb, IFLA_CAN_DATA_BITRATE_CONST,
> -                    sizeof(*priv->data_bitrate_const) *
> -                    priv->data_bitrate_const_cnt,
> -                    priv->data_bitrate_const)) ||
> -
> -           (nla_put(skb, IFLA_CAN_BITRATE_MAX,
> -                    sizeof(priv->bitrate_max),
> -                    &priv->bitrate_max))
> -           )
> -
> -               return -EMSGSIZE;
> -
> -       return 0;
> -}
> -
> -static size_t can_get_xstats_size(const struct net_device *dev)
> -{
> -       return sizeof(struct can_device_stats);
> -}
> -
> -static int can_fill_xstats(struct sk_buff *skb, const struct net_device *dev)
> -{
> -       struct can_priv *priv = netdev_priv(dev);
> -
> -       if (nla_put(skb, IFLA_INFO_XSTATS,
> -                   sizeof(priv->can_stats), &priv->can_stats))
> -               goto nla_put_failure;
> -       return 0;
> -
> -nla_put_failure:
> -       return -EMSGSIZE;
> -}
> -
> -static int can_newlink(struct net *src_net, struct net_device *dev,
> -                      struct nlattr *tb[], struct nlattr *data[],
> -                      struct netlink_ext_ack *extack)
> -{
> -       return -EOPNOTSUPP;
> -}
> -
> -static void can_dellink(struct net_device *dev, struct list_head *head)
> -{
> -}
> -
> -static struct rtnl_link_ops can_link_ops __read_mostly = {
> -       .kind           = "can",
> -       .maxtype        = IFLA_CAN_MAX,
> -       .policy         = can_policy,
> -       .setup          = can_setup,
> -       .validate       = can_validate,
> -       .newlink        = can_newlink,
> -       .changelink     = can_changelink,
> -       .dellink        = can_dellink,
> -       .get_size       = can_get_size,
> -       .fill_info      = can_fill_info,
> -       .get_xstats_size = can_get_xstats_size,
> -       .fill_xstats    = can_fill_xstats,
> -};
> -
>  /* Register the CAN network device */
>  int register_candev(struct net_device *dev)
>  {
> @@ -812,7 +448,7 @@ static __init int can_dev_init(void)
>
>         can_led_notifier_init();
>
> -       err = rtnl_link_register(&can_link_ops);
> +       err = can_netlink_register();
>         if (!err)
>                 pr_info(MOD_DESC "\n");
>
> @@ -822,7 +458,7 @@ module_init(can_dev_init);
>
>  static __exit void can_dev_exit(void)
>  {
> -       rtnl_link_unregister(&can_link_ops);
> +       can_netlink_unregister();
>
>         can_led_notifier_exit();
>  }
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> new file mode 100644
> index 000000000000..3ae884cdf677
> --- /dev/null
> +++ b/drivers/net/can/dev/netlink.c
> @@ -0,0 +1,379 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
> + * Copyright (C) 2006 Andrey Volkov, Varma Electronics
> + * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
> + */
> +
> +#include <linux/can/dev.h>
> +#include <net/rtnetlink.h>
> +
> +static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
> +       [IFLA_CAN_STATE]        = { .type = NLA_U32 },
> +       [IFLA_CAN_CTRLMODE]     = { .len = sizeof(struct can_ctrlmode) },
> +       [IFLA_CAN_RESTART_MS]   = { .type = NLA_U32 },
> +       [IFLA_CAN_RESTART]      = { .type = NLA_U32 },
> +       [IFLA_CAN_BITTIMING]    = { .len = sizeof(struct can_bittiming) },
> +       [IFLA_CAN_BITTIMING_CONST]
> +                               = { .len = sizeof(struct can_bittiming_const) },
> +       [IFLA_CAN_CLOCK]        = { .len = sizeof(struct can_clock) },
> +       [IFLA_CAN_BERR_COUNTER] = { .len = sizeof(struct can_berr_counter) },
> +       [IFLA_CAN_DATA_BITTIMING]
> +                               = { .len = sizeof(struct can_bittiming) },
> +       [IFLA_CAN_DATA_BITTIMING_CONST]
> +                               = { .len = sizeof(struct can_bittiming_const) },
> +       [IFLA_CAN_TERMINATION]  = { .type = NLA_U16 },
> +};
> +
> +static int can_validate(struct nlattr *tb[], struct nlattr *data[],
> +                       struct netlink_ext_ack *extack)
> +{
> +       bool is_can_fd = false;
> +
> +       /* Make sure that valid CAN FD configurations always consist of
> +        * - nominal/arbitration bittiming
> +        * - data bittiming
> +        * - control mode with CAN_CTRLMODE_FD set
> +        */
> +
> +       if (!data)
> +               return 0;
> +
> +       if (data[IFLA_CAN_CTRLMODE]) {
> +               struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
> +
> +               is_can_fd = cm->flags & cm->mask & CAN_CTRLMODE_FD;
> +       }
> +
> +       if (is_can_fd) {
> +               if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
> +                       return -EOPNOTSUPP;
> +       }
> +
> +       if (data[IFLA_CAN_DATA_BITTIMING]) {
> +               if (!is_can_fd || !data[IFLA_CAN_BITTIMING])
> +                       return -EOPNOTSUPP;
> +       }
> +
> +       return 0;
> +}
> +
> +static int can_changelink(struct net_device *dev, struct nlattr *tb[],
> +                         struct nlattr *data[],
> +                         struct netlink_ext_ack *extack)
> +{
> +       struct can_priv *priv = netdev_priv(dev);
> +       int err;
> +
> +       /* We need synchronization with dev->stop() */
> +       ASSERT_RTNL();
> +
> +       if (data[IFLA_CAN_BITTIMING]) {
> +               struct can_bittiming bt;
> +
> +               /* Do not allow changing bittiming while running */
> +               if (dev->flags & IFF_UP)
> +                       return -EBUSY;
> +
> +               /* Calculate bittiming parameters based on
> +                * bittiming_const if set, otherwise pass bitrate
> +                * directly via do_set_bitrate(). Bail out if neither
> +                * is given.
> +                */
> +               if (!priv->bittiming_const && !priv->do_set_bittiming)
> +                       return -EOPNOTSUPP;
> +
> +               memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
> +               err = can_get_bittiming(dev, &bt,
> +                                       priv->bittiming_const,
> +                                       priv->bitrate_const,
> +                                       priv->bitrate_const_cnt);
> +               if (err)
> +                       return err;
> +
> +               if (priv->bitrate_max && bt.bitrate > priv->bitrate_max) {
> +                       netdev_err(dev, "arbitration bitrate surpasses transceiver capabilities of %d bps\n",
> +                                  priv->bitrate_max);
> +                       return -EINVAL;
> +               }
> +
> +               memcpy(&priv->bittiming, &bt, sizeof(bt));
> +
> +               if (priv->do_set_bittiming) {
> +                       /* Finally, set the bit-timing registers */
> +                       err = priv->do_set_bittiming(dev);
> +                       if (err)
> +                               return err;
> +               }
> +       }
> +
> +       if (data[IFLA_CAN_CTRLMODE]) {
> +               struct can_ctrlmode *cm;
> +               u32 ctrlstatic;
> +               u32 maskedflags;
> +
> +               /* Do not allow changing controller mode while running */
> +               if (dev->flags & IFF_UP)
> +                       return -EBUSY;
> +               cm = nla_data(data[IFLA_CAN_CTRLMODE]);
> +               ctrlstatic = priv->ctrlmode_static;
> +               maskedflags = cm->flags & cm->mask;
> +
> +               /* check whether provided bits are allowed to be passed */
> +               if (cm->mask & ~(priv->ctrlmode_supported | ctrlstatic))
> +                       return -EOPNOTSUPP;
> +
> +               /* do not check for static fd-non-iso if 'fd' is disabled */
> +               if (!(maskedflags & CAN_CTRLMODE_FD))
> +                       ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
> +
> +               /* make sure static options are provided by configuration */
> +               if ((maskedflags & ctrlstatic) != ctrlstatic)
> +                       return -EOPNOTSUPP;
> +
> +               /* clear bits to be modified and copy the flag values */
> +               priv->ctrlmode &= ~cm->mask;
> +               priv->ctrlmode |= maskedflags;
> +
> +               /* CAN_CTRLMODE_FD can only be set when driver supports FD */
> +               if (priv->ctrlmode & CAN_CTRLMODE_FD)
> +                       dev->mtu = CANFD_MTU;
> +               else
> +                       dev->mtu = CAN_MTU;
> +       }
> +
> +       if (data[IFLA_CAN_RESTART_MS]) {
> +               /* Do not allow changing restart delay while running */
> +               if (dev->flags & IFF_UP)
> +                       return -EBUSY;
> +               priv->restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
> +       }
> +
> +       if (data[IFLA_CAN_RESTART]) {
> +               /* Do not allow a restart while not running */
> +               if (!(dev->flags & IFF_UP))
> +                       return -EINVAL;
> +               err = can_restart_now(dev);
> +               if (err)
> +                       return err;
> +       }
> +
> +       if (data[IFLA_CAN_DATA_BITTIMING]) {
> +               struct can_bittiming dbt;
> +
> +               /* Do not allow changing bittiming while running */
> +               if (dev->flags & IFF_UP)
> +                       return -EBUSY;
> +
> +               /* Calculate bittiming parameters based on
> +                * data_bittiming_const if set, otherwise pass bitrate
> +                * directly via do_set_bitrate(). Bail out if neither
> +                * is given.
> +                */
> +               if (!priv->data_bittiming_const && !priv->do_set_data_bittiming)
> +                       return -EOPNOTSUPP;
> +
> +               memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
> +                      sizeof(dbt));
> +               err = can_get_bittiming(dev, &dbt,
> +                                       priv->data_bittiming_const,
> +                                       priv->data_bitrate_const,
> +                                       priv->data_bitrate_const_cnt);
> +               if (err)
> +                       return err;
> +
> +               if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
> +                       netdev_err(dev, "canfd data bitrate surpasses transceiver capabilities of %d bps\n",
> +                                  priv->bitrate_max);
> +                       return -EINVAL;
> +               }
> +
> +               memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
> +
> +               if (priv->do_set_data_bittiming) {
> +                       /* Finally, set the bit-timing registers */
> +                       err = priv->do_set_data_bittiming(dev);
> +                       if (err)
> +                               return err;
> +               }
> +       }
> +
> +       if (data[IFLA_CAN_TERMINATION]) {
> +               const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
> +               const unsigned int num_term = priv->termination_const_cnt;
> +               unsigned int i;
> +
> +               if (!priv->do_set_termination)
> +                       return -EOPNOTSUPP;
> +
> +               /* check whether given value is supported by the interface */
> +               for (i = 0; i < num_term; i++) {
> +                       if (termval == priv->termination_const[i])
> +                               break;
> +               }
> +               if (i >= num_term)
> +                       return -EINVAL;
> +
> +               /* Finally, set the termination value */
> +               err = priv->do_set_termination(dev, termval);
> +               if (err)
> +                       return err;
> +
> +               priv->termination = termval;
> +       }
> +
> +       return 0;
> +}
> +
> +static size_t can_get_size(const struct net_device *dev)
> +{
> +       struct can_priv *priv = netdev_priv(dev);
> +       size_t size = 0;
> +
> +       if (priv->bittiming.bitrate)                            /* IFLA_CAN_BITTIMING */
> +               size += nla_total_size(sizeof(struct can_bittiming));
> +       if (priv->bittiming_const)                              /* IFLA_CAN_BITTIMING_CONST */
> +               size += nla_total_size(sizeof(struct can_bittiming_const));
> +       size += nla_total_size(sizeof(struct can_clock));       /* IFLA_CAN_CLOCK */
> +       size += nla_total_size(sizeof(u32));                    /* IFLA_CAN_STATE */
> +       size += nla_total_size(sizeof(struct can_ctrlmode));    /* IFLA_CAN_CTRLMODE */
> +       size += nla_total_size(sizeof(u32));                    /* IFLA_CAN_RESTART_MS */
> +       if (priv->do_get_berr_counter)                          /* IFLA_CAN_BERR_COUNTER */
> +               size += nla_total_size(sizeof(struct can_berr_counter));
> +       if (priv->data_bittiming.bitrate)                       /* IFLA_CAN_DATA_BITTIMING */
> +               size += nla_total_size(sizeof(struct can_bittiming));
> +       if (priv->data_bittiming_const)                         /* IFLA_CAN_DATA_BITTIMING_CONST */
> +               size += nla_total_size(sizeof(struct can_bittiming_const));
> +       if (priv->termination_const) {
> +               size += nla_total_size(sizeof(priv->termination));              /* IFLA_CAN_TERMINATION */
> +               size += nla_total_size(sizeof(*priv->termination_const) *       /* IFLA_CAN_TERMINATION_CONST */
> +                                      priv->termination_const_cnt);
> +       }
> +       if (priv->bitrate_const)                                /* IFLA_CAN_BITRATE_CONST */
> +               size += nla_total_size(sizeof(*priv->bitrate_const) *
> +                                      priv->bitrate_const_cnt);
> +       if (priv->data_bitrate_const)                           /* IFLA_CAN_DATA_BITRATE_CONST */
> +               size += nla_total_size(sizeof(*priv->data_bitrate_const) *
> +                                      priv->data_bitrate_const_cnt);
> +       size += sizeof(priv->bitrate_max);                      /* IFLA_CAN_BITRATE_MAX */
> +
> +       return size;
> +}
> +
> +static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
> +{
> +       struct can_priv *priv = netdev_priv(dev);
> +       struct can_ctrlmode cm = {.flags = priv->ctrlmode};
> +       struct can_berr_counter bec;
> +       enum can_state state = priv->state;
> +
> +       if (priv->do_get_state)
> +               priv->do_get_state(dev, &state);
> +
> +       if ((priv->bittiming.bitrate &&
> +            nla_put(skb, IFLA_CAN_BITTIMING,
> +                    sizeof(priv->bittiming), &priv->bittiming)) ||
> +
> +           (priv->bittiming_const &&
> +            nla_put(skb, IFLA_CAN_BITTIMING_CONST,
> +                    sizeof(*priv->bittiming_const), priv->bittiming_const)) ||
> +
> +           nla_put(skb, IFLA_CAN_CLOCK, sizeof(priv->clock), &priv->clock) ||
> +           nla_put_u32(skb, IFLA_CAN_STATE, state) ||
> +           nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
> +           nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
> +
> +           (priv->do_get_berr_counter &&
> +            !priv->do_get_berr_counter(dev, &bec) &&
> +            nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
> +
> +           (priv->data_bittiming.bitrate &&
> +            nla_put(skb, IFLA_CAN_DATA_BITTIMING,
> +                    sizeof(priv->data_bittiming), &priv->data_bittiming)) ||
> +
> +           (priv->data_bittiming_const &&
> +            nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
> +                    sizeof(*priv->data_bittiming_const),
> +                    priv->data_bittiming_const)) ||
> +
> +           (priv->termination_const &&
> +            (nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination) ||
> +             nla_put(skb, IFLA_CAN_TERMINATION_CONST,
> +                     sizeof(*priv->termination_const) *
> +                     priv->termination_const_cnt,
> +                     priv->termination_const))) ||
> +
> +           (priv->bitrate_const &&
> +            nla_put(skb, IFLA_CAN_BITRATE_CONST,
> +                    sizeof(*priv->bitrate_const) *
> +                    priv->bitrate_const_cnt,
> +                    priv->bitrate_const)) ||
> +
> +           (priv->data_bitrate_const &&
> +            nla_put(skb, IFLA_CAN_DATA_BITRATE_CONST,
> +                    sizeof(*priv->data_bitrate_const) *
> +                    priv->data_bitrate_const_cnt,
> +                    priv->data_bitrate_const)) ||
> +
> +           (nla_put(skb, IFLA_CAN_BITRATE_MAX,
> +                    sizeof(priv->bitrate_max),
> +                    &priv->bitrate_max))
> +           )
> +
> +               return -EMSGSIZE;
> +
> +       return 0;
> +}
> +
> +static size_t can_get_xstats_size(const struct net_device *dev)
> +{
> +       return sizeof(struct can_device_stats);
> +}
> +
> +static int can_fill_xstats(struct sk_buff *skb, const struct net_device *dev)
> +{
> +       struct can_priv *priv = netdev_priv(dev);
> +
> +       if (nla_put(skb, IFLA_INFO_XSTATS,
> +                   sizeof(priv->can_stats), &priv->can_stats))
> +               goto nla_put_failure;
> +       return 0;
> +
> +nla_put_failure:
> +       return -EMSGSIZE;
> +}
> +
> +static int can_newlink(struct net *src_net, struct net_device *dev,
> +                      struct nlattr *tb[], struct nlattr *data[],
> +                      struct netlink_ext_ack *extack)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static void can_dellink(struct net_device *dev, struct list_head *head)
> +{
> +}
> +
> +struct rtnl_link_ops can_link_ops __read_mostly = {
> +       .kind           = "can",
> +       .maxtype        = IFLA_CAN_MAX,
> +       .policy         = can_policy,
> +       .setup          = can_setup,
> +       .validate       = can_validate,
> +       .newlink        = can_newlink,
> +       .changelink     = can_changelink,
> +       .dellink        = can_dellink,
> +       .get_size       = can_get_size,
> +       .fill_info      = can_fill_info,
> +       .get_xstats_size = can_get_xstats_size,
> +       .fill_xstats    = can_fill_xstats,
> +};
> +
> +int can_netlink_register(void)
> +{
> +       return rtnl_link_register(&can_link_ops);
> +}
> +
> +void can_netlink_unregister(void)
> +{
> +       rtnl_link_unregister(&can_link_ops);
> +}
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 4a26e128af7f..7faf6a37d5b2 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -100,6 +100,8 @@ static inline void can_set_static_ctrlmode(struct net_device *dev,
>                 dev->mtu = CANFD_MTU;
>  }
>
> +void can_setup(struct net_device *dev);
> +
>  struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
>                                     unsigned int txqs, unsigned int rxqs);
>  #define alloc_candev(sizeof_priv, echo_skb_max) \
> @@ -130,4 +132,8 @@ void of_can_transceiver(struct net_device *dev);
>  static inline void of_can_transceiver(struct net_device *dev) { }
>  #endif
>
> +extern struct rtnl_link_ops can_link_ops;
> +int can_netlink_register(void);
> +void can_netlink_unregister(void);
> +
>  #endif /* !_CAN_DEV_H */
> --
> 2.29.2
>
>

Same as previous message but for netlink: fails to build. I think
you just forgot to include the changes on
drivers/net/can/dev/Makefile (c.f. below).

diff --git a/drivers/net/can/dev/Makefile b/drivers/net/can/dev/Makefile
index 2c38bd532157..6624be65de6f 100644
--- a/drivers/net/can/dev/Makefile
+++ b/drivers/net/can/dev/Makefile
@@ -6,5 +6,6 @@ can-dev-y            += dev.o
 can-dev-y            += length.o
 can-dev-y            += rx-offload.o
 can-dev-y            += skb.o
+can-dev-y            += netlink.o

 can-dev-$(CONFIG_CAN_LEDS)    += led.o
