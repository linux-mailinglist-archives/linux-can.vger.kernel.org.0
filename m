Return-Path: <linux-can+bounces-5091-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF73BB0A78
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 16:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A14167F83
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 14:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850942FCBE3;
	Wed,  1 Oct 2025 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QKukphD1"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B332E92CF
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327930; cv=none; b=oqYyQ/9/22BSPZYEKoTWJrOqJG2hBolBhgixLp3NghgrQGhlZWN0eVztnglsbajm8Y1nxI2ViTBMygKbi19UwXMd56n2VV7IBSV8ejnVbXEkI++LopmJ0FDLFwi2u664WSEDoFOuswvYCQxEAg5MG0ezquMt14chfYDpbuSA8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327930; c=relaxed/simple;
	bh=wFyFhTbS6MYQfUcIRKicbUEZvplEsfeplnap1waRaQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7MUkCvdIo9qqZsXlHluSTVCEwRyEoTBfAyCK1e+Yriz9GiGl72tISI42CYvdKtEjsCwtSXJ9740iB8Q+8Fh2r1VT5rXc9032b4chmXNuHD0HL0fEMaoOK5+rMLy0epnbbi4Cclo9hcX1vo80XDH0OjWFFgy4yAxtgWdOIdt2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QKukphD1; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-373a56498b9so12756081fa.1
        for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759327927; x=1759932727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIO3uPK5ZuAhIy7LIVCZMJNgvs3A+QGnfF2bur8/4Gc=;
        b=QKukphD1C0MmR65Sf1btFq2nxvCf5myywiLKOGkgeF5yEM0HQkJTKryNtVZ7guQlAm
         qG67HzpXXjKX5bMAYCVySzkKPjfUqbDlLMrzrcosQkkAbHDeX91owOcEO2cfEFPdb7NI
         YHANQMA10jJMt976OuISBzrJPwIJe4DKAU8XRsbarjUbyyYBxN1aQjp4/UJe4BhmIAZb
         W377KcePmoPfx4KMjflxc0a+aCOln4YsYjReOjjm13dlZbAAK4MHLe+HeSAwkZSAwaEr
         +5oAp23oJV8GW7wPqdNLlRij13YxHRgQDHoDdgFors1FQ2SyAApucZeX568M8WPZXCEx
         e2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327927; x=1759932727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIO3uPK5ZuAhIy7LIVCZMJNgvs3A+QGnfF2bur8/4Gc=;
        b=YST30/MGEQcheiaTDDOU8kJqK0WB+ZW1x9AhAnaUwhZsppUUNO4Og1e8a9ju+3Qrdo
         5jrbgV9ckUwRTsn3dycWXLtK5+wfSJJKy/GFWXOwm+X9knkKkdGcic7Sl2/0l+VXYqIE
         yWHHKTJXcmBFK5hBBc2dZZOwGVUMctWTZWjY2A/e+Gt2z1V51G9nAMAKbXa7JV3vIUQG
         C6WIz7g19EktdRSSeXI6tIIK28KY/Y5XNAHsz2qMs9YJya8jbr9pxYj7e6URC/f5/8Mk
         21+jG/e8y1FuSgaq2epUwIAxKJLuG17AqumjBN45M1ke2HfH/mqqoU91rMKTwIc/BxFd
         6ekA==
X-Forwarded-Encrypted: i=1; AJvYcCW6r9Nj2Yj9kCPy1tpff/eUvMmB4Rj7vFAkfijJCshnrap4okR+222JWA99cINyTQgIGeTuVSvr5Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsnTH0+UaZIAnEwc3tWM0tYEWO8tmMQp09YMLTllRqmOkiFJvP
	jgBsUUzcT//9gf7nXDDxJnjGZcAHhPHpvSVqzqBGWr6ju5CLy+n+osHi5o4mWHxwSkUoP7zFUfq
	O/d42EfKT+lTYJqGXnhI13IaNnMWyRx5xxiJqwQZVkg==
X-Gm-Gg: ASbGncu3hNluecWgHfly1rNJM0qoC7yuficDvnRCFxlszFcFqMDaSVfEwPaP3dUhODD
	kcPGE8nbKYEsfOQlNokYYPAf3rmLLiTtvNWWQZF7MMnyD5n/BUTYtdqfanbvtdaGAtjxWi8hmIM
	1X9zNAS8x/Uqau3diy2eZPfi3I2vIAZDcEPnMEMJtPa57YHd88vXkHU3121fdeSOASttSU2ibnr
	aex5kjmaxaOOnb2vRCqninGbNoALdpgSUGq/MX40F0O8G/vULSwnkvV0GvDL2E=
X-Google-Smtp-Source: AGHT+IGYKyPwOjoJA/hN/vRW2SG6PgxLO9/q7FFW4TMg9Moy1/qo7wnwhOI+IYoqfFAAWCFgOdsUybjzG2hZKPloTzo=
X-Received: by 2002:a05:651c:b2a:b0:36b:2fab:fa6f with SMTP id
 38308e7fff4ca-372fa205bc5mr26251721fa.3.1759327926662; Wed, 01 Oct 2025
 07:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
 <20251001091006.4003841-6-viken.dadhaniya@oss.qualcomm.com>
 <CAMRc=MfMO-+SSrTY-XQLtsDnxpj_E3TdTJ43ZxCUi-iDrvnc2w@mail.gmail.com> <20251001-fascinating-orange-skunk-7545f3-mkl@pengutronix.de>
In-Reply-To: <20251001-fascinating-orange-skunk-7545f3-mkl@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 1 Oct 2025 16:11:55 +0200
X-Gm-Features: AS18NWBg8ZyVBRpzM7I__xJ4toRDqBMebQLTblgXUJ2wZSl8Fd91gvWOuz_1g1A
Message-ID: <CAMRc=MfhyX+5hTz2BqSuBaZbbtayJWzR75EQeniPv6KCOSaWUA@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] can: mcp251xfd: add gpio functionality
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, mani@kernel.org, 
	thomas.kopp@microchip.com, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com, 
	anup.kulkarni@oss.qualcomm.com, 
	Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 3:59=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.d=
e> wrote:
>
> On 01.10.2025 15:52:56, Bartosz Golaszewski wrote:
> > On Wed, Oct 1, 2025 at 11:10=E2=80=AFAM Viken Dadhaniya
> > <viken.dadhaniya@oss.qualcomm.com> wrote:
> > > +
> > > +       if (!device_property_present(&priv->spi->dev, "gpio-controlle=
r"))
> > > +               return 0;
> > > +
> >
> > Hi! I didn't notice this before you're returning 0 here, meaning the
> > device will be attached to the driver even though it doesn't do
> > anything. It would make more sense to return -ENODEV.
>
> I consider the GPIO functionality of the mcp251xfd CAN controllers
> optional. So if the DT doesn't contain gpio-controller, continue without
> GPIO functionality.
>

Ah, sorry, I thought this was the driver's probe() callback. It's
actually just a function. This could probably be registered as an
auxiliary device for less build-time dependencies but whatever.
Nevermind my last comment.

Bart

