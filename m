Return-Path: <linux-can+bounces-2377-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA77D9EB361
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 15:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EDE18880E5
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807901BD9FA;
	Tue, 10 Dec 2024 14:31:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33221BD027
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841108; cv=none; b=XfHAQWjl0KjVWJ+AJxYJnABgQH2Lmnou88/0sPZGwEm4ZMEmorghHfg6m/mAwKT5EdlXA3g3qONIgqhgr24whqJQFRqYnHCTW5OAAS2svZfFU2Mpgtbm9ro/4eaPKlXI6AhRKGGn04R2TN+/KPB8QK/LvKbl+mOW6GE14Nb0eiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841108; c=relaxed/simple;
	bh=JpPli1h6rqF36A0qmZP/BwLFaQdc+5YLRgj9vwSvFaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZ92qrlGRV90yITLrI0x/d9mKOr6FBRnx8Temu6jT3PasRyGgfDLPBM0pZf0ekPXZUOoBW39nJdSplyrNWLAbd5hQdnTMEoXEUGR2Fr3pTDfFWRxHbliSOnZ/+qM+7ucDiWwfBI+i4fKONEOfD/NnhYQlo0SXlxHWOdCGUlBW6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tL1H1-0002vk-2D; Tue, 10 Dec 2024 15:31:39 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tL1Gz-002hnw-25;
	Tue, 10 Dec 2024 15:31:38 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 13B5A38ACFB;
	Tue, 10 Dec 2024 14:31:38 +0000 (UTC)
Date: Tue, 10 Dec 2024 15:31:37 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefano Offredi <stefano.offredi@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	kernel@pengutronix.de, linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v2] can: mcp251xfd: ACPI support
Message-ID: <20241210-gabby-augmented-mussel-8e3ea3-mkl@pengutronix.de>
References: <20241210-mcp251xfd-acpi-v2-1-d6694f590d00@pengutronix.de>
 <20241210-laughing-koel-of-nirvana-349f7e-mkl@pengutronix.de>
 <CAOv6HEC=FV1gGt17SQxWo9jTMkxhLHBmkPKAWDfg=EYGHpCfwg@mail.gmail.com>
 <20241210-watchful-kingfisher-of-focus-8bbf9f-mkl@pengutronix.de>
 <CAOv6HED6wuhUQcE36izZFWcjdsw0G=RUCLdnOJ1FKEj-e9dm_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c4ab5nz6whdni5eo"
Content-Disposition: inline
In-Reply-To: <CAOv6HED6wuhUQcE36izZFWcjdsw0G=RUCLdnOJ1FKEj-e9dm_Q@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--c4ab5nz6whdni5eo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v2] can: mcp251xfd: ACPI support
MIME-Version: 1.0

On 10.12.2024 15:04:05, Stefano Offredi wrote:
> > No! Please re-read the code, devm_gpiod_get_optional() uses
> > "microchip,rx-int", not "rx-int":
> >
> > |       rx_int =3D devm_gpiod_get_optional(&spi->dev, "microchip,rx-int=
",
> >                                                      ^^^^^^^^^^
> > |                                        GPIOD_IN);
> >
> very sorry Marc, in my test environment I had modified this line but I
> have not reported it in the patch.
> Be patient, it's the first time I post a patch to the kernel. Any hint
> is very appreciated.

No problem.

> To keep compatibility with DTS loading I propose the following:
>=20
> #ifdef CONFIG_ACPI
>         ret =3D devm_acpi_dev_add_driver_gpios(&spi->dev, acpi_mcp251xfd_=
gpios);
>         if (ret) {
>                 dev_dbg(&spi->dev, "failed to add gpios mapping table\n");
>                 return ret;
>         }
>         rx_int =3D devm_gpiod_get_optional(&spi->dev, "rx-int", GPIOD_IN);
> #else
>         rx_int =3D devm_gpiod_get_optional(&spi->dev,
> "microchip,rx-int", GPIOD_IN);
> #endif

Why not use "microchip,rx-int" for ACPI, too?

> Even with those lines of code, If I print  spi->irq before the call
> to request_threaded_irq() it keeps different error codes
> values (-19, -22, depending on whether I set the gpio controller
> values in ACPI table).

Just to clarify: from the Linux point of view "rx-int" is a GPIO, not an
interrupt. It's connected to the "nINT1/GPIO1" pin of the mcp251xfd and
this is optional. The IRQ which is available under spi->irq is connected
to the "nINT" pin of the mcp251xfd.

> Even If I remove in ACPI table all the gpio references listed
> here below:
>=20
> - GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullDefault...
> - Package () {"rx-int-gpios", Package () { ^CAN0, 0, 0, 0 } }
>=20
> the spi->irq keeps error value -2.

I suggest to first remove all "rx-int" related stuff from your ACPI
table and concentrate that "spi->irq" has a proper value.

The relevant code is in acpi_status acpi_register_spi_device():

| https://elixir.bootlin.com/linux/v5.15/source/drivers/spi/spi.c#L2294

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--c4ab5nz6whdni5eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdYUMYACgkQKDiiPnot
vG9iUgf/d8zNoUp5Wn+Mzu8e66aUbJ1Y4d5m0coIwv9qCTLs8TDk5lCWRMWGkQul
hmoagYNaPZA1t+xxxDSHK9FHqEEgoZwEKjGF+I02Fw+lf7p8Ao4XkwidsvLD72dO
IlaF8Dhas6/GZw+r5TbSdeGBq73m7TVxv3ABT5QNgU3clIMCK+21dEkpdyaTyyez
IBhXzbEWJa9xYUtIUu6OEbtUfvUqa9cjRoq/Ymr8l1FrXqYaRilOcN1S+faejtal
QyGXWOOQ1xCWu3eBy7KEbPNODvbdi9nqF5V4ldA9jiJrHt8yA9HFApJRtgqlTRdc
e04bQtXktJ+CgDZApZonuutdPHX5NQ==
=7GQl
-----END PGP SIGNATURE-----

--c4ab5nz6whdni5eo--

