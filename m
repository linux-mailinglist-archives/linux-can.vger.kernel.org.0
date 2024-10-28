Return-Path: <linux-can+bounces-1804-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D4F9B332B
	for <lists+linux-can@lfdr.de>; Mon, 28 Oct 2024 15:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D482A1F215F9
	for <lists+linux-can@lfdr.de>; Mon, 28 Oct 2024 14:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55BE1DDC21;
	Mon, 28 Oct 2024 14:18:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890AC1DC1B2
	for <linux-can@vger.kernel.org>; Mon, 28 Oct 2024 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125112; cv=none; b=F4AMIjxg6BBm5iivxbGLegeIt0wS6XKr4hp/PmstlaU+U9IRzGmk3AcZHm9Aot6NP5e4uXyOtsIlRdUNtrdOyrj99YgLixv6K4yo2OXDj9s4aEN8EiG17KCA7ABhJLqaqsFCtsWKXkwoglxgeYCR0kB0U740PeGnVpUsj/l7yLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125112; c=relaxed/simple;
	bh=GDxeko3+Dn9RuaYdTtgwmg1aQ7/CFFrKZY1eCCjQzsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo58EKMZf1iwx1UbwQjH+85yyvlrekIGvsrqRDlZoE4/GvPVqTJ9/cEOTjRCEfk9X62AXeU1PDX0I4gFVUt0H30aXQFKRa/UcPpI7o2B+RvXCryu8ix0uEQbalquVianNde/Bzh8g0vTqDLPlhlElwmHnUeUscc4mt7M7ebqUKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5QZN-0002bl-NX; Mon, 28 Oct 2024 15:18:09 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5QZK-000s76-0y;
	Mon, 28 Oct 2024 15:18:06 +0100
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D06AA360975;
	Mon, 28 Oct 2024 14:18:05 +0000 (UTC)
Date: Mon, 28 Oct 2024 15:18:05 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	William Qiu <william.qiu@starfivetech.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RE: [PATCH v2 3/4] can: Add driver for CAST CAN Bus Controller
Message-ID: <20241028-great-worm-of-snow-494fa0-mkl@pengutronix.de>
References: <20240922145151.130999-1-hal.feng@starfivetech.com>
 <20240922145151.130999-4-hal.feng@starfivetech.com>
 <cf17f15b-cbd7-4692-b3b2-065e549cb21e@lunn.ch>
 <ZQ2PR01MB13071A093EB33F48340F753EE66F2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d6ye2orfo4iuw6ou"
Content-Disposition: inline
In-Reply-To: <ZQ2PR01MB13071A093EB33F48340F753EE66F2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--d6ye2orfo4iuw6ou
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: [PATCH v2 3/4] can: Add driver for CAST CAN Bus Controller
MIME-Version: 1.0

On 23.09.2024 07:53:24, Hal Feng wrote:
> > > +static inline u8 ccan_read_reg_8bit(const struct ccan_priv *priv,
> > > +				    enum ccan_reg reg)
> > > +{
> > > +	u8 reg_down;
> > > +	union val {
> > > +		u8 val_8[4];
> > > +		u32 val_32;
> > > +	} val;
> > > +
> > > +	reg_down =3D ALIGN_DOWN(reg, 4);
> > > +	val.val_32 =3D ccan_read_reg(priv, reg_down);
> > > +	return val.val_8[reg - reg_down];
> >=20
> > There is an ioread8(). Is it invalid to do a byte read for this hardwar=
e? If so, it is
> > probably worth a comment.
>=20
> The hardware has been initially developed as peripheral component for 8 b=
it systems
> and therefore control and status registers defined as 8 bit groups. Never=
theless
> the hardware is designed as a 32 bit component finally. It prefers 32-bit=
 read/write
> interfaces. I will add a comment later.

As mentioned in my v1 review, you are doing proper u32 accesses.

> > > +static int ccan_bittime_configuration(struct net_device *ndev) {
> > > +	struct ccan_priv *priv =3D netdev_priv(ndev);
> > > +	struct can_bittiming *bt =3D &priv->can.bittiming;
> > > +	struct can_bittiming *dbt =3D &priv->can.data_bittiming;
> > > +	u32 bittiming, data_bittiming;
> > > +	u8 reset_test;
> > > +
> > > +	reset_test =3D ccan_read_reg_8bit(priv, CCAN_CFG_STAT);
> > > +
> > > +	if (!(reset_test & CCAN_RST_MASK)) {
> > > +		netdev_alert(ndev, "Not in reset mode, cannot set bit
> > timing\n");
> > > +		return -EPERM;
> > > +	}
> >=20
> >=20
> > You don't see nedev_alert() used very often. If this is fatal then netd=
ev_err().
> >=20
> > Also, EPERM? man 3 errno say:
> >=20
> >        EPERM           Operation not permitted (POSIX.1-2001).
> >=20
> > Why is this a permission issue?
>=20
> Will use netdev_err() and return -EWOULDBLOCK instead.

You have a dedicated function to put the IP core into reset
"ccan_set_reset_mode()". If you don't trust you IP core or it needs some
time, add a poll to that function and return an error.

Then there's no need on ccan_bittime_configuration() to check for reset
mode.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--d6ye2orfo4iuw6ou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcfnRsACgkQKDiiPnot
vG+52Qf9EYytqiZDcw1r+TVbTIDJoUzjC6e0XKFkbT2/IBKG1usCbI8BwlKdXwu+
uIU8xA7v62V41WBLyNHAXgeQTnjy1aNsMRUi8pJxVADI/PS91RzdWQXcHb1h6HPQ
HfhJvmk0/nz6CFOXoIlPg9bwm2uB7MxPIS3y/aZ7Mo0e6vW5ChjtcmMXW9Ma/u08
CrOsC92UX2ERW3o9nVhGqTgeKAFxiagUZMYFFMkqCDn1Pzas1EhixcpMmgbtff/q
4cesN3k0tY37qg279JvVVBZhCDcbE2ueHSxjHwITsVxKvsL8HdWp+4c5o48EP3kD
QQd+hao+9llKWOEpwduz8XmDjq3W5g==
=TefK
-----END PGP SIGNATURE-----

--d6ye2orfo4iuw6ou--

