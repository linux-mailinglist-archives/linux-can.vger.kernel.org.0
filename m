Return-Path: <linux-can+bounces-3018-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19564A56AAE
	for <lists+linux-can@lfdr.de>; Fri,  7 Mar 2025 15:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBAA16BB73
	for <lists+linux-can@lfdr.de>; Fri,  7 Mar 2025 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F721ABDC;
	Fri,  7 Mar 2025 14:42:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A051521ABC3;
	Fri,  7 Mar 2025 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358529; cv=none; b=TTG+kYhrC9dX8ZX6N1RvNRZmUFYFRYfbgIFrrgIixDGY6H60On+1/i/rB8081FnjUOxE2Sq6vEh4EI93HKg8r5kFbNMwJ/teIjiD+ftW/q2e6y8XhdSVOXl/gYFAIyu0mT8xYAohEzTVMWb/fFyYeC2Dx+VXNSJZIJ68yNHqcsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358529; c=relaxed/simple;
	bh=ynPWJxU7R/OSvEcl4gV0+dngZYdAwZxjc1eotzFUxxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrX/2uAbErpHDZKfGfsGNwqtr+1VN+QKJV94eSnc4Hrh6MbtjBtd29UP2SM+cUVPBgUFUTFkbLn2yv9rQRbuATKTUhbz8b2eJlEtlR+KNoX7e6SYUDRpu1daz/baHv2cV9NsZoPoMCcuQtxnKXhqq1bTm+eWEiMtQEW4LVQW9RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-51eb1818d4fso1989224e0c.1;
        Fri, 07 Mar 2025 06:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741358525; x=1741963325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=veoRz5ujP2KKy+HEelssfFLeBagBiRfF1OPAqqgsrnY=;
        b=Edl7V6cxDLfF8eJ0Swfx2hBXtj14W7VlzziyTpzTFWxaF8C0NHpRWzugqA2S5sICFX
         SeW+e9IsVkS/p2QaENTVoOZ3/c7r6bRkAhYtKOcr5nPqrIyQiaT+EV1XINPSgTSUjde3
         wLl9tyXmGeyfIsxYfVLNGQQvTOCyIGy0CVPgTpA0ZEAmy78fYn0U27wmiMTZXVNJh2kQ
         OOrLLWxcUvRTHnbzN8cbKKstVs2JRvesOoU6ASaouzPBIBFIwwsoT7ovN8kyGGoLY6eY
         4CKqapYvozFU4ObbmaWRJ9zeXGBULmS2C5pGzMeWcfIopJUu8nurOYMCeNJUeSpUdCK3
         Qg8g==
X-Forwarded-Encrypted: i=1; AJvYcCVBr8l5nMn+VVbtu6jznUG4UfzGWnw0t5tX9qvR4BsSO6C0aaSxqg9ldeaxkxDkntbg0l39qlTX@vger.kernel.org, AJvYcCWAUgmmNDaX1O031PBtQaHShN22CkTHFDKesEV25Q8Jc79yukPKvSpv9tNnfc/dDfCf6MO8QbAsgyS43p+snYpViWY=@vger.kernel.org, AJvYcCXUC5BFMyrcw0I1kIbGElG5qKEKTqVLmG8HuuqfIE/Nv+ZtNYLIn3AnMkeUiMiPK/+wIT84aGijMaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+r7QgVnjAJAOtCUH7Zb+YBjLtSZfmImpBG3o4ourQlM8hagUv
	yc4jeSPcS8BZePAedtuCkp/VKqV1rJx4vO2SYfGl1Q0u/bwWG3gciSQ2oWXb+r4=
X-Gm-Gg: ASbGnctsahn4rjYV/pSJcxDGsvPZJYWtcbbpRALnQKzOxJ/znBbH0j2Hkusw4XVBxkK
	gCmawJGjwb0c+6ynsN1bzlmea1mA1B6yBWD7Y58IGAXwEqztBNjYURvzJx70z1GgudU/5MCDEjm
	jgST1Uc8YnJf8aULoYq4X++HYWA/0XRHOaSz8Hg192GdJnXzbhTn3XlRNzND12qKr5m/Vo0jzs4
	l4CYTy2KgLRhqTb2QlKCbvYzNAwee+pJt8JY3nOj9sqLPmBX9ysrAf4yiiHxQ6gAezUCKAqz7Bd
	QCvludE5JOmoOvja3GXggt1IxgqXzHIo6OFwBE4120YHZs0cHS3yTDvibzLvzLtI15ZA/n6ph0O
	yr2ON4xg=
X-Google-Smtp-Source: AGHT+IE2Dtzfc0LYmYMaGuc1ThMb4At7ZxgOXwFpLla9y3li2c7yOhU884EsAnsW8rLYWloX1tW5UA==
X-Received: by 2002:a05:6122:1d9f:b0:523:91e8:324c with SMTP id 71dfb90a1353d-523e4130a63mr2829124e0c.8.1741358525037;
        Fri, 07 Mar 2025 06:42:05 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8ac1ec7sm532405e0c.11.2025.03.07.06.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 06:42:04 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86ba07fe7a4so1495964241.2;
        Fri, 07 Mar 2025 06:42:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUC2rYzmnyVl0V/sGvaC2C25Hn3xj4skVYFaIeGHlJknJ+Cx/J8aZnPy7d0wAgy4mzk5Ixfithp@vger.kernel.org, AJvYcCWkdZKZdk+MHj+DwYYvTnyLHMNkHZw0lvb4E2cNcfer697C2nW7Wu+8HofAySXxM1/bGihzrv4JBuI=@vger.kernel.org, AJvYcCXm5HmqLpHWMb5xlG7EkuMk/sHj5dWzAhwu2d6KdoPabd1bIGBSMuDwyYWxKZWVwMWV0Rs37E4F9pVlBcpl+mZLbgE=@vger.kernel.org
