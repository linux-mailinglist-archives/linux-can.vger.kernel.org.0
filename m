Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97665570F65
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 03:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiGLBXO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jul 2022 21:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiGLBXN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jul 2022 21:23:13 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D0E61104
        for <linux-can@vger.kernel.org>; Mon, 11 Jul 2022 18:23:12 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31c89111f23so66892707b3.0
        for <linux-can@vger.kernel.org>; Mon, 11 Jul 2022 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7j79fnT7jrx5rCO81584ca+BMEJ4Jm6+OU/QwzFlkA=;
        b=VjCCnc0S7BBx2S5TDgRODqf8kDQSAUoolHYyvKbiwvQnCdNn/LeKjy6p9/mi31Ti+P
         pYJr2DgRhdXHhY0aNVj8HqxEfrWmVeV9lyLz+9VKL8yhMsTtFLjTI+O03QvR9v04u/ID
         EIawg3paX5i7jIJh3Ry7RjUqLHye9B+BCLMK13phiWuZH235qxtL3uVWJKrr179Cg3CV
         5NapYB7gEfncjpEFFuOgsPZoMTeQpYs7981d+KSI0kIf6KJ46muwh3ptAXpNALVE1/4P
         FuEDXeQNb72m/Jyo7U52HxV4RYR48HO3PAiAL5kW152RbkyYmBCH26I2LwnM3g1Kdydm
         at+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7j79fnT7jrx5rCO81584ca+BMEJ4Jm6+OU/QwzFlkA=;
        b=YqFshYoQVBKoBJqEJnUqhAyBrGqHOcOM9l2eAOqoHNRh88gNqrd9jRzLDwwtihPEXV
         7xRB+IFzDOi9xD1GGpjpZHXAe3bi+796ZP8Z7Vmqu5raBg5E8ELDghU9UO3+oeZd5faf
         XMUdTrOLv4xtoOrAi/625QQ4DfrCWrzFvAJsEtXXcwM7Fg6T1abI51tAy3nRCdcyR+n+
         06v4KPooMvmuQuXVoR3UUwBTVNxpf9bPq1LUIhskRDDXknnHZJlqFzFrnI//9bg+LJG/
         nQ+3w3UODV7cpVKdHcVula/ITIa0fcaFuVvqoal1E4nwyIBcH6h2qAeamBC6AyYMR+pn
         bjNw==
X-Gm-Message-State: AJIora9yyBan3iNWmzGRZ8rXhT1VJcWT6M8npoN6jNaC6LwpolNOQcW+
        vPlZ0x7Q8KsGSnX6A1iaZYjdIbK1kTM4skg9VqeEnVSMjZ4=
X-Google-Smtp-Source: AGRyM1swNZsjhMeHvJK4s1hUyyjQJF94TpODcO2V/4unDteQa/3waPrl4c3bQM6brDNAJX49qUvhG4/ujcL77EJeDcs=
X-Received: by 2002:a81:1990:0:b0:31d:7686:5f6a with SMTP id
 138-20020a811990000000b0031d76865f6amr9363972ywz.45.1657588991830; Mon, 11
 Jul 2022 18:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220711183426.96446-1-socketcan@hartkopp.net> <20220711183426.96446-3-socketcan@hartkopp.net>
In-Reply-To: <20220711183426.96446-3-socketcan@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Tue, 12 Jul 2022 10:23:24 +0900
Message-ID: <CAMZ6Rq+jNEyknCWPCqPa8xEuBFdKeLBOUKmCC=pf0wZL+EG0-A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] can: canxl: introduce ETH_P_CANXL ethernet
 protocol handling
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 12 Jul. 2022 at 03:44, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Enable the PF_CAN infrastructure to handle CAN XL frames. A new ethernet
> protocol type ETH_P_CANXL is defined to tag skbuffs containing the CAN XL
> frame data structure.
>
> As the length information is now a uint16 value for CAN XL a new helper
> function can_get_data_len() is introduced to retrieve the data length
> from all types of CAN frames.
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/linux/can/skb.h       | 14 ++++++++++
>  include/uapi/linux/if_ether.h |  1 +
>  net/can/af_can.c              | 49 +++++++++++++++++++++++++++++------
>  3 files changed, 56 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index 182749e858b3..d043bc4afd6d 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -101,6 +101,20 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
>  {
>         /* the CAN specific type of skb is identified by its data length */
>         return skb->len == CANFD_MTU;
>  }
>
> +/* get data length inside of CAN frame for all frame types */> +static inline unsigned int can_get_data_len(struct sk_buff *skb)
> +{
> +       if(skb->len == CANXL_MTU) {
> +               const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
> +
> +               return cfx->len;
> +       } else {
> +               const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> +
> +               return cfd->len;
> +       }
> +}

What about the RTR frames?

If there are cases in which we intentionally want the declared length
and not the actual length, it might be good to have two distinct
helper functions.

/* get data length inside of CAN frame for all frame types. For
 * RTR frames, return zero. */
static inline unsigned int can_get_actual_len(struct sk_buff *skb)
{
       const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
       const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;

       if (skb->len == CANXL_MTU)
               return cfx->len;

       /* RTR frames have an actual length of zero */
       if (skb->len == CAN_MTU && cfd->flags & CAN_RTR_FLAG)
               return 0;

       return cfd->len;
}


/* get data length inside of CAN frame for all frame types. For
 * RTR frames, return requested length. */
static inline unsigned int can_get_declared_len(struct sk_buff *skb)
{
       const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
       const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;

       if (skb->len == CANXL_MTU)
               return cfx->len;

       return cfd->len;
}


