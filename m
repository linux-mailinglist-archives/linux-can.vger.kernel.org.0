Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C605B4F3A
	for <lists+linux-can@lfdr.de>; Sun, 11 Sep 2022 15:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiIKN5X (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 11 Sep 2022 09:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiIKN5V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 11 Sep 2022 09:57:21 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACDC3054B
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 06:57:19 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3457bc84d53so72348477b3.0
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=VZCML55CyPr1V+HUjq7Xz8WW6WUk38RD6lJxWI4URds=;
        b=LvgBNHzyU4gWrOywExXMOOxZmbxIJyM/lyM/peVFEQCRyaOnf3MPqfCnSv7wQl4DcE
         cEaIXYMniK+aVF6aqpWAnosGFOmkvyCrwss1ygSrWxnTEbQXvqEBmuguYLj/Xelb3leV
         rnSxiFyYTH+SE4zWtSKE+Se/W2RB6l6S6vg2IIetl+qZgyxwmRzkgo9krQXrphZtWQRO
         OhdiSZA9yPZdhrWWu5syGQsmcYOC+nMI4orW5jyq1xA17xsulOMiibTuYVBlvHjY5z36
         ec1lldAQr4ourTxRkkAMcI3AXOQ77T7vh/VXjqhiNd22X9ggVLUsIm55cO+IxkzSwCAs
         uM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VZCML55CyPr1V+HUjq7Xz8WW6WUk38RD6lJxWI4URds=;
        b=iri36RQbUUH5cJMvvYMdwzWMWgllsgJQOtKFuSrwSiTF5zVJykjDKnilFsaZhIpSMh
         IPAC/lcoC2eVrXvPK721HvnLJbB6hy0BGMuDdHUnDtd74kTioYHgKSTxtQ95/iNBOlxx
         FvBy9XU+6BkrxfT4otUUzXeXvGNHL+YOVSfZK0kkf6YIA+qJThYzUKLiTdC1kQw+1Pq1
         zt6yuDPBWf1MZxi1ZXh3GhPNbfi27owYQi+XZ8Gz73XtvHZkeUiBH1uYnmlRwwpah5Qs
         GqBMetdBAoFlt8bcOk0CPOOj+tW5Z2n1WQB0k7gH78aVqAtuXKLhtlzY34INr/E4BVbr
         r76w==
X-Gm-Message-State: ACgBeo1sHb89aN8B2TCCqDKmmAZhOOKjv2CcYMBJp50R0pyjHQfejVst
        sO44vEnhgFjt4ZGquXyjAwHa/yvE0+A0hRIAYXoJwtp2
X-Google-Smtp-Source: AA6agR7cVBFIPdBAG7FViL/pTGlBu6E92uZH21jm3fDMjPjN3O8cBQ+IwBkGKMjphkGENlZ+UeNCHUiKiJACuSxVHTg=
X-Received: by 2002:a81:7488:0:b0:345:16f2:e1e1 with SMTP id
 p130-20020a817488000000b0034516f2e1e1mr18894055ywc.45.1662904638470; Sun, 11
 Sep 2022 06:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220801190010.3344-1-socketcan@hartkopp.net> <20220801190010.3344-4-socketcan@hartkopp.net>
 <CAMZ6Rq+nSSvN47kJwiRjamo34L6rEfb=ziHcZy=VEbfA+-4Fnw@mail.gmail.com> <e4078607-1021-a113-0877-a1da4c8fc663@hartkopp.net>
In-Reply-To: <e4078607-1021-a113-0877-a1da4c8fc663@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sun, 11 Sep 2022 22:57:07 +0900
Message-ID: <CAMZ6RqLWggo8egY+MLwCUiVnCsBLU8ENJe9M_Nae6FgJPsi6Fg@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] can: set CANFD_FDF flag in all CAN FD frame structures
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

