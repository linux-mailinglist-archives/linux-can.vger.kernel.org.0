Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8006B5740F7
	for <lists+linux-can@lfdr.de>; Thu, 14 Jul 2022 03:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiGNBcI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Jul 2022 21:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiGNBcH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Jul 2022 21:32:07 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9519C21E2E
        for <linux-can@vger.kernel.org>; Wed, 13 Jul 2022 18:32:05 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31c8bb90d09so3051987b3.8
        for <linux-can@vger.kernel.org>; Wed, 13 Jul 2022 18:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9jhbBvYL6jV37WiYD8mER2C+rv7FO71XEB0iLUVnao=;
        b=bpYNzkuYOgedI6rJHbzAPQWA16eZFEfWyNTY/s9Qm3b7ubCXGNxEfV3OOqr/qc9JI7
         LrN23vCz36Pqer0h/AuYhAUmLi7pFe++qHDCwTeOxpZIW48BEeLL5EA1TUmhyiBP+vAZ
         lbc3vpOlwEMMi3kdFI4klyPiLYrkgWcQkWc1pX86lCEQBdblsXhV8VZx/uB4tnIaCoCB
         cve+c/y4mILyqB8JMHp7qn5alvK4USxSkzWlnG6hpQrjXsRj+0rxXu+xUPpq8Tlsr0dP
         WBZu7jZKr7Dz5mNcoo5eKy7q5rQT7Mu5wBVsSM0+UKppPBXgfcIqE9d8zLDJ55Ku0P+Z
         mzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9jhbBvYL6jV37WiYD8mER2C+rv7FO71XEB0iLUVnao=;
        b=k1WpUCSIcA/yazM5sno2F6ML3MxZWwd90zq8wJ1MZmcc3p87eatQ4B9ptGix/yqL7E
         CzSv6Q07/4TJEiGiJ0RUX3PIh2THZT4Eutmz4d6DPXYTjvRfrp2TzZvOmnPq5WdclwLv
         LX7yOzzpH4xBnrRXjAlaUeyQAMXjj52M4aBjuZFZ++146A2Im1kl/ElADYsPC6nUDLsZ
         d34m+w0iOrO6gTo90PwDcjBfyeROVhawbEKwRygb1bsH5uwpboyoaPXI85X+USHKKCaw
         lkcMUtf+VQKj9D5Lp6WXeoc1xasH6g6TGhXb6SLUeFkAuFUULvPudoCgoMQDMaeQob+p
         Hj3Q==
X-Gm-Message-State: AJIora8tISz/wpsEiXBlEJelxD8z/gr+TsIENEzdTfXyqvo12vPoIWIV
        szPUt+JnrcXr4sjEIJa/r+dxheWst7M7q5Gz3Sul3cxHaBA=
X-Google-Smtp-Source: AGRyM1s4MdoDux3NW+Fz5e+tJTWH6e7wQj3ZFlIX8Fp6wscvy34vpe5A4OwiLx+uxXQAaOmBxiYFsqtGoj7rlM1SA0c=
X-Received: by 2002:a0d:f247:0:b0:31d:68b1:5a16 with SMTP id
 b68-20020a0df247000000b0031d68b15a16mr7384538ywf.191.1657762324742; Wed, 13
 Jul 2022 18:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-3-socketcan@hartkopp.net> <CAMZ6Rq+jNEyknCWPCqPa8xEuBFdKeLBOUKmCC=pf0wZL+EG0-A@mail.gmail.com>
 <79a8a09e-fa85-cbdc-47cd-e54d89b71728@hartkopp.net> <CAMZ6RqJMJEjYaokH798a=GqPPDGps1_x=hMtCijkWs8dMrfNPQ@mail.gmail.com>
 <20220713070201.lzih3zqwxdjcyh2p@pengutronix.de> <CAMZ6RqJYaG_ZRXaZPQwJUecY53O1HBOWK-fHSvv7ougA_8qUZQ@mail.gmail.com>
 <f039d26b-7142-a713-0597-dd21876959f2@hartkopp.net>
In-Reply-To: <f039d26b-7142-a713-0597-dd21876959f2@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Thu, 14 Jul 2022 10:32:18 +0900
Message-ID: <CAMZ6RqJ8uaomvmAKNtiAVq_bmN1K9rDJc1tkB-2MtH1hb7i8-A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] can: canxl: introduce ETH_P_CANXL ethernet
 protocol handling
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
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

