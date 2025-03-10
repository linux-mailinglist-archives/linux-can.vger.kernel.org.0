Return-Path: <linux-can+bounces-3032-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF34A58EAB
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 09:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAEB188C816
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371F122423C;
	Mon, 10 Mar 2025 08:56:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833BE1A724C;
	Mon, 10 Mar 2025 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596967; cv=none; b=oSN3ml6WRDLtQ0T7X8E7Td1YKPKI7PzqS2r6FsOfurZMjhi9pz2G+TyByPpOYU67flxDb2aX9GTWMY+dnSFAhKJKP+eo9Qd+ZeFe9xXXI3wJpXM9NvWER1jBDBEJJmV2gqreqMcwwXC7xjRXiuMGz5LIhw11Mg6MNedGtFObmdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596967; c=relaxed/simple;
	bh=zm1uCCw5br8R96XpzbymPnTV8ASQ73LyltBb7kJpJww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gr1+Lvs98kVip797NULedbgPYdzaax25aWQR9Cjrer7xsltLNp4tP5j1qXe/JYqtslJfpyX7YDyOpHo7wsS4qV/G1t84uYnjzTBySiFIIn6hoOOVmaqid1dMB1AdYKZc0ZyUukW7X4CdntI+CDhPlRKBoDBHL7muF+JvkyCcm1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86b9d1f7249so3156683241.2;
        Mon, 10 Mar 2025 01:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741596962; x=1742201762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9qOEgoHD2ZOm0Tdo+UKnJiqz4fDlnLBAdr7n9Lr6XU=;
        b=JFBczOaPYhB62W3jE23JkVuCKYAAwjzVYu4EKBguDunyMGDAv4XNWk04hoeHSWnGnt
         CuoUR3JR4FURM1EU3wM3+yAPIM9j8V+HnLilIohePx+icuS3koTtvHRc3x5zVAN4AXSU
         rrb6r6/7JGX5jxBfdC4yYod6wxVG4s1nUX6eMsWOyu9XTCOYhZNFoEm+hYkWNPI2x2+Y
         IYW6J6926XhUTMhEXn6lgo5m5V8bJTe3CgdMqzfRbQMTf61KkeQdJyYkcmOefb/wLlKP
         dvQaLjhRDmFrcaXR63o/UFadmg+7UssDPvzAxD+BamGdA9RS2gieHAEmiz41zKVrrU2x
         1niQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKwYO4U6NhqbwSTS4K55eEuiyL0QQXbMCQC3pzxT6LJMKEPAreX0t1p0kWH4/7fqqhp8SudcWFDI0=@vger.kernel.org, AJvYcCWMkoWxRUJ2nMNmDNy+EVMoJUaPpEznuR8zWUgxAMRjqCYMhu35v9wdw7fb+d7vR/mB+9NgSaSo@vger.kernel.org, AJvYcCWz/EzHmpr4ng8nNYMcssrkV6M4biXj3BV34y3OC3j7SygwpOgc+EEfigK4GQk+Toma1/okR5CEb644TqRvFF940Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Js91eRL7NeVFjAjMf4ejwQYFEGe5jgyVmqegBqdKma4tvxJN
	5xRtNFQsv7inbxMpeHDaKoBFNqH2MkEShRFjE6P2G0atnFductxtiuwzkI67
X-Gm-Gg: ASbGnctuyP6mM2D9PZTTe6STN8goi/waK7+HfeAKed/J2mRiY5R7N/i+6Hlg+6WDPqT
	EWUTNNpXNHDVf823908GaJ8wIqJtg8ZEnjEMDfhL58zOIhmBwiVwJWaA4Dp2gkuzjyRpWS25uPh
	JcRLxoVeNDO4ZOZN1XOEPHFK7pZoZazbRspoi89br/aPSso3X57oEFtGxjIFEiR6zgiuU98hvTd
	A1e5543IHK2ceFy4aV5C8FK/ocfhUqgefszr6FZIHdUpcKNFOhthF20mJ6mnlIUIhAgfZ09GKdS
	PXWtO4d4z0zabb+sCioSRjvZn6mzo+r8Sh68u4Nwsb3N6r9dMgWMVCrbwSMExrOW4eIr6pSKxzz
	C0ucFkJM=
