Return-Path: <linux-can+bounces-830-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 974CB911EE9
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EBE8B21961
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB32F18E20;
	Fri, 21 Jun 2024 08:36:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9863316B3B9
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958972; cv=none; b=HEcQqQaLMbUjfc80Ndd0HYSYiJiZsZpOUJw9tg/XhR0w7GAn3nywP/WUewrE40pR5m9oQepb4xb5HTNvOtnuKItx6YjQ6dTKPJLjBWhUOgO0+DpTOF+Ii3QVodY11T2XxkYXR4F6fpD5cii37uZEZldS6/17rDGkd3oCqG2egy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958972; c=relaxed/simple;
	bh=Ud6uT2u8ipKnq3N0gB5UOQhhwhKjFj6njF2g7a9Pcw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbSECc6gqHB3EI150EgCt1I1A/FmmNDpn6QcI/aE77LEoOIoYT0pUzFuYemhEO9H6KsTQm2zs7DkFZzOzZmNAN98cDxTmdXtm8YmkfCOiVlMf2TjOF1YMKBDNuV1LJpIVwWsVJshWTyKPjw/DNJqbSlkGJ7zD7ESRlCy189+6F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZkd-0000eX-Rv; Fri, 21 Jun 2024 10:36:07 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZkd-003tvp-A7; Fri, 21 Jun 2024 10:36:07 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 073A62EE58B;
	Fri, 21 Jun 2024 08:36:07 +0000 (UTC)
Date: Fri, 21 Jun 2024 10:36:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] can: rcar_canfd: Simplify clock handling
Message-ID: <20240621-sensible-cerulean-pheasant-0a64e7-mkl@pengutronix.de>
References: <cover.1716973640.git.geert+renesas@glider.be>
 <2cf38c10b83c8e5c04d68b17a930b6d9dbf66f40.1716973640.git.geert+renesas@glider.be>
 <CAMZ6RqKZdo1Mk=tY-vqCm0YYr_Qk8m53+LHXqeM+1LL=S=+RqQ@mail.gmail.com>
 <CAMuHMdXV9q2D=Mhfi7s4NBuvivxBap-k_pkm4pUseoUb3SLWqQ@mail.gmail.com>
 <CAMZ6RqK32+i69Rd3qDDNm4cgQa3+m3ikZTbpt5jCGrkNt76+vw@mail.gmail.com>
 <CAMuHMdWCAU7VK97d3yOALpgg7S9+Aa3ZKwC3VVsivUev1iA+Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="53dhbrvpm3du3xed"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWCAU7VK97d3yOALpgg7S9+Aa3ZKwC3VVsivUev1iA+Ag@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--53dhbrvpm3du3xed
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.06.2024 13:38:24, Geert Uytterhoeven wrote:
> > > > > @@ -545,8 +539,8 @@ struct rcar_canfd_global {
> > > > >         struct platform_device *pdev;   /* Respective platform de=
vice */
> > > > >         struct clk *clkp;               /* Peripheral clock */
> > > > >         struct clk *can_clk;            /* fCAN clock */
> > > > > -       enum rcar_canfd_fcanclk fcan;   /* CANFD or Ext clock */
> > > > >         unsigned long channels_mask;    /* Enabled channels mask =
*/
> > > > > +       bool extclk;                    /* CANFD or Ext clock */
> > > > >         bool fdmode;                    /* CAN FD or Classical CA=
N only mode */
> > > >
> > > > Notwithstanding comment: you may consider to replace those two bool=
eans by a:
> > > >
> > > >           unsigned int flags;
> > > >
> > > > This way, no more fields would be needed in the future if more quir=
ks are added.
> > >
> > > Using "unsigned int flags" and BIT(x) flags would increase code size
> > > by 8 bytes (arm/arm64).
> >
> > I am not sure where you derive your figure from, but looking at the pah=
ole:
>=20
> pahole shows the size of data structures.
>=20
> > > Using "unsigned int foo:1" bitfields would increase code size by 16
> > > (arm) or 12 (arm64) bytes.
> > > So as long as we can fit more bools inside the hole, it is more
> > > efficient to do so...
> >
> > I do not get this either. Where did you get your 16 bytes from? If I do:
>=20
> I also looked at code size[*]: while storing bits takes less space than
> storing bytes, processing bits may require more instructions than
> processing bytes (depending on the architecture).
>=20
> [*] size drivers/net/can/rcar/rcar_canfd.o

You have probably used "scripts/bloat-o-meter" from the kernel source
for this, right?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--53dhbrvpm3du3xed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ1O3QACgkQKDiiPnot
vG8ORgf+MupiedbzdTPO56Iu8X2xz1pZy0K1aQr+0oHavCbADhkq5HSGNkFVy+h9
YtB5kS5pyFjBSpAGkpP+o7DWnTIjo49tIYXXb3yaGiR23WSNpBnXgvO8hPNBdUTG
whPxNfG3VgiQ3HCTi9bhEagjbQOjluloBPmRsBUoDoZX1D2NF7an24GjKYY3u5wP
FfCbGSmmla45QV0yLn3cel0XxxTapC4U/SQlgPtcAHk9gflGD7Ga0w66zyWQgAEa
N6Mw4xvHEswqzV++NU+WzTuxS8sn3T9+DqccRxMORoE2xt73LvuMNEMAIhbWk2k+
DnaM8FlXI+N/DxiS8LWdHJJ9c+Ed/A==
=VO/e
-----END PGP SIGNATURE-----

--53dhbrvpm3du3xed--

