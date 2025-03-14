Return-Path: <linux-can+bounces-3095-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C96A6148E
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 16:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429113B8882
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 15:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB601FFC51;
	Fri, 14 Mar 2025 15:12:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733A0200119;
	Fri, 14 Mar 2025 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965140; cv=none; b=KHzr15LmToOrbdPzgUATezaTrNT2H9ea5M16yhwizRLtR0bMUIFa3tVLGTD7yobX7H4DwJNgH4SwdRJq/qzudn5LpCaCIfX5cQNv9mDXIHSzqZR617CfD9nr4wB2TYnlJ/H4hFPUOzTsKCbg49PLIZKQB9SwpLK/rWZSdfFC2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965140; c=relaxed/simple;
	bh=gr+cnPOXE1saaUEc7WbgjvFxZxiO3bUeQQx/U+tRLLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qismeALHwSk6aH01vDBw5YseO4FemX3r6cxYCawBqjehcmqS/c7JNTbkiE7F3SKmUzuiHtissGI2ZrCCATHZmU/AK2m3n4+x1XnJrXtG/JuYKkp3z6Xc2jxlyKRNae1aeVv3rkPsCAR87gm6XdrHFTye3Qd8Vs0RgS1u2rMhEQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86d42f08219so885550241.0;
        Fri, 14 Mar 2025 08:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741965136; x=1742569936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7iWEBY2g2GtCZSO5WTBv1gbwohDo0uhlMsm9anzyJVM=;
        b=NQ9j8SakXWEX/ATKJRJkpKkKZs1O30Ue6EgDMkV6dzkUVhLmQEtUKpBr+/J6Z1DFjI
         TDj5le7mjpbE8V46EbFXbit1BgTKn/p3TSbdR3vkQ7jJHD0oH3KrqQCPyqpICWZOcOEA
         2uCf7g0DcAimiLRU0QwQr4AI39T+ftrAB0j7LCm+1Et8/E1uKfk69gsB9ASyiDT5AtfH
         LFAfe+xvGDgezoKo0+Ov01vdGWw8wQD7VjG6pOuNpXLiPIw++JZUiO2nhzcxqgDA406m
         PDWKWIQgtx/9CJvsvv+SdcWkWLGn/S9C3JEUWhZTJE8voyji1weuhUzWT5T8rGs2PPEp
         b2kw==
X-Forwarded-Encrypted: i=1; AJvYcCVdgGtiIdG6C2CmCn4e3SFMfuNHPpdWMtmYwXLDI3juSEwMV9pKxDtlnuKTzIDGtMrYQYQF85uaz0d3ATI4m8ALisI=@vger.kernel.org, AJvYcCVx0SkOkTfX1fz/ZZQOlvNEUNpb4nZc7O9u+eaL+/GfluDzfvHSObwaQ3RL7sr/HouNpr6HaFGwNXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVBzkEvwWqOv85Ti9Z8rOwZlozZSb4vPWtNRdNdRfJGUGiy5yl
	wURl6xu6B19v5U//IF5wsxd9CGNZALfQuWmykVFWqEySXzp5SQCDrKt7HTMN45c=
X-Gm-Gg: ASbGnct5iBrcyFT1ebGKNsNdAJ1bncPgaiCL0ZMjxlWqaLzjMvBUrbkfkLWiF6h+ZhC
	Hv0os1S378uzlvL89poIA1tsI7vzehnVdHV9lZCb+W63LEdUsLqQTPouUgbqf7oCweJHekF/MNn
	nlLG/UwQyZJuNxDFqz6gGAUWvwFMqGve5cN4+/HINyvMlDu8C850B2jqa2eJZdyZJg4oeZgjspy
	E2RCgE04mQEMvq9RVLXt2kpIDVWEq/RTyEtt0TKBX5jllJaIl+CnNSbT5T1HfAbnPF9AhdpEB3c
	CSOgr+DKmaQohupl3Bfi5z9S+YIlWnw4k0+j8eNuKWHd4vCmG62pydo2Nf2gsFVpL2PpjpDobJe
	f4JRIt54=
