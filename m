Return-Path: <linux-can+bounces-5106-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5768DBC63CB
	for <lists+linux-can@lfdr.de>; Wed, 08 Oct 2025 20:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D0364E7E9D
	for <lists+linux-can@lfdr.de>; Wed,  8 Oct 2025 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488EF28489E;
	Wed,  8 Oct 2025 18:06:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8421219E98D
	for <linux-can@vger.kernel.org>; Wed,  8 Oct 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759946765; cv=none; b=J8lmpaYSknN8iJToD1LdZ0LOEk6aJ0ev59PFd2wddtxKtOgLflgDc+qe0xt1wuMSmxxYZGNCXAvnYuBb72cfDZvyu7vpm3s/ESsP2ogFiSDENI0sfaLTfO6hKAa52iACEuOGlliBlZPpLRs8eECWWjSUm12WbAl4dwd/UJaxJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759946765; c=relaxed/simple;
	bh=1OGVmkCskoJ5MGHQWE/f0dqeXk7mBBM3atdNNTo9nVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp6qdJPx7amZ2inf8CofDI6EG6B0/Wo+IAscBc+bQe3ywV+yHAcIyZYubfR7egeWyT1Mqs5XcWd32cBJpa7xcZKlSXj8thuohDirSx7yw7MlSa5P+APLdlC5i3r5ovS0XGs3yzs1CQ5X11mJtDy8twp/zsjrcfYQKfjKYyaaxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6YX8-0006Uf-Ob; Wed, 08 Oct 2025 20:05:02 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6YX2-002bby-2j;
	Wed, 08 Oct 2025 20:04:56 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 508514821AD;
	Wed, 08 Oct 2025 18:04:56 +0000 (UTC)
Date: Wed, 8 Oct 2025 20:04:55 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	Max Staudt <max@enpas.org>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
	Ondrej Ille <ondrej.ille@gmail.com>, Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>, 
	socketcan@esd.eu, Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, kernel@pengutronix.de, 
	Heiko Stuebner <heiko@sntech.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>, 
	Yasushi SHOJI <yashi@spacecubics.com>, Ming Yu <tmyu0@nuvoton.com>, 
	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, Michal Simek <michal.simek@amd.com>, linux-can@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] can: treewide: remove can_change_mtu()
Message-ID: <20251008-hallowed-zebu-of-wonder-638a63-mkl@pengutronix.de>
References: <20251003-remove-can_change_mtu-v1-1-337f8bc21181@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ys7jjoslh254pce"
Content-Disposition: inline
In-Reply-To: <20251003-remove-can_change_mtu-v1-1-337f8bc21181@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--7ys7jjoslh254pce
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: treewide: remove can_change_mtu()
MIME-Version: 1.0

On 03.10.2025 12:16:38, Vincent Mailhol wrote:
> can_change_mtu() became obsolete by commit 23049938605b ("can:
> populate the minimum and maximum MTU values"). Now that
> net_device->min_mtu and net_device->max_mtu are populated, all the
> checks are already done by dev_validate_mtu() in net/core/dev.c.
>=20
> Remove the net_device_ops->ndo_change_mtu() callback of all the
> physical interfaces, then remove can_change_mtu(). Only keep the
> vcan_change_mtu() and vxcan_change_mtu() because the virtual
> interfaces use their own different MTU logic.
>=20
> The only functional change this patch introduces is that now the user
> will be able to change the MTU even if the interface is up. This does
> not matter for Classical CAN and CAN FD because their MTU range is
> composed of only one value, respectively CAN_MTU and CANFD_MTU. For
> the upcoming CAN XL, the MTU will be configurable within the
> CANXL_MIN_MTU to CANXL_MAX_MTU range at any time, even if the
> interface is up. This is consistent with the other net protocols and
> does not contradict ISO 11898-1:2024 as having a modifiable MTU is a
> kernel extension.
>=20
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7ys7jjoslh254pce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjmp8QACgkQDHRl3/mQ
kZylYQf/emcrn4U+wDMRPg3cnnX/DTOwyFGlC0GbTPxJZkzn4E0NT1qsY7z/YVhX
7MRCmOjXQ+hVuG2hc8RUN1ynUPZj5j+MdkL82hJuFw5qwAG7USc4wWOWaCXxDuhx
EtlF3EExo+k1BC5OObcREtNlshvVgELeNDLtuTb2HymwGKRkvHgwAmG4i/fhtCFp
UeU1WDDstTpSC+miqpW5XxnWD0iIeQkWaWKw1PJgOkcS9i49Uv1LWkM0qdconmCz
Xw1gHx2l1LR87jxFlFtiHfSH2SQ/yVnYlX3fTT4lvsjMV6swaJyROxlwvOofrCYT
3f3ZZsstGkn+vB61p9pnuXiuTh3vaA==
=c2yg
-----END PGP SIGNATURE-----

--7ys7jjoslh254pce--

