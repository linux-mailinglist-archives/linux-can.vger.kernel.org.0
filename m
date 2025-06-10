Return-Path: <linux-can+bounces-3798-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4636AD3A3E
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 16:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CA31895FDF
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 14:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0272729CB4F;
	Tue, 10 Jun 2025 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="etxZxmZx"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FE129614C
	for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564360; cv=none; b=eP0j8xI7ePC44Yn3KRbdZLyg5wuIETJSyohtDoe6ZlVI1xMvtphVYLlQ6d9EXcrXDBvU61Wx0Au+gB7qYLIM87u/mVEnsjHudEbcjAv+xjX9ITcE6p/f9K05rTEoM4z5IIISK7g45PQxzLLP32wwd3ejQi6GSPaOfT5UA/Sb6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564360; c=relaxed/simple;
	bh=kxrLkvelHxMTEXuljgeHJCpG7xgrvRPn1OOIhqwjvTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Siq26AYUrrLfEkyBJ5/QYMTPxRxzmLuiTYPChT7mu3JzZ+/9qRfD50hrB0/esiLT7XQXxemc71hkWZLUzwPlzgSLhb6Q5FFTU1JRF/8xNe7wuGjnrHaBFQ6CQgrDIYUsny5rvU32eNdD6Xm5IS3VpWKx/148oOOqp5KiZYZb4Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=etxZxmZx; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32ac52f78c1so55733551fa.3
        for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749564357; x=1750169157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48R6rmcYMdLE2oI43bVdlx+c/dGz3JTf+F6/kFw0QQY=;
        b=etxZxmZxAE68ZjaPAV7MXz3iG4S3/yG+wh8k9NjDNlzCDTEvIXjb3xOQV0GeYFWBTv
         DAcsEQLZ3IwIBnHdNIUz/VdfYoN6hKa9LLoC2gQSsLvBLS/KxlPN0qEkZ6PVSBt1gbe4
         L2ENg0/I/Jh7hRJEn1kHUh4bM0iyMA/wl4Vi6IKYPFxA1J0vXD9BFWC2CzaQHKqrDSC7
         PJD8P7h4UoDRxYiKm0FNFcmD5qhTEE681vlPHgDrBdCVlY9naQiXi3f1JTA7thVB3SuO
         OQeayr1rrIhyEJy/15pcyDXlm2jelh6nQT4ru7whVfPsAgde7E70fcRPYCtv4es7UPMv
         SWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749564357; x=1750169157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48R6rmcYMdLE2oI43bVdlx+c/dGz3JTf+F6/kFw0QQY=;
        b=JYU+eUS0HNMsuwm4MHU97UrmS+Np1lfzIapvUUFv78HJW4YCaJ/99uryk67vj3IW9+
         Ayx9RmUlCG9ezRqGmd9WhEdeh9K1n6ozCgqRW3IsU7QTFB9in7BKPH3mDhAzq8g6h4Ik
         6Xaud1jegcmbr9wDirrfrqMxia4a4Gu+P6Jf536g7JiDR/C2tU6vPLsCJcyglIgPmwiK
         VoMS2ORmxcgPzkWw/n9KOVFQeiGuPi6FPhBgPsEOwTrvdeW+2ts5hs2NNHSx6rDOqCDO
         CV5txgiJE/oxF/se8ICv8VEPz/DgUHkoM7VkNAihQp7zmGt4iMmxLyMVfe3fjb2S6Uwu
         asHg==
X-Forwarded-Encrypted: i=1; AJvYcCV6IXpGvz8YqMSFPD0DbCuPnSK7++upE8mbb2GGTK80kojiODpyzJBSpaPRpat2Be8UHSmYcJZBDmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8LNaC9nyCvM5g9yUWw9xSDDdf2KmAPW5DCxMnwD768bOjmaz9
	yHobxwJ9QJho0BtTFbkwDePjyl/LwFuUskapRcAR/5Ui1pXh4KKALd625tEtChknD8mW9anWV6C
	7smp60ZdD5/IFGhAT6YYZqorKh/1OxbNIpdZInRQqJA==
