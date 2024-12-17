Return-Path: <linux-can+bounces-2426-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F99F4AE1
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2024 13:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7CE188B44F
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2024 12:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494301CEEBB;
	Tue, 17 Dec 2024 12:25:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA713A3ED
	for <linux-can@vger.kernel.org>; Tue, 17 Dec 2024 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438341; cv=none; b=bj3SwRW4IIRe/VRemqR93iySnTib8o+QN4tXGcNgz7jGgTmy4IANFb9qIy/lZjsd0XMf/7mh1uPmM2ZOUejxYnwedfBJfcbJY20MNQHglCB8dPadYYdTJGrm4uuhlnbzM4GsMZxspXMCaQjgnwC4naUl8ZBhNZQO8pNsIhO4HnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438341; c=relaxed/simple;
	bh=l9MaQmrYHUS/EDjoAAvoSKVokHoMQH6NxagWTGL+uac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvqriGZksOO+euBl/2Fc/Hk6yayBqx3ptkY10ttMOG/HvPub6L5DyztV7Zty5pS329xrLb8xHCg0ABv+Mll3iFJaCy6oQQbJ9C0OgF3fTbLYPCDisCOWtuo5VZHgcm7+ME1gvVinZYaXL/GrzLUywzYl+Q+GykJXouQneChdfk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tNWdq-0006A2-VZ; Tue, 17 Dec 2024 13:25:34 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tNWdp-003rVG-23;
	Tue, 17 Dec 2024 13:25:34 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1A5C2390711;
	Tue, 17 Dec 2024 12:25:34 +0000 (UTC)
Date: Tue, 17 Dec 2024 13:25:32 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Renjaya Raga Zenta <ragazenta@gmail.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH] can: m_can: m_can_dev_setup(): set CCCR_INIT bit earlier
Message-ID: <20241217-fair-misty-jaybird-2d72f7-mkl@pengutronix.de>
References: <20241217-m_can_fix-v1-1-c043927f6374@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hh6pzxltlur3hrxh"
Content-Disposition: inline
In-Reply-To: <20241217-m_can_fix-v1-1-c043927f6374@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--hh6pzxltlur3hrxh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: m_can: m_can_dev_setup(): set CCCR_INIT bit earlier
MIME-Version: 1.0

On 17.12.2024 13:56:56, Renjaya Raga Zenta wrote:
> When OS reboot, device is still in normal mode. Probing
> will fail with this error message:
>=20
>   refusing to configure device when in normal mode
>   (unnamed net_device) (uninitialized): failed to enable configuration mo=
de
>   Failed registering m_can device -EBUSY
>=20
> The log can be traced, it's from:
>   m_can_dev_setup
>     -> m_can_niso_supported
>       -> m_can_config_enable
>         -> m_can_cccr_update_bits
>=20
> In commit cd5a46ce6fa6 ("can: m_can: don't enable transceiver when
> probing"), m_can_niso_supported() was reworked to call
> m_can_config_enable(). However, in m_can_config_enable(), it's noted
> that CCCR_INIT must be set in order to set CCCR_CCE. The CCCR_INIT
> bit is set later in m_can_dev_setup().
>=20
> To fix the problem, move forcing standby mode (set CCCR_INIT) lines
> before m_can_niso_supported() line in m_can_dev_setup().
>=20
> Fixes: cd5a46ce6fa6 ("can: m_can: don't enable transceiver when probing")
> Signed-off-by: Renjaya Raga Zenta <ragazenta@gmail.com>
> ---
> Link: https://lore.kernel.org/linux-can/20241106123700.119074-1-renjaya.z=
enta@formulatrix.com

Can you check if
https://lore.kernel.org/all/e247f331cb72829fcbdfda74f31a59cbad1a6006.172828=
8535.git.matthias.schiffer@ew.tq-group.com/
fixes your problem?

Marc

> ---
>  drivers/net/can/m_can/m_can.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 533bcb77c9f934e5840b076ded948f8256ad2ad0..9345b181c5e31e1507a4dadc3=
1e5f15545e1dc98 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1685,7 +1685,7 @@ static int m_can_niso_supported(struct m_can_classd=
ev *cdev)
>  static int m_can_dev_setup(struct m_can_classdev *cdev)
>  {
>  	struct net_device *dev =3D cdev->net;
> -	int m_can_version, err, niso;
> +	int m_can_version, err, ret, niso;
> =20
>  	m_can_version =3D m_can_check_core_release(cdev);
>  	/* return if unsupported version */
> @@ -1710,6 +1710,12 @@ static int m_can_dev_setup(struct m_can_classdev *=
cdev)
>  		CAN_CTRLMODE_FD |
>  		CAN_CTRLMODE_ONE_SHOT;
> =20
> +	/* Forcing standby mode should be redundant, as the chip should be in
> +	 * standby after a reset. Write the INIT bit anyways, should the chip
> +	 * be configured by previous stage.
> +	 */
> +	ret =3D m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);

You don't check the return value.

> +
>  	/* Set properties depending on M_CAN version */
>  	switch (cdev->version) {
>  	case 30:
> @@ -1746,11 +1752,7 @@ static int m_can_dev_setup(struct m_can_classdev *=
cdev)
>  		return -EINVAL;
>  	}
> =20
> -	/* Forcing standby mode should be redundant, as the chip should be in
> -	 * standby after a reset. Write the INIT bit anyways, should the chip
> -	 * be configured by previous stage.
> -	 */
> -	return m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
> +	return ret;
>  }
> =20
>  static void m_can_stop(struct net_device *dev)
>=20
> ---
> base-commit: c7d876495ffad298d7f5fa252000c80fd4fd1b74
> change-id: 20241217-m_can_fix-af60055d7c96
>=20
> Best regards,
> --=20
> Renjaya Raga Zenta <ragazenta@gmail.com>
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hh6pzxltlur3hrxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdhbboACgkQKDiiPnot
vG9pTwgAmRevKqcb7Wsx73ouDmJwMV5mB5inhUPeWFnqQ+oxBnzA0n8Mej2XZQdi
fuF4sIOnHsR6e+QO9RfUu1Q1HJXMx97cXsDFFItu+CAWIJcN+MykPy7AqjvM7hAb
1txPolbWvbRCqrAtTeNUFbIIkP/2Yj8vc1jjrm1jH4bZZIvjsWPBWyLNvwpzni1g
JP4X69IQSeWabMxwvuK5lB2JTyNNTbm+N1EL8DxcHyYSMbkxYFmHuZ/wMXwBYKdJ
aeBUixkZH5XLDnivvlRdFt9EBrZ5qUHzs5uxDZ8bmt3iPzUjC+qjy1cAUYhajitB
vULup0jBxH/6lt6D8/gc6WLK8JHEKA==
=uoPf
-----END PGP SIGNATURE-----

--hh6pzxltlur3hrxh--

