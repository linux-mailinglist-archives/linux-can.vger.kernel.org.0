Return-Path: <linux-can+bounces-226-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767D2851870
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 16:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F941F238BB
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 15:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1973C3CF49;
	Mon, 12 Feb 2024 15:51:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967483CF68
	for <linux-can@vger.kernel.org>; Mon, 12 Feb 2024 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753071; cv=none; b=T6Jgf3zqMTJUh/zvWB6OusTdqSV/LpjzlYFwZPqdI7PAAiQgmlcLiBpzbthJ9NGtKny01GMu4Emv3X0grQfICUWN5T72q9TE+kwwru7Wi25IzM1UWyW7WT3fhS4ymDwcmY1EXiPmdBenCuHq2fZ++NiTCOnZiI7klUlxJmxaI/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753071; c=relaxed/simple;
	bh=KsTeKWJL6U9KyyO7giHiSDGN/BfbZkfqBJ76CU/N3lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbcveRER543Q1e22mQo0JzHxGEdnRZLkxgcgGHE87iS50YCmA/4drwg2iKrg8DHdQrbbrrrqt+lSu979k/Il6zO49dpA/qyR7FO+luIXFBJsGyPMWoyGUa2QDmKdm1mG3Qn/X1nE7EGYI+R2tZf2Fk4WtbE/+XVnDgBV6kBxYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZYaG-000734-Kg; Mon, 12 Feb 2024 16:51:04 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZYaF-000Jcx-QY; Mon, 12 Feb 2024 16:51:03 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 77FB028C6C7;
	Mon, 12 Feb 2024 15:51:03 +0000 (UTC)
Date: Mon, 12 Feb 2024 16:51:03 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Guy Harris <gharris@sonic.net>, 
	Vincent Mailhol <vincent.mailhol@gmail.com>
Subject: Re: [PATCH rework v1] canxl: add virtual CAN network identifier
 support
Message-ID: <20240212-coveted-gift-6a9a29bc0484-mkl@pengutronix.de>
References: <20240212151404.60828-1-socketcan@hartkopp.net>
 <20240212-smooth-pregnancy-3c6ff0a86246-mkl@pengutronix.de>
 <c5cd87f2-3cde-43d0-9cbf-e7d4de6b9afb@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3yuay2dy7dqwzxum"
Content-Disposition: inline
In-Reply-To: <c5cd87f2-3cde-43d0-9cbf-e7d4de6b9afb@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--3yuay2dy7dqwzxum
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.02.2024 16:29:28, Oliver Hartkopp wrote:
>=20
> > What does that mean for
> > https://lore.kernel.org/all/20240128183758.68401-1-socketcan@hartkopp.n=
et/
>=20
> I've send another mail on this question. I just had to wait for the patch
> URL to show up on the ML archive. Did not expect such fast reply ;-)

The URL is predicable, it's:

    https://lore.kernel.org/all/ + Message-Id

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3yuay2dy7dqwzxum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXKPmQACgkQKDiiPnot
vG+1nQf/f9MrLR9MkUD+thzTskRTQup096MAnxEczPvqmWY/V9JzuVuPDeFccDPm
4sIbM2a2muqQU9oFeGfT4/zFWJp0idsa41LbHOJtM7fg5BRZTDOtvuVkBPmA63Jc
/ZtzUgCdIVH4qUu5iwra9b5h/5TV97Fnslpt15ZzYpNiVOYRlniQilpsX4vNFNuq
1L6QyWOjoldIsKXAP+E5jVAcRfOUY2rQXdU3kGfCLJMzVpl6IBe4FkTMREvmpvKP
Sw5I2v3PiDUvM6AWG8csynV4ISVsYy+yQrZYg95cNd6sYd91zB3UaRqGQCi4SIX3
ooc/1dAHx6YeQ5i6GAXa3MiZcbYovQ==
=3c0C
-----END PGP SIGNATURE-----

--3yuay2dy7dqwzxum--

