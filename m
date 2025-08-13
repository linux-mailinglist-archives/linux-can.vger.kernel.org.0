Return-Path: <linux-can+bounces-4229-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BA7B2453E
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 11:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262E71799AC
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377742D190C;
	Wed, 13 Aug 2025 09:20:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5849271446
	for <linux-can@vger.kernel.org>; Wed, 13 Aug 2025 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076832; cv=none; b=A9k1PTNya1gUMissLjGBEJpcyMbRZsOBqSYshP082tE2Hm8jKSzp0E5q9xsJlK+VhthQueU7rlhRCd+yXoFffUnPeoLg64KWI6A3SYA28ARc6Gb+8qVoI1xvSkWSzL7l20089zdj0PoikMaF5CaNpiAzVinVCkNzY2sn07VXt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076832; c=relaxed/simple;
	bh=6hQGavF1Les8XfZ1xiVJq5F8n4y1WqZcUWuyBZxgyaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqg03wy6yo9Qz/NCYyrME5Q3bONQ53Cd6ZqNp9+f48CQKgT1hFSb5sE4aGYqChE64gzQYsMQ3hS7wsGA+lzTgkibu/Y33kSE2PHWBZwO+LPCLCBO+vAxeSOF2R//wdO2IfPHGdTAyBBk56b5dCozJW09Mk7f0JtanQJwjgQD9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1um7ei-0002z1-Ag; Wed, 13 Aug 2025 11:20:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1um7eh-0004Ef-2V;
	Wed, 13 Aug 2025 11:20:23 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6EA2445697D;
	Wed, 13 Aug 2025 09:20:23 +0000 (UTC)
Date: Wed, 13 Aug 2025 11:20:22 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org, socketcan@esd.eu, 
	Simon Horman <horms@kernel.org>, Olivier Sobrie <olivier@sobrie.be>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/6] can: esd_usb: Fix possible calls to kfree() with NULL
Message-ID: <20250813-crafty-hallowed-gaur-49ddac-mkl@pengutronix.de>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
 <20250811210611.3233202-2-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oefxumb6xoevzno5"
Content-Disposition: inline
In-Reply-To: <20250811210611.3233202-2-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--oefxumb6xoevzno5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/6] can: esd_usb: Fix possible calls to kfree() with NULL
MIME-Version: 1.0

On 11.08.2025 23:06:06, Stefan M=C3=A4tje wrote:
> In esd_usb_start() kfree() is called with the msg variable even if the
> allocation of *msg failed.
>=20
> Move the kfree() call to a line before the allocation error exit label
> out: and adjust the exits for other errors to the new free_msg: label
> just before kfree().
>=20
> In esd_usb_probe() add free_dev: label and skip calling kfree() if
> allocation of *msg failed.
>=20
> Fixes: fae37f81fdf3 ( "net: can: esd_usb2: Do not do dma on the stack" )
> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>
> ---
>  drivers/net/can/usb/esd_usb.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
> index 27a3818885c2..05ed664cf59d 100644
> --- a/drivers/net/can/usb/esd_usb.c
> +++ b/drivers/net/can/usb/esd_usb.c
> @@ -3,7 +3,7 @@
>   * CAN driver for esd electronics gmbh CAN-USB/2, CAN-USB/3 and CAN-USB/=
Micro
>   *
>   * Copyright (C) 2010-2012 esd electronic system design gmbh, Matthias F=
uchs <socketcan@esd.eu>
> - * Copyright (C) 2022-2024 esd electronics gmbh, Frank Jungclaus <frank.=
jungclaus@esd.eu>
> + * Copyright (C) 2022-2025 esd electronics gmbh, Frank Jungclaus <frank.=
jungclaus@esd.eu>
>   */
> =20
>  #include <linux/can.h>
> @@ -746,21 +746,22 @@ static int esd_usb_start(struct esd_usb_net_priv *p=
riv)

	msg =3D kmalloc(sizeof(*msg), GFP_KERNEL);
	if (!msg) {
		err =3D -ENOMEM;
		goto out;
	}

Can you adjust the jump label for the kmalloc() fail. There's no need to
check for -ENODEV

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--oefxumb6xoevzno5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmicWNMACgkQDHRl3/mQ
kZwh3Qf/RB9+gOBjCWvTRiM3ipbnCVbvA26FiIq6P9ShGsqQv2Q81IBm6qe0dark
baRtztdnu5k16f6kd2p3+TdLKVZRqwi/PpCL5GalfzOvpcdVkOhsk6LOYTw4yJ36
1CUJdOzgxq8boRiqYxZJ+TFguE8Hq7+c9zmSEzqvWmDi8VDEbw8UCkhXj5+tJG9A
DI0Ep2PeVOuhJOUDnKxQPEqZBAdWIlLjvFverr/6BAj9eG3+mT/rlgPHDk3t+zKP
vUTGF4big47C8L/8D1jOvMMj7ZJ8R/iJl601Xh9n4wxcVq71A54Tkxh6L2EhQ7yK
E7OyeWQEPQcORkWwny4+yNDEljqZCg==
=kmi1
-----END PGP SIGNATURE-----

--oefxumb6xoevzno5--