X-Gm-Gg: ASbGncsf9mvwuuV87j0VP85LsAKh6M1C7T9g+UgRxdEkS7C2w9jJWwdTbv8SPAexduF
	2dUqQpotmz9LLYDOl64oI6k/HK/CD1zg0zSw89JKt0rhxE6+M1qRGonaHJETyjP1BcTip9HCTM4
	MU8Y26ivKLgGeITQsVNKJAPrHpEOcX/W4TNkAgXLWU9FoaB/Z7/56gRtGFwadAM7/RL/QS7ntv
X-Google-Smtp-Source: AGHT+IGMo5nFepHm6Jb8myrJnf1+8r8NeSUFkOpNLmlYqlQxjgnpXV7nPyOaCRaS1k1ZDZMWIDYqubJ68xfi3XL0kUk=
X-Received: by 2002:a2e:a585:0:b0:32a:85ad:2148 with SMTP id
 38308e7fff4ca-32adfc55558mr48698001fa.8.1749564356227; Tue, 10 Jun 2025
 07:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610-gpiochip-set-rv-net-v1-0-35668dd1c76f@linaro.org>
 <20250610-gpiochip-set-rv-net-v1-3-35668dd1c76f@linaro.org> <b2f87cff-3a81-482b-bfdd-389950b7ec8e@wanadoo.fr>
In-Reply-To: <b2f87cff-3a81-482b-bfdd-389950b7ec8e@wanadoo.fr>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Jun 2025 16:05:45 +0200
X-Gm-Features: AX0GCFvZApBk6UP-dxTG2kWDbOfc7qUQfTVpw2yDagExp_rgnAnOYdtyDfv1kN4
Message-ID: <CAMRc=MfCwz3BV15aATr_5er7wU=AmKV=Z=sHJyrjEvLwx2cMjQ@mail.gmail.com>
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

On Tue, Jun 10, 2025 at 3:55=E2=80=AFPM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> On 10/06/2025 at 21:37, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > struct gpio_chip now has callbacks for setting line values that return
> > an integer, allowing to indicate failures. Convert the driver to using
> > them.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> This does not match the address with which you sent the patch: brgl@bgdev=
.pl
>
> > ---
> >  drivers/net/can/spi/mcp251x.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251=
x.c
> > index ec5c64006a16f703bc816983765584c5f3ac76e8..7545497d14b46c6388f3976=
c2bf7b9a99e959c1e 100644
> > --- a/drivers/net/can/spi/mcp251x.c
> > +++ b/drivers/net/can/spi/mcp251x.c
> > @@ -530,8 +530,8 @@ static int mcp251x_gpio_get_multiple(struct gpio_ch=
ip *chip,
> >       return 0;
> >  }
> >
> > -static void mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offs=
et,
> > -                          int value)
> > +static int mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offse=
t,
> > +                         int value)
> >  {
> >       struct mcp251x_priv *priv =3D gpiochip_get_data(chip);
> >       u8 mask, val;
> > @@ -545,9 +545,11 @@ static void mcp251x_gpio_set(struct gpio_chip *chi=
p, unsigned int offset,
> >
> >       priv->reg_bfpctrl &=3D ~mask;
> >       priv->reg_bfpctrl |=3D val;
> > +
> > +     return 0;
>
> mcp251x_gpio_set() calls mcp251x_write_bits() which calls mcp251x_spi_wri=
te()
> which can fail.
>
> For this change to really make sense, the return value of mcp251x_spi_wri=
te()
> should be propagated all the way around.
>

I don't know this code so I followed the example of the rest of the
codebase where the result of this function is never checked - even in
functions that do return values. I didn't know the reason for this and
so didn't want to break anything as I have no means of testing it.

Can you confirm that you really want the result to be checked here?

Bart

