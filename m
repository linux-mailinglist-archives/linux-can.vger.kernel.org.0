Return-Path: <linux-can+bounces-5895-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B03CD5995
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 11:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 085043002FF0
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7AC3321CB;
	Mon, 22 Dec 2025 10:15:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D353321C8
	for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766398540; cv=none; b=ZhhUTOlTVdkcKaWLp6mMrrePNtIlQfIsOo0ExlFu5qxgHjcUOPB83DHoCIJB6JJ7lZ5klBPCJfUN6Ytu0zFfhogU0wdawXqjgtJtzCc3Csj8gquVhRo5Fs732GxKEIuL+27Kwu2phr89np+J1o3WJCS27/mPDxu5HvlimVYs9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766398540; c=relaxed/simple;
	bh=pYxC0xGJLfaMlKM2nphME9JmmJ1biPNjHd+MZwrmnFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxXD2swI2pVisrT3IlR4DfxamQmuhZTHW2O+ZCYqdBsgGhA+hRAfmPNA0JzBXD0PUKSPzZaSr+VB3t7RLurDHaAKf3SCuhpgU+7DEOZvZSymhSfCyGD5PJErHhRMeHPRXfGkQAfWtEzhK3/Fz9WKHkbnKzFY66qGvcnXB/3A2wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-455dc1cf59aso2539632b6e.0
        for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 02:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766398538; x=1767003338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEzlntz/A3Digs4sjukIlKb5qv62LH8yawTgFzZ88fo=;
        b=KD/BFmKOl1GEyPV1u9BkKx++d5eQnoEEvWcjP2c79LpvrWIVZxtFDH9xDHH3k8dufw
         FpKSGRU9VAQhzugXKVH/JnXh5gpDuDRunnOOjd4L0Hzp40lbzuM8IOfQI+8K7dc9/pDg
         tMJXPrGY+oqVKuAQ0QZOAV6W2c7Izb7AHb3rIUZrEXFsWhG7m0LHdHJlWUt5WaEnIYCV
         CemzoYPrbyBYv8FEVvY+cAHasKELOIe0IrSBs6IvxnSTBnecHbnxTgmS5lGqsYttb+gd
         gRaS55KkuI8C0atM/fmwQQkl6TVh9TNQdve3YnK3M4V2h8HnQ+rkyXOBYCnOcx2KKMej
         nVrg==
X-Forwarded-Encrypted: i=1; AJvYcCW0y2YV65iDzt4lMo9m5hWrk2sPdy69OaOGpatCE1XR37X0iDGviNUxPgCGJbSYlve8XERIO7vvIoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaKkUG4eMDqBtsPZslUCRpFA6cfGMPnwD4p4Pc3Uqfvo2TFEOb
	n4ubpfyneYFfWq4ayN9TJQIk+uRihS6Vcfb1+Hq3swrIz4gIHUIuHZA8yQlGMcC0
X-Gm-Gg: AY/fxX5T6DAlTPzViAFaOkAi4fqgG00JhDX0VlMVCxEmERK8Bh3J1YqvRW9rtY+66K6
	P21vy4m9vl5q3xknHCBlRdkHO/q1niWd0okQ4RJrx71KjUfkBE+wVLLxscQEQV97qQABq+ml+td
	u0zj0V3aqS+sc2lA5ROrJF046kinrU3SOWzcj8nHQEJxoxpoNQyjcELhWIz+5M97QYClti2TQPZ
	IHXQs4Kg4V/icmO6JTAIxSTM8E+3LnDQyPhXyRX+vg2cGYi5UuRgLBNYnwLW+Ue8Z8XpO9+cdEb
	E6ocaN4k4MgcyAsdaV+R8KZHeAh9o93RzUPMYNlLz1msA7UdA4j5AxP46VCebhfG1jOBLvH9SxU
	RzOXGgF+7CNtYLe9N8iik7vrq+1v1AJAgRMZjHAoZIZvuEwOW+qve1gk50akMUhXq8QkTdHNTD9
	RozMq0aS/4JCjYXCU1wFJCsXHRhRJcHkrqJO/BsadZyVryjSSBVI872l+FRow=
