Return-Path: <linux-can+bounces-3694-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA128AC504D
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 15:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F94F3A7888
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BAE2701A4;
	Tue, 27 May 2025 13:55:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C806C134CB
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354149; cv=none; b=r80fnlxkUiu+54KtpmEnWmGSL7gs9EuM+3Jdyao5ZV5Wm56NRBJoe9knAjc83E7hoaobetwuVs9K7tbGHm0dSd+fcC/2Ns0uU1nZ3aZbzuDW+L+3TQnDf1DXFqDd9ctWgKL1KSFMnj1xIhvE0ymeimDeq9g3ouFEJH+DpjGKcl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354149; c=relaxed/simple;
	bh=uY1PAQHvi/ySqbpimL92CJNeksNd+++L8AryZvxaxtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ugr6D/AJOPe04P9MhVpQ0Jnc38rzzhKzncLHVl+q/pfHEwNkO5v+nCl77adtO13kD0pOTCGeV5DwYWThqxnunw6ntJImhA2wcYFR45M2Jh8uqSwPEq0hkBxcAeSQHa2iabF1FQzJuaZp/YSTg53vW4b8U3kG+DRl/QB5znS6hwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uJumL-0006AJ-JM; Tue, 27 May 2025 15:55:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uJumL-000QkO-04;
	Tue, 27 May 2025 15:55:41 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AA63C41A98B;
	Tue, 27 May 2025 13:55:40 +0000 (UTC)
Date: Tue, 27 May 2025 15:55:40 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: RE: CAN XL netlink AIP status
Message-ID: <20250527-glistening-dog-of-apotheosis-293bd2-mkl@pengutronix.de>
References: <DBAPR10MB4187FB44B12BD9DB8B992256D4832@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
 <06bd3b3f-2665-4f19-b13d-581e57f54dfc@hartkopp.net>
 <AM9PR10MB4184729E14AD5C05ABC65718D496A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <1c502316-ddee-4f12-b0b8-3725cc522591@hartkopp.net>
 <AM9PR10MB418448751B1DA83EED7F50D4D498A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <63f2f51e-3fbd-4c8b-b7e4-29cb55246eaf@hartkopp.net>
 <AM9PR10MB41846346BC291F7CFE2CB71DD498A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <49245439-9822-449d-bf2c-5626349d909c@hartkopp.net>
 <20250527-lilac-panther-of-destiny-a13500-mkl@pengutronix.de>
 <AM9PR10MB4184E0842D24A4D7A2FEE09BD464A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fen7nikzzk3dwd64"
Content-Disposition: inline
In-Reply-To: <AM9PR10MB4184E0842D24A4D7A2FEE09BD464A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--fen7nikzzk3dwd64
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: CAN XL netlink AIP status
MIME-Version: 1.0

Hello,

Cc +=3D linux-can@vger.kernel.org

On 27.05.2025 13:43:05, St=C3=A9phane Grosjean wrote:
> >> This is probably the point where we should switch the discussion to the
> >> Linux-CAN mailing list.
>=20
> > Yes, please do so.
>=20
> I don't find any reference to CAN_CTRLMODE_XL_ERR_SIGNAL in linux-can.vge=
r.kernel.org archive
>=20
> https://lore.kernel.org/linux-can/?q=3DCAN_CTRLMODE_XL_ERR
>=20
> how to talk about this symbol?

Oliver, can you push your kernel patches from
netlink-snapshot-2025-05-23.tar.gz as a git tree somewhere?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fen7nikzzk3dwd64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmg1xFkACgkQDHRl3/mQ
kZy6agf+P5xRqOkeiQ/OZnORrP0bcjKSzEofR+HayPIsAmw4rNgOxuuMcBqSJLty
64DTZnINyzZmpA9GF0K72UYCMN+Ka7DbpHq4j65wSVJ8jWryYPswWO9vDNGkJ4IJ
Zh5fCXcPRDc5pI3Dl5mkr8bEcdrvwNj2m+qfnTNhCNTTHC6SAu5QrNlnUwPXAnZC
HuRFnOorgKnibqycxr39ZTJcMG7W39dSj+ptb/5N6w8aDKOARi7KKY+fM4S1JMku
027WelP8OMAnFzRpp/Abe+IOq+6dtOQdJEDOLI2sFY0gSbsxtfe5oon3VZ0DZWzH
ky+Q/sgj+QIYDJTr7bj1P40CF1/AWA==
=D2oj
-----END PGP SIGNATURE-----

--fen7nikzzk3dwd64--

