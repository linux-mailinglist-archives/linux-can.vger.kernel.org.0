Return-Path: <linux-can+bounces-3534-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C00AA973D
	for <lists+linux-can@lfdr.de>; Mon,  5 May 2025 17:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08943AB3F0
	for <lists+linux-can@lfdr.de>; Mon,  5 May 2025 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D796F25E823;
	Mon,  5 May 2025 15:17:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CD25DD0F
	for <linux-can@vger.kernel.org>; Mon,  5 May 2025 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458226; cv=none; b=VfT8glckbWbcqLGcTLDJKQOpjFd9LFvZT1tdAPgq+z/iTTGqCafWSpjLsQwg6j3U/AvcD8XC8fLEeFVEh5cSAmdRMRR73MDE1VDslYMKtJUw5G9xHyNUW1u0aYaPx913K1s9zQVJbhF+k0UHDM5lE4KdRgM3f6kQjB6uaF7wHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458226; c=relaxed/simple;
	bh=eXC/ONCQge5w2vLJ+Q7ZxPY2HLqQ3evbxJGLKRDuPu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAxwGKikiic7fzQBGZVBDXPh3pEEN5q5DDDIbj6CDrwmZP7BQNza7EwU6bauZehsCS5WaeCIU4qjtBVG/ej9xL5VNjUSITK7Krs0dnflVBqsZpQ9GTaF2pRLUVg0BuN5HUznfSg4eBqqV1pfFUV1wdyq1XA58UZ2jcplPKs4fJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uBxYy-0002yH-9m; Mon, 05 May 2025 17:17:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uBxYx-001FaW-2Q;
	Mon, 05 May 2025 17:16:59 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6B7A3408087;
	Mon, 05 May 2025 15:16:59 +0000 (UTC)
Date: Mon, 5 May 2025 17:16:59 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: I Hsin Cheng <richard120310@gmail.com>, 
	Martin Jocic <martin.jocic@kvaser.com>
Cc: mailhol.vincent@wanadoo.fr, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] can: kvaser_pciefd: Error handling for
 dma_set_mask_and_coherent()
Message-ID: <20250505-foamy-nautilus-of-artistry-b6d785-mkl@pengutronix.de>
References: <20250505141154.673290-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qeey2hzc4h7qnxuz"
Content-Disposition: inline
In-Reply-To: <20250505141154.673290-1-richard120310@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--qeey2hzc4h7qnxuz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: kvaser_pciefd: Error handling for
 dma_set_mask_and_coherent()
MIME-Version: 1.0

Hello I Hsin Cheng,

thanks for your contribution.

On 05.05.2025 22:11:54, I Hsin Cheng wrote:
> Ammend error handling for the use of "dma_set_mask_and_coherent()"
> inside "kvaser_pciefd_setup_dma()".
>=20
> Link: https://scan5.scan.coverity.com/#/project-view/36179/10063?selected=
Issue=3D1631256

This link is not public.

> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>

If I understand the documentation correctly:

https://www.kernel.org/doc/html/next/core-api/dma-api-howto.html

| dma_set_mask_and_coherent() never return fail when DMA_BIT_MASK(64).

Also see discussion:
https://lore.kernel.org/all/f61b536397092bd46d701cba2a0fc41430964b73.camel@=
kvaser.com/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qeey2hzc4h7qnxuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgY1mgACgkQDHRl3/mQ
kZzT1Qf9GEgFN/W+ni9wVIcc372piY5GnY9g746Y2PZisbsQSxwG8okRwOaAQ8bN
xU6AS5zGPLxFAtWn5HWmWYeisipOZ7d+Teb8jD2Vp4Y3ofKN2Cqvt93hj58gHePy
gpQ23p/3uQXKiHrrg468g4tcD8wdBzI8r35obVu2Xgsn0L4sVaMTaotI00P9c4N8
i+8wIPXpK36IcqOHyVq7Mo9j9Lf4hRQD6m2BYJ2mKJYnuHWilWDa2XDnKst+mtzs
1tmIaIfolN4xtmbfG0tLJAxxg88UnIOjPf+Y7jSDC4fBxQavX32hbPSRiYEK5STW
Tts19isFatt9ZhGPY29G4JcjDuRhvQ==
=OrUC
-----END PGP SIGNATURE-----

--qeey2hzc4h7qnxuz--

