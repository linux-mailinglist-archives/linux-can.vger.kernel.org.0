Return-Path: <linux-can+bounces-2371-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC759EB036
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 12:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2AC167D3E
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C60119E965;
	Tue, 10 Dec 2024 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMy0RC1M"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A619CC3E
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831592; cv=none; b=aTIvpuMj8PUyzJA5ZoJeXuA28Adi0KfCG91VUcXx9CoO/CNSiq5UGuPORKSZWOMgVx6CEpe/1JpUqZ8t5eCyfm68zoQa9fCCkGmlOWPhcO+6MrOumgbAaiGP98SXlgBGX9LR8Bw6QY8Y0oEfP501U38i7iIHusgiyonEtAv7dI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831592; c=relaxed/simple;
	bh=8yJGWFrFnNv2BYpHwA2FSoBbhy3XiE9SVW1UfrEUK2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+GegE4s/ez4fHGlmdyvRixxUv2bE+xQw2Ia4WX5v2g2Aqb8QP6cNl7AF1fTJDfPDYztXge4aqRpU7SGpdypkUPbxjoqOiQfii3kK9cbfEckkh8kd1kJt+zk2TU81Yw3uNFnW+ZDBbdlZ5qWGaIsOLWHp+45ziwNytEHNTPbMPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMy0RC1M; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30229d5b229so14996301fa.0
        for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 03:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733831589; x=1734436389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13n+ba1LkxNLKP0c5HIJHPkgMzZDZLuKVM71+znuCqY=;
        b=fMy0RC1MTCaIjTs5SOwrSC3SfdmDxcu2uuaAH3erg8r0/1ArcAflfDvyERNYrOL8Si
         YhoQkqQRa0WrDJQdF5a8n4WuxGAxZN2jdjtFtIIY72jYjIXZdPIsdv0BckQtvOcFCams
         zjluYgpRNH6/MVZi5sNaH4wKVKlAof9iosJNai5xMkfIaUsNEZiBUU9Rbzs9tzjGRq6H
         V83xXddhv2LKNdWXpkXb/OG/7iH0YHpuo2/7DXQeL25BQ0kZ2/bd+qI3zMRSGEiXDlhq
         rmmwoWTguQXEcG8UJUoFDjIoBkEE7PwVqZLQLwefwkKAEy32AakrHAgtUpiRcFoB8XNW
         OZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733831589; x=1734436389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13n+ba1LkxNLKP0c5HIJHPkgMzZDZLuKVM71+znuCqY=;
        b=Dg95/gY4ln3MDkWuQWDDTWcQyE+FVijg9KSk3Lom6hrF8nnE4LDEswybdfPtIxl27d
         qn2I9t+WEgFU1xmQqHfPbciQN+4tJhhPrug3ySawunDAXDAzSi24BAW4F/z9KWeob6ZM
         8F5KKTmWopZoiTuuZzKHKCYyvIEFh8YmPLGJ7fE0+EIqWSC3vq+ouE4hOo10H/SCR4+w
         dqT74ij+Ptdr8H2BlF7cT5anX93AA72VTZMiLS1LsxtRBoG7HcXcuIzouDNTdK/B1TmT
         umoKD9UUrLTvV8Yi7vA0V3NIVpwcBxRTVs8o065Vk5G4XenA/K4FPymPlaxR1DmM8LkD
         5x7A==
X-Forwarded-Encrypted: i=1; AJvYcCVjgEpF1aWI9g1vPrw5KxKsZLHaR2bxEHOLgWV0WzvVKSLEcb8z2fdfDeQe7DURX+u4dMM6UDkZRrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrfoNDu9lbkQYKn2CzXXrnos5Rw0VNm2bOVdalumklcezavw63
	aSe4w3g1wO+PsiSIbw2J/MUgSSg6Q7boZWjaTiawV9WBgdoMnsqggE6bZQH6DhRr6D6s1LocziW
	8kmDpn4DHPI4xW0oCIbCHa5t3v3w=
X-Gm-Gg: ASbGncs2Yn1O8PWMnt+yyg7iagvOiJ/vuNeyKuggcl5OKLJs18cw+b+WtZkUQ7z/xsb
	Pa8tFHI+AGe1T5VGuBLgpFh/bN/o/jPfLBvs=
