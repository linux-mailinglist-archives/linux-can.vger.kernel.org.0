Return-Path: <linux-can+bounces-504-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B474F8B5FD2
	for <lists+linux-can@lfdr.de>; Mon, 29 Apr 2024 19:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55EC1C21102
	for <lists+linux-can@lfdr.de>; Mon, 29 Apr 2024 17:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E4B85C41;
	Mon, 29 Apr 2024 17:13:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6847A5C
	for <linux-can@vger.kernel.org>; Mon, 29 Apr 2024 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410821; cv=none; b=bgqPu6BsDG3eHbstLm8APqDqDxc7uxL8drZIFOua59p3CIX91sneqOrcBag6GR1UyZ9guhWmDQ7FqBlQNjBJqrG/UXAJo1X4fgwZu8v38iQlIIli7a4ABPUy2QhffP0G4RzKHSpWipetaVjd4/MlJX53dA5rWGaPaWP/Q9cWKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410821; c=relaxed/simple;
	bh=a8EET6+HRKrj7JWBKCahNM2h/SqCP3OmeFlwP67JDtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvYUkw8qjH2XUWzLgNeO4tcu8AvYrL1AuC8vQjnR95xvm7hDVxvj3v+4uryaaZu1LQeGUvfvjvjNMzDA8dyuLHd1nZGrJxCBlnqSP/zQaTOBFNxk0f3/pMnl7Sv0TZkGNn58P1Lc/IXPYrkrGi/VYH5W1H3YCfjPvt7pUimTuZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s1UZM-00021v-CR; Mon, 29 Apr 2024 19:13:36 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s1UZL-00F1LI-Ja; Mon, 29 Apr 2024 19:13:35 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 490AB2C2328;
	Mon, 29 Apr 2024 17:13:35 +0000 (UTC)
Date: Mon, 29 Apr 2024 19:13:34 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mans Rullgard <mans@mansr.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: Kconfig: remove obsolete help text for slcan
Message-ID: <20240429-meticulous-rich-tapir-46bdd7-mkl@pengutronix.de>
References: <20240427152648.25434-1-mans@mansr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vx6bbjk4w4qomyse"
Content-Disposition: inline
In-Reply-To: <20240427152648.25434-1-mans@mansr.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--vx6bbjk4w4qomyse
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.04.2024 16:26:48, Mans Rullgard wrote:
> Commit cfcb4465e992 ("can: slcan: remove legacy infrastructure")
> removed the 10-device limit.  Update the Kconfig help text accordingly.
>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vx6bbjk4w4qomyse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYv1ToACgkQKDiiPnot
vG9UGQf/e8kVssxJyzOzk0KXt+uynKYNmwUf+2ug18Sgt1pIzQThnULGL3/rJ3kD
A9vX8ESzw2itwRcohYsunMeqUtzdKeCj5xrWOKAMc91nTTuh9FyarDNoL8E5UVuS
XVbCZdaL1W8SI7VeD+GtDhNmBo7BLnnK+GF2Dx1O4pBDVvXQROKopJYxYkTmJUu3
vp+cgmCZ3XuOfYmGsumnw/VqNvDMmPJpxhdc3T0MZlU5lHBWZFaq4w2XvRlfuY8b
sn5KFRMS+iZGzevPG2XL1ASPRcO80HCfxOofzuUMF6Vdaz5qpTEM++lRcad3nKq5
dN/RKMslM0UCRhHlKL3E2gFkL2q5WQ==
=Rc4M
-----END PGP SIGNATURE-----

--vx6bbjk4w4qomyse--

