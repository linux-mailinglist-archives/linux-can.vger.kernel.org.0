Return-Path: <linux-can+bounces-563-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023998BC029
	for <lists+linux-can@lfdr.de>; Sun,  5 May 2024 13:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66F42818A8
	for <lists+linux-can@lfdr.de>; Sun,  5 May 2024 11:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7D7849C;
	Sun,  5 May 2024 11:01:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C43C5680
	for <linux-can@vger.kernel.org>; Sun,  5 May 2024 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714906893; cv=none; b=GPf+FuSpEW/8DD0MVKk0pCrZSGyAoT7hsdH6pWlPz4bTNyGvaHMK6TLyof3kVbPoyieiz6oS1HZzrtofs1kLGU+eXWbLE5NIpT8XyGxAV4epzKAovIyNeCRRfkQO6zJ6M2jjqAncJAfuwPsx0mEA7lq4GhcMFjN27k1m/Zg6i40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714906893; c=relaxed/simple;
	bh=/sq8W/RMqV5sJ5BxKF3BR/Rccp7w3Wrj4tY/YJgKiEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXTx4wA/h5rGFgkS1ebaa66LEAhaMhizFHl4EqlLFKF8pi5fiMbvKHhUfDazWEQ4nhRWD/MmhP4/xVrxBKy0m+BQnIpPSJIm944LsFzXoP/E8PB3D06s+FTrQK9oz2t5sIneT4NJHT8OaDLUP6PMHdzIfoeBEagzSDjUUv0NhoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3ZcJ-00084C-9I; Sun, 05 May 2024 13:01:15 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3ZcF-00G42r-VK; Sun, 05 May 2024 13:01:12 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8D06C2C9C81;
	Sun,  5 May 2024 11:01:11 +0000 (UTC)
Date: Sun, 5 May 2024 13:01:09 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] can: sja1000: plx_pci: Reuse predefined
 CTI subvendor ID
Message-ID: <20240505-micro-degu-of-memory-a8490f-mkl@pengutronix.de>
References: <20240502123852.2631577-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oajw5gtxeutevdc3"
Content-Disposition: inline
In-Reply-To: <20240502123852.2631577-1-andriy.shevchenko@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--oajw5gtxeutevdc3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.05.2024 15:38:52, Andy Shevchenko wrote:
> There is predefined PCI_SUBVENDOR_ID_CONNECT_TECH, use it in the driver.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to linx-can-next

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--oajw5gtxeutevdc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmY3ZvIACgkQKDiiPnot
vG9c/Af/fTaOm84MFHU6/wh2K89RdBL6AfImnl2h9Cqm6yY2tYfdwEemADyIBSlU
I32WQWfp4Jc3XqpCv1KdYKb84tz4Fhi5wlM+9IYaAKkrhIpaaR8s/aQ6L1LdSV9M
zlLCrzj/7H3aZljYlK3GPIrvrUUqnzC1Zmj4ex/JBGFcGzROb250WgotPsRVlUWA
ZAFxn5F1rCMmtIsrWseUx6SkjQUIiUqTxhTNZkGBTOHvqArJzPapOcIvRaoV4LsT
MFte1B42C37JZ1QnnwrPjxRQgziAtLaqagmYrqmk30zn0+6zuEuVNS7/3ooqOS4G
NxXIBImGV51zqtx30sYdMwhr+ujEvw==
=1ldS
-----END PGP SIGNATURE-----

--oajw5gtxeutevdc3--

