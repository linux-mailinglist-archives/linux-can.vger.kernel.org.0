Return-Path: <linux-can+bounces-6172-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EADD2D471
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 08:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEC023011A98
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B481E0E08;
	Fri, 16 Jan 2026 07:35:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229051DE8BB
	for <linux-can@vger.kernel.org>; Fri, 16 Jan 2026 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548903; cv=none; b=fBrz10qfGyGtLxDBosztHjtyiwZChWCvtVjYVbPyV/h9pE6UzwXf63UeuS2ThXydURX9IOTxExt6arkYVnNiUhNpjvPzMoJI1W0/FQ3dm9bQWW70q7aFbbEXR2deIOj8IgJv6D3qRTW/H1Z26u0add2jBjkJmNgfoVZZDNYnVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548903; c=relaxed/simple;
	bh=yAOjDOGTZXfNEKxz4CFZPt2LFSvpc6aUtEoQGJaiHPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzE+sEkr9QebL1px3HXzyHiXvyR8hIGLkeFwWIsnvIfJ+ET86m7mtstlmHMYrfNbEzU9D00zkD1LPUB32zTPPygd1M2Dix+g4Cn66foR0PVYr+ycvaJFZCHR1Rska/2qiWA42QZCPDUUOSQzUYjJv5LPuii0L+cq9inIIFMBJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgeMA-0008Ry-Pm; Fri, 16 Jan 2026 08:34:54 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgeMA-000slZ-0l;
	Fri, 16 Jan 2026 08:34:53 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 417044CE3D1;
	Fri, 16 Jan 2026 07:34:53 +0000 (UTC)
Date: Fri, 16 Jan 2026 08:34:52 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net 0/4] pull-request: can 2026-01-15
Message-ID: <20260116-quetzal-of-fantastic-love-d120a3-mkl@pengutronix.de>
References: <20260115090603.1124860-1-mkl@pengutronix.de>
 <20260115185110.6c4de645@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xrp23wzamwa3pjsc"
Content-Disposition: inline
In-Reply-To: <20260115185110.6c4de645@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--xrp23wzamwa3pjsc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/4] pull-request: can 2026-01-15
MIME-Version: 1.0

Hello Jakub,

On 15.01.2026 18:51:10, Jakub Kicinski wrote:
> Was the AI wrong here
> https://lore.kernel.org/all/20260110223836.3890248-1-kuba@kernel.org/
> or that fix is still in the works?

The AI was probably right, today I'll look into the issue.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xrp23wzamwa3pjsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlp6hkACgkQDHRl3/mQ
kZzNQgf/RyrLuYi4kVEJH2q4smDJCdTo8B2eu2SkXjsg5JY7yjRMfhPTVNptr/fU
3qlJAfygOocMlZBJxY/LJjRGUpoGrwTvvyl+1B5h00m+hkNSy3xO0NJJdFnUTrUv
jgr5keb2KfMbkuUYINoTe6LCJakhLRSAvKdbUa54IOU2CHhjnZ/i0qIUYXDxXH+M
8jIDfLUVaDtpBJrk4wX5G2WJEUjf8l6S2XPoTeBRsXjigEBbBBM4kF580RLz4NBj
rEfnBs44v1uza0FhRia6gXUQvjQMwQaPlfi0oo/WJIQQmyRr7C+TpQ7DS0pecKFa
26KYj0GnnOtY0ZyN9uIl+4RXSbg3PA==
=LDim
-----END PGP SIGNATURE-----

--xrp23wzamwa3pjsc--

