Return-Path: <linux-can+bounces-4671-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9628B54551
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 10:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EDE5B60A2D
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BB52D8382;
	Fri, 12 Sep 2025 08:27:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0509C2D6E5A
	for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665639; cv=none; b=B9RCgQa9q0u7B4mMKeOL0bImuL2K5RvK3VKiFVoqO+dEY3B7DwRBo/t4ZM+48wcrARQkI9Lgz1nB2IDwD7mXsx9rCCKwjHnFehtFVHkBHvQ796igOh84GlRNsxWAcV8MltFXVwTAEZ0W3vHMxcBHTwWUCq+ErKSAKx2DLBBhz8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665639; c=relaxed/simple;
	bh=rPlm91W0zx0lVppYs1CxSHj4tmUuYrI4z38Rx5YJFZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pB0jAxzfkLfbf1NmdH4z2uMiMoAx+Ojs6sEDy//JiSouOizaWgWURtI3ZcxjFtwxPLDql72gVmmZZUvjN9+Fi9jCq8sLBL8T8H1N3BVgVesi5ManGveNZ9K99vJlSUJ6/ymObmAZezrPQCuJmaLwFoMrm6XfPdUbs/1H8wVmUtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-52eb6872bd2so781471137.3
        for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 01:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757665633; x=1758270433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dw+rt+iyBk5pp2tm7bKOL8mJupu0qbCu/uLdjMNZyww=;
        b=o10RQzVHjdEnPYr4/B2G1rvMT06YhR6iPiOL78UwvhcE6Ehu76nKk2uQdh5zxkjA0g
         Qw35ckOSELugz/R9RknBwo0h/3lI2aaxQTu5n3tjMj+tL3ApzQC61DyAvgJCbA9nYaX+
         NrDN7i9yiRETrczyqcjZI3Tpn43X7VkpsEZDZBCpDLD7mG7lqud4QtZn01S7Ausnages
         0rbwheRelV0YwoK4b+BKivEHYeC19uRN21W3s7jjEChRkLWbEIJPkULRDmhl7EzFdbwk
         HtEgQFUv15OaXWziz8Hi/lNSuxLhINWnuACWV19TIjNFJM02rT5ycj0uuv/KiSRPJSon
         gyUA==
X-Forwarded-Encrypted: i=1; AJvYcCWmVzw+31dH3cVyaBxhnxrhsD0nxoN4iCcupkgMVTx8LNmOSW61JcRH59Xno/xrJwsxk0q4NLZm/cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXFa56bp7jfe6wvGxEbv+Fd7fCWcBOLDcK3KdB5dH+56GAtZTE
	uYplELPlpmtNJqPJRw6GejJSv7iicaqk40wfVt94HxXMb6eqZ0aEMJNiIPejVOZt
X-Gm-Gg: ASbGnctmxIOSKumrZj1NWYD04VH+WmxDNxqX4mYoFGRIDB7xg9YFJbUXMi28MY7PbKE
	tRoflzQZn5YFl6ovizhtqbmM5yFy0VdEVP/mYlc1azrwkflrH0nhF1mKZoQDg1cC9h4exo9+qoY
	v9E7kdJtus+GbFEYc/GQl7WXBGFCSOcLFdk0WUN9HN8psF0Kq10uUZlR+nvj+nnYxOL9dzT0x29
	0aXUIiHcJhIs9r/36aC48zf/6gOyYCt2hYOfQyTWYsD9+VdR50ocq5lpju5xjwChxyDR55TJHkX
	tbrOqm1eF0mCb1sunbEEzScwrjYUa9zSqz5dJprJf8OW5eVKp4TLz25tSPPc3XzSbZrP4jjEyGc
	DgZCPv2M8c30pRRTECQ/T0ZVfwQxzgmCES3ncQT8dqxxDGlPFOkANjb8F4O5qyiH+9zE6GBA=
X-Google-Smtp-Source: AGHT+IH3+2DOpNnsb+bsxlkq1BbAbxbNlVG+/+sPzSihBzIG5UlNpA6WJHHNHBTgVyTatM9Hfoe7Rg==
X-Received: by 2002:a05:6102:3050:b0:533:ff66:69a1 with SMTP id ada2fe7eead31-5560918847dmr694220137.6.1757665633394;
        Fri, 12 Sep 2025 01:27:13 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-55375d5bd54sm855883137.14.2025.09.12.01.27.13
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:27:13 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-52eb6872bd2so781468137.3
        for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 01:27:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUU9uJfHqMpjUJ2+TPTl5TjtZBdkGRgjJJ2bn1coqV7tlk4ojt6VT/VsnHNDzsZYF/De6WInjRwYaU=@vger.kernel.org
