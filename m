Return-Path: <linux-can+bounces-3111-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B722FA64700
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 10:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC7C188BB38
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1358B21C173;
	Mon, 17 Mar 2025 09:21:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D09D156230
	for <linux-can@vger.kernel.org>; Mon, 17 Mar 2025 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203309; cv=none; b=h3fnTuuN1G/siGlv93rHYmi/5aMq0JFLvD/cqmuTdOGo3TbWpxQh+IgNYXhMGQC2YltCGVZy70TH1c59ONR4ke2EX3LlyNXceoqozc4NT/HdSfqmvLPr4uUDGK0vIfv6mS7+qlAW4uM7+3xY2+B6RrOvzTBqSPkedDTjd8qpZRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203309; c=relaxed/simple;
	bh=jZxRwZj7R0cei6bgW8nyC2AhEv15ffeAWLYgoLcPAEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR6qcTMaCD6HpewBjpk+3wr7fhw52KbNP/j6O/wWgHJuMqUwGe4Ai/kv8iYaj423wRI0+l87ZDR0eZqllJoXVyFaEBbsjmA7a7PH+ZcnvsSDNxIMTAhvnklHZ98QEdImYO17TslmVCFrDMKY0KDnCUDxWjWUGeVTiEp7lKYzg7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tu6f9-0006qJ-E0; Mon, 17 Mar 2025 10:21:35 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tu6f8-000Diy-1y;
	Mon, 17 Mar 2025 10:21:35 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3CAD13DD0E7;
	Mon, 17 Mar 2025 09:20:46 +0000 (UTC)
Date: Mon, 17 Mar 2025 10:20:44 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Davide Caratti <dcaratti@redhat.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: add protocol counter for AF_CAN sockets
Message-ID: <20250317-muscular-ancient-weasel-ad4392-mkl@pengutronix.de>
References: <9db5d0e6c11b232ad895885616f1258882a32f61.1741952160.git.dcaratti@redhat.com>
 <20250314-messy-fierce-squid-0ce7c3-mkl@pengutronix.de>
 <7e35b13f-bbc4-491e-9081-fb939e1b8df0@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zqheasavwo6wufin"
Content-Disposition: inline
In-Reply-To: <7e35b13f-bbc4-491e-9081-fb939e1b8df0@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--zqheasavwo6wufin
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: add protocol counter for AF_CAN sockets
MIME-Version: 1.0

On 16.03.2025 13:39:16, Oliver Hartkopp wrote:
>=20
>=20
> On 14.03.25 13:31, Marc Kleine-Budde wrote:
> > On 14.03.2025 12:39:49, Davide Caratti wrote:
> > > The third column in the output of the following command:
> > >=20
> > >   # grep CAN /proc/net/protocols
> > >=20
> > > is systematically '0': use sock_prot_inuse_add() to account for the n=
umber
> > > of sockets for each protocol on top of AF_CAN family.
> > >=20
> > > Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> >=20
> > Applied to linux-can-next.
> >=20
>=20
> Maybe too fast? E.g. J1939 is not handled.
>=20
> https://lore.kernel.org/linux-can/78951192-82b1-45bc-9903-d314c94cd182@ha=
rtkopp.net/T/#m87afc41fef8ec9099344c753e32b06f302cc0e39

Can IMHO  be added in a later patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zqheasavwo6wufin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfX6WkACgkQDHRl3/mQ
kZyZyQf9HgwcWWhwt6AwzNiiKdcu/Yp/n1Xq06Vv0ov81SpNNDaXjmLnc/CmZpMy
Xd+2mf70EbjyeanmmjKMbh0bJPf6OrRGL+0RtRPS4jpNA4/ocFQplv1ZvACSJYGZ
UVUv2s+7QnPK+t0750YEYW1Pyfc68AaLIOIslwTUocFU3kEVgWMqwc8O1h0aeKkB
XGoqZXyXW0ILAF6JPFhLS+w5MAon2xgwlKoorOFoj5Q/wjAHO0BZxTuJ8onl+3UI
x3LTQWYnwFYfQk0dug/pu0HEjX7+yKQWK62HiTjeWyIWeQ3Iwv6KzeIPpkvF/q8H
/m3PCUWcGhGrAltUMB2IABund5sWaw==
=Bfb4
-----END PGP SIGNATURE-----

--zqheasavwo6wufin--

