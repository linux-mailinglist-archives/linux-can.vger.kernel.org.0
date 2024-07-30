Return-Path: <linux-can+bounces-1062-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AB394105C
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 13:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D317D1C22EC7
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97EE19885F;
	Tue, 30 Jul 2024 11:18:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7CC19DF98
	for <linux-can@vger.kernel.org>; Tue, 30 Jul 2024 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722338301; cv=none; b=J2iyh33BUxG4M16bcxITzJUF7nNac13iuuSoR6+Oy+E1SRKTO7RwxQ2Giulb+dMy2UA0pamDrHroE4EytpX9qNB5Vu1BOgsz/SMWNFixIdgAZvxs7l+mpqxXldMIliBJeXWbuhQJrOH96SpUPTMgokWO0JbUjThEWyBxeW7A6xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722338301; c=relaxed/simple;
	bh=V56haVpUFlrD9G+P/ApnsxfO7fu8PgDIiuBLOvFaqlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msWRiZLe9HZc6PuW+87lBsIrerxW1fCYrCiwZYiYKMQQlkJtPaYiKooaPCLffIXPg/WyKVETp8KfrleqlRJtLgb+W6c+3Tq2TnskfeC1NLFO54lWhpqRjFQI6+MfYePOoGWq5bZf27PuZWWkyjQukDAxMIUkWstL1dIpYBQciZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYkrX-0004Xm-8L; Tue, 30 Jul 2024 13:17:51 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYkrV-003Gpk-Mw; Tue, 30 Jul 2024 13:17:49 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B9994311BB3;
	Tue, 30 Jul 2024 11:17:48 +0000 (UTC)
Date: Tue, 30 Jul 2024 13:17:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vivek Yadav <vivek.2311@samsung.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC] can: m_can: Release irq on error in m_can_open
Message-ID: <20240730-slick-ochre-saluki-13bd13-mkl@pengutronix.de>
References: <20240730-mcan-irq-v1-1-f47cee5d725c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6j3hsfckprgnpgna"
Content-Disposition: inline
In-Reply-To: <20240730-mcan-irq-v1-1-f47cee5d725c@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--6j3hsfckprgnpgna
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.07.2024 12:12:21, Simon Horman wrote:
> It appears that the irq requested in m_can_open() may be leaked
> if an error subsequently occurs: if m_can_start() fails.
>=20
> Address this by calling free_irq in the unwind path for
> such cases.
>=20
> Flagged by Smatch.
> Compile tested only.
>=20
> Fixes: eaacfeaca7ad ("can: m_can: Call the RAM init directly from m_can_c=
hip_config")
> Signed-off-by: Simon Horman <horms@kernel.org>

Looks good to me!

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6j3hsfckprgnpgna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmaoy9gACgkQKDiiPnot
vG9SRwf+JstLRjVK/HSfI6knM/Y4//wuo3mRdAg7NKsXt6W0QnJATIxKHZEDrjL1
OFlbHKPEZajtCTwKC1BLGNXuoG8MBOEL3aYoIenHmRacMdEcfPnBNzlEHm5+5DN4
v7Mx7tqGdHKfHvOgMX3GSxLpObOX/8hbDviG4C2gQawmoSf0ptyWXBwMfClkS4kQ
8aK2j7oYExKkNzy2TsdJ62isaBM2cfEg0hi+y1GLUXUDBdUAYhsjdhyJVRPiD3cU
dviDIIva5uzlS/mVT5Lk3L7VvgJV6me/+qY7MbI1XaqkOnDwr4SSwJE21VM9I6yO
o0ZYqI6J0Mu6f6nm5hBFItSG6Q6pMg==
=JR/c
-----END PGP SIGNATURE-----

--6j3hsfckprgnpgna--

