Return-Path: <linux-can+bounces-2837-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB21A39A9C
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 12:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422EC17217C
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 11:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AED1A5BA7;
	Tue, 18 Feb 2025 11:18:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340181AF0B7
	for <linux-can@vger.kernel.org>; Tue, 18 Feb 2025 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877539; cv=none; b=fibu2uV107Lw2cEkL4YMb1ckpoclHGOmYaQ4bE/dbkybXXZxkq5DPq6jFXqzWfwNcjHqa3VGMMzAc7RQzXESI4z71SyoPqsVVfFB+10SGhaEScIURb54Ib7sV7nXIDaqbYG90n0S/RSGHp8IVsPQ9ECUgbXEaoaA+YNmbLm0VTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877539; c=relaxed/simple;
	bh=LSgYXBAg0k7yMJvwwS2mIfVZl6S5GBuIKda6/CCNDQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz3xRIhDayXX7SFSiKErWk302tz8ZZKK+oiOXYrdRyfjMFmZ4vehxKN0KEJGqVcUxUYX7IBasYaYvVFPAEpz750KMHOPj0ERSCgFRfOc2wVD5JrJwLNeLxzN0cHC2HVUmVA6Ra4JMNk8S0ThDN0sN7/aHMYE7wOqYsePcc8D4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkLcg-0006P9-LI; Tue, 18 Feb 2025 12:18:42 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkLcg-001aFn-10;
	Tue, 18 Feb 2025 12:18:42 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E7C4B3C5B4A;
	Tue, 18 Feb 2025 11:18:41 +0000 (UTC)
Date: Tue, 18 Feb 2025 12:18:41 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH 00/11] Add support for RZ/G3E CANFD
Message-ID: <20250218-smooth-macaque-of-inquire-45fb87-mkl@pengutronix.de>
References: <20250218105007.66358-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="urlbflbvkkktcvz2"
Content-Disposition: inline
In-Reply-To: <20250218105007.66358-1-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--urlbflbvkkktcvz2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/11] Add support for RZ/G3E CANFD
MIME-Version: 1.0

On 18.02.2025 10:49:50, Biju Das wrote:
> The CAN-FD module on RZ/G3E is very similar to the one on both R-Car V4H
> and RZ/G2L, but differs in some hardware parameters:
>  * No external clock, but instead has ram clock.
>  * Support up to 6 channels.
>  * 20 interrupts.
>=20
> Biju Das (11):
>   clk: renesas: r9a09g047: Add CANFD clock/reset
>   dt-bindings: can: renesas,rcar-canfd: Fix typo in pattern properties
>     for R-Car V4M
>   dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
>   dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
>   can: rcar_canfd: Fix page entries in the AFL list
>   can: rcar_canfd: Add gen4_type variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add only_internal_clks variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Enhance multi_channel_irqs handling
>   can: rcar_canfd: Add RZ/G3E support
>   arm64: dts: renesas: r9a09g047: Add CANFD node
>   arm64: dts: renesas: r9a09g047e57-smarc: Enable CANFD

Please send the dts changes as a separate series, too. They will
probably go mainline via the renesas SoC tree.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--urlbflbvkkktcvz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme0bI4ACgkQDHRl3/mQ
kZxmZwf+Mk+rHH429fFJD5vBzdihzB3OO6lA4u6W0dSLaebC8fZrxvR/+qFsUZXa
ekPKT+YZs74zkz5KwhHQ3WE4G4ABMK46Wp/i9rTNUIsuufFoqt9H3c+Co2fuIxjH
9tDB9Fv81e+F14vVDa5epa/s2gtM9F0skIWyQY3FWO39V4dsf4njaERudiQhGUcU
gtWx+x3q03JiI/dmPNxclRYeyuayyefZ/KYwjxdY6avTx00n9u15vq9A5qyTJldq
v7XXxxpa2tjuymz7uwjlZ8x6cY2X81i1W6JSgHb5sesVUjB+y+usfFgH4k95cJWQ
0rdmfI+SSvGvQtryHlsyAWM0sN7zuw==
=fVPC
-----END PGP SIGNATURE-----

--urlbflbvkkktcvz2--

