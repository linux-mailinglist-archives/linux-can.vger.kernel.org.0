Return-Path: <linux-can+bounces-3020-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CAAA56B0A
	for <lists+linux-can@lfdr.de>; Fri,  7 Mar 2025 16:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE403189944D
	for <lists+linux-can@lfdr.de>; Fri,  7 Mar 2025 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD427189903;
	Fri,  7 Mar 2025 15:02:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C652E3361;
	Fri,  7 Mar 2025 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359749; cv=none; b=nK+ZtDegd7HBVbKL7Tec4H6NxCzJNex3OvL+ES7ZiYF0VvAmogHQr8XsZ6+U3R0wEF7sd+nLF2gqcN4hzRZ1moXV4j9XaWN+ZopudF4iIaW8iG3VfoH2Ksc5nxpAGPEwH44UZhgQPWleW1/vMwYAKH97zijKJPap9K6n61GCXdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359749; c=relaxed/simple;
	bh=4Uie/zXS3L7tF99LuxDGRGBCt+N59RO6Phv2qyt3Urk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xm2Zqh8gC9KoKGoJW8dnI8C47TAMyUDWkRSh82h0G6K7uyiSEA+hF+TkeQssBp8FbLIz5/sSm4C3f/1V/hiHFCFzbczADpTF21f4thRx7Zq3XP+fPrQ/lishniTgeZ6pipJps7/e+vkj+qvqPkK3fIpQp0544P9R6YOvWiMLZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c3b44dabe0so214648385a.1;
        Fri, 07 Mar 2025 07:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741359746; x=1741964546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiFH9uYdzsVblryLFuciVRwZg7hPiKuC2x8oklo674c=;
        b=E0TNpMWHVSI5tBzcLHBEnCy+H88WwKlS7kKm1t76NZjfJia9aoZGwK19z8t1iEJmzp
         ENcviEMh+ZAM+snl0dTLppXq3wSKEHxG7NAHdL818yf7e7LkjAkroL4MPOfQtHz/n5jF
         2DqQKz77+6353QW8ucFNtJnQZHSkpUegOTK0nG2VEyRvYMqlLke728rNGeM5HmEzk0jm
         4SLTNdDwdiCPDZQTSyLNNHkD49gqvt5j1RdXSrFrSyvqDVZjbzlvNr8/LjKwi/KdZJK7
         BBf6aUEV+A5Uv/hCBD2u7gaM6lIequaTsdY6B2h6WRzo0F6ApYi7Bt85GBIg1UOc3cn3
         /WwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMyfLZ+4hsttmzanpCA4U3Qdf+h/a78F3uHC7A3Mv2AFzfWq6AApWrIv2iLxO1XfzaPATRf+ts@vger.kernel.org, AJvYcCWr1mILwgqkpU+X4Xu+BRgA07BxXWUOQLcfChSYi7ETrzPWiflkC5jYq9NTZbtwPVbW/MkZiE8MJMF96X1CRqZhvKc=@vger.kernel.org, AJvYcCXpKimYv7D5ngbP1e7wz1upBnJeSK5aOFtdSHOKi1IqaRoWz+biBqQmAzwrQ7UB0bB9M+97Kz2H2AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOAJNRepUPUDP0YxV5IAcK5LEjW7wMIPeULz8Qg1C5oUeXORx
	lFeJhqVKTpIpJlFiNy+uaBcQIMHKbRIFeBZpBSmPkDiVa0kQ8RO2jzRX8w2Wv9k=
X-Gm-Gg: ASbGncsxicRGjsLn5Iizh/R4dmEYkSrsI9nuvJWD+YepTIf6Aa2Xd/+lxXsdXXfSJZy
	530RIUUYxzoGekJRFHhguh1WQA/hG7z844GFxLponzCDM22xoWAH3zjm83IdbFQ6hvYoUzh+RUv
	ok1hhsXsjLOc1Eyx2m7JhqJE6HcKoQ4Wq/DFh/yRT67j8tLJSowKdptQMQE4JGJeHqeSoiWHDye
	i1o9vYDflVyzbNJwzEHgjD3/HA2nPqrm6aWC2YWI+zjIRCRRWdY/2uR1bubV0vhSDL23VDh8YRb
	WkPP0rjT7P/vgouZ5K87SSC005NtcWhBfhDOF/CXN0ansbteodN03W+GDAxmW7vepV81Kgep3Vw
	C6hOP3xnq21o=
