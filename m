Return-Path: <linux-can+bounces-5233-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB389BF0830
	for <lists+linux-can@lfdr.de>; Mon, 20 Oct 2025 12:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E7F1881782
	for <lists+linux-can@lfdr.de>; Mon, 20 Oct 2025 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCA41E9919;
	Mon, 20 Oct 2025 10:21:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0221E5714;
	Mon, 20 Oct 2025 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955719; cv=none; b=nrw9Kk3kg0HqA1ATSG6hiXO/YxDfblZ8QkKlIRE1p3tsB+7xhcXyVo8LrZrx4hlh+NtwnGNiwkq9/5AhpqLXAL/jw7mKstcGPii4wPtc3K180vvXeMOYMjcbBP789k24h4K+Qp+0/WEKGy6eNg4IqIdP7Lmj12nohNdOtKMGJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955719; c=relaxed/simple;
	bh=dsoMH9dpVO4k1M1W6qBL5U7xyB+KeAg4WZc1Ph2feA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBf+svzo953YhWobci1IznmDs+f8VpATsogVcVqd4gIM3KBGDtNWHWEwB4IMJPuyqEtOv0hxeDV4NtXTIHYMNwk0CRzc7+WiUdySM5VSGfaKvqc/dj+Dhz6jwevu3RyyZK3WogBtrxVMozxIk9ti+qCIIiarH0uDdFsNd8IJu18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackshift.org; spf=pass smtp.mailfrom=blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackshift.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:102:af0a:700:2ac1:489:378:697b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id D714A76465F;
	Mon, 20 Oct 2025 10:12:17 +0000 (UTC)
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5AEE848B06D;
	Mon, 20 Oct 2025 10:12:17 +0000 (UTC)
Date: Mon, 20 Oct 2025 12:12:15 +0200
From: Marc Kleine-Budde <mkl@blackshift.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Andrei Lalaev <andrey.lalaev@gmail.com>, mailhol.vincent@wanadoo.fr, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [RFC PATCH] can: gs_usb: fix kernel oops during restart
Message-ID: <20251020-aspiring-agama-of-agreement-6d1727-mkl@blackshift.org>
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

