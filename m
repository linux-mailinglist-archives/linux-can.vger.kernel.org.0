Return-Path: <linux-can+bounces-3408-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B79BA90472
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 15:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74BB1895073
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 13:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225E014885D;
	Wed, 16 Apr 2025 13:36:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42C179A7;
	Wed, 16 Apr 2025 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744810560; cv=none; b=pWEeSoQvNGGL/UseNQQA1KsWHbxF3kqSuEzZz8tgybxkqgEzuTfTALl787tTHMmMvvdeqPgmAL0Rj+lG2ioMip6Eqc9TpnTRsXDcjWfzN+mRYnW17waPI7QX3WuDra43uzuUFXlCkNbOpevR+H+ZQ6dOnS3r9m54jHNw3Y+0OCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744810560; c=relaxed/simple;
	bh=ZYgs+qTPDdtSWmrKq+dar8jyxc4Jb+PKn0rYiZqpwdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIFPKG/mu7ZPjlfn0vbYR+U4PA9dxO5vmCSSiH7WaC+8yE56zgRCrjKSKcHkHa+a7BBQ/od2u27vKo4VxAwuXtDVV5jlLnI7i+iop0KvTCl6t5hvk55KU0MvCQ1UoO55HQAnduzPFiGTYED14T7W+LOFWfgVKH0w1Sa/NGG8G08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4769aef457bso68082511cf.2;
        Wed, 16 Apr 2025 06:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744810555; x=1745415355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGXQgOZjUBLvV+Sjr0WM5C4DyZV5bKyAW3zklxfJ3m4=;
        b=vPXYYEuggzfOFruqGwbjFkPPbcGd1R0qSMZKGtizZrpgZV5622ZnJe7S1cW2DIJul2
         z0RZPqFRyCCrBZ1IpvlAppc0LOpFbTQaKkOnioteAJ/aFxtr70W5EV8mBI7WljnsxrkX
         jl0+9yTscovVpqIQzaCAItYLv1L9NvvYWzbXQZ1t6cm6viaoi6w6npKzzozk9N1Fkhye
         pHZfeHnEekQDQOAYPXrZf2czFuubqHs0HaX3fitzjOU03/WLYFY23PJH9ajVTqhYiPMV
         QkMk99excbNmyOaX8V8oKR2cucUrQY2jbCoTMdRja1eWI5hlCoKCqJ7M9FbkhDL2glOV
         l8IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqwvtp2a4cAvRuHjzOxykW1oSgiUG2DrociRcOtDSmM3A4aiyT/f96lya32fiwK0uwu02nFm1adWBx2I6JAZjD3AY=@vger.kernel.org, AJvYcCXAKruG4ebEbcX5GxaVPuXmdyCg8r4AGvb7aUDnjebyS9fIpL5aG6SJQACUm3Cr8xnTO3toYf7M2h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFUPKrbgVe3psoheWzc32ElulyEYN9VKyBFWwUr3pt/R20gzgT
	53zOmXV3+ck02jfWiI2YW0wLxu0qvTQRd6xlsOl5mB9+Lx6vJRrgGrkrgQYl
X-Gm-Gg: ASbGncuSK4hHPzwY3bWO3n9/IXzThCR4te2ITi7HjhKx83Xyy/k4iadxocbVU2HpoUU
	muIf17LGK8zBJPu0IgJe5YzywS94R3JedtDP28rUe79I+VMvfeXZ3OD6Xx0/ymVwnLkh65oYgwA
	6dRTtA4lcTR7OLK9pnB1OvQ7dX7aZUXjrautOOQ6HLHG9sVQocHh0nikE2wrJU487x8MPhxxIWR
	iTLLjR1r07OKgIWWJvtb9UuLwg25hHtIB3/htrzgpk0VpR/m9AaL+dbMb0B9opHPVSrRqSIpmmY
	a38pAWF3vFSCivL9Vx839jeEZICyAtr2CCBwByckr0kjdM5JyVyByw4uQ7H1kIRfzlwtF1j4BEa
	1y03mKq4=
