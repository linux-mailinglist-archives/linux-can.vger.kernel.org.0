Return-Path: <linux-can+bounces-3033-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E2A58EDD
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 10:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC838165652
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 09:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4682248A4;
	Mon, 10 Mar 2025 09:02:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4507224257;
	Mon, 10 Mar 2025 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597375; cv=none; b=ANHkPtlQnCOkqDf+cTQme6ZVnzHf9svIHN1wWuLq1gP2E+uYT8GDPnpxU/9gG4NrrrbOOUgBiwNHZCa9FjbBiq9zkLeDAkT8FepinhkqnSJQ6SLDIb8hK1ysGqq0KIING/hvj53JjG3E6JvHEC9wlFhpvApIinW5Vdt6ckT+RRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597375; c=relaxed/simple;
	bh=YlEcjXzMxAK3KZdJ4MWlBlw0AjI+b/aoxMOv08xWHR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwl/3E29IaY5ZukhDw6jRM6ouLSIBZ1C9N1xcrTJr5F+qvwh/7MA1WfRGSHfvYihOxhYATsfCJ63vzU8eklXBpeP2ls4FX2jl/nbXqShXOg5E03V5m2k0P6PP1EQPEFyUfS+wC4k3DoIXnK4krS+QupsR5SECDevnliWgGodqrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86d5a786c7cso469294241.2;
        Mon, 10 Mar 2025 02:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741597371; x=1742202171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bJZRNqjz2H4Bo9RErdMqnNSxSy5ONWikHW+CT6wXx4=;
        b=paamWolzWCSS8hxXxrVPvvEo4cgna4GpsMnYYRKad0/pmdOF3Tlq2H3mGjJTz46Bvc
         /KiJ8Mr2mYTPftLkcAAZKSu5Gvb52ZbQWrz5kGOHKo+I0+BhwnefGxoO+fVP+wgmVLtL
         bYneBoR6JC9Vg6brb9TuWszx/26p8XuK0EtyzwYpwGRCf6+RZtFt2hlqCkRZ7rkJovsM
         goKIk2EFWpj2+rx2XHoUdEkALWvHDdfVgU5Fv2T/0AhxZNoH5sAXoI2mdI3TQpfpDnlV
         OldlcLJjSZ9qNZOu5bgPWVF5WqYWV+ycL0g+OrYq61WahBGWM+z0lX+Et652PA+xWKwi
         oxXA==
X-Forwarded-Encrypted: i=1; AJvYcCUNtZ2quXF+6bjtBqN8Fkzi4EjMwVFt3OAA0XSQXQlE9XzodDPkPceqHEx+IU4vHGJPn5LB18gTIwI=@vger.kernel.org, AJvYcCVg+duHWoBx40fyHqesLtmy0mJX7yzqL4XAedw8FWURvNngQejorwTjXmz1WnnsuTV65J6+ot56Z9KQk+PkdZh9jwI=@vger.kernel.org, AJvYcCX5AjTiuDQHrwJlt74qww2Oy4YmPPIBQudXEfuqyT/mAHYlTRRw6XeICp92cgLWcoFGcxdnb+9H@vger.kernel.org
X-Gm-Message-State: AOJu0YwaVLChIqkU7EJCeZBuc4MN/uGnN6ZRz+ajmcOQesI9KMbEhrGY
	dEGxHCqleLOOWUFuKRQjIt9huIZPwy4JjkRognkc9PJG7yGfk1lanpp1bcL8
X-Gm-Gg: ASbGncsz5xM0Tg2EB/8+nc1m9CtdHde8Yf9tNdO2uCd96UQExmBsPOn5XHt82dyFMPN
	GhSxHicljyi4frnvjwOp+IiPYMAkOAkxwMmnJ4W6oZJSIOFSuawLgKHRE1Yuw/224g/pB3ct+Pb
	MINc9Y0i1/4mR0RURU/rGN0C4p6eCklE5tVOtBEJfsfKg3MIQ/iaopkYTh2xpT0rUoso+DEcoAR
	si2ZNxLUP3qZonepsXB71tKYzcFz7+Kc4fKCeB29a44u5hhaYET4UkWqjuVF7eEHq004wQ9Vn0q
	paO6O5d8Wt0d6DCaTMaTIvAzfzDGc8AONFBE08tnw3xCtnGPKcY5iK2+kE6OuVjhawuLo+EGX12
	+heH/7nYIqKk=
X-Google-Smtp-Source: AGHT+IGK0GwY6nS1E8HU7oNWrncpUMDVWQngUvz240NMO8wMbznpRI2wg/9Xvb6/RcI8Gq8FnUEVug==
X-Received: by 2002:a05:6102:809c:b0:4af:deaf:f891 with SMTP id ada2fe7eead31-4c30a5016dfmr6924201137.4.1741597371274;
        Mon, 10 Mar 2025 02:02:51 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb424282sm1812395137.2.2025.03.10.02.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 02:02:50 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523de5611a3so1487915e0c.1;
        Mon, 10 Mar 2025 02:02:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIHfIplolr/9Aw+PRdLZ6Cv4DBXKnr5YZiS/ZWlEXJPB0Dup4TErnNsLsxyiNoUU0TBRGmPYWv@vger.kernel.org, AJvYcCX3yxa82PZ4HK1BzUFoHGbNKKqu6yYcgdxifq/L9pp1v67Ccuc6TvxMDXrUYFkgr0yJBF3PcAgwFTM=@vger.kernel.org, AJvYcCXNA1ZEjo1pozewk8W0vEBuHsZLBwxfzn334YY1BKaY0srJRRMM6kFEhf+DvlTsJvZo0iADYcCR6rknXhCaQveXS2A=@vger.kernel.org
