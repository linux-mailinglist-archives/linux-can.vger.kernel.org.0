Return-Path: <linux-can+bounces-3755-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F907ACAEC5
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 15:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6B21760D7
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 13:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C391AF4D5;
	Mon,  2 Jun 2025 13:18:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78D4A0F
	for <linux-can@vger.kernel.org>; Mon,  2 Jun 2025 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870297; cv=none; b=QeTQx2PYUDJLl4LQHSLyqrJd5UdDnHQrwEaR30IANdAGDUDpwDYHTbuI8+BNfw6uILK4+00hq8BkEvoQtfsll6HDKo53OCf1U66SxwlGBx7ViivsP52/p+zvGvsgbKHf+Ej5vuS0Viqw2vEvLp/ExdHiiX/5JhaagQAYqjoEwwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870297; c=relaxed/simple;
	bh=KnwDpKw+0AovZBk5A25QTLv/FOHcCpWpm5j70Kw19CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyKvQhZ8oQGkBNjCREotMgt1Aay6oy46c7DEwIIYy9MEyVKWFIemuimZ1f/ASGJdhpOfu6wJq+2ErTT3P0jZVwxsvRu//lAEtiC6/KtAfamaJAk7/bETI/gQt606GF0App4emX9hCU6B1XjCTFcNOAnUk0JSOx+Pi0UNi25ACgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uM538-0003XH-H8; Mon, 02 Jun 2025 15:17:58 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uM536-001Ske-1s;
	Mon, 02 Jun 2025 15:17:56 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2EEAA41EE93;
	Mon, 02 Jun 2025 13:17:56 +0000 (UTC)
Date: Mon, 2 Jun 2025 15:17:55 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 6/9] can: rcar_canfd: Repurpose f_dcfg base for other
 registers
Message-ID: <20250602-rigorous-ermine-of-abracadabra-467998-mkl@pengutronix.de>
References: <cover.1748863848.git.geert+renesas@glider.be>
 <f9c114fcf8cc8eaae150a3ce95dd3224cf247f6b.1748863848.git.geert+renesas@glider.be>
 <94755286-47fb-461e-9850-e14830f2536e@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kkkezthwqp4euq4q"
Content-Disposition: inline
In-Reply-To: <94755286-47fb-461e-9850-e14830f2536e@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kkkezthwqp4euq4q
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6/9] can: rcar_canfd: Repurpose f_dcfg base for other
 registers
MIME-Version: 1.0

On 02.06.2025 22:16:48, Vincent Mailhol wrote:
> I really start to dislike all those function like macros in the rcar_canfd
> driver. The only benefits of a function like macro is either to have type
> polymorphism or to generate integer constant expression or to work with c=
ontext
> specific info (e.g. __func__ or __LINE__).
>=20
> Can you just change these five function like macros to static functions?
>=20
> And from now on, each time there is a need to modify one of the rcar_canf=
d, I
> would like this to become an opportunity to little by little clean up tha=
t macro
> madness.

+1

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kkkezthwqp4euq4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmg9pIAACgkQDHRl3/mQ
kZyJtgf/T8fMk4y0IS5uEPBqD6d/vEWjlRz5QHUHuNFLd2PQmmkl4+UZwPLYpB3n
jw/Q7vLI0TlS/DooOr8LaVVNhwps5rBd0g9QK0e2cZwbp4A7BPzv2Pyj+N5YAYL6
JJTH+XEYC2GpRr/ZKc31Zer2G8VsU1r2uNNMtfwOuynZg4MrH0HD34p28YMUYLQf
yzkueRC/BnNuOgZSpeEmOqSv/JlHhfYoIuKCT8xGQjOf2uGINHgwPpsJJuNQB7vf
/a9Halu2Rgr7Z/+egc1NrlaxFGT6PcApMyrSHLitGl17NUVCiI/gRlODmV5G0NUE
xzytW5J/FBiT/ct6tE+or8QfHWIb4g==
=wzaz
-----END PGP SIGNATURE-----

--kkkezthwqp4euq4q--

