Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4232D70DB71
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 13:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjEWL2R (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 07:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjEWL2R (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 07:28:17 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96601119
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 04:28:08 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-52867360efcso5111965a12.2
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 04:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684841288; x=1687433288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxVs3to/m1/DxQHvYOFme6xte6cbqXdYZevpDJfNaXg=;
        b=hfYiL+8aMHTmZba0497VcKn679R+lrU7+cd43GyTI3nsNjxw8USd1U9xltyus+X/gR
         b6aYuye9TXV9FmhrLPcwGiSlATH4DdIq/jLs/IFofmOhxchlxxlHh0c+DaY03P8dEAtT
         OQjOPvCRQgtQdEfy/Oa2vd7BN5I6D+j9PRYcbG1V3JD/44xuMVN/HCwAyvgP8rCzi8Yf
         1MYi5QxkD7YNSkzUCqtAZGjzOSTVNO+jZ+ena37FHtUX3C96cIi7CqJBRtLy22S7/3/z
         ZEN/eDhqIDjUGBa2IJyBADunI0Gds+PxWzyX8Fqeqy8g33f6XGwgMaSTg2oVOFmJxeeP
         P4Cg==
X-Gm-Message-State: AC+VfDzE74dUoVBFg4rBJdKJfvzrI6DGpfwWXlRjuH8Hsa8SZYJPiiZz
        ISJKDuSFtLLrzWx3SQagZ5cI1pvh8yz4HWZvss0=
X-Google-Smtp-Source: ACHHUZ46QS5gQxq9FCay06GhQdiQEaB5MGx/RUccvkoGDY2Bo+PutwnFUslLNFtjtEHe46d2C3PaAFGtt9lM47yxi3M=
X-Received: by 2002:a17:90a:928e:b0:250:4a18:f575 with SMTP id
 n14-20020a17090a928e00b002504a18f575mr12894374pjo.9.1684841287610; Tue, 23
 May 2023 04:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230523094354.83792-1-extja@kvaser.com> <20230523094354.83792-12-extja@kvaser.com>
In-Reply-To: <20230523094354.83792-12-extja@kvaser.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 23 May 2023 20:27:56 +0900
Message-ID: <CAMZ6RqJbT_rfd=Ueds502b12JaJOG9xevZdSDSV50v5epqtwug@mail.gmail.com>
Subject: Re: [PATCH 11/12] can: kvaser_pciefd: Refactor code
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Jimmy,

I have one single comment for this series.

On Tue. 23 May 2023 at 18:55, Jimmy Assarsson <extja@kvaser.com> wrote:
> Refactor code;
>  - Format code
>  - Replace constants with macros
>  - Rename variables and macros
>  - Remove intermediate variable
>  - Add/remove blank lines
>  - Add function to fetch channel id from Rx packets
>  - Reduce scope of variables
>
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  drivers/net/can/kvaser_pciefd.c | 236 +++++++++++++-------------------
>  1 file changed, 97 insertions(+), 139 deletions(-)
>
> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
> index 3237c71afd2b..0575bb84b280 100644
> --- a/drivers/net/can/kvaser_pciefd.c
> +++ b/drivers/net/can/kvaser_pciefd.c
> @@ -53,7 +53,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
>  #define KVASER_PCIEFD_KCAN_CMD_REG 0x400
>  #define KVASER_PCIEFD_KCAN_IEN_REG 0x408
>  #define KVASER_PCIEFD_KCAN_IRQ_REG 0x410
> -#define KVASER_PCIEFD_KCAN_TX_NPACKETS_REG 0x414
> +#define KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG 0x414
>  #define KVASER_PCIEFD_KCAN_STAT_REG 0x418
>  #define KVASER_PCIEFD_KCAN_MODE_REG 0x41c
>  #define KVASER_PCIEFD_KCAN_BTRN_REG 0x420
> @@ -81,9 +81,9 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
>  #define KVASER_PCIEFD_IRQ_ALL_MSK 0x1f
>  #define KVASER_PCIEFD_IRQ_SRB BIT(4)
>
> -#define KVASER_PCIEFD_SYSID_NRCHAN_SHIFT 24
> -#define KVASER_PCIEFD_SYSID_MAJOR_VER_SHIFT 16
> -#define KVASER_PCIEFD_SYSID_BUILD_VER_SHIFT 1
> +#define KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_SHIFT 24
> +#define KVASER_PCIEFD_SYSID_VERSION_MAJOR_SHIFT 16
> +#define KVASER_PCIEFD_SYSID_BUILD_VERSION_SHIFT 1
>
>  /* Reset DMA buffer 0, 1 and FIFO offset */
>  #define KVASER_PCIEFD_SRB_CMD_RDB0 BIT(4)
> @@ -142,7 +142,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
>  /* Transmitter unaligned */
>  #define KVASER_PCIEFD_KCAN_IRQ_TAL BIT(17)
>
> -#define KVASER_PCIEFD_KCAN_TX_NPACKETS_MAX_SHIFT 16
> +#define KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_SHIFT 16
>
>  #define KVASER_PCIEFD_KCAN_STAT_SEQNO_SHIFT 24
>  /* Abort request */
> @@ -159,9 +159,9 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
>  #define KVASER_PCIEFD_KCAN_STAT_CAP BIT(16)
>  /* Controller got CAN FD capability */
>  #define KVASER_PCIEFD_KCAN_STAT_FD BIT(19)
> -#define KVASER_PCIEFD_KCAN_STAT_BUS_OFF_MSK (KVASER_PCIEFD_KCAN_STAT_AR | \
> -       KVASER_PCIEFD_KCAN_STAT_BOFF | KVASER_PCIEFD_KCAN_STAT_RMR | \
> -       KVASER_PCIEFD_KCAN_STAT_IRM)
> +#define KVASER_PCIEFD_KCAN_STAT_BUS_OFF_MASK                         \
> +       (KVASER_PCIEFD_KCAN_STAT_AR | KVASER_PCIEFD_KCAN_STAT_BOFF | \
> +        KVASER_PCIEFD_KCAN_STAT_RMR | KVASER_PCIEFD_KCAN_STAT_IRM)
>
>  /* Reset mode */
>  #define KVASER_PCIEFD_KCAN_MODE_RM BIT(8)
> @@ -178,9 +178,13 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
>  /* Classic CAN mode */
>  #define KVASER_PCIEFD_KCAN_MODE_CCM BIT(31)
>
> +#define KVASER_PCIEFD_KCAN_BTRN_BRP_MASK 0x1fff
>  #define KVASER_PCIEFD_KCAN_BTRN_SJW_SHIFT 13
> +#define KVASER_PCIEFD_KCAN_BTRN_SJW_MASK 0xf
>  #define KVASER_PCIEFD_KCAN_BTRN_TSEG1_SHIFT 17
> +#define KVASER_PCIEFD_KCAN_BTRN_TSEG1_MASK 0x1ff
>  #define KVASER_PCIEFD_KCAN_BTRN_TSEG2_SHIFT 26
> +#define KVASER_PCIEFD_KCAN_BTRN_TSEG2_MASK 0x1f
>
>  #define KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT 16
>
> @@ -196,9 +200,11 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
>  #define KVASER_PCIEFD_PACK_TYPE_BUS_LOAD 9
>
>  /* Kvaser KCAN packet common definitions */
> -#define KVASER_PCIEFD_PACKET_SEQ_MSK 0xff
> +#define KVASER_PCIEFD_PACKET_SEQ_MASK 0xff
>  #define KVASER_PCIEFD_PACKET_CHID_SHIFT 25
> +#define KVASER_PCIEFD_PACKET_CHID_MASK 0x7
>  #define KVASER_PCIEFD_PACKET_TYPE_SHIFT 28
> +#define KVASER_PCIEFD_PACKET_TYPE_MASK 0xf
>
>  /* Kvaser KCAN TDATA and RDATA first word */
>  #define KVASER_PCIEFD_RPACKET_IDE BIT(30)
> @@ -303,6 +309,11 @@ static struct pci_device_id kvaser_pciefd_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(pci, kvaser_pciefd_id_table);
>
> +static inline u8 kvaser_pciefd_rx_packet_get_ch_id(struct kvaser_pciefd_rx_packet *p)
> +{
> +       return (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & KVASER_PCIEFD_PACKET_CHID_MASK;

Instead of shifting and appliying the mask, define a mask which is
already shifted with GEN_MASK.

  Then use the FIELD_GET and FIELD_PREP from linux/bitfield.h.

The same comment applies to the other shift and mask operations.

This GEN_MASK, FIELD_GET and FIELD_PREP can be a separate patch.

> +}
> +
>  static void kvaser_pciefd_request_status(struct kvaser_pciefd_can *can)
>  {
>         u32 cmd;
> @@ -364,7 +375,6 @@ static void kvaser_pciefd_setup_controller(struct kvaser_pciefd_can *can)
>         unsigned long irq;
>
>         spin_lock_irqsave(&can->lock, irq);
> -
>         mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
>         if (can->can.ctrlmode & CAN_CTRLMODE_FD) {
>                 mode &= ~KVASER_PCIEFD_KCAN_MODE_CCM;
> @@ -381,7 +391,6 @@ static void kvaser_pciefd_setup_controller(struct kvaser_pciefd_can *can)
>                 mode |= KVASER_PCIEFD_KCAN_MODE_LOM;
>         else
>                 mode &= ~KVASER_PCIEFD_KCAN_MODE_LOM;
> -
>         mode |= KVASER_PCIEFD_KCAN_MODE_EEN;
>         mode |= KVASER_PCIEFD_KCAN_MODE_EPEN;
>         /* Use ACK packet type */
> @@ -401,7 +410,6 @@ static void kvaser_pciefd_start_controller_flush(struct kvaser_pciefd_can *can)
>         iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
>         iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
>                   can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
> -
>         status = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_STAT_REG);
>         if (status & KVASER_PCIEFD_KCAN_STAT_IDLE) {
>                 u32 cmd;
> @@ -418,7 +426,6 @@ static void kvaser_pciefd_start_controller_flush(struct kvaser_pciefd_can *can)
>                 mode |= KVASER_PCIEFD_KCAN_MODE_RM;
>                 iowrite32(mode, can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
>         }
> -
>         spin_unlock_irqrestore(&can->lock, irq);
>  }
>
> @@ -428,7 +435,6 @@ static int kvaser_pciefd_bus_on(struct kvaser_pciefd_can *can)
>         unsigned long irq;
>
>         del_timer(&can->bec_poll_timer);
> -
>         if (!completion_done(&can->flush_comp))
>                 kvaser_pciefd_start_controller_flush(can);
>
> @@ -441,10 +447,8 @@ static int kvaser_pciefd_bus_on(struct kvaser_pciefd_can *can)
>         spin_lock_irqsave(&can->lock, irq);
>         iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
>         iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
> -
>         iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
>                   can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
> -
>         mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
>         mode &= ~KVASER_PCIEFD_KCAN_MODE_RM;
>         iowrite32(mode, can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
> @@ -461,7 +465,6 @@ static int kvaser_pciefd_bus_on(struct kvaser_pciefd_can *can)
>
>         kvaser_pciefd_set_tx_irq(can);
>         kvaser_pciefd_setup_controller(can);
> -
>         can->can.state = CAN_STATE_ERROR_ACTIVE;
>         netif_wake_queue(can->can.dev);
>         can->bec.txerr = 0;
> @@ -480,7 +483,6 @@ static void kvaser_pciefd_pwm_stop(struct kvaser_pciefd_can *can)
>         spin_lock_irqsave(&can->lock, irq);
>         pwm_ctrl = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
>         top = (pwm_ctrl >> KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT) & 0xff;
> -
>         /* Set duty cycle to zero */
>         pwm_ctrl |= top;
>         iowrite32(pwm_ctrl, can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
> @@ -495,10 +497,8 @@ static void kvaser_pciefd_pwm_start(struct kvaser_pciefd_can *can)
>
>         kvaser_pciefd_pwm_stop(can);
>         spin_lock_irqsave(&can->lock, irq);
> -
>         /* Set frequency to 500 KHz*/
>         top = can->kv_pcie->bus_freq / (2 * 500000) - 1;
> -
>         pwm_ctrl = top & 0xff;
>         pwm_ctrl |= (top & 0xff) << KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT;
>         iowrite32(pwm_ctrl, can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
> @@ -561,7 +561,6 @@ static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
>         int seq = can->echo_idx;
>
>         memset(p, 0, sizeof(*p));
> -
>         if (can->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
>                 p->header[1] |= KVASER_PCIEFD_TPACKET_SMS;
>
> @@ -587,7 +586,7 @@ static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
>                                 << KVASER_PCIEFD_RPACKET_DLC_SHIFT;
>         }
>
> -       p->header[1] |= seq & KVASER_PCIEFD_PACKET_SEQ_MSK;
> +       p->header[1] |= seq & KVASER_PCIEFD_PACKET_SEQ_MASK;
>
>         packet_size = cf->len;
>         memcpy(p->data, cf->data, packet_size);
> @@ -601,16 +600,15 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
>         struct kvaser_pciefd_can *can = netdev_priv(netdev);
>         unsigned long irq_flags;
>         struct kvaser_pciefd_tx_packet packet;
> -       int nwords;
> +       int nr_words;
>         u8 count;
>
>         if (can_dev_dropped_skb(netdev, skb))
>                 return NETDEV_TX_OK;
>
> -       nwords = kvaser_pciefd_prepare_tx_packet(&packet, can, skb);
> +       nr_words = kvaser_pciefd_prepare_tx_packet(&packet, can, skb);
>
>         spin_lock_irqsave(&can->echo_lock, irq_flags);
> -
>         /* Prepare and save echo skb in internal slot */
>         can_put_echo_skb(skb, netdev, can->echo_idx, 0);
>
> @@ -623,13 +621,13 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
>         iowrite32(packet.header[1],
>                   can->reg_base + KVASER_PCIEFD_KCAN_FIFO_REG);
>
> -       if (nwords) {
> -               u32 data_last = ((u32 *)packet.data)[nwords - 1];
> +       if (nr_words) {
> +               u32 data_last = ((u32 *)packet.data)[nr_words - 1];
>
>                 /* Write data to fifo, except last word */
>                 iowrite32_rep(can->reg_base +
>                               KVASER_PCIEFD_KCAN_FIFO_REG, packet.data,
> -                             nwords - 1);
> +                             nr_words - 1);
>                 /* Write last word to end of fifo */
>                 __raw_writel(data_last, can->reg_base +
>                              KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
> @@ -638,15 +636,13 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
>                 __raw_writel(0, can->reg_base +
>                              KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
>         }
> -
> -       count = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NPACKETS_REG);
> +       count = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG);
>         /* No room for a new message, stop the queue until at least one
>          * successful transmit
>          */
>         if (count >= KVASER_PCIEFD_CAN_TX_MAX_COUNT ||
>             can->can.echo_skb[can->echo_idx])
>                 netif_stop_queue(netdev);
> -
>         spin_unlock_irqrestore(&can->echo_lock, irq_flags);
>
>         return NETDEV_TX_OK;
> @@ -664,25 +660,24 @@ static int kvaser_pciefd_set_bittiming(struct kvaser_pciefd_can *can, bool data)
>         else
>                 bt = &can->can.bittiming;
>
> -       btrn = ((bt->phase_seg2 - 1) & 0x1f) <<
> -              KVASER_PCIEFD_KCAN_BTRN_TSEG2_SHIFT |
> -              (((bt->prop_seg + bt->phase_seg1) - 1) & 0x1ff) <<
> -              KVASER_PCIEFD_KCAN_BTRN_TSEG1_SHIFT |
> -              ((bt->sjw - 1) & 0xf) << KVASER_PCIEFD_KCAN_BTRN_SJW_SHIFT |
> -              ((bt->brp - 1) & 0x1fff);
> +       btrn = ((bt->phase_seg2 - 1) & KVASER_PCIEFD_KCAN_BTRN_TSEG2_MASK)
> +                      << KVASER_PCIEFD_KCAN_BTRN_TSEG2_SHIFT |
> +              (((bt->prop_seg + bt->phase_seg1) - 1) &
> +               KVASER_PCIEFD_KCAN_BTRN_TSEG1_MASK)
> +                      << KVASER_PCIEFD_KCAN_BTRN_TSEG1_SHIFT |
> +              ((bt->sjw - 1) & KVASER_PCIEFD_KCAN_BTRN_SJW_MASK)
> +                      << KVASER_PCIEFD_KCAN_BTRN_SJW_SHIFT |
> +              ((bt->brp - 1) & KVASER_PCIEFD_KCAN_BTRN_BRP_MASK);
>
>         spin_lock_irqsave(&can->lock, irq_flags);
>         mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
> -
>         /* Put the circuit in reset mode */
>         iowrite32(mode | KVASER_PCIEFD_KCAN_MODE_RM,
>                   can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
>
>         /* Can only set bittiming if in reset mode */
>         ret = readl_poll_timeout(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG,
> -                                test, test & KVASER_PCIEFD_KCAN_MODE_RM,
> -                                0, 10);
> -
> +                                test, test & KVASER_PCIEFD_KCAN_MODE_RM, 0, 10);
>         if (ret) {
>                 spin_unlock_irqrestore(&can->lock, irq_flags);
>                 return -EBUSY;
> @@ -692,11 +687,10 @@ static int kvaser_pciefd_set_bittiming(struct kvaser_pciefd_can *can, bool data)
>                 iowrite32(btrn, can->reg_base + KVASER_PCIEFD_KCAN_BTRD_REG);
>         else
>                 iowrite32(btrn, can->reg_base + KVASER_PCIEFD_KCAN_BTRN_REG);
> -
>         /* Restore previous reset mode status */
>         iowrite32(mode, can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
> -
>         spin_unlock_irqrestore(&can->lock, irq_flags);
> +
>         return 0;
>  }
>
> @@ -734,6 +728,7 @@ static int kvaser_pciefd_get_berr_counter(const struct net_device *ndev,
>
>         bec->rxerr = can->bec.rxerr;
>         bec->txerr = can->bec.txerr;
> +
>         return 0;
>  }
>
> @@ -765,7 +760,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
>         for (i = 0; i < pcie->nr_channels; i++) {
>                 struct net_device *netdev;
>                 struct kvaser_pciefd_can *can;
> -               u32 status, tx_npackets;
> +               u32 status, tx_nr_packets;
>
>                 netdev = alloc_candev(sizeof(struct kvaser_pciefd_can),
>                                       KVASER_PCIEFD_CAN_TX_MAX_COUNT);
> @@ -777,7 +772,6 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
>                 netdev->ethtool_ops = &kvaser_pciefd_ethtool_ops;
>                 can->reg_base = pcie->reg_base + KVASER_PCIEFD_KCAN0_BASE +
>                                 i * KVASER_PCIEFD_KCAN_BASE_OFFSET;
> -
>                 can->kv_pcie = pcie;
>                 can->cmd_seq = 0;
>                 can->err_rep_cnt = 0;
> @@ -786,15 +780,13 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
>
>                 init_completion(&can->start_comp);
>                 init_completion(&can->flush_comp);
> -               timer_setup(&can->bec_poll_timer, kvaser_pciefd_bec_poll_timer,
> -                           0);
> +               timer_setup(&can->bec_poll_timer, kvaser_pciefd_bec_poll_timer, 0);
>
>                 /* Disable Bus load reporting */
>                 iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_BUS_LOAD_REG);
>
> -               tx_npackets = ioread32(can->reg_base +
> -                                      KVASER_PCIEFD_KCAN_TX_NPACKETS_REG);
> -               if (((tx_npackets >> KVASER_PCIEFD_KCAN_TX_NPACKETS_MAX_SHIFT) &
> +               tx_nr_packets = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG);
> +               if (((tx_nr_packets >> KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_SHIFT) &
>                       0xff) < KVASER_PCIEFD_CAN_TX_MAX_COUNT) {
>                         dev_err(&pcie->pci->dev,
>                                 "Max Tx count is smaller than expected\n");
> @@ -808,16 +800,13 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
>                 can->echo_idx = 0;
>                 spin_lock_init(&can->echo_lock);
>                 spin_lock_init(&can->lock);
> +
>                 can->can.bittiming_const = &kvaser_pciefd_bittiming_const;
>                 can->can.data_bittiming_const = &kvaser_pciefd_bittiming_const;
> -
>                 can->can.do_set_bittiming = kvaser_pciefd_set_nominal_bittiming;
> -               can->can.do_set_data_bittiming =
> -                       kvaser_pciefd_set_data_bittiming;
> -
> +               can->can.do_set_data_bittiming = kvaser_pciefd_set_data_bittiming;
>                 can->can.do_set_mode = kvaser_pciefd_set_mode;
>                 can->can.do_get_berr_counter = kvaser_pciefd_get_berr_counter;
> -
>                 can->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
>                                               CAN_CTRLMODE_FD |
>                                               CAN_CTRLMODE_FD_NON_ISO |
> @@ -836,7 +825,6 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
>                         can->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
>
>                 netdev->flags |= IFF_ECHO;
> -
>                 SET_NETDEV_DEV(netdev, &pcie->pci->dev);
>
>                 iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
> @@ -898,18 +886,16 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
>         for (i = 0; i < KVASER_PCIEFD_DMA_COUNT; i++) {
>                 unsigned int offset = KVASER_PCIEFD_DMA_MAP_BASE + 8 * i;
>
> -               pcie->dma_data[i] =
> -                       dmam_alloc_coherent(&pcie->pci->dev,
> -                                           KVASER_PCIEFD_DMA_SIZE,
> -                                           &dma_addr[i],
> -                                           GFP_KERNEL);
> +               pcie->dma_data[i] = dmam_alloc_coherent(&pcie->pci->dev,
> +                                                       KVASER_PCIEFD_DMA_SIZE,
> +                                                       &dma_addr[i],
> +                                                       GFP_KERNEL);
>
>                 if (!pcie->dma_data[i] || !dma_addr[i]) {
>                         dev_err(&pcie->pci->dev, "Rx dma_alloc(%u) failure\n",
>                                 KVASER_PCIEFD_DMA_SIZE);
>                         return -ENOMEM;
>                 }
> -
>                 kvaser_pciefd_write_dma_map(pcie, dma_addr[i], offset);
>         }
>
> @@ -917,7 +903,6 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
>         iowrite32(KVASER_PCIEFD_SRB_CMD_FOR | KVASER_PCIEFD_SRB_CMD_RDB0 |
>                   KVASER_PCIEFD_SRB_CMD_RDB1,
>                   pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
> -
>         /* Empty Rx FIFO */
>         srb_packet_count = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG) &
>                            KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK;
> @@ -942,22 +927,21 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
>
>  static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
>  {
> -       u32 sysid, srb_status, build;
> +       u32 version, srb_status, build;
>
> -       sysid = ioread32(pcie->reg_base + KVASER_PCIEFD_SYSID_VERSION_REG);
> +       version = ioread32(pcie->reg_base + KVASER_PCIEFD_SYSID_VERSION_REG);
>         pcie->nr_channels = min(KVASER_PCIEFD_MAX_CAN_CHANNELS,
> -                               ((sysid >> KVASER_PCIEFD_SYSID_NRCHAN_SHIFT) & 0xff));
> +                               ((version >> KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_SHIFT) & 0xff));
>
>         build = ioread32(pcie->reg_base + KVASER_PCIEFD_SYSID_BUILD_REG);
>         dev_dbg(&pcie->pci->dev, "Version %u.%u.%u\n",
> -               (sysid >> KVASER_PCIEFD_SYSID_MAJOR_VER_SHIFT) & 0xff,
> -               sysid & 0xff,
> -               (build >> KVASER_PCIEFD_SYSID_BUILD_VER_SHIFT) & 0x7fff);
> +               (version >> KVASER_PCIEFD_SYSID_VERSION_MAJOR_SHIFT) & 0xff,
> +               version & 0xff,
> +               (build >> KVASER_PCIEFD_SYSID_BUILD_VERSION_SHIFT) & 0x7fff);
>
>         srb_status = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_STAT_REG);
>         if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DMA)) {
> -               dev_err(&pcie->pci->dev,
> -                       "Hardware without DMA is not supported\n");
> +               dev_err(&pcie->pci->dev, "Hardware without DMA is not supported\n");
>                 return -ENODEV;
>         }
>
> @@ -967,9 +951,9 @@ static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
>         pcie->freq_to_ticks_div = pcie->freq / 1000000;
>         if (pcie->freq_to_ticks_div == 0)
>                 pcie->freq_to_ticks_div = 1;
> -
>         /* Turn off all loopback functionality */
>         iowrite32(0, pcie->reg_base + KVASER_PCIEFD_LOOP_REG);
> +
>         return 0;
>  }
>
> @@ -980,34 +964,31 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
>         struct sk_buff *skb;
>         struct canfd_frame *cf;
>         struct can_priv *priv;
> -       struct net_device_stats *stats;
> -       u8 ch_id = (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & 0x7;
> +       u8 ch_id = kvaser_pciefd_rx_packet_get_ch_id(p);
>         u8 dlc;
>
>         if (ch_id >= pcie->nr_channels)
>                 return -EIO;
>
>         priv = &pcie->can[ch_id]->can;
> -       stats = &priv->dev->stats;
>         dlc = (p->header[1] >> KVASER_PCIEFD_RPACKET_DLC_SHIFT) & 0xf;
>
>         if (p->header[1] & KVASER_PCIEFD_RPACKET_FDF) {
>                 skb = alloc_canfd_skb(priv->dev, &cf);
>                 if (!skb) {
> -                       stats->rx_dropped++;
> +                       priv->dev->stats.rx_dropped++;
>                         return -ENOMEM;
>                 }
>
>                 cf->len = can_fd_dlc2len(dlc);
>                 if (p->header[1] & KVASER_PCIEFD_RPACKET_BRS)
>                         cf->flags |= CANFD_BRS;
> -
>                 if (p->header[1] & KVASER_PCIEFD_RPACKET_ESI)
>                         cf->flags |= CANFD_ESI;
>         } else {
>                 skb = alloc_can_skb(priv->dev, (struct can_frame **)&cf);
>                 if (!skb) {
> -                       stats->rx_dropped++;
> +                       priv->dev->stats.rx_dropped++;
>                         return -ENOMEM;
>                 }
>                 can_frame_set_cc_len((struct can_frame *)cf, dlc, priv->ctrlmode);
> @@ -1021,10 +1002,9 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
>                 cf->can_id |= CAN_RTR_FLAG;
>         } else {
>                 memcpy(cf->data, data, cf->len);
> -
> -               stats->rx_bytes += cf->len;
> +               priv->dev->stats.rx_bytes += cf->len;
>         }
> -       stats->rx_packets++;
> +       priv->dev->stats.rx_packets++;
>         kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
>
>         return netif_rx(skb);
> @@ -1045,7 +1025,6 @@ static void kvaser_pciefd_change_state(struct kvaser_pciefd_can *can,
>                 spin_lock_irqsave(&can->lock, irq_flags);
>                 netif_stop_queue(can->can.dev);
>                 spin_unlock_irqrestore(&can->lock, irq_flags);
> -
>                 /* Prevent CAN controller from auto recover from bus off */
>                 if (!can->can.restart_ms) {
>                         kvaser_pciefd_start_controller_flush(can);
> @@ -1063,7 +1042,7 @@ static void kvaser_pciefd_packet_to_state(struct kvaser_pciefd_rx_packet *p,
>         if (p->header[0] & KVASER_PCIEFD_SPACK_BOFF ||
>             p->header[0] & KVASER_PCIEFD_SPACK_IRM)
>                 *new_state = CAN_STATE_BUS_OFF;
> -       else if (bec->txerr >= 255 ||  bec->rxerr >= 255)
> +       else if (bec->txerr >= 255 || bec->rxerr >= 255)
>                 *new_state = CAN_STATE_BUS_OFF;
>         else if (p->header[1] & KVASER_PCIEFD_SPACK_EPLR)
>                 *new_state = CAN_STATE_ERROR_PASSIVE;
> @@ -1088,22 +1067,16 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
>         struct net_device *ndev = can->can.dev;
>         struct sk_buff *skb;
>         struct can_frame *cf = NULL;
> -       struct net_device_stats *stats = &ndev->stats;
>
>         old_state = can->can.state;
>
>         bec.txerr = p->header[0] & 0xff;
>         bec.rxerr = (p->header[0] >> KVASER_PCIEFD_SPACK_RXERR_SHIFT) & 0xff;
>
> -       kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state,
> -                                     &rx_state);
> -
> +       kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state, &rx_state);
>         skb = alloc_can_err_skb(ndev, &cf);
> -
>         if (new_state != old_state) {
> -               kvaser_pciefd_change_state(can, cf, new_state, tx_state,
> -                                          rx_state);
> -
> +               kvaser_pciefd_change_state(can, cf, new_state, tx_state, rx_state);
>                 if (old_state == CAN_STATE_BUS_OFF &&
>                     new_state == CAN_STATE_ERROR_ACTIVE &&
>                     can->can.restart_ms) {
> @@ -1116,25 +1089,25 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
>         can->err_rep_cnt++;
>         can->can.can_stats.bus_error++;
>         if (p->header[1] & KVASER_PCIEFD_EPACK_DIR_TX)
> -               stats->tx_errors++;
> +               ndev->stats.tx_errors++;
>         else
> -               stats->rx_errors++;
> +               ndev->stats.rx_errors++;
>
>         can->bec.txerr = bec.txerr;
>         can->bec.rxerr = bec.rxerr;
>
>         if (!skb) {
> -               stats->rx_dropped++;
> +               ndev->stats.rx_dropped++;
>                 return -ENOMEM;
>         }
>
>         kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
>         cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_CNT;
> -
>         cf->data[6] = bec.txerr;
>         cf->data[7] = bec.rxerr;
>
>         netif_rx(skb);
> +
>         return 0;
>  }
>
> @@ -1142,19 +1115,19 @@ static int kvaser_pciefd_handle_error_packet(struct kvaser_pciefd *pcie,
>                                              struct kvaser_pciefd_rx_packet *p)
>  {
>         struct kvaser_pciefd_can *can;
> -       u8 ch_id = (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & 0x7;
> +       u8 ch_id = kvaser_pciefd_rx_packet_get_ch_id(p);
>
>         if (ch_id >= pcie->nr_channels)
>                 return -EIO;
>
>         can = pcie->can[ch_id];
> -
>         kvaser_pciefd_rx_error_frame(can, p);
>         if (can->err_rep_cnt >= KVASER_PCIEFD_MAX_ERR_REP)
>                 /* Do not report more errors, until bec_poll_timer expires */
>                 kvaser_pciefd_disable_err_gen(can);
>         /* Start polling the error counters */
>         mod_timer(&can->bec_poll_timer, KVASER_PCIEFD_BEC_POLL_FREQ);
> +
>         return 0;
>  }
>
> @@ -1169,9 +1142,7 @@ static int kvaser_pciefd_handle_status_resp(struct kvaser_pciefd_can *can,
>         bec.txerr = p->header[0] & 0xff;
>         bec.rxerr = (p->header[0] >> KVASER_PCIEFD_SPACK_RXERR_SHIFT) & 0xff;
>
> -       kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state,
> -                                     &rx_state);
> -
> +       kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state, &rx_state);
>         if (new_state != old_state) {
>                 struct net_device *ndev = can->can.dev;
>                 struct sk_buff *skb;
> @@ -1179,15 +1150,11 @@ static int kvaser_pciefd_handle_status_resp(struct kvaser_pciefd_can *can,
>
>                 skb = alloc_can_err_skb(ndev, &cf);
>                 if (!skb) {
> -                       struct net_device_stats *stats = &ndev->stats;
> -
> -                       stats->rx_dropped++;
> +                       ndev->stats.rx_dropped++;
>                         return -ENOMEM;
>                 }
>
> -               kvaser_pciefd_change_state(can, cf, new_state, tx_state,
> -                                          rx_state);
> -
> +               kvaser_pciefd_change_state(can, cf, new_state, tx_state, rx_state);
>                 if (old_state == CAN_STATE_BUS_OFF &&
>                     new_state == CAN_STATE_ERROR_ACTIVE &&
>                     can->can.restart_ms) {
> @@ -1217,7 +1184,7 @@ static int kvaser_pciefd_handle_status_packet(struct kvaser_pciefd *pcie,
>         struct kvaser_pciefd_can *can;
>         u8 cmdseq;
>         u32 status;
> -       u8 ch_id = (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & 0x7;
> +       u8 ch_id = kvaser_pciefd_rx_packet_get_ch_id(p);
>
>         if (ch_id >= pcie->nr_channels)
>                 return -EIO;
> @@ -1231,7 +1198,7 @@ static int kvaser_pciefd_handle_status_packet(struct kvaser_pciefd *pcie,
>         if (p->header[0] & KVASER_PCIEFD_SPACK_IRM &&
>             p->header[0] & KVASER_PCIEFD_SPACK_RMCD &&
>             p->header[1] & KVASER_PCIEFD_SPACK_AUTO &&
> -           cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MSK) &&
> +           cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MASK) &&
>             status & KVASER_PCIEFD_KCAN_STAT_IDLE) {
>                 u32 cmd;
>
> @@ -1242,26 +1209,24 @@ static int kvaser_pciefd_handle_status_packet(struct kvaser_pciefd *pcie,
>                 iowrite32(cmd, can->reg_base + KVASER_PCIEFD_KCAN_CMD_REG);
>         } else if (p->header[0] & KVASER_PCIEFD_SPACK_IDET &&
>                    p->header[0] & KVASER_PCIEFD_SPACK_IRM &&
> -                  cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MSK) &&
> +                  cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MASK) &&
>                    status & KVASER_PCIEFD_KCAN_STAT_IDLE) {
>                 /* Reset detected, send end of flush if no packet are in FIFO */
> -               u8 count = ioread32(can->reg_base +
> -                                   KVASER_PCIEFD_KCAN_TX_NPACKETS_REG) & 0xff;
> +               u8 count = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG) & 0xff;
>
>                 if (!count)
>                         iowrite32(KVASER_PCIEFD_KCAN_CTRL_EFLUSH,
>                                   can->reg_base + KVASER_PCIEFD_KCAN_CTRL_REG);
>         } else if (!(p->header[1] & KVASER_PCIEFD_SPACK_AUTO) &&
> -                  cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MSK)) {
> +                  cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MASK)) {
>                 /* Response to status request received */
>                 kvaser_pciefd_handle_status_resp(can, p);
>                 if (can->can.state != CAN_STATE_BUS_OFF &&
>                     can->can.state != CAN_STATE_ERROR_ACTIVE) {
> -                       mod_timer(&can->bec_poll_timer,
> -                                 KVASER_PCIEFD_BEC_POLL_FREQ);
> +                       mod_timer(&can->bec_poll_timer, KVASER_PCIEFD_BEC_POLL_FREQ);
>                 }
>         } else if (p->header[0] & KVASER_PCIEFD_SPACK_RMCD &&
> -                  !(status & KVASER_PCIEFD_KCAN_STAT_BUS_OFF_MSK)) {
> +                  !(status & KVASER_PCIEFD_KCAN_STAT_BUS_OFF_MASK)) {
>                 /* Reset to bus on detected */
>                 if (!completion_done(&can->start_comp))
>                         complete(&can->start_comp);
> @@ -1274,12 +1239,10 @@ static void kvaser_pciefd_handle_nack_packet(struct kvaser_pciefd_can *can,
>                                              struct kvaser_pciefd_rx_packet *p)
>  {
>         struct sk_buff *skb;
> -       struct net_device_stats *stats = &can->can.dev->stats;
>         struct can_frame *cf;
>
>         skb = alloc_can_err_skb(can->can.dev, &cf);
> -
> -       stats->tx_errors++;
> +       can->can.dev->stats.tx_errors++;
>         if (p->header[0] & KVASER_PCIEFD_APACKET_ABL) {
>                 if (skb)
>                         cf->can_id |= CAN_ERR_LOSTARB;
> @@ -1293,7 +1256,7 @@ static void kvaser_pciefd_handle_nack_packet(struct kvaser_pciefd_can *can,
>                 kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
>                 netif_rx(skb);
>         } else {
> -               stats->rx_dropped++;
> +               can->can.dev->stats.rx_dropped++;
>                 netdev_warn(can->can.dev, "No memory left for err_skb\n");
>         }
>  }
> @@ -1303,7 +1266,7 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
>  {
>         struct kvaser_pciefd_can *can;
>         bool one_shot_fail = false;
> -       u8 ch_id = (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & 0x7;
> +       u8 ch_id = kvaser_pciefd_rx_packet_get_ch_id(p);
>
>         if (ch_id >= pcie->nr_channels)
>                 return -EIO;
> @@ -1321,27 +1284,24 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
>         if (p->header[0] & KVASER_PCIEFD_APACKET_FLU) {
>                 netdev_dbg(can->can.dev, "Packet was flushed\n");
>         } else {
> -               int echo_idx = p->header[0] & KVASER_PCIEFD_PACKET_SEQ_MSK;
> -               int dlc;
> +               int echo_idx = p->header[0] & KVASER_PCIEFD_PACKET_SEQ_MASK;
> +               int len;
>                 u8 count;
>                 struct sk_buff *skb;
>
>                 skb = can->can.echo_skb[echo_idx];
>                 if (skb)
>                         kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
> -               dlc = can_get_echo_skb(can->can.dev, echo_idx, NULL);
> -               count = ioread32(can->reg_base +
> -                                   KVASER_PCIEFD_KCAN_TX_NPACKETS_REG) & 0xff;
> +               len = can_get_echo_skb(can->can.dev, echo_idx, NULL);
> +               count = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG) & 0xff;
>
>                 if (count < KVASER_PCIEFD_CAN_TX_MAX_COUNT &&
>                     netif_queue_stopped(can->can.dev))
>                         netif_wake_queue(can->can.dev);
>
>                 if (!one_shot_fail) {
> -                       struct net_device_stats *stats = &can->can.dev->stats;
> -
> -                       stats->tx_bytes += dlc;
> -                       stats->tx_packets++;
> +                       can->can.dev->stats.tx_bytes += len;
> +                       can->can.dev->stats.tx_packets++;
>                 }
>         }
>
> @@ -1352,7 +1312,7 @@ static int kvaser_pciefd_handle_eflush_packet(struct kvaser_pciefd *pcie,
>                                               struct kvaser_pciefd_rx_packet *p)
>  {
>         struct kvaser_pciefd_can *can;
> -       u8 ch_id = (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & 0x7;
> +       u8 ch_id = kvaser_pciefd_rx_packet_get_ch_id(p);
>
>         if (ch_id >= pcie->nr_channels)
>                 return -EIO;
> @@ -1391,7 +1351,7 @@ static int kvaser_pciefd_read_packet(struct kvaser_pciefd *pcie, int *start_pos,
>         pos += 2;
>         p->timestamp = le64_to_cpu(timestamp);
>
> -       type = (p->header[1] >> KVASER_PCIEFD_PACKET_TYPE_SHIFT) & 0xf;
> +       type = (p->header[1] >> KVASER_PCIEFD_PACKET_TYPE_SHIFT) & KVASER_PCIEFD_PACKET_TYPE_MASK;
>         switch (type) {
>         case KVASER_PCIEFD_PACK_TYPE_DATA:
>                 ret = kvaser_pciefd_handle_data_packet(pcie, p, &buffer[pos]);
> @@ -1541,13 +1501,12 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
>  static void kvaser_pciefd_teardown_can_ctrls(struct kvaser_pciefd *pcie)
>  {
>         int i;
> -       struct kvaser_pciefd_can *can;
>
>         for (i = 0; i < pcie->nr_channels; i++) {
> -               can = pcie->can[i];
> +               struct kvaser_pciefd_can *can = pcie->can[i];
> +
>                 if (can) {
> -                       iowrite32(0,
> -                                 can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
> +                       iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
>                         kvaser_pciefd_pwm_stop(can);
>                         free_candev(can->can.dev);
>                 }
> @@ -1648,14 +1607,13 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
>
>  static void kvaser_pciefd_remove_all_ctrls(struct kvaser_pciefd *pcie)
>  {
> -       struct kvaser_pciefd_can *can;
>         int i;
>
>         for (i = 0; i < pcie->nr_channels; i++) {
> -               can = pcie->can[i];
> +               struct kvaser_pciefd_can *can = pcie->can[i];
> +
>                 if (can) {
> -                       iowrite32(0,
> -                                 can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
> +                       iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
>                         unregister_candev(can->can.dev);
>                         del_timer(&can->bec_poll_timer);
>                         kvaser_pciefd_pwm_stop(can);
> --
> 2.40.0
>
