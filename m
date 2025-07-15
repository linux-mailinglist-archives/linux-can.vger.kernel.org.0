Return-Path: <linux-can+bounces-4002-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42702B061B0
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 16:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D40176DD4
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 14:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBDD1D7E31;
	Tue, 15 Jul 2025 14:29:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD73F1D63C7
	for <linux-can@vger.kernel.org>; Tue, 15 Jul 2025 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589760; cv=none; b=rYyWbSCzM6QWaXy3y68HOUGMfmYwdUI4gYHJ22BwoQzUPCD3FoZ52c3O5RLwNN7+IqSRBQN5k2HYIykw98VnE/zGtyWKNMAd1yb/qUfFL06qsOlypiUjEW6AEj1veHe6LzHsgk3cSRxuc9Lwp4/vAhtTLjkAYqqw/JWIFozN94A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589760; c=relaxed/simple;
	bh=1VZzoaymuieyPmi3zmkGTg2NKfaJ1Upfu5llFVSXoAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQz7MZTl7zysZ5WKAvLaea12LFVrz7OOJvBi4v8xFmkte/Wn8+Kd6wgcCGNQ/81KXTU2MNJm7m9vBrGy8zmkGQQw2JyUgqcGfKdIqzVifcMlq2t//WG3neUeIKn6kZrwrZDxdpkffYEsdNPQzMCsdLruFBBlXWr6IuzLd8Ic2n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubgeh-0005Oy-KP; Tue, 15 Jul 2025 16:29:15 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubgeh-008at9-0R;
	Tue, 15 Jul 2025 16:29:15 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CB8C04425BD;
	Tue, 15 Jul 2025 14:29:14 +0000 (UTC)
Date: Tue, 15 Jul 2025 16:29:14 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andrei Lalaev <andrey.lalaev@gmail.com>
Cc: mailhol.vincent@wanadoo.fr, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org
Subject: Re: [RFC PATCH] can: gs_usb: fix kernel oops during restart
Message-ID: <20250715-smart-ultra-avocet-d7937a-mkl@pengutronix.de>
References: <20250714175520.307467-1-andrey.lalaev@gmail.com>
 <20250715-almond-zebra-of-perception-9d2e6c-mkl@pengutronix.de>
 <b8221fe9-a167-4bcc-81bf-fb793712b48e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uprcwe72mjwulkb5"
Content-Disposition: inline
In-Reply-To: <b8221fe9-a167-4bcc-81bf-fb793712b48e@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--uprcwe72mjwulkb5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] can: gs_usb: fix kernel oops during restart
MIME-Version: 1.0

On 15.07.2025 16:24:22, Andrei Lalaev wrote:
> I was also surprised because this callback isn't marked as mandatory
> and that there are no additional checks.
>=20
> >=20
> > What about this fix?
> >=20
> > diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlin=
k.c
> > index 13826e8a707b..94603c9eb4aa 100644
> > --- a/drivers/net/can/dev/netlink.c
> > +++ b/drivers/net/can/dev/netlink.c
> > @@ -285,6 +285,12 @@ static int can_changelink(struct net_device *dev, =
struct nlattr *tb[],
> >          }
> > =20
> >          if (data[IFLA_CAN_RESTART_MS]) {
> > +                if (!priv->do_set_mode) {
> > +                        NL_SET_ERR_MSG(extack,
> > +                                       "device doesn't support restart=
 from Bus Off");
> > +                        return -EOPNOTSUPP;
> > +                }
> > +
> >                  /* Do not allow changing restart delay while running */
> >                  if (dev->flags & IFF_UP)
> >                          return -EBUSY;
> > @@ -292,6 +298,12 @@ static int can_changelink(struct net_device *dev, =
struct nlattr *tb[],
> >          }
> > =20
> >          if (data[IFLA_CAN_RESTART]) {
> > +                if (!priv->do_set_mode) {
> > +                        NL_SET_ERR_MSG(extack,
> > +                                       "device doesn't support restart=
 from Bus Off");
> > +                        return -EOPNOTSUPP;
> > +                }
> > +
> >                  /* Do not allow a restart while not running */
> >                  if (!(dev->flags & IFF_UP))
> >                          return -EINVAL;
>=20
> Thanks for the patch. As expected, it fixes the kernel OOPS,
> but the interface never leaves the BUS_OFF state.

Which device and which firmware are you using?

The gs_usb/candlelight interface is un(der)defined when it comes to
bus-off handling.

I think the original candlelight with the stm32f072 does auto bus-off
recovery. Not sure about the candlelight on stm32g0b1.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uprcwe72mjwulkb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmh2ZbYACgkQDHRl3/mQ
kZwkUQgAjo4Axu9yo94qLhfXhgrAn3QjOBCbcH0jCFtXRnpFa+HnuFYNNpvbCIgg
I03VI9lG9E+SU8tcdTQub9DNMDUY/P8/xhh+GJ0V9i54dfIa6/pgfkTDNdn8mVhZ
g8uffCc3t0jET1s2y7YOD23UtBIJ/K1IVd2ZB9CvRxy3Cnptjo61NVk5dTVmaV6d
YysXAiJuTxbRH8BFE6dBXHjdlnsCI35tMEiTGUSuU+6Nn72AyR74w1eJpQBpJJgK
tUHiI3tS7U8b7Guf3bttdFHF7mRMhgmMmsZpc0XekQVgDhno10T4paLqH8iBto46
kcmXpIp5uL9sosSLwp+bH0yv8p92qA==
=OSOz
-----END PGP SIGNATURE-----

--uprcwe72mjwulkb5--

