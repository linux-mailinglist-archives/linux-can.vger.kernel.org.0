Return-Path: <linux-can+bounces-4760-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CC7B8B037
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 20:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4005608E7
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B54525C6FF;
	Fri, 19 Sep 2025 18:58:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56601E5B7B
	for <linux-can@vger.kernel.org>; Fri, 19 Sep 2025 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308291; cv=none; b=SayYjIV0VBawgnuGyRMIewfIa6HI878RPP9mi9e2u5aUzfDckqwTKvOdKsxtl1zdtQAzUpLuEVOyV+HAsfPdG5juuShUHDUSkHd4S8MCLFjUqIWhehl5e9V7CVftgmXMZc89pe63TI9vL6e5DDSKArVoAtIn53fPM0spxHcwlJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308291; c=relaxed/simple;
	bh=22xxRxgSEiW7bx4yw7KNmPDtMS1Y+vlZbxbxWt2b2Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N456vqjye6EryTGswQK6OoIu5xoi8kb/A57KgZwQcM2fANMztYRn0QWvTAfXoJ3Sx7ZjG0g3B+4yx5repMkH7uolWJa1JfbR8hqda4rxRl+U1Kq7pToCDK/wdXVMz7wlxm+9idaPUJm8DLszND6BVFu8i2jX6aZM7X7A0nZR2MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzgJ4-00018c-C0; Fri, 19 Sep 2025 20:58:06 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzgJ3-0029MG-2n;
	Fri, 19 Sep 2025 20:58:05 +0200
Received: from pengutronix.de (ip-185-104-138-125.ptr.icomera.net [185.104.138.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A5BEE4751CC;
	Fri, 19 Sep 2025 18:58:04 +0000 (UTC)
Date: Fri, 19 Sep 2025 20:57:59 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 0/3] can: raw: optimize the sizes of struct uniqframe
 and struct raw_sock
Message-ID: <20250919-tiger-of-angelic-fragrance-f0668e-mkl@pengutronix.de>
References: <20250917-can-raw-repack-v2-0-395e8b3a4437@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yss2kkbwctpngcbc"
Content-Disposition: inline
In-Reply-To: <20250917-can-raw-repack-v2-0-395e8b3a4437@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--yss2kkbwctpngcbc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] can: raw: optimize the sizes of struct uniqframe
 and struct raw_sock
MIME-Version: 1.0

On 17.09.2025 13:48:23, Vincent Mailhol wrote:
> A few bytes can be shaved out of can raw's struct uniqframe and struct
> raw_sock.
>=20
> Patch #1 reorders struct uniqframe fields to save 8 bytes.
>=20
> Patch #2 and #3 modify struct raw_sock to use bitfields and to reorder
> its fields to save 24 bytes in total.
>=20
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--yss2kkbwctpngcbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjNp7MACgkQDHRl3/mQ
kZw0xAf/bE1DlddEsYjaj6ZylsJ6/TyZIt4ovZqmFntLwZiBPips/kLdEIQ6YlP4
Mp79cf/B02EEklCXmjxcTmdhwqZhuoYDY5MFioxoNvzS5/Dja2G4UwRn/LXAu+5P
dHJmBVTqRqXJyUr0pa41/Jzg2eTkkbh+IkJQMckn4cebFhz3ARpZn9lsw8LEeTSY
9mkMB3SP4oB57DaXavkw5hVRiyiZoZThZJZRCWA/RcUeeRlSePuuxKbYCh6AXKGL
u5X5KjEauOWOXZiukyV7YRg4i6jLiEFsSChi8KimZVPiQtImG9iwEw7+GaiteQxQ
IthKouXkA97d9wJ5mqBgA6nQXYkrfA==
=QMRM
-----END PGP SIGNATURE-----

--yss2kkbwctpngcbc--

