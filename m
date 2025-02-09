Return-Path: <linux-can+bounces-2773-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EA4A2E048
	for <lists+linux-can@lfdr.de>; Sun,  9 Feb 2025 20:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B075518860AE
	for <lists+linux-can@lfdr.de>; Sun,  9 Feb 2025 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F6B136A;
	Sun,  9 Feb 2025 19:45:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6C370807
	for <linux-can@vger.kernel.org>; Sun,  9 Feb 2025 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739130356; cv=none; b=NTizYipWpbPp3G8JzaI0nteXqHLSwbFfykw2A3w2mbPbf0Ir4AZOJYDrCrVChemFgHV3xJ8bNWGjUpYGNWVGRQADJbnbyDo30OF4wiUnWD8O6ZmxQ6/PYBgqP/RswE/6lFbFVrPu6sxFLj1c68vJndxq9s00IV6OU40sQB3ZU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739130356; c=relaxed/simple;
	bh=9SsvVlbOYv2lmswFKI0AQi9F2mIrCDfqxrT5bTao1zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwYvBnGTUFZ2eKhWEbyeTgo0IemDYMpYeGezntDSKWg9O4Q5R90U1N5+s+8jVBQBlrGSVvxTsCCy9tei9LvF6oqloUqvhwkhPlhzvNmQWnCfs8Bc0SxOPIjfv7vt85WcaXXwaz5MWnuoycdItX958dIbKs1Y0kWcqbWu1BLfBws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1thDFP-0003BG-LK; Sun, 09 Feb 2025 20:45:43 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1thDFP-0007tl-0n;
	Sun, 09 Feb 2025 20:45:43 +0100
Received: from pengutronix.de (unknown [IPv6:2a02:1210:32cc:3000:b91d:2c31:8aee:36c3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A3D493BD59C;
	Sun, 09 Feb 2025 19:40:30 +0000 (UTC)
Date: Sun, 9 Feb 2025 20:40:28 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <Stefan.Maetje@esd.eu>
Cc: "horms@kernel.org" <horms@kernel.org>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Frank Jungclaus <frank.jungclaus@esd.eu>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH 1/1] can: esd_usb: Fix not detecting version reply in
 probe routine
Message-ID: <20250209-dynamic-horse-of-defense-2e450f-mkl@pengutronix.de>
References: <20250203145810.1286331-1-stefan.maetje@esd.eu>
 <20250203145810.1286331-2-stefan.maetje@esd.eu>
 <20250206-wild-masked-hoatzin-b194e1-mkl@pengutronix.de>
 <d7fd564775351ea8a60a6ada83a0368a99ea6b19.camel@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6umtnhmicuqsg35x"
Content-Disposition: inline
In-Reply-To: <d7fd564775351ea8a60a6ada83a0368a99ea6b19.camel@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--6umtnhmicuqsg35x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] can: esd_usb: Fix not detecting version reply in
 probe routine
MIME-Version: 1.0

On 09.02.2025 18:53:43, Stefan M=C3=A4tje wrote:
> > > > > =C2=A0	if (err < 0) {
> > > > > =C2=A0		dev_err(&intf->dev, "no version message answer\n");
> > > > > -		goto free_msg;
> > > > > +		goto free_buf;
> > > > > =C2=A0	}
> > > > > =C2=A0
> > > > > -	dev->net_count =3D (int)msg->version_reply.nets;
> > > > > -	dev->version =3D le32_to_cpu(msg->version_reply.version);
> > > > > -
> > > > > =C2=A0	if (device_create_file(&intf->dev, &dev_attr_firmware))
> > > > > =C2=A0		dev_err(&intf->dev,
> > > > > =C2=A0			"Couldn't create device file for firmware\n");
> > > > > @@ -1332,11 +1392,12 @@ static int esd_usb_probe(struct usb_inter=
face *intf,
> > > > > =C2=A0	for (i =3D 0; i < dev->net_count; i++)
> > > > > =C2=A0		esd_usb_probe_one_net(intf, i);
> > >=20
> > > Return values are not checked here. :/
>=20
> Yes, that is another flaw. This needs to be tackled in another patch.

ACK

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6umtnhmicuqsg35x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmepBKcACgkQDHRl3/mQ
kZzS8gf/f+dt+VL5sr2nSYtBiquW2wEnPq8bJ7UEFue0qEPs4kIYB+YucNzFyafJ
kSUl1JHpFqQT3OFallA7X/sD+Ul3EVXbICzW6o5HgD0xoVmwrOTiq+ERZT+c/n2L
QUQs5XGgyKrUrRkiuRPwcDdSAvSrx8EplY97/feeT0nHWf6OBocJEaNd0Xv+71py
zwK0KTnjDBKCuftARr53+s7z+MPG6ny468tK7k4eawmcGY+dFVABd7BAitz3/6X1
RadRBPB3kru3Vf+wwvPI5N4/DEYSmiQ0Sh+VslRYPrRgfc/hHotAe3yLrAUy+BoQ
rSPX40UAORIUOls+2YMkC5hJ3eNvVw==
=MLsy
-----END PGP SIGNATURE-----

--6umtnhmicuqsg35x--

