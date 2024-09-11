Return-Path: <linux-can+bounces-1477-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EF7974DC4
	for <lists+linux-can@lfdr.de>; Wed, 11 Sep 2024 11:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54251F2351B
	for <lists+linux-can@lfdr.de>; Wed, 11 Sep 2024 09:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D5716F851;
	Wed, 11 Sep 2024 08:59:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275A16DC12
	for <linux-can@vger.kernel.org>; Wed, 11 Sep 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045198; cv=none; b=Ap8n3PBsfZ6W3STj+OwY+kf1Tm9dXXSIetrSe7UtCPy45nJpCSJq6U2KkIv7D4UuhXYsxpfwrEKt3tc4zyK5GSU1nNinc7T8cry/piS/iTWFSp2Dm7IEnm/cBvM3Jf8rPGVuRv3JGdwjyDXtwE89dA6UuQ+5QkZdAYGiiZT7TJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045198; c=relaxed/simple;
	bh=VoH/z5zZCUpV+73SN7uB6Tby0WjoNb83prYqoOpBkuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwifVzlk5R3CwwLIbkwQu3mhzJ2pyyAq7XTCeNCEuFV0UFkPViBUXxvGjzopLxFjkt3zo7tmfw755JgSIDdu143OyBMrMCsY/ecB3HHcakIwPYSpUfkV+hmrPc7YK+oawGbcnu5eFJ32t2PY+TGWOjuhKKnxrZJ55vzhMvjAE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soJCc-0000pv-2X; Wed, 11 Sep 2024 10:59:54 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soJCb-007687-6N; Wed, 11 Sep 2024 10:59:53 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DFD883381B7;
	Wed, 11 Sep 2024 08:59:52 +0000 (UTC)
Date: Wed, 11 Sep 2024 10:59:52 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] can: usb: Kconfig: Fix list of devices for esd_usb driver
Message-ID: <20240911-greedy-passionate-vulture-8de400-mkl@pengutronix.de>
References: <20240910170236.2287637-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kew5wn6prucpkfqy"
Content-Disposition: inline
In-Reply-To: <20240910170236.2287637-1-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kew5wn6prucpkfqy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.09.2024 19:02:36, Stefan M=C3=A4tje wrote:
> The CAN-USB/3-FD was missing on the list of supported devices.
>=20
> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>

Applied to linux-can-testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kew5wn6prucpkfqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbhXAUACgkQKDiiPnot
vG/GWgf/dIFemA8P4T/OaztXyPAXL7oDQL0iHNSCrruSQO8A51NT2flRcLtq3WgW
+rG7QMWMooMo8tMBa+CJYMrKqo7Jz72ttJhDOeyUFcImVNPtd/HMI8lJcX6vOzLn
FzEX72tozZPkFWmnofEmgEUChiTJGX70CW8BR+y6tc58Lp94eyZN8kUOa1iMC0HC
SEZNfsZofBl1WOtxP3wu09BWqy0D74x1nDHVKV6lifkO15QI9qGQJpB9kev6NHWN
fuWk1VCTfYJEHiqYgRRS8bTI9D/lw7Ja+u+Njp+JA9pgTaPBBo09F/goe6H58io+
0Wr4+tSbEuISBUu62UzmhCsj/8fjuA==
=kVCE
-----END PGP SIGNATURE-----

--kew5wn6prucpkfqy--

