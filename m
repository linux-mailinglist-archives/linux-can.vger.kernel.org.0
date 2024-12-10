Return-Path: <linux-can+bounces-2372-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE5B9EB052
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 12:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4611B164945
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 11:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32DD19E99A;
	Tue, 10 Dec 2024 11:59:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16C19F421
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831946; cv=none; b=TYobMu+9pfjFzuz84Ei/MWsDK7iTkIVYHvyX/1UVNpY0yv+HK6VWEd5o4wV9BfBSRX/7fMF+RZ1Zyy+jBWh8fkML64mF8ZnZqTc25PM4uS+AwVDXUPrUaYMR5+xuSrSODWUWbny6hA9gK5V/s/MDt3axr2fRoj+obo1zzzR0eXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831946; c=relaxed/simple;
	bh=Z4LBcQtsYnhWsMQE+ORhsIb253wQjaiJeimVg202SVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmoN7341+nCnSIVKZbpePlxa8m11AGbtIfsqAEtdKC7hoJGq8F7m2bVjSscBgP1ngy3lV1IuDp7xgsQ+oH+9HvE/IBJ9g51muoW4tk7l3980pOptOyc5q017U5lyISItRgqONZ/D3R3v9IhXTCecgTHFgKeVPyt4azD2Xk25r6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKytI-0004al-Bz; Tue, 10 Dec 2024 12:59:00 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKytG-002gOT-38;
	Tue, 10 Dec 2024 12:58:59 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 66EBA38AABC;
	Tue, 10 Dec 2024 11:58:59 +0000 (UTC)
Date: Tue, 10 Dec 2024 12:58:59 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, Robert Nawrath <mbro1689@gmail.com>
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
Message-ID: <20241210-alluring-cunning-swift-4bcd47-mkl@pengutronix.de>
References: <20241110155902.72807-28-mailhol.vincent@wanadoo.fr>
 <20241112-flashy-straight-poodle-9a796d-mkl@pengutronix.de>
 <CAMZ6RqKQLaEtgoLOAa3NHJotyHcAo=7ObXf=7tLh_DJ_QTCKOg@mail.gmail.com>
 <36b1f1cb-c431-43ad-be49-5093a3534b9d@hartkopp.net>
 <20241204-nippy-vivid-mantis-ee1725-mkl@pengutronix.de>
 <8d1cd5de-ae84-455d-8636-7f269bbfe7db@hartkopp.net>
 <20241204-mauve-asp-of-fortitude-e75174-mkl@pengutronix.de>
 <aeb667e7-9a5b-4d6f-8220-ac06dbdcfe80@hartkopp.net>
 <20241205-archetypal-stirring-kakapo-407537-mkl@pengutronix.de>
 <572d0fa8-e9df-4047-951f-2747571086db@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tpck7y6p36ouszny"
Content-Disposition: inline
In-Reply-To: <572d0fa8-e9df-4047-951f-2747571086db@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--tpck7y6p36ouszny
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
MIME-Version: 1.0

On 09.12.2024 14:13:29, Oliver Hartkopp wrote:
>=20
>=20
> On 05.12.24 10:15, Marc Kleine-Budde wrote:
> > On 05.12.2024 09:16:44, Oliver Hartkopp wrote:
> > > On 04.12.24 12:44, Marc Kleine-Budde wrote:
> > > > On 04.12.2024 12:35:43, Oliver Hartkopp wrote:
> > > > > > > > Also, the main reason for not creating the nest was that I =
thought
> > > > > > > > that the current bittiming API was stable. I was not aware =
of the
> > > > > > > > current flaw on how to divide tseg1_min. Maybe we should fi=
rst discuss
> > > > > > > > how to solve this issue for CAN FD?
> > > > > > >=20
> > > > > > > I like the current way how you added the CAN XL support.
> > > > > > > It maintains the known usage pattern - and the way how CAN XL=
 bit timings
