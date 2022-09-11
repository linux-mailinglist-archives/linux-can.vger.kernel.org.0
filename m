Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C42D5B4C8C
	for <lists+linux-can@lfdr.de>; Sun, 11 Sep 2022 09:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIKHxj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 11 Sep 2022 03:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIKHxj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 11 Sep 2022 03:53:39 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E853A481
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 00:53:38 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id y82so8526620yby.6
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 00:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gAUjoQuZ0tEVBN5rAI4838wU/R+ltmEUh8SjddOCD38=;
        b=Iuhmh2H6l4JKlKOPxnRVHNo1EgpgHa9CYaRa7evMoJExUxRas3d6KI4+4bcptSmniJ
         poF84UkWjjRve8k3iyxVQP/yHaj/iNUSD1RCw6OAnjEj/n/y0t1th9/iMwi+f7FivMul
         YOCaAQk2DCONqsgb5HFNuzrsoLXImKtDDkXjgbc/x/uplmJAKpxyQk48WIVqZpapYuQH
         odKVsbMA36ogPpjMK1Q6xfCfPCL4coeI59+bg3aF+We3679ipAas5Jcpb6yCzC4G1R6k
         K4OCHKs/ZiLWzcwOKRg3H648QVCvPv7YIn5zfIx+gce6GpiD4z2B8u8bTI5WJiAORwyV
         hlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gAUjoQuZ0tEVBN5rAI4838wU/R+ltmEUh8SjddOCD38=;
        b=B4cp4vSp5fRaBmFV16qIIre+EDDTPLocY/MrbGvEuoAX9ADwwbcKRiVSUJjKrH97JY
         AreE9XSi6DFxuGcwaXOW6KxdcrOc7XtRvONqP5N8mdCPE+eRJRUOW1+3FVoiRNJMmC1X
         i/h55IxR1vewt07a8Xo1VxEnGs1XqiY/lnspItnGqrCFeOl7qyAHODKOVOLOrGI0+Olb
         XPTHy9YBY63juAKf20lUf23iysst1ib3q8NYANDFRn9kdLRX2mkcyeESh9RIbnIjOXoX
         FSHOOGOAxIvQIglc6TPe4Ddu+gk3oDw6mKNOYUfFTsIQbAeI8hlk8yR+ta7XnrDLrInf
         V5JQ==
X-Gm-Message-State: ACgBeo2O0gUo+9AM3q7hLVHtaK22Osex2S5SrmTcLxLHIhw8ooJvMuMw
        b9WZa8dZtVoCKoUQVi5Gh1HRToHW+4JtnSoZvod8eRwR
X-Google-Smtp-Source: AA6agR5nLxxEoDs+uCNKHbhyNQJbjJciPg9mpsnZmWS7cJqxaSUdmnfihNC6lvRoI4nKjUhOfqqOejBWp51l6KYJhg4=
X-Received: by 2002:a25:77d0:0:b0:6ae:c003:7b7a with SMTP id
 s199-20020a2577d0000000b006aec0037b7amr3638982ybc.381.1662882816980; Sun, 11
 Sep 2022 00:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220801190010.3344-1-socketcan@hartkopp.net> <20220801190010.3344-6-socketcan@hartkopp.net>
In-Reply-To: <20220801190010.3344-6-socketcan@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sun, 11 Sep 2022 16:53:25 +0900
Message-ID: <CAMZ6RqJMTP8mO5LOgfdFHNAkrn+3bCP9_JcGb4Q86TtHiS100A@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] can: canxl: update CAN infrastructure for CAN XL frames
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

