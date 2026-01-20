Return-Path: <linux-can+bounces-6230-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7595AD3C4A7
	for <lists+linux-can@lfdr.de>; Tue, 20 Jan 2026 11:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0766A5CA230
	for <lists+linux-can@lfdr.de>; Tue, 20 Jan 2026 09:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063483B95F8;
	Tue, 20 Jan 2026 09:51:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6C4335066
	for <linux-can@vger.kernel.org>; Tue, 20 Jan 2026 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902688; cv=none; b=j2f9Do5+/nM6wfYcErKiA93APh/JOBAf/FPLXOg4Nu/mdGAeLwGncS7uWRFWaVxdLyT97an1P1LUznHo9e5YOn/SkcarTi5abz5tW4y/yrbsbYzuA/P7H0zE5iz7lXgf4ijX4tvM7J9DFZaf0hw70bEECIe/1j7YM2G8pz7j4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902688; c=relaxed/simple;
	bh=Y2e+JbZ5geFsLrIwdXvR6J7aoCBZ+QeMG1PGfBHkwC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyPw4c9SBJTYg05Tth6+0aJI3wC4iVhsoaLw/CBM2gALKhBZ6jaQqGEoPBTaFuoDJ+eds/6268Y3pVmgDD+uqxJfkV/Ymjc8u8ZRCRtNhMQNgADli9OuIKqbPsan8v3qzDI8MzO6zLgRAZZtE/sAqP0GXyZxqbzuuJJurgUsov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-888310b91c5so53504116d6.1
        for <linux-can@vger.kernel.org>; Tue, 20 Jan 2026 01:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768902685; x=1769507485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l18hDtqu7l45yo1vlmek39RB1c0Zv/I56SgfcgBEbBk=;
        b=hcGQg8umFw8l7UURkpOPb9chg7rx6+7jrQAp69ZeLLUb/+QcflBGL0LFLtZPaUYKEz
         nlCsybh6gdwoJYY+sdFc1PTeH4hG++20vS5EXIvChNmS1igBeWQJykuiz1kDsdS636jj
         BoGixSfRFIPVISQSFnjtmvPNaC92KfX3jDaOGx8UMmH6hC0EKb7ayJUfz97xktqU0axg
         GRK8cGNsVYYDGsDMC69uNuHXbtpZoZdBmx+Kj2uEfT+agtUIhdarUrbvdbZbRXCEddym
         +L0TuQDJT/B7w5Su1tGigA2J1A19YqawKOU9g0oEbNGTp3cS5VXT2nwy8YquvNkH9FKY
         WHXA==
X-Forwarded-Encrypted: i=1; AJvYcCVFq2LDE7bLe11QMxbWdt4vxCFR0xWiuUEEQMd2FTqDPeAI7sV73VGGkPZt5tEZLtugKT0LQ8PqxY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoXMt1CXBGw9X7qAyBxCX1hsJq7hV2jTZ8m1eSLo6R8OqfkI5h
	DjjBIjsfFQ6b0SLzk0YW1a3Pk9iT144xJxXsK8PbcNCa3z5NzTG7zDISVmHwP+w5
X-Gm-Gg: AZuq6aL+xgmu3wIMzZN54Y4LUVDjZ1L6FP3PSASg9iGp/XZEb6Ozem5pnVK1pL7lkNR
	vRCP83h/BjVXcL2dWxAk6N9DgweUKeIp14ySYbjnt2rUVxeRyGD7DKhTpXf1sqQn0aIJxiY0NVu
	KI/ntkirUelfXTjcl5mKUTiqVv5oYELG2JKz2b8/weyPIXMDSzGv9BpN5X6lA+h8IesHF639OHf
	QSq/CaYR9vMt9hML/HpmKvUAeJZmYag5O6nSNQiaT3EM6ZDYxf/CyfebRgXu1/BeXFMHo5IyNq0
	zG8fzGhvP4wYYuWoJwrjpAcfmFpz5mYIbwYpeTRIjXBQOabmE7pYz9Tca8s6BuLnMPgyqzFzclk
	8w8cSWBoKsn0RhaVqDwwfF3Osa1xdIaWhpbxTcIceXJcX/0w1fudJmbBvBGBPLNFNvgBy2WdIyB
	fW6crejpg3rObvkVGcE5cZZy2rOpcJVQg1l3MrKfhK0cs/MVC7cGyz