X-Received: by 2002:a05:6102:50a7:b0:524:bd1e:bcf2 with SMTP id
 ada2fe7eead31-5561119ee74mr779739137.35.1757665632776; Fri, 12 Sep 2025
 01:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755855779.git.geert+renesas@glider.be> <f9198ea3be46f1eb2e27d046e51293df7fb67f46.1755855779.git.geert+renesas@glider.be>
 <TY3PR01MB1134652A3383410EB50783E3A8608A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB1134652A3383410EB50783E3A8608A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Sep 2025 10:27:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXSVtgGkv6_=ixdBOcTRFHtPxPGxKLGJtV59v4pHBBR0w@mail.gmail.com>
X-Gm-Features: AS18NWABhW1LifViex4oQ6Jd3RNhJjWXAXEhORT-Lh_o6tOSVSNEKZQYYqXS88U
Message-ID: <CAMuHMdXSVtgGkv6_=ixdBOcTRFHtPxPGxKLGJtV59v4pHBBR0w@mail.gmail.com>
Subject: Re: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 12 Sept 2025 at 09:54, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > -----Original Message-----
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > Sent: 22 August 2025 10:51
> > Subject: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
> >
> > On R-Car Gen3 using PSCI, s2ram powers down the SoC.  After resume, the CAN-FD interface no longer
> > works.  Trying to bring it up again fails:
> >
> >     # ip link set can0 up
> >     RTNETLINK answers: Connection timed out
> >
> >     # dmesg
> >     ...
> >     channel 0 communication state failed
> >
> > Fix this by populating the (currently empty) suspend and resume callbacks, to stop/start the individual
> > CAN-FD channels, and (de)initialize the CAN-FD controller.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Tested-by: Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>
> With adaption to RZ/G3E for ram_clk [1]

Thanks!

> > --- a/drivers/net/can/rcar/rcar_canfd.c
> > +++ b/drivers/net/can/rcar/rcar_canfd.c

> >
> >  static int rcar_canfd_resume(struct device *dev)  {
> > +     struct rcar_canfd_global *gpriv = dev_get_drvdata(dev);
> > +     int err;
> > +     u32 ch;
> > +
> > +     err = rcar_canfd_global_init(gpriv);
> > +     if (err) {
> > +             dev_err(dev, "rcar_canfd_open() failed %pe\n", ERR_PTR(err));
>
> Typo: rcar_canfd_global_init

Oops...

> [1]
>
> biju@biju:~/linux-work/linux$ git diff
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 57ac90e57f11..cb358a4e49d0 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -468,6 +468,7 @@ struct rcar_canfd_global {
>         struct platform_device *pdev;   /* Respective platform device */
>         struct clk *clkp;               /* Peripheral clock */
>         struct clk *can_clk;            /* fCAN clock */
> +       struct clk *clk_ram;            /* Clock RAM */
>         unsigned long channels_mask;    /* Enabled channels mask */
>         bool extclk;                    /* CANFD or Ext clock */
>         bool fdmode;                    /* CAN FD or Classical CAN only mode */
> @@ -1983,10 +1984,18 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
>                 goto fail_reset2;
>         }
>
> +       /* Enable RAM clock */
> +       err = clk_prepare_enable(gpriv->clk_ram);
> +       if (err) {
> +               dev_err(dev,
> +                       "failed to enable ram clock, error %d\n", err);
> +               goto fail_clk;
> +       }
> +
>         err = rcar_canfd_reset_controller(gpriv);
>         if (err) {
>                 dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
> -               goto fail_clk;
> +               goto fail_ram_clk;
>         }
>
>         /* Controller in Global reset & Channel reset mode */
> @@ -2026,6 +2035,8 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
>         rcar_canfd_disable_global_interrupts(gpriv);
>  fail_clk:
>         clk_disable_unprepare(gpriv->clkp);
> +fail_ram_clk:
> +       clk_disable_unprepare(gpriv->clk_ram);
>  fail_reset2:
>         reset_control_assert(gpriv->rstc2);
>  fail_reset1:
> @@ -2045,6 +2056,7 @@ static void rcar_canfd_global_deinit(struct rcar_canfd_global *gpriv, bool full)
>         }
>
>         clk_disable_unprepare(gpriv->clkp);
> +       clk_disable_unprepare(gpriv->clk_ram);
>         reset_control_assert(gpriv->rstc2);
>         reset_control_assert(gpriv->rstc1);
>  }
> @@ -2153,10 +2165,10 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>                 gpriv->extclk = gpriv->info->external_clk;
>         }
>
> -       clk_ram = devm_clk_get_optional_enabled(dev, "ram_clk");
> +       gpriv->clk_ram = devm_clk_get_optional(dev, "ram_clk");
>         if (IS_ERR(clk_ram))
>                 return dev_err_probe(dev, PTR_ERR(clk_ram),
> -                                    "cannot get enabled ram clock\n");
> +                                    "cannot get ram clock\n");

I guess this should be folded into "[PATCH 3/6] can: rcar_canfd:
Extract rcar_canfd_global_{,de}init()", or even better, inserted as
a new patch before that?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

