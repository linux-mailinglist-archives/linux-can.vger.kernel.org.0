Return-Path: <linux-can+bounces-4556-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025E5B4AC12
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 13:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EDC4E266E
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DD131B122;
	Tue,  9 Sep 2025 11:31:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0DF326D79
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417465; cv=none; b=EPnJhGol/cMpQmqfPEukdBeEtiswLWgKtRKgQgnW26ZbFO+J0JPyjwQp7RmW60smHOh1ut2kIhjXaU4zCurBhlTK2RrZWIiMcYniWTqZLdrG2TZU42SivAjPSi1s2SkzT9tUvhJBHIfnzHT5AO0WnHwQCOyFkI2s8R/lNA5HIU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417465; c=relaxed/simple;
	bh=nKn+L13ot9u3lhsFvRxYljeGxEurgqp7EtnR2061Sc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNF2arsuPRKRki4fPJF82/3loqlL6moiMZ3nZA0XrUSvFSCLGPsq315/XbGQXXKgo9b5xcJ6rzdZCja5A+lHMnzE9mkPROgbqPJRNwRCtka/YNTpsuCwnMFxjVjvxpeGnPaaoBxO9rea5MqdJlNBoDrUMGcSDOtBz+7kBINtIec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvwYu-0000Rl-Uz; Tue, 09 Sep 2025 13:31:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvwYu-000PXR-29;
	Tue, 09 Sep 2025 13:31:00 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5BEA0469E48;
	Tue, 09 Sep 2025 11:31:00 +0000 (UTC)
Date: Tue, 9 Sep 2025 13:30:59 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <stephane.grosjean@free.fr>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, 
	Stephane Grosjean <stephane.grosjean@hms-networks.com>
Subject: Re: [PATCH] can: peak: Modification of references to email accounts
 being deleted
Message-ID: <20250909-sandy-ocelot-of-vitality-29ec2b-mkl@pengutronix.de>
References: <20250904104618.634972-1-stephane.grosjean@free.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n5siw2i3wodiua6x"
Content-Disposition: inline
In-Reply-To: <20250904104618.634972-1-stephane.grosjean@free.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--n5siw2i3wodiua6x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: peak: Modification of references to email accounts
 being deleted
MIME-Version: 1.0

On 04.09.2025 12:46:05, Stephane Grosjean wrote:
> From: Stephane Grosjean <stephane.grosjean@hms-networks.com>
>=20
> With the upcoming deletion of @peak-system.com accounts and following the
> acquisition of PEAK-System and its brand by HMS-Networks, this patch
> aims to migrate all references to @hms-networks.com.
>=20
> Signed-off-by: Stephane Grosjean <stephane.grosjean@hms-networks.com>

What about creating an entry in the .mailmap, too?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--n5siw2i3wodiua6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjAD/AACgkQDHRl3/mQ
kZzghggAhcYpR3sODGTxR3qmJkb74csLcsopOGhGLVStf1SSMfNuZAnIa2/TD4KH
0Qc4NeKzH+/UsEKWZGdio39az9ur1sdSEq1eISbBk9qS9rWQ/jcbw9OARmqLvkIO
R038ugjLGyHWKglnxUMgQSj05mzvOK44dOIIAxA1+DKeaQqCbXvs6qbO16x9liYU
h3xmSOXZzbIef2iIpu/qC4F+19wQqv6I8Vuy9h+2nu4+wS3xVKEmL0fcwS49A+Ub
C6H9yQDUghUC7r9WmdZq0qebccxYnIUUhfIXx9nur1ZH19CRsGJzhTVIgqtJOKMp
vpucfOAvmlGqBHEKBkeumY1jxEE7wg==
=sosP
-----END PGP SIGNATURE-----

--n5siw2i3wodiua6x--

