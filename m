Return-Path: <linux-can+bounces-2358-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9216B9EAA4C
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 09:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2FF18890CE
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 08:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A0422A1D5;
	Tue, 10 Dec 2024 08:09:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A76198E77
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818198; cv=none; b=bSghEKijLSe0MQgbrnNt6gMZF1seu6rfCAts0FQqKLbUmI/lcwfZGm1R9/ahhOVlNJib9GWIg40i1+5ppK4+I11nPPLVdrZx7K+fe/aF/3CugRJYktJtpu7JnlOZVNzqTmYWY4JuRmpPmhW+NVXlBarGAVSipnyUY9hWJfqfT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818198; c=relaxed/simple;
	bh=xZzX+R9FZe06HSW8CWC1y7tFQTGZCIL3JYWviXjmSYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HneT5p9J+8IheMOD0kN9/eMhePm6dIU3BHeMyJBupJfvhAEV4byhI/zUPyOMOfp2Vo4jqw6JNZu96OZxerI0Znvdkmtj6iHgZ/Nq769H51/0IorwTN+1GBBOTYIFoAhgVNv0MbE4XM4qGxIKiUK5794P/0WB3Wr3TqkgP51o3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKvJX-0008B2-9p; Tue, 10 Dec 2024 09:09:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKvJW-002ebB-06;
	Tue, 10 Dec 2024 09:09:50 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 245C238A444;
	Tue, 10 Dec 2024 08:09:50 +0000 (UTC)
Date: Tue, 10 Dec 2024 09:09:49 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	Stefano Offredi <stefano.offredi@gmail.com>
Subject: Re: [PATCH can-next v2] can: mcp251xfd: ACPI support
Message-ID: <20241210-khaki-dove-of-whirlwind-979568-mkl@pengutronix.de>
References: <20241210-mcp251xfd-acpi-v2-1-d6694f590d00@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="chrimzxfinuutve5"
Content-Disposition: inline
In-Reply-To: <20241210-mcp251xfd-acpi-v2-1-d6694f590d00@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--chrimzxfinuutve5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v2] can: mcp251xfd: ACPI support
MIME-Version: 1.0

