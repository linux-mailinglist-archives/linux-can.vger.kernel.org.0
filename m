Return-Path: <linux-can+bounces-5549-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCFBC78143
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27236363C89
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BABD3314DF;
	Fri, 21 Nov 2025 09:14:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E662BD001
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716471; cv=none; b=G61wreo/TIPIpySTwckx/REOnFTtmgC5vE1d06PgL9lq8daVbR2kiTt339utqx1d5V6YE3HqD0mu7xbiKnO08YN7J/uADBtm6m1HnqSUlBD/p7pQoHw4X/hBx3yJrsF5uWwVz1xHtKh9ZZAtkhTE7gEQlVZEWw6iKgfOo2ZYzTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716471; c=relaxed/simple;
	bh=Qy2IWe5FRVTon1UEFLUbXKbXgrPFg0t6+2/JhtczFjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRG89Zp15E7vHENf9XFXGjye6hitdJ0lvxwMKYoSJPPFKab8tmF9Ubgj1vTS3p14icM90GMG1F1PrV1mqiGanYxvrJEOe/apz9oYFSve1sGJ/oxrQOBrEjcmJpkkI2iSBTBSqUnoqI0a9DFUKEkQ2a2KaiXC4dRiK9M2PmJodO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMNDm-0002vG-UX; Fri, 21 Nov 2025 10:14:26 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMNDm-001Ypm-2M;
	Fri, 21 Nov 2025 10:14:26 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 846214A45EF;
	Fri, 21 Nov 2025 09:14:26 +0000 (UTC)
Date: Fri, 21 Nov 2025 10:14:26 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [canxl v4 08/17] can: bittiming: add PWM validation
Message-ID: <20251121-garnet-ammonite-of-genius-7d6db2-mkl@pengutronix.de>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
 <20251121083414.3642-9-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kzjdemn3rlqf2qfy"
Content-Disposition: inline
In-Reply-To: <20251121083414.3642-9-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kzjdemn3rlqf2qfy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [canxl v4 08/17] can: bittiming: add PWM validation
MIME-Version: 1.0

On 21.11.2025 09:34:05, Oliver Hartkopp wrote:
> From: Vincent Mailhol <mailhol@kernel.org>
>
> Add can_validate_pwm() to validate the values pwms, pwml and pwml.
> Error messages are added to each of the checks to inform the user on
> what went wrong. Refer to those error messages to understand the
> validation logic.
>
> The boundary values CAN_PWM_DECODE_NS (the transceiver minimum
> decoding margin) and CAN_PWM_NS_MAX (the maximum PWM symbol duration)
> are hardcoded for the moment. Note that a transceiver capable of
> bitrates higher than 20 Mbps may be able to handle a CAN_PWM_DECODE_NS
> below 5 ns. If such transceivers become commercially available, this
> code could be revisited to make this parameter configurable. For now,
> leave it static.
>
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev/bittiming.c | 63 +++++++++++++++++++++++++++++++++
>  include/linux/can/bittiming.h   | 22 ++++++++++++
>  2 files changed, 85 insertions(+)
>
> diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittim=
ing.c
> index 0b93900b1dfa..730b1b254460 100644
> --- a/drivers/net/can/dev/bittiming.c
> +++ b/drivers/net/can/dev/bittiming.c
> @@ -1,9 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
>   * Copyright (C) 2006 Andrey Volkov, Varma Electronics
>   * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
> + * Copyright (c) 2025 Vincent Mailhol <mailhol@kernel.org>
>   */
>
>  #include <linux/can/dev.h>
>
>  void can_sjw_set_default(struct can_bittiming *bt)
> @@ -149,5 +150,67 @@ int can_get_bittiming(const struct net_device *dev, =
struct can_bittiming *bt,
>  		return can_validate_bitrate(dev, bt, bitrate_const,
>  					    bitrate_const_cnt, extack);
>
>  	return -EINVAL;
>  }
> +
> +int can_validate_pwm_bittiming(const struct net_device *dev,
> +			       const struct can_pwm *pwm,
> +			       struct netlink_ext_ack *extack)
> +{
> +	const struct can_priv *priv =3D netdev_priv(dev);
> +	u32 xl_bit_time_tqmin =3D can_bit_time_tqmin(&priv->xl.data_bittiming);
> +	u32 nom_bit_time_tqmin =3D can_bit_time_tqmin(&priv->bittiming);
> +	u32 pwms_ns =3D can_tqmin_to_ns(pwm->pwms, priv->clock.freq);
> +	u32 pwml_ns =3D can_tqmin_to_ns(pwm->pwml, priv->clock.freq);
> +
> +	if (pwms_ns + pwml_ns > CAN_PWM_NS_MAX) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "The PWM symbol duration: %u ns may no exceed %u ns",
                                                                       not

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kzjdemn3rlqf2qfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkgLW8ACgkQDHRl3/mQ
kZz/TAf+Ja6ii14zshJgHR4aCvLyGjyj/gv/89z2mmL+yEszlgMaSNGFXrmEbyVs
g2GIXQW2lay4dOrJuU8Y6j/3F8JFW+AZTVmYfqK7UfoqiKkyD6Ozo0BJCLebFHZ4
FoyOvBKhfUa7zBtKjh1febVJ1RKR3KoRfr2tU+M66dfNI2cLrM4nzAplyyLvwZfI
T0Cg63aKatHIJggSoalkhgidO69i1jEcA5hdRwQR97ikfJm5cp9OlUcXWsXSkCj/
GYNT6YhYQzuKEAMOGde7mpAY9nUMwp+MoAO1DP8z1Kc8mKfaR9WkyaWWZa0ihnKI
hC5X/a6GaB6KVRodNoFY5KmCtZI9GA==
=k1SF
-----END PGP SIGNATURE-----

--kzjdemn3rlqf2qfy--

