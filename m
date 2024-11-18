Return-Path: <linux-can+bounces-2085-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A224F9D0B4A
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 09:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B6F1F22FF1
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 08:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089D417C224;
	Mon, 18 Nov 2024 08:57:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5D31547E8
	for <linux-can@vger.kernel.org>; Mon, 18 Nov 2024 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920265; cv=none; b=bu82MDgNGUkZRPlpMd9qUllFJV0CgAZrzxI62XvwgltIT3uF5n2pSiW75PEri/dB/stMj41EBwfCMelbTqd9cKvvVRLSyoPo43Mw6MfOMuroVdhI8QV4r2tRmtarizbAeZAcM1pIcy9GXj0pVu3OceQ6DMt+WcReEuX26N8A3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920265; c=relaxed/simple;
	bh=pd0vV6YrjI+3YN9U+/SNmqU/0Mvbed6i2C/mZN+9+E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gliFOk/McCXOtGEg1J7ys67geQg3XnLJjp9GBK1jZEDP+X4Lmf1kx59mPGg5VYUHgGWZ3fcoIsoUpBS5XigLGmxoWgd5s1AlpiPuJW4It1uQG+YP5AQO+yO5XIl1TJJc07cdp2ftl7dlrzAJ3TQSM9t0BdBNsUjq96pXT2ZWfXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tCxZY-0001PD-DS; Mon, 18 Nov 2024 09:57:28 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tCxZW-001MYc-0f;
	Mon, 18 Nov 2024 09:57:26 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 529B0375F45;
	Mon, 18 Nov 2024 08:55:32 +0000 (UTC)
Date: Mon, 18 Nov 2024 09:55:32 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH can-next v5 0/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
Message-ID: <20241118-horned-beautiful-finch-db5770-mkl@pengutronix.de>
References: <20241114-tcan-wkrqv-v5-0-a2d50833ed71@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ef4k4v6jgw3outty"
Content-Disposition: inline
In-Reply-To: <20241114-tcan-wkrqv-v5-0-a2d50833ed71@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ef4k4v6jgw3outty
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v5 0/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
MIME-Version: 1.0

On 14.11.2024 10:14:48, Sean Nyekjaer wrote:
> This series adds support for setting the nWKRQ voltage.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ef4k4v6jgw3outty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc7AQEACgkQKDiiPnot
vG/Jnwf+IKkLE3rizG6Qj6BPTfBWTmEaePsRJxFn2dCItaRyYi/bfnNydXTIEuh7
Z4lbHefEAjLp1pqTfPOwtfxdXjabd3ocvswOeRaMr1Zv2A/VZ2JRqeOtg3nYd97E
4khcEkwQXR0bWb4Fch+lwkKldvNOTxSY/QUC9eCN0hvJ5aeVCjxC35UykuJ8HN/j
DF8l/vesXXO2RhXpxMF6nrr86LuGV+S6pHQvNPvmJ0whBOdmIraMnTRsyftnrNIQ
GQFUGxRNyVbmpcP4pOzPIc2vwAFHK4xG5HRVh/Xisa9XeKkFhjd8U9B+y4gPL16o
mrYYnEb+I+0c/xBAY5yV0bnRIh3Ayg==
=BsHD
-----END PGP SIGNATURE-----

--ef4k4v6jgw3outty--

