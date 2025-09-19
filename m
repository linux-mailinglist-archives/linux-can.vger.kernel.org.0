Return-Path: <linux-can+bounces-4761-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C85DB8B08F
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 21:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A4D5A2F36
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 19:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778FD26FD9D;
	Fri, 19 Sep 2025 19:04:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A4919DF4A
	for <linux-can@vger.kernel.org>; Fri, 19 Sep 2025 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308650; cv=none; b=rNQL/PX+aVh12SyAQgGZH6nmdpK5uNCuo+82S1ODiern0Cp0Ti/GMr14tpkGKTIrHqKgEqbiINnLkVQ2WGey8DdtlrVYTV2v9YavbdATdgIXuLhYhSIuNL9eMT7o+fF37AAG3Go8YU2CRGuhRJ3PwNW1DryQUP7ee8M5SumG/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308650; c=relaxed/simple;
	bh=NW8nGzciBK2UY5TvnjgoXCb2Hp+6NHK9jXn07Tf3dio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6Tid2cUgeJrfTUGH2gDoahy+EldueJ3+dD5YqVEuUJ7wmr2JkqWvZWHn1a2y/bCxGwMPvMaF5VPY/bHSdfgtbkxe2xGTveHf/XsERSOTtskLz1+ANeB5vXgVQNETpMMJyHdZkDz/oaPsD1PnzFouQACa86ZtGrtf1QhhtXv97I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzgOp-00026Z-CN; Fri, 19 Sep 2025 21:04:03 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzgOn-0029YZ-1s;
	Fri, 19 Sep 2025 21:04:01 +0200
Received: from pengutronix.de (ip-185-104-138-125.ptr.icomera.net [185.104.138.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A27B74751DB;
	Fri, 19 Sep 2025 19:04:00 +0000 (UTC)
Date: Fri, 19 Sep 2025 21:03:59 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andrea Daoud <andreadaoud6@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Possible race condition of the rockchip_canfd driver
Message-ID: <20250919-lurking-agama-of-genius-96b832-mkl@pengutronix.de>
References: <CAOprWosSvBmORh9NKk-uxoWZpD6zdnF=dODS-uxVnTDjmofL6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gge37mtwq6wtzjdu"
Content-Disposition: inline
In-Reply-To: <CAOprWosSvBmORh9NKk-uxoWZpD6zdnF=dODS-uxVnTDjmofL6g@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gge37mtwq6wtzjdu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Possible race condition of the rockchip_canfd driver
MIME-Version: 1.0

Hello,

On 18.09.2025 20:58:33, Andrea Daoud wrote:
> I'm using the rockchip_canfd driver on an RK3568. When under high bus
> load, I get
> the following logs [1] in rkcanfd_tx_tail_is_eff, and the CAN bus is unab=
le to
> communicate properly under this condition. The exact cause is currently n=
ot
> entirely clear, and it's not reliably reproducible.

Our customer is using a v3 silicon revision of the chip, which doesn't
this workaround.

> In the logs we can spot some strange points:
>=20
> 1. Line 24, tx_head =3D=3D tx_tail. This should have been rejected by the=
 if
> (!rkcanfd_get_tx_pending) clause.
>=20
> 2. Line 26, the last bit of priv->tx_tail (0x0185dbb3) is 1. This means t=
hat the
> tx_tail should be 1, because rkcanfd_get_tx_tail is essentially mod the
> priv->tx_tail by two. But the printed tx_tail is 0.
>=20
> I believe these problems could mean that the code is suffering from some =
race
> condition. It seems that, in the whole IRQ processing chain of the driver,
> there's no lock protection. Maybe some IRQ happens within the execution of
> rkcanfd_tx_tail_is_eff, and touches the state of the tx_head and tx_tail?
>=20
> Could you please have a look at the code, and check if some locking is ne=
eded?

My time for community support is currently a bit limited. I think this
has to wait a bit, apologies :/

regards,
Marc=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gge37mtwq6wtzjdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjNqRoACgkQDHRl3/mQ
kZyo+Qf/T3m3vtjMMPeAzZSo9sBY5Ua+T7LYK3oU4OfY2FXjMwtwj7KG1YlMzZfB
EnKx8YEiYzxOsDhgPPMATwByRfx4MDXOTmpP/VkU6+bQJsNbJ5uox/LR56/Ss8wU
kiB1pcPpvnqaxLiVGStJ1Hy/LyKACHaKsXsFiBiUDCCovrz6Ogk1NTp9s5sa5HZC
piCOg4cdZqaNlC7P2tBa1hU9HrkdUn/bP+VYqdzzk85Z0DFsCi3WpdMkN/Dhymf+
eOoJ7pRSoKbUAiO+OMoGtxYgjtNKHW1GYhg3Q6BuLn+OFoNhigDhoeF62IJpGofO
lJKKMXeaO9WXM4ryfvXl6ra4MYxvSg==
=R78M
-----END PGP SIGNATURE-----

--gge37mtwq6wtzjdu--

