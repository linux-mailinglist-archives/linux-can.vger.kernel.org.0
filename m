Return-Path: <linux-can+bounces-4382-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FAFB39484
	for <lists+linux-can@lfdr.de>; Thu, 28 Aug 2025 09:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9FD1883142
	for <lists+linux-can@lfdr.de>; Thu, 28 Aug 2025 07:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762002D24B7;
	Thu, 28 Aug 2025 07:04:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE762C2376
	for <linux-can@vger.kernel.org>; Thu, 28 Aug 2025 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364677; cv=none; b=S5woFZhlNfx2w223P9USNuaNs+MQk1Iie8DOucvKjW5c8rNJaEbCO44CycnFVYPbQTYuc6xrd/MkPWFYdj3TIuxoqHNSFsQhm+6tvtwJcy2OJTmUgl+n6GPTpF/o5152a5kRsLTNbz2alMP/IlqmCxoUhhKBtPq8kkO2XKJ6nB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364677; c=relaxed/simple;
	bh=pJentARxXgQN3RFZvZGLsfKkWb+Uyy4N/c/LxryUBG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9zsU2ZT1nPYnMcLY9OJ98b8GRpa7xMbMC0RzUo57sm+rYe3CmlPZZ2eZdgc/TiPk+6zJI8xOesaPObT3GYaEZjzyyHEppCQvxdhI+/72SreG657Oqs9KW6FmawZ3HtSXSFIwI678QkJw7aXaLohcNDWbIoEt4fg6JVtncVc5U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1urWgP-0002LD-3C; Thu, 28 Aug 2025 09:04:29 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1urWgO-002WDZ-2g;
	Thu, 28 Aug 2025 09:04:28 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6247145F7FF;
	Thu, 28 Aug 2025 07:04:28 +0000 (UTC)
Date: Thu, 28 Aug 2025 09:04:27 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Vincent Mailhol's email address
Message-ID: <20250827-valiant-ingenious-viper-3147c1-mkl@pengutronix.de>
References: <20250826105255.35501-2-mailhol@kernel.org>
 <20250827-winged-bizarre-mackerel-a91272-mkl@pengutronix.de>
 <1e8b20dd-1afa-46ed-81a6-52614a43056e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2bps7jqntbviu2gk"
Content-Disposition: inline
In-Reply-To: <1e8b20dd-1afa-46ed-81a6-52614a43056e@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--2bps7jqntbviu2gk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: update Vincent Mailhol's email address
MIME-Version: 1.0

On 27.08.2025 17:14:24, Vincent Mailhol wrote:
> On 27/08/2025 at 16:40, Marc Kleine-Budde wrote:
> > On 26.08.2025 19:48:39, mailhol@kernel.org wrote:
> >> From: Vincent Mailhol <mailhol@kernel.org>
> >>
> >> Now that I have received my kernel.org account, I am changing my email
> >> address from mailhol.vincent@wanadoo.fr to mailhol@kernel.org. The
> >> wanadoo.fr address was my first email which I created when I was a kid
> >> and has a special meaning to me, but it is restricted to a maximum of
> >> 50 messages per hour which starts to be problematic on threads where
> >> many people are CC-ed.
> >>
> >> Update all the MAINTAINERS entries accordingly and map the old address
> >> to the new one.
> >>
> >> I remain reachable from my old address. The different copyright
> >> notices mentioning my old address are kept as-is for the moment. I
> >> will update those one at a time only if I need to touch those files.
> >>
> >> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> >=20
> > Applied to linux-can-next.
>=20
> Thanks!
>=20
> > BTW: The "From" header of your mail only contains you e-mail address,
> > not your real name.
>=20
> Yes, I did not properly set the from field in my .gitconfig and because t=
his is
> the very first email which I sent using my new email and git send-email I
> couldn't notice it. I spotted the issue just after sending and it is alre=
ady fixed.

Very good!

BTW: I use git's "includeIf" directive in my ~/.gitconfig to have
directory specific git config options:

[includeIf "gitdir:~/kernel-stuff/"]                                       =
                                                                           =
                                          =20
        path =3D ~/.config/git/kernel

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2bps7jqntbviu2gk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmiv/3gACgkQDHRl3/mQ
kZye9AgAnBJVdI1cCSVZffM17VtC4/aIp+OcfRFyqt1C3H/G4THnbH6kH7PxZd++
+2jAmj/iXCWsHv7fhFvyV37gjs49qvCM8yJhz+c75w4/F/4NbffmkzWhqBLtUWGm
lohP5DqDkalaxw113BJpAJRIUrQVANoEkRfaf4pfk0Sf3wrUODZwNXxHelG+EsNO
YDt7cEx1vpc7oM1sGOccLpPcyA462p1UZ4PnGQTHLpSEZ4LPfY9w22EHvBhW9Kk6
VeREwWtZqOAb9BhxdgU8OBFpFA2v4A9sghgyQUWxyAC5S6U++YaZls8Y+vrdM3uy
fByIdJDE4p3srZUWGwz7uHzl+TC9EQ==
=yjAm
-----END PGP SIGNATURE-----

--2bps7jqntbviu2gk--

