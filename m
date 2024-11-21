Return-Path: <linux-can+bounces-2163-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199859D4F81
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 16:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2121F21B45
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4FC27447;
	Thu, 21 Nov 2024 15:12:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0391D86CB
	for <linux-can@vger.kernel.org>; Thu, 21 Nov 2024 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201974; cv=none; b=OmNwIGOBBxu0cNnwyX19pjNafWnv7HYVFOvoMTGz/OqfRDGMgmv+9yIKxbcNNk+M/XB35RhKArrIaoBDkVhU2Fdflyc8Yhis4BEwARJZCsmulHSjqWAr6OpQNUj25msymd40A9PF3SgeAV1Et/QtzirjsNGSSZic1tz7vaxlpvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201974; c=relaxed/simple;
	bh=qSwaYSmr7cHiebiREuYIFlM8lNP5yhjdd8P/egjnf/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4Lszrr+HC5ECKDntaLLrfJXmIs0SEj96sBKUB51GzDv2xdmJi590RniMemF+Nfyew3kZGG7ORUbPs3M22jfjxyVV/X/iYpAftQdBEBi3J41yr539GQqz6Uf/Q233eH8Fo1EwZ8VhlEXvYf2aiTBOD5VEa6LHQ8uhxpROmOmYqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tE8rC-00062z-SP; Thu, 21 Nov 2024 16:12:34 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tE8rB-001vQb-1K;
	Thu, 21 Nov 2024 16:12:33 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0DEFC378B3C;
	Thu, 21 Nov 2024 15:12:33 +0000 (UTC)
Date: Thu, 21 Nov 2024 16:12:32 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, n.buchwitz@kunbus.com, l.sanfilippo@kunbus.com, 
	p.rosenberger@kunbus.com, stable@vger.kernel.org, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: dev: can_set_termination(): Allow gpio sleep
Message-ID: <20241121-augmented-aquamarine-cuckoo-017f53-mkl@pengutronix.de>
References: <20241121150209.125772-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ejqsmakmfeudclee"
Content-Disposition: inline
In-Reply-To: <20241121150209.125772-1-nb@tipi-net.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ejqsmakmfeudclee
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: dev: can_set_termination(): Allow gpio sleep
MIME-Version: 1.0

Hello Nicolai,

thanks for your contribution!

On 21.11.2024 16:02:09, Nicolai Buchwitz wrote:
> The current implementation of can_set_termination() sets the GPIO in a
> context which cannot sleep. This is an issue if the GPIO controller can
> sleep (e.g. since the concerning GPIO expander is connected via SPI or
> I2C). Thus, if the termination resistor is set (eg. with ip link),
> a warning splat will be issued in the kernel log.
>=20
> Fix this by setting the termination resistor with
> gpiod_set_value_cansleep() which instead of gpiod_set_value() allows it to
> sleep.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

I've send the same patch a few hours ago:

https://lore.kernel.org/all/20241121-dev-fix-can_set_termination-v1-1-41fa6=
e29216d@pengutronix.de/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ejqsmakmfeudclee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc/Td0ACgkQKDiiPnot
vG/Pqwf/dWE69GxFrUHSylwyxBpOXWmTEdBhFLEjuDY5BFBD6JraWk8T7MWVERT3
t97Fw7BhZc+gRuedteyDFIChRWFCL0nqan6mf111dFzqP4Vx+a4gj3cF72buEwuw
vcsAM+aHEEubMro3czQhps58CZnrauP8kYX0RuL4q59JeMBw652TkBOe8GGMlghf
ML3C6xPibVoQiOigKlflr2bGbvoW37S8VnmZZdw+hnkm278kXpLJiTEyhjLvx0L7
w0IL1b+oGgohm1s7BJ+qtCipHh93DAR/wdpVbcGKp+5jwoFAGDXyk3zoSdiaAbVp
rsfWbXdY4iHjHTYw7mE8JDT7d9hljQ==
=P0BZ
-----END PGP SIGNATURE-----

--ejqsmakmfeudclee--

