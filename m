Return-Path: <linux-can+bounces-3720-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C858AC6D9C
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 18:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308961BC7ED7
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E089D28CF65;
	Wed, 28 May 2025 16:13:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE65728C871
	for <linux-can@vger.kernel.org>; Wed, 28 May 2025 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448781; cv=none; b=QcQ/JKtpjafa5qe87sIHfVepmD6eOmyEK7XuJEkgIPJFSXjP1JuxZnAlPsH+wTLixYkVEq/17VC+u7Xuaubo3SyFmVJCuGOgEYDoxTYX3MS0g+hp/oGWHfIR5mtu24+LNwLO1rFXEfaqDC6v7tISs0jCPQbxdQqdL6IHQSBxBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448781; c=relaxed/simple;
	bh=rf2vUQCyJVMs18UuH8zWKaMAjE/RtTO606L+oR/7iVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhmNcNTzrA3jY2qeMHmZk4rKbxupI+x08KLNaBpdD0nRcNplHUzhh+Z29oRvYQSRzahdnBUHC/pw0dj2F+0QN7D2alRKZEdR4voadcLv2Nw6UqKkfQyPtOslDtFFO+aqCUe+aWvintkKQpFQ4wufJVyxi0zA6jcO0aEDA7alsyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKJOg-0006o3-AQ; Wed, 28 May 2025 18:12:54 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKJOf-000cPL-2w;
	Wed, 28 May 2025 18:12:53 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8EB6741B94B;
	Wed, 28 May 2025 16:12:53 +0000 (UTC)
Date: Wed, 28 May 2025 18:12:53 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH 02/11] can: netlink: replace tabulation by space in
 assignment
Message-ID: <20250528-bronze-penguin-of-joviality-0ce1a8-mkl@pengutronix.de>
References: <20250527195625.65252-1-socketcan@hartkopp.net>
 <20250527195625.65252-2-socketcan@hartkopp.net>
 <20250528-quirky-ultra-hawk-37000f-mkl@pengutronix.de>
 <77c5a904-8b2c-4a78-890d-2777ddefe250@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ohjgbzt5cnnd4ftz"
Content-Disposition: inline
In-Reply-To: <77c5a904-8b2c-4a78-890d-2777ddefe250@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ohjgbzt5cnnd4ftz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 02/11] can: netlink: replace tabulation by space in
 assignment
MIME-Version: 1.0

On 29.05.2025 00:51:12, Vincent Mailhol wrote:
> On 28/05/2025 at 17:47, Marc Kleine-Budde wrote:
> > On 27.05.2025 21:56:16, Oliver Hartkopp wrote:
> >> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >>
> >> commit cfd98c838cbe ("can: netlink: move '=3D' operators back to
> >> previous line (checkpatch fix)") inadvertently introduced a tabulation
> >> between the IFLA_CAN_DATA_BITTIMING_CONST array index and the equal
> >> sign.
> >>
> >> Remove it.
> >>
> >> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >=20
> > The patches 2...5 look good to me. If Oliver adds his S-o-b, I can take
> > them for linux-can-next.
>=20
> If you prefer, I already submitted those in the past in a dedicated serie=
s with
> a proper cover letter:
>=20
> https://lore.kernel.org/linux-can/20241112165118.586613-7-mailhol.vincent=
@wanadoo.fr/

Even better.

> Because I got zero answers, I split it even further. This is why only one=
 patch
> got merge in for 6.15. I was planning to resend those clean-up patches an=
yway,
> but if you are OK to take them directly from my previous series, go ahead.
> Nothing has changed for these since November, except from the first patch=
 with
> was merged separately.

I've adjusted the cover letter, as patch 1 is already mainline, and
taken the rest of the series to can-next/testing. Note, once -rc1 is
out, I'll rebase this branch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ohjgbzt5cnnd4ftz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmg3NgEACgkQDHRl3/mQ
kZz7ggf/V7P1vS8/U85/aKJw9c+g9lK7l4x52DE2k8QNLtnGh6HsnjT4Bn9eIF5z
1Qe+itPcrBqj11gOQbpc4wQptQoDCJIMmwDX232AUHBcDNMvNLy21Lvhc9p3kztn
G0isG8pACq7cbaMlGJNulX4P0IsdDwFeLaz3mYOuVAH+MrNbaWHOpFSK2nigkzsK
OmDPydwrIHFs0NyBBpJsgy+fP4VlQVWJrDvNpziQe1dEjXCgf8NKEskZ2ens6NvI
x/j2G+zgV15PO/WmGZ51GRZoYSAkBhBTeeFzDjbUNJxR49KLRxVYWwnVeVa6feGL
MKC/Q0P/tiJ/JO0Q6g6/Hhd6DcnUSQ==
=zPQH
-----END PGP SIGNATURE-----

--ohjgbzt5cnnd4ftz--

