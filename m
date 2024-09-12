Return-Path: <linux-can+bounces-1495-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48FF9765E7
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 11:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2055B20550
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E61018C90C;
	Thu, 12 Sep 2024 09:42:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210B1922EE
	for <linux-can@vger.kernel.org>; Thu, 12 Sep 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134137; cv=none; b=L//vsUhJWeq2iZSpIYVqvK7NIDLPDj71VWksc/qFFRGByRMC0UgaZG6VLExLOPERgxq+lM9HpfxDke7dBY5Ybqy4ozvZkqMx7sIyNW3c02C3N0/9LLPclEYlcRGVr5WK9rEnQ8RCMJTfopQ59qtSpkhmWUrQyHFUX/yAW4bZQvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134137; c=relaxed/simple;
	bh=Katux25sGb/HIBw9+BWJODsap1n6wdAfeCSkRdm45Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC2oc22obfaGNlWh3snKTNk/hMbw5dhhsbOnUCFlVDBkDEtu2U6+6TSnWpzcjAtOMQl87Chc7YBZvWqr3ePQTZ9b3HslCKDfZymnHfV3cCcYGMCITDXLHEf78Cq72IQ28M1BDVpZkQ6IZ//1cxPuA+vLArvq82nCk9rByjn0aAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sogL6-00077f-3s; Thu, 12 Sep 2024 11:42:12 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sogL5-007Lmy-9D; Thu, 12 Sep 2024 11:42:11 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F3EB73392B5;
	Thu, 12 Sep 2024 09:42:10 +0000 (UTC)
Date: Thu, 12 Sep 2024 11:42:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin Jocic <martin.jocic@kvaser.com>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	extja@kvaser.com
Subject: Re: [PATCH v3] can: kvaser_pciefd: Enable 64-bit DMA addressing
Message-ID: <20240912-denim-weasel-of-prowess-b3a971-mkl@pengutronix.de>
References: <d7340f78e3db305bfeeb8229d2dd1c9077e10b92.1725875278.git.martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5wenrt2zrwlr65ub"
Content-Disposition: inline
In-Reply-To: <d7340f78e3db305bfeeb8229d2dd1c9077e10b92.1725875278.git.martin.jocic@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--5wenrt2zrwlr65ub
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.09.2024 13:35:12, Martin Jocic wrote:
> Enabling 64-bit addressing for DMA buffers will prevent issues
> on some memory constrained platforms like e.g. Raspberry Pi 5,
> where the driver won't load because it cannot allocate enough
> continuous memory in the default 32-bit memory address range.
>=20
> Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>

Applied to linux-can.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5wenrt2zrwlr65ub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbit28ACgkQKDiiPnot
vG97uQf8Da4WDaMhxpBopf6jtz4PmiwwgCVCXmxmrY53WP3UoJsZEbDOx+S5mAHA
IY7LL93zBHh+k14PklOZU7OVyA+EgSs0ne0r2TylhbQv50U5GbLZCDaHGwH1CecS
x2z7ZjF5H96JfrcExKIDcIufg2GLCXEzJ3oIDnfOP++yXNBcds3PY1Djsh6ruK5T
QxAMoupyZ/WxsFKcZ0aN039qDoiOzkMD9j07xtLFAXJCf9KYTHdguHFJ2XD0uhOV
6dRP1357phrunM/Zw/rQaJg5GINQL0iR/X2zkX1YaEccMCNN+GtROGGonzhb1Nwd
aZdE3hVkx6+LvfmvysVMzfhsOuyH8g==
=Og2Y
-----END PGP SIGNATURE-----

--5wenrt2zrwlr65ub--

