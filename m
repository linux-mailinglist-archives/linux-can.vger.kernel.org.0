Return-Path: <linux-can+bounces-1867-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD699BB154
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 11:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78371F20D22
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5141C1B2192;
	Mon,  4 Nov 2024 10:39:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AA61B219F
	for <linux-can@vger.kernel.org>; Mon,  4 Nov 2024 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716755; cv=none; b=mqkZwVEYLO58/oAX1ARPpbbHD8sAuCEVYCVL8JiUip87GLMhZAOZxuf0DEmx65hOSx5puF9K6/rQmX30Vcne4I4mQMvcwO4wXP6S9cE9Wen+m+JFCgJO5lPTMUMI6Ag9jQFEhNMg0c3pqjh4skKHNXvYq2Uo4DV+oUTpm5S6fW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716755; c=relaxed/simple;
	bh=N3f8zM9BaHy1ub8djA4SwrgJt0GPZwBjTTRE/BIVDd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NR1s5DCixpNHQjl3EHLQMDNSre/tPxejDAzLw+kteOkmU0McbzLJRRRK5dJHKinOvUaiRJm6anmUj66xzdqop36CC+EvW1Krcm8fTOGr2N5MMPIqzddXqrVtfxBZrZTPMqdqUbjdJR3+AT3cKT6JYYbmcbHD5a5ExYt+1GET53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t7uUF-0005Px-81; Mon, 04 Nov 2024 11:39:07 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t7uUD-001xqC-02;
	Mon, 04 Nov 2024 11:39:05 +0100
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AA96F36791A;
	Mon, 04 Nov 2024 10:39:04 +0000 (UTC)
Date: Mon, 4 Nov 2024 11:39:04 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: "baozhu.liu" <lucas.liu@siengine.com>, wg@grandegger.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] can: flexcan: simplify the calculation of priv->mb_count
Message-ID: <20241104-graceful-slug-of-growth-0ee47f-mkl@pengutronix.de>
References: <20241104084705.5005-1-lucas.liu@siengine.com>
 <CAMZ6RqJ-O6PcwUrA9azJHq8vJ4_2GEFcqU-8_epHyAoBmeeEuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rvghoukwx3snbpoh"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJ-O6PcwUrA9azJHq8vJ4_2GEFcqU-8_epHyAoBmeeEuA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--rvghoukwx3snbpoh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: flexcan: simplify the calculation of priv->mb_count
MIME-Version: 1.0

On 04.11.2024 19:31:30, Vincent Mailhol wrote:
> On Mon. 4 Nov. 2024 at 18:05, baozhu.liu <lucas.liu@siengine.com> wrote:
> > Since mb is a fixed-size two-dimensional array (u8 mb[2][512]),
> > "priv->mb_count =3D sizeof(priv->regs->mb)/priv->mb_size;",
> > this expression calculates mb_count correctly and is more concise.
>=20
> When using integers,
>=20
>   (a1 / q) + (a2 / q)
>=20
> is not necessarily equal to
>=20
>   (a1 + a2) / q.
>=20
>=20
> If the decimal place of
>=20
>   sizeof(priv->regs->mb[0]) / priv->mb_size
>=20
> were to be greater than or equal to 0.5, the result would have changed
> because of the rounding.
>=20
> This is illustrated in https://godbolt.org/z/bfnhKcKPo.
>=20
> Here, luckily enough, the two valid results are, for CAN CC:
>=20
>   sizeof(priv->regs->mb[0]) / priv->mb_size =3D 512 / 16
>                                             =3D 64
>=20
> and for CAN FD:
>=20
>   sizeof(priv->regs->mb[0]) / priv->mb_size =3D 512 / 72
>                                             =3D 14.22
>=20
> and both of these have no rounding issues.
>=20
> I am not sure if we should take this patch. It is correct at the end
> because you "won a coin flip", but the current code is doing the
> correct logical calculation which would always yield the correct
> result regardless of the rounding.

Wow, that's an elaborative answer. Thanks Vincent!

And yes the current code does the correct logical calculation because of
the underlying restrictions of the hardware. A CAN-CC/FD frame cannot
cross the boundary between the 2 memory areas.

If you want to improve something, feel free to add a comment explaining
the reasoning for the existing calculation.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rvghoukwx3snbpoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcopEUACgkQKDiiPnot
vG+ScAf/a7XypquJYiAv/hBRV51RnhSryuYsfRlSSS8wb3UCeVb6nADSf+6UVerW
AjAy6H5MciVX9UvCdZRaL6NBzi+Qy3qbSTJY0YoYvaTSX9TuHOF9FAJnVoQoEp3k
yWswClGqDLk9+3U51jUbJYKxIE1VQ8ea3vejo42n2hZx7DQnw3jhTtoeGktykAwD
xGAedlkIzGtqhnWXAcGP/DbAafSpzZTCghA7Bemahn/aax2Jy/W3+9EbNPOU92rz
yuj7qCrDV0pVOvmvqWl1A1URXXMvuyeJmN/spg2LFp2oHJwQJMPZeOZJ/wzuHOMK
DEn1fqnjxL71ZQXcVyU8sSmLZPxAOQ==
=e0L2
-----END PGP SIGNATURE-----

--rvghoukwx3snbpoh--