X-Received: by 2002:a05:6214:124e:b0:88f:ce0b:a008 with SMTP id 6a1803df08f44-89389f82fc5mr274303936d6.3.1768902685401;
        Tue, 20 Jan 2026 01:51:25 -0800 (PST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a72642fdsm968454185a.46.2026.01.20.01.51.25
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 01:51:25 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-502b0aa36feso25159961cf.1
        for <linux-can@vger.kernel.org>; Tue, 20 Jan 2026 01:51:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNo6RFgdZjj1AMzTehgZhvTRihoF/VkQ5DVzgeG/EhyQzF5M8JmYAoMZJTmm5pvIq1xc5lt4qtvqI=@vger.kernel.org
X-Received: by 2002:a05:6102:cd1:b0:5ef:233e:6b25 with SMTP id
 ada2fe7eead31-5f192508654mr6479996137.13.1768902342092; Tue, 20 Jan 2026
 01:45:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com> <20260118-rz-sdio-mux-v5-2-3c37e8872683@solid-run.com>
In-Reply-To: <20260118-rz-sdio-mux-v5-2-3c37e8872683@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Jan 2026 10:45:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWnpci1v1oQb34_QRtU-P3S8TSormmNudajT0e34EO14w@mail.gmail.com>
X-Gm-Features: AZwV_Qh1sWLkk903wC1dLdg8mLxjiEBVkYZdOb9H2O-Zh60PCWOHx0RPYuQB8LA
Message-ID: <CAMuHMdWnpci1v1oQb34_QRtU-P3S8TSormmNudajT0e34EO14w@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] mux: Add helper functions for getting optional and
 selected mux-state
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Josua,

On Sun, 18 Jan 2026 at 11:29, Josua Mayer <josua@solid-run.com> wrote:
> In-tree phy-can-transceiver driver has already implemented a local
> version of devm_mux_state_get_optional.
>
> The omap-i2c driver gets and selects an optional mux in its probe
> function without using any helper.
>
> Add new helper functions covering both aforementioned use-cases:
>
> - mux_control_get_optional:
>   Get a mux-control if specified in dt, return NULL otherwise.
> - devm_mux_state_get_optional:
>   Get a mux-state if specified in dt, return NULL otherwise.
> - devm_mux_state_get_selected:
>   Get and select a mux-state specified in dt, return error otherwise.
> - devm_mux_state_get_optional_selected:
>   Get and select a mux-state if specified in dt, return error or NULL.
>
> Existing mux_get helper function is changed to take an extra argument
> indicating whether the mux is optional.
> In this case no error is printed, and NULL returned in case of ENOENT.
>
> Calling code is adapted to handle NULL return case, and to pass optional
> argument as required.
>
> To support automatic deselect for _selected helper, a new structure is
> created storing an exit pointer similar to clock core which is called on
> release.
>
> To facilitate code sharing between optional/mandatory/selected helpers,
> a new internal helper function is added to handle quiet (optional) and
> verbose (mandatory) errors, as well as storing the correct callback for
> devm release: __devm_mux_state_get
>
> Due to this structure devm_mux_state_get_*_selected can no longer print
> a useful error message when select fails. Instead callers should print
> errors where needed.
>
> Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
> property presence check") noted that "mux_get() always prints an error
> message in case of an error, including when the property is not present,
> confusing the user."
>
> The first error message covers the case that a mux name is not matched
> in dt. The second error message is based on of_parse_phandle_with_args
> return value.
>
> In optional case no error is printed and NULL is returned.
> This ensures that the new helper functions will not confuse the user
> either.
>
> With the addition of optional helper functions it became clear that
> drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
> Add stubs for all symbols exported by mux core.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks for your patch!

> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c

> @@ -677,7 +707,7 @@ EXPORT_SYMBOL_GPL(devm_mux_control_get);
>   *
>   * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
>   */
> -static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
> +static struct mux_state *mux_state_get(struct device *dev, const char *mux_name, bool optional)
>  {
>         struct mux_state *mstate;
>
> @@ -685,12 +715,10 @@ static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
>         if (!mstate)
>                 return ERR_PTR(-ENOMEM);
>
> -       mstate->mux = mux_get(dev, mux_name, &mstate->state);
> -       if (IS_ERR(mstate->mux)) {
> -               int err = PTR_ERR(mstate->mux);
> -
> +       mstate->mux = mux_get(dev, mux_name, &mstate->state, optional);
> +       if (IS_ERR_OR_NULL(mstate->mux)) {
>                 kfree(mstate);

mstate is freed here...

> -               return ERR_PTR(err);
> +               return ERR_CAST(mstate->mux);

... and dereferenced here, leading to a use after free.

>         }
>
>         return mstate;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

