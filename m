Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA7E572EE4
	for <lists+linux-can@lfdr.de>; Wed, 13 Jul 2022 09:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiGMHPU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Jul 2022 03:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiGMHPT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Jul 2022 03:15:19 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF41748EB0
        for <linux-can@vger.kernel.org>; Wed, 13 Jul 2022 00:15:18 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ef5380669cso103460217b3.9
        for <linux-can@vger.kernel.org>; Wed, 13 Jul 2022 00:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39JOrFawX1/cecKXHLtftnK31AncC6p43fErCehEFQg=;
        b=dAky8A+RI4Bs/0qdYPNbwTs2D7VFbbKPvU41S/b5hX0ShPEOfi9Puv/mAo7VvaRNjg
         7ryH0NMkrgvH50zlXIX9hWsaTiKEgZo7Ql+9WDFQSH20cQuf9jlMWlO8NshNiqtQbc70
         w0X9qw9PX4ttSj43llg0iSLz/xIfxq9ZaIvxO7kSn+WPTtQht3/WAmla7bCsds2YYw/5
         t9UUJGSHlzVg+jiBs+BWlgIlrS/0gGkJCyV9bhnC8Adu9b/dUM0C8BhSg+08gIdExqDa
         0993oRx5aEbgxO9S/NQ8XMmJgE6gStH1neS3sVddXi4sSv+1UhJKiJhzStEKs5p0NRVc
         kSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39JOrFawX1/cecKXHLtftnK31AncC6p43fErCehEFQg=;
        b=fKbwJ5/Z+TvSb1HkLTCEVAc1Y9G8qsvgcAMVonD2/Yn2q/BNpuTWeudmPkgzulWHv4
         wXPW4GdrhlCnM8FYTcEgg6ttYbQ2hPQLXWCYgdaWdwfC9XfPZi/BKlXiuybbWX95WoxL
         DjiIy9SjXpV0WSwzg94e0TWBsTS4jL+EHOh8GsB25OlcowXr/3sLYcMYK3idqxdCs+iX
         qfLARjFq7zgFa2cZYTwzuUm642iUpTAf2Mzw8XefwlKJqUlQ+eFTLEy7OiX8NlsQXtl+
         NUHo35hwR9OlddeHIKJwE54vakeHLOT5UvDKWGnsAR9TaMT2VZuechimXbAL0S7xN2Ev
         QmAQ==
X-Gm-Message-State: AJIora+z2DxFYvcD1PLk9ZmLMXkhAQQIF8pcF0O2I6HCZ2BdXh2UmTqn
        8RaGdZL9H97E3o3nr3FZsdh+5gqTc9tTIWk/c4co2GLo7M6KEQ==
X-Google-Smtp-Source: AGRyM1s0rdr8mXh/EKqgTuoEbLugB3VOMpIUVp+WJ5fXvBppDosPjynHtMI5IaOO7a09L+WS+jWFh33sUpDGOJ1o92A=
X-Received: by 2002:a0d:f247:0:b0:31d:68b1:5a16 with SMTP id
 b68-20020a0df247000000b0031d68b15a16mr2586137ywf.191.1657696517817; Wed, 13
 Jul 2022 00:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-3-socketcan@hartkopp.net> <CAMZ6Rq+jNEyknCWPCqPa8xEuBFdKeLBOUKmCC=pf0wZL+EG0-A@mail.gmail.com>
 <79a8a09e-fa85-cbdc-47cd-e54d89b71728@hartkopp.net> <CAMZ6RqJMJEjYaokH798a=GqPPDGps1_x=hMtCijkWs8dMrfNPQ@mail.gmail.com>
 <20220713070201.lzih3zqwxdjcyh2p@pengutronix.de>
In-Reply-To: <20220713070201.lzih3zqwxdjcyh2p@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 13 Jul 2022 16:15:06 +0900
Message-ID: <CAMZ6RqJYaG_ZRXaZPQwJUecY53O1HBOWK-fHSvv7ougA_8qUZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] can: canxl: introduce ETH_P_CANXL ethernet
 protocol handling
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
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

