Return-Path: <linux-can+bounces-1550-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E751B983D08
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 08:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EC81C21679
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 06:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD1D47A73;
	Tue, 24 Sep 2024 06:21:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC5353373
	for <linux-can@vger.kernel.org>; Tue, 24 Sep 2024 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158875; cv=none; b=fqIAZONJ+oCuPsDU7WI3zN3W06J3CrQqTm30uGOOH5STiu3e/v2LFb/wBwoVBM1vlEoAp0P8ifV7gGKOefhbSjKRkyqUP1FVJSVRiWW0gD46WFFisxKAwZWMLv+TTwNhkhDG2xS/dLTkEINR64Rbmkmx/eCFJHZjVZNlD5ERQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158875; c=relaxed/simple;
	bh=QG/VKk0vH17/JF2w8zE89ygq5JrJkgBerB73y4hm/6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/q3aQtC+/dqAFaLdV9jQmi+2CSD0yrNHY8ygfTq6kVrtQl8A8v8cr048GkAz7NfWhP+FLF9ixRabxzFeqBkkDXCLhIVTJ2DcE9vm43/pYuyoaucu+ErSCBJogTkqPzUQoDV6kvTQZc8L3lhFkAXG5a4a1LFTrMJAR7nh4gakEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssyv7-0006zf-Qe; Tue, 24 Sep 2024 08:21:09 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssyv6-0018DL-Un; Tue, 24 Sep 2024 08:21:08 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 366D4341953;
	Tue, 24 Sep 2024 06:21:08 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:21:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: Oops on mcp251xfd open on 6.6.52
Message-ID: <20240924-goose-of-undeniable-discussion-efc300-mkl@pengutronix.de>
References: <20240923115310.GA138774@francesco-nb>
 <20240923-spry-badger-of-perception-303c63-mkl@pengutronix.de>
 <20240923120027.GB138774@francesco-nb>
 <20240923-quixotic-okapi-of-rain-99ae09-mkl@pengutronix.de>
 <ZvHugNKM-Ilu4K3K@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="petlyah5sixnu6i7"
Content-Disposition: inline
In-Reply-To: <ZvHugNKM-Ilu4K3K@gaggiata.pivistrello.it>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--petlyah5sixnu6i7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.09.2024 00:41:04, Francesco Dolcini wrote:
> Hello Marc,
>=20
> On Mon, Sep 23, 2024 at 04:36:16PM +0200, Marc Kleine-Budde wrote:
> > On 23.09.2024 14:00:27, Francesco Dolcini wrote:
> > > On Mon, Sep 23, 2024 at 01:57:07PM +0200, Marc Kleine-Budde wrote:
> > > > On 23.09.2024 13:53:10, Francesco Dolcini wrote:
> > > > > I got the following Oops on doing a simple ip link set canX up, r=
unning
> > > > > on an i.MX8MM SoC.
> > > > >=20
> > > > > This was reproduced with some automated testing, I have not tried=
 to
> > > > > reproduce it so far. Any idea or hint? It seems systematic, intro=
duced
> > > > > around 12th september on the v6.6.y branch.
> > > >=20
> > > > Which Kernel version are you using?
> > >=20
> > > v6.6.52 is reproducing the issue, I guess it started on some previous
> > > v6.6.x kernel (with x < 52), but I was not able to dig out the logs
> > > running on older kernel from our automated testing (yet).
> > >=20
> > > I was not able to test mainline (yet).
> >=20
> > Can you cherry-pick these and see if it fixes your problem?
> >=20
> > 51b2a7216122 ("can: mcp251xfd: properly indent labels")
> > a7801540f325 ("can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() =
into mcp251xfd_chip_start/stop()")
>=20
> Yes, these 2 commits fix the issue.
> In addition I noticed that also 6.1.111 is affected by the exact same Oop=
s.
>=20
> Thanks!

Thanks for testing!

> BTW, to reproduce, just
>=20
>   ip link set can0 type can bitrate 1000000
>   ip link set can0 up=20
>=20
> How to we move forward now? Would you ask greg to backport to stable kern=
el also
> these 2 patches

Yeah, that's pretty much what I'm going to do now :).

> (I assume that something was backported that broke the
> functionality at some point)?=20

Yes, it's:

upstream:
| 24436be590c6 ("can: mcp251xfd: rx: add workaround for erratum DS80000789E=
 6 of mcp2518fd")

v6.6:
| 5ea24ddc26a7 ("can: mcp251xfd: rx: add workaround for erratum DS80000789E=
 6 of mcp2518fd")

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--petlyah5sixnu6i7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbyWk8ACgkQKDiiPnot
vG81bwf/Vv5q7BkaOfvk1sOVuKf056y8/+bnhBF5naIdJoHZL7o9gOKi6YKfkt12
piLV0dqGPoba7GWArODioWZ+frcfJeh7wBInJKQI8BANLTGc877QJ5m1PtQ+JbWn
hojx/3tTbdd+x68aQkk3rrupJRPqp6iUrka2KipiHGsehnF8qjzems1rG1Zq0zf+
r9JGp6qSILW+NIjlFzaqr7zMU7lpNxHCO9YK2AcqKvbUad9+ZSe8Y6QY3/fmcEyu
QfhqN3+tdOgCogL4Y8jGRI/BLW5rPSX7ccOSqXpNq6B1fFo6LCzj712T8dYrlm6S
eron5D20kG680nea0KlVD8OKqe2vDA==
=prB/
-----END PGP SIGNATURE-----

--petlyah5sixnu6i7--