X-Google-Smtp-Source: AGHT+IGnjHhixXYUbtFiYLTNGJBcH8RM72ftklqkwtET9oX9GQNx2kwqVlAYEREGuh3zP6UXClJ8Rw==
X-Received: by 2002:a05:622a:110a:b0:476:67d8:930e with SMTP id d75a77b69052e-47ad8115319mr19072321cf.34.1744810555342;
        Wed, 16 Apr 2025 06:35:55 -0700 (PDT)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb2ce5fsm111158401cf.43.2025.04.16.06.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 06:35:54 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5675dec99so604902085a.0;
        Wed, 16 Apr 2025 06:35:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWar9ekIDcv0hLGzTM0zbdLRiDdTMWLznJHM9qQAT5x16rS1ZpdzLgdXyg+gSTvJ8w5XzD3h6522tg=@vger.kernel.org, AJvYcCXrdfQBTYL5jCG0GymPaYjq/rbwcoslTu9EWE3derniRuR+B5OFodgi7lCRkLRwbxVQuIuZiXSDpZXZ16moaJnBaX8=@vger.kernel.org
X-Received: by 2002:a05:620a:24c1:b0:7c5:3b9d:61fa with SMTP id
 af79cd13be357-7c919002c78mr264315685a.26.1744810554510; Wed, 16 Apr 2025
 06:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402102226.28032-1-biju.das.jz@bp.renesas.com> <20250402102226.28032-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250402102226.28032-6-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Apr 2025 15:35:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXT9sPDdcbro_8auzz4dRUTxwotuzninVKRmELcDNhfiQ@mail.gmail.com>
X-Gm-Features: ATxdqUFpTjtBo7LJrwShUloe6l8oQq05Yk_ZEWhlPqtbSu3VZ79KjcbMvkWTgDQ
Message-ID: <CAMuHMdXT9sPDdcbro_8auzz4dRUTxwotuzninVKRmELcDNhfiQ@mail.gmail.com>
Subject: Re: [PATCH v8 05/19] can: rcar_canfd: Update RCANFD_GERFL_ERR macro
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Wed, 2 Apr 2025 at 12:22, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Replace the macro RCANFD_GERFL_EEF0_7->RCANFD_GERFL_EEF. The macros
> RCANFD_GERFL_EEF* in RCANFD_GERFL_ERR can be replaced by FIELD_PREP() and
> drop the redundant macro RCANFD_GERFL_EEF(ch).
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v7->v8:
>  * Updated commit description.
>  * Replaced the macro RCANFD_GERFL_EEF0_7->RCANFD_GERFL_EEF.
>  * Dropped the redundant macro RCANFD_GERFL_EEF(ch).
>  * Dropped the tag.

Thanks for the update!

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -74,18 +74,18 @@
>  #define RCANFD_GSTS_GNOPM              (BIT(0) | BIT(1) | BIT(2) | BIT(3))
>
>  /* RSCFDnCFDGERFL / RSCFDnGERFL */
> -#define RCANFD_GERFL_EEF0_7            GENMASK(23, 16)
> -#define RCANFD_GERFL_EEF(ch)           BIT(16 + (ch))
> +#define RCANFD_GERFL_EEF               GENMASK(23, 16)
>  #define RCANFD_GERFL_CMPOF             BIT(3)  /* CAN FD only */
>  #define RCANFD_GERFL_THLES             BIT(2)
>  #define RCANFD_GERFL_MES               BIT(1)
>  #define RCANFD_GERFL_DEF               BIT(0)
>
>  #define RCANFD_GERFL_ERR(gpriv, x) \
> -       ((x) & (reg_gen4(gpriv, RCANFD_GERFL_EEF0_7, \
> -                        RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1)) | \
> -               RCANFD_GERFL_MES | \
> -               ((gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0)))
> +({\
> +       typeof(gpriv) (_gpriv) = (gpriv); \
> +       ((x) & ((FIELD_PREP(RCANFD_GERFL_EEF, (_gpriv)->channels_mask)) | \
> +               RCANFD_GERFL_MES | ((_gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0))); \
> +})
>
>  /* AFL Rx rules registers */
>
> @@ -938,7 +938,7 @@ static void rcar_canfd_global_error(struct net_device *ndev)
>         u32 ridx = ch + RCANFD_RFFIFO_IDX;
>
>         gerfl = rcar_canfd_read(priv->base, RCANFD_GERFL);
> -       if (gerfl & RCANFD_GERFL_EEF(ch)) {
> +       if (gerfl & FIELD_PREP(RCANFD_GERFL_EEF, ch)) {

BIT(ch)

>                 netdev_dbg(ndev, "Ch%u: ECC Error flag\n", ch);
>                 stats->tx_dropped++;
>         }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

