Return-Path: <linux-can+bounces-2373-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92229EB07F
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 13:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA931887094
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FA21A08C1;
	Tue, 10 Dec 2024 12:09:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF919D899
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832566; cv=none; b=g7V3staxwqeFE/EYBo7cMV4UwaqOfpIffYMI+ht/1C2MHTgsa4LEQ/22lHpJ7RYwDg0BkSfrmagXoEfXawZvEkwT8QDr1NSp4/syDo0w72hctogm9lFhNMoL1H37tX7H1kF2LmwzdmbICC6zimm3537Y8gTu95GhxkO4P/wInaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832566; c=relaxed/simple;
	bh=4jrXM61mzNBi80OaSxD/uhkEJOSKBPrqpZnYY3X+NF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcOJF3X1x32L7znAoatHUachL2SuZVlnShZ+Wtd6rth/nmXYjh/qm4Klrp3HDBdpu2clE0tFHRcgAclWZKd4OIboMBJLSKbIUBYmhlgRBO+ibNNrO1/8wlxJp6ydqSktqJgy/PQEVBJ2qQHTsSYD4QKVewpPZJiXd60DFbqIzmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKz3I-00064G-GV; Tue, 10 Dec 2024 13:09:20 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKz3H-002gTK-0b;
	Tue, 10 Dec 2024 13:09:19 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 95CF438AADE;
	Tue, 10 Dec 2024 12:09:19 +0000 (UTC)
Date: Tue, 10 Dec 2024 13:09:19 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefano Offredi <stefano.offredi@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	kernel@pengutronix.de, linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v2] can: mcp251xfd: ACPI support
Message-ID: <20241210-watchful-kingfisher-of-focus-8bbf9f-mkl@pengutronix.de>
References: <20241210-mcp251xfd-acpi-v2-1-d6694f590d00@pengutronix.de>
 <20241210-laughing-koel-of-nirvana-349f7e-mkl@pengutronix.de>
 <CAOv6HEC=FV1gGt17SQxWo9jTMkxhLHBmkPKAWDfg=EYGHpCfwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k23c27hplytjld5x"
Content-Disposition: inline
In-Reply-To: <CAOv6HEC=FV1gGt17SQxWo9jTMkxhLHBmkPKAWDfg=EYGHpCfwg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--k23c27hplytjld5x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v2] can: mcp251xfd: ACPI support
MIME-Version: 1.0

On 10.12.2024 12:52:57, Stefano Offredi wrote:
> > > +#ifdef CONFIG_ACPI
> > > +static const struct acpi_device_id  mcp251xfd_acpi_id_table[] =3D {
> > > +     { "MCP2517", .driver_data =3D (kernel_ulong_t)&mcp251xfd_devtyp=
e_data_mcp2517fd, },
> > > +     { "MCP2518", .driver_data =3D (kernel_ulong_t)&mcp251xfd_devtyp=
e_data_mcp2518fd, },
> > > +     { "MCP251X", .driver_data =3D (kernel_ulong_t)&mcp251xfd_devtyp=
e_data_mcp251xfd, },
> > > +     {}
> > > +};
> > > +MODULE_DEVICE_TABLE(acpi, mcp251xfd_acpi_id_table);
> > > +
> > > +static const struct acpi_gpio_params rx_int_gpios =3D { 1, 0, false =
};
> > > +
> > > +static const struct acpi_gpio_mapping acpi_mcp251xfd_gpios[] =3D {
> > > +     { "rx-int-gpios", &rx_int_gpios, 1 },
> >
> > The devm_gpiod_get_optional() uses "microchip,rx-int". How does it find
                                        ^^^^^^^^^^

> > the "rx-int-gpios" here? Does the ACPI matching code remove the
> > "microchip," prefix?
> >
> It should use the devm_acpi_dev_add_driver_gpios() function to get
> rx-int-gpios using names listed in acpi_mcp251xfd_gpios[] (rx-int-gpios).
> Then watching at other drivers using gpios loading, after calling
> devm_acpi_dev_add_driver_gpios(),
> they call devm_gpiod_get_optional(), with the same name but without "-gpi=
os".
> So in our case it is exactly "rx-int".

No! Please re-read the code, devm_gpiod_get_optional() uses
"microchip,rx-int", not "rx-int":

| 	rx_int =3D devm_gpiod_get_optional(&spi->dev, "microchip,rx-int",
                                                     ^^^^^^^^^^
| 					 GPIOD_IN);


> The chain starts from the acpi table here:
> Package () {"rx-int-gpios", Package () { ^CAN0, 0, 0, 0 } }.
>
> For example you can watch at st33zp24/spi.c:237 driver, or st-nci/spi.c:2=
35

This is the case for st33zp24/spi.c, but not your code:

| static const struct acpi_gpio_mapping acpi_st33zp24_gpios[] =3D {
|         { "lpcpd-gpios", &lpcpd_gpios, 1 },
             ^^^^^^^^^^^
|         { },
| };

|         tpm_dev->io_lpcpd =3D devm_gpiod_get_optional(dev, "lpcpd",
                                                            ^^^^^
|                                                     GPIOD_OUT_HIGH);

FYI:
Without a reference to a kernel version this line file+line number is
not of much value. Can you post a link to https://elixir.bootlin.com
which includes the kernel version?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--k23c27hplytjld5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdYL2sACgkQKDiiPnot
vG8FeAf/aqluPgZ9W2LIYqmfcwl+elqDmfjsnJJp78HGh6ZcG7Ghjld6bXLvo/P5
4AbmbpPuF2kmALMvirl6ZTzGZiD8SxljaMD9nXvAvpcA6Iyc4sq3uxnF4Il+b5sk
eN5pKzXkWER3LpBdun6RmR+Z65yC+clLdM487s60FOPSUw5eFUjro344h9ZBdGGv
ZVxbszZvOJFuzLKJgXttLL2fil8qFzctrSOlbC4OxiYdP7mzRMyGRnYszLQxNGuk
blTMKFTSsNdImsY1Fowffcczh/Z8A2L8PRVE0snkblKcVv+fAo669fdxpsJ25c3P
A/hBn32AlVbWe9KsJGOMStoXktG1BA==
=Rj7R
-----END PGP SIGNATURE-----

--k23c27hplytjld5x--

