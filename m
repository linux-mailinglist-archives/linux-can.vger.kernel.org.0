Return-Path: <linux-can+bounces-3089-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C92A613FA
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 15:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AEEA7A42E1
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9B11FECAA;
	Fri, 14 Mar 2025 14:47:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1711990BA;
	Fri, 14 Mar 2025 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963666; cv=none; b=BtcFVfw1Zug5r9d2eRfL3IlFQWSVxv87Y/tqFSym6RBuyZP5Wvla+JPMpGN8zcXCjQpBaC1mMiT/SHt3K3w5N06lQC8Fjl4j3NLWRKL0QKxRy3lkytgAQomqq4vLkckBBOf3Mlxgojowq5+CAU675ab9fToXSOlT7gVMHbbTFy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963666; c=relaxed/simple;
	bh=9QNwKI3dTpz7XKFOx1EWa8husp06PisYwSHM/B4LW7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBeL1p3KMxZwfDwZmLOXL80ciS3ymD0ReaqSzk1p3Lux+kO6loqQanDbJaguI1r5ynxV2hxcHVwjqEii4xO38F3vUaV56v/IBTHJL4ad1LNpzvgwZJfiWfpumqc5JW7OHSakxZ6xl/LWh6KF8r8OzmzK101klzjY6WZXjDtTOFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86b68e51af4so888804241.1;
        Fri, 14 Mar 2025 07:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963663; x=1742568463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLu+DsI/8Azt2FzOJU5yiyx02lmITLI9vM3XZSuIAfE=;
        b=kdb+s7BKt7kneeEIf7474xae98xXgev4adyBefGV/TwENLJbUuh7/zYzlGJTzI6xHn
         RLkf3xPVxkc7FO6arEzHHJUwzOsfIcu0yVnvz7ewd4rakj4sPtRu4PNi3BVq/rwkFasB
         0ntFbv/rRiGBU34lrreF0hDfNclJpsoLJ+6xZRxEmymWf9M+A/1P64iEk3p1kjPGa02W
         FAbM0YLWPnwTjwS7dfdRIqwdF6xGjqwnMbr6aITUg4CcmCA8n7QWzXniuyKMI5K6y9n+
         D/zrc96UghAj4RCs/Hn2YPGUD1q/A8QC3RmfXNW81C56nGXIo33HyeJHW8fOGzkJrXkb
         OJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk46+Su5TOJy/vVTG8CbzKoL7KKyRY8ghjsvzSAjZdVcQ8SZNeIVRsce5QDOzbNOgKkqWcLMnS77ZxMMX7ty+fAVY=@vger.kernel.org, AJvYcCUxL6mRZsU0H3P6TVX9Lo57zbkX/QKLu1RkdEBvhjByP9gsWGJt29LdRpBWvQXn3C3EdxBPbcbolYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaW89xMwvNsIh2lp0mTOuvkeDxAkAjq/MGAGbcn6tlD+gw1CLa
	pYI4k6OqwGq/nxBU8w7ss5CXPg8VaiN+c8kq79Qb5Om3owEup6TJrpdf54Wq9dA=
X-Gm-Gg: ASbGncuoVijMA/FjQc7xsFaVMll+zYNoHThgBcq3jX2rFbB5kxGIW81tCWd4qBrWtEb
	dHse/V4rk85czuz3mga9SroH2k1Spbi+GMWnyDajk0118jBUdx92uEa96r8riUdFIZhiKQbMT/v
	+cYdCXIWSZfjGP6OL2oiaS8G0rxxk8NRSmTRqN/kQkfx242av+bC/OVQ+p0QvXhaZAGviewq5OF
	QRAs6FaXFcNE/KcicCsAQlq7pAAaj/bnS5ftm+7Tji1Vy+tWV3+ssXZuolpi+owWf4fgYThOfvw
	hNk4W3PwgscS0/hw7t7igqW6+We9LnuNlIhZAv6iHA05kOd4h2qUesoLJqIT0ArH76JD21bN7p/
	Dky9rB/J5w0pUGZVazw==
X-Google-Smtp-Source: AGHT+IEg6IdzVeDSVj8SsmRTgHNAoRnBUBzy2ko6L9GU344G5UyQL2FhoHeAi8Lt9/lNt9IhKANUZw==
X-Received: by 2002:a05:6102:41a9:b0:4c1:b339:e4f with SMTP id ada2fe7eead31-4c383116c35mr1796089137.4.1741963662978;
        Fri, 14 Mar 2025 07:47:42 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a70f590sm591660e0c.40.2025.03.14.07.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:47:42 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86c29c0acdfso1042717241.3;
        Fri, 14 Mar 2025 07:47:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgdZrYmw84JwBiSoWPz+cK9PKRRaU57kackztBcuMb0jbUcK2xjn8nz4d+Q2sFroe1seI7+jevwbwnDwOJ0kI18BE=@vger.kernel.org, AJvYcCXglS+Zk9o05HIRfff0G9uN/gRywy4pVMmFnnFmL5OrOzG+PQqRzl00Qz89vnKypYxCnjjarQ/yJfg=@vger.kernel.org
X-Received: by 2002:a05:6102:3710:b0:4c1:9780:383a with SMTP id
 ada2fe7eead31-4c383163fcdmr1903754137.13.1741963662194; Fri, 14 Mar 2025
 07:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com> <20250306124256.93033-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250306124256.93033-8-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2025 15:47:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXwNH-3AUe=CvONFxGfw3a1pATU4vTRqxX3xvk7K1yGjg@mail.gmail.com>
X-Gm-Features: AQ5f1JqAZ9kXD-2ZgcZMrZEhd-UymoYI_cOaWY6_G-nT2Z4XZfHZ4xln8kMcW0w
Message-ID: <CAMuHMdXwNH-3AUe=CvONFxGfw3a1pATU4vTRqxX3xvk7K1yGjg@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] can: rcar_canfd: Add mask table to struct rcar_canfd_hw_info
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

Thanks for your patch!

On Thu, 6 Mar 2025 at 13:43, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> R-Car Gen3 and Gen4 has some differences in the mask bits. Add a

have

> mask table to handle these differences.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Suggestions for improvements below.

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -82,25 +82,24 @@
>  #define RCANFD_GERFL_DEF               BIT(0)
>
>  #define RCANFD_GERFL_ERR(gpriv, x) \
> -       ((x) & (reg_gen4(gpriv, RCANFD_GERFL_EEF0_7, \
> -                        RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1)) | \
> -               RCANFD_GERFL_MES | \
> +       ((x) & ((gpriv)->info->mask_table[RCANFD_EEF_MASK] | RCANFD_GERFL_MES | \
>                 ((gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0)))

RZ/G3E documents only EFF bits 0-5.
I think this can just be replaced by gpriv->channels_mask << 16,
especially as there is only one user of RCANFD_GERFL_ERR().

>
>  /* AFL Rx rules registers */
>
>  /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
>  #define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
> -       (((x) & reg_gen4(gpriv, 0x1ff, 0xff)) << \
> +       (((x) & (gpriv)->info->mask_table[RCANFD_RNC_MASK]) << \
>          (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))

All other mask values are just the maximum value of a parameter.
E.g. the RNC mask is the number of supported rules - 1.
So perhaps store these as parameters instead?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

