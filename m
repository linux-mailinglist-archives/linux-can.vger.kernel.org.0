Return-Path: <linux-can+bounces-4000-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E98BB058E9
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 13:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B02F3AE052
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 11:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A6A2D97BC;
	Tue, 15 Jul 2025 11:34:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213132D6401
	for <linux-can@vger.kernel.org>; Tue, 15 Jul 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579256; cv=none; b=L6ODvANDO5tUavCkGz7MXcbokPWTNDIu7KRb3ietqIb1FfjpH5KeKlw9mwuqaZdWJ99IZITCgc8ymuF8EuhZDelpxAmet+WrtSJr89eAbPG0YTeDULgzmQ6wKka2vI1D1JhoysOPRepRJSdpMGGDlhAKfb5H81R1YGsvJS+3S+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579256; c=relaxed/simple;
	bh=xuUks+W/d6ssg1oq9GXSSz31kaiNVVYndaiq2TmGFIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JilC4bwLmaG1YUPliu5Gs3e/PqJ19gbyLmpP1qappFOFXJaHQWmOc+w+EtIXQWg/d5KrvPiS+qJ0Yyy6ppkFS5vbxRFoO7pi0SgbUwpFVMs94+qFuwqkv+sBtQP94OL5tyMK9LPorH3F7SX6Xq9coQodVq3bOVzc4zwS4ARw510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubdvG-0003iF-Be; Tue, 15 Jul 2025 13:34:10 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubdvG-008ZSj-0R;
	Tue, 15 Jul 2025 13:34:10 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C58B74423D6;
	Tue, 15 Jul 2025 11:34:09 +0000 (UTC)
Date: Tue, 15 Jul 2025 13:34:09 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] can: Kconfig: add missing COMPILE_TEST
Message-ID: <20250715-laughing-gazelle-of-nirvana-3502bd-mkl@pengutronix.de>
References: <20250715-can-compile-test-v2-0-f7fd566db86f@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="53wy6ux2n6earrh7"
Content-Disposition: inline
In-Reply-To: <20250715-can-compile-test-v2-0-f7fd566db86f@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--53wy6ux2n6earrh7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] can: Kconfig: add missing COMPILE_TEST
MIME-Version: 1.0

On 15.07.2025 20:28:10, Vincent Mailhol wrote:
> The ti_hecc and tscan1 CAN drivers can not be built on an x86_64
> platform. Add the COMPILE_TEST dependency to allow build testing.
>=20
> Doing that, a so far unnoticed W=3D0 warning showed up in ti_hecc. Fix
> this warning. To prevent any potential noise in some future git
> bisect, the warning is fixed before introducing COMPILE_TEST.
>=20
> Note that the mscan and mpc5xxx drivers have the same issue but those
> two use some helper functions, such as in_8() and out_8(), which are
> only available on the powerpc platform. Those two drivers would
> require some deeper code refactor to be built on x86_64 and are thus
> left out of scope.

Added to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--53wy6ux2n6earrh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmh2PK0ACgkQDHRl3/mQ
kZxZMAf+MxOyHcgzN73V5oP1YTQXFFdZ1WH7+bwUaJc9ntiNLXAwyVukfbG/jEau
tHet8OzfSyVnPTXFOqMujt5eBxj4sN+fcQlsbOPcw1JbZ7mvTvjJoKDEKlLxZme/
OQwgNscBPoY9Sxuim14pXVQH5hCcsOvssv+SEVJNEvnWgBtAGVakZhh8xsE7Mq5Y
mqb7o4r6g3MmXIijZWtRBuiBzdIjpbPg6eTz2GPQDeqoV7mwKUa5kHzvHtqBKqRS
r5MEGBicM3Lt2SNH5nmvGy4M+UrTLN1UvStLwbJKA89bsg5Y2ugiUx015iKUa+Wv
CLE5IFBG1mH8Oba2vc2ifNopc7u4eQ==
=yzDW
-----END PGP SIGNATURE-----

--53wy6ux2n6earrh7--