On Tue. 2 Aug. 2022 at 04:02, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> - add new ETH_P_CANXL ethernet protocol type
> - update skb checks for CAN XL
> - add alloc_canxl_skb() which now needs a data length parameter
> - introduce init_can_skb_reserve() to reduce code duplication
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev/skb.c     | 72 ++++++++++++++++++++++++++---------
>  include/linux/can/skb.h       | 23 ++++++++++-
>  include/uapi/linux/if_ether.h |  1 +
>  net/can/af_can.c              | 25 +++++++++++-
>  4 files changed, 101 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index adb413bdd734..f2ec20d80aba 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -185,10 +185,24 @@ void can_free_echo_skb(struct net_device *dev, unsigned int idx,
>                 priv->echo_skb[idx] = NULL;
>         }
>  }
>  EXPORT_SYMBOL_GPL(can_free_echo_skb);
>
> +/* fill common values for CAN sk_buffs */
> +static void init_can_skb_reserve(struct sk_buff *skb)
> +{
> +       skb->pkt_type = PACKET_BROADCAST;
> +       skb->ip_summed = CHECKSUM_UNNECESSARY;
> +
> +       skb_reset_mac_header(skb);
> +       skb_reset_network_header(skb);
> +       skb_reset_transport_header(skb);
> +
> +       can_skb_reserve(skb);
> +       can_skb_prv(skb)->skbcnt = 0;
> +}
> +
>  struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
>  {
>         struct sk_buff *skb;
>
>         skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> @@ -198,20 +212,12 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
>
>                 return NULL;
>         }
>
>         skb->protocol = htons(ETH_P_CAN);
> -       skb->pkt_type = PACKET_BROADCAST;
> -       skb->ip_summed = CHECKSUM_UNNECESSARY;
> -
> -       skb_reset_mac_header(skb);
> -       skb_reset_network_header(skb);
> -       skb_reset_transport_header(skb);
> -
> -       can_skb_reserve(skb);
> +       init_can_skb_reserve(skb);
>         can_skb_prv(skb)->ifindex = dev->ifindex;
> -       can_skb_prv(skb)->skbcnt = 0;
>
>         *cf = skb_put_zero(skb, sizeof(struct can_frame));
>
>         return skb;
>  }
> @@ -229,30 +235,55 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
>
>                 return NULL;
>         }
>
>         skb->protocol = htons(ETH_P_CANFD);
> -       skb->pkt_type = PACKET_BROADCAST;
> -       skb->ip_summed = CHECKSUM_UNNECESSARY;
> -
> -       skb_reset_mac_header(skb);
> -       skb_reset_network_header(skb);
> -       skb_reset_transport_header(skb);
> -
> -       can_skb_reserve(skb);
> +       init_can_skb_reserve(skb);
>         can_skb_prv(skb)->ifindex = dev->ifindex;
> -       can_skb_prv(skb)->skbcnt = 0;
>
>         *cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
>
>         /* set CAN FD flag by default */
>         (*cfd)->flags = CANFD_FDF;
>
>         return skb;
>  }
>  EXPORT_SYMBOL_GPL(alloc_canfd_skb);
>
> +struct sk_buff *alloc_canxl_skb(struct net_device *dev,
> +                               struct canxl_frame **cfx,
> +                               unsigned int data_len)
> +{
> +       struct sk_buff *skb;
> +
> +       if (data_len < CANXL_MIN_DLEN || data_len > CANXL_MAX_DLEN)
> +               goto out_error;
> +
> +       skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> +                              CANXL_HDR_SIZE + data_len);
> +       if (unlikely(!skb))
> +               goto out_error;
> +
> +       skb->protocol = htons(ETH_P_CANXL);
> +       init_can_skb_reserve(skb);
> +       can_skb_prv(skb)->ifindex = dev->ifindex;
> +
> +       *cfx = skb_put_zero(skb, CANXL_HDR_SIZE + data_len);
> +
> +       /* set CAN XL flag and length information by default */
> +       (*cfx)->flags = CANXL_XLF;
> +       (*cfx)->len = data_len;
> +
> +       return skb;
> +
> +out_error:
> +       *cfx = NULL;
> +
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(alloc_canxl_skb);
> +
>  struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
>  {
>         struct sk_buff *skb;
>
>         skb = alloc_can_skb(dev, cf);
> @@ -317,10 +348,15 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
>         case ETH_P_CANFD:
>                 if (!can_is_canfd_skb(skb))
>                         goto inval_skb;
>                 break;
>
> +       case ETH_P_CANXL:
> +               if (!can_is_canxl_skb(skb))
> +                       goto inval_skb;
> +               break;
> +
>         default:
>                 goto inval_skb;
>         }
>
>         if (!can_skb_headroom_valid(dev, skb)) {
> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index ddffc2fc008c..01c01b1261fa 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -28,10 +28,13 @@ unsigned int __must_check can_get_echo_skb(struct net_device *dev,
>  void can_free_echo_skb(struct net_device *dev, unsigned int idx,
>                        unsigned int *frame_len_ptr);
>  struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf);
>  struct sk_buff *alloc_canfd_skb(struct net_device *dev,
>                                 struct canfd_frame **cfd);
> +struct sk_buff *alloc_canxl_skb(struct net_device *dev,
> +                               struct canxl_frame **cfx,
> +                               unsigned int data_len);
>  struct sk_buff *alloc_can_err_skb(struct net_device *dev,
>                                   struct can_frame **cf);
>  bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb);
>
>  /*
> @@ -112,15 +115,33 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
>
>         /* the CAN specific type of skb is identified by its data length */
>         return (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN);
>  }
>
> -/* get length element value from can[fd]_frame structure */
> +static inline bool can_is_canxl_skb(const struct sk_buff *skb)
> +{
> +       const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
> +
> +       if (skb->len < CANXL_HDR_SIZE + CANXL_MIN_DLEN || skb->len > CANXL_MTU)
> +               return false;
> +
> +       /* this also checks valid CAN XL data length boundaries */
> +       if (skb->len != CANXL_HDR_SIZE + cfx->len)
> +               return false;
> +
> +       return cfx->flags & CANXL_XLF;
> +}
> +
> +/* get length element value from can[|fd|xl]_frame structure */
>  static inline unsigned int can_skb_get_len_val(struct sk_buff *skb)
>  {
> +       const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
>         const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;

Nitpick: what would be the acronyms for cfx and cfd? I thought that
cfd was for *C*AN-*FD* frame, and thus I would expect cxl instead of
cfx for *C*AN-*XL* frame.
On the contrary, if cfx stands for *C*AN *F*rame *X*L, then for
CAN-FD, the acronym should be cff (*C*AN *f*rame *F*D).


> +       if (can_is_canxl_skb(skb))
> +               return cfx->len;
> +
>         return cfd->len;
>  }
>
>  /* get needed data length inside CAN frame for all frame types (RTR aware) */
>  static inline unsigned int can_skb_get_data_len(struct sk_buff *skb)
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
> index 072a6a5c9dd1..9503ab10f9b8 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -200,11 +200,13 @@ int can_send(struct sk_buff *skb, int loop)
>  {
>         struct sk_buff *newskb = NULL;
>         struct can_pkg_stats *pkg_stats = dev_net(skb->dev)->can.pkg_stats;
>         int err = -EINVAL;
>
> -       if (can_is_can_skb(skb)) {
> +       if (can_is_canxl_skb(skb)) {
> +               skb->protocol = htons(ETH_P_CANXL);
> +       } else if (can_is_can_skb(skb)) {
>                 skb->protocol = htons(ETH_P_CAN);
>         } else if (can_is_canfd_skb(skb)) {
>                 struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>
>                 skb->protocol = htons(ETH_P_CANFD);
> @@ -700,10 +702,25 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
>
>         can_receive(skb, dev);
>         return NET_RX_SUCCESS;
>  }
>
> +static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
> +                    struct packet_type *pt, struct net_device *orig_dev)
> +{
> +       if (unlikely(dev->type != ARPHRD_CAN || (!can_is_canxl_skb(skb)))) {
> +               pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
> +                            dev->type, skb->len);
> +
> +               kfree_skb(skb);
> +               return NET_RX_DROP;
> +       }
> +
> +       can_receive(skb, dev);
> +       return NET_RX_SUCCESS;
> +}
> +
>  /* af_can protocol functions */
>
>  /**
>   * can_proto_register - register CAN transport protocol
>   * @cp: pointer to CAN protocol structure
> @@ -824,10 +841,15 @@ static struct packet_type can_packet __read_mostly = {
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
> @@ -863,10 +885,11 @@ static __init int can_init(void)
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

Yours sincerely,
Vincent Mailhol
