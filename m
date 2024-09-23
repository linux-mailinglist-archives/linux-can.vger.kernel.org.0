Return-Path: <linux-can+bounces-1538-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F4197EA66
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 13:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED391F21FEA
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 11:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D5519539F;
	Mon, 23 Sep 2024 11:01:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBACB195F04
	for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089317; cv=none; b=XIIwqWe43XWJo6F2fPel7gAuzkZIUh+W9sGRZVzhfTaqYZVWrylIfc8FliN3ylCEdj+hH/e6vWKyKkaQxIvaXAimYFKioCUiKi5/8f2zwYEWPZ1K9T22jfycTp1Oyp08ByzmyF+Hi5tHx3HBa83jAnT2XL/MR8FrAYFmydmVIA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089317; c=relaxed/simple;
	bh=XkT0GAd5gT92rvVezRv83C93yk9DwRnkVghgv3yZFsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBt43T2vP3olpW4XNqb6cuzwlbll55j8wvAbL3XoufY4dtyTtBbkySVRX0uYlzKKCVpAjmobLgno4rHF8Ewsv85CARXzZqZNmkclGZzIylJcL9uJ4GvOyxV2F/hcnVLD6IsJpr7q98WuleZ+P8xJ3IBaHuWi/a2h7u/QpHBymHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssgp9-0007Nz-RP; Mon, 23 Sep 2024 13:01:47 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssgp7-000wJh-Ec; Mon, 23 Sep 2024 13:01:45 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9C82A341139;
	Mon, 23 Sep 2024 11:01:43 +0000 (UTC)
Date: Mon, 23 Sep 2024 13:01:42 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Thomas =?utf-8?Q?M=C3=BChlbacher?= <tmuehlbacher@posteo.net>
Cc: linux-can@vger.kernel.org, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH 1/1] can: {cc770,sja1000}_isa: allow building on x86_64
Message-ID: <20240923-cordial-garrulous-perch-b084ab-mkl@pengutronix.de>
References: <20240919174151.15473-1-tmuehlbacher@posteo.net>
 <20240919174151.15473-2-tmuehlbacher@posteo.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kjkw5j7ocl2d4bmr"
Content-Disposition: inline
In-Reply-To: <20240919174151.15473-2-tmuehlbacher@posteo.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kjkw5j7ocl2d4bmr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.09.2024 17:35:22, Thomas M=C3=BChlbacher wrote:
> The ISA variable is only defined if X86_32 is also defined. However,
> these drivers are still useful and in use on at least some modern 64-bit
> x86 industrial systems as well. With the correct module parameters, they
> work as long as IO port communication is possible, despite their name
> having ISA in them.
>=20
> Fixes: a29689e60ed3 ("net: handle HAS_IOPORT dependencies")
> Signed-off-by: Thomas M=C3=BChlbacher <tmuehlbacher@posteo.net>

Looks good to me! Added to linux-can/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kjkw5j7ocl2d4bmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbxSpIACgkQKDiiPnot
vG+pfQf/TzY4sbkNF+jUYt6Sqqgg0UWxCvVZp7g+wOUet7Q/euXwMY/XF5vwciSS
96VOhamtfVDMzmCBcbdPdYUeJkGajsGCVIzxQqvosvz4bxCB3L5sObJx0S7dKhp1
cOA2tQJRxuVXSHJvpLY0ZcvRNNX0izpNPYrkskpm22csOHY1c0CogppxOyH6hXmI
j6Zgum1ohO18i0bQcFX656V5vORRKkDspueeufQ7IKiC6C3Wel3syu09Lqwwr/I3
02ukm3zcM4/eXEwjEzVtOLyWNxAMto6VG6/PmzTKngN1z0G0nMHjXQSvHQBkIzVV
aWULq5dJdVtmRoyY8CdwqvpIZgZVKQ==
=TPgQ
-----END PGP SIGNATURE-----

--kjkw5j7ocl2d4bmr--

