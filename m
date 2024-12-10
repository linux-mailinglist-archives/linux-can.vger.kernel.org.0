Return-Path: <linux-can+bounces-2381-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4C79EB494
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 16:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B92C16BD24
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D0F1B4147;
	Tue, 10 Dec 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBXRCp6u"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF11BD9C7
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843903; cv=none; b=fafAl1hFnY3qnej+gb26txSw2sDt3Xeva8WUNUECit0PoxJCIVm4Cck6mUBHMlaa/3TUDUIbzXHdcb9XkMQXH0b4t1bshUMd6SZYyTZoBC2QVzQCDJJAx6KWyY86Tc1ZOtieNuLay0T/WIq32Cf1xUN7B7fM0IXdlQ/kctSLq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843903; c=relaxed/simple;
	bh=wByzIo4k4Til2XLAJq8xR1q9GwBj/8BM5QtfCiIj++Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8eET4rozwR/uUpuBYK/t3SuBXZeBJQ+QNDw73bM8FfG5Kbima5e9gGlCvTxVu4dsbas+Cp//xCLqm6KF6OLki/mOBCy3jFz5eLViUFnPxnznuTAt1GdrAbtjhjqRuA9HNJHIfHLEekJ7Yk47q/f4x5q2/TwcMNMh+yj9ts1X5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBXRCp6u; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ff976ab0edso53645481fa.1
        for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 07:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733843899; x=1734448699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkVwHgGDTsHCuzMDJ15oDpSXvNq8fNs/zvYGijjfM7s=;
        b=XBXRCp6uWB1NNkYjWUTG26VWQPjxu0wHSwEkdSgP4d+rEYnkygJ0wafBcYpFwnsjTj
         EFndqT4PoVlOYCGFIBBiwmhKPUpdav6mIEbU6uXJ8qFFRnKMhY4TTtG5MFwPsdhwXduQ
         EaAAZpIJA9WUdjGOJ0q9dhg3JCIDGOlXdy+bojJ140BxQAxpmbrhRhVppxklImXLG6O+
         k6p8tLKQ9qOBM7JtKLrGVmWjMGQRIqUMeJstunlly6C8UbjitFrght0TG2VPSZgz7dhM
         jeYHo/gfIfcwUqAsPxxEMjhJ/7nXgk5JmxUPm5W+lbd9DzABGtlx2tttRACUoTtiBncd
         xuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733843899; x=1734448699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkVwHgGDTsHCuzMDJ15oDpSXvNq8fNs/zvYGijjfM7s=;
        b=TfxeMgB/0JcJ3fNic4GAiBaLofAm5XOjZY1uKvM3jQGqHKs1qP9dFZtlIbn4vrCPLi
         aD+h0c/l156oLCe+ykqfqFQm1ekYfiAjqUZhjecZiTQQrvVqMMXYCIrFO/Oe46X06bYy
         +bveOrbOyc/nBiEhSn+MnL886F6vBkdEzCnl35zHDPqNzyE3dJyFsuE+QTIrUhdx89W1
         U7YUSmmX2m7K1EFQSVPCWH8SaAofgn+RykqF1GWg783XZXRPWX13dnzJdhVOrcTPqS9B
         p7oEFyhaO9jQ5TeapJ79MFF9HqcSsGstcx+H6IXqFBd4DFkMO5GDoQwr7V00UNCXrdt2
         j9Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVSIkrPIrI4zEU243vBvxZ5MYz7sp1Pe+WRd+Lq36IiuS37G4kB1/GCAwf+BJ9BCM+h3Tu0jbLz6BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxChSdWd4oPCJIRoWAiWv+ffoArMiS+R2B9ZzfDWpSBDlk9cs6m
	1vVoJmAcvUx5pqfEPb69RBVYtSwWuz6JwUisLRrF6qYKYiR29nBXcL001yFJbqMR7+TswlimFwt
	CfTbRYgI7MhYQZcgjkMjwYU7FkTk=
X-Gm-Gg: ASbGncsXKxO4ltCu1BcFJJR3DmbxM1tD8E1ddvHTrXwg7tk3MuLusFDJtTUgPzWd9Ql
	Jlcpv+SnIeENyx0FXWezvORbpv7g9Le9ovE0=
