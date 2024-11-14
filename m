Return-Path: <linux-can+bounces-2042-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64D49C8605
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A5D285FAA
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171431E04BE;
	Thu, 14 Nov 2024 09:24:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1281D1724
	for <linux-can@vger.kernel.org>; Thu, 14 Nov 2024 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576292; cv=none; b=kq4rIjBbmhwi5rWhkwOZvnxx45f1gfjBv77y2xdSRLdAfeR4lqdQq+umwjWtUGYR1AVwd6Bcn7+ZJkXZE6IAFL1yyXNNSWG0OW4bnXucbxIGEmHjbu9juF1WMZEuxvHbX4DDoNe63METLGp91WQr6uCj08QhukiDrZ8CjLcZZ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576292; c=relaxed/simple;
	bh=YTZ1U53t3+Y4p975TTuCgk2aQJEJQTEEakGxqPyNkBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDQmvQis/jVEUDKphZo2VpipcBDE0tKNKAsmX6IP20gm5oZAIIBHiSAdK3akqstaqP3tkyzbWAHJ525vdOHNjYDC6DOFLPJGn6HGmU0Z2/Lz/e3Ut2dLBERaA0ZvSPb5+9JxVhuhuYAYa4BG94pJQaENSjUL/s/YhVNPCA3ZzHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBW5d-00005w-2D; Thu, 14 Nov 2024 10:24:37 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBW5c-000ic2-2D;
	Thu, 14 Nov 2024 10:24:36 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4BF60372F32;
	Thu, 14 Nov 2024 09:24:36 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:24:35 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH can-next v3 2/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
Message-ID: <20241114-hysterical-toucan-of-storm-722706-mkl@pengutronix.de>
References: <20241112-tcan-wkrqv-v3-0-c66423fba26d@geanix.com>
 <20241112-tcan-wkrqv-v3-2-c66423fba26d@geanix.com>
 <b61e19bb-58ae-42ac-9863-f1149a812261@wanadoo.fr>
 <bmuodxb7xtuwexm7rg6ijepxlyqlwdux37ye2ztwreg7kiynwy@xxt3qvgwebvw>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hxrvvoshhuf5jrb2"
Content-Disposition: inline
In-Reply-To: <bmuodxb7xtuwexm7rg6ijepxlyqlwdux37ye2ztwreg7kiynwy@xxt3qvgwebvw>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--hxrvvoshhuf5jrb2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v3 2/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
MIME-Version: 1.0

On 14.11.2024 10:04:31, Sean Nyekjaer wrote:
> Hi Vincent,
>=20
> On Thu, Nov 14, 2024 at 05:59:54PM +0100, Vincent Mailhol wrote:
> > Hi Sean,
> >=20
> > I found the v3. I=C2=A0was a bit confused because it was hidden before =
the v2 in
> > my mailbox: the active thread in v2 bump it to the top, thus "shadowing=
" the
> > v3.
> >=20
> > On 12/11/2024 at 23:39, Sean Nyekjaer wrote:
> > > nWKRQ supports an output voltage of either the internal reference vol=
tage
> > > (3.6V) or the reference voltage of the digital interface 0 - 6V (VIO).
> > > Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.
> > > Unset nWKRQ is kept at internal reference voltage.
> > >=20
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> >=20
> > Notwithstanding of bellow nitpick:
> >=20
> > Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >=20
> > > ---
> > >   drivers/net/can/m_can/tcan4x5x-core.c | 20 ++++++++++++++++++++
> > >   drivers/net/can/m_can/tcan4x5x.h      |  2 ++
> > >   2 files changed, 22 insertions(+)
> > >=20
> > > diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/=
m_can/tcan4x5x-core.c
> > > index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..12a375c653cbd255b5dc8=
5faf2f76de397a644ec 100644
> > > --- a/drivers/net/can/m_can/tcan4x5x-core.c
> > > +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> > > @@ -92,6 +92,8 @@
> > >   #define TCAN4X5X_MODE_STANDBY BIT(6)
> > >   #define TCAN4X5X_MODE_NORMAL BIT(7)
> > > +#define TCAN4X5X_NWKRQ_VOLTAGE_VIO BIT(19)
> > > +
> > >   #define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
> > >   #define TCAN4X5X_DISABLE_INH_MSK	BIT(9)
> > > @@ -267,6 +269,13 @@ static int tcan4x5x_init(struct m_can_classdev *=
cdev)
> > >   	if (ret)
> > >   		return ret;
> > > +	if (tcan4x5x->nwkrq_voltage_vio) {
> > > +		ret =3D regmap_set_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
> > > +				      TCAN4X5X_NWKRQ_VOLTAGE_VIO);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > >   	return ret;>   }
> > > @@ -318,6 +327,15 @@ static const struct tcan4x5x_version_info
> > >   	return &tcan4x5x_versions[TCAN4X5X];
> > >   }
> > > +static void tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
> > > +{
> > > +	struct tcan4x5x_priv *tcan4x5x =3D cdev_to_priv(cdev);
> > > +	struct device_node *np =3D cdev->dev->of_node;
> > > +
> > > +	if (of_property_read_bool(np, "ti,nwkrq-voltage-vio"))
> > > +		tcan4x5x->nwkrq_voltage_vio =3D true;
> >=20
> > Nitpick: you can directly assign the value. No need for the if.
> >=20
> > 	tcan4x5x->nwkrq_voltage_vio =3D
> > 		of_property_read_bool(cdev->dev->of_node,
> > 				      "ti,nwkrq-voltage-vio");
> >=20
> > My personal preference is to not declare the np variable because it used
> > only once but instead directly use cdev->dev->of_node. See this as a
> > suggestion. If you prefer to keep as it is, OK for me :)
>=20
> It looks a lot cleaner :)
> Just send v4, with some commit messange changens from Marc.
> I will update and sent v5

No need to send a v6 with the updated R-b, b4 will collect them. After
we get an ack by one of the DT maintainers I'll apply the patches.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hxrvvoshhuf5jrb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc1wdEACgkQKDiiPnot
vG/4gAf+PTUWp816cWwpPWNdLBMYvQrLIXS0TG1DtsDknARxwcL5FtPjZDzdIn58
T6byzluwdaRiguQJcyYSyy9vxRR1yDxqrjKtW+wOH+wGiax1B7A/wkfNCUjy1ewM
BssR8dyrd203QefDmII9aegB4JiAizrpJZtRlnxtiLSUDLaQ7Hh3UZPCKlk30BvK
4tzsa1RtKuX167D4n+KVoQKrlr4Vp8V4KM1FrAIMEFyzjnmg7oWRr3Hj/V3E6vll
O5fnPIF5+zB1O5GL4omlA6QbcfjDLd/uNEMrEN0XxrQTrp9ANTaFaA71ssJA4xiP
jKTq5VqPZC2HwelogHDjBuE1LeLHsQ==
=k3LC
-----END PGP SIGNATURE-----

--hxrvvoshhuf5jrb2--

