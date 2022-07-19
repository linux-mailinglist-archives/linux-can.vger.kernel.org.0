Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0A057A2CC
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 17:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbiGSPQx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 11:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiGSPQw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 11:16:52 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3AD189
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 08:16:51 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id k85so24315682ybk.7
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 08:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YUZtGs1D2S3PFvmOCWz7WtyIilprWp5gC2CXjVJ+xYE=;
        b=lymoboKbraL0SYNHtvOHaQRVnjaJtxG+d4KUMcCUl51mGyMjujHn2UnQfajEMT2OFD
         +S+UU1eNzrksULmegOhKlczwDw4RNJF6dJ1b90GSRUZGdC9rgqreXKEp6NYlrD1Okjcp
         WLaV4WvGAyIESOCsrgkA0rlQ74SGObQM+V2KPOOEFj1LKDPwRt5HRlPWpg/So8j4T4ag
         lfX19mAwxa4wTAgkk+/AoLhJC98ye9meiOPIRGCRrGfroSA3TtsaSV5dHZLHXwym2Wm9
         WRiRDUb/rtSaJ0WpgwBvUOOjXVIyXXmTyTT2rnGfofXJP4Xsy03eRnr6rJzcXnqCw568
         mGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YUZtGs1D2S3PFvmOCWz7WtyIilprWp5gC2CXjVJ+xYE=;
        b=hags5wBcnb9JbC3VpTJJjpS4lDKMs0vJQdYxYoCxcXE4XgDrocj6NVAA71inzNXVPg
         /uUm2adTL7kKp6iFSW/GleSXdNjRWmktx36av4alTTKsvi4FqNuYepBFk+JUOfQI2DtB
         62l9cfqE5Fu1gbXfcMH4XsYYLbqrZ5ILjHsdJ43KP51oj2oU+9JLR3VqraJcp/oimd9r
         xOTLzM62hN/R6/PfYVTh0hA/wPf0D2WUvdhDwE8JnKz0KIvhxM6nkflIoaOuc1H1RdtK
         temK4ymj+c4spMKoQPW6ZTl1TufsK/hW2n0zn5cxk1vTuNPX6C+hqorr1bTcguISkxYv
         KxTg==
X-Gm-Message-State: AJIora+RNN0cpjj/adhYAdd2xayXTI3jTGfOY+7hG85iYFFF6iDEs4VB
        mwgMdbEFY+HSXcIOpg8fgMgASKVlGL/4fywHbTwT92hspdQ=
X-Google-Smtp-Source: AGRyM1s2oZBceEa7F8APabrexqZ+5tgIB8RoQvez9/64alxpuEmA2iTG8ajwFNfrbRpOhO5umh2RreXIkmVKYnEqSxM=
X-Received: by 2002:a25:72d4:0:b0:670:7c08:a9e8 with SMTP id
 n203-20020a2572d4000000b006707c08a9e8mr5497242ybc.423.1658243810415; Tue, 19
 Jul 2022 08:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220719112748.3281-1-socketcan@hartkopp.net> <20220719112748.3281-4-socketcan@hartkopp.net>
 <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com> <f8ec078d-44c9-9f8c-800f-058e4c735003@hartkopp.net>
In-Reply-To: <f8ec078d-44c9-9f8c-800f-058e4c735003@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 20 Jul 2022 00:16:39 +0900
Message-ID: <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
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

