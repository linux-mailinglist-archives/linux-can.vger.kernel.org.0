Return-Path: <linux-can+bounces-838-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 176889123A5
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 13:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE02E28ABAC
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 11:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA591174EFC;
	Fri, 21 Jun 2024 11:28:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F471173335;
	Fri, 21 Jun 2024 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969295; cv=none; b=SQKd1hGZlZJ/jLDUWWBZVuo3kuDyPymC5bKugIFDX2rhE3/U0lsiilJla2gIkRZsDwb2U37YhKbwJpXQOdATQblQshADngxi1IZ4n0X0jqC8Ramwe+5UrMSEXGG8Z6+NBoF6o8agTbB96CWqyvsGlWmOGdIImtcbXGc9V2XsZq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969295; c=relaxed/simple;
	bh=SEvL4lGitM1kzXkEUz1eovKJta8wJVbr/Oc6AjkPQYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r25Bz2RaEH+MQuQfCksUmoNS762T1srWKjJ+YJX4XiHIir1Df5B8go/UOdUvettQMdnBvpW+v4bwZnQGtiWjITPLTdlfSFjEI3eCQGhgpJJpTyog3pBl8EVGpQRJvQKOzo7EVptiElcxyAeCqcVa9NaxIgmg5lJPHKV/9eo4qfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-632bcf111ffso18698217b3.3;
        Fri, 21 Jun 2024 04:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718969291; x=1719574091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JmBvwH27lm3rF7bqIM0/a1ijP5ERqLEiQexLVnftvM=;
        b=AOJqNrUo1SicMO8Iwtdm2Y4A73oCMON6GCwn9L3EHa8JNe1uzQCtQS2PNcXz47NyxR
         /hK2w8QKZyXEb6oZi1Aw3ma2TrONdkMMGp0beM1/8V7JfEnbXkXN4XYB5sZLsMWrbLQQ
         LkjX7rw5I18HBFrhMDuE5gYtB2NYTsGhrlGMjkqzKSChy3yVdLfFVt1TLRndz9+IQ1iR
         veR41v+Xszc/W3BJR8QEg20TBuAtHvQUQ0KrFMC7wZPnNIRlx/NJ7BD9FakNM1af+JN0
         7q3/njtkkUkK3hBEdKb+VNs/dEFI9fO0agekKzIYINxDDsBTagVVT/jtlOd4VbG4GF5n
         riJg==
X-Forwarded-Encrypted: i=1; AJvYcCVnOhgiyQYNRoflOCdM51TLMviOUT2B7sYVCsnGLP5HaT/klQxJI2Os0SqzB1pDf8tHDRdU3zw3L4P4Wgh0Bvd7EiQmahSf2oAUcJkD6bvg5dlBnLMY3J1gE/sysuGopYZzPCRDP2E/OKntFZb9Btdn+PMcGSBfgBXBJD58PLENAvxRpFk=
X-Gm-Message-State: AOJu0YwaDt6Ling59jOQo8znY4If+RhrKORTJ9JohEUb1+/NUPTHWGwc
	miKWK3vVANqxnyBD76/97MYuVB6qODeLJ9WxSX+kJYrJxxHpOBwUbc91BYx5
X-Google-Smtp-Source: AGHT+IHCHl7FzT7G8CfPtNWszmGHzaGVtNnCFLKGDVJWV4DTbgEDfocEXu/AAJNN+g9Z93bo4VEy2w==
X-Received: by 2002:a81:bf54:0:b0:640:bd69:e15a with SMTP id 00721157ae682-640bd69e17amr1686667b3.40.1718969291387;
        Fri, 21 Jun 2024 04:28:11 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63f15f66f5asm2737737b3.146.2024.06.21.04.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 04:28:11 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so1763296276.2;
        Fri, 21 Jun 2024 04:28:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVw85Jl481kFUA5fGtJSzbKTnTwlA96m9l0fIpUE8/nskEDlveFtrAT6bIWyLON99hDytGF+u0x3iGUSxtLEF3vKNvSE+b/je6avvP/9WLWBW1xN+vKgfUvxkcj2P77FJeZK5W8yEYrRKSPvVtsx7PgGuUPR7x9eiD9R04Wc94fNv+o7UI=
