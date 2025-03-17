Return-Path: <linux-can+bounces-3138-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80256A65191
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 14:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7824A3A7CF9
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 13:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B1B1487E1;
	Mon, 17 Mar 2025 13:45:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFAC14A4E0
	for <linux-can@vger.kernel.org>; Mon, 17 Mar 2025 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219132; cv=none; b=TG4GUMBaMsIoLYQ8WxV0lEijxTZ3tgQdRGwVB3gSXi3F4gesN0DIOpmVFWHjIJvJcsY1bSxs+FfNlPXKnmRX7P/3iuuYVb1QKyQLQkWxPdUW1irEfHwtcISehukZiNFxS9GYpjb6vgEohAh3uAr6RRZXJI7b5LIie9JPD01gjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219132; c=relaxed/simple;
	bh=xAZ8W2dFleCKJ+lxm1jLCdRJR3vccWm9ZuUTb1oM428=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=titXX8WjjQas8Zm9Tv0fIe4rF7fjd/nxGzkPznvmw1/o2MHpTY0cMZBpW7gteGXGPeKoOmXQ1UcH8y3EZsUQj8JzC4uQsUZ/qBUaqoHlUwVKpf+c1G9Kqpx0vbCr9uLE8ToigZq40MUuzYs0bkQaOLad/YT/02T11PnQrlaLcSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tuAmR-00087E-N9; Mon, 17 Mar 2025 14:45:23 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tuAmQ-000GII-1T;
	Mon, 17 Mar 2025 14:45:22 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7A70E3DEA85;
	Mon, 17 Mar 2025 13:45:22 +0000 (UTC)
Date: Mon, 17 Mar 2025 14:45:22 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, "biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: RE: [PATCH v5 07/16] can: rcar_canfd: Add rnc_field_width
 variable to struct rcar_canfd_hw_info
Message-ID: <20250317-imperial-crafty-mandrill-5b1cc2-mkl@pengutronix.de>
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
 <20250317123619.70988-8-biju.das.jz@bp.renesas.com>
 <20250317-carmine-wolverine-of-discussion-a45336-mkl@pengutronix.de>
 <TY3PR01MB1134685CB81B52D7717B3768186DF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k3pig72gjtcnnl5l"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB1134685CB81B52D7717B3768186DF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--k3pig72gjtcnnl5l
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: [PATCH v5 07/16] can: rcar_canfd: Add rnc_field_width
 variable to struct rcar_canfd_hw_info
MIME-Version: 1.0

On 17.03.2025 13:32:37, Biju Das wrote:
> Hi Marc,
>=20
> Thanks for the feedback.
>=20
> > -----Original Message-----
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> > Sent: 17 March 2025 12:52
> > Subject: Re: [PATCH v5 07/16] can: rcar_canfd: Add rnc_field_width vari=
able to struct
> > rcar_canfd_hw_info
> >=20
> > On 17.03.2025 12:36:01, Biju Das wrote:
> > > R-Car Gen4 packs 2 RNC values in a 32-bit word, whereas R-Car Gen3
> > > packs up to 4 values in a 32-bit word. Handle this difference by
> > > adding rnc_field_width variable to struct rcar_canfd_hw_info and
> > > update the macro RCANFD_GAFLCFG.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > v5:
> > >  * New patch.
> > > ---
> > >  drivers/net/can/rcar/rcar_canfd.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/can/rcar/rcar_canfd.c
> > > b/drivers/net/can/rcar/rcar_canfd.c
> > > index 32d700962d69..924a116cd9ab 100644
> > > --- a/drivers/net/can/rcar/rcar_canfd.c
> > > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > > @@ -85,6 +85,7 @@
> > >  		((gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0)))
> > >
> > >  /* AFL Rx rules registers */
> > > +#define RCANFD_RNC_PER_REG(gpriv)	(32 / (gpriv)->info->rnc_field_wid=
th)
> >=20
> > Nitpick/micro optimization:
> >=20
> > Rename that to something like rnc_stride and put in value you need, i.e.
> > 1 or 2.
>=20
> you mean to drop the macro RCANFD_RNC_PER_REG and instead use .rnc_stride=
 to store
> the values {2 , 4} and avoid runtime computations (32 / rnc_field_width)??

ACK. And the values I gave as example were not correct, as you've only
field width of 8 and 16.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--k3pig72gjtcnnl5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfYJ2wACgkQDHRl3/mQ
kZznIwf/XRU7BDTLFBVfPSm1KqKDGHW2SPd/scKAZrw475l9URPIAM47qUuFdv6x
xm3hw1MBxr/eHwg4yqSsbwOyqw1QYC9pIm0mRt5RznAL97/dFNbGPJSrnwHoKoul
vJtcAhFcmVq6DLwrdWoNlAPnDi75n9eZoZ6VBjPPRMEZSEyxuOZ9XCGrqi/07ytY
VfD6svNhaEYiQrFli6p78ckq9St+DHDI21MKYfj1dxDa0jCogJVh9LlaF9Ed5sO9
Ofs3om/UG6ZxrAf+2qcyodVVj6Iq054LjP8CeetYw7wfdGwuQQmIpBcv2cI1NgfJ
5F+SYDzF98ynihWzSwpSzU6IuaeUSg==
=NfoW
-----END PGP SIGNATURE-----

--k3pig72gjtcnnl5l--

