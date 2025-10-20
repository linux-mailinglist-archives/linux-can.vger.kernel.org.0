Return-Path: <linux-can+bounces-5232-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EC8BF07F1
	for <lists+linux-can@lfdr.de>; Mon, 20 Oct 2025 12:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69B554F13A6
	for <lists+linux-can@lfdr.de>; Mon, 20 Oct 2025 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BF42F5A02;
	Mon, 20 Oct 2025 10:17:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5682F6579
	for <linux-can@vger.kernel.org>; Mon, 20 Oct 2025 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955467; cv=none; b=jatczHF5kbIOB5M/56CUkyj8g3M4r3IY+LDb+D9OPZ1+CEIPXDMRPWImuWU0odnvgHihZI0x5gSlmJKLe/KnAo43GVb9eiPmbPHERcbIu5+BOBu4EdBWbLoXjUVIhZ31N925ou3ldBSQYd/ZUHqaMwCCIig2wc0g3IU9+QCd6kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955467; c=relaxed/simple;
	bh=dsoMH9dpVO4k1M1W6qBL5U7xyB+KeAg4WZc1Ph2feA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni2Qm1NWU0rdH9f65AWsWCtsg6EIs+NuBfXLAhA9+b1tJFH4C5Z4FPGDNE0gGrOb5x9Qax8/aCGQQ3DGRVWZ6NKSAC5F7KHLGRXs8TjjDMGFqokJsnhGI6vrCqi3aPi2WhuoA5DasU5pYiron1mA98vOeIIDRXLZKlxkWcFmtTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vAmxQ-0001Qk-Qy
	for linux-can@vger.kernel.org; Mon, 20 Oct 2025 12:17:40 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vAmxQ-004Wt2-21
	for linux-can@vger.kernel.org;
	Mon, 20 Oct 2025 12:17:40 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5C39B48B07D
	for <linux-can@vger.kernel.org>; Mon, 20 Oct 2025 10:17:40 +0000 (UTC)
Resent-From: Marc Kleine-Budde <mkl@pengutronix.de>
Resent-Date: Mon, 20 Oct 2025 12:17:40 +0200
Resent-Message-ID: <sbvpia5cndz4tm2yh7wczrz7q3jpud4k3ifl636bb5ymuzcyhx@6bmzdq3mv3p6>
Resent-To: linux-can@vger.kernel.org
Date: Mon, 20 Oct 2025 12:12:17 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Andrei Lalaev <andrey.lalaev@gmail.com>, mailhol.vincent@wanadoo.fr, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [RFC PATCH] can: gs_usb: fix kernel oops during restart
Message-ID: <20251020-certain-arrogant-vole-of-sunshine-141841-mkl@pengutronix.de>
References: <20250714175520.307467-1-andrey.lalaev@gmail.com>
 <20250715-almond-zebra-of-perception-9d2e6c-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6flxl23ofa67og72"
Content-Disposition: inline
In-Reply-To: <20250715-almond-zebra-of-perception-9d2e6c-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--6flxl23ofa67og72
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] can: gs_usb: fix kernel oops during restart
MIME-Version: 1.0

On 15.07.2025 11:37:15, Marc Kleine-Budde wrote:
> What about this fix?
>=20
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 13826e8a707b..94603c9eb4aa 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -285,6 +285,12 @@ static int can_changelink(struct net_device *dev, st=
ruct nlattr *tb[],
>          }
> =20
>          if (data[IFLA_CAN_RESTART_MS]) {
> +                if (!priv->do_set_mode) {
> +                        NL_SET_ERR_MSG(extack,
> +                                       "device doesn't support restart f=
rom Bus Off");
> +                        return -EOPNOTSUPP;
> +                }
> +

Damn. This causes a regression on systemd-network:

| systemd-networkd[1532939]: can0: Failed to set CAN interface configuratio=
ns: Device doesn't support restart from Bus Off. Operation not supported
| systemd-networkd[1532939]: can0: Failed
| systemd-networkd[1532939]: can0: Trying to reconfigure the interface.
| systemd-networkd[1532939]: can0: Reconfiguring with /etc/systemd/network/=
90-can.network.

Since v258-rc1 restart delays of 0 are configured, prior to this, they
were ignored.

I'll send a fix that allows configuring a restart delay of 0, even if
the device doesn't have a restart handler.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6flxl23ofa67og72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmj2CvsACgkQDHRl3/mQ
kZzOSAgAjpzrU8+fjVkgLEjaAc3ZqGwXIYjGq4YpaamsC1jY96P886QYBi985VK6
Dpjda4aSe6zzLzCVf/bfGDRILpmiSA/Q+tk2SlJ6raH3YNdHOJ9YlWWVLiLOJYVH
g/Rt65RMhywaS4AHfsa4YnTsv89v4rw6yVU/5sqtedPCtHPR9yA7cztAOgwzWHQA
p6ix3xBz8Go7OvQ66wnSGYujtQwayKuWqaDLbHKjHL8wy0oXhMrF/63D753562sY
DOnEoEnMxo6SSNz9nhAVF0RZ9QqEViyQFzcbQ/EXEFiGcOWXuQTpAbbwEMdwy45L
rprAH0dSCtKuJ7+ypoqMBUPK2hVBbA==
=z2cn
-----END PGP SIGNATURE-----

--6flxl23ofa67og72--

