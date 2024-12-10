Return-Path: <linux-can+bounces-2378-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E302A9EB38A
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 15:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24671883F67
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B59A1B0F12;
	Tue, 10 Dec 2024 14:37:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4B1AA1FD
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841466; cv=none; b=C3GkHtkHfFuMadcTOza9ruDXWd6LplUI7rvQ6+A6CE4Mm3Wu8SuZw35rDWNMGREy+rKAm6umBwb9vwtO3vJxUk5Avl9/Av++Sc5zrurBAtT4nkU2y2FsP2VfBXz4IjubliH1LX2dI0eztlDtve8z5qoCmtn4ienzWP/6gXZ61a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841466; c=relaxed/simple;
	bh=XOsr/5U22XScc5+r1RKCC/MjtPhff8dCz6y19BbKBHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtv6mFCMTuDmP1G1EX0/PA/oUK/RelDcCCEkf2YYady2zKjZBsEKM1LYBdC8meRa6ClkNJibMx2cQEP/5yMN+ziyot72/bCt+5qQigd9/rqIeR5F/dGxNYXYz5qR/ePTTxBSda2S9F5SfzCoTzo7ZI4z5OfyxU+OOVKm+UUoAKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tL1MY-0003vw-Eh; Tue, 10 Dec 2024 15:37:22 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tL1MV-002hsm-1M;
	Tue, 10 Dec 2024 15:37:20 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C85D438AD15;
	Tue, 10 Dec 2024 14:37:19 +0000 (UTC)
Date: Tue, 10 Dec 2024 15:37:19 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, "Felipe Balbi (Intel)" <balbi@kernel.org>, 
	Raymond Tan <raymond.tan@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com
Subject: Re: [PATCH v4 1/2] can: m_can: set init flag earlier in probe
Message-ID: <20241210-rational-abiding-guppy-0160a3-mkl@pengutronix.de>
References: <e247f331cb72829fcbdfda74f31a59cbad1a6006.1728288535.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vu3xl5bvkrkbjz26"
Content-Disposition: inline
In-Reply-To: <e247f331cb72829fcbdfda74f31a59cbad1a6006.1728288535.git.matthias.schiffer@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--vu3xl5bvkrkbjz26
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/2] can: m_can: set init flag earlier in probe
MIME-Version: 1.0

On 07.10.2024 10:23:58, Matthias Schiffer wrote:
> While an m_can controller usually already has the init flag from a
> hardware reset, no such reset happens on the integrated m_can_pci of the
> Intel Elkhart Lake. If the CAN controller is found in an active state,
> m_can_dev_setup() would fail because m_can_niso_supported() calls
> m_can_cccr_update_bits(), which refuses to modify any other configuration
> bits when CCCR_INIT is not set.
>=20
> To avoid this issue, set CCCR_INIT before attempting to modify any other
> configuration flags.
>=20
> Fixes: cd5a46ce6fa6 ("can: m_can: don't enable transceiver when probing")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vu3xl5bvkrkbjz26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdYUhwACgkQKDiiPnot
vG+2Mwf/d/1ZGG027IKEALewD29SddkM73+NCzUXFoLJ84lvUw0YJmQi95XxDzBD
DMNAizgc3WznHAU1j7MJ7af/2fnRGgLmxWGoxvBwqAIcVhvYSAS3IBbIuqXQHo1G
2GPWgYbeCf1nGL8qj7p/3g3As9a0YbZlLv1Ta70XDuU026GUWMLzj0KbnCsk3ol4
hRgEd9IeD5ppgBGw66XVS01b8ONjBGZDWuw+Loqg3T/zn3dx+postey1D71gXsq/
Mo/kyHBAT1CIwzl3aCw1g9TzvdStfCnWSI5TpVBYHfa9hfN1EMHv3HOIaA30NNWr
bXX4XexxyAiVE+VJp3IKk2d7pChULw==
=6+uz
-----END PGP SIGNATURE-----

--vu3xl5bvkrkbjz26--

