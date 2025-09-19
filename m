Return-Path: <linux-can+bounces-4752-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A663B8AB0F
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 19:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F82517312B
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5613725C804;
	Fri, 19 Sep 2025 17:05:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0B31FEE3
	for <linux-can@vger.kernel.org>; Fri, 19 Sep 2025 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301523; cv=none; b=NSc3iiB5Pggeun0NikIfgK/vr/FpJSI9x3GlP+74rv1OpLtwALbPteJQQam5DdeAXsFRRO9vJkqNMqYc2AIWX9kHtlYilDBRMqfYFjGRSflGVwPIJ58D98jgk9I3sylZ0PSjJ7UF0QsCsSekUASwGMBxYTvA9aUhUl7X24pAQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301523; c=relaxed/simple;
	bh=Mvxr5986z8SC05lluub2hgg11scs2HtbyBBn90Ioodg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/XR/LyNvU64lgcasVgNUS6rlv3+S8xALrijcq8mZyzyzZhjuq5mdQ8njXOuSbq0bCsJB55W9pRYM7kJPaHItNJ3IZBtJRfHNpsToUytYAVY2jVETCbIyzfaenuPXIWs9SPBPxs4p94soRRBZfqisPr9QqEM/x4ZpiV2gvA4Pw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzeXP-0001QP-4w; Fri, 19 Sep 2025 19:04:47 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzeXK-0028ck-2G;
	Fri, 19 Sep 2025 19:04:42 +0200
Received: from pengutronix.de (ip-185-104-138-125.ptr.icomera.net [185.104.138.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BB2044750C5;
	Fri, 19 Sep 2025 17:04:40 +0000 (UTC)
Date: Fri, 19 Sep 2025 19:04:39 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>, Akshay Bhat <akshay.bhat@timesys.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, 
	Yasushi SHOJI <yashi@spacecubics.com>, 
	Remigiusz =?utf-8?B?S2/FgsWCxIV0YWo=?= <remigiusz.kollataj@mobica.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/4] can: populate ndo_change_mtu() to prevent buffer
 overflow
Message-ID: <20250919-portable-rat-of-dew-32b5e9-mkl@pengutronix.de>
References: <20250918-can-fix-mtu-v1-0-0d1cada9393b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="idh7qp6reuygcmse"
Content-Disposition: inline
In-Reply-To: <20250918-can-fix-mtu-v1-0-0d1cada9393b@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--idh7qp6reuygcmse
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/4] can: populate ndo_change_mtu() to prevent buffer
 overflow
MIME-Version: 1.0

On 18.09.2025 18:00:23, Vincent Mailhol wrote:
> Four drivers, namely etas_es58x, hi311x, sun4i_can and mcba_usb forgot
> to populate their net_device_ops->ndo_change_mtu(). Because of that,
> the user is free to configure any MTU on these interfaces.
>=20
> This can be abused by an attacker who could craft some skbs and send
> them through PF_PACKET to perform a buffer overflow of up to 247 bytes
> in each of these drivers.
>=20
> This series contains four patches, one for each of the drivers, to add
> the missing ndo_change_mtu() callback. The descriptions contain
> detailed explanations of how the buffer overflow could be triggered.
>=20
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

Added to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--idh7qp6reuygcmse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjNjSQACgkQDHRl3/mQ
kZybWwf/dkqGg8VI+ORuB/Iv9jFds/SZ0a+AmPu0ZAlenrV4u1OLUBbd2avtEd+T
KaYO6CuAzlpTZP6vx6S3XQ1M0qy4Z5EtQbgbrVETQ/Z6ZN106WXaOj7iYrGkWc4V
CvSbll8GBD2cP0qQrR+2DAV27Z7UHty6U1qOfqb8y0afoeqh1Bhq3ODivlAtejuE
azZd1kmiX5HdWUD2d7GQBiAZ6cBDWH70C5oMYaH7J9kiCiHKt4yqL1R1o2tlc6n7
WN3xrUIERmq9aM9x7Dh2+67tnEnfZdL10uFxUIq6Z9USZR8hn/oEI/2lOk5Fd3ZK
inQU0iQq8JWngpplUukaDeiKO/EitA==
=2zvn
-----END PGP SIGNATURE-----

--idh7qp6reuygcmse--

