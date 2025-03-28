Return-Path: <linux-can+bounces-3262-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ABEA74890
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EBC3B1785
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3539F1C174E;
	Fri, 28 Mar 2025 10:43:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D2221322B;
	Fri, 28 Mar 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158591; cv=none; b=hf8Jk0n3aN9xy+6vaLfBGr/6ncn2inILE4fQwLR+Z4iJ06/xFuKkC4FV0AGyA214CAugLRJtCc94jGUpIGSCr/D2XeDGlzLVYby3FnCQWzbyeV8DB/QUvf2UxFCtMxwm9+q43rJufk1uhBcVKwQ4etWPP7tPJ9cF9snJco/jC5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158591; c=relaxed/simple;
	bh=VnoF2Ju6tOy/xqdbkflEbTfJoMup9mQM/0QwdeFM9vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqEYU3K6Q7vK20lgsk1cU1WdhQb1OKk3KjC4GrnRmlhQXbgHZ1fm53be0YwiOp1l0JFkXl5bkZXOwUQ7L3oSlmOGtkqSu7GY1wjQO2t1xn2DQ2lnLbqwb/z2McBpBNt+0HRQDXn4Bp269ycjaJ8QYvBh7EVZGzSqBtdppjZNJmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-523dc190f95so1017088e0c.1;
        Fri, 28 Mar 2025 03:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743158586; x=1743763386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBAkx/4w8XGM/dsfSPtbusOCn505hXouL4WJRlyQs+I=;
        b=GtjM3ORujvHI5fzMpl/aSArn96SGFcmTwr5EhplVqM7C8shkWw0FHwKZh5M5N0FbpR
         XzHLp7pizskBjem27wpdqyyTMtWBWOb8qNH+tmjmC1b5nxVWwe+540mDZoVSdqe5ZyGw
         E9n5XXi2hN9evZQjpVwqnMShBSP+HoAMUXLQJzEFhY17EwrNCbmdKgXrakHm+q5ceg5j
         TPNXmh6FmDTQbEvUv4RDs9Ny3guJ0N9n0hq8kyecZJj/mafmepvUVV1YmWIB6uTl4LIj
         BI5pT/JD/YUicRnwpwlLdxNKIku242C8jQIRM7dY17ggbBL7N8KJAwk/NB5+z8huMI5f
         +DYw==
X-Forwarded-Encrypted: i=1; AJvYcCVUbLeFMatD67Pr08jKH/NLBKphxA4tnbP/3eSZ3DHAIebkGwC2XrmWJaJNL6G3f+9xLF/0pGRuFJs=@vger.kernel.org, AJvYcCW/JwUtG6bCRSw6LWEywQh4y7HTYx7T0pYX0qpdemFT4q/AQ5iilcakRLU4klSa0rTHXU7OO+9flfzcWe0038pvA7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKsGmqRM2HZQpOMDwG7gJiaJt6PMXJ52MVhviLpD91gmIOvwo6
	cvsZPehkvnbgEFjkbspjEzThqrbvg51tLc1waK1z3Qqw3Jwt3HtX0SASCrPa
X-Gm-Gg: ASbGncv3r393rzYaJ2wW6bU9jq+UwQriI69Dfo9YBiuuBL0zsYNCDTxpG1Q4Fi80+VG
	QNSpPvA7MS9/Ay3j3ZkEsegJvAVJUGBY0XO13PVTXhJXS2XnY0C3I0xedyzZqeKPRMYnnJnX3ls
	CdYMsAJymk1nLTzXX2O93PE0m65iaIXPT66+kUa3RqpYfRF4/j/f16jkCGFCrzoHmVbcRIraFG3
	GmPHomaL37os9b2S8Rv9P56n5IsjjQccK2rO/pnGrRwSNkoFAelRh5SyyMO4gynpSW+80xyrb5R
	z5s9yuP2gcIcha6MAXhhoXPotxIWE9bT6oDaCEe2YoFSexa8OSevkBryp64JK+OCJzZfrllJAMd
	NwSc7Ged6HmE=
