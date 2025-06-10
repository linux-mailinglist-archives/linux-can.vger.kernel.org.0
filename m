Return-Path: <linux-can+bounces-3801-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2D5AD3E47
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 18:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF3D161D00
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA7C23D2BF;
	Tue, 10 Jun 2025 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eQLzL2y0"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965515A85A
	for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571572; cv=none; b=Mu/KtId1Y2tzTjoLTtpFgSFzTHfuF89kLU2SzHvmaFFljsSJ3Hwj+SY7YLJVYaDcMT31h2p4Dl+jigNB9m39Dw5vKYmpwa3o9dvxMEKowcs9WZH6PKh0gfnB6x607z0IkkOsgKNTE0vZNyTIB1L+sQDxDb2KLVYWG/7a8BGxJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571572; c=relaxed/simple;
	bh=u6cGggZH3SoNATQpjfjKdz2DCIZcJJHBoyp8JLYX+lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u36RP5D6JQi1o/yXsbce719WbtQayK+bpZzfE0BEytDvLwignM1XIm0WDEIyOJRZIFKlT1Ac6F7HGObpyZcWct7aaDEepAr86PoIjViv1Klh3CgxRxeYm04bJI0zRICmV69sHva7H2jPs+jeXBN46to30IaHKAYSxJKFx4N7OYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eQLzL2y0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553241d30b3so5196788e87.3
        for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749571567; x=1750176367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBeEGoByLmNx0JymY4xT4q6q7D7j914xDLGGfvyG00M=;
        b=eQLzL2y00GZ30dqiHn6Z1b8t15Dk78jqEBxhQOW7DYZJ0tatu3bvWrxkImq7R8+6oH
         Sk8Kk+HmW4erRVPpuqSQuziMhY5h1ClbUuyf/rTCVyxgYXLDylH9a9OGKF3TVDx6lrPq
         fOpbWE6tBhoIQP2vUi5otZpT255Az8Jvmm3wLpN2NnaUTa6/b2R3Wiw7BfuSNUgBjC7A
         VV/DWSmphV21TDzFLEyvzo399gowzCR4YUxHsbkpXFU9yNrjmehqsArk5TBpsXeGWoyj
         kJyEbitcGIs7cWEScx/9kS9/nm7sPOvjoDJr/zTudNI+DuDG1c8KD+TvjhgdXQ3Qg4i7
         fX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749571567; x=1750176367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBeEGoByLmNx0JymY4xT4q6q7D7j914xDLGGfvyG00M=;
        b=PK7qcBIPO/QnY9RE+I2nI9LP3tiUqw7SGfCchT+JmPak5mhKGJkTdYBViC7P/Zd5pZ
         JAKnQiYW2MTWjPNiusPUNwA1o3F4r2CbABFq44UD+WA1RLviJnIDKB7AoGUuh6oBG0av
         Gh+Sh9KfyESmEYvDBYTq9MXpJhD31bHxtEj9pE9v8bS1Z+j/YFiVGQJ4sjx5o5YIYV/C
         vmY8htsHuXDz/waGOt2eCafVVFHqagSW05J6B4dhycHrZEAnhNtHuXapVlbH+6/DqAdc
         LHutYju5AlCdQdjlnD8Ujd7IkKH0GxBEcCqzEPkfQzHXLhEVcn6YBXvan8ISXfHKp9z/
         8Zng==
X-Forwarded-Encrypted: i=1; AJvYcCUUE+ylIrSurYyY58pjEnd29urMtJpfOiMv1JHmRtiHQDRNUxl0GSC66vdWreI6aH13+DnL7K5afaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMgJ9JU2m3LPT4+yVx5EdqEN11LtdLyUae8N2+DUVR1FhYAKxh
	D9RKqGEm/JUzpdWyVrXuTsRWky79pd7cYLtNBx7P7XqZJ31KqBq4+toGwkfT5/+C7o0vRqpEsaT
	rV69zHbpoEAwTd/h8UFbZYRG3c8qTKj53Cf41jdd89Q==
X-Gm-Gg: ASbGncsPPl1usCtr6pMYDIBDD8CFRaPdI4VTvUcYE7DezkWTCmPuGaZUaGoSQYNtCxs
	AKcrOwR7ihFd8617BpYKEvER2cNyvy3Xh2NHjhCB26fhd3kUAfl4T4hfamFN1LxNGEt7IAuYaGZ
	5ySJRtFxEDJLF8EYynF0I/SRJYqA8SneO+aDjsvB4sn4vVqJ2YEMv8X/n8oTShzvgP3gO6YoPf
