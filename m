Return-Path: <linux-can+bounces-4575-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AD3B4FF50
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 16:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36AE44E2FB2
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 14:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3786E1F0E2E;
	Tue,  9 Sep 2025 14:25:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E703451B6
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427941; cv=none; b=aEm8Ia72yARR2bWVOOCr805ncqZr0Q3oCmYQ9XkcYFQoGSrTznA1pzljrE8XgCRh563SYHsEp/6rDzh4h0D8qz9Cfu0IzRRr0VCGcC9SIWVEaswdHV62fsbZvpZviD/NWaxuGgNyJ00zqVjZFUORq+AUO5wm8s8FUoOldAX6WzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427941; c=relaxed/simple;
	bh=uNGcIq+ZR3PxycUsDS2PV0JGZ8EK/zbw9hMatiX9My4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ngk84Ll6sTGUc3Rx30p0N0sm2Y9gd8sl41w54aYVcDgS04gqLENGCcGGRC4KkNNR2lMqalLCfJSKszLFCCuHe+Mbbxr9U71lkFYfkK3sdoxtjH9p126+GJZI8feKaKEs7Zwl5ASF5BjFXG/V26Ex1sqv0uiV2+CReo1eCHBuK9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvzHm-0003Rk-AN; Tue, 09 Sep 2025 16:25:30 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvzHk-000R8L-1A;
	Tue, 09 Sep 2025 16:25:28 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CFBC246A13B;
	Tue, 09 Sep 2025 14:25:27 +0000 (UTC)
Date: Tue, 9 Sep 2025 16:25:26 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Patrik Flykt <patrik.flykt@linux.intel.com>, 
	Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
	Varka Bhadram <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH 3/7] can: m_can: m_can_handle_state_errors(): fix CAN
 state transition to Error Active
Message-ID: <20250909-faithful-devious-jaguar-99b51c-mkl@pengutronix.de>
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
 <20250812-m_can-fix-state-handling-v1-3-b739e06c0a3b@pengutronix.de>
 <DC74JEKBB6HL.1LJ53UZJ0T0Q9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f3rl4hv3iqttmmyj"
Content-Disposition: inline
In-Reply-To: <DC74JEKBB6HL.1LJ53UZJ0T0Q9@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--f3rl4hv3iqttmmyj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/7] can: m_can: m_can_handle_state_errors(): fix CAN
 state transition to Error Active
MIME-Version: 1.0

On 20.08.2025 10:49:35, Markus Schneider-Pargmann wrote:
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -812,6 +812,10 @@ static int m_can_handle_state_change(struct net_de=
vice *dev,
> >  	u32 timestamp =3D 0;
> > =20
> >  	switch (new_state) {
> > +	case CAN_STATE_ERROR_ACTIVE:
> > +		/* error active state */
>=20
> This comment and the one below don't really help IMHO.

both removed

> > +		cdev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> > +		break;
> >  	case CAN_STATE_ERROR_WARNING:
> >  		/* error warning state */
> >  		cdev->can.can_stats.error_warning++;
> > @@ -841,6 +845,13 @@ static int m_can_handle_state_change(struct net_de=
vice *dev,
> >  	__m_can_get_berr_counter(dev, &bec);
> > =20
> >  	switch (new_state) {
> > +	case CAN_STATE_ERROR_ACTIVE:
> > +		/* error active state */
> > +		cf->can_id |=3D CAN_ERR_CRTL | CAN_ERR_CNT;
> > +		cf->data[1] =3D CAN_ERR_CRTL_ACTIVE;
> > +		cf->data[6] =3D bec.txerr;
> > +		cf->data[7] =3D bec.rxerr;
> > +		break;
> >  	case CAN_STATE_ERROR_WARNING:
> >  		/* error warning state */
> >  		cf->can_id |=3D CAN_ERR_CRTL | CAN_ERR_CNT;
> > @@ -877,30 +888,29 @@ static int m_can_handle_state_change(struct net_d=
evice *dev,
> >  	return 1;
> >  }
> > =20
> > +static enum can_state
> > +m_can_can_state_get_by_psr(const u32 psr)
> > +{
> > +	if (psr & PSR_BO)
> > +		return CAN_STATE_BUS_OFF;
> > +	if (psr & PSR_EP)
> > +		return CAN_STATE_ERROR_PASSIVE;
> > +	if (psr & PSR_EW)
> > +		return CAN_STATE_ERROR_WARNING;
>=20
> Why should m_can_handle_state_errors() should be called if none of these
> flags are set?
>=20
> m_can_handle_state_errors() seems to only be called if IR_ERR_STATE
> which is defined as:
>   #define IR_ERR_STATE	(IR_BO | IR_EW | IR_EP)
>=20
> This is the for the interrupt register but will the PSR register bits be
> set without the interrupt register being set?

The IR_ERR_STATE will be set if there was a _change_ in corresponding
PSR register's bits.

With successful transmission/reception the corresponding error counter
decrease and if a threshold is crossed the state changes.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--f3rl4hv3iqttmmyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjAONMACgkQDHRl3/mQ
kZyliAf/ceMUBCHutAOryEMbbIWug1YkHAQvL7QNu0qjuqlkVtecmu8CJe0fjL7j
/Qb6TpI/hphna8fyakI8qfElK7rICztW1AX4rpEtshqZcUrXO+f5TfMnboATUXpd
Y5oPqTF8ZJSQJGi0SnORPJvUWlLBKtEn5PeXHNca7RDzzs4W40Z3e2EEVzd4eP3X
ek4uxCPV6YNcy5anDWziBRj+z3oVDxWUI/jRc4gWNf0g++cRuYnEa48vCGZ1Uhg5
ImBnZC+szUaxzXmXXNBQ4pqcdOcYs+4IVRkFnJSjG95oANj8CDSYbh4Cvl9va8ji
J7t0rAsE2qvnycJj5XmYnZc/WOvV9A==
=IVoy
-----END PGP SIGNATURE-----

--f3rl4hv3iqttmmyj--

