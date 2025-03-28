Return-Path: <linux-can+bounces-3258-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 026E5A74817
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925051893738
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255642144A0;
	Fri, 28 Mar 2025 10:21:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102A31D7E21
	for <linux-can@vger.kernel.org>; Fri, 28 Mar 2025 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157265; cv=none; b=qZfrA/8lTNtUUmksh3MFodoO8VKt6/P3MauzsTgbpwgZ8KZqBNhuByN6K2hBPXS8G5JAABGVLDj5z05O2OptMxYlmRpNh89FQDJb5/nhjtMIuS9HIgZWql88jjQkISdtbRGyZJUU+VqE/XmGJZ19APxVW4tX/XzKwRnCCQz2sME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157265; c=relaxed/simple;
	bh=FIqfVmCPKEO2JKFT6OA+t0YCHzqi+ywsJeLk80qvFA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMbV318UYsepR44LuC9ZNTGQD769dyaE/rFK48Or0Z7FTjPD4/Zz8Tvtwhi3Hnl3PtDUKNlLFhSYBeqBKML6eNZGqY+DDSG+lUACbgMtu8HTxU8vJE+PR/BCJd4F+3vmpC2kk2hvIq7qXEwp6a25Noo1/dAUjtI6s3EpZNYmNsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ty6pX-0006ph-Tm; Fri, 28 Mar 2025 11:20:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ty6pW-0025AS-0B;
	Fri, 28 Mar 2025 11:20:50 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B43C13E8786;
	Fri, 28 Mar 2025 10:20:49 +0000 (UTC)
Date: Fri, 28 Mar 2025 11:20:49 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, "biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: RE: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF*
 macros in RCANFD_GERFL_ERR
Message-ID: <20250328-serious-orange-oarfish-3631f1-mkl@pengutronix.de>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-6-biju.das.jz@bp.renesas.com>
 <40392a70-3be4-4d11-8614-eebd5d9d24a8@wanadoo.fr>
 <TY3PR01MB11346C091544B49A6C160712E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <deffdc35-86cf-4282-ba6d-f36890bf9fcd@wanadoo.fr>
 <TY3PR01MB11346DA97D5F685D96A638DB086A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ixudpacwom357zfm"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346DA97D5F685D96A638DB086A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ixudpacwom357zfm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF*
 macros in RCANFD_GERFL_ERR
MIME-Version: 1.0

On 28.03.2025 09:51:43, Biju Das wrote:
> > Yes, it starts at bit 16, but at which bit does it end?
> >=20
> > The GENMASK() helps to document the register names. Of course is works =
if you replace the FIELD_PREP
> > with a left shift, but you are replacing some meaningful information ab=
out the register name, register
> > start bit and end bit by just a start bit value. See? You just lost the=
 register name and end bit
> > info.
> >=20
> > FIELD_PREP() is not only about doing the correct shift but also about d=
ocumenting that you are putting
> > the value into a specific register.
> >=20
> > When reading:
> >=20
> >   FIELD_PREP(RCANFD_GERFL_EEF0_7, gpriv->channels_mask)
> >=20
> > I immediately understand that you are putting the gpriv->channels_mask =
value into the GERFL_EEF0_7
> > register and I can look at the datasheet for details about that GERFL_E=
EF0_7 if I want to.
>=20
> Gen4 has 8 channels (GENMASK(16, 23)
> G3E has 6 channels  (GENMASK(16, 21)
> V4M has 4 channels  (GENMASK(16, 19)
> V3H_2 has 3 channels (GENMASK(16,18)
> All other SoCs has 2 channels (GENMASK(16,17)
>=20
> So you mean, I should replace RCANFD_GERFL_EEF0_7 with a
>=20
> Generic one RCANFD_GERFL_EEF(x) GENMASK(16, 16 + (x) - 1) to handle
> this differences
>=20
> Where x is the number of supported channels(info->max_channels)
>=20
> and then use
>=20
> FIELD_PREP(RCANFD_GERFL_EEF(x), gpriv->channels_mask)

The mask for FIELD_PREP must be compile time constant.

Geert recently posted a series to add non constant helpers:

| https://lore.kernel.org/all/1824412519cb8791ab428065116927ee7b77cf35.1738=
329459.git.geert+renesas@glider.be/

It seems it wasn't applied yet...

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ixudpacwom357zfm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfmd/4ACgkQDHRl3/mQ
kZxrqggAirVpsuhf6kJMSHgUak0dMzjz9ekLF0Vi8qB6xmcK6OH786A+nkAB8kG8
qOZ0wG0/1nZA1+1iFWkI27KZEv5fT1iUNXppBUYSYQk2dztz5M3lNpbkza6xI/or
3f/ro3oSRhErX8OL/iwREX7IajLGECwnJTjO9Jon6rv3bRPVVpQ8cXFLf4kezX/j
0sJPCUTiVivJvS1Jl7Fnl3cczhl2n83dK6LMHMZt/ObmIzF4AiiebacXrivyqzI/
NOCvVDY1d97JXk/R+uzpZ9wgw3nhuStP1hsyvB/lJi1OFWH9ZWhwDXzRhWzUke+p
IbbMUz/M7/FJKKXTfTUEXwHcPEaykQ==
=qcRL
-----END PGP SIGNATURE-----

--ixudpacwom357zfm--

