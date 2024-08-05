Return-Path: <linux-can+bounces-1107-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 699DF947DD2
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 17:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFF21F2122C
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 15:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0FF13CFAA;
	Mon,  5 Aug 2024 15:18:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F206158DD2
	for <linux-can@vger.kernel.org>; Mon,  5 Aug 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871118; cv=none; b=sKaiIMGofPSTwotZQ53Q+Ko8/IvuoKNSVsbmAl8OEIts0hmURiZXWNyKLqJQNl1qOJm+OIkCoYldpd0r70B5Q07W+46zXMg2lNLlRaDP+UQT0ITrcu+Ne1pqrmNV6ZMBg334jHTz/0Qfx7axrqh7v9hOtKJBAK/feryGhiVJUEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871118; c=relaxed/simple;
	bh=zoB9quVCCMCFyv5ZsUEb4C2MmDFvY18pyDbZ6M6IhLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdADTnAE8ny7LSwphPVeIgqU3bqNiuH3UEQEdEr7AcaT9HBRbCRvJrIESnW8UQOqcZrXALiOz81vqhhydzYqfe94jCHHhB/cFJTVXCE5QPuU7XuBTG4rhz3/N4tuKA4+J+tJS5uJYKVRJhlD3iDq9kYSQwibQLGo/KbfTor/fu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sazTZ-0000aO-2I; Mon, 05 Aug 2024 17:18:21 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sazTW-004k73-QR; Mon, 05 Aug 2024 17:18:18 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0FC433172C4;
	Mon, 05 Aug 2024 14:42:46 +0000 (UTC)
Date: Mon, 5 Aug 2024 16:42:45 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vivek Yadav <vivek.2311@samsung.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] can: m_can: Release irq on error in m_can_open
Message-ID: <20240805-swinging-wolverine-of-potency-529367-mkl@pengutronix.de>
References: <20240805-mcan-irq-v2-1-7154c0484819@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ru4nfge4yg7x6vt"
Content-Disposition: inline
In-Reply-To: <20240805-mcan-irq-v2-1-7154c0484819@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--3ru4nfge4yg7x6vt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.08.2024 15:01:58, Simon Horman wrote:
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
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Simon Horman <horms@kernel.org>

Applied ti linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3ru4nfge4yg7x6vt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmaw5OIACgkQKDiiPnot
vG+KoQf7BlmdDSOW7fQjDZ0Y0jfsV7pq59N/S77MZVOBHm4iAFg1+R5B0S6wJ749
5JlZabthjAYZ26GHF9iHhN61HaxsGXq0XUKBZNnvdN2B0ppqthWdcvAP60uFff+3
+qNPXjsv4dAcMQh2jMs2aRAi9/9CQ/MVd2YyskL3b1y+FocSnAOG4UMlRGi2bBy5
ZuZdsg7mjYVjvKYo2SsGj/n57J+iZSvhtM/czVmkUUIRkvm8nr7huCcHT9+qnoKe
KoU87FElalfvY+mDBc4S6NyiBE99uAG/a7b7gvSLsK8Kt7PxrjbEzBwNlfHMBwhL
NP2PADb4vXWq1DDrCTL2pWp0uuRldw==
=Hlsq
-----END PGP SIGNATURE-----

--3ru4nfge4yg7x6vt--

