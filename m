Return-Path: <linux-can+bounces-3259-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A022A74818
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F795167BF3
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1BB214200;
	Fri, 28 Mar 2025 10:21:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C671D7E21
	for <linux-can@vger.kernel.org>; Fri, 28 Mar 2025 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157318; cv=none; b=YPGuzMbzGoA5qn6T4VFZkuE/mXyU0UPC9CCnzTdZ1AOL3LTZTdp8qAshOtE0vbZ2m3U7qeoFpbFJJVkRRP9Y3xVVyqNThKCtzHEGgWQfnpB+i82tSwa4MKBrWAX65ZzZ07VxgiBJAamoL/hS9EjRW6KZpi4R9g6JoQ4FSL9uIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157318; c=relaxed/simple;
	bh=5E8xTt5NsbrIl3C6fpfWzGI8WCrHNrHt7zTd+gWSxKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2gZLlw//2DUo4mD9JjhRYT3RRmcFHBXgNiGrlVUaaQ4yuA22AelwoWSJwPqdRDUjhhx9AC9rpzKAZcX7mBkjnsVXsb1uq3K6X6E3A172lyu09wuy237e+TXOY2A+w/xnvlGLwzu6DKave/0PawsTcVLA81TobsOmZlRvHnpPeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ty6qS-0006vx-FW; Fri, 28 Mar 2025 11:21:48 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ty6qS-0025Ac-0b;
	Fri, 28 Mar 2025 11:21:48 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DD1363E8789;
	Fri, 28 Mar 2025 10:21:47 +0000 (UTC)
Date: Fri, 28 Mar 2025 11:21:47 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros
 in RCANFD_GERFL_ERR
Message-ID: <20250328-clay-grouse-of-calibration-a165b3-mkl@pengutronix.de>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-6-biju.das.jz@bp.renesas.com>
 <40392a70-3be4-4d11-8614-eebd5d9d24a8@wanadoo.fr>
 <TY3PR01MB11346C091544B49A6C160712E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <deffdc35-86cf-4282-ba6d-f36890bf9fcd@wanadoo.fr>
 <TY3PR01MB11346DA97D5F685D96A638DB086A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdUacYqUd_iPk95C3+bc64SeMbDj1=zdfLvuMHFbTRS39w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dlfiiapzcmofp6mq"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUacYqUd_iPk95C3+bc64SeMbDj1=zdfLvuMHFbTRS39w@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--dlfiiapzcmofp6mq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros
 in RCANFD_GERFL_ERR
MIME-Version: 1.0

On 28.03.2025 11:10:23, Geert Uytterhoeven wrote:
> > Gen4 has 8 channels (GENMASK(16, 23)
> > G3E has 6 channels  (GENMASK(16, 21)
> > V4M has 4 channels  (GENMASK(16, 19)
> > V3H_2 has 3 channels (GENMASK(16,18)
> > All other SoCs has 2 channels (GENMASK(16,17)
> >
> > So you mean, I should replace RCANFD_GERFL_EEF0_7 with a
> >
> > Generic one RCANFD_GERFL_EEF(x) GENMASK(16, 16 + (x) - 1) to handle
> > this differences
> >
> > Where x is the number of supported channels(info->max_channels)
> >
> > and then use
> >
> > FIELD_PREP(RCANFD_GERFL_EEF(x), gpriv->channels_mask)
>=20
> Just use
>=20
>     #define RCANFD_GERFL_EEF    GENMASK(23, 16)
>=20
> and
>=20
>     FIELD_PREP(RCANFD_GERFL_EEF, gpriv->channels_mask)
>=20
> As channels_mask can never have bits set for non-existing channels,
> all reserved bits above EEF in the GERFL register will be zero.

That's even better than computing the mask at runtime!

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dlfiiapzcmofp6mq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfmeDkACgkQDHRl3/mQ
kZz1Lgf9HmdNOQRJmAL3Os5ybONV+vLNI9hYg4vGMjZidOLTQFDLJBH4zrj8VMuG
KvtP2n7jja4xUSeFIasmxBKvtV85P1hQ9BiTnmwJp6/y1UNjXXQdn+Z3zva1ioGU
CNfqaoLsAQFzuNc4QmpZT3bbzjxvoFjD40VmH0xOp1RTguPJMpRakaoWddzDfiZd
tZAjfTJV7fFcSnDQkdGEDCqP1+/ySuBDj3/094B5bAkrshFzo7qo3WTP/uiee+wY
U/n7XisMz2Fskos1z08WWZIRReE4CTnUzat751PxmBShBkF/hU6jrv0ESXIwj4ph
nIrWFHcgNKHBaF5x0zHaW1wPkMbxNw==
=coSN
-----END PGP SIGNATURE-----

--dlfiiapzcmofp6mq--

