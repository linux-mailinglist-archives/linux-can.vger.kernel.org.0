Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830947B7FEB
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 14:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjJDMz7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 08:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjJDMz7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 08:55:59 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F9798
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 05:55:55 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3af609c3e74so1369326b6e.2
        for <linux-can@vger.kernel.org>; Wed, 04 Oct 2023 05:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696424154; x=1697028954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7g2/ODcqRPH7pItUmz913l3o7kNCbMFo3/Rt07DHkdM=;
        b=nQ9Vf7G8P+a5NkZDjavO1aAvMqYa8goFfYcTbnfh/3fLbgv1bfDXlrJWvhhnt/lLSU
         hoAeZLBKPRvub2+EKzCUYB+A4gio4acUTnLmjIEVBOWyAaLvrQTrRzVIDptZil58M8pW
         jmCRlg+ADmpFHNQiyNXtTN8BYV+QnSiWQjyi3TyCfPcOv7qkRMGQGJLN91zC9Hq+7AJf
         i8AkgVDYfyUmv5PDVOuBc/yUnTagp9UMqZ7XtlQu5FxCtPyR/gHGeSQtD4qaKO0pZTDf
         kNvv13RnHR2LU1/7dz7sqCaWEEEk3N6CmCOFCtBFG5rRqAz2KHES/SmtBKYDA0yZSeO4
         oFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696424154; x=1697028954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7g2/ODcqRPH7pItUmz913l3o7kNCbMFo3/Rt07DHkdM=;
        b=Yyyjb3+/ZdnYEbXobaLxvPUdo/5aE9nRFYZvwKB0mL5eiXimf8nGsNntCGhUlAFv2B
         lUNm1hRCQpwkoJ4y9Bdpy3mrW3A3ERrXgZz27ZWJ9Y3QCi/qBHhS/Gna9FqF86iiFMRp
         HYdVnTfTypOPMGLg6rhqZh4lQ19TJV30n6gCanIIpAPoWnoE6kaf2xUTp6I0VwnINXMU
         1fGb4KneaWjFGnvhjtvsOcWjAyU6q3tpBomNJDjXb/pgZm7czcj2PMduJcWDp0tRwJ5i
         NdemjEklqkkAAN59K8qpzUsn2Jf+Gjz9Fy2YXvQ+JJ1UZfl2UigTg8E2xP0L463mWMyn
         jusw==
X-Gm-Message-State: AOJu0YzAtAdT92F4eYc3lqRUWG0S0mFMjU9wuBXGwDO75FYxGwGnIugr
        43YkjjbP4zdAWdS1ctq+/8sA9OvhuqnlR9Lc5USeBXL1f4U=
X-Google-Smtp-Source: AGHT+IF8yyMgKCmHfpVw7i+6aIUCOy7g72UICD0LI1Qmnj8s0Ma2gW6+A7ZSNmOD84Pql3Rp4heGT8KaA9DVdb+MWyo=
X-Received: by 2002:a05:6358:1ca:b0:135:57d0:d171 with SMTP id
 e10-20020a05635801ca00b0013557d0d171mr2134808rwa.15.1696424154422; Wed, 04
 Oct 2023 05:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de> <20231004-at91_can-rx_offload-v1-27-c32bf99097db@pengutronix.de>
In-Reply-To: <20231004-at91_can-rx_offload-v1-27-c32bf99097db@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 4 Oct 2023 21:55:41 +0900
Message-ID: <CAMZ6RqLoyCOsTuYCryr++yZw036cF2VyEbxawQSKvM-54aaHuA@mail.gmail.com>
Subject: Re: [PATCH 27/27] can: at91_can: switch to rx-offload implementation
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 4 Oct. 2023 at 18:24, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> The current at91_can driver uses NAPI to handle RX'ed CAN frames, the
> RX IRQ is disabled an a NAPI poll is scheduled. Then in at91_poll_rx()
                     ^^

