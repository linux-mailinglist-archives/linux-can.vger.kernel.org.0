Return-Path: <linux-can+bounces-6229-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE361D3C42B
	for <lists+linux-can@lfdr.de>; Tue, 20 Jan 2026 10:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C32F15480C0
	for <lists+linux-can@lfdr.de>; Tue, 20 Jan 2026 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43A3B5300;
	Tue, 20 Jan 2026 09:35:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3625F3E9F61
	for <linux-can@vger.kernel.org>; Tue, 20 Jan 2026 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901718; cv=none; b=X18PEQ3Ynywzf3zFkfnpg/y2ZNTqqmjkSTaHBmLWdZoMF9/OFpcMntGl2Vll2V9L+ZYMTn+AyFepMc+c6LdizFjBwRxEl1Une4KS+LOgdVc0W0JsqLfwlSrl/31v/9yPh3tNQw/uHz+GJmbecQ+QOi9g3bZefXv/cauzCv5Li3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901718; c=relaxed/simple;
	bh=8oF7WvkLTpbnCP6yb2DMCynlFu+13M83ZUzjQuNxXOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xn3hiQwFX/zs+F+uNoSQF9YKRuCW1LvDfhN4t4QUjViCgh3drXc8Hy0KzooGXSwZR52Yk5MbUr/5vUmCVXDw2bv7QkrS66ZceYuE4CWy5Tu0lp/NwkBHaUz2jTjOa+mO7Y2XAZInDrcXZFnbQWOcT74LlGo4DVNZ0ucpM73YVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso3378302241.2
        for <linux-can@vger.kernel.org>; Tue, 20 Jan 2026 01:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901716; x=1769506516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97LNh80TR77S8pwS2e4ZBU/MTmpHjj3Q16znIrdsedk=;
        b=qL+it/9F/iGWHw1qG5OsZFLX7M3UjQEAR+cQZFY4rXFFuZoZHOiIvfJi2OXBoKyuop
         86TWb28k3ZN5ek14wmZWZIgq5V2e3ctljlqPm5+bjS8/I/VeMSPZDe5OoAqV//B/TlqR
         Cl1Nl+MinsPIkPdcCFBvtq8P7gcQ+fBvB2W6gW+s/QT0oDoZVSKRGbALNiyPnGSbwSNu
         jz/PpMtRQaUVYqecLE0K+sF6Kr/9/4HIzyL0uVHPONEUchLjmFzYRVQH/9OjaWkGhCAS
         nIvPfQkhKZmF4un4nCSGlMLUGoD/GO0kHdJNtO0ZXDYRFGHmExtM9EwJrHTwcgKdT+6h
         baHA==
X-Forwarded-Encrypted: i=1; AJvYcCVr+s0pmHWRoQeKFZagZaa6ZBg9InyaMPb5nZVXm+7QgeyRp4jUMI/3oL2eg6yey30BdhojsRVtrHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSxMZF47eUwwJG8WZRa5+m9w3nRIaHVLcBs3NRvH4QQiQ0wN3W
	uaJazlwzeWAaZ+PXmUjha95jnBdvlr9ncArJyd4qLgMeCEU+TIT7d9NH3MF1M+Kc
X-Gm-Gg: AZuq6aKiW83f+H2Xgjsf8tL5eOquHhS2dqA2MvUf3KE/DSqGRTxN+rnNqF9wieFPlZ1
	YdAtrPCruorzpGCmvrTqHx56v/wEJbUnpHINQItmQiciIGGY5467UOSm42WxIvPOBjAIPcH83jN
	tyZt/CMaTMJMdaqSJp9SkjeSf0q77kmRR5Zf162PQItWPmb6+HQgGOf8PAVvWmPV8PCnJ5KCIIL
	X+tUDLG8KW+SyVmgx4y4IyJ9EhDmb2Q9o985rqnYELQfRrGadVGuUkifT91Tjx9ebiIyP5/Pl9j
	u5bWujd0xjCDAYaB7baNpFmTjCV2t2Agfvehq6nWW/cdUBvmEQlGgxUjxAtUkQkueopqEj3U4NN
	jkZd8J95dT71E/mUWfdo6M+rsdESgbJJhgclKfUQQO07AYKknIlOFwEsWwcAZ7w4T70zNwZHnTi
	cqdrFAJG47tZsA/cTp3kIoM8bwrazl3ER39ps5dMJ5QrqR9z5H3YqQ
X-Received: by 2002:a05:6102:dc6:b0:5dc:7fe3:1d0 with SMTP id ada2fe7eead31-5f1a700dba0mr5204867137.19.1768901715998;
        Tue, 20 Jan 2026 01:35:15 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6e60c9bsm4186208137.14.2026.01.20.01.35.15
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 01:35:15 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5636784883bso4227444e0c.3
        for <linux-can@vger.kernel.org>; Tue, 20 Jan 2026 01:35:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6YZVOdxCrNwOXxWrGqs20MI73rnkFQU2/eLJj0uwtVDTnzlLe1PQBsQAVnze3VeHkVsyEQjxs0vc=@vger.kernel.org
X-Received: by 2002:a05:6102:1610:b0:530:f657:c40 with SMTP id
 ada2fe7eead31-5f1a712440dmr4338759137.22.1768901715766; Tue, 20 Jan 2026
 01:35:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com> <20260118-rz-sdio-mux-v5-1-3c37e8872683@solid-run.com>
In-Reply-To: <20260118-rz-sdio-mux-v5-1-3c37e8872683@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Jan 2026 10:35:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVf7MjEAaTAy3kgaTcfs240UcnL_yFWfYH_eqVfp-6jvA@mail.gmail.com>
X-Gm-Features: AZwV_QifN5dzgWIfmsNWfdw085d37JEd6a5y3M-TObPOlkszfcRmE9SintqdNzo
Message-ID: <CAMuHMdVf7MjEAaTAy3kgaTcfs240UcnL_yFWfYH_eqVfp-6jvA@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
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
> Rename the temporary devm_mux_state_get_optional function to avoid
> conflict with upcoming implementation in multiplexer subsystem.
>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

My
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
on v3 is still valid.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

