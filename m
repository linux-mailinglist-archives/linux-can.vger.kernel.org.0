Return-Path: <linux-can+bounces-2742-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD102A2A8C8
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 13:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005B67A2184
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 12:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098C020B208;
	Thu,  6 Feb 2025 12:49:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DBA13D897
	for <linux-can@vger.kernel.org>; Thu,  6 Feb 2025 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738846147; cv=none; b=BhaiFpUOA2WDk2g7Tcv9dee5ON5Ln1keBGc3D2wen/G76wT9r5LOYnsAS+b+gguRw7OS3HII3q4XkzsUdWGgzcGnA5D96Du/csqVFbNDtFyKesaJVFd5nS/A0Xscj9lk+IVaYN84yQqGTcnsGZp2RaOs8vYBa4N7tKwXRTOywL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738846147; c=relaxed/simple;
	bh=ByH9IjVfdPoMNGKitF3NQgwXMRehRiCBWIRPz3BX2WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gB9WNRv85p5ssQicWnauoQr+X8m7Ey24dg7gnMxbIFz8+9Q25kyXuyz9xoRPz+XftXYBV5RX1FszHMMEvU2c4L46ZFgrmm3M1RPpmgPvxV3b6WwKJMAYK9GRrGnhRiPD/niHJYchc6fUAFavOhXdJfxuQHfxKDFomcACd/Dyua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tg1JY-0004qa-VA; Thu, 06 Feb 2025 13:49:04 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tg1JY-003oDs-1y;
	Thu, 06 Feb 2025 13:49:04 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6076A3BB4CF;
	Thu, 06 Feb 2025 12:49:04 +0000 (UTC)
Date: Thu, 6 Feb 2025 13:49:04 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH] can.h: canxl: support Remote Request Substitution bit
 access
Message-ID: <20250206-fascinating-collie-of-infinity-47da9a-mkl@pengutronix.de>
References: <20250124142347.7444-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4algqk356vudc575"
Content-Disposition: inline
In-Reply-To: <20250124142347.7444-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--4algqk356vudc575
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can.h: canxl: support Remote Request Substitution bit
 access
MIME-Version: 1.0

On 24.01.2025 15:23:47, Oliver Hartkopp wrote:
> The Remote Request Substitution bit is a dominant bit ("0") in the CAN XL
> frame. As some CAN XL controllers support to access this bit a new
> CANXL_RRS value has been defined for the canxl_frame.flags element.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4algqk356vudc575
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmekr70ACgkQDHRl3/mQ
kZxw9gf/e3fusWMX8FVH9Zv/KVxFNGbp6ZZrZ68LNbRkSeGul7po+Fq33Lqv4G1C
8lMMrjUGBlc9gGQ7tPJngRrX5/ySZIViKSZPWPpCDoTwBxEIorH7FOStITVKSbMX
ebbu7UKFvfSURKVxVE0CYp5c4zJYKa8mR1sUxkHK5HGh5C5KGxveeb85aTPZSeTB
CEUd/J6tgZyRqSJerG54GfqqccX3uvmd07GIQ0cmL3XkBgCrXqXVfvjW0MI2Il0R
kx8hfpaii4D/UQJkbeI1VF1e4rJisWHF+mJJtQA44JshQVztJKL1AHGk6dmGeEoe
AATUb5Miy3gaghMqw/3PBIZ1riFrtg==
=QrW7
-----END PGP SIGNATURE-----

--4algqk356vudc575--