X-Google-Smtp-Source: AGHT+IEsOQrYPgmjG5gf5eJcoy90Njj25Int7K02YQRhWno5/1DVtUQaQ3A+S2Y6ZRVoPBJKSlc7bpGrgPTlOH5bN10=
X-Received: by 2002:a2e:be0f:0:b0:302:3d74:a1af with SMTP id
 38308e7fff4ca-3023d74a2admr4572091fa.20.1733843899146; Tue, 10 Dec 2024
 07:18:19 -0800 (PST)
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
 <CAOv6HED6wuhUQcE36izZFWcjdsw0G=RUCLdnOJ1FKEj-e9dm_Q@mail.gmail.com> <20241210-gabby-augmented-mussel-8e3ea3-mkl@pengutronix.de>
In-Reply-To: <20241210-gabby-augmented-mussel-8e3ea3-mkl@pengutronix.de>
From: Stefano Offredi <stefano.offredi@gmail.com>
Date: Tue, 10 Dec 2024 16:18:07 +0100
Message-ID: <CAOv6HECvDWOQMvvLi7ZQRsOMAQ83rUZUQoMM0Siym2nOEFq_fw@mail.gmail.com>
Subject: Re: [PATCH can-next v2] can: mcp251xfd: ACPI support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	kernel@pengutronix.de, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il giorno mar 10 dic 2024 alle ore 15:31 Marc Kleine-Budde
<mkl@pengutronix.de> ha scritto:
>
> On 10.12.2024 15:04:05, Stefano Offredi wrote:
> > > No! Please re-read the code, devm_gpiod_get_optional() uses
> > > "microchip,rx-int", not "rx-int":
> > >
> > > |       rx_int =3D devm_gpiod_get_optional(&spi->dev, "microchip,rx-i=
nt",
> > >                                                      ^^^^^^^^^^
> > > |                                        GPIOD_IN);
> > >
> > very sorry Marc, in my test environment I had modified this line but I
> > have not reported it in the patch.
> > Be patient, it's the first time I post a patch to the kernel. Any hint
> > is very appreciated.
>
> No problem.
>
> > To keep compatibility with DTS loading I propose the following:
> >
> > #ifdef CONFIG_ACPI
> >         ret =3D devm_acpi_dev_add_driver_gpios(&spi->dev, acpi_mcp251xf=
d_gpios);
> >         if (ret) {
> >                 dev_dbg(&spi->dev, "failed to add gpios mapping table\n=
");
> >                 return ret;
> >         }
> >         rx_int =3D devm_gpiod_get_optional(&spi->dev, "rx-int", GPIOD_I=
N);
> > #else
> >         rx_int =3D devm_gpiod_get_optional(&spi->dev,
> > "microchip,rx-int", GPIOD_IN);
> > #endif
>
> Why not use "microchip,rx-int" for ACPI, too?

yes I'll test it.

>
> > Even with those lines of code, If I print  spi->irq before the call
> > to request_threaded_irq() it keeps different error codes
> > values (-19, -22, depending on whether I set the gpio controller
> > values in ACPI table).
>
> Just to clarify: from the Linux point of view "rx-int" is a GPIO, not an
> interrupt. It's connected to the "nINT1/GPIO1" pin of the mcp251xfd and
> this is optional. The IRQ which is available under spi->irq is connected
> to the "nINT" pin of the mcp251xfd.
>
> > Even If I remove in ACPI table all the gpio references listed
> > here below:
> >
> > - GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullDefault...
> > - Package () {"rx-int-gpios", Package () { ^CAN0, 0, 0, 0 } }
> >
> > the spi->irq keeps error value -2.
>
> I suggest to first remove all "rx-int" related stuff from your ACPI
> table and concentrate that "spi->irq" has a proper value.
>
> The relevant code is in acpi_status acpi_register_spi_device():
>
> | https://elixir.bootlin.com/linux/v5.15/source/drivers/spi/spi.c#L2294
>

Ok thanks I will investigate on it.

Just to be sure, will the driver, if rx-int and interrupt logic is not
used, perform
 a polling on the spi bus to check for messages incoming on the can control=
ler?
So I should see in this operating mode continuous spi communication on
the bus, right?

regards
Stefano

> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