and

> the RX'ed CAN frames are tried to read in order from the device.
>
> This approach has 2 drawbacks:
>
> - Under high system load it might take too long from the initial RX
>   IRQ to the NAPI poll function to run. This causes RX buffer
>   overflows.
> - The algorithm to read the CAN frames in order is not bullet proof
>   and may fail under certain use cases/system loads.
>
> The rx-offload helper fixes these problems by reading the RX'ed CAN
> frames in the interrupt handler and adding it a list sorted by RX
                                               ^

adding it *to* a list?

> timestamp. This list of RX'ed SKBs is then passed to the networking
> stack via NAPI.
>
> Convert the RX path to rx-offload, pass all CAN error frames with
> can_rx_offload_queue_timestamp().
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/Kconfig    |   1 +
>  drivers/net/can/at91_can.c | 340 +++++++++++++--------------------------------
>  2 files changed, 100 insertions(+), 241 deletions(-)
>
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index 649453a3c858..8d6fc0852bf7 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -89,6 +89,7 @@ config CAN_RX_OFFLOAD
>  config CAN_AT91
>         tristate "Atmel AT91 onchip CAN controller"
>         depends on (ARCH_AT91 || COMPILE_TEST) && HAS_IOMEM
> +       select CAN_RX_OFFLOAD
>         help
>           This is a driver for the SoC CAN controller in Atmel's AT91SAM9263
>           and AT91SAM9X5 processors.
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index ca62aa027e5f..33fb1e5edea5 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -3,7 +3,7 @@
>   * at91_can.c - CAN network driver for AT91 SoC CAN controller
>   *
>   * (C) 2007 by Hans J. Koch <hjk@hansjkoch.de>
> - * (C) 2008, 2009, 2010, 2011 by Marc Kleine-Budde <kernel@pengutronix.de>
> + * (C) 2008, 2009, 2010, 2011, 2023 by Marc Kleine-Budde <kernel@pengutronix.de>
>   */
>
>  #include <linux/bitfield.h>
> @@ -26,6 +26,7 @@
>
>  #include <linux/can/dev.h>
>  #include <linux/can/error.h>
> +#include <linux/can/rx-offload.h>
>
>  #define AT91_MB_MASK(i) ((1 << (i)) - 1)
>
> @@ -142,7 +143,6 @@ enum at91_devtype {
>
>  struct at91_devtype_data {
>         unsigned int rx_first;
> -       unsigned int rx_split;
>         unsigned int rx_last;
>         unsigned int tx_shift;
>         enum at91_devtype type;
> @@ -150,14 +150,13 @@ struct at91_devtype_data {
>
>  struct at91_priv {
>         struct can_priv can;            /* must be the first member! */
> -       struct napi_struct napi;
> +       struct can_rx_offload offload;
>         struct phy *transceiver;
>
>         void __iomem *reg_base;
>
>         unsigned int tx_head;
>         unsigned int tx_tail;
> -       unsigned int rx_next;
>         struct at91_devtype_data devtype_data;
>
>         struct clk *clk;
> @@ -166,9 +165,13 @@ struct at91_priv {
>         canid_t mb0_id;
>  };
>
> +static inline struct at91_priv *rx_offload_to_priv(struct can_rx_offload *offload)
> +{
> +       return container_of(offload, struct at91_priv, offload);
> +}
> +
>  static const struct at91_devtype_data at91_at91sam9263_data = {
>         .rx_first = 1,
> -       .rx_split = 8,
>         .rx_last = 11,
>         .tx_shift = 2,
>         .type = AT91_DEVTYPE_SAM9263,
> @@ -176,7 +179,6 @@ static const struct at91_devtype_data at91_at91sam9263_data = {
>
>  static const struct at91_devtype_data at91_at91sam9x5_data = {
>         .rx_first = 0,
> -       .rx_split = 4,
>         .rx_last = 5,
>         .tx_shift = 1,
>         .type = AT91_DEVTYPE_SAM9X5,
> @@ -213,27 +215,6 @@ static inline unsigned int get_mb_rx_last(const struct at91_priv *priv)
>         return priv->devtype_data.rx_last;
>  }
>
> -static inline unsigned int get_mb_rx_split(const struct at91_priv *priv)
> -{
> -       return priv->devtype_data.rx_split;
> -}
> -
> -static inline unsigned int get_mb_rx_num(const struct at91_priv *priv)
> -{
> -       return get_mb_rx_last(priv) - get_mb_rx_first(priv) + 1;
> -}
> -
> -static inline unsigned int get_mb_rx_low_last(const struct at91_priv *priv)
> -{
> -       return get_mb_rx_split(priv) - 1;
> -}
> -
> -static inline unsigned int get_mb_rx_low_mask(const struct at91_priv *priv)
> -{
> -       return AT91_MB_MASK(get_mb_rx_split(priv)) &
> -               ~AT91_MB_MASK(get_mb_rx_first(priv));
> -}
> -
>  static inline unsigned int get_mb_tx_shift(const struct at91_priv *priv)
>  {
>         return priv->devtype_data.tx_shift;
> @@ -374,9 +355,8 @@ static void at91_setup_mailboxes(struct net_device *dev)
>         for (i = get_mb_tx_first(priv); i <= get_mb_tx_last(priv); i++)
>                 set_mb_mode_prio(priv, i, AT91_MB_MODE_TX, 0);
>
> -       /* Reset tx and rx helper pointers */
> +       /* Reset tx helper pointers */
>         priv->tx_head = priv->tx_tail = 0;
> -       priv->rx_next = get_mb_rx_first(priv);
>  }
>
>  static int at91_set_bittiming(struct net_device *dev)
> @@ -548,34 +528,6 @@ static netdev_tx_t at91_start_xmit(struct sk_buff *skb, struct net_device *dev)
>         return NETDEV_TX_OK;
>  }
>
> -/**
> - * at91_activate_rx_low - activate lower rx mailboxes
> - * @priv: a91 context
> - *
> - * Reenables the lower mailboxes for reception of new CAN messages
> - */
> -static inline void at91_activate_rx_low(const struct at91_priv *priv)
> -{
> -       u32 mask = get_mb_rx_low_mask(priv);
> -
> -       at91_write(priv, AT91_TCR, mask);
> -}
> -
> -/**
> - * at91_activate_rx_mb - reactive single rx mailbox
> - * @priv: a91 context
> - * @mb: mailbox to reactivate
> - *
> - * Reenables given mailbox for reception of new CAN messages
> - */
> -static inline void at91_activate_rx_mb(const struct at91_priv *priv,
> -                                      unsigned int mb)
> -{
> -       u32 mask = 1 << mb;
> -
> -       at91_write(priv, AT91_TCR, mask);
> -}
> -
>  static inline u32 at91_get_timestamp(const struct at91_priv *priv)
>  {
>         return at91_read(priv, AT91_TIM);
> @@ -600,37 +552,60 @@ static void at91_rx_overflow_err(struct net_device *dev)
>  {
>         struct net_device_stats *stats = &dev->stats;
>         struct sk_buff *skb;
> +       struct at91_priv *priv = netdev_priv(dev);
>         struct can_frame *cf;
> +       u32 timestamp;
> +       int err;
>
>         netdev_dbg(dev, "RX buffer overflow\n");
>         stats->rx_over_errors++;
>         stats->rx_errors++;
>
> -       skb = alloc_can_err_skb(dev, &cf);
> +       skb = at91_alloc_can_err_skb(dev, &cf, &timestamp);
>         if (unlikely(!skb))
>                 return;
>
>         cf->can_id |= CAN_ERR_CRTL;
>         cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
>
> -       netif_receive_skb(skb);
> +       err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
> +       if (err)
> +               stats->rx_fifo_errors++;
>  }
>
>  /**
> - * at91_read_mb - read CAN msg from mailbox (lowlevel impl)
> - * @dev: net device
> + * at91_mailbox_read - read CAN msg from mailbox
> + * @offload: rx-offload
>   * @mb: mailbox number to read from
> - * @cf: can frame where to store message
> + * @timestamp: pointer to 32 bit timestamp
> + * @drop: true indicated mailbox to mark as read and drop frame
>   *
> - * Reads a CAN message from the given mailbox and stores data into
> - * given can frame. "mb" and "cf" must be valid.
> + * Reads a CAN message from the given mailbox if not empty.
>   */
> -static void at91_read_mb(struct net_device *dev, unsigned int mb,
> -                        struct can_frame *cf)
> +static struct sk_buff *at91_mailbox_read(struct can_rx_offload *offload,
> +                                        unsigned int mb, u32 *timestamp,
> +                                        bool drop)
>  {
> -       const struct at91_priv *priv = netdev_priv(dev);
> +       const struct at91_priv *priv = rx_offload_to_priv(offload);
> +       struct can_frame *cf;
> +       struct sk_buff *skb;
>         u32 reg_msr, reg_mid;
>
> +       reg_msr = at91_read(priv, AT91_MSR(mb));
> +       if (!(reg_msr & AT91_MSR_MRDY))
> +               return NULL;
> +
> +       if (unlikely(drop)) {
> +               skb = ERR_PTR(-ENOBUFS);
> +               goto mark_as_read;
> +       }
> +
> +       skb = alloc_can_skb(offload->dev, &cf);
> +       if (unlikely(!skb)) {
> +               skb = ERR_PTR(-ENOMEM);
> +               goto mark_as_read;
> +       }
> +
>         reg_mid = at91_read(priv, AT91_MID(mb));
>         if (reg_mid & AT91_MID_MIDE)
>                 cf->can_id = FIELD_GET(AT91_MID_MIDVA_MASK | AT91_MID_MIDVB_MASK, reg_mid) |
> @@ -638,7 +613,9 @@ static void at91_read_mb(struct net_device *dev, unsigned int mb,
>         else
>                 cf->can_id = FIELD_GET(AT91_MID_MIDVA_MASK, reg_mid);
>
> -       reg_msr = at91_read(priv, AT91_MSR(mb));
> +       /* extend timstamp to full 32 bit */
                    ^^^^^^^^

timestamp

> +       *timestamp = FIELD_GET(AT91_MSR_MTIMESTAMP_MASK, reg_msr) << 16;

If I understand correctly, you only use the hardware timestamp for the
napi but you do not report it to the userland.

Not a criticism of this series, but it seems to me that it would be
easy to add one follow-up patch that would populate
skb_shared_hwtstamps->hwtstamp and update ethtool_ops->get_ts_info in
order to report those hardware timestamps to the user.

>         cf->len = can_cc_dlc2len(FIELD_GET(AT91_MSR_MDLC_MASK, reg_msr));
>
>         if (reg_msr & AT91_MSR_MRTR) {
> @@ -652,151 +629,12 @@ static void at91_read_mb(struct net_device *dev, unsigned int mb,
>         at91_write(priv, AT91_MID(mb), AT91_MID_MIDE);
>
>         if (unlikely(mb == get_mb_rx_last(priv) && reg_msr & AT91_MSR_MMI))
> -               at91_rx_overflow_err(dev);
> -}
> +               at91_rx_overflow_err(offload->dev);

(...)

This concludes my "review" of this series. Because I was scrolling
through it and not doing anything thorough, I will not be giving my
review-by tag even if there is a follow-up v2. That said, aside from
my comment on patch 01/27 and the random typo nitpick, nothing seemed
off.


Yours sincerely,
Vincent Mailhol
