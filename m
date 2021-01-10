Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7242F05BE
	for <lists+linux-can@lfdr.de>; Sun, 10 Jan 2021 07:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbhAJGxT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 10 Jan 2021 01:53:19 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:41400 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbhAJGxS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 10 Jan 2021 01:53:18 -0500
Received: by mail-yb1-f170.google.com with SMTP id w127so13732659ybw.8
        for <linux-can@vger.kernel.org>; Sat, 09 Jan 2021 22:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVxOyn6qAxP1zFBsnvRYUHbToP5bQARAbEdE6l8lxtU=;
        b=fQQ19LvsbkleESrxb67I3qzTe/2BqFkGUKnG/oTB2UpIUfO7uYO3bidTdJe3OxCTu6
         r8TRLS82H3z2vLBYwS6dPf+BjK1Xa58twalrp6bxHJYC1i3/OUjW2+7sN9IMUKNMJC6O
         3OBBtn6vzw83bUb2Q9lEGChByQT9LvduNzJi5ae/CL1V1NvY5Yu2kAwXbUC6VJ5/8Yr1
         JvHgA27dfwVGZn1skuHJDBR5GrNNUUHTLqC8j55Q5puEnOXE++QYcUnXYTjB8zSeQYnG
         pgYYdHhbCaqvl96sT7oxaNOFzNZA2NEGZT4JMFya7rWPnCN8mk2M4MSBvomfg0vmKBQo
         XMNQ==
X-Gm-Message-State: AOAM533SbfOtBzGQ/bP7ku6pydgP4aY4DWVuzV4YmbP7d3u2eOkt4xpz
        LbKM5UpQ4kmSIZj18TPxiYskJsvwgWEBCThnZk4=
X-Google-Smtp-Source: ABdhPJw0l4xRcoa6Eado4vIuWoShRVwxo4KOEEGh3/HG7c4MQP3kq5zRgQbTJjUoa8KzSjzPYLhhFKOU6HgH4hwG89c=
X-Received: by 2002:a25:287:: with SMTP id 129mr15490779ybc.145.1610261557240;
 Sat, 09 Jan 2021 22:52:37 -0800 (PST)
MIME-Version: 1.0
References: <20210109174013.534145-1-mkl@pengutronix.de> <20210109174013.534145-12-mkl@pengutronix.de>
In-Reply-To: <20210109174013.534145-12-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 10 Jan 2021 15:52:26 +0900
Message-ID: <CAMZ6RqKfVZ-Z10EK611NZots0Q61bJ6b5TPxSgWAv3nWo0+ryg@mail.gmail.com>
Subject: Re: [net-next 11/13] can: dev: extend struct can_skb_priv to hold CAN
 frame length
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun. 10 Jan 2021 at 02:40, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> In order to implement byte queue limits (bql) in CAN drivers, the length of the
> CAN frame needs to be passed into the networking stack after queueing and after
> transmission completion.
>
> To avoid to calculate this length twice, extend the struct can_skb_priv to hold
> the length of the CAN frame and extend __can_get_echo_skb() to return that
> value.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/dev/rx-offload.c | 2 +-
>  drivers/net/can/dev/skb.c        | 9 +++++++--
>  include/linux/can/skb.h          | 4 +++-
>  3 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
> index 3c1912c0430b..6a26b5282df1 100644
> --- a/drivers/net/can/dev/rx-offload.c
> +++ b/drivers/net/can/dev/rx-offload.c
> @@ -271,7 +271,7 @@ unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
>         u8 len;
>         int err;
>
> -       skb = __can_get_echo_skb(dev, idx, &len);
> +       skb = __can_get_echo_skb(dev, idx, &len, NULL);
>         if (!skb)
>                 return 0;
>
> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 26cd597ff771..24f782a23409 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -76,7 +76,8 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>  EXPORT_SYMBOL_GPL(can_put_echo_skb);
>
>  struct sk_buff *
> -__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
> +__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
> +                  unsigned int *frame_len_ptr)
>  {
>         struct can_priv *priv = netdev_priv(dev);
>
> @@ -91,6 +92,7 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
>                  * length is supported on both CAN and CANFD frames.
>                  */
>                 struct sk_buff *skb = priv->echo_skb[idx];
> +               struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
>                 struct canfd_frame *cf = (struct canfd_frame *)skb->data;
>
>                 /* get the real payload length for netdev statistics */
> @@ -99,6 +101,9 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
>                 else
>                         *len_ptr = cf->len;
>
> +               if (frame_len_ptr)
> +                       *frame_len_ptr = can_skb_priv->frame_len;
> +
>                 priv->echo_skb[idx] = NULL;
>
>                 return skb;
> @@ -118,7 +123,7 @@ unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
>         struct sk_buff *skb;
>         u8 len;
>
> -       skb = __can_get_echo_skb(dev, idx, &len);
> +       skb = __can_get_echo_skb(dev, idx, &len, NULL);
>         if (!skb)
>                 return 0;
>

The can_skb_priv->frame_len is smart. Nice change :)

I have one knit pick concerning the symmetry between
can_put_echo_skb() and can_get_echo_skb().

My current understanding is that:
  * In the tx branch, we need to manually set can_skb_priv->frame_len. Example:
        can_skb_prv(skb)->frame_len = can_skb_get_frame_len(skb);
        can_put_echo_skb(skb, netdev, skb_idx);
  * In the rx branch, it is accessed through the function can_get_echo_skb():
        unsigned int frame_len;
        can_get_echo_skb(skb, netdev, skb_idx, &frame_len);

Please correct me if my understanding is wrong.

I think that you did not modify can_put_echo_skb() so that the
drivers which do not implement the BQL would not have to call
can_skb_get_frame_len(skb) and thus saving computing resources. I
also understand that the motivation to modify can_put_echo_skb()
is to factorise the code.

But the absence of symmetry in the final result bothers me a
bit. Reading manually can_skb_prv(skb)->frame_len by hand would
look as below, which I think is short enough not to be
factorized within can_get_echo_skb():
        struct sk_buff *skb = priv->echo_skb[skb_idx];
        unsigned int frame_len = can_skb_prv(skb)->frame_len;
        can_get_echo_skb(skb, netdev, skb_idx);

So at the end, I would suggest not to modify can_get_echo_skb()
so that it is a better "mirror" of can_put_echo_skb().

> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index c90ebbd3008c..5db9da30843c 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -20,7 +20,7 @@ void can_flush_echo_skb(struct net_device *dev);
>  int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>                      unsigned int idx);
>  struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx,
> -                                  u8 *len_ptr);
> +                                  u8 *len_ptr, unsigned int *frame_len_ptr);
>  unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
>  void can_free_echo_skb(struct net_device *dev, unsigned int idx);
>  struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf);
> @@ -42,11 +42,13 @@ struct sk_buff *alloc_can_err_skb(struct net_device *dev,
>   * struct can_skb_priv - private additional data inside CAN sk_buffs
>   * @ifindex:   ifindex of the first interface the CAN frame appeared on
>   * @skbcnt:    atomic counter to have an unique id together with skb pointer
> + * @frame_len: length of CAN frame in data link layer
>   * @cf:                align to the following CAN frame at skb->data
>   */
>  struct can_skb_priv {
>         int ifindex;
>         int skbcnt;
> +       unsigned int frame_len;
>         struct can_frame cf[];
>  };
>
> --
> 2.29.2
>
>
