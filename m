Return-Path: <linux-can+bounces-4555-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94907B4AB0C
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 13:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523D24433E3
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 11:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC1524337B;
	Tue,  9 Sep 2025 11:04:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933662D0C82
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415852; cv=none; b=njDrb4+kNqWa4DJ+NPnS61YXn6vKt3AtDq4QTRh+8nJ2r30fUctxmmGe8damCi9EtqBn09xBAXGeGJzOcAtlBrYi6ZPQk5a5WL+WVJCrgMptYFSWqZJ5+uE+vmxFMCk6C7xudwBRIdAcK5tGJU0c7PlQauReXV8Jd950Rzi/phI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415852; c=relaxed/simple;
	bh=B8c2377KZdS+EHZcUQDQTlAZiq6HWEeL9hg1Ganu0hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRxNJ+iU8k7Le/L6BsaHNo/DW7+OJXziABvDukgTkrI0kMZzzHhJkDvmINgm+DsNN3R7XfPYF854KxDP/rkFFN+rx34Xk39MGVHt4rB6eABXMvsIoZRtxN2KpSsV631fTqiogTyKjqrDqurhJMFohgvn64kdVbJWXFpl06+nEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvw8m-0003MR-3W; Tue, 09 Sep 2025 13:04:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvw8k-000PEq-1b;
	Tue, 09 Sep 2025 13:03:58 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 31F2A469DDC;
	Tue, 09 Sep 2025 11:03:58 +0000 (UTC)
Date: Tue, 9 Sep 2025 13:03:57 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Alex Tran <alex.t.tran@gmail.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: networking: can: change bcm_msg_head frames
 member to support flexible array
Message-ID: <20250909-victorious-micro-copperhead-24eaa0-mkl@pengutronix.de>
References: <20250904031709.1426895-1-alex.t.tran@gmail.com>
 <a7c707b7-61e1-4c40-8708-f3331da96d34@hartkopp.net>
 <c649a695-caeb-4c20-b983-9035c396e145@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mcbodx5e3hand5vz"
Content-Disposition: inline
In-Reply-To: <c649a695-caeb-4c20-b983-9035c396e145@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--mcbodx5e3hand5vz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] docs: networking: can: change bcm_msg_head frames
 member to support flexible array
MIME-Version: 1.0

On 09.09.2025 12:35:46, Paolo Abeni wrote:
> On 9/4/25 8:25 AM, Oliver Hartkopp wrote:
> > On 04.09.25 05:17, Alex Tran wrote:
> >> The documentation of the 'bcm_msg_head' struct does not match how
> >> it is defined in 'bcm.h'. Changed the frames member to a flexible arra=
y,
> >> matching the definition in the header file.
> >>
> >> See commit 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays w=
ith
> >> flexible-array members")
> >>
> >> Bug 217783 <https://bugzilla.kernel.org/show_bug.cgi?id=3D217783>
> >>
> >> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> >=20
> > Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> @Mark, @Oliver: I assume you want us to apply this patch directly to the
> net tree, am I correct?

I'll take it.

> If so, @Alex: please use a formal 'Fixes:' tag for the blamed commit and
> 'Link: to reference the bz entry, thanks!

Will do.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mcbodx5e3hand5vz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjACZoACgkQDHRl3/mQ
kZwXkQf/UEh23x6d+laA+YYWTD4yIXfk/XOixd7eGpRJzaYl3wRVjM36gzRioI7H
kMIchzpl2QmrzKSvA+j5KTwfSkpotYAt4BMJA+X622lnoV2N3Up2KcsHAqwwbsYq
SPSm6NZbc+Pj4jKl+hFt7i7Yp/rnqJcM0LI061o1/rSU41WKPmj4e1iD0Uxc+OrM
QCd2Epdfd+p5QZUstr7yDErKUoxhoh38TkzqnX/22kmopWg+bfW3rEuqzyyT/3ev
20xX3Cb/GIoDDfisKfshlJwXlW5x3p2oADRUfykxmg9ghUoalO249XZYZ8owKMgy
Sjd0AC8KOBt87W/tXWdbO3FxQnvhEQ==
=3Dg+
-----END PGP SIGNATURE-----

--mcbodx5e3hand5vz--