X-Google-Smtp-Source: AGHT+IHd3I1OVEWgMny7h2Baqh5DBJB572YkfzrpOW/nSB1wjoInAYuzH6/ihFE+HkYDZj2j7lo3/mOOSaalg7HeZM0=
X-Received: by 2002:a2e:bc23:0:b0:32a:87ce:1235 with SMTP id
 38308e7fff4ca-32adfc3f54fmr52666951fa.36.1749571567213; Tue, 10 Jun 2025
 09:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610-gpiochip-set-rv-net-v1-0-35668dd1c76f@linaro.org>
 <20250610-gpiochip-set-rv-net-v1-3-35668dd1c76f@linaro.org>
 <b2f87cff-3a81-482b-bfdd-389950b7ec8e@wanadoo.fr> <CAMRc=MfCwz3BV15aATr_5er7wU=AmKV=Z=sHJyrjEvLwx2cMjQ@mail.gmail.com>
 <b9ea7e0e-7dd1-460b-950a-083620dd52e9@wanadoo.fr>
In-Reply-To: <b9ea7e0e-7dd1-460b-950a-083620dd52e9@wanadoo.fr>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Jun 2025 18:05:55 +0200
X-Gm-Features: AX0GCFsFWH4b7yJkolxQLHQKmDUo4N7FgPgYNia8CjJoC_PxTolZxLLShEa2WEo
Message-ID: <CAMRc=Mf4qupdJEm9mWPF3-B3hprn6AvP7Po2=aQYbaSvFf8OeA@mail.gmail.com>
Subject: Re: [PATCH 3/4] net: can: mcp251x: use new GPIO line value setter callbacks
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-can@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linus Walleij <linus.walleij@linaro.org>, "Chester A. Unal" <chester.a.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 5:48=E2=80=AFPM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> On 10/06/2025 at 23:05, Bartosz Golaszewski wrote:
> > On Tue, Jun 10, 2025 at 3:55=E2=80=AFPM Vincent Mailhol
> > <mailhol.vincent@wanadoo.fr> wrote:
> >>
> >> On 10/06/2025 at 21:37, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>
> >>> struct gpio_chip now has callbacks for setting line values that retur=
n
> >>> an integer, allowing to indicate failures. Convert the driver to usin=
g
> >>> them.
> >>>
> >>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>
> >> This does not match the address with which you sent the patch: brgl@bg=
dev.pl
> >>
> >>> ---
> >>>  drivers/net/can/spi/mcp251x.c | 16 ++++++++++------
> >>>  1 file changed, 10 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp2=
51x.c
> >>> index ec5c64006a16f703bc816983765584c5f3ac76e8..7545497d14b46c6388f39=
76c2bf7b9a99e959c1e 100644
> >>> --- a/drivers/net/can/spi/mcp251x.c
> >>> +++ b/drivers/net/can/spi/mcp251x.c
> >>> @@ -530,8 +530,8 @@ static int mcp251x_gpio_get_multiple(struct gpio_=
chip *chip,
> >>>       return 0;
> >>>  }
> >>>
> >>> -static void mcp251x_gpio_set(struct gpio_chip *chip, unsigned int of=
fset,
> >>> -                          int value)
> >>> +static int mcp251x_gpio_set(struct gpio_chip *chip, unsigned int off=
set,
> >>> +                         int value)
> >>>  {
> >>>       struct mcp251x_priv *priv =3D gpiochip_get_data(chip);
> >>>       u8 mask, val;
> >>> @@ -545,9 +545,11 @@ static void mcp251x_gpio_set(struct gpio_chip *c=
hip, unsigned int offset,
> >>>
> >>>       priv->reg_bfpctrl &=3D ~mask;
> >>>       priv->reg_bfpctrl |=3D val;
> >>> +
> >>> +     return 0;
> >>
> >> mcp251x_gpio_set() calls mcp251x_write_bits() which calls mcp251x_spi_=
write()
> >> which can fail.
> >>
> >> For this change to really make sense, the return value of mcp251x_spi_=
write()
> >> should be propagated all the way around.
> >>
> >
> > I don't know this code so I followed the example of the rest of the
> > codebase where the result of this function is never checked - even in
> > functions that do return values. I didn't know the reason for this and
> > so didn't want to break anything as I have no means of testing it.
>
> The return value of mcp251x_spi_write() is used in mcp251x_hw_reset(). In=
 other
> locations, mcp251x_spi_write() is only used in functions which return voi=
d, so
> obviously, the return value is not checked.
>

Wait, after a second look GPIO callbacks (including those that return
a value like request()) use mcp251x_write_bits() which has no return
value. It probably should propagate what mcp251x_spi_write() returns
but that's material for a different series. The goal of this one is to
use the new setters treewide and drop the old ones from struct
gpio_chip.

Bart