X-Google-Smtp-Source: AGHT+IH9klsVS6/lfklqYviBsYPranv1kHHzG0O+pUsshQYIis10VdMMYaNrTqHWb4u0W3m9CWtLSw==
X-Received: by 2002:a05:6808:e85:b0:450:db06:6079 with SMTP id 5614622812f47-457b20facdemr4674372b6e.53.1766398537961;
        Mon, 22 Dec 2025 02:15:37 -0800 (PST)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc66645494sm7256245a34.0.2025.12.22.02.15.37
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 02:15:37 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-65745a436f7so2160050eaf.3
        for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 02:15:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUoqsDI7zuZuKlnfU2bZ1LXeg8YlrHSTw3flktEjRdwd8OTi9X3oIJcdei2S+ejUqgrW3mPxQP6DO8=@vger.kernel.org
X-Received: by 2002:a05:6102:3a0e:b0:5d7:de89:8dc6 with SMTP id
 ada2fe7eead31-5eb1a616c74mr2760273137.6.1766398102025; Mon, 22 Dec 2025
 02:08:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com> <20251210-rz-sdio-mux-v3-2-ca628db56d60@solid-run.com>
In-Reply-To: <20251210-rz-sdio-mux-v3-2-ca628db56d60@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Dec 2025 11:08:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXjAS6HOYy5=uxcK0RZL5X6agRoHG67QUw4xh5+ovZaJQ@mail.gmail.com>
X-Gm-Features: AQt7F2qgJlv5WWEn-8R7_EQWn45G6An5kBRt8R2C89e3bKVxcY7XZ_y43fEdjFs
Message-ID: <CAMuHMdXjAS6HOYy5=uxcK0RZL5X6agRoHG67QUw4xh5+ovZaJQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mux: Add helper functions for getting optional and
 selected mux-state
To: Josua Mayer <josua@solid-run.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>, 
	Jon Nettleton <jon@solid-run.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Josua,

On Wed, 10 Dec 2025 at 18:39, Josua Mayer <josua@solid-run.com> wrote:
> In-tree phy-can-transceiver driver has already implemented a local
> version of devm_mux_state_get_optional.
>
> The omap-i2c driver gets and selects an optional mux in its probe
> function without using any helper.
>
> Add new helper functions covering both aforementioned use-cases:
>
> - devm_mux_state_get_optional:
>   Get a mux-state if specified in dt, return NULL otherwise.
> - devm_mux_state_get_optional_selected:
>   Get and select a mux-state if specified in dt, return error or NULL.
>
> Existing mux_get helper function is changed to return -ENOENT in case dt
> did not specify a mux-state or -control matching given name (if valid).
> This matches of_parse_phandle_with_args semantics which also returns
> -ENOENT if the property does nto exists, or its value is zero.
>
> The new helper functions check for ENOENT to return NULL for optional
> muxes.
>
> Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
> property presence check") noted that "mux_get() always prints an error
> message in case of an error, including when the property is not present,
> confusing the user."
>
> The first error message covers the case that a mux name is not matched
> in dt. This is removed as the returned error code (-ENOENT) is clear.
>
> The second error message is based on of_parse_phandle_with_args return
> value. In case mux description is missing from DT, it returns -ENOENT.
> Print error message only for other error codes.
>
> This ensures that the new helper functions will not confuse the user
> either.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks for your patch!

> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -542,11 +542,8 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
>                 else
>                         index = of_property_match_string(np, "mux-control-names",
>                                                          mux_name);
> -               if (index < 0) {
> -                       dev_err(dev, "mux controller '%s' not found\n",
> -                               mux_name);
> -                       return ERR_PTR(index);
> -               }
> +               if (index < 0)
> +                       return ERR_PTR(-ENOENT);
>         }
>
>         if (state)
> @@ -558,8 +555,10 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
>                                                  "mux-controls", "#mux-control-cells",
>                                                  index, &args);
>         if (ret) {
> -               dev_err(dev, "%pOF: failed to get mux-%s %s(%i)\n",
> -                       np, state ? "state" : "control", mux_name ?: "", index);
> +               if (ret != -ENOENT)

I think the non-optional variant should still print an error message in
case of -ENOENT, else this has to be duplicated in all drivers using it.

This is typically handled by having a non-printing core helper function,
and having printing non-optional, and non-printing/ignoring optional wrappers
around the former.

> +                       dev_err(dev, "%pOF: failed to get mux-%s %s(%i)\n",
> +                               np, state ? "state" : "control",
> +                               mux_name ?: "", index);
>                 return ERR_PTR(ret);
>         }
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

