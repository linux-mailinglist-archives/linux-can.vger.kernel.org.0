Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C326C2F0512
	for <lists+linux-can@lfdr.de>; Sun, 10 Jan 2021 05:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbhAJE1p (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 9 Jan 2021 23:27:45 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:33612 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbhAJE1o (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 9 Jan 2021 23:27:44 -0500
Received: by mail-yb1-f170.google.com with SMTP id o144so13629701ybc.0
        for <linux-can@vger.kernel.org>; Sat, 09 Jan 2021 20:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U37dLJrDgl6Qw4QgLsMMD+w9qXZl4eRHNeMXB2cPhSM=;
        b=qbTdF62+UW2803fHdL/yBGlurPYKoZ4WbBBbBRSLf+qzpLgsRf/nzAbwQod1Km+yv+
         ROeBv8YKOEVJY9TejT8RF6V+l7zuuLW5ZtM3vvFujVCZK5LhcV7ZSXdv0Nc362hSVjnA
         Mz9Ma6/XsPiqCa9FyKdQU3fgpRdC1A4q8bkRy8na4ft9h9rFs+5VGVtYK2+TrNDiWAe6
         LfwiYr70hVz5utWzJpo/RiSF4IK7b9P9kmlQxvJYcM+XQjDI15KrjeSo38J7Km0DPT0v
         FGw9SFHKco/RQ0szy/uZEtRjje2f/ARBgkl4ENi0QxKUDFYAbFQ8uH8lc9yINdSQF9c1
         D9HQ==
X-Gm-Message-State: AOAM532kTgCFEOJxP0pQSiKf3uxqoBZT12U2jTfcI36bYd2IqRM2ze/0
        oZr6CKyiFU10ll/s9sjT66/oiBLU4nVhxFGzLcw=
X-Google-Smtp-Source: ABdhPJwoaPpOG1TJZ059vYpvBqw6odIHK34vEQt3OWgLdS1lhIMHlfK1t71QFjpR9Sqw0e51TyfBTAeu8HNreBAHRQg=
X-Received: by 2002:a25:f30a:: with SMTP id c10mr15407069ybs.514.1610252821937;
 Sat, 09 Jan 2021 20:27:01 -0800 (PST)
MIME-Version: 1.0
References: <20210109174013.534145-1-mkl@pengutronix.de> <20210109174013.534145-6-mkl@pengutronix.de>
In-Reply-To: <20210109174013.534145-6-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 10 Jan 2021 13:26:50 +0900
Message-ID: <CAMZ6RqKwa7GLc2vTMkZjUqRknR5d7CtGgeA+JQ=dKX1-VZxz+w@mail.gmail.com>
Subject: Re: [net-next 05/13] can: dev: move skb related into seperate file
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun. 10 Jan. 2021 at 02:40, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> This patch moves the skb related code of the CAN device infrastructure into a
> separate file.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/dev/dev.c | 213 ------------------------------------
>  drivers/net/can/dev/skb.c | 220 ++++++++++++++++++++++++++++++++++++++
>  include/linux/can/dev.h   |  76 -------------
>  include/linux/can/skb.h   |  77 +++++++++++++
>  4 files changed, 297 insertions(+), 289 deletions(-)
>  create mode 100644 drivers/net/can/dev/skb.c
>
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 3372e99d5db7..fe71ff9ef8c9 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -132,149 +132,6 @@ void can_change_state(struct net_device *dev, struct can_frame *cf,
>  }
>  EXPORT_SYMBOL_GPL(can_change_state);
>
> -/* Local echo of CAN messages
> - *
> - * CAN network devices *should* support a local echo functionality
> - * (see Documentation/networking/can.rst). To test the handling of CAN
> - * interfaces that do not support the local echo both driver types are
> - * implemented. In the case that the driver does not support the echo
> - * the IFF_ECHO remains clear in dev->flags. This causes the PF_CAN core
> - * to perform the echo as a fallback solution.
> - */
> -static void can_flush_echo_skb(struct net_device *dev)
> -{
> -       struct can_priv *priv = netdev_priv(dev);
> -       struct net_device_stats *stats = &dev->stats;
> -       int i;
> -
> -       for (i = 0; i < priv->echo_skb_max; i++) {
> -               if (priv->echo_skb[i]) {
> -                       kfree_skb(priv->echo_skb[i]);
> -                       priv->echo_skb[i] = NULL;
> -                       stats->tx_dropped++;
> -                       stats->tx_aborted_errors++;
> -               }
> -       }
> -}
> -
> -/* Put the skb on the stack to be looped backed locally lateron
> - *
> - * The function is typically called in the start_xmit function
> - * of the device driver. The driver must protect access to
> - * priv->echo_skb, if necessary.
> - */
> -int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
> -                    unsigned int idx)
> -{
> -       struct can_priv *priv = netdev_priv(dev);
> -
> -       BUG_ON(idx >= priv->echo_skb_max);
> -
> -       /* check flag whether this packet has to be looped back */
> -       if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK ||
> -           (skb->protocol != htons(ETH_P_CAN) &&
> -            skb->protocol != htons(ETH_P_CANFD))) {
> -               kfree_skb(skb);
> -               return 0;
> -       }
> -
> -       if (!priv->echo_skb[idx]) {
> -               skb = can_create_echo_skb(skb);
> -               if (!skb)
> -                       return -ENOMEM;
> -
> -               /* make settings for echo to reduce code in irq context */
> -               skb->pkt_type = PACKET_BROADCAST;
> -               skb->ip_summed = CHECKSUM_UNNECESSARY;
> -               skb->dev = dev;
> -
> -               /* save this skb for tx interrupt echo handling */
> -               priv->echo_skb[idx] = skb;
> -       } else {
> -               /* locking problem with netif_stop_queue() ?? */
> -               netdev_err(dev, "%s: BUG! echo_skb %d is occupied!\n", __func__, idx);
> -               kfree_skb(skb);
> -               return -EBUSY;
> -       }
> -
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(can_put_echo_skb);
> -
> -struct sk_buff *
> -__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
> -{
> -       struct can_priv *priv = netdev_priv(dev);
> -
> -       if (idx >= priv->echo_skb_max) {
> -               netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
> -                          __func__, idx, priv->echo_skb_max);
> -               return NULL;
> -       }
> -
> -       if (priv->echo_skb[idx]) {
> -               /* Using "struct canfd_frame::len" for the frame
> -                * length is supported on both CAN and CANFD frames.
> -                */
> -               struct sk_buff *skb = priv->echo_skb[idx];
> -               struct canfd_frame *cf = (struct canfd_frame *)skb->data;
> -
> -               /* get the real payload length for netdev statistics */
> -               if (cf->can_id & CAN_RTR_FLAG)
> -                       *len_ptr = 0;
> -               else
> -                       *len_ptr = cf->len;
> -
> -               priv->echo_skb[idx] = NULL;
> -
> -               return skb;
> -       }
> -
> -       return NULL;
> -}
> -
> -/* Get the skb from the stack and loop it back locally
> - *
> - * The function is typically called when the TX done interrupt
> - * is handled in the device driver. The driver must protect
> - * access to priv->echo_skb, if necessary.
> - */
> -unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
> -{
> -       struct sk_buff *skb;
> -       u8 len;
> -
> -       skb = __can_get_echo_skb(dev, idx, &len);
> -       if (!skb)
> -               return 0;
> -
> -       skb_get(skb);
> -       if (netif_rx(skb) == NET_RX_SUCCESS)
> -               dev_consume_skb_any(skb);
> -       else
> -               dev_kfree_skb_any(skb);
> -
> -       return len;
> -}
> -EXPORT_SYMBOL_GPL(can_get_echo_skb);
> -
> -/* Remove the skb from the stack and free it.
> - *
> - * The function is typically called when TX failed.
> - */
> -void can_free_echo_skb(struct net_device *dev, unsigned int idx)
> -{
> -       struct can_priv *priv = netdev_priv(dev);
> -
> -       BUG_ON(idx >= priv->echo_skb_max);
> -
> -       if (priv->echo_skb[idx]) {
> -               dev_kfree_skb_any(priv->echo_skb[idx]);
> -               priv->echo_skb[idx] = NULL;
> -       }
> -}
> -EXPORT_SYMBOL_GPL(can_free_echo_skb);
> -
>  /* CAN device restart for bus-off recovery */
>  static void can_restart(struct net_device *dev)
>  {
> @@ -379,76 +236,6 @@ static void can_setup(struct net_device *dev)
>         dev->features = NETIF_F_HW_CSUM;
>  }
>
> -struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
> -{
> -       struct sk_buff *skb;
> -
> -       skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> -                              sizeof(struct can_frame));
> -       if (unlikely(!skb))
> -               return NULL;
> -
> -       skb->protocol = htons(ETH_P_CAN);
> -       skb->pkt_type = PACKET_BROADCAST;
> -       skb->ip_summed = CHECKSUM_UNNECESSARY;
> -
> -       skb_reset_mac_header(skb);
> -       skb_reset_network_header(skb);
> -       skb_reset_transport_header(skb);
> -
> -       can_skb_reserve(skb);
> -       can_skb_prv(skb)->ifindex = dev->ifindex;
> -       can_skb_prv(skb)->skbcnt = 0;
> -
> -       *cf = skb_put_zero(skb, sizeof(struct can_frame));
> -
> -       return skb;
> -}
> -EXPORT_SYMBOL_GPL(alloc_can_skb);
> -
> -struct sk_buff *alloc_canfd_skb(struct net_device *dev,
> -                               struct canfd_frame **cfd)
> -{
> -       struct sk_buff *skb;
> -
> -       skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> -                              sizeof(struct canfd_frame));
> -       if (unlikely(!skb))
> -               return NULL;
> -
> -       skb->protocol = htons(ETH_P_CANFD);
> -       skb->pkt_type = PACKET_BROADCAST;
> -       skb->ip_summed = CHECKSUM_UNNECESSARY;
> -
> -       skb_reset_mac_header(skb);
> -       skb_reset_network_header(skb);
> -       skb_reset_transport_header(skb);
> -
> -       can_skb_reserve(skb);
> -       can_skb_prv(skb)->ifindex = dev->ifindex;
> -       can_skb_prv(skb)->skbcnt = 0;
> -
> -       *cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
> -
> -       return skb;
> -}
> -EXPORT_SYMBOL_GPL(alloc_canfd_skb);
> -
> -struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
> -{
> -       struct sk_buff *skb;
> -
> -       skb = alloc_can_skb(dev, cf);
> -       if (unlikely(!skb))
> -               return NULL;
> -
> -       (*cf)->can_id = CAN_ERR_FLAG;
> -       (*cf)->len = CAN_ERR_DLC;
> -
> -       return skb;
> -}
> -EXPORT_SYMBOL_GPL(alloc_can_err_skb);
> -
>  /* Allocate and setup space for the CAN network device */
>  struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
>                                     unsigned int txqs, unsigned int rxqs)
> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> new file mode 100644
> index 000000000000..26cd597ff771
> --- /dev/null
> +++ b/drivers/net/can/dev/skb.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
> + * Copyright (C) 2006 Andrey Volkov, Varma Electronics
> + * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
> + */
> +
> +#include <linux/can/dev.h>
> +
> +/* Local echo of CAN messages
> + *
> + * CAN network devices *should* support a local echo functionality
> + * (see Documentation/networking/can.rst). To test the handling of CAN
> + * interfaces that do not support the local echo both driver types are
> + * implemented. In the case that the driver does not support the echo
> + * the IFF_ECHO remains clear in dev->flags. This causes the PF_CAN core
> + * to perform the echo as a fallback solution.
> + */
> +void can_flush_echo_skb(struct net_device *dev)
> +{
> +       struct can_priv *priv = netdev_priv(dev);
> +       struct net_device_stats *stats = &dev->stats;
> +       int i;
> +
> +       for (i = 0; i < priv->echo_skb_max; i++) {
> +               if (priv->echo_skb[i]) {
> +                       kfree_skb(priv->echo_skb[i]);
> +                       priv->echo_skb[i] = NULL;
> +                       stats->tx_dropped++;
> +                       stats->tx_aborted_errors++;
> +               }
> +       }
> +}
> +
> +/* Put the skb on the stack to be looped backed locally lateron
> + *
> + * The function is typically called in the start_xmit function
> + * of the device driver. The driver must protect access to
> + * priv->echo_skb, if necessary.
> + */
> +int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
> +                    unsigned int idx)
> +{
> +       struct can_priv *priv = netdev_priv(dev);
> +
> +       BUG_ON(idx >= priv->echo_skb_max);
> +
> +       /* check flag whether this packet has to be looped back */
> +       if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK ||
> +           (skb->protocol != htons(ETH_P_CAN) &&
> +            skb->protocol != htons(ETH_P_CANFD))) {
> +               kfree_skb(skb);
> +               return 0;
> +       }
> +
> +       if (!priv->echo_skb[idx]) {
> +               skb = can_create_echo_skb(skb);
> +               if (!skb)
> +                       return -ENOMEM;
> +
> +               /* make settings for echo to reduce code in irq context */
> +               skb->pkt_type = PACKET_BROADCAST;
> +               skb->ip_summed = CHECKSUM_UNNECESSARY;
> +               skb->dev = dev;
> +
> +               /* save this skb for tx interrupt echo handling */
> +               priv->echo_skb[idx] = skb;
> +       } else {
> +               /* locking problem with netif_stop_queue() ?? */
> +               netdev_err(dev, "%s: BUG! echo_skb %d is occupied!\n", __func__, idx);
> +               kfree_skb(skb);
> +               return -EBUSY;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(can_put_echo_skb);
> +
> +struct sk_buff *
> +__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
> +{
> +       struct can_priv *priv = netdev_priv(dev);
> +
> +       if (idx >= priv->echo_skb_max) {
> +               netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
> +                          __func__, idx, priv->echo_skb_max);
> +               return NULL;
> +       }
> +
> +       if (priv->echo_skb[idx]) {
> +               /* Using "struct canfd_frame::len" for the frame
> +                * length is supported on both CAN and CANFD frames.
> +                */
> +               struct sk_buff *skb = priv->echo_skb[idx];
> +               struct canfd_frame *cf = (struct canfd_frame *)skb->data;
> +
> +               /* get the real payload length for netdev statistics */
> +               if (cf->can_id & CAN_RTR_FLAG)
> +                       *len_ptr = 0;
> +               else
> +                       *len_ptr = cf->len;
> +
> +               priv->echo_skb[idx] = NULL;
> +
> +               return skb;
> +       }
> +
> +       return NULL;
> +}
> +
> +/* Get the skb from the stack and loop it back locally
> + *
> + * The function is typically called when the TX done interrupt
> + * is handled in the device driver. The driver must protect
> + * access to priv->echo_skb, if necessary.
> + */
> +unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
> +{
> +       struct sk_buff *skb;
> +       u8 len;
> +
> +       skb = __can_get_echo_skb(dev, idx, &len);
> +       if (!skb)
> +               return 0;
> +
> +       skb_get(skb);
> +       if (netif_rx(skb) == NET_RX_SUCCESS)
> +               dev_consume_skb_any(skb);
> +       else
> +               dev_kfree_skb_any(skb);
> +
> +       return len;
> +}
> +EXPORT_SYMBOL_GPL(can_get_echo_skb);
> +
> +/* Remove the skb from the stack and free it.
> + *
> + * The function is typically called when TX failed.
> + */
> +void can_free_echo_skb(struct net_device *dev, unsigned int idx)
> +{
> +       struct can_priv *priv = netdev_priv(dev);
> +
> +       BUG_ON(idx >= priv->echo_skb_max);
> +
> +       if (priv->echo_skb[idx]) {
> +               dev_kfree_skb_any(priv->echo_skb[idx]);
> +               priv->echo_skb[idx] = NULL;
> +       }
> +}
> +EXPORT_SYMBOL_GPL(can_free_echo_skb);
> +
> +struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
> +{
> +       struct sk_buff *skb;
> +
> +       skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> +                              sizeof(struct can_frame));
> +       if (unlikely(!skb))
> +               return NULL;
> +
> +       skb->protocol = htons(ETH_P_CAN);
> +       skb->pkt_type = PACKET_BROADCAST;
> +       skb->ip_summed = CHECKSUM_UNNECESSARY;
> +
> +       skb_reset_mac_header(skb);
> +       skb_reset_network_header(skb);
> +       skb_reset_transport_header(skb);
> +
> +       can_skb_reserve(skb);
> +       can_skb_prv(skb)->ifindex = dev->ifindex;
> +       can_skb_prv(skb)->skbcnt = 0;
> +
> +       *cf = skb_put_zero(skb, sizeof(struct can_frame));
> +
> +       return skb;
> +}
> +EXPORT_SYMBOL_GPL(alloc_can_skb);
> +
> +struct sk_buff *alloc_canfd_skb(struct net_device *dev,
> +                               struct canfd_frame **cfd)
> +{
> +       struct sk_buff *skb;
> +
> +       skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> +                              sizeof(struct canfd_frame));
> +       if (unlikely(!skb))
> +               return NULL;
> +
> +       skb->protocol = htons(ETH_P_CANFD);
> +       skb->pkt_type = PACKET_BROADCAST;
> +       skb->ip_summed = CHECKSUM_UNNECESSARY;
> +
> +       skb_reset_mac_header(skb);
> +       skb_reset_network_header(skb);
> +       skb_reset_transport_header(skb);
> +
> +       can_skb_reserve(skb);
> +       can_skb_prv(skb)->ifindex = dev->ifindex;
> +       can_skb_prv(skb)->skbcnt = 0;
> +
> +       *cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
> +
> +       return skb;
> +}
> +EXPORT_SYMBOL_GPL(alloc_canfd_skb);
> +
> +struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
> +{
> +       struct sk_buff *skb;
> +
> +       skb = alloc_can_skb(dev, cf);
> +       if (unlikely(!skb))
> +               return NULL;
> +
> +       (*cf)->can_id = CAN_ERR_FLAG;
> +       (*cf)->len = CAN_ERR_DLC;
> +
> +       return skb;
> +}
> +EXPORT_SYMBOL_GPL(alloc_can_err_skb);
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index d75fba1d030a..4a26e128af7f 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -84,69 +84,6 @@ struct can_priv {
>  #endif
>  };
>
> -/* Check for outgoing skbs that have not been created by the CAN subsystem */
> -static inline bool can_skb_headroom_valid(struct net_device *dev,
> -                                         struct sk_buff *skb)
> -{
> -       /* af_packet creates a headroom of HH_DATA_MOD bytes which is fine */
> -       if (WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct can_skb_priv)))
> -               return false;
> -
> -       /* af_packet does not apply CAN skb specific settings */
> -       if (skb->ip_summed == CHECKSUM_NONE) {
> -               /* init headroom */
> -               can_skb_prv(skb)->ifindex = dev->ifindex;
> -               can_skb_prv(skb)->skbcnt = 0;
> -
> -               skb->ip_summed = CHECKSUM_UNNECESSARY;
> -
> -               /* perform proper loopback on capable devices */
> -               if (dev->flags & IFF_ECHO)
> -                       skb->pkt_type = PACKET_LOOPBACK;
> -               else
> -                       skb->pkt_type = PACKET_HOST;
> -
> -               skb_reset_mac_header(skb);
> -               skb_reset_network_header(skb);
> -               skb_reset_transport_header(skb);
> -       }
> -
> -       return true;
> -}
> -
> -/* Drop a given socketbuffer if it does not contain a valid CAN frame. */
> -static inline bool can_dropped_invalid_skb(struct net_device *dev,
> -                                         struct sk_buff *skb)
> -{
> -       const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> -
> -       if (skb->protocol == htons(ETH_P_CAN)) {
> -               if (unlikely(skb->len != CAN_MTU ||
> -                            cfd->len > CAN_MAX_DLEN))
> -                       goto inval_skb;
> -       } else if (skb->protocol == htons(ETH_P_CANFD)) {
> -               if (unlikely(skb->len != CANFD_MTU ||
> -                            cfd->len > CANFD_MAX_DLEN))
> -                       goto inval_skb;
> -       } else
> -               goto inval_skb;
> -
> -       if (!can_skb_headroom_valid(dev, skb))
> -               goto inval_skb;
> -
> -       return false;
> -
> -inval_skb:
> -       kfree_skb(skb);
> -       dev->stats.tx_dropped++;
> -       return true;
> -}
> -
> -static inline bool can_is_canfd_skb(const struct sk_buff *skb)
> -{
> -       /* the CAN specific type of skb is identified by its data length */
> -       return skb->len == CANFD_MTU;
> -}
>
>  /* helper to define static CAN controller features at device creation time */
>  static inline void can_set_static_ctrlmode(struct net_device *dev,
> @@ -187,23 +124,10 @@ void can_bus_off(struct net_device *dev);
>  void can_change_state(struct net_device *dev, struct can_frame *cf,
>                       enum can_state tx_state, enum can_state rx_state);
>
> -int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
> -                    unsigned int idx);
> -struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx,
> -                                  u8 *len_ptr);
> -unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
> -void can_free_echo_skb(struct net_device *dev, unsigned int idx);
> -
>  #ifdef CONFIG_OF
>  void of_can_transceiver(struct net_device *dev);
>  #else
>  static inline void of_can_transceiver(struct net_device *dev) { }
>  #endif
>
> -struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf);
> -struct sk_buff *alloc_canfd_skb(struct net_device *dev,
> -                               struct canfd_frame **cfd);
> -struct sk_buff *alloc_can_err_skb(struct net_device *dev,
> -                                 struct can_frame **cf);
> -
>  #endif /* !_CAN_DEV_H */
> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index fc61cf4eff1c..c90ebbd3008c 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -16,6 +16,19 @@
>  #include <linux/can.h>
>  #include <net/sock.h>
>
> +void can_flush_echo_skb(struct net_device *dev);
> +int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
> +                    unsigned int idx);
> +struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx,
> +                                  u8 *len_ptr);
> +unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
> +void can_free_echo_skb(struct net_device *dev, unsigned int idx);
> +struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf);
> +struct sk_buff *alloc_canfd_skb(struct net_device *dev,
> +                               struct canfd_frame **cfd);
> +struct sk_buff *alloc_can_err_skb(struct net_device *dev,
> +                                 struct can_frame **cf);
> +
>  /*
>   * The struct can_skb_priv is used to transport additional information along
>   * with the stored struct can(fd)_frame that can not be contained in existing
> @@ -74,4 +87,68 @@ static inline struct sk_buff *can_create_echo_skb(struct sk_buff *skb)
>         return nskb;
>  }
>
> +/* Check for outgoing skbs that have not been created by the CAN subsystem */
> +static inline bool can_skb_headroom_valid(struct net_device *dev,
> +                                         struct sk_buff *skb)
> +{
> +       /* af_packet creates a headroom of HH_DATA_MOD bytes which is fine */
> +       if (WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct can_skb_priv)))
> +               return false;
> +
> +       /* af_packet does not apply CAN skb specific settings */
> +       if (skb->ip_summed == CHECKSUM_NONE) {
> +               /* init headroom */
> +               can_skb_prv(skb)->ifindex = dev->ifindex;
> +               can_skb_prv(skb)->skbcnt = 0;
> +
> +               skb->ip_summed = CHECKSUM_UNNECESSARY;
> +
> +               /* perform proper loopback on capable devices */
> +               if (dev->flags & IFF_ECHO)
> +                       skb->pkt_type = PACKET_LOOPBACK;
> +               else
> +                       skb->pkt_type = PACKET_HOST;
> +
> +               skb_reset_mac_header(skb);
> +               skb_reset_network_header(skb);
> +               skb_reset_transport_header(skb);
> +       }
> +
> +       return true;
> +}
> +
> +/* Drop a given socketbuffer if it does not contain a valid CAN frame. */
> +static inline bool can_dropped_invalid_skb(struct net_device *dev,
> +                                         struct sk_buff *skb)
> +{
> +       const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> +
> +       if (skb->protocol == htons(ETH_P_CAN)) {
> +               if (unlikely(skb->len != CAN_MTU ||
> +                            cfd->len > CAN_MAX_DLEN))
> +                       goto inval_skb;
> +       } else if (skb->protocol == htons(ETH_P_CANFD)) {
> +               if (unlikely(skb->len != CANFD_MTU ||
> +                            cfd->len > CANFD_MAX_DLEN))
> +                       goto inval_skb;
> +       } else
> +               goto inval_skb;
> +
> +       if (!can_skb_headroom_valid(dev, skb))
> +               goto inval_skb;
> +
> +       return false;
> +
> +inval_skb:
> +       kfree_skb(skb);
> +       dev->stats.tx_dropped++;
> +       return true;
> +}
> +
> +static inline bool can_is_canfd_skb(const struct sk_buff *skb)
> +{
> +       /* the CAN specific type of skb is identified by its data length */
> +       return skb->len == CANFD_MTU;
> +}
> +
>  #endif /* !_CAN_SKB_H */
> --
> 2.29.2
>
>

Fails to build. I think you just forgot to include the changes on
drivers/net/can/dev/Makefile (c.f. below).

diff --git a/drivers/net/can/dev/Makefile b/drivers/net/can/dev/Makefile
index 5c647951e06d..2c38bd532157 100644
--- a/drivers/net/can/dev/Makefile
+++ b/drivers/net/can/dev/Makefile
@@ -5,5 +5,6 @@ can-dev-y            += bittiming.o
 can-dev-y            += dev.o
 can-dev-y            += length.o
 can-dev-y            += rx-offload.o
+can-dev-y            += skb.o

 can-dev-$(CONFIG_CAN_LEDS)    += led.o
