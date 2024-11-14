Return-Path: <linux-can+bounces-2031-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE759C8577
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD0C1F250C2
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4501304B0;
	Thu, 14 Nov 2024 09:02:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99B1DC74A
	for <linux-can@vger.kernel.org>; Thu, 14 Nov 2024 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574920; cv=none; b=WBjHiNVPTv5sswaKX0qr4KaHyiqO97ee2WQJP7Fnx/rGmefnh6h1hJUPdqTwjygQTwCwMvjsVwEmiEeMGaz44oPt7AeN0tUw0hg2JFf2Ugnp0O5vdrPkGla+MGX6spOjIwQtdDF7HuVmbMTO5uKiGBjuypEepxsBfp8IoGSsLjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574920; c=relaxed/simple;
	bh=+Qj7doP4Jib+4CAWjqtuXlPX1qsX62A2FRO1yV5dVok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUHDIDPPkiR0se3+3/Bqb9l5pwBedGUUoW1k6/5kxOvtxopy9x6kdiVqq49WIpqZ0ssJks4COan+K10afuOpVKKmIEQZfwLjd4cK1mUY3enAQbEVD20NRV4bWP7NrQSFyVnqBNhY/w7NeLmIjBB7AtifrGeEQIIKigfJnXAALIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBVjU-0002o7-KX; Thu, 14 Nov 2024 10:01:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBVjT-000iJL-34;
	Thu, 14 Nov 2024 10:01:43 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 86B8F372EC6;
	Thu, 14 Nov 2024 09:01:43 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:01:42 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sean Nyekjaer <sean@geanix.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
Message-ID: <20241114-quirky-aquamarine-junglefowl-408784-mkl@pengutronix.de>
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
 <20241111101011.30e04701@kernel.org>
 <fatpdmg5k2vlwzr3nhz47esxv7nokzdebd7ziieic55o5opzt6@axccyqm6rjts>
 <20241112-hulking-smiling-pug-c6fd4d-mkl@pengutronix.de>
 <20241113193709.395c18b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xfgzptvdr5uihgs4"
Content-Disposition: inline
In-Reply-To: <20241113193709.395c18b0@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--xfgzptvdr5uihgs4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
MIME-Version: 1.0

On 13.11.2024 19:37:09, Jakub Kicinski wrote:
> On Tue, 12 Nov 2024 08:16:02 +0100 Marc Kleine-Budde wrote:
> > > > There is no need to CC netdev@ on pure drivers/net/can changes.
> > > > Since these changes are not tagged in any way I have to manually
> > > > go and drop all of them from our patchwork. =20
> >=20
> > Does the prefix "can-next" help, i.e.:
> >=20
> > | [PATCH can-next v2 0/2]
> >=20
> > which can be configured via:
> >=20
> > | b4 prep --set-prefixes "can-next"
>=20
> Yup, prefix would make it easy for us to automatically discard !
>=20
> > > Oh sorry for that.
> > > I'm using b4's --auto-to-cc feature, any way to fix that? =20
> >=20
> > You can manually trim the list of Cc: using:
> >=20
> > | b4 prep --edit-cover
>=20
> My bad actually, I didn't realize we don't have an X: entries
> on net/can/ under general networking in MAINTAINERS.
>=20
> Would you mind if I added them?

Makes sense! I didn'k know that X: exists and that it makes total sense
here.

Feel free to add my:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xfgzptvdr5uihgs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc1vHMACgkQKDiiPnot
vG+Y5QgAnsKhZBcYg2x5xl/xRkUMV8Q/4si7mWxptk6zDHdYBauHiTUaI/v8bpaV
LHUjJWZM+sbmBV0BCIO6YAXPSHaM0VvxULIQC3fOhhl0nCeE+Gx0eiEpJ6U5HhLf
xvHXqxuTjdonBgYOTPd2pEcjaobL0v8WYFwLcZArtEJgr4AJlqmTzDtapx+3Kuuv
xoCm7gBqysQZ7GhRZArw83AKyKiKRLtZmSPpgygkN3Nl//qDS3ee/WgRkyMEH0Z2
Dx2szXEn4m0PztyOGCdZQljehOfoKhOFJOeYRTGf9IwuQfC+fLk376PPmHZxATcB
nv/RcdITZKtX3nrUQLLZ1UjjPYzs2Q==
=RfwS
-----END PGP SIGNATURE-----

--xfgzptvdr5uihgs4--