X-Google-Smtp-Source: AGHT+IEhwXR/fZUMNKgrz8kaD82Wwkg8faYZL0hStgYOvmBR5Y69N3EXoh8Em1so7R093UwGpo4beA==
X-Received: by 2002:a05:6102:cd3:b0:4bb:e1c9:80b4 with SMTP id ada2fe7eead31-4c30a36790dmr8344918137.0.1741596962514;
        Mon, 10 Mar 2025 01:56:02 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb4217e4sm1823429137.4.2025.03.10.01.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 01:56:01 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86d2fba8647so3716590241.0;
        Mon, 10 Mar 2025 01:56:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2AK0Mo4c0IfJbCiCYWMgIsfhlvgDVRD9nHN3YXkMc6o/HQae2HFphJp6BAoqPPiAxewpqHcZdVA9Iraq2Mn3wxqk=@vger.kernel.org, AJvYcCVP7C1aXH3CHIFCAPB8UbUadR6ecScB3jbPmAuSr7fbVemq41yAOQ0wqIScJkEFozHWYXWCr9aC+zY=@vger.kernel.org, AJvYcCWANjHTIzSRp22u8iPKw3iUqkOKz/bv42t+0naAObjHkAayVZCehip2lD/bUIvWFbnN6Fm8d0pl@vger.kernel.org
X-Received: by 2002:a05:6102:1613:b0:4bb:d062:452 with SMTP id
 ada2fe7eead31-4c30a537426mr8549471137.3.1741596961465; Mon, 10 Mar 2025
 01:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220094516.126598-1-biju.das.jz@bp.renesas.com>
 <20250220094516.126598-3-biju.das.jz@bp.renesas.com> <CAMuHMdUs=+niOyBW0us=UjZTnqeYjVsLWZSmROndCO8azER=3g@mail.gmail.com>
 <CAMuHMdU2JW-LGK+uj4Y8tQc2wh2VTBJ0V+wuwt9Vwn5CzLeNuw@mail.gmail.com>
In-Reply-To: <CAMuHMdU2JW-LGK+uj4Y8tQc2wh2VTBJ0V+wuwt9Vwn5CzLeNuw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Mar 2025 09:55:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXS+mWjjT5JsFarWTcNam7qGLGOgjx7dY_WVyADoD9S=w@mail.gmail.com>
X-Gm-Features: AQ5f1Jp8hwfq5J7BQvgCygoye3phUk6XXqY-1H4IS6iRHcBk3n8163xKokNuEQk
Message-ID: <CAMuHMdXS+mWjjT5JsFarWTcNam7qGLGOgjx7dY_WVyADoD9S=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] can: rcar_canfd: Fix page entries in the AFL list
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Mar 2025 at 16:02, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, 7 Mar 2025 at 15:41, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, 20 Feb 2025 at 10:45, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > There are a total of 96 AFL pages and each page has 16 entries with
> > > registers CFDGAFLIDr, CFDGAFLMr, CFDGAFLP0r, CFDGAFLP1r holding
> > > the rule entries (r = 0..15).
> > >
> > > Currently, RCANFD_GAFL* macros use a start variable to find AFL entries,
> > > which is incorrect as the testing on RZ/G3E shows ch1 and ch4
> > > gets a start value of 0 and the register contents are overwritten.
> > >
> > > Fix this issue by using rule_entry corresponding to the channel
> > > to find the page entries in the AFL list.
> > >
> > > Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > This finally fixes CAN2 and CAN3 on the White Hawk and White Hawk
> > Single development boards based on R-Car V4H with 8 CAN channels
> > (the transceivers for CAN4-7 are not mounted), so
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Unfortunately, it does not fix CAN2 and CAN3 on the Gray Hawk Single
> > development board, which is based on R-Car V4M with 4 CAN channels.
> >
> > > --- a/drivers/net/can/rcar/rcar_canfd.c
> > > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > > @@ -787,10 +787,11 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
> > >  }
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
> > Looking at the actual behavior of your patch, the same can be achieved
> > by updating start, by adding a single line here:
> >
> >     start += (ch & -2) * num_rules;
> >
> > > @@ -802,7 +803,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
> > >         }
> > >
> > >         /* Enable write access to entry */
> > > -       page = RCANFD_GAFL_PAGENUM(start);
> > > +       page = RCANFD_GAFL_PAGENUM(rule_entry);
>
> The similar fix in the BSP[1] keeps the old value of start here.
> However, it does not make a difference for me (both R-Car V4H and V4M).

Sorry, forgot to add the link
[1] https://github.com/renesas-rcar/linux-bsp/commit/e9ba9ac6fe77baa3

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

