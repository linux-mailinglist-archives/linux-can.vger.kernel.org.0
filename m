Return-Path: <linux-can+bounces-6231-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71829D3C4F7
	for <lists+linux-can@lfdr.de>; Tue, 20 Jan 2026 11:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1FCA6C3028
	for <lists+linux-can@lfdr.de>; Tue, 20 Jan 2026 09:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61933B8BB9;
	Tue, 20 Jan 2026 09:56:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1553904FB
	for <linux-can@vger.kernel.org>; Tue, 20 Jan 2026 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902990; cv=none; b=G96b05NjnXfP7rxKvSSELruDRTwaM+4r/ZhKDLR+yGB/2axHGvluz5/P1LBhvhZc6lNkXreYe5kvOgREKBdn3DTv/YxLGIwDiLxzXmLRyH+3mNXvzQKQdXfHmI0W3wenHVlZRrAoROIbrrBWkcNOTLcFrNz/hnSAwFlaNSKY/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902990; c=relaxed/simple;
	bh=PhelJ3YKLy0g5664IUc1xRM3vK2MnAcXyilLWshEZX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeXN6z0LLHkwBcT1l2yhqg9Tnt6Z01JqcmyWiF9PhOg3TadD26x9b1a11Zqe6cTZrXAaguM+gVGon07ZwxGBvgLLCV/rcbNneibzxg8U6CZe6Tu8YvgB0l8kimaHhHfNcTOUj7mYsBZtwBYRMweBPrDIsUIqkp36BNk35WyDEzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-65f6f9d84d6so3114302eaf.1
        for <linux-can@vger.kernel.org>; Tue, 20 Jan 2026 01:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768902988; x=1769507788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMqHiB2kIqqBrLa59wdqxa2/T5exJBY1xL1A1svqwlE=;
        b=k4BOHJWIaseOqqFzqnEGV/g2ZVOTPEN3bdzWev7MNCfJBcjfqQPVDUBBJPen8pUjig
         Kv7C7qRpJN0WvSKBu144EBEy8x8MP1DDwT6WX6oIFYCA/Q2K0LZpX5d6wdmnizEKi3Ar
         XQha4tUfrWUTreUjCmdEjEa1KHEosyDXnxx9qRg/zMcN4aRYUUbGKJB+C/zmpYL7EVds
         2e//BQyjk0M3LkIlzaopdmOPgI/ovRbt/d1gur84xxaLVZEnFrlmwhV+IEDPH6cN2PRT
         +uf+y8wknCGfyp3xXcREBQ4sG4HvtBbkCNpqfmAT4I5rgSiF/FgNSP5HgIyWaDO8tjYJ
         +Vww==
X-Forwarded-Encrypted: i=1; AJvYcCUrXdJ6y39a6LAMjFVhQ0+MVrbjgKXMO3fEsos1GHDf7H4KsYFDrofRUQP4IYbieyix07HKenyYWT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR9abg1BZejTFOWtNycL4uL/lZSAJAVklnoTYOiELcjrlKVD4A
	ZGfgMvwkNoX8tmOHw14h6sdjlHcswzm6qByDjpxD8jDiQ9MT/g74FLQeHk/WgVRzPHg=
X-Gm-Gg: AY/fxX61svSYj1ycltWfO8HLZH+TWGqlZ2vC6s8JwT9yqssQV5CJwmFoY+fjOlgiki+
	szcNsUyZ/cPypIWutOmRMTmeQeGMZWPXGKzKzGwBGz1shzKPzJ8G4MVeo6+muJCDTTPCzlG5+Zw
	0yWHapQ99DPIq9U18eqWKmUCDd+IdvU2kgXQG3tYfxpaYhqEJtLRaI6PtllOsLOkrZWzsLkLL3i
	pXE5Fg9xFvddIPEP6BT/rHcKCI2qp0qqKBbkq+7VKqgp/dPriyViFKlK60lxdiIvbuaiC8+BU8+
	qu5U1FJ2kmbpufrxZ6aoafXntDszvk0KuaY/mntV9cJwMfX15dgwIC4CWrb+stJ8OJ53ELR/YXC
	kdkiyWm3HG445ETYdvSCnjSEq7qLwPXMQN7vfGmJehHnKojF13KcetAC6XShL+FEWmGFs1rYTQT
	89O3HCfUoo7dTnqjaVgfzRv2gjBhtJV8gIm55tzz48lVdW8CyXyj6t
X-Received: by 2002:a05:6820:f0a:b0:65f:6ac2:7861 with SMTP id 006d021491bc7-662b0063b83mr498884eaf.50.1768902987619;
        Tue, 20 Jan 2026 01:56:27 -0800 (PST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66289e3af7dsm4628946eaf.14.2026.01.20.01.56.27
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 01:56:27 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45c958d48a9so2645710b6e.1
        for <linux-can@vger.kernel.org>; Tue, 20 Jan 2026 01:56:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhb/aX+dTCihi4vxfB0nPDX8fPh5DOcSBc/LAxk4UzndBrZ39INmX++3RzZmI+6vf4WCQK8BsoNS0=@vger.kernel.org
X-Received: by 2002:a05:6102:2928:b0:5db:f6ef:560 with SMTP id
 ada2fe7eead31-5f50ae0a099mr264663137.28.1768902583158; Tue, 20 Jan 2026
 01:49:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com> <20260118-rz-sdio-mux-v5-7-3c37e8872683@solid-run.com>
In-Reply-To: <20260118-rz-sdio-mux-v5-7-3c37e8872683@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Jan 2026 10:49:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU5shzYs27wO2A0SoisGBMo8RHf9DO-ubC6VrhWECEPCw@mail.gmail.com>
X-Gm-Features: AZwV_QjEUqevj8OUxZ5xnP3V3BgNbEzQSiuy0CgomAkdvyQGaaSlv633jCWavtA
Message-ID: <CAMuHMdU5shzYs27wO2A0SoisGBMo8RHf9DO-ubC6VrhWECEPCw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] mmc: host: renesas_sdhi_core: support selecting an
 optional mux
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Jan 2026 at 11:29, Josua Mayer <josua@solid-run.com> wrote:
> Some hardware designs route data or control signals through a mux to
> support multiple devices on a single sdhi controller.
>
> In particular SolidRun RZ/G2L/G2LC/V2L System on Module use a mux for
> switching between soldered eMMC and an optional microSD on a carrier
> board, e.g. for development or provisioning.
>
> SD/SDIO/eMMC are not well suited for runtime switching between different
> cards, however boot-time selection is possible and useful - in
> particular considering dt overlays.
>
> Add support for an optional SD/SDIO/eMMC mux defined in dt, and select
> it during probe.
>
> Similar functionality already exists in other places, e.g. i2c-omap.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