X-Google-Smtp-Source: AGHT+IHEC6OkEgvuK4vmBMg2ZswACQmGWiT9VgpNJWDAfa7DE1Q3uYA3zpAe6Tz8tny98n81iym52A==
X-Received: by 2002:a05:6122:3d13:b0:520:42d3:91c1 with SMTP id 71dfb90a1353d-52449a48ccdmr1623570e0c.10.1741965136131;
        Fri, 14 Mar 2025 08:12:16 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a6e5ecdsm589135e0c.29.2025.03.14.08.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 08:12:15 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86c29c0acdfso1053493241.3;
        Fri, 14 Mar 2025 08:12:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7M621sqM9OsFq0Klf2gj2Pv9h7cjFkt4NqBQzCC7Q3cUQRwweW67C89nZiJGmZlc0YkVZksAGOVoPb4vljr1tGuM=@vger.kernel.org, AJvYcCXC3ba/f/92uL5GSHCumrafhsvZ7GDmdKess7043tf28FsRnWJrg4F6LgPH52vU9jrscKqHehw1I5w=@vger.kernel.org
X-Received: by 2002:a05:6102:41a8:b0:4bd:22d5:fbd7 with SMTP id
 ada2fe7eead31-4c383163676mr2218537137.11.1741965135232; Fri, 14 Mar 2025
 08:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250306124256.93033-12-biju.das.jz@bp.renesas.com> <CAMuHMdX_SxAh-T0UzGvJ2rZ=6r3uyDrpHmyVgn1Fv5r51Tpyog@mail.gmail.com>
 <TY3PR01MB113467E7730F505783F3E642286D22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113467E7730F505783F3E642286D22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2025 16:12:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVyUV3kMFiwA+0LyttXKxRgJiW6JfJUrVDg-LnoKa9rLg@mail.gmail.com>
X-Gm-Features: AQ5f1JrZigD6rHe9w_E_F32LjURdnQvgFE5RjbhJ8MuunWGS5432W8nNwjx1i7E
Message-ID: <CAMuHMdVyUV3kMFiwA+0LyttXKxRgJiW6JfJUrVDg-LnoKa9rLg@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] can: rcar_canfd: Add RZ/G3E support
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 14 Mar 2025 at 15:59, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Thu, 6 Mar 2025 at 13:43, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > The CAN-FD IP found on the RZ/G3E SoC is similar to R-Car Gen4, but it
> > > has no external clock instead it has clk_ram, it has 6 channels and
> > > supports 20 interrupts. Add support for RZ/G3E CAN-FD driver.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/net/can/rcar/rcar_canfd.c
> > > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > > @@ -1979,6 +1991,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
> > >         u32 rule_entry = 0;
> > >         bool fdmode = true;                     /* CAN FD only mode - default */
> > >         char name[9] = "channelX";
> > > +       struct clk *clk_ram;
> > >         int i;
> > >
> > >         info = of_device_get_match_data(dev); @@ -2068,6 +2081,11 @@
> > > static int rcar_canfd_probe(struct platform_device *pdev)
> > >                 gpriv->extclk = !gpriv->info->only_internal_clks;
> > >         }
> > >
> > > +       clk_ram = devm_clk_get_optional_enabled(dev, "ram_clk");
> > > +       if (IS_ERR(clk_ram))
> > > +               return dev_err_probe(dev, PTR_ERR(clk_ram),
> > > +                                    "cannot get ram clock\n");
> > > +
> >
> > clk_ram is unused.
>
> clk_ram is local variable and is used for error checking.
> devm_clk_get_optional_enabled() is dev-res managed clock
> and the will be enabled during probe() and get disabled during unbind
> similar to "fck".

Thanks!

> Am I missing anything here?

No, I had missed the "_enabled" part....

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

