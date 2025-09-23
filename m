Return-Path: <linux-can+bounces-4896-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8341AB95308
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 11:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7413A2DE1
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A657726738C;
	Tue, 23 Sep 2025 09:14:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE544191F66
	for <linux-can@vger.kernel.org>; Tue, 23 Sep 2025 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618895; cv=none; b=WKn7zPMLvcLTvILs5hIv0oxCfsyqwz2o28HIu0zMUPK2y75YyEsoRRWeZrkHuV51m+i1xiXy3ajMp1ZgBrkobdJYM5W2IVl31TyTlzgonop40soF/hy98gfvl9xMTWcllgJKLRf37kP6fpAKj+sqWge2+IJuIaAKxoDzK7Qoi0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618895; c=relaxed/simple;
	bh=1osXgEH4WoMe9XyFyvNl1mqQ9N/sWRDBzM1FOvWgri4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyqIgoDdl1p7luyqX3Y/e/FEbRfWKJyD7dxQJeEraRIi/y+Tr0xGVUktNn2lH9RhBYhfYEe/MVW1//RYTz0EQc29+8QgmFCtLMSxx2K/bhcvVR1HRzeFtk6pzN4fVcBdYS+UfIsUuyzjHNoh2kEvtGUu/pw5A+xi0T0Mt3hybys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z6q-0006Ja-6w; Tue, 23 Sep 2025 11:14:52 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z6o-00049v-0Q;
	Tue, 23 Sep 2025 11:14:50 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CA1E1477BFD;
	Tue, 23 Sep 2025 09:14:49 +0000 (UTC)
Date: Tue, 23 Sep 2025 11:14:48 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chen Yufeng <chenyufeng@iie.ac.cn>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: hi311x: fix null pointer dereference when
 resuming from sleep before interface was enabled
Message-ID: <20250923-famous-gharial-of-drizzle-0c2da1-mkl@pengutronix.de>
References: <20250911150820.250-1-chenyufeng@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ocjaiy22zdtkm5uy"
Content-Disposition: inline
In-Reply-To: <20250911150820.250-1-chenyufeng@iie.ac.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ocjaiy22zdtkm5uy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: hi311x: fix null pointer dereference when
 resuming from sleep before interface was enabled
MIME-Version: 1.0

On 11.09.2025 23:08:20, Chen Yufeng wrote:
> This issue is similar to the vulnerability in the `mcp251x` driver, which=
=20
> was fixed in commit 03c427147b2d ("can: mcp251x: fix resume from sleep be=
fore=20
>  interface was brought up").
>=20
> In the `hi311x` driver, when the device resumes from sleep, the driver=20
> schedules `priv->restart_work`. However, if the network interface was=20
> not previously enabled, the `priv->wq` (workqueue) is not allocated and=
=20
> initialized, leading to a null pointer dereference.
>=20
> To fix this, we move the allocation and initialization of the workqueue=
=20
> from the `hi3110_open` function to the `hi3110_can_probe` function.=20
> This ensures that the workqueue is properly initialized before it is=20
> used during device resume. And added logic to destroy the workqueue=20
> in the error handling paths of `hi3110_can_probe` and in the=20
> `hi3110_can_remove` function to prevent resource leaks.
>=20
> Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ocjaiy22zdtkm5uy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjSZQUACgkQDHRl3/mQ
kZzIyQf+Ms35z/EVt9UhSuPlGGcYhSMxdt8wepQ47tu4Nki47B2QSHSbX16FVU1Q
eVqJPbBGzYITgFA8/T8FGA9cAWVAFfOqBdM+L5gGtLP5bVmesivMvR1SD9zh96hd
hzNmdfF2UmBSYx5FODt+qy8dPQoCbfikthMsuR5oNDJDQXRlVJZK4QjEgXV2ov6C
0MAa/nBb3uz5vGM9Jueo0xdE93PLtjYTcydvj/dQSfPWcRWhoa6XIYmovlJkJGLy
RPG+RO3KlhU7kTqtLF4RlxDVWLeYykbN4+8EaeGA/tmAr4Qb6Se0sUufeLktkom5
3V8Np4WgzDoduqqI0NbKnxic30uTwA==
=4K5d
-----END PGP SIGNATURE-----

--ocjaiy22zdtkm5uy--