X-Google-Smtp-Source: AGHT+IE+i8UKepoquQNw0QUK0tROUXyKbHh3y+odawTunVEBX4Hy3MXwQ+ab7yEWopl7yk9T8RDApg==
X-Received: by 2002:a05:620a:1b85:b0:7c3:d922:8779 with SMTP id af79cd13be357-7c4d6f92ce5mr522519485a.0.1741359745868;
        Fri, 07 Mar 2025 07:02:25 -0800 (PST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5381d45sm250564085a.52.2025.03.07.07.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:02:25 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0a159ded2so210221185a.0;
        Fri, 07 Mar 2025 07:02:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFSBZ7+cEckx2ANJrsJkEpHYzxpcUu0vhapz6/NRe2ltS9uHo0lZezrX/Wzorj4PZtnX8jLo1L@vger.kernel.org, AJvYcCVerThe2GqaP6xzGj3nWpX89dtqAlCfPAqcPPDaWdVnK0SVuVKsuC0xdGVzWQXfCnJnNqMZvufZoN5PedewGr/mxx4=@vger.kernel.org, AJvYcCWYh9gBGBD4eUmuUlQTBuD5hlncxaYdp5klRi4zXUQgGvOLfeiwPNsqtCgIespigUsltuysAo4lGxM=@vger.kernel.org
X-Received: by 2002:a05:620a:6607:b0:7c0:ae2e:630d with SMTP id
 af79cd13be357-7c4e168299dmr517902485a.16.1741359745233; Fri, 07 Mar 2025
 07:02:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220094516.126598-1-biju.das.jz@bp.renesas.com>
 <20250220094516.126598-3-biju.das.jz@bp.renesas.com> <CAMuHMdUs=+niOyBW0us=UjZTnqeYjVsLWZSmROndCO8azER=3g@mail.gmail.com>
In-Reply-To: <CAMuHMdUs=+niOyBW0us=UjZTnqeYjVsLWZSmROndCO8azER=3g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 16:02:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU2JW-LGK+uj4Y8tQc2wh2VTBJ0V+wuwt9Vwn5CzLeNuw@mail.gmail.com>
X-Gm-Features: AQ5f1Jp-_DYcdz4xzsduSARw8uJiqkAm5JOCV1qOKpSjSZe8OagMlfbKL_zHV18
Message-ID: <CAMuHMdU2JW-LGK+uj4Y8tQc2wh2VTBJ0V+wuwt9Vwn5CzLeNuw@mail.gmail.com>
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

Hi Biju,

On Fri, 7 Mar 2025 at 15:41, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, 20 Feb 2025 at 10:45, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > There are a total of 96 AFL pages and each page has 16 entries with
> > registers CFDGAFLIDr, CFDGAFLMr, CFDGAFLP0r, CFDGAFLP1r holding
> > the rule entries (r = 0..15).
> >
> > Currently, RCANFD_GAFL* macros use a start variable to find AFL entries,
> > which is incorrect as the testing on RZ/G3E shows ch1 and ch4
> > gets a start value of 0 and the register contents are overwritten.
> >
> > Fix this issue by using rule_entry corresponding to the channel
> > to find the page entries in the AFL list.
> >
> > Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>
> Thanks for your patch!
>
> This finally fixes CAN2 and CAN3 on the White Hawk and White Hawk
> Single development boards based on R-Car V4H with 8 CAN channels
> (the transceivers for CAN4-7 are not mounted), so
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Unfortunately, it does not fix CAN2 and CAN3 on the Gray Hawk Single
> development board, which is based on R-Car V4M with 4 CAN channels.
>
> > --- a/drivers/net/can/rcar/rcar_canfd.c
> > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > @@ -787,10 +787,11 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
> >  }
> >
> >  static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
> > -                                          u32 ch)
> > +                                          u32 ch, u32 rule_entry)
> >  {
> >         u32 cfg;
> >         int offset, start, page, num_rules = RCANFD_CHANNEL_NUMRULES;
> > +       u32 rule_entry_index = rule_entry % 16;
> >         u32 ridx = ch + RCANFD_RFFIFO_IDX;
> >
> >         if (ch == 0) {
>
> The out-of-context code does:
>
>                 start = 0; /* Channel 0 always starts from 0th rule */
>         } else {
>                 /* Get number of Channel 0 rules and adjust */
>                 cfg = rcar_canfd_read(gpriv->base, RCANFD_GAFLCFG(ch));
>                 start = RCANFD_GAFLCFG_GETRNC(gpriv, 0, cfg);
>         }
>
> After your changes below, "start" is set but never used.
>
> Looking at the actual behavior of your patch, the same can be achieved
> by updating start, by adding a single line here:
>
>     start += (ch & -2) * num_rules;
>
> > @@ -802,7 +803,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
> >         }
> >
> >         /* Enable write access to entry */
> > -       page = RCANFD_GAFL_PAGENUM(start);
> > +       page = RCANFD_GAFL_PAGENUM(rule_entry);

The similar fix in the BSP[1] keeps the old value of start here.
However, it does not make a difference for me (both R-Car V4H and V4M).

> >         rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLECTR,
> >                            (RCANFD_GAFLECTR_AFLPN(gpriv, page) |
> >                             RCANFD_GAFLECTR_AFLDAE));

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

