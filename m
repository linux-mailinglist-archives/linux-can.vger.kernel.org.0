Return-Path: <linux-can+bounces-3716-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC32FAC64B5
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 10:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FB816DBAC
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 08:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B8B13633F;
	Wed, 28 May 2025 08:47:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F75464E
	for <linux-can@vger.kernel.org>; Wed, 28 May 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422074; cv=none; b=KI7eSDN4mhDfWJ3ra0Em83IGU8L/JfLdowg5neRjHE4fjYXkpaTrn/vyINysMdEN/ClyQPaSViqA+ChIjQ3YlUHxTYtCa6PrlaQL7prZTTmBpF6zOcvxnGdnEr+a4kIUyka/5vbrvZcFQnT4E1GyEuMHcj0Sc1HXPKrefh1eLv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422074; c=relaxed/simple;
	bh=TqqEQ9VVDwFl0qdKqxX8tM9FRCjfqdTMPQD4VLgIvVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4bzDMJR+dAYZC2Fn7cJhbMIYFAKh+GyA5K2Qt6z2EfruJ60NN2UOJsGCkcZk/twQ6SaJwW4u7iWYw2ezg5y95Q3U6oyuUsfoEzKziUlpE+rpIwtlDgIm6FHFRNN79hgRAkFYUuf3lhyGrhMiZbPVtziZQcViZ2Ik+3LgJNG+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKCRz-0005en-J0; Wed, 28 May 2025 10:47:51 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKCRz-000YcE-0a;
	Wed, 28 May 2025 10:47:51 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D5B9741B241;
	Wed, 28 May 2025 08:47:50 +0000 (UTC)
Date: Wed, 28 May 2025 10:47:50 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH 02/11] can: netlink: replace tabulation by space in
 assignment
Message-ID: <20250528-quirky-ultra-hawk-37000f-mkl@pengutronix.de>
References: <20250527195625.65252-1-socketcan@hartkopp.net>
 <20250527195625.65252-2-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gdj25d2olvsknzcy"
Content-Disposition: inline
In-Reply-To: <20250527195625.65252-2-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gdj25d2olvsknzcy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 02/11] can: netlink: replace tabulation by space in
 assignment
MIME-Version: 1.0

On 27.05.2025 21:56:16, Oliver Hartkopp wrote:
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>=20
> commit cfd98c838cbe ("can: netlink: move '=3D' operators back to
> previous line (checkpatch fix)") inadvertently introduced a tabulation
> between the IFLA_CAN_DATA_BITTIMING_CONST array index and the equal
> sign.
>=20
> Remove it.
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

The patches 2...5 look good to me. If Oliver adds his S-o-b, I can take
them for linux-can-next.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gdj25d2olvsknzcy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmg2zbMACgkQDHRl3/mQ
kZwSNwf/UncYuM+x44nNkTtPbXAIhwjSRfLEf48Aht9tjuWvoGpUwBJXBS8Y/7j3
RN4USQjaRQGZQi6zBVT3AFwDeXyt91eJC9/CgKdADq+qZu3kn0dTX0xiT05j/xqI
yECQhJUXARaX/Is7VXfZF8Pg9XP9EG7Klz2q2b+56Yjn43/NaWXp2yj13iWvpsRK
agCSXPj9G4nW/ZePa63gOor0BzbLlmpWwNYD38fgubMgXrJJ9IrWvq3PXEOaR7AF
eDQYS3YwUc4Vwn7tXZKjwJzetiYUNWNU728BLOmhZuA1hZtxYIFyr1YpMXVxdkyL
YhSq6gYLJcv7kmIOczEUAW+LpuzoDA==
=XNQM
-----END PGP SIGNATURE-----

--gdj25d2olvsknzcy--

