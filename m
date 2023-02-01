Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC22685F3E
	for <lists+linux-can@lfdr.de>; Wed,  1 Feb 2023 06:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjBAFtk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 1 Feb 2023 00:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjBAFti (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2023 00:49:38 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7595C0C7
        for <linux-can@vger.kernel.org>; Tue, 31 Jan 2023 21:49:35 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id be8so17390105plb.7
        for <linux-can@vger.kernel.org>; Tue, 31 Jan 2023 21:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=286OmTWlEbySW6/pGngJJjlF6WGSW5U8gGQ2oV41zjg=;
        b=RVzL+2+APv84mE5z76+evvs1yzZ3IntXDRVyNuTOqxFkuOrL3Yy11oL0QhO09ynsaS
         Yue8G4ZyOYa+83birwL82U18hHnrO9InLgETVyJt44BCcLwpJHVNWP2cioSlerggOAGn
         sCF8US20LEtFiaJma9DIEeubxzUHa9KTVBycmQoUVf+GDmqAzyA4BtfVG92xUprBB6Uh
         jTM/a+Hhce8Uf/XJNsoVI2bRZx9Cygnsi7HBSwpZ2jfE2H3tEAqhJzx/A3VvTuhaM8vy
         qAx/CG1h2k7H41RAE++DWE0gVPP4HVi+WcYIq8lEP3qHq84a+XZDiUwNTaMm7WzP8MrR
         z1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=286OmTWlEbySW6/pGngJJjlF6WGSW5U8gGQ2oV41zjg=;
        b=Ij8nPkZsa2evS4AwF3jtmakyMiut09opLijto28op26RwfXZ5jKGO/VabcFivj3wMM
         sKLdxxyR6IPWg6oSdFtCIdlC0LuZ1zvE64lDoFOAaCEh7uhpsARxFAeKQEbMX4JTO69v
         YLMpzp20R99dlBtD8xP1iWBrN291YmLfqBv8lVHnJeGX+0tIN8fdqGIeevN0T+t+Kpc8
         hEQ1nN78s2Qr4gBsvJ3lLIwB7ve5R932iudhuDX42a7mnunqeK5V4UQS1KIOW9CsKPTG
         hrjgF/01X/KNbXM9VTrJwiKIYfzFLeh7GaqvOFwmEO0K3hueHlUhG4yv9AUWuaK32TXn
         fABQ==
X-Gm-Message-State: AO0yUKXpUaeEUahGxXQ7AUO3YPShaAjuSPtTY9o1NM8Gwtc1TSafg/9c
        Np8n022G5k5DbsssgrH0PmtIw3lXtqG3HXgxFCE=
X-Google-Smtp-Source: AK7set+VpXtK8By4PcliQQAXjx1BCvM93XrgKrowaIwgjGnVfzxp0R0YZV7mXjOghegAfEuXMZc+rf5QQzor8wCFxLc=
X-Received: by 2002:a17:902:ef83:b0:195:e77b:793c with SMTP id
 iz3-20020a170902ef8300b00195e77b793cmr306698plb.29.1675230574384; Tue, 31 Jan
 2023 21:49:34 -0800 (PST)
MIME-Version: 1.0
References: <20220907103845.3929288-1-mkl@pengutronix.de> <20220907103845.3929288-3-mkl@pengutronix.de>
 <CAMZ6RqKqhmTgUZiwe5uqUjBDnhhC2iOjZ791+Y845btJYwVDKg@mail.gmail.com>
 <BL3PR11MB64844E3FC13C55433CDD0B3DFB449@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqJ8rhSVwnNHaxyRBg24PoH4EU8prEGsZO56wU6ozfMdAA@mail.gmail.com> <20230131160436.2vfszb3qqsyx3ea7@pengutronix.de>
In-Reply-To: <20230131160436.2vfszb3qqsyx3ea7@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 1 Feb 2023 14:49:23 +0900
Message-ID: <CAMZ6RqJDARUjhDF5k1DydZMr=YWU9QSXDshTwznV4oh79a7niQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] can: bittiming: can_calc_bittiming(): make use of min3()
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Thomas.Kopp@microchip.com, linux-can@vger.kernel.org,
        mark@baggywrinkle.co.uk
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

On Wed. 1 Feb 2023 at 01:04, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Finally I've found some time to look at this again...
>
> On 12.09.2022 17:28:15, Vincent Mailhol wrote:
> > Also, I was assuming that can_fixup_bittiming() was already doing the
> > out of range check:
> > https://elixir.bootlin.com/linux/v6.0-rc1/source/drivers/net/can/dev/bittiming.c#L27
> >
> > But in reality, only one of either can_calc_bittiming(),
> > can_fixup_bittiming() or can_validate_bitrate() is being called. And
> > thus, can_validate_bitrate() might be called with out of range values
> > and in that case the neltink interface should return -ERANGE (for
> > example if sjw > sjw_max).
> >
> > Sees that there is more work to do here than initially anticipated.
>
> I've converted the existing netdev_err() NL_SET_ERR_MSG_FMT(). This
> means the error message is transported via netlink to user space and
> printed by the "ip" tool.

I was not aware of this NL_SET_ERR_MSG_FMT() thing, and let me say
that I really like that solution!

> | # ip link set flexcan0 txqueuelen 10 type can bitrate 2200000
> | Warning: bitrate error 2.5%.

The Linux coding style says:

  Kernel messages do not have to be terminated with a period.

Ref: https://www.kernel.org/doc/html/latest/process/coding-style.html#printing-kernel-messages

However, I am not sure if this also applies to the ip tool.

> |
> | # ip link set flexcan0 txqueuelen 10 type can bitrate 22000000
> | Error: bitrate error 80.5% too high.
>
> This is the error message for the SJW check:
>
> | # ip link set flexcan0 txqueuelen 10 type can bitrate 500000 sjw 3
> | Error: SJW 3 bigger than phase_seg1 6 and/or phase_seg2 2.

At that point in the code, I assume that sjw was already validated
against sjw_max. While not impossible, I think that having sjw bigger
than both phase_seg1 and phase_seg2 at the same time is uncommon. I
suggest to split the error message in two and only print the relevant
one:

  Error: SJW 3 bigger than phase_seg1 x
  Error: SJW 3 bigger than phase_seg2 x

If the user still manages to violate both, only the phase_seg1 error
message is displayed.

> Maybe add a '=' between the phase_seg and the actual number:
>
> | Error: SJW 3 bigger than phase_seg1=6 and/or phase_seg2=2.

If you ask me my preferences, I will go with column:

  Error: SJW: 3 bigger than phase_seg1: 6 and/or phase_seg2: 2.

But I will not complain if you pick anything else.
