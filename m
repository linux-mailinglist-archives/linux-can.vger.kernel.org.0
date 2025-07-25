Return-Path: <linux-can+bounces-4118-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6CAB119DF
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 10:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F981C84046
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 08:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3EA2BE7AC;
	Fri, 25 Jul 2025 08:33:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273572C033B
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432419; cv=none; b=R77RYFQUCJqeGRIAPakU+vrmBzEHmpw2i4F33XA6mDJ7My1H1EF6zYJE7KgoXTWgl2mPx1XRYSrZTrFiuGU85GdkSkUYmfe1ABxCvXqtaU7a4mnwGEZVxaq1iGw0rME0CXM6Gh2/dFtvW6H/AdJVsbpfCiFdGt/H7RvUAJINQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432419; c=relaxed/simple;
	bh=QlvAmP4lpuRNJ72tT7uEW+KAYOHIlXPy0UR8uyqwblA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI7wobCwrcPp5paOfw2HApqp69diMNZO+8ErbKIhl3dY6fonOLFSo0p0ot6MKLg2NQaqgDwVbUiJco8mWEAbXpB+euQax6BUchKk9ln8t8Oy1qPAGs9+dgy9FZZFfZXWXG810uXyOTzm4v3/aKrt7s/N2vxEBB4L//DP6PtvMF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufDrq-00026u-IR; Fri, 25 Jul 2025 10:33:26 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufDrq-00ABlQ-0V;
	Fri, 25 Jul 2025 10:33:26 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CC8BB4492D1;
	Fri, 25 Jul 2025 08:33:25 +0000 (UTC)
Date: Fri, 25 Jul 2025 10:33:25 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <stephane.grosjean@free.fr>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, 
	Stephane Grosjean <stephane.grosjean@hms-networks.com>
Subject: Re: [PATCH v2] can: peak_usb: fix USB FD devices potential
 malfunction
Message-ID: <20250725-whimsical-finicky-sambar-5202a2-mkl@pengutronix.de>
References: <20250724081550.11694-1-stephane.grosjean@free.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mvff4ihlaeibwvsa"
Content-Disposition: inline
In-Reply-To: <20250724081550.11694-1-stephane.grosjean@free.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--mvff4ihlaeibwvsa
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: peak_usb: fix USB FD devices potential
 malfunction
MIME-Version: 1.0

On 24.07.2025 10:13:19, Stephane Grosjean wrote:
> From: Stephane Grosjean <stephane.grosjean@hms-networks.com>
>=20
> The latest firmware versions of USB CAN FD interfaces export the EP numbe=
rs
> to be used to dialog with the device via the "type" field of a response to
> a vendor request structure, particularly when its value is greater than or
> equal to 2.
>=20
> This patch corrects the driver's test of this field.
>=20
> Fixes: 4f232482467a ("can: peak_usb: include support for a new MCU")
> Signed-off-by: Stephane Grosjean <stephane.grosjean@hms-networks.com>

Added to linux-can, don't know it if makes it into the v6.16.

I've included Vincent's R-b from:
https://lore.kernel.org/CAMZ6Rq+FH99xRNqndUVqFQwBMjutdrYsrvpJn_n6gTOC7zsAkg=
@mail.gmail.com

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mvff4ihlaeibwvsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmiDQVEACgkQDHRl3/mQ
kZzupwf9HJ7nFIqmC8C5E9x85V9qSHyiXPHNvH1zyZ2leD07fEu8E4Iao6miEUEL
iWkqTI9WSmoiDOsjKNus4/ZzFeIoNk7R6IPMvNtgRDGY8rKaK/XzdftWLGUUpPjm
FkkSos7uqp5jwlDF+Ppe2JZITrkB+hwAP4ZbhOUZdWmKlIz/Af6y3HeRe/dPfnKd
rhEq8XE5Oi0jGEvTgs5/9gx3fpI+2l8RfY7SIUaXHK6A/QAY+eFx9INrKDgLfmTv
32/1/coqm9JA2v4xECoDog2DGmiLniq+8km+s3VPRrbE+NlAOlgH1dBQudp/gLHd
ci5ZByVAt8vhtCFiN0yZpiyp2Nj4zg==
=ZXqm
-----END PGP SIGNATURE-----

--mvff4ihlaeibwvsa--

