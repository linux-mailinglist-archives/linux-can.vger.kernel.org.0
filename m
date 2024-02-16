Return-Path: <linux-can+bounces-293-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E5857DD9
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 14:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767AC1F273EE
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 13:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16A278691;
	Fri, 16 Feb 2024 13:40:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F14129A83
	for <linux-can@vger.kernel.org>; Fri, 16 Feb 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090806; cv=none; b=OLTtLKpU/+9W1sVXGKbIGQL56mbjncWDthORguHjSTcF0anOg9dtoilYk2fb8JWQK6T6DBTCjKOU2QuDAG35MfFhDKWONARuuimwcfp9kU5CjEbQBjQzcyFtXc3WXU44T2H+ukEUhhL1Yn7EviWQNhy6aXWSgrU8Tj4GRFiUOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090806; c=relaxed/simple;
	bh=Dbb9ntlQhQ58NS0fm39u8U/3o7sG+cFW1S+9IZXQY1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeEvQp/oWwz+qKVB4bMk/utIXKXqiILTm5GpbAmbuttjw19MNfwuZnFUSkMKofhxiIHpZQhrm2ibbzcAsXxfipWyxf9mZaPlMaI0FoLhwWsXbNsTEbgndf+IyUdrVtqmJwHU0I2h2hFVYa6Wl73yxWNCtypiELnNgyjrP2uosFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rayRB-0002sJ-QQ; Fri, 16 Feb 2024 14:39:33 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rayRB-0015RJ-2D; Fri, 16 Feb 2024 14:39:33 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B34CE29044F;
	Fri, 16 Feb 2024 13:39:32 +0000 (UTC)
Date: Fri, 16 Feb 2024 14:39:32 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "Dr. Michael 'Mickey' Lauer" <mickey@vanille.de>, 
	linux-can@vger.kernel.org
Subject: Re: Protocol recommendation for CAN(FD)-USB adapter
Message-ID: <20240216-acclaim-impromptu-4474f57f9761-mkl@pengutronix.de>
References: <0671FD01-F7C3-41C0-BD66-9E67150AB2C9@vanille.de>
 <465e5c3d-fe8a-4b01-99b4-c955f0bcaa15@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kgv4c6kis2tnquna"
Content-Disposition: inline
In-Reply-To: <465e5c3d-fe8a-4b01-99b4-c955f0bcaa15@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kgv4c6kis2tnquna
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.02.2024 22:25:37, Oliver Hartkopp wrote:
> On 2024-02-09 18:28, Dr. Michael 'Mickey' Lauer wrote:
> > My team and I have designed and developed
> > a new CAN(FD) adapter based on ESP32S3 and MCP2518fd
> > primarily aimed at ECU firmware reprogramming,
> > but eventually also for the use as OBD2-adapter,
> > CAN-logger, etc.
> >=20
> > The next incarnation will also have a
> > USB interface and I=E2=80=99m planning the necessary
> > changes for its firmware.
> >=20
> > I would like it to be compatible with SocketCAN
> > out of the box =E2=80=94 optimally without writing a
> > Linux driver, but rather reusing an existing one.
> >=20
> > Which of the mainline SocketCAN drivers would you recommend
> > basing my USB protocol on? From a quick glance,
> > I=E2=80=99m leaning towards GS-USB, since this already
> > supports different hardware families.
>=20
> Yes. I would also recommend the gsusb driver and the CandleLight firmware
> project on the other side:

ACK. gs_usb is the way to go for USB-to-CAN adapters.

> https://github.com/candle-usb/candleLight_fw
>=20
> ... where currently the CAN FD support is in the testing phase IIRC.

The USB protocol for CAN-FD is stable and supported by the kernel and
the Work-In-Progress firmware. The firmware can be found here:

| https://github.com/candle-usb/candleLight_fw/pull/139
| https://github.com/candle-usb/candleLight_fw/pull/176

We're currently discussing the implementation details of the firmware,
but the USB part is, as mentioned above, stable.

> Both the CAN(FD) adapter firmware and also the Linux kernel driver is
> actively developed by Marc Kleine-Budde and others.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kgv4c6kis2tnquna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXPZZEACgkQKDiiPnot
vG/I8Af/f31300B0DO3vMS2BMkIerBts7DXGYdAgO6O+qmTsShtNUfrmUwcX0mOY
EURnIxEHdx3meqqWGeE9O94nf+IFl5N5bGP91oPrj6OyYXT8CG43Ziu1rIMdDC6I
BdMAbPYBLAK0V9hvMMvPdly8hO3b7mUSo3JRti7ZO3Ck0Q+yIshvR35c74ygmNQQ
jz9TAiCXVtK6AZMdjs/SrPUSq88waIh5ku0hC9W4jCzbLOk4w9jOs3AcRzheCo5L
mUBM269Kww7MEnTn+5cgB9YGZ21PO/bLM4n2JenqPkv4cHaUmqUNxgU79nLZysdA
675YyP/E0+4wRJ4tH+TyXCtOOK+iRQ==
=lKP6
-----END PGP SIGNATURE-----

--kgv4c6kis2tnquna--

