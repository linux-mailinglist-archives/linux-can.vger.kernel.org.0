Return-Path: <linux-can+bounces-2383-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E409EB4E9
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 16:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2FD168AA3
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 15:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6477178F23;
	Tue, 10 Dec 2024 15:28:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCF51BD51F
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844510; cv=none; b=OeVgQTwWQqh9WgpHhkkQaK8S+qCpWRT/TcbkIRGVzzXsxmZ1SI4So5MhV+MIX6hYoi0Y/0q+7+gQ2jolANlC4FAXR6IYpjxkyVcOJXy1uyy7rNO2VLL4KW7691nJgCtKU9zwAaixwd3Dk/hP0v0INudtxMWyUrMeFCAUQoSnf5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844510; c=relaxed/simple;
	bh=XbnkVor0nP8/0yTdYDnVuDldwVIGBONYZrLV1iSBAIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzY6gVqaIqcL/91DnAPuaFOeATVUb7ESqLkTF+z7TkQcpqV2LREJL+T+3av5AL5Ggi/Kd0i5DrvR5iqmGPS2+dQK0mtfWZGvHTeYd16sdqf0dWVxBdiZnn2bmX6PhWJXXoi+PR7AmFLcFtVbDFOmC6kYXwBwZOm4h6PiDR8gCRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tL29w-000414-O0; Tue, 10 Dec 2024 16:28:24 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tL29v-002iEV-1m;
	Tue, 10 Dec 2024 16:28:24 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F08A438ADA8;
	Tue, 10 Dec 2024 15:28:23 +0000 (UTC)
Date: Tue, 10 Dec 2024 16:28:23 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefano Offredi <stefano.offredi@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	kernel@pengutronix.de, linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v2] can: mcp251xfd: ACPI support
Message-ID: <20241210-complex-impetuous-panther-fedb99-mkl@pengutronix.de>
References: <20241210-mcp251xfd-acpi-v2-1-d6694f590d00@pengutronix.de>
 <20241210-laughing-koel-of-nirvana-349f7e-mkl@pengutronix.de>
 <CAOv6HEC=FV1gGt17SQxWo9jTMkxhLHBmkPKAWDfg=EYGHpCfwg@mail.gmail.com>
 <20241210-watchful-kingfisher-of-focus-8bbf9f-mkl@pengutronix.de>
 <CAOv6HED6wuhUQcE36izZFWcjdsw0G=RUCLdnOJ1FKEj-e9dm_Q@mail.gmail.com>
 <20241210-gabby-augmented-mussel-8e3ea3-mkl@pengutronix.de>
 <CAOv6HECvDWOQMvvLi7ZQRsOMAQ83rUZUQoMM0Siym2nOEFq_fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7tog5qm5i3hyaw6t"
Content-Disposition: inline
In-Reply-To: <CAOv6HECvDWOQMvvLi7ZQRsOMAQ83rUZUQoMM0Siym2nOEFq_fw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--7tog5qm5i3hyaw6t
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v2] can: mcp251xfd: ACPI support
MIME-Version: 1.0

On 10.12.2024 16:18:07, Stefano Offredi wrote:
> > > Even with those lines of code, If I print  spi->irq before the call
> > > to request_threaded_irq() it keeps different error codes
> > > values (-19, -22, depending on whether I set the gpio controller
> > > values in ACPI table).
> >
> > Just to clarify: from the Linux point of view "rx-int" is a GPIO, not an
> > interrupt. It's connected to the "nINT1/GPIO1" pin of the mcp251xfd and
> > this is optional. The IRQ which is available under spi->irq is connected
> > to the "nINT" pin of the mcp251xfd.
> >
> > > Even If I remove in ACPI table all the gpio references listed
> > > here below:
> > >
> > > - GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullDefault...
> > > - Package () {"rx-int-gpios", Package () { ^CAN0, 0, 0, 0 } }
> > >
> > > the spi->irq keeps error value -2.
> >
> > I suggest to first remove all "rx-int" related stuff from your ACPI
> > table and concentrate that "spi->irq" has a proper value.
> >
> > The relevant code is in acpi_status acpi_register_spi_device():
> >
> > | https://elixir.bootlin.com/linux/v5.15/source/drivers/spi/spi.c#L2294
> >
>=20
> Ok thanks I will investigate on it.
>=20
> Just to be sure, will the driver, if rx-int and interrupt logic is not

"rx-int" is not used as an interrupt source. To keep things simple
forget about "rx-int" for now.

> used, perform a polling on the spi bus to check for messages incoming
> on the can controller?

No - polling is not implemented and makes IMHO no sense, as it's quite
some overhead.

> So I should see in this operating mode
> continuous spi communication on the bus, right?

If there's no traffic on the bus, you should only see very little SPI
communication. Just a read of the timestamp every 30s or so.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7tog5qm5i3hyaw6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdYXhQACgkQKDiiPnot
vG9lZQf7BUTKj7xCgv0rLE4XS/Hf0qzslYP83aysnygTqWUX4Kc19Me92fD4chMx
3Ii6Q01ZQ2fydWPf4k7edYG0sYC+uwOUp4ATPHxqX9q/2QIx97EBUsOSOk2MlLyw
olER+++KVxXJadssw4AFHlx2T3FODTfxqFrVUcncAlH7T0iTDvfz0YUFCNh78kdc
1OUuXGYFATdh3ImAIU20hklN0ZCTmn3AJ4Y8NKlvCAUoIfcPC6TpCOtzixdSAfFI
RDC8ogailc5kEnis59n+ecFfRiSh+5j5T4JXIViWy/Y780aWkqjCV5tvXq4fS1dp
NXLRAbVpdYMBAyd7EDBkI68t/3WkGA==
=95Z7
-----END PGP SIGNATURE-----

--7tog5qm5i3hyaw6t--

