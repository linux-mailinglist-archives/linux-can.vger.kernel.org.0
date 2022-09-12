Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54385B562F
	for <lists+linux-can@lfdr.de>; Mon, 12 Sep 2022 10:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiILI3v (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 12 Sep 2022 04:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiILI3Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Sep 2022 04:29:24 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9790A33E36
        for <linux-can@vger.kernel.org>; Mon, 12 Sep 2022 01:28:27 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id c9so11569024ybf.5
        for <linux-can@vger.kernel.org>; Mon, 12 Sep 2022 01:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kjF5s9nfnRchVC3mqeQdKLM4HELzZCFw2Gfsb/MBwYU=;
        b=jOvhpsHN0mMcTcnntohAuwuzPL1T9oD8pPEBSiA7NH+ZZKvRo1trlrmk3Sw8JbC455
         5MvM+iSBAUdznZozJT7TOfnmwcdG7FRoikFMsvzjmLN9Hhg3ibN7s7lYiG7sqZDbUjNK
         Blt2N8iETI32gvHLT78wBni/bRhi7DWze3uCHgCl66VtSM6qWU3DloOoPGtK7iiQ2dm0
         bhxK2B2pahD/z5LXR3IWksgnkW1ik7EbkvFg1XaETnws3XTrVQqI5VrwR1kCyBSfTGge
         7hKs/BBfm7Em+9QmnP4ZcWz2+yqgTLXqrmJ7hwsakE4BM2N7X6jXfZ3RuZL8O/bIzaC6
         bOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kjF5s9nfnRchVC3mqeQdKLM4HELzZCFw2Gfsb/MBwYU=;
        b=kYoKQhkHUbMx8iCI5wXmRuhmyH3cJlPWRs0BNHwEAMgNQ0sg3n5XjlErgOqOC1IYOY
         dxDUDuC8MdTOG2byIDM4X4AiN+hQfR1rO+Mgv09FDsF4MJ14VYn1trHOipL8GdgC5oKq
         sJLk9lc7HzZcrt6wiWQtsm5UNQN9kJvSZek52L3SKdaZPRDO8iev1gZt2c/09xZFKpvL
         vhT/c00qBdKqC2VeYd7Jfam9lAZ633WBIDeTcChpZ0zaUckgSUUIhSqn0pgRB6bUSNtx
         eaUFWcKahqjdOVoyIvzsqekbBRyaHyzZ+JObChKv1KnnxAhWoxVezgnOA/hwRMS2xamh
         ad5A==
X-Gm-Message-State: ACgBeo2GMeDIqwn67In2xrSkBTDEs0cT6AGp3zTO5N3aUyHkbB3QvR2C
        vcX+o6XUA6yy3vaa1NxdaORi/57tE6p4ccFIB1rUCTAk/aQ=
X-Google-Smtp-Source: AA6agR40J/Fpz+UVvuYp//b234asO4vireeQy4v/p0LNccjrURinbLupVjTq2y+bPSJVsJatn8IRnr2X2jt/xApQff8=
X-Received: by 2002:a25:da82:0:b0:6a9:27d8:a671 with SMTP id
 n124-20020a25da82000000b006a927d8a671mr20253426ybf.142.1662971306463; Mon, 12
 Sep 2022 01:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220907103845.3929288-1-mkl@pengutronix.de> <20220907103845.3929288-3-mkl@pengutronix.de>
 <CAMZ6RqKqhmTgUZiwe5uqUjBDnhhC2iOjZ791+Y845btJYwVDKg@mail.gmail.com> <BL3PR11MB64844E3FC13C55433CDD0B3DFB449@BL3PR11MB6484.namprd11.prod.outlook.com>
In-Reply-To: <BL3PR11MB64844E3FC13C55433CDD0B3DFB449@BL3PR11MB6484.namprd11.prod.outlook.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Mon, 12 Sep 2022 17:28:15 +0900
Message-ID: <CAMZ6RqJ8rhSVwnNHaxyRBg24PoH4EU8prEGsZO56wU6ozfMdAA@mail.gmail.com>
Subject: Re: [PATCH 2/5] can: bittiming: can_calc_bittiming(): make use of min3()
To:     Thomas.Kopp@microchip.com
Cc:     mkl@pengutronix.de, linux-can@vger.kernel.org,
        mark@baggywrinkle.co.uk
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

On Mon. 12 Sept. 2022 at 14:56, <Thomas.Kopp@microchip.com> wrote:
> > > In can_calc_bittiming() there are several open coded checks to ensure
> > > that SJW is within certain limits. Replace this by a single call to
> > > min3().
> > >
> > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > ---
> > >  drivers/net/can/dev/calc_bittiming.c | 8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/net/can/dev/calc_bittiming.c
> > b/drivers/net/can/dev/calc_bittiming.c
> > > index d3caa040614d..ce6bef2444a2 100644
> > > --- a/drivers/net/can/dev/calc_bittiming.c
> > > +++ b/drivers/net/can/dev/calc_bittiming.c
> > > @@ -158,12 +158,8 @@ int can_calc_bittiming(const struct net_device
> > *dev, struct can_bittiming *bt,
> > >         if (!bt->sjw || !btc->sjw_max) {
> > >                 bt->sjw = 1;
> > >         } else {
> > > -               /* bt->sjw is at least 1 -> sanitize upper bound to sjw_max */
> > > -               if (bt->sjw > btc->sjw_max)
> > > -                       bt->sjw = btc->sjw_max;
> > > -               /* bt->sjw must not be higher than tseg2 */
> > > -               if (tseg2 < bt->sjw)
> > > -                       bt->sjw = tseg2;
> > > +               /* sjw must not be higher than sjw_max and tseg2 */
> > > +               bt->sjw = min3(bt->sjw, btc->sjw_max, tseg2);
> >
> > Not directly a criticism of this patch (as things were already like
> > that), but if the user provides an incorrect value for SJW (or any
> > other bittiming argument), wouldn't it be better to inform? Returning
> > -EINVAL might be too violent. Maybe a dmesg would be good?
>
> I'd say it would be consistent to keep returning -EINVAL (at least for the SJW>(min p1,p2)) condition.
>
> The same is done for FD Bitrate < Arbitration bitrate and both conditions have the same level of justification in the ISO 11898-1:2015
> "The data bit time shall have the same length as the nominal bit time or it shall be shorter than the nominal bit time."
>
> "In nominal bit time and in data bit time, SJW shall be less than or equal to the minimum of these two items: Phase_Seg1 and Phase_Seg2."
>
> Shall is a binding requirement to be ISO conformant in this case.

What you say makes sense.

Also, I was assuming that can_fixup_bittiming() was already doing the
out of range check:
https://elixir.bootlin.com/linux/v6.0-rc1/source/drivers/net/can/dev/bittiming.c#L27

But in reality, only one of either can_calc_bittiming(),
can_fixup_bittiming() or can_validate_bitrate() is being called. And
thus, can_validate_bitrate() might be called with out of range values
and in that case the neltink interface should return -ERANGE (for
example if sjw > sjw_max).

Sees that there is more work to do here than initially anticipated.


Yours sincerely,
Vincent Mailhol