X-Google-Smtp-Source: AGHT+IFYuzHFzP96Unr4CP1eFxlagiRf6xbLgBonKhGcbjd3xXUVVcgcRm5MAFOn90RILtPMqOVtlA==
X-Received: by 2002:a05:6102:c52:b0:4bb:e5bf:9c7d with SMTP id ada2fe7eead31-4c58707a17emr5722146137.17.1743158585491;
        Fri, 28 Mar 2025 03:43:05 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c6c010f531sm310474137.10.2025.03.28.03.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 03:43:05 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-525da75d902so879009e0c.3;
        Fri, 28 Mar 2025 03:43:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUN6Qy7eBywqMDJuqoMT2FPNoK1QpHUptT5wu5fIzhIrGEoBkdiuU9AXEXHihHRO6OP3ZKtzyXg1yw=@vger.kernel.org, AJvYcCV0if5Cxg/pTVCjSEluePvfx8WXzBGjr9zJX7toFYLjG5HURZN3/UvbPkV5gBXIDgOBMPt0YrAshDXAllcm0cag/QY=@vger.kernel.org
X-Received: by 2002:a05:6102:2c0f:b0:4bb:c9bd:8dc5 with SMTP id
 ada2fe7eead31-4c586f10729mr7091900137.3.1743158584510; Fri, 28 Mar 2025
 03:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-6-biju.das.jz@bp.renesas.com> <40392a70-3be4-4d11-8614-eebd5d9d24a8@wanadoo.fr>
 <TY3PR01MB11346C091544B49A6C160712E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <deffdc35-86cf-4282-ba6d-f36890bf9fcd@wanadoo.fr> <TY3PR01MB11346DA97D5F685D96A638DB086A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20250328-serious-orange-oarfish-3631f1-mkl@pengutronix.de>
In-Reply-To: <20250328-serious-orange-oarfish-3631f1-mkl@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Mar 2025 11:42:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXWDaJx5THFd9NB7VsTjGZgFt8JPGa+WQivSdgYVY1yWg@mail.gmail.com>
X-Gm-Features: AQ5f1JquXF7gevW02FK9rOZ8go-LSMsgjm6v928M_U3w3FbwFPSnLRx6NEN_0Hw
Message-ID: <CAMuHMdXWDaJx5THFd9NB7VsTjGZgFt8JPGa+WQivSdgYVY1yWg@mail.gmail.com>
Subject: Re: RE: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF*
 macros in RCANFD_GERFL_ERR
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Fri, 28 Mar 2025 at 11:20, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 28.03.2025 09:51:43, Biju Das wrote:
> > > Yes, it starts at bit 16, but at which bit does it end?
> > >
> > > The GENMASK() helps to document the register names. Of course is works if you replace the FIELD_PREP
> > > with a left shift, but you are replacing some meaningful information about the register name, register
> > > start bit and end bit by just a start bit value. See? You just lost the register name and end bit
> > > info.
> > >
> > > FIELD_PREP() is not only about doing the correct shift but also about documenting that you are putting
> > > the value into a specific register.
> > >
> > > When reading:
> > >
> > >   FIELD_PREP(RCANFD_GERFL_EEF0_7, gpriv->channels_mask)
> > >
> > > I immediately understand that you are putting the gpriv->channels_mask value into the GERFL_EEF0_7
> > > register and I can look at the datasheet for details about that GERFL_EEF0_7 if I want to.
> >
> > Gen4 has 8 channels (GENMASK(16, 23)
> > G3E has 6 channels  (GENMASK(16, 21)
> > V4M has 4 channels  (GENMASK(16, 19)
> > V3H_2 has 3 channels (GENMASK(16,18)
> > All other SoCs has 2 channels (GENMASK(16,17)
> >
> > So you mean, I should replace RCANFD_GERFL_EEF0_7 with a
> >
> > Generic one RCANFD_GERFL_EEF(x) GENMASK(16, 16 + (x) - 1) to handle
> > this differences
> >
> > Where x is the number of supported channels(info->max_channels)
> >
> > and then use
> >
> > FIELD_PREP(RCANFD_GERFL_EEF(x), gpriv->channels_mask)
>
> The mask for FIELD_PREP must be compile time constant.
>
> Geert recently posted a series to add non constant helpers:
>
> | https://lore.kernel.org/all/1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be/
>
> It seems it wasn't applied yet...

Yeah, people keep on asking for more...
#perfectistheenemyofgoodenough...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