On Thu. 14 Jul. 2022 at 05:27, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 13.07.22 09:15, Vincent Mailhol wrote:
> > On Wed. 13 Jul. 2022 at 16:02, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> >> On 13.07.2022 08:58:26, Vincent Mailhol wrote:
> >>> On Wed. 13 Jul. 2022 at 05:20, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >>>> On 12.07.22 03:23, Vincent Mailhol wrote:
> >>>>> On Tue. 12 Jul. 2022 at 03:44, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >>>>>> Enable the PF_CAN infrastructure to handle CAN XL frames. A new ethernet
> >>>>>> protocol type ETH_P_CANXL is defined to tag skbuffs containing the CAN XL
> >>>>>> frame data structure.
> >>>>>>
> >>>>>> As the length information is now a uint16 value for CAN XL a new helper
> >>>>>> function can_get_data_len() is introduced to retrieve the data length
> >>>>>> from all types of CAN frames.
> >>>>>>
> >>>>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >>>>>> ---
> >>>>>>    include/linux/can/skb.h       | 14 ++++++++++
> >>>>>>    include/uapi/linux/if_ether.h |  1 +
> >>>>>>    net/can/af_can.c              | 49 +++++++++++++++++++++++++++++------
> >>>>>>    3 files changed, 56 insertions(+), 8 deletions(-)
> >>>>>>
> >>>>>> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> >>>>>> index 182749e858b3..d043bc4afd6d 100644
> >>>>>> --- a/include/linux/can/skb.h
> >>>>>> +++ b/include/linux/can/skb.h
> >>>>>> @@ -101,6 +101,20 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
> >>>>>>    {
> >>>>>>           /* the CAN specific type of skb is identified by its data length */
> >>>>>>           return skb->len == CANFD_MTU;
> >>>>>>    }
> >>>>>>
> >>>>>> +/* get data length inside of CAN frame for all frame types */> +static inline unsigned int can_get_data_len(struct sk_buff *skb)
> >>>>>> +{
> >>>>>> +       if(skb->len == CANXL_MTU) {
> >>>>>> +               const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
> >>>>>> +
> >>>>>> +               return cfx->len;
> >>>>>> +       } else {
> >>>>>> +               const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> >>>>>> +
> >>>>>> +               return cfd->len;
> >>>>>> +       }
> >>>>>> +}
> >>>>>
> >>>>> What about the RTR frames?
> >>>>>
> >>>>> If there are cases in which we intentionally want the declared length
> >>>>> and not the actual length, it might be good to have two distinct
> >>>>> helper functions.
> >>>>
> >>>> Good idea.
> >>>>
> >>>>> /* get data length inside of CAN frame for all frame types. For
> >>>>>    * RTR frames, return zero. */
> >>>>> static inline unsigned int can_get_actual_len(struct sk_buff *skb)
> >>>>
> >>>> I would name this one can_get_data_len()
> >>>
> >>> ACK.
> >
> > So, according to Marc's comments (c.f. below):
> > can_skb_get_data_len()
> >
> >>>>> {
> >>>>>          const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
> >>>>>          const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> >>>>>
> >>>>>          if (skb->len == CANXL_MTU)
> >>>>>                  return cfx->len;
> >>>>>
> >>>>>          /* RTR frames have an actual length of zero */
> >>>>>          if (skb->len == CAN_MTU && cfd->flags & CAN_RTR_FLAG)
> >>>>>                  return 0;
> >>>>>
> >>>>>          return cfd->len;
> >>>>> }
> >>>>>
> >>>>>
> >>>>> /* get data length inside of CAN frame for all frame types. For
> >>>>>    * RTR frames, return requested length. */
> >>>>> static inline unsigned int can_get_declared_len(struct sk_buff *skb)
> >>>>
> >>>> I would name this one can_get_len()
> >>>
> >>> I anticipate that most of the time, developers do not want to get the
> >>> RTR length but the actual length (e.g. to memcpy data[] or to increase
> >>> statistics). People will get confused between can_get_data_len() and
> >>> can_get_len() due to the similar names. So I would suggest a more
> >>> explicit name to point out that this one is probably not the one you
> >>> want to use.
> >>> Candidates name I can think of:
> >>>   * can_get_raw_len()
> >>>   * can_get_advertised_len()
> >>>   * can_get_rtr_len()
>
> But these three functions still confuse me.
>
> IMO we need two values:
>
> - the data byte length (RTR aware)
> - the (raw) length value
>
> My suggestion for a naming would be:
>
> - can_skb_get_data_len()
> - can_skb_get_len_value()

Hmm, you did not fully convince me but at the same time, your solution
is okayish to me.
My main point was to correctly manage the length according to the RTR
flag and this concern is now fully addressed. I am fine to go on with
your naming suggestions.

Yours sincerely,
Vincent Mailhol