X-Received: by 2002:a05:6102:3c91:b0:4c3:221:8f47 with SMTP id
 ada2fe7eead31-4c30a5ec42dmr6701535137.13.1741597370391; Mon, 10 Mar 2025
 02:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220094516.126598-1-biju.das.jz@bp.renesas.com>
 <20250220094516.126598-3-biju.das.jz@bp.renesas.com> <CAMuHMdUs=+niOyBW0us=UjZTnqeYjVsLWZSmROndCO8azER=3g@mail.gmail.com>
 <TY3PR01MB113462D6EF7BDDFE403FD0DC286D42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113462D6EF7BDDFE403FD0DC286D42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Mar 2025 10:02:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUyLLCdTHkhFJh9rK7Vv5S98anw8-Cc51MafzQ5DF+V_g@mail.gmail.com>
X-Gm-Features: AQ5f1JpzOKDYhPfzHRPDBcf6oxF1UpGjWsQlxCi7lgUIq6vj77_R-7-qagn33FY
Message-ID: <CAMuHMdUyLLCdTHkhFJh9rK7Vv5S98anw8-Cc51MafzQ5DF+V_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] can: rcar_canfd: Fix page entries in the AFL list
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Sat, 8 Mar 2025 at 07:30, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH v2 2/2] can: rcar_canfd: Fix page entries in the AFL list
> >
> > On Thu, 20 Feb 2025 at 10:45, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > There are a total of 96 AFL pages and each page has 16 entries with
> > > registers CFDGAFLIDr, CFDGAFLMr, CFDGAFLP0r, CFDGAFLP1r holding the
> > > rule entries (r = 0..15).
> > >
> > > Currently, RCANFD_GAFL* macros use a start variable to find AFL
> > > entries, which is incorrect as the testing on RZ/G3E shows ch1 and ch4
> > > gets a start value of 0 and the register contents are overwritten.
> > >
> > > Fix this issue by using rule_entry corresponding to the channel to
> > > find the page entries in the AFL list.
> > >
> > > Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD
> > > driver")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > This finally fixes CAN2 and CAN3 on the White Hawk and White Hawk Single development boards based on
> > R-Car V4H with 8 CAN channels (the transceivers for CAN4-7 are not mounted), so
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks for testing.
>
> So, the fix now works on 3 different boards with channel number > 2
> RZ/G3E SMARC(6 channels), White Hawk and White Hawk Single development boards based on
> R-Car V4H(8 Channels).

Note that only channels 0-3 are tested on White Hawk, as the latter
have no transceivers mounted.

Note to self: test channels 4-7 on the CAN board connector,
using a transceiver-less bus from Siemens ApNote AP2921.

> > Unfortunately, it does not fix CAN2 and CAN3 on the Gray Hawk Single development board, which is based
> > on R-Car V4M with 4 CAN channels.
>
> Q1) Does it worked with downstream BSP?

IIRC, it did not at the time CAN support for R-Car V4M was upstreamed.

> Q2) Does it by chance is in standby mode?

You mean the transceiver?
All channels but channel zero use the same type of transceiver,
and similar wiring. There might still be a pin control bug, though.

> Q3) Does it work if you just configure single channel by connecting to an external CAN device?

Haven't tried that yet, same for logic analyzer.
(before this patch, the logic analyzer showed that channel 2 did not
seem to work at all, and channel 3 worked for transmit only, but that
info probably doesn't help much :^).

> Q4) if you are testing in loopback mode, is failure happens CAN2->CAN3 or CAN3>CAN2?

Fails in both directions.

> > > --- a/drivers/net/can/rcar/rcar_canfd.c
> > > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > > @@ -787,10 +787,11 @@ static void
> > > rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)  }
> > >
> > >  static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
> > > -                                          u32 ch)
> > > +                                          u32 ch, u32 rule_entry)
> > >  {
> > >         u32 cfg;
> > >         int offset, start, page, num_rules = RCANFD_CHANNEL_NUMRULES;
> > > +       u32 rule_entry_index = rule_entry % 16;
> > >         u32 ridx = ch + RCANFD_RFFIFO_IDX;
> > >
> > >         if (ch == 0) {
> >
> > The out-of-context code does:
> >
> >                 start = 0; /* Channel 0 always starts from 0th rule */
> >         } else {
> >                 /* Get number of Channel 0 rules and adjust */
> >                 cfg = rcar_canfd_read(gpriv->base, RCANFD_GAFLCFG(ch));
> >                 start = RCANFD_GAFLCFG_GETRNC(gpriv, 0, cfg);
> >         }
> >
> > After your changes below, "start" is set but never used.
> >
> > Looking at the actual behavior of your patch, the same can be achieved by updating start, by adding a
> > single line here:
> >
> >     start += (ch & -2) * num_rules;
>
> start is not readable at all. I need to work out from " 102_uciaprcn0140_IPSpec_v1p06_r2.pdf"
> section 7.7 to understand, what is page, rule_index_entry etc...

Thanks, and good luck!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

