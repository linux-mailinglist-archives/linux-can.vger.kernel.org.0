Return-Path: <linux-can+bounces-1980-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4389C5163
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 10:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496F3B2DA7D
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 08:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96776154456;
	Tue, 12 Nov 2024 08:41:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB420B808
	for <linux-can@vger.kernel.org>; Tue, 12 Nov 2024 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400881; cv=none; b=QyKU0RtW2dMFlsuYlRYI6xk9xKoB8XVna4wpgUICMAtiqcUIFrsgLdTBi9kF1zjW+hJQlPW6Vnie1EiD/FWAudauxQux1vVDc0SaA9Z2jqz4VEFr3HfrjcYQV3AAIqniI4+J5NCraq7BgNIeAOUBn05L+FiR4KU+RCD0VnsU1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400881; c=relaxed/simple;
	bh=GlxsWFBscFc9J7uXMDOGVz43WXsxhkahR1Pt96sNOC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlDIi750aTatKsjq8fQ0a2lzcnGGK/LnVOXqLGL5obkTkxrdhZfl2wGTX5zMiblD7QDC3mJAQ6iBXmCq2hA7lK2prhhCH6yIPg3XvTI9jlw2cip6q/iU9COrboyKafBPIVj7UQtPLiSO9gBx5HzM6f6I1SMUZGWQjjFd/4iDxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tAmSZ-0007mW-8e; Tue, 12 Nov 2024 09:41:15 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tAmSY-000NfZ-2K;
	Tue, 12 Nov 2024 09:41:14 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5DE26371339;
	Tue, 12 Nov 2024 08:41:14 +0000 (UTC)
Date: Tue, 12 Nov 2024 09:41:14 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Robert Nawrath <mbro1689@gmail.com>
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
Message-ID: <20241112-towering-ruby-pony-d93ab0-mkl@pengutronix.de>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <20241110155902.72807-28-mailhol.vincent@wanadoo.fr>
 <20241112-flashy-straight-poodle-9a796d-mkl@pengutronix.de>
 <CAMZ6RqKQLaEtgoLOAa3NHJotyHcAo=7ObXf=7tLh_DJ_QTCKOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mjqt2m7s4bpkf42a"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKQLaEtgoLOAa3NHJotyHcAo=7ObXf=7tLh_DJ_QTCKOg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--mjqt2m7s4bpkf42a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
MIME-Version: 1.0

On 12.11.2024 17:31:38, Vincent Mailhol wrote:
> On Tue. 12 Nov. 2024 at 17:09, Marc Kleine-Budde <mkl@pengutronix.de> wro=
te:
> > On 11.11.2024 00:56:01, Vincent Mailhol wrote:
> > > Add the netlink interface for CAN XL.
> > >
> > > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > ---
> > >  drivers/net/can/dev/netlink.c    | 78 +++++++++++++++++++++++++++++-=
--
> > >  include/linux/can/bittiming.h    |  2 +
> > >  include/linux/can/dev.h          | 13 ++++--
> > >  include/uapi/linux/can/netlink.h |  7 +++
> > >  4 files changed, 90 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netl=
ink.c
> > > index 6c3fa5aa22cf..3c89b304c5b8 100644
> > > --- a/drivers/net/can/dev/netlink.c
> > > +++ b/drivers/net/can/dev/netlink.c
> > > @@ -22,6 +22,9 @@ static const struct nla_policy can_policy[IFLA_CAN_=
MAX + 1] =3D {
> > >       [IFLA_CAN_TERMINATION] =3D { .type =3D NLA_U16 },
> > >       [IFLA_CAN_TDC] =3D { .type =3D NLA_NESTED },
> > >       [IFLA_CAN_CTRLMODE_EXT] =3D { .type =3D NLA_NESTED },
> > > +     [IFLA_CAN_XL_DATA_BITTIMING] =3D { .len =3D sizeof(struct can_b=
ittiming) },
> > > +     [IFLA_CAN_XL_DATA_BITTIMING_CONST] =3D { .len =3D sizeof(struct=
 can_bittiming_const) },
> > > +     [IFLA_CAN_XL_TDC] =3D { .type =3D NLA_NESTED },
> >
> > I haven't looked at the can_xl IP-core docs yet.
> >
> > I don't want to pass "struct can_bittiming_const" via netlink to user
> > space. It's not sufficient to fully describe the CAN-FD controllers, as
> > tseg1_min cannot equally divided into prop_seg and phase_seg1.
> >
> > Better make it a NLA_NESTED, as you did for the TDC.
>=20
> I considered this point. The fact is that the code to handle the "struct
> can_bittiming_const" already exists. And so here, I am left with two
> choices:
>=20
>   - small code refactor and reuse the existing
>=20
>   - rewrite the full thing just for CAN XL and have two different ways
>     to handle the constant bittiming: one for Classical CAN and CAN FD
>     and the other for CAN XL.
>=20
> For consistency, I chose the former approach which is the least
> disruptive. If you want this nested, what about an in-between
> solution:
>=20
>   IFLA_CAN_XL /* NLA_NESTED */
>     + IFLA_CAN_DATA_BITTIMING /* struct can_bittiming */
>     + IFLA_CAN_DATA_BITTIMING_CONST /* struct can_bittiming */
>     + IFLA_CAN_TDC /* NLA_NESTED */
>         + IFLA_CAN_TDC_TDCV_MIN
>         + IFLA_CAN_TDC_TDCV_MAX
>         + (all other TDC nested values)...
>=20
> This way, we can still keep most of the current CAN(-FD) logic, and if
> we want to add one value, we can add it as a standalone within the
> IFLA_CAN_XL nest.
>=20
> Also, the main reason for not creating the nest was that I thought
> that the current bittiming API was stable. I was not aware of the
> current flaw on how to divide tseg1_min. Maybe we should first discuss
> how to solve this issue for CAN FD?

The bittiming API is stable. I thought of adding an additional nested
type to hold all relevant information. Luckily it's only from kernel ->
user space. So we can pass both, the old struct can_bittiming_const and
the new nested type and the user space can decide which one to use.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mjqt2m7s4bpkf42a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmczFKcACgkQKDiiPnot
vG/IxQf/aWwLQrwJNcrJgtSii1lrPWdIkDphfE1GrJ38ZNIYZQ6PEl8i5LoU3cbI
ycY5MI8dhclOZUBmQsa8yY6VLeUo6iAxapmf9TiHx0w4DHezOcLXt8IZk64v0PAx
mSf3MQM9GPRBotBrmW2/ed1df6inNVF41WhgMeb8y6etnyQm/jyAs4r6KeOXsUer
pbpyE7PeS5IOuMgZmy0xaHyKfBE9900q8i8gBhoXemvJ5YNVzYOq7nWI89xyJ580
g8zXOBYOnyA4nipMZ9sWuG9SDHuMU8Sq3ueAPBjzsBoN18fLEIcbIVRrI/mw5mFT
qyNlG9PKyrbyt2jt66NhrjFWPlshmA==
=zNma
-----END PGP SIGNATURE-----

--mjqt2m7s4bpkf42a--

