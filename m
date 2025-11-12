Return-Path: <linux-can+bounces-5365-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD252C51701
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 10:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D67684FA2D1
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 09:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE13C221282;
	Wed, 12 Nov 2025 09:36:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53354274B55
	for <linux-can@vger.kernel.org>; Wed, 12 Nov 2025 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940196; cv=none; b=S42LIBG4r4EZHyLI3S6ROK24bc4N052lo6+Imyt2v2eMy/2BJyXHjrtaOEhXCMUbFu9BLqsoPdHYK2PhC5tPHQSnbtOMmJTkc3zn9h9KEt8gazqy7qkeyYlDaWxnap43Zu3mMfEMB1PVmImVf84sae7uHlUbNKpVOSCWHko8HHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940196; c=relaxed/simple;
	bh=BgxKsCr5lQNnJC/eyEecLuMCdeTpY2TtT1U3lIZmlsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeESlU7mumTwIx00MtZtPLoGpGsdJ/7z88DRYyH9rBXohSgGN/NJFvUvTWi58LyJUCtTOXdt56t5afwNJxizRS+RjOuwhCzLdBLexqzGXRwGWctxcofWrHytkUOi6RkNW+bF+hzilpfLtRi5zaXAum4qZl9zKI1qWFW5Mwu8t6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ7HD-0002M2-VA; Wed, 12 Nov 2025 10:36:31 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ7HD-0003km-1b;
	Wed, 12 Nov 2025 10:36:31 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2F48A49DA2D;
	Wed, 12 Nov 2025 09:36:31 +0000 (UTC)
Date: Wed, 12 Nov 2025 10:36:29 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, kernel@pengutronix.de, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2025-11-12
Message-ID: <20251112-fanatic-cricket-of-efficiency-0c305b-mkl@pengutronix.de>
References: <20251112091734.74315-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lgk4dvrlchuf4ccl"
Content-Disposition: inline
In-Reply-To: <20251112091734.74315-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--lgk4dvrlchuf4ccl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2025-11-12
MIME-Version: 1.0

On 12.11.2025 10:13:40, Marc Kleine-Budde wrote:
> Hello netdev-team,
>
> this is a pull request of 11 patches for net-next/main.
>
> The first 3 patches are by Vadim Fedorenko and convert the CAN drivers
> to use the ndo_hwtstamp callbacks.
>
> Maud Spierings contributes a patch to the mcp251x driver that converts
> it to use dev_err_probe()
>
> The remaining patches target the mcp251xfd driver and are by Gregor
> Herburger and me. They add GPIO controller functionality to the
> driver.

Doh! I missed the last patch, here's an updated description:


The first 3 patches are by Vadim Fedorenko and convert the CAN drivers
to use the ndo_hwtstamp callbacks.

Maud Spierings contributes a patch to the mcp251x driver that converts
it to use dev_err_probe()

The next 6 patches target the mcp251xfd driver and are by Gregor
Herburger and me. They add GPIO controller functionality to the driver.

The final patch is by Chu Guangqing and fixes a typo in the bxcan
driver.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lgk4dvrlchuf4ccl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkUVRkACgkQDHRl3/mQ
kZwBBAgAo8aoUHYOBppge88PZwWboQomqG2WQe0takgm0bg1FOcASAbKeLOtKg7F
II/Cz3ru6XaClW9Fzoh1pfVEWR5VFGJ6/HEZMT6a1Do51m64cvfojvwAMXfWlK6V
tU28bz/ySzn7/alBWq84v3anwTuMzY2+o64y5Fk/sB9604OlLthvMGoVOgPr9hYj
43XqUMB7+ncT09UAP28JgMS4Fp3yVXHHXa/L9+krqQZrLhL45gdy8Ox3+BOf7h2m
t9FZyMTwpAh8IzwiolZZDAWIz99+mrMz+S/Rmn/7zVUwXLV5A1x+YJqUNsnQmmXP
OQaAxdDsu7bKq7yb/M7d9MHwECNyjg==
=2zV+
-----END PGP SIGNATURE-----

--lgk4dvrlchuf4ccl--

