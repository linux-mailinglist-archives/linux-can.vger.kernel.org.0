Return-Path: <linux-can+bounces-4782-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F4FB8FD0B
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 11:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C2C178B2A
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 09:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43AD26E715;
	Mon, 22 Sep 2025 09:44:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55051459F7
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534246; cv=none; b=kUyCo+V81+40CH2oo2zK/hBFg/E6kQRCqzsqtP7Cpe2lQKFj5x6UZ7GCKm3xRgJR/m7DHUkk9G4hdW7PXjOhe7Nf6JbB1mmodW8OVdGQW0Q9MO5Ai9FXTVlfEYnhvk+yB0PJwQhAHWCYBOYX099L943uWfyuUnfLlpfXaHZq2oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534246; c=relaxed/simple;
	bh=Op2SVDJIe/UqVXLX0hU5fJrbWehPyFq8PPlw17qHjNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GY0Tva/moBnhZ3ynPffQgvSOAz9LBnQXJ+QAtBPIPNN9XCSxAR3V/N3j7ZgYQu9a4f7c0HLLuCgWtN7RHAHwBcR2+iP0iMGS1CAS8zvSlp/FAA72CinDBrzFOHme0xwAP10l2it3yQhSCQ+egPom9c6QfBrSPsBqSTZzZS0oBFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0d5P-0002lt-6t; Mon, 22 Sep 2025 11:43:55 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0d5O-002ZM8-0p;
	Mon, 22 Sep 2025 11:43:54 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DEF40476CA3;
	Mon, 22 Sep 2025 09:43:53 +0000 (UTC)
Date: Mon, 22 Sep 2025 11:43:53 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, Robert Nawrath <mbro1689@gmail.com>, 
	Minh Le <minh.le.aj@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/20] can: netlink: refactor
 CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
Message-ID: <20250922-amber-spider-of-control-90be7c-mkl@pengutronix.de>
References: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
 <20250910-canxl-netlink-prep-v2-7-f128d4083721@kernel.org>
 <f9854748-78c1-4852-a610-e839e9c91df3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d5aff4qmd2lfxgtx"
Content-Disposition: inline
In-Reply-To: <f9854748-78c1-4852-a610-e839e9c91df3@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--d5aff4qmd2lfxgtx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 07/20] can: netlink: refactor
 CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
MIME-Version: 1.0

On 20.09.2025 16:24:42, Vincent Mailhol wrote:
> On 10/09/2025 at 15:03, Vincent Mailhol wrote:
> > CAN_CTRLMODE_TDC_AUTO and CAN_CTRLMODE_TDC_MANUAL are mutually
> > exclusive. This means that whenever the user switches from auto to
> > manual mode (or vice versa), the other flag which was set previously
> > needs to be cleared.
> >=20
> > Currently, this is handled with a masking operation. It can be done in
> > a simpler manner by clearing any of the previous TDC flags before
> > copying netlink attributes. The code becomes easier to understand and
> > will make it easier to add the new upcoming CAN XL flags which will
> > have a similar reset logic as the current TDC flags.
> >=20
> > Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> > ---
> >  drivers/net/can/dev/netlink.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlin=
k.c
> > index 274eaab10796b601d565c32f6315727a578970bb..72a82d4e9d6494771320ea0=
35ed6f6098c0e8ce6 100644
> > --- a/drivers/net/can/dev/netlink.c
> > +++ b/drivers/net/can/dev/netlink.c
> > @@ -254,6 +254,10 @@ static int can_changelink(struct net_device *dev, =
struct nlattr *tb[],
> >  		if ((maskedflags & ctrlstatic) !=3D ctrlstatic)
> >  			return -EOPNOTSUPP;
> > =20
> > +		/* If a top dependency flag is provided, reset all its dependencies =
*/
> > +		if (cm->mask & CAN_CTRLMODE_FD)
> > +			priv->ctrlmode &=3D !CAN_CTRLMODE_FD_TDC_MASK;
>                                           ^
>=20
> This is a bug. The correct operation to unset the flag is:
>=20
> 		priv->ctrlmode &=3D ~CAN_CTRLMODE_FD_TDC_MASK;
>=20
> (replace the ! operator by ~).
>=20
> @Marc, do you think you can send your next PR to net soonish?
>=20
> I would like to rebase this series and the "rework the CAN MTU logic" ser=
ies on
> top of the MTU fix:
>=20
> https://lore.kernel.org/linux-can/20250918-can-fix-mtu-v1-0-0d1cada9393b@=
kernel.org/
>=20
> But to do so, I first need to wait for the MTU fix to appear on net-next =
and
> there is not so much time left before the end of the development windows.

This series looks fine to me. After -rc1, please check for any
ndo_change_mtu, because the Nuvoton CAN-FD driver will go mainline, but
not via the net-next tree.

> If the schedule is too short, let me know and I will adjust accordingly by
> dropping whatever patches are in conflict.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--d5aff4qmd2lfxgtx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjRGlUACgkQDHRl3/mQ
kZzjZwf/YVBw13aS+uX4OutqD6C3ihMaJhnkeBAwGlJ/eJZ3/dYyEhhbZKnEF8XZ
L3bqB1K2+s6L9c6JoKPXsRVyBt/XO//yCO3ElgvRYSIvdq//iH5RxB8jyJTw8YLc
OwRQKyu6g7CdYx9ocXAcYS5Kh00p/d+td4z//MG21elnj4V8HiAd/zlpEIRWWG2p
q1jlh9/c+1n8aWW4HaPmKDlIvyN1WecEn408FUAHgB//jWHY2utmO9IjqvK2VJvL
eadcqxK8/tu5UP4QHZX8gSGwbK2vPyPXjx8hweuz5jE4cudE/mrvII4+gBTIWQrc
nduNusLYlCuebi4mE0nGopAMiWGvAw==
=EcZb
-----END PGP SIGNATURE-----

--d5aff4qmd2lfxgtx--

