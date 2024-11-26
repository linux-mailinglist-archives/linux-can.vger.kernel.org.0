Return-Path: <linux-can+bounces-2226-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4429D94E5
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 10:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FED9B2DB83
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204AD1BD012;
	Tue, 26 Nov 2024 09:42:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6D1BC9EE
	for <linux-can@vger.kernel.org>; Tue, 26 Nov 2024 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614160; cv=none; b=idKMuWJWA2HXsiPupM0/WNxTcJL3WCB60qqvMappAd36aqzvMYKCAW/jddDO69Chy8zOyvsGsQ/cVDAK2eR3wCue0WCkWXBG55OVKlQSUSwvsNpGTp6WtuZBW0c5LMG4n6yh8srQzf1q9oEDgWTolPfzr7yxe9SXxqDwm4HYW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614160; c=relaxed/simple;
	bh=XUd9gUDDpEeLjJL0Dwjl59AMlXDURokArCPyyIb+kxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox+AurHP1lukV4VYL3x3m3wy+yC5LIw0YNCP+Rt0jJArK5+zuhOeIiY5H3aiJ6DMDTrZfMNWg4oKFYRkqKHzBlGYQCzJG52cq1nzQ89EEWfi0ZzLbpnxIXlYKMBQu1RqD0sCBCIZzZ6VKRx1Ltejfx17EL+C4wdJ39zCb/fc3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFs58-00008u-Oh; Tue, 26 Nov 2024 10:42:06 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFs52-000E6C-23;
	Tue, 26 Nov 2024 10:42:01 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EE9F937D855;
	Tue, 26 Nov 2024 09:42:00 +0000 (UTC)
Date: Tue, 26 Nov 2024 10:42:00 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Akshay Bhat <akshay.bhat@timesys.com>, Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Chen-Yu Tsai <wens@csie.org>, "David S. Miller" <davem@davemloft.net>, 
	Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
	Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Marek Vasut <marex@denx.de>, Maxime Ripard <mripard@kernel.org>, 
	Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, Samuel Holland <samuel@sholland.org>, 
	Sebastian Haas <haas@ems-wuensche.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Varka Bhadram <varkabhadram@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfgang Grandegger <wg@grandegger.com>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 00/12] Fix {rx,tx}_errors CAN statistics
Message-ID: <20241126-gigantic-intelligent-wallaby-2155eb-mkl@pengutronix.de>
References: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oinnd7mmrbpyaeoz"
Content-Disposition: inline
In-Reply-To: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--oinnd7mmrbpyaeoz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 00/12] Fix {rx,tx}_errors CAN statistics
MIME-Version: 1.0

On 22.11.2024 23:15:41, Dario Binacchi wrote:
> This series extends the patch 4d6d26537940 ("can: c_can: fix {rx,tx}_erro=
rs statistics"),
> already merged into the mainline, to other CAN devices that similarly do
> not correctly increment the error counters for reception/transmission.

I've re-phrased the commit messages of the earlier patches to imperative
language.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--oinnd7mmrbpyaeoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdFl+UACgkQKDiiPnot
vG/v6gf+PSVM1BCLp+8U3Ib5fPjv56qhSELaMQwnseETdpOhezRKYuUyLYp/qxhZ
zCEkFwcei3zNxlbepUdkP7ln/j05Cwavz1akIZ9arFAz7idBGqPQphF55JWJZggV
peQpmEX6YAVG2xYe/vTNgBE57FFXYtFcVADihq4UXeQfXh/C6Lm00phWt1JaHe9J
OKdrWp/U7qECbGA5Gh8G+tYbXQilDnrV0iAqdEg8wWAguflcgk3/W5f6KYFrDX9W
dEkcZb+r7bbu1FGx+E3IkyxSbAUvlj94KVak3VzPicJ9j2JQHCqbEM6I90+4Mby4
d/aiV9lt060AIJPrevBXqyNXaI38qA==
=xk6y
-----END PGP SIGNATURE-----

--oinnd7mmrbpyaeoz--

