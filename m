Return-Path: <linux-can+bounces-4577-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B9DB4FF74
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 16:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E8F4E3642
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19FB32252E;
	Tue,  9 Sep 2025 14:31:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AD41F3BAE
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428309; cv=none; b=DjOvYXSBZTQqk+AkLsIpV+R2FH3ljim4hiPCLN+dkeQKL47p4Yq8FaY2nrCpR/V6fzYWicqkxrG+O3jPSDoSWuX0CBqPeD/wALDWgtAvxgYLjLX3RSWJ6ebnPvZ3+cP8+g2aM5BCvpREo2yJp1f/SBG9mRVpeCeC3s4dcV8parw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428309; c=relaxed/simple;
	bh=TreZvkxp8XSRxg997tJky3Hnu4lPLXSt72DP2Lzhp98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQCBUvERhueLy+JYHKPGvuL/S+VCpNvKS15EcO+qvjSOTI2n8ZDT5SRSlK7IBBtY5vECLPktC5EE0T/xiux4VVNJKhYLbwHsjQEqETggUl0fPMe3zElSBDqTWXFAh+0Lkm0ba0sZBUSUZ708lv1N9rNy1fvYpfCK+BAmiAS7XD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvzNd-0004n5-H2; Tue, 09 Sep 2025 16:31:33 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvzNb-000R8v-2Z;
	Tue, 09 Sep 2025 16:31:31 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6426B46A15E;
	Tue, 09 Sep 2025 14:31:31 +0000 (UTC)
Date: Tue, 9 Sep 2025 16:31:29 +0200
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
Message-ID: <20250909-bulky-wolverine-of-artistry-49749f-mkl@pengutronix.de>
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
 <20250812-m_can-fix-state-handling-v1-3-b739e06c0a3b@pengutronix.de>
 <DC74JEKBB6HL.1LJ53UZJ0T0Q9@baylibre.com>
 <DC74YGSPTL16.KG2SWZD4L3YV@baylibre.com>
 <20250909-nightingale-of-strange-defense-631196-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e54chjukw6j4z4mj"
Content-Disposition: inline
In-Reply-To: <20250909-nightingale-of-strange-defense-631196-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--e54chjukw6j4z4mj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/7] can: m_can: m_can_handle_state_errors(): fix CAN
 state transition to Error Active
MIME-Version: 1.0

On 09.09.2025 16:28:48, Marc Kleine-Budde wrote:
> On 20.08.2025 11:09:16, Markus Schneider-Pargmann wrote:
> > >> --- a/drivers/net/can/m_can/m_can.c
> > >> +++ b/drivers/net/can/m_can/m_can.c
>=20
> [...]
>=20
> > >> +static enum can_state
> > >> +m_can_can_state_get_by_psr(const u32 psr)
> > >> +{
> > >> +	if (psr & PSR_BO)
> > >> +		return CAN_STATE_BUS_OFF;
> > >> +	if (psr & PSR_EP)
> > >> +		return CAN_STATE_ERROR_PASSIVE;
> > >> +	if (psr & PSR_EW)
> > >> +		return CAN_STATE_ERROR_WARNING;
> > >
> > > Why should m_can_handle_state_errors() should be called if none of th=
ese
> > > flags are set?
> > >
> > > m_can_handle_state_errors() seems to only be called if IR_ERR_STATE
> > > which is defined as:
> > >   #define IR_ERR_STATE	(IR_BO | IR_EW | IR_EP)
> > >
> > > This is the for the interrupt register but will the PSR register bits=
 be
> > > set without the interrupt register being set?
> >=20
> > After reading the other users of the above function, I do see why this
> > was added. I am still wondering if there is a way to return to
> > ERROR_ACTIVE once the errors are cleared from the error register.
>=20
> Sorry, I don't get what you mean.
>=20
> > Also looking at all the users added for the function above, could you
> > read the register inside the function? Currently you are adding a
> > reg variable and a read call for each call to this function.
> > m_can_handle_state_errors() also doesn't need the psr value with your
> > refactoring.
>=20
> That makes sense.

I'm also preparing the driver to have error handling for all register
reads...so I'll have to return in case of an error and pass the state
via a pointer.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--e54chjukw6j4z4mj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjAOj0ACgkQDHRl3/mQ
kZwWrgf7BdY+ptahLZATa0AFzO3ZIBhl10JwGw7j/tNeoWTipUKn3AqbczOUvYXC
u0+WcPO86QHgc4xcprtJSkd1pYn1mpNk/y4CXQg+qyWIZlGsx+ibWRDxBFotcqKz
E1IYFSKJQnyGVtH+mUkR4Y4+1i5h+zGQMDZ0YUqFFq8EfueYyDvHpyzJ6z0DXAzD
rIsTz7FRk76MDyTiFmNQvWs6MaQnJAEqi9vALE4C6SiL4w3tmxGiVSazy3frMCVR
5W5u82ZwxJxt73979tSGoOG5jplz0GfIpmrACkVXS/Eob+0NIvTNrjkCgSK2XXbB
7axFr/+mPlY2qj7Fo57iCwZh43aAtA==
=XkXU
-----END PGP SIGNATURE-----

--e54chjukw6j4z4mj--

