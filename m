Return-Path: <linux-can+bounces-2093-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 196379D1435
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 16:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E2F1F21790
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE3D1AF0D4;
	Mon, 18 Nov 2024 15:14:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35111A9B51
	for <linux-can@vger.kernel.org>; Mon, 18 Nov 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942874; cv=none; b=pLTWYI+724YTjOSocbY9M4pTCTC9aPQ1fsoIRtmxHj3E7oE96SInmqucz9PaKbuqXW67czRFGRIF6zLpcC4ZNo6NfG9uYyM3Hjejx9tl4o1fY8ABjfFboaU0HG0IrFfbLQdph8pBDnKbPqm3AJqrAq3t48TL+9WgD9koRrksadA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942874; c=relaxed/simple;
	bh=mBqnyF8F99Ri8pipwkHs2XCwUZan8IXCijA7+v397NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckg2q1MOKkzBJqI0TSz0Hxo4MnHrXnNQlQ6ki2wsOVX4oOaRkYHt+X85+qhAZstxmZ1i557Pqufvdgm/pJaBGz93uAXLHCJ5plu7F849gONGAQKbKEEa/vvgh01dMa8cFcr1MEgHAMbTAe+I2DqwMYwSxjvplLFA9wbH73PIJZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tD3S7-0003Be-RU; Mon, 18 Nov 2024 16:14:11 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tD3S6-001PyT-20;
	Mon, 18 Nov 2024 16:14:10 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 35B103765CD;
	Mon, 18 Nov 2024 15:14:10 +0000 (UTC)
Date: Mon, 18 Nov 2024 16:14:09 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH can-next v5 2/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
Message-ID: <20241118-impetuous-mackerel-of-glamour-f482ed-mkl@pengutronix.de>
References: <20241114-tcan-wkrqv-v5-0-a2d50833ed71@geanix.com>
 <20241114-tcan-wkrqv-v5-2-a2d50833ed71@geanix.com>
 <clwiowhd5jwf7uzbcbexelsspdpflqhshq6ev5wsabhuugemlp@bbktuqgjd2gg>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5lc3tcsgin2oixnj"
Content-Disposition: inline
In-Reply-To: <clwiowhd5jwf7uzbcbexelsspdpflqhshq6ev5wsabhuugemlp@bbktuqgjd2gg>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--5lc3tcsgin2oixnj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v5 2/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
MIME-Version: 1.0

On 18.11.2024 16:05:42, Sean Nyekjaer wrote:
> Hi Marc,
>=20
> On Thu, Nov 14, 2024 at 10:14:50AM +0100, Sean Nyekjaer wrote:
> > The nWKRQ pin supports an output voltage of either the internal referen=
ce
> > voltage (3.6V) or the reference voltage of
> > the digital interface 0-6V (VIO).
> > Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.
> >=20
> > If this property is omitted the reset default, the internal reference
> > voltage, is used.
> >=20
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> >  drivers/net/can/m_can/tcan4x5x-core.c | 20 ++++++++++++++++++++
> >  drivers/net/can/m_can/tcan4x5x.h      |  2 ++
> >  2 files changed, 22 insertions(+)
> >=20
> > diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_=
can/tcan4x5x-core.c
> > index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..7213d9894c82d079bf92f1e=
c62d4eebb500cdfa4 100644
> > --- a/drivers/net/can/m_can/tcan4x5x-core.c
> > +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> > @@ -92,6 +92,8 @@
> >  #define TCAN4X5X_MODE_STANDBY BIT(6)
> >  #define TCAN4X5X_MODE_NORMAL BIT(7)
> > =20
> > +#define TCAN4X5X_NWKRQ_VOLTAGE_VIO BIT(19)
> > +
> >  #define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
> >  #define TCAN4X5X_DISABLE_INH_MSK	BIT(9)
> > =20
> > @@ -267,6 +269,13 @@ static int tcan4x5x_init(struct m_can_classdev *cd=
ev)
> >  	if (ret)
> >  		return ret;
> > =20
> > +	if (tcan4x5x->nwkrq_voltage_vio) {
> > +		ret =3D regmap_set_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
> > +				      TCAN4X5X_NWKRQ_VOLTAGE_VIO);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	return ret;
> >  }
> > =20
> > @@ -318,6 +327,15 @@ static const struct tcan4x5x_version_info
> >  	return &tcan4x5x_versions[TCAN4X5X];
> >  }
> > =20
> > +static void tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
> > +{
> > +	struct tcan4x5x_priv *tcan4x5x =3D cdev_to_priv(cdev);
> > +	struct device_node *np =3D cdev->dev->of_node;
>=20
> Guess we can remove this line. Sorry

ACK. Will fixup here.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5lc3tcsgin2oixnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc7Wb8ACgkQKDiiPnot
vG/WZwf/XeUCg+GNtKoHxa7Fx7ZdaV02WLfPg/Ln0FyQOu6eIgXMA55aG+yd/9t0
w6oW5AkGXr1oPHA2ytYNuTVwcZRJev4haqNzHjLosBc41zlO2aNSflvlRanQbF0F
inQBVXdTgKtiW399Df86kTiGfAlH+f8MUqEX4QYcCzF7u0jtVRq95DOYk/CC/45z
ICj8C46MGxJjtnhj7G31UfGtNG3vCabBwct9WJsfk03/8vvAVJ56LIaKPcQPO2T6
SC/0Tru3cTBI6urc+9SddTXgRacACJOHi82e9iS5a9OiCqvc3n/X+C0mgF3wosp3
FlmGZeGKfGFQFCIrmCBioI7lZMcsvg==
=Efuo
-----END PGP SIGNATURE-----

--5lc3tcsgin2oixnj--

