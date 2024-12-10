Return-Path: <linux-can+bounces-2385-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA789EB593
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 17:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1FC2823E7
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 16:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEF119D8BB;
	Tue, 10 Dec 2024 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkMvB4Se"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A0D23DEBB
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846603; cv=none; b=K2esC25pjEuMnNOrisPG3IjrYbU/a/bi0nMUObgw0YVPnmMF+8fUL2ku2UL6GPkSu+rGGAmnVqUhfl8kRMCiCVOeK+K3hz1f3SFpjVBqwjEJoDvBy+52lGNVGZOxbWGHO5J1I7Xh5c1ohe1PVtYY85o5/jc1+nNgbJMG/1GPNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846603; c=relaxed/simple;
	bh=X+CxO8AT1fA17jCi0xPPfHCI2dhBPWA98B1PCBnl/cY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2pHaQz554cvb5oYtbN+MkfGpOAeJPm4zZgrgQ6nevvH294OUZm+BqeOcEE0o1dTyGmYJk4JmadYa37Fd+UEjL8z23eRKTB6nweMPzmTGFNy0gmNobn8JU0TNxdq6ttc+9d/Fmnw1voYLCanrsV1gyJdaVGtk9kOGNqSm6qfJJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkMvB4Se; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so51583461fa.3
        for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 08:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733846600; x=1734451400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJvqB0Zu4Y/Vutvod/GSdiTobDCXgn2mv8igzrnYywQ=;
        b=CkMvB4SeRpn+pTFOJFizh0OLpm+F1zxFxqD4qIxZhNrd9PQ6TDH++v9KhwIUg6GLs0
         2NFItf3zshYXzR0DFU3RX4LV4HWBMHgeNCPcpA37XSXyiA2acCTmKLyvgCAP50/7xZi5
         xZZpSS7gTcHDWYfsOhL9H17U4l1fHB1X1hsqk1CxppIfRU49hdi3svZXwoMAfM1aYkPL
         bp/qLvA7PaxA/eEfS5JddB1aOEhwNwO3HIN4cZKaLIhQH7j+VC8Jn99YrOYIREwmrF67
         hm8T3vFad4yNH9cU7AJHxhQ5QI8iNfVemdaKc7JPXHv0dWoPmYQccLHc12s+RA3A3FT6
         rnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733846600; x=1734451400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJvqB0Zu4Y/Vutvod/GSdiTobDCXgn2mv8igzrnYywQ=;
        b=VyA50djoAeg7SOjyAZGEV5kyJkcxukSgmLTRHViWD4bqH32DFRM1n3VT+jHctc2jsJ
         cXJM9S44D/SxBMVG1RoRQatMo3YaaWd+NXV+I8NIvz5BzDsIZBLk01bh3eG6ubS09VBf
         FYgRP/SSwqcqVQlsH2O718fe5wtwGokwBKPLjgQUKb98HFxaJM9C21I8Xe4T2ZtNhunf
         xID7u/qc4Oq+Kk0YK5+FKTMA+H1hDNeiRr9GnEt9mSq9LjFbu1PPACsSo9doWgyQKHhX
         Rk/90dfspnyFhCAQqIXQDQg04O7z5OKYc6+BuBgVlmbhZK01TofkJGHYjrsEnIbEPQQh
         02vg==
X-Forwarded-Encrypted: i=1; AJvYcCVS65U2DDUGQC19bdLBRh7jNrpvlf69u0WT+de2cME3jX9b4FHwZFE7DTFIgEbUxHojLXVu4lDUGGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6b9A88AgKCNTZVChiAbE+sqhG6dDKG/tedNWOR0iNM5e7p5gu
	hHlDTyAsBEI6J4aIeEuby09aphYVbKZtoyhDAEZgFvTCMhij7lTd26kruIMmRTHb+j0MobzsxEA
	Nhx2SZFmvw/InoAvf81DRAac2EBs=
X-Gm-Gg: ASbGncvQxfuFMug9GTKmMSLeBVUyCzmwo/LjupMlm5unb+xyW+9w4k9VhITiGksfUTh
	3+NiZRgftyfUxHY32tnyntNjCDSActLhZjug=