On Wed. 13 Jul. 2022 at 16:02, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 13.07.2022 08:58:26, Vincent Mailhol wrote:
> > On Wed. 13 Jul. 2022 at 05:20, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> > > On 12.07.22 03:23, Vincent Mailhol wrote:
> > > > On Tue. 12 Jul. 2022 at 03:44, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> > > >> Enable the PF_CAN infrastructure to handle CAN XL frames. A new ethernet
> > > >> protocol type ETH_P_CANXL is defined to tag skbuffs containing the CAN XL
> > > >> frame data structure.
> > > >>
> > > >> As the length information is now a uint16 value for CAN XL a new helper
> > > >> function can_get_data_len() is introduced to retrieve the data length
> > > >> from all types of CAN frames.
> > > >>
> > > >> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > > >> ---
> > > >>   include/linux/can/skb.h       | 14 ++++++++++
> > > >>   include/uapi/linux/if_ether.h |  1 +
> > > >>   net/can/af_can.c              | 49 +++++++++++++++++++++++++++++------
> > > >>   3 files changed, 56 insertions(+), 8 deletions(-)
> > > >>
> > > >> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> > > >> index 182749e858b3..d043bc4afd6d 100644
> > > >> --- a/include/linux/can/skb.h
> > > >> +++ b/include/linux/can/skb.h
> > > >> @@ -101,6 +101,20 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
> > > >>   {
> > > >>          /* the CAN specific type of skb is identified by its data length */
> > > >>          return skb->len == CANFD_MTU;
> > > >>   }
> > > >>
> > > >> +/* get data length inside of CAN frame for all frame types */> +static inline unsigned int can_get_data_len(struct sk_buff *skb)
> > > >> +{
> > > >> +       if(skb->len == CANXL_MTU) {
> > > >> +               const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
> > > >> +
> > > >> +               return cfx->len;
> > > >> +       } else {
> > > >> +               const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> > > >> +
> > > >> +               return cfd->len;
> > > >> +       }
> > > >> +}
> > > >
> > > > What about the RTR frames?
> > > >
> > > > If there are cases in which we intentionally want the declared length
> > > > and not the actual length, it might be good to have two distinct
> > > > helper functions.
> > >
> > > Good idea.
> > >
> > > > /* get data length inside of CAN frame for all frame types. For
> > > >   * RTR frames, return zero. */
> > > > static inline unsigned int can_get_actual_len(struct sk_buff *skb)
> > >
> > > I would name this one can_get_data_len()
> >
> > ACK.

So, according to Marc's comments (c.f. below):
can_skb_get_data_len()

> > > > {
> > > >         const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
> > > >         const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> > > >
> > > >         if (skb->len == CANXL_MTU)
> > > >                 return cfx->len;
> > > >
> > > >         /* RTR frames have an actual length of zero */
> > > >         if (skb->len == CAN_MTU && cfd->flags & CAN_RTR_FLAG)
> > > >                 return 0;
> > > >
> > > >         return cfd->len;
> > > > }
> > > >
> > > >
> > > > /* get data length inside of CAN frame for all frame types. For
> > > >   * RTR frames, return requested length. */
> > > > static inline unsigned int can_get_declared_len(struct sk_buff *skb)
> > >
> > > I would name this one can_get_len()
> >
> > I anticipate that most of the time, developers do not want to get the
> > RTR length but the actual length (e.g. to memcpy data[] or to increase
> > statistics). People will get confused between can_get_data_len() and
> > can_get_len() due to the similar names. So I would suggest a more
> > explicit name to point out that this one is probably not the one you
> > want to use.
> > Candidates name I can think of:
> >  * can_get_raw_len()
> >  * can_get_advertised_len()
> >  * can_get_rtr_len()

So according to Marc's comments (c.f. below), candidates become:
  * can_skb_get_raw_len()
  * can_skb_get_advertised_len()
  * can_skb_get_rtr_len()

> > The only time you want to access the raw len (with real RTR value) is
> > in the TX path when you fill your device's structures. But here the
> > can_get_cc_dlc() is a better helper function which is already RTR
> > aware.
>
> There also is
>
> | unsigned int can_skb_get_frame_len(const struct sk_buff *skb)

I totally forgot about that one, despite the fact that I co-developed
it with you.

> It gives the length of the frame on the wire in bytes. We should use a
> common naming scheme. Let's always use can_skb_ as a prefix or drop the
> skb_ from this function.

You are right. The idea was to use the can_skb_ prefix because the
argument of the function was a struct skb_buff. Same applies here.