X-Received: by 2002:a25:b106:0:b0:e02:bf87:7cc7 with SMTP id
 3f1490d57ef6-e02bf878897mr7718264276.64.1718969290736; Fri, 21 Jun 2024
 04:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716973640.git.geert+renesas@glider.be> <2cf38c10b83c8e5c04d68b17a930b6d9dbf66f40.1716973640.git.geert+renesas@glider.be>
 <CAMZ6RqKZdo1Mk=tY-vqCm0YYr_Qk8m53+LHXqeM+1LL=S=+RqQ@mail.gmail.com>
 <CAMuHMdXV9q2D=Mhfi7s4NBuvivxBap-k_pkm4pUseoUb3SLWqQ@mail.gmail.com>
 <CAMZ6RqK32+i69Rd3qDDNm4cgQa3+m3ikZTbpt5jCGrkNt76+vw@mail.gmail.com>
 <CAMuHMdWCAU7VK97d3yOALpgg7S9+Aa3ZKwC3VVsivUev1iA+Ag@mail.gmail.com> <20240621-sensible-cerulean-pheasant-0a64e7-mkl@pengutronix.de>
In-Reply-To: <20240621-sensible-cerulean-pheasant-0a64e7-mkl@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Jun 2024 13:27:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUpbZBzpU=qAL5dNCq5WVgmdqamAjc=syHzzNZLZ2Y1WA@mail.gmail.com>
Message-ID: <CAMuHMdUpbZBzpU=qAL5dNCq5WVgmdqamAjc=syHzzNZLZ2Y1WA@mail.gmail.com>
Subject: Re: [PATCH 1/3] can: rcar_canfd: Simplify clock handling
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc,

On Fri, Jun 21, 2024 at 10:36=E2=80=AFAM Marc Kleine-Budde <mkl@pengutronix=
.de> wrote:
> On 06.06.2024 13:38:24, Geert Uytterhoeven wrote:
> > > > > > @@ -545,8 +539,8 @@ struct rcar_canfd_global {
> > > > > >         struct platform_device *pdev;   /* Respective platform =
device */
> > > > > >         struct clk *clkp;               /* Peripheral clock */
> > > > > >         struct clk *can_clk;            /* fCAN clock */
> > > > > > -       enum rcar_canfd_fcanclk fcan;   /* CANFD or Ext clock *=
/
> > > > > >         unsigned long channels_mask;    /* Enabled channels mas=
k */
> > > > > > +       bool extclk;                    /* CANFD or Ext clock *=
/
> > > > > >         bool fdmode;                    /* CAN FD or Classical =
CAN only mode */
> > > > >
> > > > > Notwithstanding comment: you may consider to replace those two bo=
oleans by a:
> > > > >
> > > > >           unsigned int flags;
> > > > >
> > > > > This way, no more fields would be needed in the future if more qu=
irks are added.
> > > >
> > > > Using "unsigned int flags" and BIT(x) flags would increase code siz=
e
> > > > by 8 bytes (arm/arm64).
> > >
> > > I am not sure where you derive your figure from, but looking at the p=
ahole:
> >
> > pahole shows the size of data structures.
> >
> > > > Using "unsigned int foo:1" bitfields would increase code size by 16
> > > > (arm) or 12 (arm64) bytes.
> > > > So as long as we can fit more bools inside the hole, it is more
> > > > efficient to do so...
> > >
> > > I do not get this either. Where did you get your 16 bytes from? If I =
do:
> >
> > I also looked at code size[*]: while storing bits takes less space than
> > storing bytes, processing bits may require more instructions than
> > processing bytes (depending on the architecture).
> >
> > [*] size drivers/net/can/rcar/rcar_canfd.o
>
> You have probably used "scripts/bloat-o-meter" from the kernel source
> for this, right?

Not this time; I used "size" from the binutils package instead.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

