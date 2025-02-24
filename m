Return-Path: <linux-can+bounces-2939-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8614EA41A6C
	for <lists+linux-can@lfdr.de>; Mon, 24 Feb 2025 11:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA031887D9E
	for <lists+linux-can@lfdr.de>; Mon, 24 Feb 2025 10:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D6F24A068;
	Mon, 24 Feb 2025 10:12:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E2D242934;
	Mon, 24 Feb 2025 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391935; cv=none; b=a0dp0E+7Rhoe+XO0/tKyGuLeCyaftO5AR2ZuOaVu0d0je2kf8ZnO2QCGxmc2ff39OMQjXH7lhYEt4d+PoURLKoKTc2ZebzAttDZx40s5TzNYcLKCP3qZXhED/1mli/SZ7wKPvafP6foB9zgpd23aKnLjQWi6Ovqs6DeBVDxSFs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391935; c=relaxed/simple;
	bh=mDAuP4us5iBE0QATL+ViiK31CwEtZzLIxh2KH2N3qr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCwSZ5Ds0Lin7LW0/EUH/cuweOI/WWk3NRNomRnxA6kgCrrQ1OkyzK/KziNRhqMXNyzIlH+ZRq2pabdvAlrHE2+hbEZc6NrM59B7FOgIkpvwr0h+8wQeu+PUnzR7d4at/shf/x84eE4vm9JQz2SSlFY+sRe8SPsnKmvtZ/H1i0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-521b1b8cdb6so1008717e0c.2;
        Mon, 24 Feb 2025 02:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391931; x=1740996731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knn5txmmyUgseDNlXNzRHRoQx4KOWF3qCQpw0h6Qcps=;
        b=P3miaQqm6mHQs7f6h4VZV89B9HSVkMKxtWDLXOUcl5a14EZPpYOW4sK0t3sTTgWav2
         f2TUuzX5cINqoRgObCdqDjS8Hs+BVokx9zUW8bLa5u4nDpiLphS2COFMVARblbQsmETx
         9HGZTPnOvyikU6GZCgcd9FHOvmLlecPB60wh0+P+14luXTtmBLledkmmMLgFcwQS8G9l
         MoZ+b6E0rYRxIcbX9FS+kth82VFq5Nmzsv8pe+pbB3DVefuMwU/ozipYs+PJkMr5lOIG
         JR8CjtOxaky5gClmXFvYDePOcRFEG8F+81yhOuWBSVhpfJ7+BuEm5sSbnh2XUlacteiY
         D4oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbN17YeWXsE9LBGoieg2Y5M9s+MzydrlMH5EgD61KwxR/xopixxOI9cbA6D6Avf0vX0DS3CnMmhsE=@vger.kernel.org, AJvYcCVwOYIdAH84vmosPykcHCj77r6U1jCvAhWzH8qEEah4gu8+Mv/aKEZ9+m9I2KMVYHBnrtxiPjTQINRozS6SOI4tFBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHnUg35riUmjiXzTRT07SvlKVbMnbQWSC2vNlit5g2KH8fwPM
	eLKMDKycnsC0Mj2mLiHgaF/h/hQG2SlkQsUY7OiD1lW5S0i3HgjAtymRXSkK+2Q=
X-Gm-Gg: ASbGnctG5LbNZNEZCa9X4rGPPSuwHaV0uic0TcvJM8ftxeTa2OTAXXtzc/IiCZ0vCVG
	sj16dXBMfwGVN9+/oeFoan1HTVZV/KurMWFPDljLZufCeTyX2+ICB6ec7yq9jAd+9/NuJnQAQXW
	LjneQsm75ykFV/zYZRwhXcb5+NaclfMqrxQHWswQHSJEIm6HQshKzawLB2KCrdGnm/0i90gwpBU
	dAY14tFZ53ox2Vmkso/uE/dNsHH5YRYBAI4v6UXsdBKcg40OtVHz1aegilB7Vn8a67GxtW4wooV
	xX2P3eSoanzFcicMfZdZKIwuzaGVYxk5bYhufxtkUlfkK83zLEqotvSjmuzN46m/
X-Google-Smtp-Source: AGHT+IE3srHXuwIsb3dzMkXvUc4XtXUGE3DjzOX09HzeihqzK3IrErz3bSm3nI5wguqYl1moRAKKgg==
X-Received: by 2002:a05:6122:3295:b0:520:5f0a:b5a5 with SMTP id 71dfb90a1353d-521ee428374mr4749181e0c.6.1740391931152;
        Mon, 24 Feb 2025 02:12:11 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-521d7b10604sm1562107e0c.33.2025.02.24.02.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 02:12:10 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-868e5684712so1175751241.3;
        Mon, 24 Feb 2025 02:12:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8LzGBqzzgm98YElfytaEctqlxnGBouIR23r1uXQGBtEwnvWXoAvGyyiHGteraH2zqtK7JG6q1FqaS871UJLazia0=@vger.kernel.org, AJvYcCWCTwj+llYnggnG5miMEn0C+NtWRvSvEr223ieAB3yVrf/p9DMS/OwY6EcOCQBw6/0IWu3EGykj1zY=@vger.kernel.org
X-Received: by 2002:a05:6102:4a97:b0:4bb:b809:36c0 with SMTP id
 ada2fe7eead31-4bfc0167735mr6326024137.20.1740391930494; Mon, 24 Feb 2025
 02:12:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220130427.217342-1-biju.das.jz@bp.renesas.com> <20250220130427.217342-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250220130427.217342-5-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Feb 2025 11:11:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWVsf+1J_e5iu_29SjVyF+wWnj4MH5sktb_FNeQpo5F0Q@mail.gmail.com>
X-Gm-Features: AWEUYZk6x99zboz8dKULt8AjttB0jYow2GUAmY46ZecANIyYjebI-hoVA_JK6s8
Message-ID: <CAMuHMdWVsf+1J_e5iu_29SjVyF+wWnj4MH5sktb_FNeQpo5F0Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] can: rcar_canfd: Add gen4_type variable to struct rcar_canfd_hw_info
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

On Thu, 20 Feb 2025 at 14:04, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Both R-Car Gen4 and RZ/G3E SoCs have similar register layout. Introduce
> gen4_type variable to struct rcar_canfd_hw_info for the preparation of
> adding RZ/G3E driver support.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -516,6 +516,7 @@ struct rcar_canfd_hw_info {
>         /* hardware features */
>         unsigned shared_global_irqs:1;  /* Has shared global irqs */
>         unsigned multi_channel_irqs:1;  /* Has multiple channel irqs */
> +       unsigned gen4_type:1;           /* Has gen4 type reg layout */

Perhaps this can be replaced by a (or more) more descriptive feature
flags, like you did before when introducing rcar_canfd_hw_info?

>  };
>
>  /* Channel priv data */
> @@ -596,6 +597,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>         .max_channels = 8,
>         .postdiv = 2,
>         .shared_global_irqs = 1,
> +       .gen4_type = 1,
>  };
>
>  static const struct rcar_canfd_hw_info rzg2l_hw_info = {
> @@ -607,7 +609,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>  /* Helper functions */
>  static inline bool is_gen4(struct rcar_canfd_global *gpriv)
>  {
> -       return gpriv->info == &rcar_gen4_hw_info;
> +       return gpriv->info->gen4_type;
>  }

And hopefully we can get rid of is_gen4() in the process, too...

>
>  static inline u32 reg_gen4(struct rcar_canfd_global *gpriv,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

