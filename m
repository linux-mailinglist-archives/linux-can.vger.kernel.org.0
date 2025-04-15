Return-Path: <linux-can+bounces-3399-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86CDA897D7
	for <lists+linux-can@lfdr.de>; Tue, 15 Apr 2025 11:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBE43AA92F
	for <lists+linux-can@lfdr.de>; Tue, 15 Apr 2025 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296C1205AA3;
	Tue, 15 Apr 2025 09:25:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1908D284699
	for <linux-can@vger.kernel.org>; Tue, 15 Apr 2025 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709138; cv=none; b=oRfYcZl+lWTuZOGVzjhRb3gNP9lctOUMIO57OF1ReRryw0aPUR+I9LT2Kivx93/4g8M2ZptYa2+D1YROK5AnAqaNkO/3oe0eAhD3TBw4dQ4+nf4KN91OFk+gBO5OqKR9+AYyeTfmOJUteGt3t9o3WI7jM9kXWR/hrbl9vBHZls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709138; c=relaxed/simple;
	bh=Js0OYHUDBggbN21MupHzDCzb95swyEh3y+c7AxltwS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsV95kIUvOeESyqmhDUzcP8F/avg4Tj0yLfxr2gmSJL5ufSDurcoLaVmETsJxmYCy9PIn11Jeoncsul52vVdFO3q99CWPNaZvsoQ5mptg9xNtr+qYgp6Gq6ULcTnxX6OFm7Y648l1bGr/3m9ViIv+tsOACvEjJV7FHD6SU+dLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4cXf-0003Vx-Gq; Tue, 15 Apr 2025 11:25:19 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4cXe-000OZz-20;
	Tue, 15 Apr 2025 11:25:18 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B93643F9ADA;
	Tue, 15 Apr 2025 09:03:05 +0000 (UTC)
Date: Tue, 15 Apr 2025 11:03:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>, 
	Maxime Ripard <mripard@kernel.org>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>, 
	imx@lists.linux.dev, Christophe Lizzi <clizzi@redhat.com>, 
	Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
	Eric Chanudet <echanude@redhat.com>, Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] can: flexcan: enable PER clock before obtaining its rate
Message-ID: <20250415-olive-bulldog-of-acumen-f8ada3-mkl@pengutronix.de>
References: <20250414073646.1473157-1-ciprianmarian.costea@oss.nxp.com>
 <20250414-camouflaged-silver-dodo-d0c000-mkl@pengutronix.de>
 <e4bd8e47aeab761e409121ac9bc19408@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ea3nv5gvbkpg3kof"
Content-Disposition: inline
In-Reply-To: <e4bd8e47aeab761e409121ac9bc19408@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ea3nv5gvbkpg3kof
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: flexcan: enable PER clock before obtaining its rate
MIME-Version: 1.0

Hello Stephen,

thanks for your input.

On 14.04.2025 17:27:10, Stephen Boyd wrote:
> Quoting Marc Kleine-Budde (2025-04-14 02:55:34)
> > On 14.04.2025 10:36:46, Ciprian Costea wrote:
> > > From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> > >=20
> > > The FlexCan driver assumes that the frequency of the 'per' clock can =
be
> > > obtained even on disabled clocks, which is not always true.
> > >=20
> > > According to 'clk_get_rate' documentation, it is only valid once the =
clock
> > > source has been enabled.
> >=20
> > In commit bde8870cd8c3 ("clk: Clarify clk_get_rate() expectations")
> > Maxime Ripard changed the documentation of the of the function in clk.c
> > to say it's allowed. However clk.h states "This is only valid once the
> > clock source has been enabled.".
> >=20
> > I've added the common clock maintainers to Cc.
> >=20
> > Which documentation is correct? Is the clk.h correct for archs not using
> > the common clock framework?
> >=20
>=20
> I don't know what arches not using the common clk framework (CCF) do so
> I can't comment there.

The driver is used on Freescale/NXP SoCs: m68k (coldfire), arm, arm64.
Coldfire provides us directly with the fixed clock rate, so no clk_*()
functions are used there.

> If you want something to work on an architecture
> that doesn't use the CCF then follow the header file, but in all
> practical cases _some_ rate will be returned from clk_get_rate() and
> we're not going to BUG_ON() or crash the system in the CCF
> implementation for this case. Enabling the clk is good hygiene though,
> so is it really a problem to enable it here?

It's not a problem to enable the clock. If it would stay enabled, it
means a higher power consumption (I cannot quantify how much), as the
clock is only needed if the CAN interface is up. But we have more things
to cleanup:

For CAN controllers, information about the clock is more important than
for e.g. serial interfaces, so it's exported to user space. During probe
a CAN driver typically queries the clock rate with clk_get_rate()
(without enabling the clock) and stores the rate in a structure.

If the user space configures the bit rate of the CAN bus, the stored
clock rate is used to calculate the bit timing parameters. During ifup
the clocks are enabled and the previously calculated bit timing
parameters are programmed into the hardware.

In the early days of the stm32mp1 this has previously caused problems
because the frequency of the CAN clock changed between the initial
clk_get_rate() and the ifup.

For SoCs with CAN interfaces, the system designer usually configures the
CAN clock to a specific rate, so this problem does currently not occur.

What are our options?
- enable the clock before clk_get_rate(), disable it afterwards?
  -> This might be a bit more "hygienic", but doesn't solve the clock
     rate changes problem.

- clk_notifier_register() and update the saved rate
  -or-
- give our framework a pointer to the clock, so that it can do the
  query every time needed, instead of using the value from probe time

- delay the calculation of the bit timing parameter until ifup, do a
  clk_rate_exclusive_get(), re-calculate the bit timing parameters and
  program them into the HW

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ea3nv5gvbkpg3kof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmf+IMUACgkQDHRl3/mQ
kZxK2Qf9HAn4ob3h6aUeP89LLoGXCIV0BwaTLfdq/FfE8cdPJFaNYPqKfAQR0hCX
W09FS52Qo1YkODvj6fImAtavgZm6P3TCcJW8zORMyqI35BOVDYFz7oTkY1pUxx1N
8dqrIzX3orDTum9tY6N/lfaqb87hiBeNB1r4cJljtVBr0B/yU8xdDRdDYriejITs
WHbl5vkgTEIjuD6Tt26lf7Vm/8DPnsFok7+FCNlfwqGFaCsiiAxlKrmDhZbI1GVN
x4gNJ4I3j6T/muZaIyyEPgMH6HJijXFDMfzwiOlSUsMMjYJ6C+HzrHJgOEFxBB3/
1Fym0NSFmTKKNEqecO05pfEcccbDZg==
=ABXE
-----END PGP SIGNATURE-----

--ea3nv5gvbkpg3kof--

