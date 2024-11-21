Return-Path: <linux-can+bounces-2165-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AA99D4FA7
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 16:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD251F2219E
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619EF1D7E4E;
	Thu, 21 Nov 2024 15:25:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D67230997
	for <linux-can@vger.kernel.org>; Thu, 21 Nov 2024 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202756; cv=none; b=rvemVDRZMCxWP4HxdQJCSEplyqOUic9CQ0VRRaWc3tixtcMJalHFfHCqbrxPsaD5IdjofyCWeqKBPuDpWfv1dCPtRXJIsxWFjjPvpjHvHoMxIJOrfyU8oBkBUGs1lhfWMgf1EfH12RenP/dwxDmzCaVzbSl8V35S+W35iTLRcDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202756; c=relaxed/simple;
	bh=oK0uQiqKh+/vdcnvCmhyFoYOyRWHiqqATD9Y2HjkXnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTUIIT287nxYxZpuJZatjRjc71OXcwWrxa6ezKQ+VAUhsqMIsnDUmr0L6XfNQx9Oc4VJxH/Hx9jM4dpF4cYgvzGbvT3uEAxjSm+VmNO4FL1XwsCZGnGehWIPsErrhDsxWGabpHVAPzuJT3rt8Q94Gj7fIB04Itrj+YcTn70CM3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tE93x-0008LV-Vh; Thu, 21 Nov 2024 16:25:45 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tE93x-001vS6-1s;
	Thu, 21 Nov 2024 16:25:45 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2E84B378B50;
	Thu, 21 Nov 2024 15:25:45 +0000 (UTC)
Date: Thu, 21 Nov 2024 16:25:44 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, n.buchwitz@kunbus.com, 
	p.rosenberger@kunbus.com, stable@vger.kernel.org, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: dev: can_set_termination(): Allow gpio sleep
Message-ID: <20241121-inquisitive-granite-hamster-b12a6f-mkl@pengutronix.de>
References: <20241121150209.125772-1-nb@tipi-net.de>
 <20241121-augmented-aquamarine-cuckoo-017f53-mkl@pengutronix.de>
 <c47b3d06-8763-4f69-b845-c7b58c9e2fd2@kunbus.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ogcxihj3qbcsrofe"
Content-Disposition: inline
In-Reply-To: <c47b3d06-8763-4f69-b845-c7b58c9e2fd2@kunbus.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ogcxihj3qbcsrofe
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: dev: can_set_termination(): Allow gpio sleep
MIME-Version: 1.0

On 21.11.2024 16:17:53, Lino Sanfilippo wrote:
> > On 21.11.2024 16:02:09, Nicolai Buchwitz wrote:
> >> The current implementation of can_set_termination() sets the GPIO in a
> >> context which cannot sleep. This is an issue if the GPIO controller can
> >> sleep (e.g. since the concerning GPIO expander is connected via SPI or
> >> I2C). Thus, if the termination resistor is set (eg. with ip link),
> >> a warning splat will be issued in the kernel log.
> >>
> >> Fix this by setting the termination resistor with
> >> gpiod_set_value_cansleep() which instead of gpiod_set_value() allows i=
t to
> >> sleep.
> >>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> >=20
> > I've send the same patch a few hours ago:
> >=20
> > https://lore.kernel.org/all/20241121-dev-fix-can_set_termination-v1-1-4=
1fa6e29216d@pengutronix.de/
> >=20
> Shouldnt this also go to stable?

Until today no-one complained about the problem, but I'll add stable on
Cc while applying the patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ogcxihj3qbcsrofe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc/UPYACgkQKDiiPnot
vG9IOwf/Xe9QldZzK3oY8FulDCyFTGhkQ/QLlekheNDEoEshpuKTEM9bNypg820V
d0BtTboD3LudGIca4aoyFiYpko1B9UA7rNsylK4A85ZdphA6r1Wmw9qibOlpHH1V
PYJ0ftVJcW2t6MsXjtcPkHSZCCZv70KPh7h2bX4yJ/y9RJ711E67kiN1wscv+5tM
xSmWqR+ONxt6/kadkeGM4CwwKbBn0Ygm1SV3tYpyTQ07DRYvlJnpXmSShEu3Tuz6
igUEltviWwMBC3TTGbsXfjBetQOy2gk9+QNHRIQUOg5BvcB+fSjaXC9AuJqMHSeD
mGKdDReZlR8/jgtYQKtb23hvbQcrcQ==
=S3ok
-----END PGP SIGNATURE-----

--ogcxihj3qbcsrofe--

