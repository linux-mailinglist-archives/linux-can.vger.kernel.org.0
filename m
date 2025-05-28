Return-Path: <linux-can+bounces-3721-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67348AC6DA5
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 18:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319A816A724
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2222A1632C8;
	Wed, 28 May 2025 16:14:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BFD28A415
	for <linux-can@vger.kernel.org>; Wed, 28 May 2025 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448876; cv=none; b=I9GzMEOPET6Bka6ROJKtHGMP6EmU8VniPKFN/OwuVK2Q2B/kKbIAv6uV1repOnjKH/h5TZUyK6dfVKnivibRpZfoNPaoUs0ceFidWQE0sO6GGhmcHE6KgLMkovux8ozAocoEJbLo4cMGhXepwc7shAD9ITTrVc/La9Hvr3VxMeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448876; c=relaxed/simple;
	bh=evkglJcT5jvVSXEIL44FKK2hHH2M8hsbfYh2wdvL/e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK1gbT2GlKfYv9qXkKx09SCI2xGOlAacWXG1gJqlsA8/acfFU/t/ipQPE05pnmxpqbDmXeCn9dhlt58V/P7FR04nNQDd11/u00uyfNU6/SCmAGENu6BpNTgYPu5UvAw5lf9ps+PIybdS4YhDKzuiOqX6k9zFGMqmOrBNR8C7BmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKJQF-0007xQ-Dh; Wed, 28 May 2025 18:14:31 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKJQF-000cPV-0I;
	Wed, 28 May 2025 18:14:31 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CF25041B950;
	Wed, 28 May 2025 16:14:30 +0000 (UTC)
Date: Wed, 28 May 2025 18:14:30 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org
Subject: Re: Latest patches - Re: CAN XL netlink AIP status
Message-ID: <20250528-discreet-hummingbird-from-valhalla-d1edc2-mkl@pengutronix.de>
References: <1c502316-ddee-4f12-b0b8-3725cc522591@hartkopp.net>
 <AM9PR10MB418448751B1DA83EED7F50D4D498A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <63f2f51e-3fbd-4c8b-b7e4-29cb55246eaf@hartkopp.net>
 <AM9PR10MB41846346BC291F7CFE2CB71DD498A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <49245439-9822-449d-bf2c-5626349d909c@hartkopp.net>
 <20250527-lilac-panther-of-destiny-a13500-mkl@pengutronix.de>
 <AM9PR10MB4184E0842D24A4D7A2FEE09BD464A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <20250527-glistening-dog-of-apotheosis-293bd2-mkl@pengutronix.de>
 <04a7058c-95c7-4adc-a447-423aec0e0077@hartkopp.net>
 <20250528-pastel-quoll-of-genius-d1423a-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yrqofigxhxevpdjt"
Content-Disposition: inline
In-Reply-To: <20250528-pastel-quoll-of-genius-d1423a-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--yrqofigxhxevpdjt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Latest patches - Re: CAN XL netlink AIP status
MIME-Version: 1.0

On 28.05.2025 10:02:47, Marc Kleine-Budde wrote:
> On 27.05.2025 21:55:52, Oliver Hartkopp wrote:
> > I uploaded the latest work on this GitHub repo where you three (in To:)=
 are
> > requested as collaborators:
> >=20
> > https://github.com/hartkopp/canxl-nl
>=20
> Thanks!
>=20
> > Additionally I will send the patches for iproute2 and the Linux kernel =
here
> > on the mailing list for further discussions.
>=20
> I've imported your series [1] to a git tree, that make development
> easier than working on patch files.=20
>=20
> [1] https://lore.kernel.org/all/20250527195625.65252-1-socketcan@hartkopp=
=2Enet/
>=20
> The branch is called b4/can-xl and is available on my git.kernel.org acco=
unt:
>=20
> | https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/=
log/?h=3Db4/can-xl
>=20
> Oliver, regarding the series, I'm missing your Signed-of-by for
> Vincent's patches.

I've updated the b4/can-xl on top of current can-next-testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--yrqofigxhxevpdjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmg3NmMACgkQDHRl3/mQ
kZziNQf/ZxWoKBqS8YLzVdA3XfGD8dv/septBcz8WLeDshR6u66NWnQZvIED+L9s
PNlUde4hZ4g3KvRuE0nX1tyfsUzxskRIeVYxT9gvFc01G/0hAzq8HAWb9cJevMzy
0q6zLKNtaLUM8Q5/gHg4vJjDk4TzkX3us/UktY5y+JZ6rIbraAgyBkWdq86w9FUc
Ihc62YIeCadBgUWG+as+aOlhcymP6+YHttsFBFSUUrvwiD1dgMfZ7xI+GTkpc0S4
7u17MYWr29Qfn6I3IaC2QLm0dZD6v5nPUsM9ED9zXj27Vlm0MvD8JlyC9Jtkat4W
7Jyp3AXFgpJucZhWpJ7zEpJkHCmTgA==
=pzDy
-----END PGP SIGNATURE-----

--yrqofigxhxevpdjt--

