Return-Path: <linux-can+bounces-2294-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F3C9DFC23
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 09:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58985B20BD9
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76C01F9EDD;
	Mon,  2 Dec 2024 08:41:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EA22940F
	for <linux-can@vger.kernel.org>; Mon,  2 Dec 2024 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128863; cv=none; b=Pp1TOFxuSbtCEuJ9pT5/ybTUKkYEFXZsF3EQioLtC0MzX4mwzaHPFiUNWWAe9/Fff6TqDU9eKu2iUkhuKKY/GVL/1LPAp7c3RXgyP/llgcCZST/gCPBaAroNKk8ujXufZ41jlUft25Wcubwi0weeOgRGTckA+IaeV4fbs/BpJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128863; c=relaxed/simple;
	bh=7I+R5L1BwJqd9zIkPLNyF04fhIpkeHr5L099bXPGOSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eq/8G4pp1Gmqk08NUoYeD8p1da1QkQMAtCkInE0jcSOy/+i4yP4kJNShQ8i6MFi91i7SHZSaJbloB3sh9XdniOv3aCKbbez96xAy7VFEOaV1bKtJek6hfoxmTd8Vnb6cES70tLtfpipMExm0QhL589+UiVyXfdUwcCpent9XC58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI1z8-0004S3-K6; Mon, 02 Dec 2024 09:40:50 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI1z7-001GTZ-1g;
	Mon, 02 Dec 2024 09:40:50 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DEEA83832DE;
	Mon, 02 Dec 2024 08:40:49 +0000 (UTC)
Date: Mon, 2 Dec 2024 09:40:49 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH] mailmap: add an entry for Oliver Hartkopp
Message-ID: <20241202-nocturnal-functional-bulldog-edb76e-mkl@pengutronix.de>
References: <20241130170911.2828-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eccj4hq4c22jucxq"
Content-Disposition: inline
In-Reply-To: <20241130170911.2828-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--eccj4hq4c22jucxq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] mailmap: add an entry for Oliver Hartkopp
MIME-Version: 1.0

On 30.11.2024 18:08:34, Oliver Hartkopp wrote:
> Map my retired company address and an accidentally used personal
> mail address within mailmap.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to linux-can-next

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--eccj4hq4c22jucxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdNco0ACgkQKDiiPnot
vG8Uowf/TeVIu172xO4s8cqqFWYRI+ZcItGn/DLa+eyeX4FtaQ1c6GhfOjMbi2r/
evPNfkLRJrDlstEQg66+6QcfEonEKaY8KJ15FLkUqaCsYFDQ8o2bu5dqiVTBvo9J
FzfbFGUmcKpORgIWLgksSex+iiJqCdXYVKU/9MJkNdqEEUcc7o7iOkFZpUyiTxzK
LvfkC62yQ7VhJU4UHT4/Djh+bhPpilD/4UUeQsif5GbhLgOJqQOrvHSvFQHLQC7X
sd2/BqHIzPV8wvdtscRKiG/dKtLLVcKMFNqnya9auM2aNgM7PItbwxlmcz0Ef+Az
sJMyuM1KpzzvEVwsxVwqsNweF2mZTw==
=dCBh
-----END PGP SIGNATURE-----

--eccj4hq4c22jucxq--