X-Received: by 2002:a05:6102:a54:b0:4c1:b3a5:9fa with SMTP id
 ada2fe7eead31-4c30a6d2076mr2049732137.16.1741358524146; Fri, 07 Mar 2025
 06:42:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220094516.126598-1-biju.das.jz@bp.renesas.com> <20250220094516.126598-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250220094516.126598-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 15:41:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUs=+niOyBW0us=UjZTnqeYjVsLWZSmROndCO8azER=3g@mail.gmail.com>
X-Gm-Features: AQ5f1JrWRl9MPvTG_dOnScu40764bguYrV2frwLJ-gti0W78dvGdmo03XDNfOMc
Message-ID: <CAMuHMdUs=+niOyBW0us=UjZTnqeYjVsLWZSmROndCO8azER=3g@mail.gmail.com>
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

On Thu, 20 Feb 2025 at 10:45, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> There are a total of 96 AFL pages and each page has 16 entries with
> registers CFDGAFLIDr, CFDGAFLMr, CFDGAFLP0r, CFDGAFLP1r holding
> the rule entries (r = 0..15).
>
> Currently, RCANFD_GAFL* macros use a start variable to find AFL entries,
> which is incorrect as the testing on RZ/G3E shows ch1 and ch4
> gets a start value of 0 and the register contents are overwritten.
>
> Fix this issue by using rule_entry corresponding to the channel
> to find the page entries in the AFL list.
>
> Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

This finally fixes CAN2 and CAN3 on the White Hawk and White Hawk
Single development boards based on R-Car V4H with 8 CAN channels
(the transceivers for CAN4-7 are not mounted), so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Unfortunately, it does not fix CAN2 and CAN3 on the Gray Hawk Single
development board, which is based on R-Car V4M with 4 CAN channels.

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -787,10 +787,11 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
>  }
>
>  static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
> -                                          u32 ch)
> +                                          u32 ch, u32 rule_entry)
>  {
>         u32 cfg;
>         int offset, start, page, num_rules = RCANFD_CHANNEL_NUMRULES;
> +       u32 rule_entry_index = rule_entry % 16;
>         u32 ridx = ch + RCANFD_RFFIFO_IDX;
>
>         if (ch == 0) {

The out-of-context code does:

                start = 0; /* Channel 0 always starts from 0th rule */
        } else {
                /* Get number of Channel 0 rules and adjust */
                cfg = rcar_canfd_read(gpriv->base, RCANFD_GAFLCFG(ch));
                start = RCANFD_GAFLCFG_GETRNC(gpriv, 0, cfg);
        }

After your changes below, "start" is set but never used.

Looking at the actual behavior of your patch, the same can be achieved
by updating start, by adding a single line here:

    start += (ch & -2) * num_rules;

> @@ -802,7 +803,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
>         }
>
>         /* Enable write access to entry */
> -       page = RCANFD_GAFL_PAGENUM(start);
> +       page = RCANFD_GAFL_PAGENUM(rule_entry);
>         rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLECTR,
>                            (RCANFD_GAFLECTR_AFLPN(gpriv, page) |
>                             RCANFD_GAFLECTR_AFLDAE));

Out of context code:

        /* Write number of rules for channel */
        rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch),
                           RCANFD_GAFLCFG_SETRNC(gpriv, ch, num_rules));

So the old code calculated the page number based on the pre-configured
number of rules in the RCANFD_GAFLCFGw register, not taking into
account ch > 2, and then reprogrammed the register with the new number
of rules... Hmm...

> @@ -818,13 +819,13 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
>                 offset = RCANFD_C_GAFL_OFFSET;
>
>         /* Accept all IDs */
> -       rcar_canfd_write(gpriv->base, RCANFD_GAFLID(offset, start), 0);
> +       rcar_canfd_write(gpriv->base, RCANFD_GAFLID(offset, rule_entry_index), 0);
>         /* IDE or RTR is not considered for matching */
> -       rcar_canfd_write(gpriv->base, RCANFD_GAFLM(offset, start), 0);
> +       rcar_canfd_write(gpriv->base, RCANFD_GAFLM(offset, rule_entry_index), 0);
>         /* Any data length accepted */
> -       rcar_canfd_write(gpriv->base, RCANFD_GAFLP0(offset, start), 0);
> +       rcar_canfd_write(gpriv->base, RCANFD_GAFLP0(offset, rule_entry_index), 0);
>         /* Place the msg in corresponding Rx FIFO entry */
> -       rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLP1(offset, start),
> +       rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLP1(offset, rule_entry_index),
>                            RCANFD_GAFLP1_GAFLFDP(ridx));
>
>         /* Disable write access to page */
> @@ -1851,6 +1852,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>         unsigned long channels_mask = 0;
>         int err, ch_irq, g_irq;
>         int g_err_irq, g_recc_irq;
> +       u32 rule_entry = 0;
>         bool fdmode = true;                     /* CAN FD only mode - default */
>         char name[9] = "channelX";
>         int i;
> @@ -2023,7 +2025,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>                 rcar_canfd_configure_tx(gpriv, ch);
>
>                 /* Configure receive rules */
> -               rcar_canfd_configure_afl_rules(gpriv, ch);
> +               rcar_canfd_configure_afl_rules(gpriv, ch, rule_entry);
> +               rule_entry += RCANFD_CHANNEL_NUMRULES;
>         }
>
>         /* Configure common interrupts */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

