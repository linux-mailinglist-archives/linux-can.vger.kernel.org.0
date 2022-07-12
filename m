Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3C572A22
	for <lists+linux-can@lfdr.de>; Wed, 13 Jul 2022 01:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiGLX6P (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 19:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiGLX6P (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 19:58:15 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D097C8E9D
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 16:58:14 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31d7db3e6e5so66754307b3.11
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 16:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Du+diwbr9r6wNjd2pxXkFXjDGSDcLFVeGayc8S7OgU=;
        b=pzRo2bvinJWNZCaLqYIErEUZLc+f+72xTHJ8x0WOMLwMMsF6PCPY86p3OYnZ9r+P+j
         0y88M7YQYrhSz6ufXwjXMxmXyAOZ4FIXO5aGClLhG0di53HzMxi4lkFCzzOEW954jVZh
         4kE4ISf38aqxzR39VD/+ZlTIqx8NLjjmNIZCRKWIkbWVP1QWnEN9HEACHeNb3vheVQNM
         wPSow9egrv5x0qBaKGG7pKAdOf0Xq1BPMUI2USQKPJGGu5Q49haoCPjpMPRG8a4wlkBY
         VL1LEbirPHHIzJ9RFTfi2wgYnGIQs0jAenjlBWUxjnfMCBK/8jfE6doijJR3zycGNpz5
         NrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Du+diwbr9r6wNjd2pxXkFXjDGSDcLFVeGayc8S7OgU=;
        b=Omh8ZOIsYludwpMbh6eU/rS27rDKC8UKWLjYlY2GWCX8k6LaUUWv6eJT35SwO+zwpB
         WJrt6LHkYtFM9TkA+3uWIl6VvOKdxGIuVddCz4rb448Fis25oAsm8mwEWBgt4+Viupfz
         tBR72IxwINln/h3pX24l+Ue3i7KWYmjGkhmqDZBva+ak4UR7GL2JosRSbLkd99y5o3LH
         bBnEFq1G5+/IUwd+t/5LAQB1aJDGtsGHTQ836+TZeVFgLjgGBgwFj//ai3nIJGP0i/Bm
         pvzLmq2VIktHq75ztGJoqJWN0VYjPEJjqApWdaHKXuAmOO+W9BToF8MARo1kO9Yfo7sN
         gqTA==
X-Gm-Message-State: AJIora+nd8xHe7euc2E4Lx+XdTi5CNm3eBTUsVAc2FnyP257kiX1VELn
        lseHNjZVvHcYCxaPDEtoCwfzzwtfidZt9yNYZL25W8M0spv9lw==
X-Google-Smtp-Source: AGRyM1uUB8SjoRY+YiYIWysWcFDYgp9nsCc26ffPHw6WqyYi9wxQ6pqj138c3VqwRokGHf0Rupis9Ha3U0Syh1YoX8w=
X-Received: by 2002:a0d:f703:0:b0:31d:6e5b:20c with SMTP id
 h3-20020a0df703000000b0031d6e5b020cmr1084854ywf.78.1657670293530; Tue, 12 Jul
 2022 16:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-3-socketcan@hartkopp.net> <CAMZ6Rq+jNEyknCWPCqPa8xEuBFdKeLBOUKmCC=pf0wZL+EG0-A@mail.gmail.com>
 <79a8a09e-fa85-cbdc-47cd-e54d89b71728@hartkopp.net>
In-Reply-To: <79a8a09e-fa85-cbdc-47cd-e54d89b71728@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 13 Jul 2022 08:58:26 +0900
Message-ID: <CAMZ6RqJMJEjYaokH798a=GqPPDGps1_x=hMtCijkWs8dMrfNPQ@mail.gmail.com>
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

On Wed. 13 Jul. 2022 at 05:20, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 12.07.22 03:23, Vincent Mailhol wrote:
> > On Tue. 12 Jul. 2022 at 03:44, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >> Enable the PF_CAN infrastructure to handle CAN XL frames. A new ethernet
> >> protocol type ETH_P_CANXL is defined to tag skbuffs containing the CAN XL
> >> frame data structure.
> >>
> >> As the length information is now a uint16 value for CAN XL a new helper
> >> function can_get_data_len() is introduced to retrieve the data length
> >> from all types of CAN frames.
> >>
> >> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >> ---
> >>   include/linux/can/skb.h       | 14 ++++++++++
> >>   include/uapi/linux/if_ether.h |  1 +
> >>   net/can/af_can.c              | 49 +++++++++++++++++++++++++++++------
> >>   3 files changed, 56 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> >> index 182749e858b3..d043bc4afd6d 100644
> >> --- a/include/linux/can/skb.h
> >> +++ b/include/linux/can/skb.h
> >> @@ -101,6 +101,20 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
> >>   {
> >>          /* the CAN specific type of skb is identified by its data length */
> >>          return skb->len == CANFD_MTU;
> >>   }
> >>
> >> +/* get data length inside of CAN frame for all frame types */> +static inline unsigned int can_get_data_len(struct sk_buff *skb)
> >> +{
> >> +       if(skb->len == CANXL_MTU) {
> >> +               const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
> >> +
> >> +               return cfx->len;
> >> +       } else {
> >> +               const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> >> +
> >> +               return cfd->len;
> >> +       }
> >> +}
> >
> > What about the RTR frames?
> >
> > If there are cases in which we intentionally want the declared length
> > and not the actual length, it might be good to have two distinct
> > helper functions.
>
> Good idea.
>
> > /* get data length inside of CAN frame for all frame types. For
> >   * RTR frames, return zero. */
> > static inline unsigned int can_get_actual_len(struct sk_buff *skb)
>
> I would name this one can_get_data_len()

ACK.

> > {
> >         const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
> >         const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> >
> >         if (skb->len == CANXL_MTU)
> >                 return cfx->len;
> >
> >         /* RTR frames have an actual length of zero */
> >         if (skb->len == CAN_MTU && cfd->flags & CAN_RTR_FLAG)
> >                 return 0;
> >
> >         return cfd->len;
> > }
> >
> >
> > /* get data length inside of CAN frame for all frame types. For
> >   * RTR frames, return requested length. */
> > static inline unsigned int can_get_declared_len(struct sk_buff *skb)
>
> I would name this one can_get_len()

I anticipate that most of the time, developers do not want to get the
RTR length but the actual length (e.g. to memcpy data[] or to increase
statistics). People will get confused between can_get_data_len() and
can_get_len() due to the similar names. So I would suggest a more
explicit name to point out that this one is probably not the one you
want to use.
Candidates name I can think of:
  * can_get_raw_len()
  * can_get_advertised_len()
 * can_get_rtr_len()

The only time you want to access the raw len (with real RTR value) is
in the TX path when you fill your device's structures. But here the
can_get_cc_dlc() is a better helper function which is already RTR
aware.

> > {
> >         const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
> >         const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> >
> >         if (skb->len == CANXL_MTU)
> >                 return cfx->len;
> >
> >         return cfd->len;
> > }

Yours sincerely,
Vincent Mailhol
