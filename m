Return-Path: <linux-can+bounces-5295-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB69C28FF8
	for <lists+linux-can@lfdr.de>; Sun, 02 Nov 2025 14:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91B4E4E47D3
	for <lists+linux-can@lfdr.de>; Sun,  2 Nov 2025 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161B61F582E;
	Sun,  2 Nov 2025 13:55:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB31E98E3
	for <linux-can@vger.kernel.org>; Sun,  2 Nov 2025 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762091727; cv=none; b=FYmBvZWe3O3xwn1kLgVG3pAtDOlzto/VIdf+BOJ11rrlI5VgM3JfN3FYLNwDM7q7Xv1qbmkbnIyYlblv0IFMtLDQenx8mFn+9T/hSoXmOwuK5e3NbzjTwMy42YZ9Ys76QLPxp6qh4IOGGIqL5A+jLyYX45K4IyBVadLQV3g9/Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762091727; c=relaxed/simple;
	bh=M2IisSCTvrkgv5ctIyTrkxVp3NrBj65m8a0MhyuYjpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG609TdenhmIP7NEtk6wpGurIzl98YqxzLY53CHVXEey1XAkvmcyie2erXTsI8gnjuSI9tiQ1IDd/k3c+h1RqC5lE8iQ0zhGOFgltDc1d72JAPnrQ05VGjc+U8M/FPZZrw1sJVssDicsEF/yGfxVfv0i5tMU4KsyBjUEAcJaLtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vFYXv-0007Xl-0u; Sun, 02 Nov 2025 14:55:03 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vFYXt-006ha3-0A;
	Sun, 02 Nov 2025 14:55:01 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C5D33494550;
	Fri, 31 Oct 2025 12:19:54 +0000 (UTC)
Date: Fri, 31 Oct 2025 13:19:51 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>, socketcan@esd.eu, Manivannan Sadhasivam <mani@kernel.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Jimmy Assarsson <extja@kvaser.com>, Axel Forsman <axfo@kvaser.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 0/3] convert can drivers to use ndo_hwtstamp
 callbacks
Message-ID: <20251031-fierce-laughing-hummingbird-208a89-mkl@pengutronix.de>
References: <20251029231620.1135640-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uok4emd47n6jmrxq"
Content-Disposition: inline
In-Reply-To: <20251029231620.1135640-1-vadim.fedorenko@linux.dev>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--uok4emd47n6jmrxq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 0/3] convert can drivers to use ndo_hwtstamp
 callbacks
MIME-Version: 1.0

On 29.10.2025 23:16:17, Vadim Fedorenko wrote:
> The patchset converts generic ioctl implementation into a pair of
> ndo_hwtstamp_get/ndo_hwtstamp_set generic callbacks and replaces
> callbacks in drivers.

applied to linux-can-next

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uok4emd47n6jmrxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkEqWQACgkQDHRl3/mQ
kZyKaAf/dkrC1Ni82GV4fZJYaXVJXi6U1naARUVYLKAvPCoVAem6NU/tGcrd79G1
gMKlMmStFT/lai3orSbSLvrgFqpFbwOBJ7BtbMJMhGabU8/DJAS+QdsoSw3ADLNN
6ontAErIFaHHQn55gM3lQhoYvy8D4gMDEGOaPcvkFPx8tglI5BJllKfOjjQ8+eXb
kpbw1rNmui+yHLWe4YE8MsCrZ4ZpZmjOZB2YuBBF+m39JvCmo60/DyVwciT3tEhK
2KLh8mX7T9nMSwOTA+QiI3Hvin8QhcZYV9V5WEyZ2Q7xlMlPmK6U1ITxoX7SuuSP
On7+XGNvkJ1pUsuAHXPj/Z+8/PTTfQ==
=jOya
-----END PGP SIGNATURE-----

--uok4emd47n6jmrxq--