On Sun. 11 Sept. 2022 at 21:23, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 11.09.22 09:51, Vincent Mailhol wrote:
> > On Tue. 2 Aug. 2022 at 04:02, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >> To simplify the testing in user space all struct canfd_frame's provided by
> >> the CAN subsystem of the Linux kernel now have the CANFD_FDF flag set in
> >> canfd_frame::flags.
> >>
> >> NB: Handcrafted ETH_P_CANFD frames introduced via PF_PACKET socket might
> >> not set this bit correctly. During the check for sufficient headroom in
> >> PF_PACKET sk_buffs the uninitialized CAN sk_buff data structures are filled.
> >> In the case of a CAN FD frame the CANFD_FDF flag is set accordingly.
> >>
> >> As the CAN frame content is already zero initialized in alloc_canfd_skb()
> >> the obsolete initialization of cf->flags in the CTU CAN FD driver has been
> >> removed as it would overwrite the already set CANFD_FDF flag.
> >>
> >> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >> ---
> >>   drivers/net/can/ctucanfd/ctucanfd_base.c |  1 -
> >>   drivers/net/can/dev/skb.c                | 11 +++++++++++
> >>   include/uapi/linux/can.h                 |  4 ++--
> >>   net/can/af_can.c                         |  5 +++++
> >>   4 files changed, 18 insertions(+), 3 deletions(-)
> >
> > Would it be relevant to also set the flag when the skb is cloned?
> >
> > diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> > index 182749e858b3..24de0bb7092e 100644
> > --- a/include/linux/can/skb.h
> > +++ b/include/linux/can/skb.h
> > @@ -85,6 +85,7 @@ static inline void can_skb_set_owner(struct sk_buff
> > *skb, struct sock *sk)
> >   static inline struct sk_buff *can_create_echo_skb(struct sk_buff *skb)
> >   {
> >          struct sk_buff *nskb;
> > +       struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> >
> >          nskb = skb_clone(skb, GFP_ATOMIC);
> >          if (unlikely(!nskb)) {
> > @@ -92,6 +93,9 @@ static inline struct sk_buff
> > *can_create_echo_skb(struct sk_buff *skb)
> >                  return NULL;
> >          }
> >
> > +       if (can_is_canfd_skb(skb))
> > +               cfd->flags |= CANFD_FDF;
> > +
> >          can_skb_set_owner(nskb, skb->sk);
> >          consume_skb(skb);
> >          return nskb;
> >
>
> No, this should be obsolete.
>
> The current patch set should set this bit at all creation/malloc places
> of CAN FD skbs.
>
> >> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
> >> index 3c18d028bd8c..c4026712ab7d 100644
> >> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> >> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> >> @@ -655,11 +655,10 @@ static void ctucan_read_rx_frame(struct ctucan_priv *priv, struct canfd_frame *c
> >>                  cf->can_id = (idw & CAN_EFF_MASK) | CAN_EFF_FLAG;
> >>          else
> >>                  cf->can_id = (idw >> 18) & CAN_SFF_MASK;
> >>
> >>          /* BRS, ESI, RTR Flags */
> >> -       cf->flags = 0;
> >>          if (FIELD_GET(REG_FRAME_FORMAT_W_FDF, ffw)) {
> >>                  if (FIELD_GET(REG_FRAME_FORMAT_W_BRS, ffw))
> >>                          cf->flags |= CANFD_BRS;
> >>                  if (FIELD_GET(REG_FRAME_FORMAT_W_ESI_RSV, ffw))
> >>                          cf->flags |= CANFD_ESI;
> >> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> >> index b896e1ce3b47..adb413bdd734 100644
> >> --- a/drivers/net/can/dev/skb.c
> >> +++ b/drivers/net/can/dev/skb.c
> >> @@ -242,10 +242,13 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
> >>          can_skb_prv(skb)->ifindex = dev->ifindex;
> >>          can_skb_prv(skb)->skbcnt = 0;
> >>
> >>          *cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
> >>
> >> +       /* set CAN FD flag by default */
> >> +       (*cfd)->flags = CANFD_FDF;
> >> +
> >>          return skb;
> >>   }
> >>   EXPORT_SYMBOL_GPL(alloc_canfd_skb);
> >>
> >>   struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
> >> @@ -285,10 +288,18 @@ static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
> >>                          skb->pkt_type = PACKET_HOST;
> >>
> >>                  skb_reset_mac_header(skb);
> >>                  skb_reset_network_header(skb);
> >>                  skb_reset_transport_header(skb);
> >> +
> >> +               /* set CANFD_FDF flag for CAN FD frames */
> >> +               if (can_is_canfd_skb(skb)) {
> >> +                       struct canfd_frame *cfd;
> >> +
> >> +                       cfd = (struct canfd_frame *)skb->data;
> >> +                       cfd->flags |= CANFD_FDF;
> >> +               }
> >>          }
> >>
> >>          return true;
> >>   }
> >>
> >> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> >> index 90801ada2bbe..7b23eeeb3273 100644
> >> --- a/include/uapi/linux/can.h
> >> +++ b/include/uapi/linux/can.h
> >> @@ -139,12 +139,12 @@ struct can_frame {
> >>    * The struct can_frame and struct canfd_frame intentionally share the same
> >>    * layout to be able to write CAN frame content into a CAN FD frame structure.
> >>    * When this is done the former differentiation via CAN_MTU / CANFD_MTU gets
> >>    * lost. CANFD_FDF allows programmers to mark CAN FD frames in the case of
> >>    * using struct canfd_frame for mixed CAN / CAN FD content (dual use).
> >> - * N.B. the Kernel APIs do NOT provide mixed CAN / CAN FD content inside of
> >> - * struct canfd_frame therefore the CANFD_FDF flag is disregarded by Linux.
> >> + * Since the introduction of CAN XL the CANFD_FDF flag is set in all CAN FD
> >> + * frame structures provided by the CAN subsystem of the Linux kernel.
> >>    */
> >>   #define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payload data) */
> >>   #define CANFD_ESI 0x02 /* error state indicator of the transmitting node */
> >>   #define CANFD_FDF 0x04 /* mark CAN FD for dual use of struct canfd_frame */
> >>
> >> diff --git a/net/can/af_can.c b/net/can/af_can.c
> >> index afa6c2151bc4..072a6a5c9dd1 100644
> >> --- a/net/can/af_can.c
> >> +++ b/net/can/af_can.c
> >> @@ -203,11 +203,16 @@ int can_send(struct sk_buff *skb, int loop)
> >>          int err = -EINVAL;
> >>
> >>          if (can_is_can_skb(skb)) {
> >>                  skb->protocol = htons(ETH_P_CAN);
> >>          } else if (can_is_canfd_skb(skb)) {
> >> +               struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> >> +
> >>                  skb->protocol = htons(ETH_P_CANFD);
> >> +
> >> +               /* set CAN FD flag for CAN FD frames by default */
> >> +               cfd->flags |= CANFD_FDF;
> >>          } else {
> >>                  goto inval_skb;
> >>          }
> >>
> >>          /* Make sure the CAN frame can pass the selected CAN netdevice. */
> >
> > Once all the malloc and clone functions set the flag, is there still a
> > route that would reach the can_send() without setting the CANFD_FDF
> > flag? If the answer is supposedly no, maybe it is better to remove the
> > check (or maybe replace it with a debug message to identify missed use
> > cases).
>
> The flag IS set in all skb malloc places (and therefore does not need to
> be set in clone places (see my answer above).
>
> This specific check in can_send() especially covers content that came
> from userspace which is not setting this bit today.
>
> The same is done for userspace content provided by a PF_PACKET socket in
> can_skb_headroom_valid() above.

I see. So if I take the vcan driver as an example, can_send() would
set the flag and then, no need to set it again when cloning. Same goes
for the can_echo_skb. Thanks for the explanations.


Yours sincerely,
Vincent Mailhol
