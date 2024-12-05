Return-Path: <linux-can+bounces-2342-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7164B9E517B
	for <lists+linux-can@lfdr.de>; Thu,  5 Dec 2024 10:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DAC9163F46
	for <lists+linux-can@lfdr.de>; Thu,  5 Dec 2024 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF64190477;
	Thu,  5 Dec 2024 09:36:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688A18FC70
	for <linux-can@vger.kernel.org>; Thu,  5 Dec 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391382; cv=none; b=ldzTxDr5yUhLzAX6E2l6wtPe7wTJ6J+8Gfoc3j1zixS+OtMhaNtc7Cb7aoz6AHvNDh8GsLPZ847uSJV+ANF4YO1S0M9vWhQ00POuwGyyBv/pbl8RRDxHyssdDhnzYqI00xTv4+VWd1R8A76XkNdD8BQNK2CQSL1v14g4G362Bv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391382; c=relaxed/simple;
	bh=KUBYN52UVWJ2upxd5I960WFWQ1u1QBLjbUx4b9TUjzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCk3Hmipr9Um/JB5vEoUmctBUozL3d16C8W/+xzXLmq5GtLz9FBIJivtQlr5cg8AoouD68PV9f35x12yjbI+bfMckSZfjVFQXI462LOMLOlZwmJ5fXnM36tzSMvkLFC0H43dgr47CV+/26/h0RxNlTQqO5tq3+Q1GYYPt3Bk8l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tJ8HQ-0000Ry-Ts; Thu, 05 Dec 2024 10:36:16 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tJ8HP-001niy-2K;
	Thu, 05 Dec 2024 10:36:16 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DA57B3860D9;
	Thu, 05 Dec 2024 09:15:55 +0000 (UTC)
Date: Thu, 5 Dec 2024 10:15:55 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, Robert Nawrath <mbro1689@gmail.com>
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
Message-ID: <20241205-archetypal-stirring-kakapo-407537-mkl@pengutronix.de>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <20241110155902.72807-28-mailhol.vincent@wanadoo.fr>
 <20241112-flashy-straight-poodle-9a796d-mkl@pengutronix.de>
 <CAMZ6RqKQLaEtgoLOAa3NHJotyHcAo=7ObXf=7tLh_DJ_QTCKOg@mail.gmail.com>
 <36b1f1cb-c431-43ad-be49-5093a3534b9d@hartkopp.net>
 <20241204-nippy-vivid-mantis-ee1725-mkl@pengutronix.de>
 <8d1cd5de-ae84-455d-8636-7f269bbfe7db@hartkopp.net>
 <20241204-mauve-asp-of-fortitude-e75174-mkl@pengutronix.de>
 <aeb667e7-9a5b-4d6f-8220-ac06dbdcfe80@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="46yl6wivyltjsl6m"
Content-Disposition: inline
In-Reply-To: <aeb667e7-9a5b-4d6f-8220-ac06dbdcfe80@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--46yl6wivyltjsl6m
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
MIME-Version: 1.0

On 05.12.2024 09:16:44, Oliver Hartkopp wrote:
> On 04.12.24 12:44, Marc Kleine-Budde wrote:
> > On 04.12.2024 12:35:43, Oliver Hartkopp wrote:
> > > > > > Also, the main reason for not creating the nest was that I thou=
ght
> > > > > > that the current bittiming API was stable. I was not aware of t=
he
> > > > > > current flaw on how to divide tseg1_min. Maybe we should first =
discuss
> > > > > > how to solve this issue for CAN FD?
> > > > >=20
> > > > > I like the current way how you added the CAN XL support.
> > > > > It maintains the known usage pattern - and the way how CAN XL bit=
 timings
> > > > > are defined is identical to CAN FD (including TDC).
> > > > >=20
> > > > > Is the separation of propseg and tseg1 that relevant?
> > > > > Does it really need to be exposed to the user?
> > > >=20
> > > > There are IIRC at least 2 CAN-FD cores where the prop segment and p=
hase
> > > > segment 1 for the data bit timing have not the same width. This mea=
ns we
> > > > have to change the bittiming_const in the kernel.
>=20
> Sure?

I'm sure the registers don't have the same width. And I'm sure about my
conclusion, but that's up for discussion :)

https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/can/ctucanfd/ct=
ucanfd_base.c#L197
https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/can/flexcan/fle=
xcan-core.c#L1210

> In the end (almost) every CAN controller has the tseg1 register which
> contains prop_seg + phase_seg1 as a sum of these.

Some do (just a short grep): bxcan, esdacc, rcar_can, softing, hi311x,
ti_hecc. More controllers haven evenly divided prop_seg + phase_seg1.

> The relevant point is behind prop_seg + phase_seg1 and I'm pretty sure th=
ese
> "2 CAN-FD cores" will add the values internally too.

As the ctucanfd is open you can have a look :)

> I'm a bit concerned that after 40 years someone shows up with the idea to
> spend two registers for the tseg1 value instead of one.

It doesn't matter if prop_seg and phase_seg1 are in the same register or
not, what matters is:
a) 1. does the IP core want separate prop_seg and phase_seg1 values
   - or -
   2. does the IP core want a single "prop_seg + phase_seg1", a.k.a.
      tseg1 value?
b) 1. what's the width of the prop_seg and phase_seg1?
   2. what's the width of tseg1?

Currently the CAN infrastructure allows the driver to specify tseg1 only
and assumes the width of prop_seg and phase_seg1 to be the same, as it
distributes tseg1 evenly between prop_seg and phase_seg1:

https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/can/dev/calc_bi=
ttiming.c#L155

This leads to the workarounds in the CAN drivers, see above for links.

> As a both values rely on the same tq can't we just split the tseg1 into
> prop_seg + phase_seg1 values with some common e.g. 70:30 pattern?

We currently split 50:50 (hard-coded).

> IMO changing the bittiming API has no value for the user just to satisfy =
the
> "2 CAN-FD cores" that came late to the party.
>=20
> > > > A struct in netlink means we cannot change it.
> > >=20
> > > But are we not already in this situation with CAN FD that we can not =
change
> > > the bittiming (const) in the userspace API?
> >=20
> > Yes, we have to support it. But we can add a new nested type that
> > serializes the individual members of an improved struct bittiming_const.
> > The old user space tools will just keep working, iproute2 can be updated
> > to use the new bittiming_const if it's available and fall back to the
> > existing one.
>=20
> Ok. Nice - but maybe obsolete due to my question above ;-)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--46yl6wivyltjsl6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdRb0gACgkQKDiiPnot
vG9j1Af9H7lPEL2Tf47e33L155uHLsxUgePM8pCItcbWNr+SagasjmIpide1Tkll
21af7HrkTwKFt8cvkgfUizWUzTO0H0Gpexbzyca/u3cyRd9Tx1Yw17E77EWI/lt6
rQZ2vWpKUprBS9Q2+qZGfTqz82H+wB3T3uSwDkYTcUkEZK8q5d5rhFDb95MTilns
yYeifZgim4K5FI1CkazTpilNoz3pvdfsH2TYTx/Y6/+bgQDQWfrlz8bDRAYELNfs
uZI1JmM41lvsJ53yySYtuOq3Q7SIqKD6NNY4Ym8FD7jqromwv9vcQiBIUnXhzEbP
7H9kQE1oqByY8nypN8NVmWy4j79M1Q==
=9Sf2
-----END PGP SIGNATURE-----

--46yl6wivyltjsl6m--

