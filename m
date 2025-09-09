Return-Path: <linux-can+bounces-4559-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BFDB4ACD8
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 13:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D8A3A8F66
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 11:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8CF2FF153;
	Tue,  9 Sep 2025 11:51:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18BA3054E4
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418697; cv=none; b=R+FoKH4XfuNRChaItgRmhDc2T8d0Aw4l5IY/avpFNmIHe/Bx59hWVMggifkLdWT4Ub0tv6RUoUppEJ5HJYNRQcQd/RNo07t1vR56wTSOtx1+QCgf8Ibf4Gp3NHhjkruE4ba2/1f1GifJbEow382etKrKMfiYxpOwtv3dVhsdWN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418697; c=relaxed/simple;
	bh=rM8Edg1V76sW3QRSEK59CYmQHgFYOvRJaGacmPQjS+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgLFOGNoS3b0pio1TiL8eYzIItWmRlfpXm7B3QaYcPHauhNtIVwzALehrJjeFOcIdDCHXughEOThyYiqdBhKQdjeBDAEiPXVwWEV8wN8ez59idt5YYT+YeD/9zoyJD2YYeJ2vakq3LHYVB3VY6ecbGIF9TTHOfoZ2GGDL3dITx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvwsn-0004ab-Dn; Tue, 09 Sep 2025 13:51:33 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvwsl-000Pdi-0I;
	Tue, 09 Sep 2025 13:51:31 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BB329469E96;
	Tue, 09 Sep 2025 11:51:30 +0000 (UTC)
Date: Tue, 9 Sep 2025 13:51:30 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chen Yufeng <chenyufeng@iie.ac.cn>
Cc: mailhol.vincent@wanadoo.fr, dario.binacchi@amarulasolutions.com, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH] can: hi311x: fix null pointer dereference when resuming
 from sleep before interface was enabled
Message-ID: <20250909-swinging-terrestrial-sunfish-11cec7-mkl@pengutronix.de>
References: <20250906075019.124-1-chenyufeng@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o2qzhkq6yh5dqypi"
Content-Disposition: inline
In-Reply-To: <20250906075019.124-1-chenyufeng@iie.ac.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--o2qzhkq6yh5dqypi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: hi311x: fix null pointer dereference when resuming
 from sleep before interface was enabled
MIME-Version: 1.0

On 06.09.2025 15:50:19, Chen Yufeng wrote:
> This issue is similar to the vulnerability in the `mcp251x` driver, which=
=20
> was fixed in  03c427147b2d("can: mcp251x: fix resume from sleep before=20
              ^^^ added "commit" to fix checkpatch warning.

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

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--o2qzhkq6yh5dqypi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjAFL8ACgkQDHRl3/mQ
kZwAjQgAkhrNkFroWfhZQZ+bnBq/iCSErwxhMus3L4YBXwCrk8w1Guhj86uHhj/a
1neXYZHMYwXo+i8tGpc4gTURcbsrYVMO63FXKwb8rE4f6jBQ6aLs0eRY+E8TNyeI
IyvLFSioX9E7w+O1uAZRtrJwOACTEFjfh3fShvRofiVKigGlowB0bQuabZQ+L9Nq
L3pv6dD9rQgbdTDRCBjAk3S4PLZRMIQ+Zhy+NkLlpuPXTe/3E4Vy4JxaMHHfw3bl
7+scjZ/jhm1frhi/MbWYxGlhLnuAZdUy8M4i/DnKUYiL1sDe3wtBA7gUbx8qYN74
ktR4SL5lQAP0VtHjGOTBaii5JL/Zlw==
=DjAn
-----END PGP SIGNATURE-----

--o2qzhkq6yh5dqypi--

