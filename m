Return-Path: <linux-can+bounces-4513-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB5FB48B27
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 13:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F74D188D421
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 11:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C16F2F99A5;
	Mon,  8 Sep 2025 11:10:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2412DE71C
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329848; cv=none; b=E8piKEj2uf71kIlhaADf2MOo/oJdjWsJWYiUIoUmxPEYEY7ha4QXKMDieKrqYoEVmg9VBOgikqQmWcYJHp88lj2RqLi0x6ScvroGHSYa4xy1fAJeaKQMxW7ELUy5QcfD2V2oF5X9ahmgGLhfwkVksXzmq15I+tOQAlYAJZPrk4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329848; c=relaxed/simple;
	bh=5T/BtOQ9kiQ4qfC8ekrNRQH9aekxhMgyAk46BGUkcYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnebjmhcZ7F/K7RGIB96PfMMmSZBrx32H1GMHL1KDPc8lfNeL9wRNhZSs6q01q8pEaBZJebrAVi6JqjGV7UnkDzVe1wMXhLfDPnROl0Ha+K7cmzowll2a6INAcUPCexCPj3Xv2sMeefbAKk7DVsNMwwUUtfjQhDJ8DMJaB+sv2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvZlh-00017L-0k; Mon, 08 Sep 2025 13:10:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvZlg-000EuB-2A;
	Mon, 08 Sep 2025 13:10:40 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 557F5469085;
	Mon, 08 Sep 2025 11:10:40 +0000 (UTC)
Date: Mon, 8 Sep 2025 13:10:39 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH can-utils] cangen: allow to use -m on classical CAN
 interfaces
Message-ID: <20250908-hilarious-myna-of-relaxation-f26357-mkl@pengutronix.de>
References: <20250907060330.441165-1-mailhol@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kiiuptld7a272mhi"
Content-Disposition: inline
In-Reply-To: <20250907060330.441165-1-mailhol@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kiiuptld7a272mhi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-utils] cangen: allow to use -m on classical CAN
 interfaces
MIME-Version: 1.0

On 07.09.2025 15:03:30, Vincent Mailhol wrote:
> The -m option currently only works on CAN FD or CAN XL interfaces.
> There is a logic to add CAN XL to the mix only if supported but CAN FD
> is always forced.
>=20
> Modify the -m logic so that only the options supported by the
> interface are added to the mix. This way:
>=20
>   - a Classical CAN interface only mixes -e and -R
>   - a CAN FD interface mixes -e, -R, -f, -b and -E
>   - a CAN XL interface mixes -e, -R, -f, -b, -E and -X
>=20
> This provides a better user experience and also makes -m a good
> default option for fuzzing any type of CAN interface.

I've created a PR on GH:
https://github.com/linux-can/can-utils/pull/599

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kiiuptld7a272mhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmi+uawACgkQDHRl3/mQ
kZxlSwf9EvFwK00XB+Wj2ZsLwP2fiWhT+aH8x19lCzx9M4z9E5lpJgT91Jv6gdY7
Qh9l/n3o32Mrf8S2JAN9uiQGz5UTi2GcuY4npEXVC/YIiwM29VUA9tBIc7pKBYrL
eAilQiFr2tJdUN1oYzRb7MAhqkJ34DwreXNv8aD8Ammb3uOOq5k93gl3Wh4WZ6zC
9KC784WQWkFIlXivXNZf+HJnKB/Sc3KTeYJKEUM0k364f5NpW577VEPTh8uvMnu+
KW9U33aRmWNM+2mVoN8Y+LJrgt4R7AqYYS3rB+ERNkUZpirkMjfxVv9Y1uNqIq5R
8EKlDQUB9nHRVea0KBloTsV8SbTRQQ==
=Lr2J
-----END PGP SIGNATURE-----

--kiiuptld7a272mhi--