> > > > > > > are defined is identical to CAN FD (including TDC).
> > > > > > >=20
> > > > > > > Is the separation of propseg and tseg1 that relevant?
> > > > > > > Does it really need to be exposed to the user?
> > > > > >=20
> > > > > > There are IIRC at least 2 CAN-FD cores where the prop segment a=
nd phase
> > > > > > segment 1 for the data bit timing have not the same width. This=
 means we
> > > > > > have to change the bittiming_const in the kernel.
> > >=20
> > > Sure?
> >=20
> > I'm sure the registers don't have the same width. And I'm sure about my
> > conclusion, but that's up for discussion :)
> >=20
> > https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/can/ctucanf=
d/ctucanfd_base.c#L197
> > https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/can/flexcan=
/flexcan-core.c#L1210
> >=20
> > > In the end (almost) every CAN controller has the tseg1 register which
> > > contains prop_seg + phase_seg1 as a sum of these.
> >=20
> > Some do (just a short grep): bxcan, esdacc, rcar_can, softing, hi311x,
> > ti_hecc. More controllers haven evenly divided prop_seg + phase_seg1.
> >=20
> > > The relevant point is behind prop_seg + phase_seg1 and I'm pretty sur=
e these
> > > "2 CAN-FD cores" will add the values internally too.
> >=20
> > As the ctucanfd is open you can have a look :)

As far as I understand, it internally adds sync + prop + phase1:

https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core/-/blob/master/src/presca=
ler/bit_time_cfg_capture.vhd?ref_type=3Dheads#L242

> > > I'm a bit concerned that after 40 years someone shows up with the ide=
a to
> > > spend two registers for the tseg1 value instead of one.
> >=20
> > It doesn't matter if prop_seg and phase_seg1 are in the same register or
> > not, what matters is:
> > a) 1. does the IP core want separate prop_seg and phase_seg1 values
> >     - or -
> >     2. does the IP core want a single "prop_seg + phase_seg1", a.k.a.
> >        tseg1 value?
> > b) 1. what's the width of the prop_seg and phase_seg1?
> >     2. what's the width of tseg1?
> >=20
> > Currently the CAN infrastructure allows the driver to specify tseg1 only
> > and assumes the width of prop_seg and phase_seg1 to be the same, as it
> > distributes tseg1 evenly between prop_seg and phase_seg1:
> >=20
> > https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/can/dev/cal=
c_bittiming.c#L155
> >=20
> > This leads to the workarounds in the CAN drivers, see above for links.
>=20
> Yes. But why don't we just let this as-is then?
>=20
> Even if prop_seg phase_seg1 registers have a different size, this split up
> can be done easily without changing the current bittiming API.
>=20
> Maybe a common helper function to split up the values based on given
> register sizes could simplify the handling for those CAN drivers.

Good idea!

What about adding the information about prop_seg and phase_seg1 to
bittiming_const and let the can_calc_bittiming() calculate it?

> I'm still not convinced that it brings some benefits for the user to exte=
nd
> the bittiming API. IMHO it just complicates the bitrate settings.

The benefit is, that the user knows about the limitation of prop_seg and
phase_seg1.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tpck7y6p36ouszny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdYLP8ACgkQKDiiPnot
vG9cPAf/YBpOigVLmroXcOuBsivW8yiPpyHbsJFMr8bGosmyqWmgi4Oy9l5Op5dW
Gzrd+Cv7TFAHnM5mbFcLKMaaXLkFP2veYnX6uS4r5v/Om2SlKVqrjdyOm8NCDfp+
SPwUgLL09lFiaRK4XCIKbfQJNhEjBx3jOr6mFdRv5Im0b9oMoGUxhnfOPArSo7jC
RxUHD/jhkpPhiQnZV2QtjJeiDuezcHinaox3N5e0z/X5oi+eWho79g86H1G4x3h5
VORy03hcrafEMVUoUSCW47vg0xrVt5EhHGDvQNmg/Cg0501DrJysZV5E6+90aUpd
2jvimPkpwMdCTAFnnpfg37XorcEzbQ==
=17/j
-----END PGP SIGNATURE-----

--tpck7y6p36ouszny--

