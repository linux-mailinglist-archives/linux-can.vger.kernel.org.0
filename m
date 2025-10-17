Return-Path: <linux-can+bounces-5201-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8738ABE7328
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 10:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BE11AA16B7
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 08:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B406B296BB4;
	Fri, 17 Oct 2025 08:34:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CA329ACEE
	for <linux-can@vger.kernel.org>; Fri, 17 Oct 2025 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690093; cv=none; b=qjXnqwH9r5zlO12DZppfW87hdABwE8awkJvQo0hprD60GpvplSsV1v2PwiXHM/bzLB1BRbXBrzf4DX3YMroShehO0i83x8SY3XLWzHH34Gn8tNHcb8+YxNxOlyJVrqbJhCuQbSXKM5fK2L7vBFg3htguwez3XO7vv7cWaCz5Qbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690093; c=relaxed/simple;
	bh=ZYFWlfVM9p4mPmv77EzBu7ebgttLvW0BaITgV2fZhFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L47bzhSw+d5p8oZtUCVNEQr7k4lGKp3IqCV0iydXGpLZmRRvKNQUxMbCOysRMqexOSXdWlPvrzbHQVXbAR3zB9em6YvmlFDARBJEr8m52slutOF22QgY1mgemsI9+5WqF+5We+55bDPKZ4nzOYyjQIrd8qKwCqRLsQLNsIo7MpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9fv8-0001Er-AB; Fri, 17 Oct 2025 10:34:42 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9fv7-0041up-1q;
	Fri, 17 Oct 2025 10:34:41 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A5037488DA2;
	Fri, 17 Oct 2025 08:28:38 +0000 (UTC)
Date: Fri, 17 Oct 2025 10:28:38 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, Robert Nawrath <mbro1689@gmail.com>, 
	Minh Le <minh.le.aj@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] can: dev: can_dev_dropped_skb: drop CAN FD skbs if
 FD is off
Message-ID: <20251017-determined-jackdaw-of-painting-e2ff64-mkl@pengutronix.de>
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
 <20251013-canxl-netlink-v1-1-f422b7e2729f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kzeksx7g66zyfwwf"
Content-Disposition: inline
In-Reply-To: <20251013-canxl-netlink-v1-1-f422b7e2729f@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kzeksx7g66zyfwwf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/9] can: dev: can_dev_dropped_skb: drop CAN FD skbs if
 FD is off
MIME-Version: 1.0

On 13.10.2025 20:01:23, Vincent Mailhol wrote:
> Currently, the CAN FD skb validation logic is based on the MTU: the
> interface is deemed FD capable if and only if its MTU is greater or
> equal to CANFD_MTU.
>=20
> This logic is showing its limit with the introduction of CAN XL. For
> example, consider the two scenarios below:
>=20
>   1. An interface configured with CAN FD on and CAN XL on
>=20
>   2. An interface configured with CAN FD off and CAN XL on
>=20
> In those two scenarios, the interfaces would have the same MTU:
>=20
>   CANXL_MTU
>=20
> making it impossible to differentiate which one has CAN FD turned on
> and which one has it off.
>=20
> Because of the limitation, the only non-UAPI-breaking workaround is to
> do the check at the device level using the can_priv->ctrlmode flags.
> Unfortunately, the virtual interfaces (vcan, vxcan), which do not have
> a can_priv, are left behind.
>=20
> Add a check on the CAN_CTRLMODE_FD flag in can_dev_dropped_skb() and
> drop FD frames whenever the feature is turned off.
>=20
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

What about merging both can_dev_dropped_skb() an
can_dropped_invalid_skb() in the skb.c, so that there is no stub in the
header file anymore.

Someone (i.e. me) used can_dropped_invalid_skb() in a driver, that means
the check for CAN_CTRLMODE_LISTENONLY is missing :/ (I'll send a fix).

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kzeksx7g66zyfwwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjx/jIACgkQDHRl3/mQ
kZwAcAf+KYQBiRZQxXmER1iYmGFEJtTy42LYexZFEnNa9vBjwM/t8bkv36+fMctp
dVWP92QmuWulv4ec9aN4n6e8TVw9DMtC+JnAKbdhE3itR/3FX0iHt5hTf4qV0Bve
nvDvP3iBir41BJyFZswj3cdpatbnIM+nJtLeYz/t/xwkZdgMD/CiM2tfwW3mY1Cd
Lf0F1AaUwKWVvoHGI/fHFfHC3bWaEBEu+BQ4ZC0Ek1slpwBqCGKVBgbSDSSHtBlO
lDpDbGHDR2tYcfMPDLtRnbr9T/YVqr8KWbzkkvZw96Ve5FEl0JmANSAlanepsqdB
94/lWHlDpWOReDgZWaFX6vfLRljMVA==
=ylWo
-----END PGP SIGNATURE-----

--kzeksx7g66zyfwwf--

