Return-Path: <linux-can+bounces-3021-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6258BA56B6B
	for <lists+linux-can@lfdr.de>; Fri,  7 Mar 2025 16:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA82018822E4
	for <lists+linux-can@lfdr.de>; Fri,  7 Mar 2025 15:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9783D21C9E7;
	Fri,  7 Mar 2025 15:09:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2A2236F0
	for <linux-can@vger.kernel.org>; Fri,  7 Mar 2025 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360183; cv=none; b=FdxuG2MlUxuVjFypiTU4tCxiqr+UVsQd3jEfhHA4klkUxBVuTnTXO+KZluwcJMDhKkVAARVHBhuPaDN4IbYkdmEp210ua+YqMfkpb7MB/s8AAmiEZiNw9lvqlhuZfNyQpO2yKDYuaPvEMadso/3z0GNJ+Zm6AnDhGdR2RqUCkdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360183; c=relaxed/simple;
	bh=nvInyBZ9SIDhwcj6V7u6ISgZ68zr/vHYYkDicntnXXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxEGGOl9nKwcTvJphMHf5Lsg4iUCnq9p+NZ1asPvxfsovlPjnqfmojBNLPIRk8jjv67ar8Zd7EA5O+/51hBNz8MP6WywzlhjunSIkT5uJJEGeYClPur//K3/VMKhF9CATarM8bUxsbsBYsYjwnK05Lz/bfsMMPD9QdqoJVrturc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tqZKK-0002tg-Oh; Fri, 07 Mar 2025 16:09:28 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tqZKJ-004VKm-2N;
	Fri, 07 Mar 2025 16:09:27 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5B79E3D4BA4;
	Fri, 07 Mar 2025 15:09:27 +0000 (UTC)
Date: Fri, 7 Mar 2025 16:09:27 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] can: rcar_canfd: Fix page entries in the AFL list
Message-ID: <20250307-weightless-malkoha-of-experiment-f9926c-mkl@pengutronix.de>
References: <20250220094516.126598-1-biju.das.jz@bp.renesas.com>
 <20250220094516.126598-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdUs=+niOyBW0us=UjZTnqeYjVsLWZSmROndCO8azER=3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ne2omge6bmgxvr5z"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUs=+niOyBW0us=UjZTnqeYjVsLWZSmROndCO8azER=3g@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ne2omge6bmgxvr5z
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] can: rcar_canfd: Fix page entries in the AFL list
MIME-Version: 1.0

On 07.03.2025 15:41:52, Geert Uytterhoeven wrote:
> Hi Biju,
>=20
> On Thu, 20 Feb 2025 at 10:45, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > There are a total of 96 AFL pages and each page has 16 entries with
> > registers CFDGAFLIDr, CFDGAFLMr, CFDGAFLP0r, CFDGAFLP1r holding
> > the rule entries (r =3D 0..15).
> >
> > Currently, RCANFD_GAFL* macros use a start variable to find AFL entries,
> > which is incorrect as the testing on RZ/G3E shows ch1 and ch4
> > gets a start value of 0 and the register contents are overwritten.
> >
> > Fix this issue by using rule_entry corresponding to the channel
> > to find the page entries in the AFL list.
> >
> > Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Thanks for your patch!
>=20
> This finally fixes CAN2 and CAN3 on the White Hawk and White Hawk
> Single development boards based on R-Car V4H with 8 CAN channels
> (the transceivers for CAN4-7 are not mounted), so
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Unfortunately, it does not fix CAN2 and CAN3 on the Gray Hawk Single
> development board, which is based on R-Car V4M with 4 CAN channels.
>=20
> > --- a/drivers/net/can/rcar/rcar_canfd.c
> > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > @@ -787,10 +787,11 @@ static void rcar_canfd_configure_controller(struc=
t rcar_canfd_global *gpriv)
> >  }
> >
> >  static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *g=
priv,
> > -                                          u32 ch)
> > +                                          u32 ch, u32 rule_entry)
> >  {
> >         u32 cfg;
> >         int offset, start, page, num_rules =3D RCANFD_CHANNEL_NUMRULES;
> > +       u32 rule_entry_index =3D rule_entry % 16;
> >         u32 ridx =3D ch + RCANFD_RFFIFO_IDX;
> >
> >         if (ch =3D=3D 0) {
>=20
> The out-of-context code does:
>=20
>                 start =3D 0; /* Channel 0 always starts from 0th rule */
>         } else {
>                 /* Get number of Channel 0 rules and adjust */
>                 cfg =3D rcar_canfd_read(gpriv->base, RCANFD_GAFLCFG(ch));
>                 start =3D RCANFD_GAFLCFG_GETRNC(gpriv, 0, cfg);
>         }
>=20
> After your changes below, "start" is set but never used.

If you don't need this variable anymore, please remove it.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ne2omge6bmgxvr5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfLDCQACgkQDHRl3/mQ
kZy1BggAlWzSaoBsYVWmLWHhyU3Dd4rKAq1LByO9qoGwCqrJVsOECF8aWmp9MXEb
9QeBSXlxUQ+w7Sk/N9NDmfZ1JxKHKM+GRW7nyXe8VdSk2mPcHTlkxZ1Zv4JTYOFW
qvPuBPpWRq6QxEr1suN55jWD6OaRDsF6k6he8BJslgsRCkwveh7e1oj3k6eIUOyV
/maNyCCO0LRqW9Ul8j3N/DCklIABNAGcaJZlLINZWOveHDvnN83YXPe5mv6dKOXM
6kZMje9BsKhN1gnHrciaqT4U/A+wW8A+vv1w9k2b/MDN+u/+Q5vSGlO3cySKBnQT
xMG1UorWo25zTKB9xVgtJ4wfd1S5eA==
=pBDm
-----END PGP SIGNATURE-----

--ne2omge6bmgxvr5z--

