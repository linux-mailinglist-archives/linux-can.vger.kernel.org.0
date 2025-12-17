Return-Path: <linux-can+bounces-5871-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFC0CC82DC
	for <lists+linux-can@lfdr.de>; Wed, 17 Dec 2025 15:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 960B431209EB
	for <lists+linux-can@lfdr.de>; Wed, 17 Dec 2025 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E547350291;
	Wed, 17 Dec 2025 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p3Rlr0+T"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB7234EF1E
	for <linux-can@vger.kernel.org>; Wed, 17 Dec 2025 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765978983; cv=none; b=Pk+UKefFyj8+Q3+4xdAnPhpUoBFL0FYVuwMDEmR/W3QN/poDfbell8kKRrPu2x5X2IxWFizGY/OnmpFuvNiz6Lc2Rqtx+WAiFdx1n58i3ap0s2U+MxX+scGKJ9pQAHaFEAbQIGHYvLezbhG3+GXhiW/Xg29RUx0qvp1t/nlucXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765978983; c=relaxed/simple;
	bh=nre4+f/1qweJxFoeeHsRIflrATunEW5LWrhj6Pv/YRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ki9zisAFByHynU1EgFSbBT5NJ8fyhW3loLWzPsenL8oQkzP3CKWokdMfDg4HJ4Xzte750IY1VEL4MLjw1TpHiTilrerkoal9F8TH1qlI3p6a0dFhGYRNWTtlSsylDBMKWhXBLBhXcON9Ft+syCLPs9ytEUihuNNJb+XJIgtVwCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p3Rlr0+T; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-597c83bb5c2so5118998e87.3
        for <linux-can@vger.kernel.org>; Wed, 17 Dec 2025 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765978979; x=1766583779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i+2rCMNUHkZI89lP4N4BumifdRKTsaBf6MC8t3850FA=;
        b=p3Rlr0+T95LKZQayrzXYTvbUvv6N3iakcHQxpWx65eUd8+lUCwS9f/6Vq8MUTJdvlz
         7HBLv9cPHp0cj23HbmJUS2Dh4U+l0qYdvF3aaPSH5JhrZ7YwOrobUVipOLHpwW7ccrIf
         zJ+8xK/8D5t6y3s2jCWDJHgv/e+jJdAWR8rd3sUGUxoNuroOChb1flv7wxO4rM6o3+YN
         9bffZEShBR52yarjv9mW5IuaDnM93Nl2nAyIZVXA1W7zJbGNr+KOAczd0O2ufav4PF0J
         Zz8oMvmmVmyPwHwvBQtuaBJquDvPpGmglAzCfZ8Kc7HPVa437NOe0NjK+mIGVYzE6vk0
         B10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765978979; x=1766583779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+2rCMNUHkZI89lP4N4BumifdRKTsaBf6MC8t3850FA=;
        b=fmibq6Mas9AbPZF3pPWoq5P5oBF4KL1HduojlS7p1Dk4Uv4nCtCRd+sxj0ItXETdQP
         Ppmpa4qH4dRiDPFJeeP6j82RhADhHdiQTqB3haS3BDmr5njhhnzgmATUGHlierTsAM9p
         KL3HiaHYhn0PbB9+nAYOt3bFtdjlkwMqam5sGKOJXH0gO68VTKINA8gvtDo7qbZOfsSV
         rnj8xWkzlvIuwxJNRW5CdsqMFyYxImxGoD2QTGGDrGaCceHtlJ3MtmURBYNOb+GKdVXx
         ajNdAhkdXmFUBWkw0uApxOViR4qn0ZtA+OC1YHjFoMBCOhq4ySwK/jZSznksRr0RUk6G
         h1gg==
X-Forwarded-Encrypted: i=1; AJvYcCXU5gZicoXN5On5PxogCVPZpTwZe4U8kgPegvH20Tnzq3xatjKIXh1r4zavROUBqRd13IAd6BjQBxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXGXXbIrd+11wFcxS5JBfmoD4GlipnRvqdKndz2JzAiC5YdB27
	exkMY8zbHeYXEuK3IUZIjSE3p5glDSO4h0RWT57ygJj8DwmLFtvIQmnz23tX67Bam48dKwJZ6/d
	4GLF+FM5T8c97jeV3R6oSTzBYEWN286vaZTACvKd2VQ==