X-Google-Smtp-Source: AGHT+IEX6+eYTByee8iSP6UYvU4kC7ObbVgYMumvDhYFBvuzqPvpmowgtqPxqo1DjT7I0cCzs80V1lygtUhXYtS/0y8=
X-Received: by 2002:a2e:a80a:0:b0:300:12d1:37e8 with SMTP id
 38308e7fff4ca-3002f8c13edmr76993301fa.12.1733846597793; Tue, 10 Dec 2024
 08:03:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-mcp251xfd-acpi-v2-1-d6694f590d00@pengutronix.de>
 <20241210-laughing-koel-of-nirvana-349f7e-mkl@pengutronix.de>
 <CAOv6HEC=FV1gGt17SQxWo9jTMkxhLHBmkPKAWDfg=EYGHpCfwg@mail.gmail.com>
 <20241210-watchful-kingfisher-of-focus-8bbf9f-mkl@pengutronix.de>
 <CAOv6HED6wuhUQcE36izZFWcjdsw0G=RUCLdnOJ1FKEj-e9dm_Q@mail.gmail.com>
 <20241210-gabby-augmented-mussel-8e3ea3-mkl@pengutronix.de>
 <CAOv6HECvDWOQMvvLi7ZQRsOMAQ83rUZUQoMM0Siym2nOEFq_fw@mail.gmail.com> <20241210-complex-impetuous-panther-fedb99-mkl@pengutronix.de>
In-Reply-To: <20241210-complex-impetuous-panther-fedb99-mkl@pengutronix.de>
From: Stefano Offredi <stefano.offredi@gmail.com>
Date: Tue, 10 Dec 2024 17:03:06 +0100
Message-ID: <CAOv6HEAxp303Y71XjNUaz5cVKriPLUS++0cHrm45248ORg=W1g@mail.gmail.com>
Subject: Re: [PATCH can-next v2] can: mcp251xfd: ACPI support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	kernel@pengutronix.de, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il giorno mar 10 dic 2024 alle ore 16:28 Marc Kleine-Budde
<mkl@pengutronix.de> ha scritto:
>
> On 10.12.2024 16:18:07, Stefano Offredi wrote:
> > > > Even with those lines of code, If I print  spi->irq before the call
> > > > to request_threaded_irq() it keeps different error codes
> > > > values (-19, -22, depending on whether I set the gpio controller
> > > > values in ACPI table).
> > >
> > > Just to clarify: from the Linux point of view "rx-int" is a GPIO, not=
 an
> > > interrupt. It's connected to the "nINT1/GPIO1" pin of the mcp251xfd a=
nd
> > > this is optional. The IRQ which is available under spi->irq is connec=
ted
> > > to the "nINT" pin of the mcp251xfd.
> > >
> > > > Even If I remove in ACPI table all the gpio references listed
> > > > here below:
> > > >
> > > > - GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullDefault...
> > > > - Package () {"rx-int-gpios", Package () { ^CAN0, 0, 0, 0 } }
> > > >
> > > > the spi->irq keeps error value -2.
> > >
> > > I suggest to first remove all "rx-int" related stuff from your ACPI
> > > table and concentrate that "spi->irq" has a proper value.
> > >
> > > The relevant code is in acpi_status acpi_register_spi_device():
> > >
> > > | https://elixir.bootlin.com/linux/v5.15/source/drivers/spi/spi.c#L22=
94
> > >
> >
> > Ok thanks I will investigate on it.
> >
> > Just to be sure, will the driver, if rx-int and interrupt logic is not
>
> "rx-int" is not used as an interrupt source. To keep things simple
> forget about "rx-int" for now.
>
> > used, perform a polling on the spi bus to check for messages incoming
> > on the can controller?
>
> No - polling is not implemented and makes IMHO no sense, as it's quite
> some overhead.
>

Ok, now it's clear, rx-int (INT0) is not necessary, but nINT is necessary.
I will investigate starting from acpi_register_spi_device.
I think that the problem depends on the fact that my gpio controller is not
described in the ACPI table, (is loaded as an external module after the boo=
t),
and the reference from the ACPI mcp descriptor fails.
Thanks again for your support. I'll be back when I have solved it.

regards
Stefano

> > So I should see in this operating mode
> > continuous spi communication on the bus, right?
>
> If there's no traffic on the bus, you should only see very little SPI
> communication. Just a read of the timestamp every 30s or so.
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

