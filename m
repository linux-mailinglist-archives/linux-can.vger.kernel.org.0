Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E092752BBCF
	for <lists+linux-can@lfdr.de>; Wed, 18 May 2022 16:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbiEROHw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 18 May 2022 10:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238454AbiEROHu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 May 2022 10:07:50 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D616ABC3;
        Wed, 18 May 2022 07:07:47 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id q135so3829078ybg.10;
        Wed, 18 May 2022 07:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QXYjMoct8jHy31FBakzpCRkd+Wppn/IEAU7MUWDLFiQ=;
        b=ez7/MlI9wDfj0ZG4XcHSkTTmgGiS1z4ymcAOkW8ECwRYScqYUhIuQErX3vSsWkVWog
         ejaoKVEqdTaB/dmYjvk5LZBx+4t5+AFJd5DLZOFCBHaCW2wKaaLpckiMMxqViVs/uH6H
         LCYahL9gSDi945NaE/yrP9PqwzV6KcNb+502szV+/wljE1tU/mkQw4SyVvpNIZnMTIgC
         4XqwAqkj51s+ZpkiaUpsFFGFhzj6cYjvZ8gntD/s23URYs5mhIJo5gMYNAzH8SvOXxkw
         +GEVHfqliQtdWz498NlEyv4SipQpyIFYRLRGphj33Y+m5ksFfEjBRuZI6vUNFVci6LTM
         mICw==
X-Gm-Message-State: AOAM532ziQC1zWv5inqa8dT97GKr4nwcJinEOkQQBrtvVq29tZ5uv1qz
        lHzqNcnRbHK1FbBj0TViFAcKoV8KyPnAsrO1qsapGOicK2iX4A==
X-Google-Smtp-Source: ABdhPJyLHZ2AgpCh9R3fj0oOs2ey9AP1V4nx8RS0AvuWHKgetRwnyrtQBOZTyg/mJL52a1rIhFf17NbJc7JTUGB6SYg=
X-Received: by 2002:a25:e093:0:b0:64d:6c85:6bc6 with SMTP id
 x141-20020a25e093000000b0064d6c856bc6mr18989580ybg.500.1652882866975; Wed, 18
 May 2022 07:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220517060821.akuqbqxro34tj7x6@pengutronix.de>
 <CAMZ6RqJ3sXYUOpw7hEfDzj14H-vXK_i+eYojBk2Lq=h=7cm7Jg@mail.gmail.com>
 <20220517104545.eslountqjppvcnz2@pengutronix.de> <e054f6d4-7ed1-98ac-8364-425f4ef0f760@hartkopp.net>
 <20220517141404.578d188a.max@enpas.org> <20220517122153.4r6n6kkbdslsa2hv@pengutronix.de>
 <20220517143921.08458f2c.max@enpas.org> <0b505b1f-1ee4-5a2c-3bbf-6e9822f78817@hartkopp.net>
 <CAMZ6RqJ0iCsHT-D5VuYQ9fk42ZEjHStU1yW0RfX1zuJpk5rVtQ@mail.gmail.com>
 <43768ff7-71f8-a6c3-18f8-28609e49eedd@hartkopp.net> <20220518132811.xfmwms2cu3bfxgrp@pengutronix.de>
In-Reply-To: <20220518132811.xfmwms2cu3bfxgrp@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 18 May 2022 23:07:35 +0900
Message-ID: <CAMZ6RqJqeNjAtoDWADHsWocgbSXqQixcebJBhiBFS8BVeKCb3g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] can: skb:: move can_dropped_invalid_skb and
 can_skb_headroom_valid to skb.c
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Max Staudt <max@enpas.org>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 18 May 2022 à 22:32, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 18.05.2022 15:10:44, Oliver Hartkopp wrote:
> > On 18.05.22 14:03, Vincent MAILHOL wrote:
> > > I didn't think this would trigger such a passionate discussion!
> >
> > :-D
> >
> > Maybe your change was the drop that let the bucket run over ;-)
>
> It's so trivial that everybody feels the urge to say something. :D
>
> > > > But e.g. the people that are running Linux instances in a cloud only
> > > > using vcan and vxcan would not need to carry the entire infrastructure
> > > > of CAN hardware support and rx-offload.
> > >
> > > Are there really some people running custom builds of the Linux kernel
> > > in a cloud environment? The benefit of saving a few kilobytes by not
> > > having to carry the entire CAN hardware infrastructure is blown away
> > > by the cost of having to maintain a custom build.
> >
> > When looking to the current Kconfig and Makefile content in
> > drivers/net/can(/dev) there is also some CONFIG_CAN_LEDS which "depends on
> > BROKEN" and builds a leds.o from a non existing leds.c ?!?
> >
> > Oh leds.c is in drivers/net/can/leds.c but not in drivers/net/can/dev/leds.c
> > where it could build ... ?
> >
> > So what I would suggest is that we always build a can-dev.ko when a CAN
> > driver is needed.
> >
> > Then we have different options that may be built-in:
> >
> > 1. netlink hw config interface
> > 2. bitrate calculation
> > 3. rx-offload
> > 4. leds
> >
> > E.g. having the netlink interface without bitrate calculation does not make
> > sense to me too.
>
> ACK
>
> > > I perfectly follow the idea to split rx-offload. Integrators building
> > > some custom firmware for an embedded device might want to strip out
> > > any unneeded piece. But I am not convinced by this same argument when
> > > applied to v(x)can.
> >
> > It does. I've seen CAN setups (really more than one or two!) in VMs and
> > container environments that are fed by Ethernet tunnels - sometimes also in
> > embedded devices.

Are those VM running custom builds of the kernel in which all the CAN
hardware devices have been removed? Also, isn't it hard to keep those
up to date with all the kernel security patches?

> > > A two level split (with or without rx-offload) is what makes the most
> > > sense to me.
> > >
> > > Regardless, having the three level split is not harmful. And because
> > > there seems to be a consensus on that, I am fine to continue in this
> > > direction.
> >
> > Thanks!
> >
> > Should we remove the extra option for the bitrate calculation then?
>
> +1

I can imagine people wanting to ship a product with the bitrate
calculation removed. For example, an infotainment unit designed for
one specific vehicle platform (i.e. baudrate is fixed). In that case,
the integrator might decide to remove bittiming calculation and
hardcode all hand calculated bittiming parameters instead.

So that one, I prefer to keep it. I just didn't mention it in my
previous message because it was already splitted out.

> > And what about the LEDS support depending on BROKEN?
> > That was introduced by commit 30f3b42147ba6f ("can: mark led trigger as
> > broken") from Uwe as it seems there were some changes in 2018.
>
> There's a proper generic LED trigger now for network devices. So remove
> LED triggers, too.

Yes, the broken LED topic also popped-up last year:

https://lore.kernel.org/linux-can/20210906143057.zrpor5fkh67uqwi2@pengutronix.de/

I am OK to add one patch to the series for LED removal. Just some
heads-up: I will take my time, it will definitely not be ready for the
v5.19 merge window. And I also expect that there will be at least one
more round of discussion.

While I am at it, anything else to add to the wish list before I start
to working it?
