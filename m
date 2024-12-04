Return-Path: <linux-can+bounces-2333-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84C49E38A5
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 12:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4177B3D3E4
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 11:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DA7746E;
	Wed,  4 Dec 2024 11:15:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3B41AF0BE
	for <linux-can@vger.kernel.org>; Wed,  4 Dec 2024 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310942; cv=none; b=Cq16CbNC9rA163h3cHsQqkO9k11wRu9eQmMljq+01hl/POpsjeN31u0hvDff43c6t+nfkR2/IXgMeX2fBIWxq3g6a9b/km2qUt/BxAioYlcBMN9pczq9mwEAvRwdfwaBrdlDy3iBbzDdNdlFMvE9qPviTcA+1575wDJN9ozP/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310942; c=relaxed/simple;
	bh=YAy10zKjBb0vT8DVQ2C5M9Fmoe5zfUE0YXr09jke+NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niiuTlD7o03jph9K4xrOqy0FMuAd8xCR+k2RjzkF7YMYMdvcu3jhXwPagG6JgpZbklN31XoiQUxHO7mSWPYRVzzJCiHmD2BR/PoShUohgDuOfIUFKhMlx9GhjHlF1uExMd7gw7L9SAUGtKfl4Rmk+Xyl4VbebsJtfsy4xlXMWZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tInLu-0000ma-1h; Wed, 04 Dec 2024 12:15:30 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tInLs-001djY-1u;
	Wed, 04 Dec 2024 12:15:29 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0197E38560E;
	Wed, 04 Dec 2024 11:15:28 +0000 (UTC)
Date: Wed, 4 Dec 2024 12:15:28 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, Robert Nawrath <mbro1689@gmail.com>
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
Message-ID: <20241204-nippy-vivid-mantis-ee1725-mkl@pengutronix.de>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <20241110155902.72807-28-mailhol.vincent@wanadoo.fr>
 <20241112-flashy-straight-poodle-9a796d-mkl@pengutronix.de>
 <CAMZ6RqKQLaEtgoLOAa3NHJotyHcAo=7ObXf=7tLh_DJ_QTCKOg@mail.gmail.com>
 <36b1f1cb-c431-43ad-be49-5093a3534b9d@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kn45l5n2qc42vluj"
Content-Disposition: inline
In-Reply-To: <36b1f1cb-c431-43ad-be49-5093a3534b9d@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kn45l5n2qc42vluj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
MIME-Version: 1.0

