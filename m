Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF8D57A16C
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 16:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiGSO0g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 10:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiGSO0P (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 10:26:15 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF36E48CA7
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:11:31 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id c131so25963246ybf.9
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZ9ahWTBsO+dJBLGpKk36xcXl5vC3x3j/HcrD6L/Epo=;
        b=EIpoDWEjYhW3itAVjRDt2yOIXL20C+3dWvW463hLZXkTVmFlOOemwKtnMs5npxkgsr
         QSEMdm/5m2eDlOOzMFntpXf52cjt2ZrvnxZfnmT/7S0rBtCgRDZ4rVaSeHRqqxISm3Go
         B7Eon45NKsjP3oPmIzORB4FSYlv8ENw9oLeAEKhYHP18xh4EJdavCgkvXvUHVoL2/pQh
         XG6Cwf4Xdm9qR42l8C0+KeOK/MtaVRRLmJgb0XgN7rPq7rhs3qW64AC/vf/R8pOrK7zx
         wSVKjfphstQXNkCeWx8wfy9tq5xeyqfTlaqsqeCAeyCHWov+dk/Zi4U98P3H9dcmDqwn
         VJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZ9ahWTBsO+dJBLGpKk36xcXl5vC3x3j/HcrD6L/Epo=;
        b=7mTjxOmUVlsDZYiCLWVBmLEHAxXDlaGL9ylQS9A4jZIRv/GswhTv4OIYxe0vM1UVgn
         rCFfH9WF4SNN/1mM4mjzJXatVOfMHNwHxDpuM/qYy0Fcb52gBb6PttjDCaI2WocJLhQ8
         4T11BspxTxhMyJhq6ev0X/uY/ICZIEIb4XZb9W1YiPTdRHsdkPd5FzWb9nbd6i+kLYXq
         U+aTAEgXXtKa46jGvO2BneefgmxpVqgYQBxL6Y7gfL/MMdGz32AGWbxSI/5/iFa5ldAo
         cYCfxP/zGBZZmkZZR9YW6/2jXHn24Etv/mTG8ciMUJYjydktoyKi+QpA30X1b/Kb/rmD
         qGGA==
X-Gm-Message-State: AJIora8FSXSqqIVGxpr5vbBMXG2lXnpoDrCkzNlosrLZHpaQs2IdQBbB
        UwxjDH8NkZa+M5RLDuE9GqbkxPv1qNFoL4prSz5Nsgknh1I=
X-Google-Smtp-Source: AGRyM1sThygwpXWWipHzLAx3CE9u+/Trpinj7R3Y6znUMmgQNScc3xGC9hvJ2xNqdUaXG4l/MRaliBJ6EMGEKtpm//Y=
X-Received: by 2002:a25:20c5:0:b0:66f:f7d9:94eb with SMTP id
 g188-20020a2520c5000000b0066ff7d994ebmr18623675ybg.500.1658239890893; Tue, 19
 Jul 2022 07:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220719112748.3281-1-socketcan@hartkopp.net> <20220719112748.3281-4-socketcan@hartkopp.net>
In-Reply-To: <20220719112748.3281-4-socketcan@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Tue, 19 Jul 2022 23:11:20 +0900
Message-ID: <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 19 Jul. 2022, 20:44, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Extend the CAN device driver infrastructure to handle CAN XL frames.
> This especially addresses the increased data length which is extended
> to uint16 for CAN XL.
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev/rx-offload.c |  2 +-
>  drivers/net/can/dev/skb.c        | 49 ++++++++++++++++++++++++++------
>  include/linux/can/skb.h          |  5 +++-
>  3 files changed, 45 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
> index a32a01c172d4..8505e547e922 100644
> --- a/drivers/net/can/dev/rx-offload.c
> +++ b/drivers/net/can/dev/rx-offload.c
> @@ -245,11 +245,11 @@ unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
>                                          unsigned int *frame_len_ptr)
>  {
>         struct net_device *dev = offload->dev;
>         struct net_device_stats *stats = &dev->stats;
>         struct sk_buff *skb;
> -       u8 len;
> +       unsigned int len;
>         int err;
>
>         skb = __can_get_echo_skb(dev, idx, &len, frame_len_ptr);
>         if (!skb)
>                 return 0;
> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 8bb62dd864c8..8531e0c39d1c 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -53,11 +53,12 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>         BUG_ON(idx >= priv->echo_skb_max);
>
>         /* check flag whether this packet has to be looped back */
>         if (!(dev->flags & IFF_ECHO) ||
>             (skb->protocol != htons(ETH_P_CAN) &&
> -            skb->protocol != htons(ETH_P_CANFD))) {
> +            skb->protocol != htons(ETH_P_CANFD) &&
> +            skb->protocol != htons(ETH_P_CANXL))) {
>                 kfree_skb(skb);
>                 return 0;
>         }
>
>         if (!priv->echo_skb[idx]) {
> @@ -86,12 +87,12 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(can_put_echo_skb);
>
>  struct sk_buff *
> -__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
> -                  unsigned int *frame_len_ptr)
> +__can_get_echo_skb(struct net_device *dev, unsigned int idx,
> +                  unsigned int *len_ptr, unsigned int *frame_len_ptr)
>  {
>         struct can_priv *priv = netdev_priv(dev);
>
>         if (idx >= priv->echo_skb_max) {
>                 netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
> @@ -103,17 +104,13 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
>                 /* Using "struct canfd_frame::len" for the frame
>                  * length is supported on both CAN and CANFD frames.
>                  */
>                 struct sk_buff *skb = priv->echo_skb[idx];
>                 struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
> -               struct canfd_frame *cf = (struct canfd_frame *)skb->data;
>
>                 /* get the real payload length for netdev statistics */
> -               if (cf->can_id & CAN_RTR_FLAG)
> -                       *len_ptr = 0;
> -               else
> -                       *len_ptr = cf->len;
> +               *len_ptr = can_skb_get_data_len(skb);
>
>                 if (frame_len_ptr)
>                         *frame_len_ptr = can_skb_priv->frame_len;
>
>                 priv->echo_skb[idx] = NULL;
> @@ -139,11 +136,11 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
>   */
>  unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx,
>                               unsigned int *frame_len_ptr)
>  {
>         struct sk_buff *skb;
> -       u8 len;
> +       unsigned int len;
>
>         skb = __can_get_echo_skb(dev, idx, &len, frame_len_ptr);
>         if (!skb)
>                 return 0;
>
> @@ -244,10 +241,41 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
>
>         return skb;
>  }
>  EXPORT_SYMBOL_GPL(alloc_canfd_skb);
>
> +struct sk_buff *alloc_canxl_skb(struct net_device *dev,
> +                               struct canxl_frame **cfx)
> +{
> +       struct sk_buff *skb;
> +
> +       skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> +                              sizeof(struct canxl_frame));

I am confused. In this message:
https://lore.kernel.org/linux-can/3dcc85f8-2c02-dfe5-de23-d022f3fc56be@hartkopp.net/
you said that you "vote for selecting the 'truncated' option only"
(which is OK with me). But here, you are allocating the full size. If
we always want truncated frames, shouldn't we allocate the exact size
frame length here?

> +       if (unlikely(!skb)) {
> +               *cfx = NULL;
> +
> +               return NULL;
> +       }
> +
> +       skb->protocol = htons(ETH_P_CANXL);
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
> +       *cfx = skb_put_zero(skb, sizeof(struct canxl_frame));
> +
> +       return skb;
> +}
> +EXPORT_SYMBOL_GPL(alloc_canxl_skb);
> +
>  struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
>  {
>         struct sk_buff *skb;
>
>         skb = alloc_can_skb(dev, cf);
> @@ -302,10 +330,13 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
>                         goto inval_skb;
>         } else if (skb->protocol == htons(ETH_P_CANFD)) {
>                 if (unlikely(skb->len != CANFD_MTU ||
>                              cfd->len > CANFD_MAX_DLEN))
>                         goto inval_skb;
> +       } else if (skb->protocol == htons(ETH_P_CANXL)) {

Nitpick but with the growing list, I would see a switch
(skb->protocol) rather than the cascade of if.

> +               if (unlikely(!can_is_canxl_skb(skb)))
> +                       goto inval_skb;
>         } else {

default:

>                 goto inval_skb;
>         }
>
>         if (!can_skb_headroom_valid(dev, skb)) {
> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index 51481f5afe62..9972c9bd73bc 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -18,19 +18,22 @@
>
>  void can_flush_echo_skb(struct net_device *dev);
>  int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>                      unsigned int idx, unsigned int frame_len);
>  struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx,
> -                                  u8 *len_ptr, unsigned int *frame_len_ptr);
> +                                  unsigned int *len_ptr,
> +                                  unsigned int *frame_len_ptr);
>  unsigned int __must_check can_get_echo_skb(struct net_device *dev,
>                                            unsigned int idx,
>                                            unsigned int *frame_len_ptr);
>  void can_free_echo_skb(struct net_device *dev, unsigned int idx,
>                        unsigned int *frame_len_ptr);
>  struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf);
>  struct sk_buff *alloc_canfd_skb(struct net_device *dev,
>                                 struct canfd_frame **cfd);
> +struct sk_buff *alloc_canxl_skb(struct net_device *dev,
> +                               struct canxl_frame **cfx);
>  struct sk_buff *alloc_can_err_skb(struct net_device *dev,
>                                   struct can_frame **cf);
>  bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb);

Yours sincerely,
Vincent Mailhol
