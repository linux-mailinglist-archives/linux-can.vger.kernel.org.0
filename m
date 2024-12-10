Return-Path: <linux-can+bounces-2376-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B92C9EB2AE
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 15:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C82516DA82
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 14:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53511A9B52;
	Tue, 10 Dec 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afiTdnAG"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077781AAA0A
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839460; cv=none; b=qAQoj7iNgNLSkzWZ1MNmufpRQjwzVOF3trtvYoBJ5OrYDH/SoZ3fzlK0+pq8X+ounWPeiSN/1hB8oC0hEC9hIoTG1HmZqwnzuCWrSAW+/JWD7oVW5QDP0cRjrADbPP+HXAUU84vNj75EiKNeNYNHX8S8TvR91+n7O0IyPa2gl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839460; c=relaxed/simple;
	bh=eRzc9Abo0FCh0voXzJtptYvF9W+pYmONZ5tBMF30/uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INKTHZfbXb3vl5DJKDLekruQ9Mgfdb3ycY8EGL9fNGVkHkyXoqNvp9LjowEznHFQzgYHZNLUZ0hWtUf7R9S/LB5dCzy2svwWLy7PuaJcwVRuUxsN4+97iyT9cCSIfC/28LYedxGSc4OlXa4/HeWrn5Tijn3+gAUYtsSn4dMjKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afiTdnAG; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e3778bffdso4097160e87.0
        for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 06:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733839457; x=1734444257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttxCjP+mXsaWFXR+88haBIlfDepUFxf35Uljw3cq4tI=;
        b=afiTdnAGgF2zM7M06cZw6JaNnsR/y8aVzh05Vp1bsLSx9N8n0KLgDfhKNMKJWJjIHa
         GrIiZkvJsgWR1QG56SJfvneAdndKyfJJmZphQP+ReTPt0PlLCTTrwBXnxY8nIIp8Ky7J
         jY5f0s0B4UWM3hjk2lrJfBCsXUrv15BQgmNsJTBmbx/4lt3p/OMJedqPF1JUj/aYqCI4
         2yhRve5XRiav7+QWLjn+pA/2KQvWiXdFt1oqLxpaB1ZJpsDNB6mj0uLTJ00oDOjGJWHc
         uKfOqwwz/AlScEa8T/PvyKU29AvP4wGesmZKs0NEpgZzHnbggZNAzj7SLCnTecpF4Vsq
         Qdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733839457; x=1734444257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttxCjP+mXsaWFXR+88haBIlfDepUFxf35Uljw3cq4tI=;
        b=hIEX/WjIJqX5Q1aRbyYOyZPM/m/rCBYGLOFSJRt9PgBBxAPl6ef6lPCaE17/9aCTgd
         p/OFXYm3lIy4PPBVoxIHt+covE8V+v9ycOIikx9vDZ+DEkH2deLzmC2QIB7IXl0DK0Yo
         pqZ/x0lIUVCZ9mo1XVgQXaisLi867filRk3vZARUzSWWXKtyzJyq/8R7BsdkM+tVg9Wq
         an8Jfg7gWBM1ycv4dKRpQnLB0gxQA2s80pfljslux/SPQM+lFicswVBQDU83PErTN0yb
         eGPzTQnJ8AWrPTgBrJ67czepIOXHNza+0hnKLMhKW319tQsG/YYZdQz3voPvGBMHPdvI
         bV0g==
X-Forwarded-Encrypted: i=1; AJvYcCW2LF9dh6ug3ZvsKGRAJaJd8DM01WoPRAeXNdOL5xYRGIDcETDHValGbVND1H4ROT414xuKAi81Q/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo6VzbsRqFfT1koVshBqVOSxSV7G8nWomkCocpfV0M2NzGRbhT
	UHY2XhaiyKiAUi4Qwb2t8xjRI1DimIKC/2Gc3l+35cLy9OT64t5/UxxXLWK2MJ1vu5R/hwsFbQ+
	xqVvIrL59TbNfHsOZa4pR+9Q7YuU=
X-Gm-Gg: ASbGncsYpzO6N1tdh+F1hkW/4za1+AW5Of4aYPY3BvQuUtCyHIatlMheQHkUYiPyQD8
	O7D2zycBIiaVWwigshcVqeNahlc0FDcjVb8U=
X-Google-Smtp-Source: AGHT+IHiyNQXvUS9H7QTHQgkRaCBLigGQsO8oJ4YG/XEOaSmPT4tph4oZtXDVnwDshMBLkH+NjsQnf/+OsBIWVlO1bg=
X-Received: by 2002:a05:6512:3d04:b0:540:1faa:5945 with SMTP id
 2adb3069b0e04-540240e69aamr1475054e87.33.1733839456755; Tue, 10 Dec 2024
 06:04:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-mcp251xfd-acpi-v2-1-d6694f590d00@pengutronix.de>
 <20241210-laughing-koel-of-nirvana-349f7e-mkl@pengutronix.de>
 <CAOv6HEC=FV1gGt17SQxWo9jTMkxhLHBmkPKAWDfg=EYGHpCfwg@mail.gmail.com> <20241210-watchful-kingfisher-of-focus-8bbf9f-mkl@pengutronix.de>