On Tue 19 Jul. 2022 at 23:38, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 19.07.22 16:11, Vincent Mailhol wrote:
> > On Tue. 19 Jul. 2022, 20:44, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >> Extend the CAN device driver infrastructure to handle CAN XL frames.
> >> This especially addresses the increased data length which is extended
> >> to uint16 for CAN XL.
> >>
> >> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >> ---
> >>   drivers/net/can/dev/rx-offload.c |  2 +-
> >>   drivers/net/can/dev/skb.c        | 49 ++++++++++++++++++++++++++------
> >>   include/linux/can/skb.h          |  5 +++-
> >>   3 files changed, 45 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
> >> index a32a01c172d4..8505e547e922 100644
> >> --- a/drivers/net/can/dev/rx-offload.c
> >> +++ b/drivers/net/can/dev/rx-offload.c
> >> @@ -245,11 +245,11 @@ unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
> >>                                           unsigned int *frame_len_ptr)
> >>   {
> >>          struct net_device *dev = offload->dev;
> >>          struct net_device_stats *stats = &dev->stats;
> >>          struct sk_buff *skb;
> >> -       u8 len;
> >> +       unsigned int len;
> >>          int err;
> >>
> >>          skb = __can_get_echo_skb(dev, idx, &len, frame_len_ptr);
> >>          if (!skb)
> >>                  return 0;
> >> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> >> index 8bb62dd864c8..8531e0c39d1c 100644
> >> --- a/drivers/net/can/dev/skb.c
> >> +++ b/drivers/net/can/dev/skb.c
> >> @@ -53,11 +53,12 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
> >>          BUG_ON(idx >= priv->echo_skb_max);
> >>
> >>          /* check flag whether this packet has to be looped back */
> >>          if (!(dev->flags & IFF_ECHO) ||
> >>              (skb->protocol != htons(ETH_P_CAN) &&
> >> -            skb->protocol != htons(ETH_P_CANFD))) {
> >> +            skb->protocol != htons(ETH_P_CANFD) &&
> >> +            skb->protocol != htons(ETH_P_CANXL))) {
> >>                  kfree_skb(skb);
> >>                  return 0;
> >>          }
> >>
> >>          if (!priv->echo_skb[idx]) {
> >> @@ -86,12 +87,12 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
> >>          return 0;
> >>   }
> >>   EXPORT_SYMBOL_GPL(can_put_echo_skb);
> >>
> >>   struct sk_buff *
> >> -__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
> >> -                  unsigned int *frame_len_ptr)
> >> +__can_get_echo_skb(struct net_device *dev, unsigned int idx,
> >> +                  unsigned int *len_ptr, unsigned int *frame_len_ptr)
> >>   {
> >>          struct can_priv *priv = netdev_priv(dev);
> >>
> >>          if (idx >= priv->echo_skb_max) {
> >>                  netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
> >> @@ -103,17 +104,13 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
> >>                  /* Using "struct canfd_frame::len" for the frame
> >>                   * length is supported on both CAN and CANFD frames.
> >>                   */
> >>                  struct sk_buff *skb = priv->echo_skb[idx];
> >>                  struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
> >> -               struct canfd_frame *cf = (struct canfd_frame *)skb->data;
> >>
> >>                  /* get the real payload length for netdev statistics */
> >> -               if (cf->can_id & CAN_RTR_FLAG)
> >> -                       *len_ptr = 0;
> >> -               else
> >> -                       *len_ptr = cf->len;
> >> +               *len_ptr = can_skb_get_data_len(skb);
> >>
> >>                  if (frame_len_ptr)
> >>                          *frame_len_ptr = can_skb_priv->frame_len;
> >>
> >>                  priv->echo_skb[idx] = NULL;
> >> @@ -139,11 +136,11 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
> >>    */
> >>   unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx,
> >>                                unsigned int *frame_len_ptr)
> >>   {
> >>          struct sk_buff *skb;
> >> -       u8 len;
> >> +       unsigned int len;
> >>
> >>          skb = __can_get_echo_skb(dev, idx, &len, frame_len_ptr);
> >>          if (!skb)
> >>                  return 0;
> >>
> >> @@ -244,10 +241,41 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
> >>
> >>          return skb;
> >>   }
> >>   EXPORT_SYMBOL_GPL(alloc_canfd_skb);
> >>
> >> +struct sk_buff *alloc_canxl_skb(struct net_device *dev,
> >> +                               struct canxl_frame **cfx)
> >> +{
> >> +       struct sk_buff *skb;
> >> +
> >> +       skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> >> +                              sizeof(struct canxl_frame));
> >
> > I am confused. In this message:
> > https://lore.kernel.org/linux-can/3dcc85f8-2c02-dfe5-de23-d022f3fc56be@hartkopp.net/
> > you said that you "vote for selecting the 'truncated' option only"
> > (which is OK with me). But here, you are allocating the full size. If
> > we always want truncated frames, shouldn't we allocate the exact size
> > frame length here?
>
> No confusion.
>
> The API to the user space is 'truncated' option only.
>
> The data structure inside the kernel sizeof(struct can[|fd|xl]_frame).
>
> See:
> https://lore.kernel.org/linux-can/4c79233f-1301-d5c7-7698-38d39d8702aa@hartkopp.net/
>
> ---8<---
>
> As the sk_buffs are only allocated once and are not copied inside the
> kernel there should be no remarkable drawbacks whether we allocate
> CAN_MTU skbs or CANXL_MTU skbs.
>
> AFAICS both skbs will fit into a single page.

This is true. A page is at least 4k. So the 2k + alpha will easily fit.
But the page is not the smallest chunk that can return malloc, c.f.
KMALLOC_MIN_SIZE:
https://elixir.bootlin.com/linux/latest/source/include/linux/slab.h#L279

Also, more than the page size, my concern are the cache misses,
especially when memsetting to zero the full canxl frame. As far as I
understand, cloning an skb does not copy the payload (only increment a
reference to it) so the echo_skb thing should not be impacted.
That said, I am not able to tell whether or not this will have a
noticeable impact (I have some feeling it might but can not assert
it). If this looks good for the people who have the expertise in
kernel performances, then I am fine.

> ---8<---
>
> It is just easier and safe.
>
> (..)
>
> >> @@ -302,10 +330,13 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
> >>                          goto inval_skb;
> >>          } else if (skb->protocol == htons(ETH_P_CANFD)) {
> >>                  if (unlikely(skb->len != CANFD_MTU ||
> >>                               cfd->len > CANFD_MAX_DLEN))
> >>                          goto inval_skb;
> >> +       } else if (skb->protocol == htons(ETH_P_CANXL)) {
> >
> > Nitpick but with the growing list, I would see a switch
> > (skb->protocol) rather than the cascade of if.
> >
> >> +               if (unlikely(!can_is_canxl_skb(skb)))
> >> +                       goto inval_skb;
> >>          } else {
> >
> > default:
> >
> >>                  goto inval_skb;
> >>          }
>
> Yes. Good idea!
>
> Will change that.

Maybe even better:

        switch(ntohs(skb->protocol)) {
        case ETH_P_CAN:
               /* ... */
        case ETH_P_CANFD:
               /* ... */
        case ETH_P_CANXL:
                /* ... */
        default:
                /* ... */
        }
