Return-Path: <linux-can+bounces-6066-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ED1D08C4E
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 11:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7595305B58E
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 10:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C09133A9CD;
	Fri,  9 Jan 2026 10:56:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B073382EF
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956203; cv=none; b=rxz4oxQEAjwPdr8OhaLP/2E+XtfFkx9O/VkgopqFZ/e8gSseX7wM4ZQuXkHWE5zk/34CqltsrviBHOCUFgBryMt4Oib/F4XQkmf+x5hOepi8CRsyUM++zJQ8VOihpSR6wQgqRNEl8LWqdui4aj1//gdUYVgXEkxdVD41wGMZwTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956203; c=relaxed/simple;
	bh=J0Sxl4vU8l9+D53XccRv0UWJqsotLxwL/KtSOnsvyqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3aBLOc5wEIF6Od50EzfrEjHYlsfZ0oAH2CRlgLfVNLqWNECwFEd0KU6Mzh0a9tsTDbMK0vAO1APkxw+zGaP2N6Xm4ubKJOg5zNIfZp+bZBNarRwmqI43QH5EqBw6ZKamPs96DKdR1BgA6GowpN/ygG7VDwDUns0yhxN46pA7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1veAAU-0008BG-4J; Fri, 09 Jan 2026 11:56:34 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1veAAS-009pcJ-2B;
	Fri, 09 Jan 2026 11:56:32 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D9ED84C97BD;
	Fri, 09 Jan 2026 10:56:31 +0000 (UTC)
Date: Fri, 9 Jan 2026 11:56:31 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Pavel Pisa <pisa@fel.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>, 
	linux-can@vger.kernel.org, David Laight <david.laight.linux@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Andrea Daoud <andreadaoud6@gmail.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Jiri Novak <jnovak@fel.cvut.cz>
Subject: Re: [PATCH v2] can: ctucanfd: fix SSP_SRC in cases when bit-rate is
 higher than 1 MBit.
Message-ID: <20260109-meek-dexterous-jaybird-20f9f9-mkl@pengutronix.de>
References: <20260105111620.16580-1-pisa@fel.cvut.cz>
 <c5851986-837b-4ffb-9bf7-3131cf9c05d1@kernel.org>
 <202601060153.21682.pisa@fel.cvut.cz>
 <c3dd8234-3a7e-4277-89cf-1f4ccb2c0317@kernel.org>
 <20260109-robust-clay-falcon-2f3ecb-mkl@pengutronix.de>
 <25616e3d-9fd9-491e-9a93-fa48d3e7ba2c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="msdgz4pwflqfzkg7"
Content-Disposition: inline
In-Reply-To: <25616e3d-9fd9-491e-9a93-fa48d3e7ba2c@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--msdgz4pwflqfzkg7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: ctucanfd: fix SSP_SRC in cases when bit-rate is
 higher than 1 MBit.
MIME-Version: 1.0

On 09.01.2026 11:50:42, Vincent Mailhol wrote:
> On 09/01/2026 at 10:29, Marc Kleine-Budde wrote:
> > On 06.01.2026 23:14:47, Vincent Mailhol wrote:
> >>> thanks for pointing to Transmission Delay Compensation
> >>> related code introduced in 5.16 kernel. I have noticed it
> >>> in the past but not considered it yet and I think
> >>> that we need minimal fixes to help users and
> >>> allow change to propagate into stable series now.
> >
> > How to proceed. Take this fix now an (hopefully) port to the mainline
> > TDC framework later?
>
> While I would definitely prefer to see the TDC framework implementation
> rather than this quick fix,

ACK

> I will also not block it.

thanks

> If you feel confident to continue with that patch, go ahead.

I think the patch has been tested and as far as I understood the patch
was used internally for some time. So applied to linux-can, added stable
on Cc and added a fixes tag.

thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--msdgz4pwflqfzkg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlg3twACgkQDHRl3/mQ
kZxNrQgAlk4TzqvrRZWIZparxSLvYu2lqpNS7mlDtHR20ficHdnLG1YyAAbHFVLc
B68drUCHzjv/QJiZFN2h5I/glUqtnSCzfI0jrEwm5/6staSiBIo7z2cKxiAJPEIo
ne50o0adNjQ0TspBR7UqSLY8DFwk0OWb+IiZwpHrIC5BaN8Uk/xCVGQigfKX8Gmq
6TU42TCh+a5eTziaSpq+9NGB5f6Mvnlwwa1jG+L/wnrO9rcnRr1s4GhUIge9LSfH
9jCazYhhrcD8Uycbvgkci7rpn4RPfolfnANlQ1ZZGmN5Lbi4z6O5ziJ6AVVjyK51
nCrvEzvNWnCtAHlJYxBgx+VEj3k7YA==
=6V0j
-----END PGP SIGNATURE-----

--msdgz4pwflqfzkg7--

