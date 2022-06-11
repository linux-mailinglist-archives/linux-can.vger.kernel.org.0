Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09B25473EB
	for <lists+linux-can@lfdr.de>; Sat, 11 Jun 2022 12:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiFKKqT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 11 Jun 2022 06:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiFKKqS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 11 Jun 2022 06:46:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C755A14008
        for <linux-can@vger.kernel.org>; Sat, 11 Jun 2022 03:46:16 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a15so2033947lfb.9
        for <linux-can@vger.kernel.org>; Sat, 11 Jun 2022 03:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=va6/lF6L6Ng8zl2J0isVPUb8pv9qoi2tKiUrpBsODPA=;
        b=DjLgzQ27Ee07ihrkEXtl7JW/IRmTqDJodYVSEyOl8ZIznuzFzBdk9oqZMHdorpBtr8
         syS/0JO2bowlxuPY8zX3+ul0eLzNyIVUFRTW57NNCDGKVOwLkWkZJ8ov4yX9MljDw15s
         B1cwl1nzokQ9zDokzpNPPERUAATQQF+MUCRKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=va6/lF6L6Ng8zl2J0isVPUb8pv9qoi2tKiUrpBsODPA=;
        b=OxzUrfBhw8T3G6aum4mnTHaVqSnnYmn+tBw16GxHCeHhYbifHjglgI/Ra8e6oaSV82
         J/9OeWu3exsazizLY+Xnk3+SlH2fIhFOH45b94vB80vejCk9JxUgBPHzJKDOk5Olfw9A
         tNreMyGONdNYfL3SvPg3ItuZ17Xd/8nQEOo6n7CwXbC/Qa2+hTMkHlLuPYTqqa8EUrlV
         TutzMuDXzwUbBHOInbo6MPuuPI90kNAKiruBAwN168EMdBlPZjD0nck7SnoNHGLpiJ+o
         exVni5KVxcNbcH2W2/+FUknngyUrrAv92P5XVOWiQRiE56Tw1qvzO2qrr+XT3Z467vBv
         /FSg==
X-Gm-Message-State: AOAM531pLOWxyCmDdrnWyHlNBxu4+qLIG5A8YT5bKrxB91KlVtEeZFEP
        tGEbC/GoPhZz9SyTKv9YUfuKKUiV7coav8CgLGrn6A==
X-Google-Smtp-Source: ABdhPJzJtG4lYlUf2mQAOQTuBTkStm+krM95435xBeb4XDhxoNaH5AszJsK/Afk5u/5zMnyGTUJON3/oX3bWoqpdPL8=
X-Received: by 2002:a05:6512:10c5:b0:479:2de0:561c with SMTP id
 k5-20020a05651210c500b004792de0561cmr21354813lfg.536.1654944374938; Sat, 11
 Jun 2022 03:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220608165116.1575390-1-dario.binacchi@amarulasolutions.com>
 <20220608165116.1575390-6-dario.binacchi@amarulasolutions.com> <eae65531-bf9f-4e2e-97ca-a79a8aa833fc@hartkopp.net>
In-Reply-To: <eae65531-bf9f-4e2e-97ca-a79a8aa833fc@hartkopp.net>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Sat, 11 Jun 2022 12:46:04 +0200
Message-ID: <CABGWkvroJG16AOu8BODhVu068jacjHWbkkY9TCF4PQ7rgANVXA@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] can: slcan: simplify the device de-allocation
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On Wed, Jun 8, 2022 at 10:38 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> This patch (at least) needs some rework.

Any suggestions are welcome. And double-checking the patch, I already have some
changes to put in version 3.
>
> The patch cf124db566e6b036 ("net: Fix inconsistent teardown and release
> of private netdev state.") from DaveM added some priv_destructor
>
>      dev->priv_destructor = sl_free_netdev;
>
> which is not taken into account in this patch.
>
> As written before I would like to discuss this change out of your patch
> series "can: slcan: extend supported features" as it is no slcan feature
> extension AND has to be synchronized with the drivers/net/slip/slip.c
> implementation.

Why do you need to synchronize it with  drivers/net/slip/slip.c
implementation ?

>
> When it has not real benefit and introduces more code and may create
> side effects, this beautification should probably be omitted at all.
>

I totally agree with you. I would have already dropped it if this patch
didn't make sense. But since I seem to have understood that this is
not the case, I do not understand why it cannot be improved in this
series.

The cover letter highlighted positive reactions to the series because
the module had been requiring these kinds of changes for quite
some time. So, why not take the opportunity to finalize this patch in
this series even if it doesn't extend the supported features ?

Anyway, I have some changes and tests to run before submitting version 3.
If I don't get any hints before then, I'll drop it from the series.

Thanks and regards,
Dario

> Thanks,
> Oliver
>
> On 08.06.22 18:51, Dario Binacchi wrote:
> > Since slcan_devs array contains the addresses of the created devices, I
> > think it is more natural to use its address to remove it from the list.
> > It is not necessary to store the index of the array that points to the
> > device in the driver's private data.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> > (no changes since v1)
> >
> >   drivers/net/can/slcan.c | 15 ++++++++++-----
> >   1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
> > index 929cb55e08af..cf05c30b8da5 100644
> > --- a/drivers/net/can/slcan.c
> > +++ b/drivers/net/can/slcan.c
> > @@ -432,11 +432,17 @@ static int slc_open(struct net_device *dev)
> >
> >   static void slc_dealloc(struct slcan *sl)
> >   {
> > -     int i = sl->dev->base_addr;
> > +     unsigned int i;
> >
> > -     free_candev(sl->dev);
> > -     if (slcan_devs)
> > -             slcan_devs[i] = NULL;
> > +     for (i = 0; i < maxdev; i++) {
> > +             if (sl->dev == slcan_devs[i]) {
> > +                     free_candev(sl->dev);
> > +                     slcan_devs[i] = NULL;
> > +                     return;
> > +             }
> > +     }
> > +
> > +     pr_err("slcan: can't free %s resources\n",  sl->dev->name);
> >   }
> >
> >   static int slcan_change_mtu(struct net_device *dev, int new_mtu)
> > @@ -533,7 +539,6 @@ static struct slcan *slc_alloc(void)
> >
> >       snprintf(dev->name, sizeof(dev->name), "slcan%d", i);
> >       dev->netdev_ops = &slc_netdev_ops;
> > -     dev->base_addr  = i;
> >       sl = netdev_priv(dev);
> >
> >       /* Initialize channel control data */
> >



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
