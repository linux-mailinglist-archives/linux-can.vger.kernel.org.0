Return-Path: <linux-can+bounces-292-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC983857DB1
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 14:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37257B220BC
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 13:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B54129A80;
	Fri, 16 Feb 2024 13:30:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1E8768ED
	for <linux-can@vger.kernel.org>; Fri, 16 Feb 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090207; cv=none; b=eNOrS5lim6xO6ZU31uQMKb0q6evXhxU3N3wHMtokp1ew43fmsYry7Vp3CgVZo2V+BsaqFFsrx/NRkZf7Avao7Z1w1pn7nnXZE8yc2eM1U6In+ReRMU3KWU97g1oDdKxkRuryd3/3S88g/26/hfYKx+29jHc+M2IcY1aBvUkdXDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090207; c=relaxed/simple;
	bh=W0NgYBg8z25QPIAqi0hcC9IHVP9Do1RoScCzZvKTOec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPO+9Xhxv0cO3uP+crI+kX8LpaSrIs7RnPYJjvFcoiXnxZz2vYrUbzz+4TMQN+IEltyMbouR7H0vUjJwXKR07z/8W+nJWzgpZn0Fatnrakysyi5twWiL6hZ2lwWOwRxoDlWj22089cBhenr4m43wVWQ/BSLS4wOeJ58aoeLoIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rayHy-0002M9-HA; Fri, 16 Feb 2024 14:30:02 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rayHx-0015Nt-Vc; Fri, 16 Feb 2024 14:30:02 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A7B2A290437;
	Fri, 16 Feb 2024 13:30:01 +0000 (UTC)
Date: Fri, 16 Feb 2024 14:30:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 1/3] can: peak_usb: fix potential "UBSAN:
 shitf-out-of-bounds" issue
Message-ID: <20240216-distrust-unreeling-dd88d5845959-mkl@pengutronix.de>
References: <20240215152656.13883-1-s.grosjean@peak-system.com>
 <20240216-storewide-province-2a26f06f2205-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iagkhksmhlmhnami"
Content-Disposition: inline
In-Reply-To: <20240216-storewide-province-2a26f06f2205-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--iagkhksmhlmhnami
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.02.2024 14:22:02, Marc Kleine-Budde wrote:
> On 15.02.2024 16:26:54, Stephane Grosjean wrote:
> > Shift exponent 32 is too large for 32-bit type 'int' so u64 values are
> > used instead.
>=20
> FYI: Consider migrating this code to timecounter_read/cyclecounter. See

This patch is good as it is, the conversion to
timecounter/cyclecounter is future work.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--iagkhksmhlmhnami
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXPY1YACgkQKDiiPnot
vG8LBAgAmEbemW62DRq40D1PTNLZshSJQJkXt06BhAQJBktfw+WJKVZ2N3nIMkSm
XmGJvY2RU4kM3w9XaYUGfKYvmGL4GmMmC4mXlEziQwJtGSZRz3Dp7hpRsI5xrmxD
10WbtcmY9HI/9Wk3UggNi4cUufYjqfrnA4hM8n3kdccD1/A8IMR100n/ZMDajAG0
BpzMH/HxfAmW2aWuInKh2EsUQM7Hm/JqLFDGwdJrtlk15zoW3x3JzWp9KnpMnpLp
p21VZ6HztCyJxXO/5lMquRzYA9QZjAiJQb2nZGidA0xDlH6PG8qyGQmRDIZeXrNu
72f8L8GIqIwDx8rbAIm/bWyVqqRNwQ==
=adLp
-----END PGP SIGNATURE-----

--iagkhksmhlmhnami--