X-Gm-Gg: AY/fxX6nWM0KMJylPjYbJtIpaBTMAdNBXFt4P4EZXONop2yi2pkJw9xg1BVvVd43z4j
	aGE7EQVrGcwkDi10cLIUr8eKA9XLHx4B4DJu6agTZlI2KGKYEk+rkGcsKJYHNmqIGk3vLQ3X43e
	PAxFX/94PqcMtder4NJ4B3Dt0kAPkbZF+5KAIdMkFVDujZmhxRo0JGQChN+RfEONcaXSybh09qs
	ggi71dKeHXikfEnTfxPjebNccg2ot7w05vDJ6lopn7Xmjib/S4bO4vDi9tqEZfiguobJBk=
X-Google-Smtp-Source: AGHT+IFQ7RFU2XYjhNpz4zPlGBfxB8IQy25jb9NHzoC5kJ0seGo5jh0pCCbvJquopiBKgSSVm6gg0z6EMwvFTEugGus=
X-Received: by 2002:a05:6512:3a89:b0:598:f262:15c7 with SMTP id
 2adb3069b0e04-598faa4d4c4mr4998838e87.25.1765978978821; Wed, 17 Dec 2025
 05:42:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com>
In-Reply-To: <20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Dec 2025 14:42:21 +0100
X-Gm-Features: AQt7F2rn4fUAIJmNzeBvaDU3HopJ0wrtd_f0H7TRKpgHGGrU8bW-ugZfTBQ1TVc
Message-ID: <CAPDyKFr7DCRs_E4VfrY9-NY8-bStT9oAZaYhUZDg_y3KEW9DWQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
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

On Wed, 10 Dec 2025 at 18:39, Josua Mayer <josua@solid-run.com> wrote:
>
> Some Renesas SoC based boards mux SD and eMMC on a single sdio
> controller, exposing user control by dip switch and software control by
> gpio.
>
> Purpose is to simplify development and provisioning by selecting boot
> media at power-on, and again before starting linux.
>
> Add binding and driver support for linking a (gpio) mux to renesas sdio
> controller.
>
> Introduce generic helper functions for getting managed and selected
> mux-state objects, and switch i2c-omap and phy-can-transceiver drivers.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v3:
> - updated omap-i2c and phy-can-transceiver to use new helpers.
> - created generic helper functions for getting managed optional mux-state.
>   (Reported-by: Rob Herring <robh@kernel.org>)
> - picked up binding ack by Rob Herring.
> - replaced use of "SDIO" with "SD/SDIO/eMMC" in binding document and
>   commit descriptions.
>   (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
> - Link to v2: https://lore.kernel.org/r/20251201-rz-sdio-mux-v2-0-bcb581b88dd7@solid-run.com
>
> Changes in v2:
> - dropped mux-controller node from dt binding example
>   (Reported-by: Conor Dooley <conor@kernel.org>
>    Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
> - Link to v1: https://lore.kernel.org/r/20251128-rz-sdio-mux-v1-0-1ede318d160f@solid-run.com
>
> ---
> Josua Mayer (6):
>       phy: can-transceiver: rename temporary helper function to avoid conflict
>       mux: Add helper functions for getting optional and selected mux-state
>       phy: can-transceiver: drop temporary helper getting optional mux-state
>       i2c: omap: switch to new generic helper for getting selected mux-state
>       dt-bindings: mmc: renesas,sdhi: Add mux-states property
>       mmc: host: renesas_sdhi_core: support selecting an optional mux
>
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml      |  6 ++
>  drivers/i2c/busses/i2c-omap.c                      | 19 ++----
>  drivers/mmc/host/Kconfig                           |  1 +
>  drivers/mmc/host/renesas_sdhi.h                    |  1 +
>  drivers/mmc/host/renesas_sdhi_core.c               | 16 +++++-
>  drivers/mux/core.c                                 | 67 +++++++++++++++++++---
>  drivers/phy/phy-can-transceiver.c                  | 10 ----
>  include/linux/mux/consumer.h                       |  4 ++
>  8 files changed, 89 insertions(+), 35 deletions(-)
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251128-rz-sdio-mux-acc5137f1618
>
> Best regards,
> --
> Josua Mayer <josua@solid-run.com>

Looks like this needs to go together or if someone can host the common
parts via an immutable branch.

Anyway, I am expecting some discussion or update for patch2 first.

Kind regards
Uffe

