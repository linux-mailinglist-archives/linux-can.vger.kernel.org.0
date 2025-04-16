Return-Path: <linux-can+bounces-3410-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC090A90492
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 15:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC47C17EE4C
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ADE18A6AE;
	Wed, 16 Apr 2025 13:43:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAE51B3957;
	Wed, 16 Apr 2025 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744810993; cv=none; b=mp5u6+CVdQenzcZCpFU7grGN5M0T3Z1/4eY0eR859X23rr8o1fdFABV8lB1Wk2qxEsYrDit5gFuEhb6lMdQJavXhbud2WA+hQfmN0JENlzDal2sF0HwU7JW4qvI9MY1HY4AEF5f623u1Qtld2etGWdu6UNUQK96A5Gc7axzaZpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744810993; c=relaxed/simple;
	bh=i+h+x7jYXPrCxPkzOhpOMVwGMaWrLh2qq674qxg3A6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GexfrdfDsAt0n25k/zy/uz7G3W281a3LV9Xc+x1rM0hlUMzfP29itOHiLsAtiD6gwu4fI0Cw03XEOU6av9unfgZ3Fx4+uNMQ5PiQdpiOrxrDB6WIZWWVlJa2B5z4ai3AekmrsRR8AH2YHoPMsAhwy3xuI+StfothLITBXoT/Mhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86d587dbc15so702487241.1;
        Wed, 16 Apr 2025 06:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744810990; x=1745415790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epMdNEp8sYZi3MIvU6bz078dy39igkQTzfmle2wp0+0=;
        b=tlwZmJ+6s+59pxAF6UmA96O0x8eMqHauRlOCYhQJYnRIHH7n96gn/KPBn+tGsS/dgd
         Qz2A29rzQunUHe8mjjKDKFhY7TqsiWpp6fBbbIhiV3NJ3fmxQNn4Pzz7SpEMTQMh1HM1
         7bBzgb6nNZzhhIUK3eQRT3yN+X5lu3W+hSljVtaHlL6cMUhD4xVybCwDC0d+Oc106a3e
         BYYCnQXhiooOQDBY1T2XjCAbgmNiXnHTSBkDHaF9Ld8XEuC30xCtpw/dDWfk64kLpuq7
         u98U2bNSRKjsbs0+CU/6/G0bdluxB6uucZlIF02/i91qSGRyPQhVv4dni+a2xQXsVMUn
         ULng==
X-Forwarded-Encrypted: i=1; AJvYcCUxSO48Mv4ydfhZAH1Z1gLfejsP/Hi87YdwngW8e5NyVhvmMIf6lLpWJaOJ0vz2s6tOq+rIJ7b6kLOPcWefWEhVXXE=@vger.kernel.org, AJvYcCUxTSKG/p4Hqxv4RIhpt5u//CcPq3BT6g8giuXlaD27ilh7IKqSs4H/kAEeRxGocSoaiz8dj2HQask=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJYZloNkleSrDaQlgfHycP+3gN4zZMWhsl1B1PpohI393kDq6J
	3J/J8TonqJMtlcq9ygs+ZEjinrTRyLl9Bg8hXwS2UtkM2aUs+i69PIrSHNxT
X-Gm-Gg: ASbGncudjs3XQq1w0ZmQZ9/aPoPv2AhFdjX72Q6vKwdjCZXAi3y/ZgD/bhCVb9eYyMJ
	WmIRtIKbD3Sy4HL4fpEbe+U+BhdRjV0Pv6KCTf4VmrCWs4Sp0yljRC5tXdb3L15tFD302SZ09Ne
	8GOV5QQJ6ekw5OFwT6Y+gNNnRS/1j7bRCdgkL7KYQCY9h3JxMKzXRmu/bunLBqx40jPBt0YWeWP
	hL6zdWlZ9sUr6THv9KyE5r/JHgJE63csVYcvbvC30kg429VaIBJkOnhEJVWdAKvO0WNhHNv78lp
	PpBVRyUBmgHI3UdLghgtCcPFW/4DqZQcbBH4mUIKBFH7oIh5DoYH5Jtgdb+yaF8DKBa4z4hIY0O
	ulxfsAwM=
X-Google-Smtp-Source: AGHT+IFT6CHM6BS2WDX9jdCarF8jM3jYeEa10hGvEuzZWDMxOfWtdLLoJe0fC4z8DzLwfUmabbaxxw==
X-Received: by 2002:a67:ed49:0:b0:4c3:243:331a with SMTP id ada2fe7eead31-4cb59682081mr822977137.6.1744810990142;
        Wed, 16 Apr 2025 06:43:10 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c98afd38sm3019300137.24.2025.04.16.06.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 06:43:09 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5290be1aedcso623549e0c.1;
        Wed, 16 Apr 2025 06:43:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVi1FGzBSQftqy4maA1/EK3R7ot6hyUSHdB0FT0fwkmWReyjXoDSmsJ8w4awueZzPjbRvY8fJHEOt4VtoueKDR6UAg=@vger.kernel.org, AJvYcCXrrP5xXsm0uetgYyiTGCoQdnM10UFcO1Gnr1+zMi8SIyi1O11OdwaodLW0RBdpGgZQx0PLGR72l/4=@vger.kernel.org
X-Received: by 2002:a05:6122:2c8:b0:523:dbd5:4e7f with SMTP id
 71dfb90a1353d-5290eb4e2ffmr933240e0c.3.1744810989594; Wed, 16 Apr 2025
 06:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402102226.28032-1-biju.das.jz@bp.renesas.com> <20250402102226.28032-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250402102226.28032-8-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Apr 2025 15:42:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUi1t-KeeTYTacuxGNpbZQT9Fv5xGrNQHw-n6ihyKn1Rg@mail.gmail.com>
X-Gm-Features: ATxdqUHgJm6HUb73tdM64_FGNDrYStdv0ymp31V2acefER8uWIBHygABogpXryc
Message-ID: <CAMuHMdUi1t-KeeTYTacuxGNpbZQT9Fv5xGrNQHw-n6ihyKn1Rg@mail.gmail.com>
Subject: Re: [PATCH v8 07/19] can: rcar_canfd: Add rcar_canfd_setrnc()
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Wed, 2 Apr 2025 at 12:23, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Add rcar_canfd_setrnc() to replace the macro RCANFD_GAFLCFG_SETRNC.
> While at it, replace int->unsigned int for local variables offset, page
> and num_rules in rcar_canfd_configure_afl_rules().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

One nit below.

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c

> @@ -676,6 +672,15 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
>                 can_free_echo_skb(ndev, i, NULL);
>  }
>
> +static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
> +                             unsigned int num_rules)
> +{
> +       unsigned int shift = reg_gen4(gpriv, 16, 24) - (ch & 1) * reg_gen4(gpriv, 16, 8);
> +       u32 rnc = num_rules  << shift;

Unneeded double space.

> +
> +       rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch), rnc);
> +}
> +
>  static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
>  {
>         if (is_gen4(gpriv)) {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

