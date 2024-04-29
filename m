Return-Path: <linux-can+bounces-505-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3E28B5FFA
	for <lists+linux-can@lfdr.de>; Mon, 29 Apr 2024 19:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4041C21650
	for <lists+linux-can@lfdr.de>; Mon, 29 Apr 2024 17:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A4C86264;
	Mon, 29 Apr 2024 17:21:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C9C85C62
	for <linux-can@vger.kernel.org>; Mon, 29 Apr 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411315; cv=none; b=E2lEyn1cpY04uwIpjUGyowGLhtBE7r2YkWFyo3Lr3g/IiGjSU2K/SJ1pjatvABUiwWAYJ6DkoIaRkkerzwp5lSwiDAl8zS4ftFyq50jfeaTqkBeFzJwruqJ/gY/snbCP+hwmQjWyqSa6i8n5FyvUeNOZRGjQp4b0GtI7wrym9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411315; c=relaxed/simple;
	bh=Jf960DS4x7SoepwWwyw2jzfTahLi1n7PxY/YV9ch6WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAdTKv5Sej8EQpd36FjdqG+PgrtqK/aiWI2apNI2sa5M56MeQf6Ao5SwTqz29fPtfKYl48F1mEckLDeuFfuipi1xa+Xots07LZ8Dpm7LdM7bgALBRMT9GuEPm3yAwlpKC2hVEF40s6+FLi5eHpt50DKNbHDPx01i5U/x+FCkiy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s1UhM-0003jp-I2; Mon, 29 Apr 2024 19:21:52 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s1UhM-00F1Mk-3B; Mon, 29 Apr 2024 19:21:52 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C60DC2C233A;
	Mon, 29 Apr 2024 17:21:51 +0000 (UTC)
Date: Mon, 29 Apr 2024 19:21:51 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH] can: isotp: remove ISO 15675-2 specification version
 where possible
Message-ID: <20240429-towering-unbiased-rhino-ca6fea-mkl@pengutronix.de>
References: <20240420194746.4885-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="phmozpmkqpb5zp2w"
Content-Disposition: inline
In-Reply-To: <20240420194746.4885-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--phmozpmkqpb5zp2w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.04.2024 21:47:46, Oliver Hartkopp wrote:
> With the new ISO 15765-2:2024 release the former documentation and commen=
ts
> have to be reworked. This patch removes the ISO specification version/date
> where possible.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to linux-can-next.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--phmozpmkqpb5zp2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYv1ywACgkQKDiiPnot
vG8zYQf/aLXDniF5whQXpX0n/VfSjr6LMgyby4eru0KMLmudIGs+ESfxnslI733q
WeFbFEf5v0d3DoKGYaYrnOox6AgOFHwKCItMOyQE9IphyUZ7LuQbhuLEMIih2GEx
IU58EYZ9onWhSNpo4DOVZn56mL/PEKCAMFXGlxYVyy6Pu4R0z9hTlzcFsSb7pzM/
zknFNVfBsBo9E6UhI53Uill8y+ZJMt3KBnbXS3NMvwfD7JW073903LbuFABfb3zW
SDE5NP5CFT2Wy0ntAgcIXy2a4owCImUVtXrwwS/VJ+wCWMHamCOahWyfnlQVQbtS
QgIi4uk1rh1mt/mfIkbOPUasiP43fA==
=DCLK
-----END PGP SIGNATURE-----

--phmozpmkqpb5zp2w--

