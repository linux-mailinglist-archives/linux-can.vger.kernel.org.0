Return-Path: <linux-can+bounces-2641-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B08BA10642
	for <lists+linux-can@lfdr.de>; Tue, 14 Jan 2025 13:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0E13A69F8
	for <lists+linux-can@lfdr.de>; Tue, 14 Jan 2025 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F50236EBF;
	Tue, 14 Jan 2025 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="f68S+rd2"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5256236EB4
	for <linux-can@vger.kernel.org>; Tue, 14 Jan 2025 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856742; cv=none; b=OVPDiw0LvXifE1Q6xK5hbYXya/nHt8pLqbLM/0rKsWCL7IL3U7IOeCDYKpm81rRrRwK/Q788wOiJe22S6FM+zLj46ykksyY+vMN3nfTVCW8DnCSSCZiKK1gBGj6Ct9EckCJc8XC83kN/f6vNWsAub2XnznnJ14R+gHL1mokKYT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856742; c=relaxed/simple;
	bh=K6oz2DS94f8jy21SzXh52ZGsk7kmXvUL4fauuKsYHSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8m/AbsVH/PU9WkYVjC02NjZi6MqNuh1fx/NxUr+zRtgsXxspSRaAHM/Xa5vuYvcF8Qm1u0qRytiZAP+/cqh4iVO8ueUmNSnjpJgvt5RIWSfZXQ4fC9hoqEGmgsJWGJJfkbLArvpeYEBbkoL4W47CwqKKAKoYYeOlgOJGdxKpog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=f68S+rd2; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30229d5b229so45750551fa.0
        for <linux-can@vger.kernel.org>; Tue, 14 Jan 2025 04:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1736856739; x=1737461539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6oz2DS94f8jy21SzXh52ZGsk7kmXvUL4fauuKsYHSA=;
        b=f68S+rd2H2M+mTqpHL+RyKBn+6j9nrOVdFgEMefWySkKUAzP9y9mjuA6H0Ro66sBjM
         FCXYXkG4Lcg5tb8jEqGt4CbD58xensbZNXE5Pbmq2LtOZIbez4+69aj4vauoxAXkTgTy
         z6B1BSnHVTcPJ0q4kbHbJBN2xST9NIbHGqmkpCC8t6cBjS2olv3XycARQFl/Uo5WlRvV
         FOnoRwUGqxCx91jKhvi0O0oPFHQpTZZWyz5B0CLpORzWhxOfMr1B283BdubODqySHg2+
         tyzPDiJH777Ux4/Ar26YyhGNMjmIVyK5aJX69sAKH+0KRzFgg9irk2ishhA11kwkgKIR
         GidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736856739; x=1737461539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6oz2DS94f8jy21SzXh52ZGsk7kmXvUL4fauuKsYHSA=;
        b=Ep3cBGC9viXCDyKF7vyH3nGSLKdUI5FinZFfzv6JM5Fl9PBRJSRcjFAEU/cQzGIK56
         EjOnJ9c/Q8BqHOYuLLYPKk12doG8vW3DYCQ0pegGm9zT5HNamn7D6ArFRA0uSPaTK/1O
         8maCeJZm4z+7iTHjleL757C4cl6UMzArAxcf2P3rj3gYJ1QZXAXjYpiLXJlgKRg4SVPD
         3R5AOdPEYyg2NvqFKkINq1kJvlyCOUYuu18G9Sc/Vk87F/Ig5k2W7E1RsQSPd1TeoTrv
         sIFCmXLiwwxCRlh/RLpulWrgcCLv/nTftHS66LN3ig0LdihNhBr2nvrfe5dcsa7tWw0X
         Ln9A==
X-Forwarded-Encrypted: i=1; AJvYcCWqkknlIpudmABZH7mM2KjpCqVLbwIz48jViVV+E15U2JTqiChou40qv9XDrNEOcWeLwgUYSMra14c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Ui1tru3rU1Ki9ZwpyyJX8/C4c/Oy2HnPEk2fCvxyV0tmfKMu
	ADIynfpRClnNW31okCzlI/QaI/Tat4gN71vJh0AHbDXBfhy+uvyalmMUSF19I3Me2c/N1ClEegI
	LPBpZf/yZK/OSktxyJFylcdZTyacvciz31CIeMw==
X-Gm-Gg: ASbGnct4cIrxbZHQALit4Ci/GI/ew+jl8igW5jX/i/KYviQysL7cO7Z1/Cf0Reay7l8
	BmnTd0YddGP1++p8VVvM//sRl33qCOuyFMifSh+08Av898pkMfmq8x1pIHo/yucha3PhBJw==
X-Google-Smtp-Source: AGHT+IENAzQOWIqeBcjNLCeAWZHXeOZ644Mso77ytYMGJJwc3A78vETSt+TEx++AZVkXjYF397/HELxPeWd4tKYdKto=
X-Received: by 2002:a2e:a587:0:b0:300:3a15:8f2a with SMTP id
 38308e7fff4ca-305f459aaddmr69824011fa.2.1736856738634; Tue, 14 Jan 2025
 04:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114033010.2445925-1-a0282524688@gmail.com> <20250114033010.2445925-3-a0282524688@gmail.com>
In-Reply-To: <20250114033010.2445925-3-a0282524688@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 14 Jan 2025 13:12:07 +0100
X-Gm-Features: AbW1kvZqlT9ZQof5_cPsRoDpTSEUzbcfgE_gPvPzrdmIRQZ45w8iL14wP2FIYK8
Message-ID: <CAMRc=MeEye9i2Z=Y8bHt2ruCS6JJRxmGiLvAUt6E7BJ2K4wosg@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] gpio: Add Nuvoton NCT6694 GPIO support
To: Ming Yu <a0282524688@gmail.com>
Cc: tmyu0@nuvoton.com, lee@kernel.org, linus.walleij@linaro.org, 
	andi.shyti@kernel.org, mkl@pengutronix.de, mailhol.vincent@wanadoo.fr, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, wim@linux-watchdog.org, 
	linux@roeck-us.net, jdelvare@suse.com, alexandre.belloni@bootlin.com, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:30=E2=80=AFAM Ming Yu <a0282524688@gmail.com> wro=
te:
>
> This driver supports GPIO and IRQ functionality for NCT6694 MFD
> device based on USB interface.
>
> Signed-off-by: Ming Yu <a0282524688@gmail.com>
> ---

Please pick up review tags when resending.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

