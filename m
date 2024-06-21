Return-Path: <linux-can+bounces-829-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F400A911ED6
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECE61F26537
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81F15A49F;
	Fri, 21 Jun 2024 08:32:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5225283CD4
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958764; cv=none; b=H7ktzt+GGP8dmEw6D/yGiVj1Gwv8bi7tgFpdLu8KmCp/CAW5mlvX8EhKWbSThKqMvzNlnAp0fj7wQetqGoMGT+x2AFli86SjX1neCmZLaPuX0YklNU0bi0VZ4JPeGN42T85NrzmcgqYPPbY9bKGSwdOPZSf6bcdme8UJE6KJCGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958764; c=relaxed/simple;
	bh=daS9aJZhTJcgfHTDrztn2JUHLiLIJqNzJdBuv8HUVGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ag22RSuDo2dcKzu9J6G01N9xLSFmkTqSc1gH4U0hm/F3d472Mk9weG2xwc9SgIgWslUQFhXBAKlxR7UKvp6U1OBu/aLY/dRvQAcR12TSUGn6uvbeOLzk24CbZ5WWFn3KvMf6vnQ/zN/o4K0DSNuN+jNd8cvVf9h724k5IuMmgdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZh8-0000Pr-Gp; Fri, 21 Jun 2024 10:32:30 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZh7-003ttA-3V; Fri, 21 Jun 2024 10:32:29 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CFC342EE57F;
	Fri, 21 Jun 2024 08:32:28 +0000 (UTC)
Date: Fri, 21 Jun 2024 10:32:28 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Markus Schneider-Pargmann <msp@baylibre.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] can: m_can: don't enable transceiver when probing
Message-ID: <20240621-magic-slick-tarsier-5c4d86-mkl@pengutronix.de>
References: <20240607105210.155435-1-martin@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dr4sgbc4ol5qlmml"
Content-Disposition: inline
In-Reply-To: <20240607105210.155435-1-martin@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--dr4sgbc4ol5qlmml
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.06.2024 12:52:08, Martin Hundeb=C3=B8ll wrote:
> The m_can driver sets and clears the CCCR.INIT bit during probe (both
> when testing the NON-ISO bit, and when configuring the chip). After
> clearing the CCCR.INIT bit, the transceiver enters normal mode, where it
> affects the CAN bus (i.e. it ACKs frames). This can cause troubles when
> the m_can node is only used for monitoring the bus, as one cannot setup
> listen-only mode before the device is probed.
>=20
> Rework the probe flow, so that the CCCR.INIT bit is only cleared when
> upping the device. First, the tcan4x5x driver is changed to stay in
> standby mode during/after probe. This in turn requires changes when
> setting bits in the CCCR register, as its CSR and CSA bits are always
> high in standby mode.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@geanix.com>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dr4sgbc4ol5qlmml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ1OpkACgkQKDiiPnot
vG/4TAgAmLUazXAa8AZVzXY39Anxi7BZb29Xo7lZfvw3pNPLCdv9kxblG6K/R0GB
XFZ8q1VJzmNohbONojvo8ybg2/qzI1Tg4TmrMMpjFivcw2qpGGx4ltM4DUCccT3Y
+JxdtVwqKx+rJM4aNgXxfSsdlAlGv7lX5EW0RUY5zb9Y60ENEwqe9UCrWKRR04p8
1JhOG9Dv4PBaXsvOBn2ZmRIg39F6lbl3A6z1qFHQw6KV2T5voMpFGrgvpcAntwVJ
mihMhm0sMPOEqEKQ30SoKVs87Vyt1Vb7ym/0KGusEFGY9plmfw5P2rreOKLFmMkJ
VhwjsniE10gXIuenWguXkAPVQLEfLw==
=kv+C
-----END PGP SIGNATURE-----

--dr4sgbc4ol5qlmml--

