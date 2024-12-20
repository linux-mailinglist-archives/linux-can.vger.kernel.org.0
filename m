Return-Path: <linux-can+bounces-2469-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 450919F91E9
	for <lists+linux-can@lfdr.de>; Fri, 20 Dec 2024 13:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559801897173
	for <lists+linux-can@lfdr.de>; Fri, 20 Dec 2024 12:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2925C1BCA19;
	Fri, 20 Dec 2024 12:06:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD1B1C3027
	for <linux-can@vger.kernel.org>; Fri, 20 Dec 2024 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734696388; cv=none; b=foSkukhIJw71ri/MGfmj+01pzat7WI90/ka8XmuMpz2MiNXBCQ3W9Rv0v+9XrqwqGybQoYqvmSFZCgA8b5HKvt7e+PJaJI35pbE8JR3nxwKS7KCB+zrMeQ3BAzupVafwGpPyqSRhvu8KZXzuBjZzZTVKn/WLJL2nMpL9r0rGWEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734696388; c=relaxed/simple;
	bh=30MbtmhXHnT8ga8C+x5EHziK5ZQ/9D+FcGao4N/6ybo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDQmsCWre0w+7TL6pYs95PqfY3cTVIcJzDl44OfM4UFgFB8JHEhj4rYJ8w/eKVBw0MmOcUv0IKyu//EkugIyUdNxCiqEmyGXGOSW8ZZxyyXee+9Pe2PH9vSGHlLtCVWSe8v19tjxRLBjRgrMRhtiYxADrzPDwUCl/w8HFXZ4vxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tObli-0008UH-Kf; Fri, 20 Dec 2024 13:06:10 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tOblg-004Mzd-0v;
	Fri, 20 Dec 2024 13:06:09 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2E122392EF0;
	Fri, 20 Dec 2024 12:06:06 +0000 (UTC)
Date: Fri, 20 Dec 2024 13:06:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, heiko@sntech.de, 
	cl@rock-chips.com, kever.yang@rock-chips.com, linux-can@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: can: rockchip: add can for RK3576 Soc
Message-ID: <20241219-sapphire-vicugna-of-opposition-be748f-mkl@pengutronix.de>
References: <20241219011159.3357530-1-zhangqing@rock-chips.com>
 <20241219011159.3357530-2-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eudui3nm55akuurq"
Content-Disposition: inline
In-Reply-To: <20241219011159.3357530-2-zhangqing@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--eudui3nm55akuurq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] net: can: rockchip: add can for RK3576 Soc
MIME-Version: 1.0

On 19.12.2024 09:11:58, Elaine Zhang wrote:
> Is new controller:
> Support CAN and CANFD protocol.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Thanks for porting the rk3576 to the mainline driver. Looking at subtle
differences between the IP cores I'm not sure if you want to add it to
the existing driver or have a dedicated driver. But we can decide on
this later. At least the mainline driver has a better structure than
your original downstream driver.

Why was the timestamp register removed from the registers? Previously
the driver supported hardware timestamping. :(

Some general comments here, a more detailed review will follow.

Why have bits been removed from several registers and the remaining ones
moved? That doesn't make it easier for driver developers to cover new IP
cores. :(

Please use FIELD_GET(), FIELD_PREP() macros instead of open coding shift
and mask operations. See rest of the driver.

Have you actually tested this code in both RX and TX direction? I don't
see rkcanfd_handle_tx_int() being called?

What's the purpose of "rockchip,rx-max-data"?

Why do you add "rx_fifo_depth" to "struct rkcanfd_priv"? It's not used
outside of rkcanfd_probe().

Can you configure the IP core for CAN-2.0 only mode, so that it only
receives CAN-2.0 frames only?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--eudui3nm55akuurq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdlXZAACgkQKDiiPnot
vG83mQf/f6DaBGVIT5WusxNppsrY5LvjB2UCWh8j3u0AGBRxOL5ktwa/cZna9O4L
BH0KOBH+K6mUQ6ssME6tH0EYz17DUbaaFnhPjVTRDGAQu0qktLXoFf0cRjiTo4vV
xLLVVPn9++OTYFUQmN+SxWih0MHBK5+HhIUd+HZTw5GGWdt5V+Wh5kkS048slc9E
mP2tspwcyzJaOAXz9zsdxOc540tcT4cfgI8GgzSIFiVtZWoliAEvgHFzNcp6ZZts
GWRSK2Lf/sf6+mmbHNpa0GhG7M6zqu+nC6oVgVuWY23RO6laQvUTSktw0Ek9nq2f
EtgEcqjYtJiSK62wZQ8ijhtgtX6D+Q==
=AKwc
-----END PGP SIGNATURE-----

--eudui3nm55akuurq--