On 10.12.2024 08:57:14, Marc Kleine-Budde wrote:
> From: Stefano Offredi <stefano.offredi@gmail.com>
>=20
> This patch makes the Microchip MCP251xFD driver compatible with
> hardware parameters loading from ACPI tables.
>=20
> It's a patch for the 5.15 kernel version for which I could do tests on.
>=20
> The ACPI driver hardware description table I used is the following:
>=20
> DefinitionBlock ("can.aml", "SSDT", 1, "mcp2518fd", "Intel", 0x00000003)
> {
>     External (\_SB.PC00.SPI0, DeviceObj)
>     Scope (\_SB.PC00.SPI0)
>     {
>         Device (CAN0) {
>             Name (_HID, "MCP2518")
>             Name (_CID, "mcp2518fd")
>             Name (_DDN, "CAN SPI device connected to CS0")
>             Name (_CRS, ResourceTemplate () {
>                 SpiSerialBus (
>                     0,                             // Chip select
>                     PolarityLow,             // Chip select is active low
>                     FourWireMode,        // Full duplex
>                     8,                              // Bits per word is 8=
 (byte)
>                     ControllerInitiated,    // Don't care
>                     20000000,                // 20 MHz
>                     ClockPolarityLow,     // SPI mode 0
>                     ClockPhaseFirst,      // SPI mode 0
>                     "\\_SB.PC00.SPI0",  // SPI host controller
>                     0                               // Must be 0
>                 )
>                 GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullDefault, =
0,
>                     "\\_SB.GPI0", 0, ResourceConsumer, ,
>                     )
>                     {
>                        2
>                     }
>             })
>             Name (_DSD, Package ()
>             {
>                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                 Package ()
>                 {
>                     Package () {"rxint-gpios", Package () { ^CAN0, 0, 0, =
0 } },
>                     Package (2) {"clock-frequency",  40000000 }
>                 }
>             })
>          }
>      }
>  }
>=20
> Signed-off-by: Stefano Offredi <stefano.offredi@gmail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> This is a continuation of Stefano Offredi's work. For easier review
> I've rebased the patch to current net-next/main and fixed the
> indention.
> ---
> Changes in v2:
> - rebased to net-next/main
> - fix indention
> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 34 ++++++++++++++++++++=
++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net=
/can/spi/mcp251xfd/mcp251xfd-core.c
> index 3bc56517fe7a99d96dd43750a8ddd21961138e41..ee066dc2fdaa97ebadb5dc975=
957426c563adc9e 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -12,6 +12,9 @@
>  // Copyright (c) 2019 Martin Sperl <kernel@martin.sperl.org>
>  //
> =20
> +#ifdef CONFIG_ACPI
> +#include <linux/acpi.h>
> +#endif
>  #include <linux/unaligned.h>
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
> @@ -2002,6 +2005,23 @@ static const struct spi_device_id mcp251xfd_id_tab=
le[] =3D {
>  };
>  MODULE_DEVICE_TABLE(spi, mcp251xfd_id_table);
> =20
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id  mcp251xfd_acpi_id_table[] =3D {
> +	{ "MCP2517", .driver_data =3D (kernel_ulong_t)&mcp251xfd_devtype_data_m=
cp2517fd, },
> +	{ "MCP2518", .driver_data =3D (kernel_ulong_t)&mcp251xfd_devtype_data_m=
cp2518fd, },
> +	{ "MCP251X", .driver_data =3D (kernel_ulong_t)&mcp251xfd_devtype_data_m=
cp251xfd, },

At lest in the Linux struct the acpi_device_id::id member has a length
of 16. Can we add "FD", so that it reads "MCP2517FD"?

> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, mcp251xfd_acpi_id_table);
> +
> +static const struct acpi_gpio_params rx_int_gpios =3D { 1, 0, false };
> +
> +static const struct acpi_gpio_mapping acpi_mcp251xfd_gpios[] =3D {
> +	{ "rx-int-gpios", &rx_int_gpios, 1 },
> +	{},
> +};
> +#endif
> +
>  static int mcp251xfd_probe(struct spi_device *spi)
>  {
>  	struct net_device *ndev;
> @@ -2012,11 +2032,20 @@ static int mcp251xfd_probe(struct spi_device *spi)
>  	bool pll_enable =3D false;
>  	u32 freq =3D 0;
>  	int err;
> +	int ret;

Reuse "err".

> =20
>  	if (!spi->irq)
>  		return dev_err_probe(&spi->dev, -ENXIO,
>  				     "No IRQ specified (maybe node \"interrupts-extended\" in DT mis=
sing)!\n");
> =20
> +#ifdef CONFIG_ACPI
> +	ret =3D devm_acpi_dev_add_driver_gpios(&spi->dev, acpi_mcp251xfd_gpios);
> +	if (ret) {
> +		dev_dbg(&spi->dev, "failed to add gpios mapping table\n");
> +		return ret;
> +	}
> +#endif
> +
>  	rx_int =3D devm_gpiod_get_optional(&spi->dev, "microchip,rx-int",
>  					 GPIOD_IN);
>  	if (IS_ERR(rx_int))
> @@ -2049,6 +2078,8 @@ static int mcp251xfd_probe(struct spi_device *spi)
>  		if (err)
>  			return dev_err_probe(&spi->dev, err,
>  					     "Failed to get clock-frequency!\n");
> +
> +		dev_dbg(&spi->dev, "using clock-frequency %d Hz\n", freq);

The clock frequency is shown with "ip --details link show can0", so we
can remove this here.

>  	}
> =20
>  	/* Sanity check */
> @@ -2204,6 +2235,9 @@ static struct spi_driver mcp251xfd_driver =3D {
>  		.name =3D DEVICE_NAME,
>  		.pm =3D &mcp251xfd_pm_ops,
>  		.of_match_table =3D mcp251xfd_of_match,
> +#ifdef CONFIG_ACPI
> +		.acpi_match_table =3D ACPI_PTR(mcp251xfd_acpi_id_table),
> +#endif
>  	},
>  	.probe =3D mcp251xfd_probe,
>  	.remove =3D mcp251xfd_remove,
>=20
> ---

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--chrimzxfinuutve5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdX90oACgkQKDiiPnot
vG8b0gf9ElARTqJuSNu3wiz5tW+1OxhYkrvpwUcFGaUv3RV5pbxr1blAoYcBAw+j
VrQI01DmNH8DRUAYAdxdcxxziUUE106OEqoGnwS/JA2yCImjjMiMsnNCyhRW9azB
Z+D9kn7uHRPC9gkByU7pcypbEa2+IrfCqhN4ak05L5n8EleHxDFSAJiqmzS1G4P/
E9lOHoqkmE+m/SxOsvkMRssshBc5GQedwx1X7wrmJwm0ba/Yja2/5a4xHg63dGjz
2LTQz45ZgcPTx2DmjSR89Cuwhy5DtsuzJ6kGHIPvMi/y3x5NK4gd7Oi/R6OpNW/M
K3UIk85buiZOPsY0Y4LEo+TkVuRn1Q==
=9eZl
-----END PGP SIGNATURE-----

--chrimzxfinuutve5--

