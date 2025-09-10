Return-Path: <linux-can+bounces-4643-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16764B51981
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 16:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C707F3BA02E
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ED231DDA4;
	Wed, 10 Sep 2025 14:36:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F74930FC18
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514968; cv=none; b=KsW92/g+hNN9DA7uQdNC1J1rgVvF2EOSTJz+UR7MDdtgMy5RWYjlfRG4scEnKN/XSkQfJgvEAxAGBLA2AGoyB0U+i51jBvCGiT0I4eAtO5yvnPOv+U2fIzW5SkdTWcwGJA9O7lb4z7y3RB4YuW/7bNtcpxz2Lw1so6xoRR7EwVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514968; c=relaxed/simple;
	bh=Qcv9VypQ5CrpXUdBUIiKcNieFWwbjJkp9RmJQnfPYd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueFB4Y8IzQ4C9pVdiFna3sywD5/z43F0bV4a2GNU7dem7rD0h2m/+Bdjv0zXvuBOPhavjd0B6/vn4Yffd3/SH5u7sDrW3kMXxyHscGfT4+8oZRh6Cc+NjzbNSVlNixm0j67YzTNqUrOn6wmBsLprzDG9ugcQVlrSX3PZQ2UqoNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwLvU-0007bu-E8; Wed, 10 Sep 2025 16:36:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwLvS-000bjF-35;
	Wed, 10 Sep 2025 16:35:58 +0200
Received: from pengutronix.de (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8A5AD46B034;
	Wed, 10 Sep 2025 14:35:58 +0000 (UTC)
Date: Wed, 10 Sep 2025 16:35:56 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Patrik Flykt <patrik.flykt@linux.intel.com>, 
	Dong Aisheng <b29396@freescale.com>, Varka Bhadram <varkabhadram@gmail.com>, 
	Wu Bo <wubo.oduw@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 7/7] can: m_can: add optional support for reset
Message-ID: <20250910-gay-rigorous-kingfisher-abafca-mkl@pengutronix.de>
References: <20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de>
 <20250909-m_can-fix-state-handling-v2-7-af9fa240b68a@pengutronix.de>
 <DCP0LDEOSFXS.1E937SV1347BX@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="66zxwyxnktomwrop"
Content-Disposition: inline
In-Reply-To: <DCP0LDEOSFXS.1E937SV1347BX@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--66zxwyxnktomwrop
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 7/7] can: m_can: add optional support for reset
MIME-Version: 1.0

On 10.09.2025 11:32:04, Markus Schneider-Pargmann wrote:
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> > index 9528af8500af..93085bf1c267 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c

[...]

> > +	cdev->rst =3D devm_reset_control_get_optional_shared(cdev->dev, NULL);
> > +	if (IS_ERR(cdev->rst))
> > +		return PTR_ERR(cdev->rst);
>=20
> Should this print an error message here?

makes sense

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--66zxwyxnktomwrop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjBjMkACgkQDHRl3/mQ
kZzgrQgApzmQ/kzhOLSRpvMqZhnGhK7PjEmu8YpSzK0Mixg4Ev7U55o3GciGL8Ei
mzn5AjRrRJTUje7pd+RS7DQ6hCpXzI/B/lBHPgYLGYES9cRefQXR1oitWOFKDiwD
994zjarSrr7h/6VoFYfGeXO/UvduULD3V8eSKhYBDxEuYwES8csIJp5pSE7oTx4R
CYLpVxI21sui/Bjgu+OwadFsFkrR08EIK4pJvfMx4e8L8ZdyVnn2acj5O9qMXdOI
ptRobYRsF8uSeDCm550HTiGnGfJv3LHXMm7C3ZOzRaVKfpjZ0NT4kxJjZ0cz29yT
qcJ5PSLZV7QjGnKOCCFFm3ivDfNpzA==
=EJob
-----END PGP SIGNATURE-----

--66zxwyxnktomwrop--

