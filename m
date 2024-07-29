Return-Path: <linux-can+bounces-1058-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7917493FE4F
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 21:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A912B1C222E9
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 19:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D176B146584;
	Mon, 29 Jul 2024 19:33:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182885947
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281587; cv=none; b=ScavtMZkHIS285CQD2v1M3HeWH9fP08cxbB0uuTDSG/LlREnTggRrbDAkgO4U3yVNvwXbHLaAtA8fp60d/F4NV6MxYsmIhQBwBrqUYOKEb4+9s4hJkG4d9/kTR8NWlQZmiA4QuQgOH4gKZJzdZmpyc42HX3n/HWBbiYbNtSlqBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281587; c=relaxed/simple;
	bh=M+XYDALNe0CwnTV7fx0pNLydFW/LAkjJVXywgGSrNlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXL6Rojb1jAxYk6Wgp8YRanPmtj5QBjgYvYfNJwj6sqjeYOboZACuBLazuYBpPs9oy7tJakRYQVrpkjVtFhOS+0fc3/w+G5qDv4nSUwK7wGOlb3Bqh22A+w+lV1/64JA0LSanOpKE9Qa55zGklPuSFhqhnUJFHSeWZ9SQmQ5CBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYW6X-0004Z4-BK; Mon, 29 Jul 2024 21:32:21 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYW6T-003790-EX; Mon, 29 Jul 2024 21:32:17 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9789A31134B;
	Mon, 29 Jul 2024 19:32:15 +0000 (UTC)
Date: Mon, 29 Jul 2024 21:32:14 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Michal Kubiak <michal.kubiak@intel.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, Conor Dooley <conor@kernel.org>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/7] can: m_can: Map WoL to device_set_wakeup_enable
Message-ID: <20240729-blue-cockle-of-vigor-7d7670-mkl@pengutronix.de>
References: <20240729074135.3850634-1-msp@baylibre.com>
 <20240729074135.3850634-3-msp@baylibre.com>
 <15424d0f-9538-402f-bc5d-cdd630c7c5e9@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gymxo6uklvdsbh6i"
Content-Disposition: inline
In-Reply-To: <15424d0f-9538-402f-bc5d-cdd630c7c5e9@lunn.ch>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gymxo6uklvdsbh6i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.07.2024 21:27:04, Andrew Lunn wrote:
> On Mon, Jul 29, 2024 at 09:41:30AM +0200, Markus Schneider-Pargmann wrote:
> > In some devices the pins of the m_can module can act as a wakeup source.
> > This patch helps do that by connecting the PHY_WAKE WoL option to
> > device_set_wakeup_enable. By marking this device as being wakeup
> > enabled, this setting can be used by platform code to decide which
> > sleep or poweroff mode to use.
> >=20
> > Also this prepares the driver for the next patch in which the pinctrl
> > settings are changed depending on the desired wakeup source.
> >=20
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >  drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >=20
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> > index 81e05746d7d4..2e4ccf05e162 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -2182,6 +2182,36 @@ static int m_can_set_coalesce(struct net_device =
*dev,
> >  	return 0;
> >  }
> > =20
> > +static void m_can_get_wol(struct net_device *dev, struct ethtool_wolin=
fo *wol)
> > +{
> > +	struct m_can_classdev *cdev =3D netdev_priv(dev);
> > +
> > +	wol->supported =3D device_can_wakeup(cdev->dev) ? WAKE_PHY : 0;
> > +	wol->wolopts =3D device_may_wakeup(cdev->dev) ? WAKE_PHY : 0;
> > +}
>=20
> It is nice to see Ethernet WoL mapped to CAN :-)
>=20
> So will any activity on the CAN BUS wake the device? Or does it need
> to be addresses to this device?

Unless you have a special filtering transceiver, which is the CAN
equivalent of a PHY, CAN interfaces usually wake up on the first
message on the bus. That message is usually lost.

Note: The details of the m_can IP core might be different.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gymxo6uklvdsbh6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAman7jsACgkQKDiiPnot
vG/ekQf/UazIMc4lJG3SED8MsgayQ8NHDp/+4mf0my6KoBoV1C4NRTwVqNE6HF3t
qWWYAnY98fNAq4kEniEDAYDM/EYZHsTZSYAFTK7eUjxD2C8nh9VDF4xiCg8M/ZyT
iC/TkPU0JQ6OJStTrCmD1s/xpHH6JnyWp2J1ReByVp+3E+HgOR7Ugss3P7nkKZp2
bpzsveXbeAd7nU6Atpti4NUtGyGBwx5rw2u2iqY5bGlHtpqjcuW8jceifGfrJHiH
1kYW2s6otcCbvkulf0tgfhQExkC8PP2fU3Kr2bxoSiU2X1UQLJNVJSwW7Z1Yn6tB
iAyzOKi7Mor09c9q4wdE5MVhFINhaQ==
=8S1o
-----END PGP SIGNATURE-----

--gymxo6uklvdsbh6i--

