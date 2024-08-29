Return-Path: <linux-can+bounces-1233-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A08964F04
	for <lists+linux-can@lfdr.de>; Thu, 29 Aug 2024 21:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5E42811A4
	for <lists+linux-can@lfdr.de>; Thu, 29 Aug 2024 19:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0971B6527;
	Thu, 29 Aug 2024 19:35:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1521AE046
	for <linux-can@vger.kernel.org>; Thu, 29 Aug 2024 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960151; cv=none; b=a23NHPF55NMbYKKQoxchnllicz+X5EvnnxzCqllRCLIeWwm58byvi1BFxXOlic6LJUyeIPdKxIqOWCLJ7I3N35eywyGJEidBum7sCrMiXObVBVGxZEh7+PNISiF3ifPiyUddO1t6bs5XkTW+3W+VDPkpegDFa7cTpyKpePSmyGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960151; c=relaxed/simple;
	bh=DKOoPQzVVaJtEe1bbHlHfP2Zo4nE/kjdZiCkf5ZdWEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYOxNGwLfRvJ3SwXW/H/rRxL3sK9I4oJceQweY1xcrzl6Lx7InRK0HncINkDqiLxy0sZR8M0et/dWX4WECg3db2KgE6gkcXLGr5kX/ZlelsG8RFO9akEHDxSDJR1OjzfREievmrImD12uFr3Cwk2MPt+7n5z8nX96fA0b2cTS0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjkvl-0005NZ-98; Thu, 29 Aug 2024 21:35:41 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjkvk-003z1W-GO; Thu, 29 Aug 2024 21:35:40 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2471832D54F;
	Thu, 29 Aug 2024 19:35:40 +0000 (UTC)
Date: Thu, 29 Aug 2024 21:35:39 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: can: cc770: Simplify parsing DT properties
Message-ID: <20240829-spiked-amigurumi-bloodhound-d94a6c-mkl@pengutronix.de>
References: <20240828131902.3632167-1-robh@kernel.org>
 <20240828161624.GS1368797@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gupfvblu2pdoqihu"
Content-Disposition: inline
In-Reply-To: <20240828161624.GS1368797@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gupfvblu2pdoqihu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.08.2024 17:16:24, Simon Horman wrote:
> On Wed, Aug 28, 2024 at 08:19:02AM -0500, Rob Herring (Arm) wrote:
> > Use of the typed property accessors is preferred over of_get_property().
> > The existing code doesn't work on little endian systems either. Replace
> > the of_get_property() calls with of_property_read_bool() and
> > of_property_read_u32().
> >=20
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>=20
> ...
>=20
> > diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/c=
c770/cc770_platform.c
> > index 13bcfba05f18..9993568154f8 100644
> > --- a/drivers/net/can/cc770/cc770_platform.c
> > +++ b/drivers/net/can/cc770/cc770_platform.c
> > @@ -71,16 +71,9 @@ static int cc770_get_of_node_data(struct platform_de=
vice *pdev,
> >  				  struct cc770_priv *priv)
> >  {
> >  	struct device_node *np =3D pdev->dev.of_node;
> > -	const u32 *prop;
> > -	int prop_size;
> > -	u32 clkext;
> > -
> > -	prop =3D of_get_property(np, "bosch,external-clock-frequency",
> > -			       &prop_size);
> > -	if (prop && (prop_size =3D=3D  sizeof(u32)))
> > -		clkext =3D *prop;
> > -	else
> > -		clkext =3D CC770_PLATFORM_CAN_CLOCK; /* default */
> > +	u32 clkext =3D CC770_PLATFORM_CAN_CLOCK, clkout =3D 0;
>=20
> Marc,
>=20
> Could you clarify if reverse xmas tree ordering - longest line to shortest
> - of local variables is desired for can code? If so, I'm flagging that the
> above now doesn't follow that scheme.

If you touch the code, and noting speaks against it, please make it
reverse xmas.

>=20
> > +
> > +	of_property_read_u32(np, "bosch,external-clock-frequency", &clkext);
> >  	priv->can.clock.freq =3D clkext;
> > =20
> >  	/* The system clock may not exceed 10 MHz */
>=20
> ...
>=20
> > @@ -109,20 +102,16 @@ static int cc770_get_of_node_data(struct platform=
_device *pdev,
> >  	if (of_property_read_bool(np, "bosch,polarity-dominant"))
> >  		priv->bus_config |=3D BUSCFG_POL;
> > =20
> > -	prop =3D of_get_property(np, "bosch,clock-out-frequency", &prop_size);
> > -	if (prop && (prop_size =3D=3D sizeof(u32)) && *prop > 0) {
> > -		u32 cdv =3D clkext / *prop;
> > -		int slew;
> > +	of_property_read_u32(np, "bosch,clock-out-frequency", &clkout);
> > +	if (clkout > 0) {
> > +		u32 cdv =3D clkext / clkout;
> > +		u32 slew;
> > =20
> >  		if (cdv > 0 && cdv < 16) {
> >  			priv->cpu_interface |=3D CPUIF_CEN;
> >  			priv->clkout |=3D (cdv - 1) & CLKOUT_CD_MASK;
> > =20
> > -			prop =3D of_get_property(np, "bosch,slew-rate",
> > -					       &prop_size);
> > -			if (prop && (prop_size =3D=3D sizeof(u32))) {
> > -				slew =3D *prop;
> > -			} else {
> > +			if (of_property_read_u32(np, "bosch,slew-rate", &slew)) {
> >  				/* Determine default slew rate */
> >  				slew =3D (CLKOUT_SL_MASK >>
> >  					CLKOUT_SL_SHIFT) -
>=20
> Rob,
>=20
> The next few lines look like this:
>=20
> 					((cdv * clkext - 1) / 8000000);
> 				if (slew < 0)
> 					slew =3D 0;
>=20
> But slew is now unsigned, so this check will always be false.
>=20
> Flagged by Smatch and Coccinelle.

Good finding.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gupfvblu2pdoqihu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbQzYgACgkQKDiiPnot
vG+0xgf+Jd7TG+Bgy8pVLY4i+WWleeGEDIMUYt57JUHFQe+1FkA3sMA3umuEW2Rd
gH/GlB7jRhCrO69ecd5AjZD33ca3D83E1h/FJbL3vEA9EZp873WzdKcBQL0Gm86O
Kq43+bAKDLOEsSM5N6jd2QqGKfJ8r4EOBG/pMkEj/VeaKZCHOAy+JwhfiYbjtNNk
X2a0EcUJ6gITsBSJ5fRlfviiJsoT7OyMBpmBtuSa/oSaBAnG6wHPNdM/01pxJJZ/
vPfNSnApWhaLBpS2/zdbjFdxy2v0kjb16Y7E2+pT6dVS5ctInkuHVFQDJqEXZ0BR
h+ZwrjjjS2q9uHe31ZdblhSNUp7iQg==
=o3cU
-----END PGP SIGNATURE-----

--gupfvblu2pdoqihu--