X-Google-Smtp-Source: AGHT+IERgnhE9l7Pah+UbmA4pNJ+Sju6zGfQbXAYpIWSEJaUoH/hlLZ+vlcqZjf++m0CPbby1gkZfITga8rIjLYsJ74=
X-Received: by 2002:a05:651c:4cb:b0:300:1d91:c2bf with SMTP id
 38308e7fff4ca-3022ffca8bbmr11785361fa.41.1733831588533; Tue, 10 Dec 2024
 03:53:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-mcp251xfd-acpi-v2-1-d6694f590d00@pengutronix.de> <20241210-laughing-koel-of-nirvana-349f7e-mkl@pengutronix.de>
In-Reply-To: <20241210-laughing-koel-of-nirvana-349f7e-mkl@pengutronix.de>
From: Stefano Offredi <stefano.offredi@gmail.com>
Date: Tue, 10 Dec 2024 12:52:57 +0100
Message-ID: <CAOv6HEC=FV1gGt17SQxWo9jTMkxhLHBmkPKAWDfg=EYGHpCfwg@mail.gmail.com>
Subject: Re: [PATCH can-next v2] can: mcp251xfd: ACPI support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	kernel@pengutronix.de, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il giorno mar 10 dic 2024 alle ore 11:45 Marc Kleine-Budde
<mkl@pengutronix.de> ha scritto:
>
> On 10.12.2024 08:57:14, Marc Kleine-Budde wrote:
> > From: Stefano Offredi <stefano.offredi@gmail.com>
> >
> > This patch makes the Microchip MCP251xFD driver compatible with
> > hardware parameters loading from ACPI tables.
> >
> > It's a patch for the 5.15 kernel version for which I could do tests on.
> >
> > The ACPI driver hardware description table I used is the following:
> >
> > DefinitionBlock ("can.aml", "SSDT", 1, "mcp2518fd", "Intel", 0x00000003=
)
> > {
> >     External (\_SB.PC00.SPI0, DeviceObj)
> >     Scope (\_SB.PC00.SPI0)
> >     {
> >         Device (CAN0) {
> >             Name (_HID, "MCP2518")
> >             Name (_CID, "mcp2518fd")
> >             Name (_DDN, "CAN SPI device connected to CS0")
> >             Name (_CRS, ResourceTemplate () {
> >                 SpiSerialBus (
> >                     0,                             // Chip select
> >                     PolarityLow,             // Chip select is active l=
ow
> >                     FourWireMode,        // Full duplex
> >                     8,                              // Bits per word is=
 8 (byte)
> >                     ControllerInitiated,    // Don't care
> >                     20000000,                // 20 MHz
> >                     ClockPolarityLow,     // SPI mode 0
> >                     ClockPhaseFirst,      // SPI mode 0
> >                     "\\_SB.PC00.SPI0",  // SPI host controller
> >                     0                               // Must be 0
> >                 )
> >                 GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullDefault=
, 0,
> >                     "\\_SB.GPI0", 0, ResourceConsumer, ,
> >                     )
> >                     {
> >                        2
> >                     }
> >             })
> >             Name (_DSD, Package ()
> >             {
> >                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >                 Package ()
> >                 {
> >                     Package () {"rxint-gpios", Package () { ^CAN0, 0, 0=
, 0 } },
> >                     Package (2) {"clock-frequency",  40000000 }
> >                 }
> >             })
> >          }
> >      }
> >  }
> >
> > Signed-off-by: Stefano Offredi <stefano.offredi@gmail.com>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> > This is a continuation of Stefano Offredi's work. For easier review
> > I've rebased the patch to current net-next/main and fixed the
> > indention.
> > ---
> > Changes in v2:
> > - rebased to net-next/main
> > - fix indention
> > ---
> >  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 34 ++++++++++++++++++=
++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/n=
et/can/spi/mcp251xfd/mcp251xfd-core.c
> > index 3bc56517fe7a99d96dd43750a8ddd21961138e41..ee066dc2fdaa97ebadb5dc9=
75957426c563adc9e 100644
> > --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > @@ -12,6 +12,9 @@
> >  // Copyright (c) 2019 Martin Sperl <kernel@martin.sperl.org>
> >  //
> >
> > +#ifdef CONFIG_ACPI
> > +#include <linux/acpi.h>
> > +#endif
> >  #include <linux/unaligned.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/clk.h>
> > @@ -2002,6 +2005,23 @@ static const struct spi_device_id mcp251xfd_id_t=
able[] =3D {
> >  };
> >  MODULE_DEVICE_TABLE(spi, mcp251xfd_id_table);
> >
> > +#ifdef CONFIG_ACPI
> > +static const struct acpi_device_id  mcp251xfd_acpi_id_table[] =3D {
> > +     { "MCP2517", .driver_data =3D (kernel_ulong_t)&mcp251xfd_devtype_=
data_mcp2517fd, },
> > +     { "MCP2518", .driver_data =3D (kernel_ulong_t)&mcp251xfd_devtype_=
data_mcp2518fd, },
> > +     { "MCP251X", .driver_data =3D (kernel_ulong_t)&mcp251xfd_devtype_=
data_mcp251xfd, },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(acpi, mcp251xfd_acpi_id_table);
> > +
> > +static const struct acpi_gpio_params rx_int_gpios =3D { 1, 0, false };
> > +
> > +static const struct acpi_gpio_mapping acpi_mcp251xfd_gpios[] =3D {
> > +     { "rx-int-gpios", &rx_int_gpios, 1 },
>
> The devm_gpiod_get_optional() uses "microchip,rx-int". How does it find
> the "rx-int-gpios" here? Does the ACPI matching code remove the
> "microchip," prefix?
>
It should use the devm_acpi_dev_add_driver_gpios() function to get
rx-int-gpios using names listed in acpi_mcp251xfd_gpios[] (rx-int-gpios).
Then watching at other drivers using gpios loading, after calling
devm_acpi_dev_add_driver_gpios(),
they call devm_gpiod_get_optional(), with the same name but without "-gpios=
".
So in our case it is exactly "rx-int".

The chain starts from the acpi table here:
Package () {"rx-int-gpios", Package () { ^CAN0, 0, 0, 0 } }.

For example you can watch at st33zp24/spi.c:237 driver, or st-nci/spi.c:235

Stefano

> Marc
>
> > +     {},
> > +};
> > +#endif
> > +
> >  static int mcp251xfd_probe(struct spi_device *spi)
> >  {
> >       struct net_device *ndev;
> > @@ -2012,11 +2032,20 @@ static int mcp251xfd_probe(struct spi_device *s=
pi)
> >       bool pll_enable =3D false;
> >       u32 freq =3D 0;
> >       int err;
> > +     int ret;
> >
> >       if (!spi->irq)
> >               return dev_err_probe(&spi->dev, -ENXIO,
> >                                    "No IRQ specified (maybe node \"inte=
rrupts-extended\" in DT missing)!\n");
> >
> > +#ifdef CONFIG_ACPI
> > +     ret =3D devm_acpi_dev_add_driver_gpios(&spi->dev, acpi_mcp251xfd_=
gpios);
> > +     if (ret) {
> > +             dev_dbg(&spi->dev, "failed to add gpios mapping table\n")=
;
> > +             return ret;
> > +     }
> > +#endif
> > +
> >       rx_int =3D devm_gpiod_get_optional(&spi->dev, "microchip,rx-int",
> >                                        GPIOD_IN);
> >       if (IS_ERR(rx_int))
> > @@ -2049,6 +2078,8 @@ static int mcp251xfd_probe(struct spi_device *spi=
)
> >               if (err)
> >                       return dev_err_probe(&spi->dev, err,
> >                                            "Failed to get clock-frequen=
cy!\n");
> > +
> > +             dev_dbg(&spi->dev, "using clock-frequency %d Hz\n", freq)=
;
> >       }
> >
> >       /* Sanity check */
> > @@ -2204,6 +2235,9 @@ static struct spi_driver mcp251xfd_driver =3D {
> >               .name =3D DEVICE_NAME,
> >               .pm =3D &mcp251xfd_pm_ops,
> >               .of_match_table =3D mcp251xfd_of_match,
> > +#ifdef CONFIG_ACPI
> > +             .acpi_match_table =3D ACPI_PTR(mcp251xfd_acpi_id_table),
> > +#endif
> >       },
> >       .probe =3D mcp251xfd_probe,
> >       .remove =3D mcp251xfd_remove,
> >
> > ---
> > base-commit: a0e1fc921cb0651cd11469bf5378ec342bf7094d
> > change-id: 20241209-mcp251xfd-acpi-79b57084512f
> >
> > Best regards,
> > --
> > Marc Kleine-Budde <mkl@pengutronix.de>
> >
> >
> >
> >
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

