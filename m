Return-Path: <linux-can+bounces-5635-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96206C800F9
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 12:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B911343195
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 11:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C02255F28;
	Mon, 24 Nov 2025 11:03:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9CE238C1B
	for <linux-can@vger.kernel.org>; Mon, 24 Nov 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982201; cv=none; b=YncpC8n8in3YC+biZRnQ9KUFoDTp/Z4aG68eVS124jw0b0cVpj18DEEZ+QKv+uqm2gSx5+2sBR46uNKxn/lchg/3n8PomW3s+jJLL8ANRTy3HRAyJBVRswhkHQHlKYjTOaTD9nDDiKPn7DPBNjmwvF0S3/LX/vArCADD/Ea50nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982201; c=relaxed/simple;
	bh=rEhQ0kChvoW135zoDbu5Vz/F/y9BKhr5QRudslmrQ7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeRYKn7zKrx6zRWncTBshaw4D7K6rSGRdAO3NMtNzXeJaJdzZ8j+sFWlL1CDWeAODy+13tbE9kSfR3HlIZadaKR8YySIs63ICwsXyMh59KJyRTBg7NSVZJ4gzvNtm7AQFVvS8ZbUAQBPJyQpWMUr75tv79QM0ySaP3X8UpXIHgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vNULh-0007NK-EJ; Mon, 24 Nov 2025 12:03:13 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vNULg-0029iX-2l;
	Mon, 24 Nov 2025 12:03:12 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 998244A6F1A;
	Mon, 24 Nov 2025 10:59:42 +0000 (UTC)
Date: Mon, 24 Nov 2025 11:59:40 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Thomas =?utf-8?Q?M=C3=BChlbacher?= <tmuehlbacher@posteo.net>
Cc: linux-can@vger.kernel.org, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [RFC PATCH 0/1] can: sja1000: try to enable NAPI
Message-ID: <20251124-wild-grouse-of-influence-3314f5-mkl@pengutronix.de>
References: <20251123181820.19233-1-tmuehlbacher@posteo.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mlg7rdfiy6lkqmxl"
Content-Disposition: inline
In-Reply-To: <20251123181820.19233-1-tmuehlbacher@posteo.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--mlg7rdfiy6lkqmxl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/1] can: sja1000: try to enable NAPI
MIME-Version: 1.0

On 23.11.2025 18:18:27, Thomas M=C3=BChlbacher wrote:
> I think there could be some benefit in avoiding the unbounded while loop
> for RX in the ISR. On a system with slow IO between controller and host,
> we can end up staying inside of the ISR for much too long if a more
> capable bus participant causes a lot of traffic.

If you go for NAPI, you have to disable the IRQ you want to handle in
NAPI in the IRQ handler and re-enable it, if you're done.

In the past (before threaded NAPI was a thing) there was the problem
that the latency from IRQ handler to NAPI was too big, leading to RX
overflows.

This is why some newer CAN drivers read from the hardware in the IRQ
handler and push the skbs into the networking stack in NAPI. There is
the small "rx-offload" handler for the NAPI side.

Another option is to make the IRQ handler threaded, which allows you to
prioritize it against the other threads in the system.

In general you don't want to push skbs into the networking stack in the
IRQ handler, because this approach may lead to out-of-order reception of
CAN packet, especially on SMP systems.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mlg7rdfiy6lkqmxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkkOpkACgkQDHRl3/mQ
kZwWVAgAocyzoqt9LDbQGxXYHGtF6aFIRjrgoXkSCkgYeTpPRSQMwl9CmCWwKLns
GkVCUoaVfOFnW8+bYKk0LSn/cUzpgOMUI+VKjhIFXg5dyIM9paarZoXARtXw7Fw1
nLU0FZi1guHz3AaHncPABz+KV+rWg4Hzy7b89tVxmpuWGHkkPnMm+YLvfjLwegKb
u4AACvxW7ldDZI4/eNJn1a4mamLBUjKjQoilCU4kU+J/E2Bnf+G3P59VABFFKYKe
QViIuFLA1SWxKCK79OwYsZkahe6bbl/XO3CeJXvX++ThN0kzTMZzoOVkTMI8XtnQ
Qi3c4Vy4Xh/ISxN2/UMJRpsmcvw24w==
=uEfW
-----END PGP SIGNATURE-----

--mlg7rdfiy6lkqmxl--