> +
>  #endif /* !_CAN_SKB_H */
> diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
> index d370165bc621..69e0457eb200 100644
> --- a/include/uapi/linux/if_ether.h
> +++ b/include/uapi/linux/if_ether.h
> @@ -136,10 +136,11 @@
>  #define ETH_P_WAN_PPP   0x0007          /* Dummy type for WAN PPP frames*/
>  #define ETH_P_PPP_MP    0x0008          /* Dummy type for PPP MP frames */
>  #define ETH_P_LOCALTALK 0x0009         /* Localtalk pseudo type        */
>  #define ETH_P_CAN      0x000C          /* CAN: Controller Area Network */
>  #define ETH_P_CANFD    0x000D          /* CANFD: CAN flexible data rate*/
> +#define ETH_P_CANXL    0x000E          /* CANXL: eXtended frame Length */
>  #define ETH_P_PPPTALK  0x0010          /* Dummy type for Atalk over PPP*/
>  #define ETH_P_TR_802_2 0x0011          /* 802.2 frames                 */
>  #define ETH_P_MOBITEX  0x0015          /* Mobitex (kaz@cafe.net)       */
>  #define ETH_P_CONTROL  0x0016          /* Card specific control frames */
>  #define ETH_P_IRDA     0x0017          /* Linux-IrDA                   */
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 1fb49d51b25d..2c9f48aa5f1f 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -197,31 +197,32 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
>   *  -EINVAL when the skb->data does not contain a valid CAN frame
>   */
>  int can_send(struct sk_buff *skb, int loop)
>  {
>         struct sk_buff *newskb = NULL;
> -       struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> +       unsigned int len = can_get_data_len(skb);
>         struct can_pkg_stats *pkg_stats = dev_net(skb->dev)->can.pkg_stats;
>         int err = -EINVAL;
>
>         if (skb->len == CAN_MTU) {
>                 skb->protocol = htons(ETH_P_CAN);
> -               if (unlikely(cfd->len > CAN_MAX_DLEN))
> +               if (unlikely(len > CAN_MAX_DLEN))
>                         goto inval_skb;
>         } else if (skb->len == CANFD_MTU) {
>                 skb->protocol = htons(ETH_P_CANFD);
> -               if (unlikely(cfd->len > CANFD_MAX_DLEN))
> +               if (unlikely(len > CANFD_MAX_DLEN))
> +                       goto inval_skb;
> +       } else if (skb->len == CANXL_MTU) {
> +               skb->protocol = htons(ETH_P_CANXL);
> +               if (unlikely(len > CANXL_MAX_DLEN || len == 0))
>                         goto inval_skb;
>         } else {
>                 goto inval_skb;
>         }
>
> -       /* Make sure the CAN frame can pass the selected CAN netdevice.
> -        * As structs can_frame and canfd_frame are similar, we can provide
> -        * CAN FD frames to legacy CAN drivers as long as the length is <= 8
> -        */
> -       if (unlikely(skb->len > skb->dev->mtu && cfd->len > CAN_MAX_DLEN)) {
> +       /* Make sure the CAN frame can pass the selected CAN netdevice */
> +       if (unlikely(skb->len > skb->dev->mtu)) {
>                 err = -EMSGSIZE;
>                 goto inval_skb;
>         }
>
>         if (unlikely(skb->dev->type != ARPHRD_CAN)) {
> @@ -725,10 +726,36 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
>  free_skb:
>         kfree_skb(skb);
>         return NET_RX_DROP;
>  }
>
> +static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
> +                    struct packet_type *pt, struct net_device *orig_dev)
> +{
> +       struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
> +
> +       if (unlikely(dev->type != ARPHRD_CAN || skb->len != CANXL_MTU)) {
> +               pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
> +                            dev->type, skb->len);
> +               goto free_skb;
> +       }
> +
> +       /* This check is made separately since cfx->len would be uninitialized if skb->len = 0. */
> +       if (unlikely(cfx->len > CANXL_MAX_DLEN || cfx->len == 0)) {
> +               pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d, datalen %d\n",
> +                            dev->type, skb->len, cfx->len);
> +               goto free_skb;
> +       }
> +
> +       can_receive(skb, dev);
> +       return NET_RX_SUCCESS;
> +
> +free_skb:
> +       kfree_skb(skb);
> +       return NET_RX_DROP;
> +}
> +
>  /* af_can protocol functions */
>
>  /**
>   * can_proto_register - register CAN transport protocol
>   * @cp: pointer to CAN protocol structure
> @@ -849,10 +876,15 @@ static struct packet_type can_packet __read_mostly = {
>  static struct packet_type canfd_packet __read_mostly = {
>         .type = cpu_to_be16(ETH_P_CANFD),
>         .func = canfd_rcv,
>  };
>
> +static struct packet_type canxl_packet __read_mostly = {
> +       .type = cpu_to_be16(ETH_P_CANXL),
> +       .func = canxl_rcv,
> +};
> +
>  static const struct net_proto_family can_family_ops = {
>         .family = PF_CAN,
>         .create = can_create,
>         .owner  = THIS_MODULE,
>  };
> @@ -888,10 +920,11 @@ static __init int can_init(void)
>         if (err)
>                 goto out_sock;
>
>         dev_add_pack(&can_packet);
>         dev_add_pack(&canfd_packet);
> +       dev_add_pack(&canxl_packet);
>
>         return 0;
>
>  out_sock:
>         unregister_pernet_subsys(&can_pernet_ops);
> --
> 2.30.2
>
