Return-Path: <linux-can+bounces-5467-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C2AC65360
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 17:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6616A382AC2
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754A725782A;
	Mon, 17 Nov 2025 16:34:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30EE2C3774
	for <linux-can@vger.kernel.org>; Mon, 17 Nov 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397273; cv=none; b=WAnipRKS+y9aHqeUtcp3BGM2Xm47IcKGFtFMqhKABjiyL+X+VhMrph+B+p7jRkegMgPEgnEe0j4iZOIeV03oATBoEPxXrVNwjbDj6S8nBn/43n4yrwMOqgaKcvVedzXQ69oy84/OGxqZuMyRb6bMyiS+Hcy4avKMANfHBCWrb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397273; c=relaxed/simple;
	bh=XcXkNZF7ocJnkqz43j17GtTbx0xtTGce6z8NnCUyvdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I240o+1w7hXgtoiIEVi7miDOEj4brcVcJpvSyIA98bEihF+rBSNqIE2xzPBKTLQnUt9vkox1fQY0pB4NrvxiM0FTHNihbhcnOJSVN/huBlz4LBDd+logJSrjaw7M+AyMyzJcdzdK3spMpEsCKGaNvPptBV7hrvdRXm073n0ki64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vL2BJ-0004XW-EL; Mon, 17 Nov 2025 17:34:21 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vL2BJ-000wXD-0E;
	Mon, 17 Nov 2025 17:34:21 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BBADA4A170F;
	Mon, 17 Nov 2025 16:34:20 +0000 (UTC)
Date: Mon, 17 Nov 2025 17:34:20 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] can: calc_bittiming: get rid of the incorrect
 "nominal" word
Message-ID: <20251117-transparent-exotic-myna-bd77c9-mkl@pengutronix.de>
References: <a84c66ff-c5ad-418e-afb6-31f114eda17c@kernel.org>
 <1277298823.655244587.1763393551815.JavaMail.root@zimbra65-e11.priv.proxad.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s4nkd7erh45aac6t"
Content-Disposition: inline
In-Reply-To: <1277298823.655244587.1763393551815.JavaMail.root@zimbra65-e11.priv.proxad.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--s4nkd7erh45aac6t
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 1/3] can: calc_bittiming: get rid of the incorrect
 "nominal" word
MIME-Version: 1.0

On 17.11.2025 16:32:31, St=C3=A9phane Grosjean wrote:
> > >>  static int
> > >>  can_update_sample_point(const struct can_bittiming_const *btc,
> > >> -			const unsigned int sample_point_nominal, const unsigned int
> > >> tseg,
> > >> +			unsigned int sp_origin, unsigned int tseg,
> > >
> > > Please don't remove the "const".
> > I always considered it silly to tag a scalar parameter as const.
> > Because C
> > passes the function argument by value, it is pretty meaningless.
>
> The "const" attribute means that the parameter cannot be used on the
> left side of an assignment in its block. Even if this parameter is not
> an input/output parameter, without =E2=80=9Cconst=E2=80=9D it can be modi=
fied within
> the function, just like a local variable (which it is, since it is
> theoretically also declared on the stack). Explicitly stating =E2=80=9Cco=
nst=E2=80=9D
> is a strong indicator that the value cannot be modified in the block
> imho.

=2E..and this is exactly what I want to express, because it's the
reference value.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--s4nkd7erh45aac6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkbTokACgkQDHRl3/mQ
kZy92Af/aj70eZjULAkCMEVZC1xbrducJ6x/OAK0VDeS+WI7u3HPC6FQ6Anai4eK
qtqTKgG93Bqg8bL1hXq7b7RpytUh9sylwjzRBlOBHYSUi8WvsUJa65vwW9mWr7Zq
6zgFVqD2MxNJE1OWpf4aceAOF2ow7Pdo5tjM3fGq2CKwOGw1X1TKe+b44zIuu5Pi
bKrak2ei2UkuRa2iIxtMt0wz+RgxotrrWLkaouQQS2p4SDAzJLvOvYQqkvLygST8
4OKVb8jyqawgzvYJkVTAL1l2n1pfE59UjtOXuayUOwg6egR40+TJX+EeiWKUJtDq
6SKXi/TyxSdOc9Ifz0u4ZpqIn6ZMiA==
=LEFt
-----END PGP SIGNATURE-----

--s4nkd7erh45aac6t--

