Return-Path: <linux-can+bounces-4692-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C67B554B1
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 18:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CD77C684D
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CBA1E503D;
	Fri, 12 Sep 2025 16:32:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE363176E4
	for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694730; cv=none; b=b0/AIBbsFyXNZq6DaMv5s1MGbVQ8n/xLvrLju1aXrKifcxWU5JsfQgg9F00h8MZmHw0hgETpHSH7cZ2yU09e3Xf1sUxhUGEtvPtQ15KS3mLtqt4anRR+xMWXJqbii1kwfbywitp/QiME5BFXg9U43wILULRYd8sokqpSDx+zeIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694730; c=relaxed/simple;
	bh=/NSaik2nlATKQaaMFS+NA+EoaK/PYO0K7DnAhpHC2LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cm2CnQO20EPFrAdbIUcGMNaSQk5xUTWqUB5b7G3noq35xUPYb4WO3EjhYq6WGmB2s2jU9i5dD/xfiW4B824UCYs9Ukc1kXJXQEXs1LnsS9yiBRkydUnPK7OlNKrnyEjJ5MGwH1VH4D2APocBVvvN+xIuYS9j7/+NWvdk+9pKSPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ux6gt-0003D9-3c; Fri, 12 Sep 2025 18:32:03 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ux6gs-000xjC-2Q;
	Fri, 12 Sep 2025 18:32:02 +0200
Received: from pengutronix.de (unknown [IPv6:2001:41b8:9c0:900:dd13:804:bda0:3276])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 631B146DD09;
	Fri, 12 Sep 2025 16:32:02 +0000 (UTC)
Date: Fri, 12 Sep 2025 18:32:01 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>
Subject: Re: [PATCH v2] can: peak: Modification of references to email
 accounts being deleted
Message-ID: <20250912-cyber-woodpecker-of-correction-2d34c7-mkl@pengutronix.de>
References: <20250912081820.86314-1-stephane.grosjean@free.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rav2v3g6ta7yjils"
Content-Disposition: inline
In-Reply-To: <20250912081820.86314-1-stephane.grosjean@free.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--rav2v3g6ta7yjils
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: peak: Modification of references to email
 accounts being deleted
MIME-Version: 1.0

On 12.09.2025 10:17:19, St=C3=A9phane Grosjean wrote:
> From: St=C3=A9phane Grosjean <stephane.grosjean@hms-networks.com>
>=20
> With the upcoming deletion of @peak-system.com accounts and following the
> acquisition of PEAK-System and its brand by HMS-Networks, this fix
> aims to migrate all address references to @hms-networks.com, as well as t=
o map
> my personal committer addresses to author addresses, while taking the
> opportunity to correct the accent on the first =E2=80=98e=E2=80=99 of my =
first name.
>=20
> Signed-off-by: St=C3=A9phane Grosjean <stephane.grosjean@hms-networks.com>

Applied to linux-can-next

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rav2v3g6ta7yjils
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjESv4ACgkQDHRl3/mQ
kZwPiAf/ezFyxyXW1i4ajTT0Z+Rx9kuG6LaBZoQxwZGVWjTe6YraQO8xhcVxWiEi
EflqjJBBGoMbDQSFNzC6OUUXgKLANkv1+Cr8X/r7L1XeIzgIYgDwEtpfkxsWP8L1
Wlo6+IX5UwZWydavT/4fguUm2vr7aywb0yQ8colQorBPgLe5d5AY+sCD1K/ZnER8
exqOC7gOQUomWQEHAgrq6MBUUIFRFz+C83ji5Flzqu99t5dNjD6hLepwk5eycvXr
OYMHn7cNUqImOeHW4/9cVsl+wgZ7EMbfn0eZYUAs0HVDruBOONd82RIH7JsKWYfy
KS6FqYXvucIlIqLs3hso5o3Hp91j4g==
=Vi6/
-----END PGP SIGNATURE-----

--rav2v3g6ta7yjils--

