Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADC9687CCF
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 13:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjBBMEU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 07:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBBMET (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 07:04:19 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A10234F1
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 04:04:18 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z14so1140728pgs.10
        for <linux-can@vger.kernel.org>; Thu, 02 Feb 2023 04:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kXlRk2CcIBg/1SXtJ8RILa2PzO8I5o4fOe19YASetEc=;
        b=F4dcpFfm4Wc4fTt3ZcttW2DSxLdnhEhlITEDY5r4iosnMFnTmB7/6pMy3Ing5hoHON
         uQPGLbrbe3Bc1JN8ED2juHVfFEhyB0IJwp53djpTjCEw4+UqEMPyFqwgOWkfNpkyTtlw
         KaDM63duHuTm8eOwH+POnntVCMFJ7gEsH4/g2DtOFt8QZRdWrwwg4bcz33/NwqIluCjg
         kZZ76h1w7eypI0itpLj1nPeXnbuAc3XWR5FNQYb2GdI5HHTRmmiuXmwvTi6Fsa0zXj80
         /x0QhMB5IPAUCw1imBMiWMXpBOgbmq8S6yC6ktyfontN/TAD0Kkc1ewVL7cHGDVrxCGi
         1tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXlRk2CcIBg/1SXtJ8RILa2PzO8I5o4fOe19YASetEc=;
        b=MB422JaJXoeZcRgxKyVAoII7Zff2wGkSDkjmnXMj7A2FRxDrr5VVguBrr6Db8v5sOL
         4XTGa4CH2O+1yif/Vl8p1qXLSI0bUu8ZEVXaBNtKdRQifNiIho7T4mNGadRx1GUA9q3j
         3phuBbWhdNLsAV++Q9sKoRujnQeaBCMk+pUa5gG3zfOH5G2QXT33E/UoGmArPDXfse3p
         DZCS7RVbmmYF3l8n94rsfjqlalkdjlkkKTqHjWZqPNqlNsvEpe72hwUJwCXCODLkBFZW
         VW9S4GNDou6jl4FzdLwSy1kRYbOXqA06nmHRDk3cqkcMqml20AISV+PfG1Drhki+T4t0
         Xr1A==
X-Gm-Message-State: AO0yUKWlLak9yi4+O3vrEcgcBY1ptLNWtGwXCC4J/0hqkIwpc0KVjcs7
        o8pDoqDyezj1PNxPdpuopmTmfTfj2kgMOuR9Cpw=
X-Google-Smtp-Source: AK7set9+tn3y3pfvI+3krLXYpPB0lkpgE1ONeMC68Vd1XrxQv9EdB8I012sXFmysercuZTPVqKstMCroEJXWoJxVWAQ=
X-Received: by 2002:aa7:959a:0:b0:592:a8af:4ffc with SMTP id
 z26-20020aa7959a000000b00592a8af4ffcmr1533545pfj.52.1675339458250; Thu, 02
 Feb 2023 04:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20230202110854.2318594-1-mkl@pengutronix.de> <20230202110854.2318594-11-mkl@pengutronix.de>
 <CAMZ6RqJuUvTo=LAYdHQryjcr+FD+o=-_TJmrwjpgiixN6dTyFw@mail.gmail.com> <20230202115342.4why7ttcc4bziljk@pengutronix.de>
In-Reply-To: <20230202115342.4why7ttcc4bziljk@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Thu, 2 Feb 2023 21:04:07 +0900
Message-ID: <CAMZ6RqL8754aFH+WMXJFCZQbvw+g_n+Shq7QNg3VbQC6GE0YJg@mail.gmail.com>
Subject: Re: [PATCH v2 10/17] can: bittiming: factor out can_sjw_set_default()
 and can_sjw_check()
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>,
        kernel@pengutronix.de, Mark Bath <mark@baggywrinkle.co.uk>
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

On Thu. 2 Feb 2023 at 20:53, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 02.02.2023 20:51:04, Vincent Mailhol wrote:
> > On Thu. 2 Feb. 2023 at 20:09, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > > Factor out the functionality of assigning a SJW default value into
> > > can_sjw_set_default() and the checking the SJW limits into
> > > can_sjw_check().
> > >
> > > This functions will be improved and called from a different function
> > > in the following patches.
> > >
> > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > ---
> > >  drivers/net/can/dev/bittiming.c | 30 ++++++++++++++++++++++++++----
> > >  include/linux/can/bittiming.h   |  5 +++++
> > >  2 files changed, 31 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
> > > index 0b0b8c767c5b..101de1b3bf30 100644
> > > --- a/drivers/net/can/dev/bittiming.c
> > > +++ b/drivers/net/can/dev/bittiming.c
> > > @@ -6,6 +6,24 @@
> > >
> > >  #include <linux/can/dev.h>
> > >
> > > +void can_sjw_set_default(struct can_bittiming *bt)
> > > +{
> > > +       if (bt->sjw)
> > > +               return;
> > > +
> > > +       /* If user space provides no sjw, use 1 as default */
> > > +       bt->sjw = 1;
> > > +}
> > > +
> > > +int can_sjw_check(const struct net_device *dev, const struct can_bittiming *bt,
> > > +                 const struct can_bittiming_const *btc, struct netlink_ext_ack *extack)
> > > +{
> > > +       if (bt->sjw > btc->sjw_max)
> > > +               return -ERANGE;
> >
> > You return -ERANGE here but then replace it by -EINVAL in patch #12.
>
> ACK.
>
> > Better to directly return -EINVAL here.
>
> This patch only factors out the functionality, but doesn't change it on
> purpose.

ACK.

I thought it was a leftover. I would not have done it that way, but I
do not want to over argue on this nitpick. So OK for me.
