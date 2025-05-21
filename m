Return-Path: <linux-can+bounces-3611-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61123ABF0F0
	for <lists+linux-can@lfdr.de>; Wed, 21 May 2025 12:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302751688B7
	for <lists+linux-can@lfdr.de>; Wed, 21 May 2025 10:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A938C25A342;
	Wed, 21 May 2025 10:07:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A3253F3A
	for <linux-can@vger.kernel.org>; Wed, 21 May 2025 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822047; cv=none; b=bi+NVAZTgk8a5ww16LyD4KjNlr/Bm7Lv0L0IanUWvzFjtU2HGyZVtbd6YWYnO2jclbbr4a26a1fZYiD1IFgw0C/nGSRJqoxWPhVn8CmwQwiskElpjW2lH7zGH5qDQ5Oc3XdeKP90yRv2BFWfA6mufmrThdwfdK2tsS9Ts8sOp5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822047; c=relaxed/simple;
	bh=opxaVNb07Rd8axYijuIwX0qLz4PZ5eUnXP+JCXL4XbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4dLCyvy1x9IsoquJZ01iPBUgorGBtBLEYDxFn4xDexREmH9yLirO7YcQjxfE5JhtuHVVwo7C7VnA2ChiB36YKgu/onVAju7eAZZ7+KovsC27ppzJCC60TNghn1UMnK4z3M1DfgBeCaWEAR6DsELjAmmaPP6RsyCyZBl5Pi7H9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uHgLw-0007R6-Sq; Wed, 21 May 2025 12:07:12 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uHgLu-000YT3-1s;
	Wed, 21 May 2025 12:07:10 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009:2000::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A31874167EC;
	Wed, 21 May 2025 10:07:09 +0000 (UTC)
Date: Wed, 21 May 2025 12:07:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Jonathan Corbet <corbet@lwn.net>, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] documentation: networking: can: Document
 alloc_candev_mqs()
Message-ID: <20250521-ancient-discreet-weasel-98b145-mkl@pengutronix.de>
References: <a679123dfa5a5a421b8ed3e34963835e019099b0.1747820705.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sbvuoiedkezuzawe"
Content-Disposition: inline
In-Reply-To: <a679123dfa5a5a421b8ed3e34963835e019099b0.1747820705.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--sbvuoiedkezuzawe
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] documentation: networking: can: Document
 alloc_candev_mqs()
MIME-Version: 1.0

On 21.05.2025 11:51:21, Geert Uytterhoeven wrote:
> Since the introduction of alloc_candev_mqs() and friends, there is no
> longer a need to allocate a generic network device and perform explicit
> CAN-specific setup.  Remove the code showing this setup, and document
> alloc_candev_mqs() instead.

Makes sense.

>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Dunno if this deserves
> Fixes: 39549eef3587f1c1 ("can: CAN Network device driver and Netlink inte=
rface")
>=20
>  Documentation/networking/can.rst | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/networking/can.rst b/Documentation/networking/=
can.rst
> index b018ce346392652b..784dbd19b140d262 100644
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -1106,13 +1106,10 @@ General Settings
> =20
>  .. code-block:: C

This breaks the rst rendering. I think you should remove the "..
code-block:: C"...

> =20
> -    dev->type  =3D ARPHRD_CAN; /* the netdevice hardware type */
> -    dev->flags =3D IFF_NOARP;  /* CAN has no arp */
> +CAN network device drivers can use alloc_candev_mqs() and friends instea=
d of
> +alloc_netdev_mqs(), to automatically take care of CAN-specific setup:

and add a second ":" after "setup:"

> =20
> -    dev->mtu =3D CAN_MTU; /* sizeof(struct can_frame) -> Classical CAN i=
nterface */
> -
> -    or alternative, when the controller supports CAN with flexible data =
rate:
> -    dev->mtu =3D CANFD_MTU; /* sizeof(struct canfd_frame) -> CAN FD inte=
rface */
> +    dev =3D alloc_candev_mqs(...);
> =20
>  The struct can_frame or struct canfd_frame is the payload of each socket
>  buffer (skbuff) in the protocol family PF_CAN.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--sbvuoiedkezuzawe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgtpcgACgkQDHRl3/mQ
kZzZBAf+KobGBApygB4CwC3hCcnYb71xjwgtbkiWO5q4KhXRr930pIva6X5+T98v
pYeIvgWBHWIb+oX+XtODqQ8Oecye/wbxH1vE5/HBlN8MrAWboUUj1By66QpVT8ON
aXipujw3xZ9W0DNEjZC9dNi0HFlNquQnEukbjL/LwpOg4RucG5nDrbMi/JeUU4zi
fw3w1Wn+0Jby2EJViWX0maZauvcFm7sSF2zSPT6T0xcyWHOmPPiE9DoyFv4sZ3a/
zvKjzWxGxByng32iRHDJIbzpMGPy89ws5hdy4os42O1TR4SmwoIfkUpVFYYd8l+B
7GZTZEflFfOdesOsMoN97v4Tgj/D5g==
=WQeM
-----END PGP SIGNATURE-----

--sbvuoiedkezuzawe--

