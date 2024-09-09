Return-Path: <linux-can+bounces-1444-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB87971484
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 11:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A015B223FB
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 09:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B92D175D21;
	Mon,  9 Sep 2024 09:56:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D71B3726
	for <linux-can@vger.kernel.org>; Mon,  9 Sep 2024 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875791; cv=none; b=Yn2mqZ1lV9EdaXa6JYa+AkXohpwJEiD9LGSXx5nIVCz73e5cIUvBxJR/ZWIZOlGvBoOav8Os5e9lkMtzfLCeOBxleM827lwEbx7XKK5+ZgzGop9lqsFJoSg6kFHeCNS6JKe5vfwPTX8MTjZEYsev5lLs8mqinNjRRJ0xEkcqfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875791; c=relaxed/simple;
	bh=p1hQfZvZcv0CLp/JXxFyB1/SGRMNiNU5swnfm2dofOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWbG+D8OX8s6Mof+I0P1ASRbHlBIpGVjZZ6pw7xmLNBoI4BcZa3qrV9MUft4VASmwzwKPEJCJ/Kn2ehxiWTfYV3A+1xZhMr8PMfIr6lUfT+YJMd2Yzb6Jc3lrnQJQJgDh8RbibdP2zsUxUNNfpdiEZJH6ZzypUlyzgXVHOsna+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1snb7x-00081S-Uw; Mon, 09 Sep 2024 11:56:09 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1snb7u-006cba-T3; Mon, 09 Sep 2024 11:56:06 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8CE173367B0;
	Mon, 09 Sep 2024 09:56:06 +0000 (UTC)
Date: Mon, 9 Sep 2024 11:56:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, Michal Simek <michal.simek@amd.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: Switch back to struct platform_driver::remove()
Message-ID: <20240909-burrowing-orchid-gopher-1b7bc0-mkl@pengutronix.de>
References: <20240909072742.381003-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mdaoaeaktz2owhjl"
Content-Disposition: inline
In-Reply-To: <20240909072742.381003-2-u.kleine-koenig@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--mdaoaeaktz2owhjl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.09.2024 09:27:41, Uwe Kleine-K=C3=B6nig wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
>=20
> Convert all can drivers to use .remove(), with the eventual goal to drop
> struct platform_driver::remove_new(). As .remove() and .remove_new() have
> the same prototypes, conversion is done by just changing the structure
> member name in the driver initializer.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>=20
> this is merge window material and should be applied to a tree that
> includes 0edb555a65d1---so v6.11-rc1 is fine.

Added to linux-can-next/testing, should go into v6.12.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mdaoaeaktz2owhjl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbexjMACgkQKDiiPnot
vG9Dogf+JfplR+o1vqqfEDCY1MbsUdrdDNscDen5aLBudgObHATxQuLErxpbEsC2
DJGK4wbRqe3fCPDIlHWyxbf7uDm6f8Zss+e6Ob3XqwoFH87jSb4CtQoyYZ8XhzCR
wRuLo5NUY5hZKHciJHEfaCcWMHsAzvxUl6aeCb6WfZza/2kDyKmHGxoSC7jKXIG1
XzkyRDkfsxq+LDdupN+sa6W0SSyQ54x29lqoM08ILDHor60rysYrzwOlkqfM80u3
H23zg6YPt5f1TF0rs/OTQ0mk6a4DU/ZWoPtAzRDWePZOFiG26klo5plp5VB9GKn2
qRhRYjonDP92pELOxIGgUMOc+jzHxA==
=/Lql
-----END PGP SIGNATURE-----

--mdaoaeaktz2owhjl--