On 04.12.2024 11:56:02, Oliver Hartkopp wrote:
>=20
>=20
> On 12.11.24 09:31, Vincent Mailhol wrote:
> > On Tue. 12 Nov. 2024 at 17:09, Marc Kleine-Budde <mkl@pengutronix.de> w=
rote:
> > > On 11.11.2024 00:56:01, Vincent Mailhol wrote:
> > > > Add the netlink interface for CAN XL.
> > > >=20
> > > > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > > ---
> > > >   drivers/net/can/dev/netlink.c    | 78 +++++++++++++++++++++++++++=
++---
> > > >   include/linux/can/bittiming.h    |  2 +
> > > >   include/linux/can/dev.h          | 13 ++++--
> > > >   include/uapi/linux/can/netlink.h |  7 +++
> > > >   4 files changed, 90 insertions(+), 10 deletions(-)
> > > >=20
> > > > diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/ne=
tlink.c
> > > > index 6c3fa5aa22cf..3c89b304c5b8 100644
> > > > --- a/drivers/net/can/dev/netlink.c
> > > > +++ b/drivers/net/can/dev/netlink.c
> > > > @@ -22,6 +22,9 @@ static const struct nla_policy can_policy[IFLA_CA=
N_MAX + 1] =3D {
> > > >        [IFLA_CAN_TERMINATION] =3D { .type =3D NLA_U16 },
> > > >        [IFLA_CAN_TDC] =3D { .type =3D NLA_NESTED },
> > > >        [IFLA_CAN_CTRLMODE_EXT] =3D { .type =3D NLA_NESTED },
> > > > +     [IFLA_CAN_XL_DATA_BITTIMING] =3D { .len =3D sizeof(struct can=
_bittiming) },
> > > > +     [IFLA_CAN_XL_DATA_BITTIMING_CONST] =3D { .len =3D sizeof(stru=
ct can_bittiming_const) },
> > > > +     [IFLA_CAN_XL_TDC] =3D { .type =3D NLA_NESTED },
> > >=20
> > > I haven't looked at the can_xl IP-core docs yet.
> > >=20
> > > I don't want to pass "struct can_bittiming_const" via netlink to user
> > > space. It's not sufficient to fully describe the CAN-FD controllers, =
as
> > > tseg1_min cannot equally divided into prop_seg and phase_seg1.
> > >=20
> > > Better make it a NLA_NESTED, as you did for the TDC.
> >=20
> > I considered this point. The fact is that the code to handle the "struct
> > can_bittiming_const" already exists. And so here, I am left with two
> > choices:
> >=20
> >    - small code refactor and reuse the existing
> >=20
> >    - rewrite the full thing just for CAN XL and have two different ways
> >      to handle the constant bittiming: one for Classical CAN and CAN FD
> >      and the other for CAN XL.
> >=20
> > For consistency, I chose the former approach which is the least
> > disruptive. If you want this nested, what about an in-between
> > solution:
> >=20
> >    IFLA_CAN_XL /* NLA_NESTED */
> >      + IFLA_CAN_DATA_BITTIMING /* struct can_bittiming */
> >      + IFLA_CAN_DATA_BITTIMING_CONST /* struct can_bittiming */
> >      + IFLA_CAN_TDC /* NLA_NESTED */
> >          + IFLA_CAN_TDC_TDCV_MIN
> >          + IFLA_CAN_TDC_TDCV_MAX
> >          + (all other TDC nested values)...
> >=20
> > This way, we can still keep most of the current CAN(-FD) logic, and if
> > we want to add one value, we can add it as a standalone within the
> > IFLA_CAN_XL nest.
> >=20
> > Also, the main reason for not creating the nest was that I thought
> > that the current bittiming API was stable. I was not aware of the
> > current flaw on how to divide tseg1_min. Maybe we should first discuss
> > how to solve this issue for CAN FD?
>=20
> I like the current way how you added the CAN XL support.
> It maintains the known usage pattern - and the way how CAN XL bit timings
> are defined is identical to CAN FD (including TDC).
>=20
> Is the separation of propseg and tseg1 that relevant?
> Does it really need to be exposed to the user?

There are IIRC at least 2 CAN-FD cores where the prop segment and phase
segment 1 for the data bit timing have not the same width. This means we
have to change the bittiming_const in the kernel.

A struct in netlink means we cannot change it. It makes IMHO no sense to
me to add any new structs into netlink, especially if we know the
bittiming struct is going to change.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kn45l5n2qc42vluj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdQOc0ACgkQKDiiPnot
vG/EVQgAgxynW5Nv4nt1SuJOOQPPidlZo+hy6eOjvNtkSinJ3Rr62FhRN+64w3mK
vtdEU6ljXae+ET9vN70aX6qk2qk7sw4xJe3bZRBGjt2sG65dJQ8cCrxyl7F464ge
hgDpp22XPUbhKEbPvMukLm4f4V3MbvmHYk0PYFLTUQD34Y3qgdFtUd3FFsQRP50y
Z4dYYB6BBOOGG/5NnTVEJPxtE5Ea1fBM97HClNHeYGsp95tGCdrSvgXKvsORFptq
8ay6oPVCvp1scFpDXBcEoG4CTEbi940WFwgYgoxwAmvcdqrGveQWSFGVKuCxzh/j
pOIsxcvx9WugYtriMXrwlZJQ+99jjA==
=apLA
-----END PGP SIGNATURE-----

--kn45l5n2qc42vluj--