In-Reply-To: <20241210-watchful-kingfisher-of-focus-8bbf9f-mkl@pengutronix.de>
From: Stefano Offredi <stefano.offredi@gmail.com>
Date: Tue, 10 Dec 2024 15:04:05 +0100
Message-ID: <CAOv6HED6wuhUQcE36izZFWcjdsw0G=RUCLdnOJ1FKEj-e9dm_Q@mail.gmail.com>
Subject: Re: [PATCH can-next v2] can: mcp251xfd: ACPI support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	kernel@pengutronix.de, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il giorno mar 10 dic 2024 alle ore 13:09 Marc Kleine-Budde
<mkl@pengutronix.de> ha scritto:
>
> On 10.12.2024 12:52:57, Stefano Offredi wrote:
> > > > +#ifdef CONFIG_ACPI
> > > > +static const struct acpi_device_id  mcp251xfd_acpi_id_table[] =3D =
{
> > > > +     { "MCP2517", .driver_data =3D (kernel_ulong_t)&mcp251xfd_devt=
ype_data_mcp2517fd, },
> > > > +     { "MCP2518", .driver_data =3D (kernel_ulong_t)&mcp251xfd_devt=
ype_data_mcp2518fd, },
> > > > +     { "MCP251X", .driver_data =3D (kernel_ulong_t)&mcp251xfd_devt=
ype_data_mcp251xfd, },
> > > > +     {}
> > > > +};
> > > > +MODULE_DEVICE_TABLE(acpi, mcp251xfd_acpi_id_table);
> > > > +
> > > > +static const struct acpi_gpio_params rx_int_gpios =3D { 1, 0, fals=
e };
> > > > +
> > > > +static const struct acpi_gpio_mapping acpi_mcp251xfd_gpios[] =3D {
> > > > +     { "rx-int-gpios", &rx_int_gpios, 1 },
> > >
> > > The devm_gpiod_get_optional() uses "microchip,rx-int". How does it fi=
nd
>                                         ^^^^^^^^^^
>
> > > the "rx-int-gpios" here? Does the ACPI matching code remove the
> > > "microchip," prefix?
> > >
> > It should use the devm_acpi_dev_add_driver_gpios() function to get
> > rx-int-gpios using names listed in acpi_mcp251xfd_gpios[] (rx-int-gpios=
).
> > Then watching at other drivers using gpios loading, after calling
> > devm_acpi_dev_add_driver_gpios(),
> > they call devm_gpiod_get_optional(), with the same name but without "-g=
pios".
> > So in our case it is exactly "rx-int".
>
> No! Please re-read the code, devm_gpiod_get_optional() uses
> "microchip,rx-int", not "rx-int":
>
> |       rx_int =3D devm_gpiod_get_optional(&spi->dev, "microchip,rx-int",
>                                                      ^^^^^^^^^^
> |                                        GPIOD_IN);
>
very sorry Marc, in my test environment I had modified this line but I
have not reported it in the patch.
Be patient, it's the first time I post a patch to the kernel. Any hint
is very appreciated.

To keep compatibility with DTS loading I propose the following:

#ifdef CONFIG_ACPI
        ret =3D devm_acpi_dev_add_driver_gpios(&spi->dev, acpi_mcp251xfd_gp=
ios);
        if (ret) {
                dev_dbg(&spi->dev, "failed to add gpios mapping table\n");
                return ret;
        }
        rx_int =3D devm_gpiod_get_optional(&spi->dev, "rx-int", GPIOD_IN);
#else
        rx_int =3D devm_gpiod_get_optional(&spi->dev,
"microchip,rx-int", GPIOD_IN);
#endif

Even with those lines of code, If I print  spi->irq before the call
to request_threaded_irq() it keeps different error codes
values (-19, -22, depending on whether I set the gpio controller
values in ACPI table).
Even If I remove in ACPI table all the gpio references listed
here below:

- GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullDefault...
- Package () {"rx-int-gpios", Package () { ^CAN0, 0, 0, 0 } }

the spi->irq keeps error value -2.


>
> > The chain starts from the acpi table here:
> > Package () {"rx-int-gpios", Package () { ^CAN0, 0, 0, 0 } }.
> >
> > For example you can watch at st33zp24/spi.c:237 driver, or st-nci/spi.c=
:235
>
> This is the case for st33zp24/spi.c, but not your code:
>
> | static const struct acpi_gpio_mapping acpi_st33zp24_gpios[] =3D {
> |         { "lpcpd-gpios", &lpcpd_gpios, 1 },
>              ^^^^^^^^^^^
> |         { },
> | };
>
> |         tpm_dev->io_lpcpd =3D devm_gpiod_get_optional(dev, "lpcpd",
>                                                             ^^^^^
> |                                                     GPIOD_OUT_HIGH);
>
> FYI:
> Without a reference to a kernel version this line file+line number is
> not of much value. Can you post a link to https://elixir.bootlin.com
> which includes the kernel version?
>

thanks again, here my kernel developing version:

https://elixir.bootlin.com/linux/v5.15/source

regards,
Stefano

> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

