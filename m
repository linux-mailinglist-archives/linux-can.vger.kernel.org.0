Return-Path: <linux-can+bounces-6131-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0604DD1DFE5
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 11:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F53C301E68C
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C9350A0E;
	Wed, 14 Jan 2026 10:19:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FC027B32C
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385969; cv=none; b=NWdKE3iH6x89pftuZD8CeJ+8JjjAwJuL1EuH+NrtT6hKk3kegm9En3chAdVPA8sHjTfsH4LfDaXmPXO1W6eWPdRpDf5rymhgi7NdCyM8cTCy3Aag4pAzoqTdX3Y1PfWH7BnLX01IoorgRP3wmhUgtKfUIz1+qRiafLyzM6QUrEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385969; c=relaxed/simple;
	bh=4BhCs5J2jbu4VR1A6Nvxx1fO692S37WLopKDmb8HGI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2ir1ggsyWSylmMG4iNiMS7UOm09iosjRwuNQgZ+02ysDY249JUak/D7sKkO90ZaXPkeFovuS3GFWBDyyWsiEzYAEhCVczaekr9bDCq9lEt6gfKVOL9rqr2qNHdlBpbxm1n6icpXIcNz3cBL6Ugb1sh5+93xXR1l4kr/CU3xFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfxy6-0001qA-4s; Wed, 14 Jan 2026 11:19:14 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfxy4-000ZXa-2M;
	Wed, 14 Jan 2026 11:19:12 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B09E54CCB03;
	Wed, 14 Jan 2026 10:19:11 +0000 (UTC)
Date: Wed, 14 Jan 2026 11:19:11 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, 
	Sebastian Haas <haas@ems-wuensche.com>, "David S. Miller" <davem@davemloft.net>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, socketcan@esd.eu, Yasushi SHOJI <yashi@spacecubics.com>, 
	Daniel Berglund <db@kvaser.com>, Olivier Sobrie <olivier@sobrie.be>, 
	Remigiusz =?utf-8?B?S2/FgsWCxIV0YWo=?= <remigiusz.kollataj@mobica.com>, Bernd Krumboeck <b.krumboeck@gmail.com>, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH can 0/5] can: usb: fix URB memory leaks
Message-ID: <20260114-offbeat-impala-of-finesse-df5c4c-mkl@pengutronix.de>
References: <20260110-can_usb-fix-memory-leak-v1-0-4a7c082a7081@pengutronix.de>
 <5b5c8a8b-5832-4566-af45-dee6818fa44c@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2neutif7tdvctb6b"
Content-Disposition: inline
In-Reply-To: <5b5c8a8b-5832-4566-af45-dee6818fa44c@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--2neutif7tdvctb6b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can 0/5] can: usb: fix URB memory leaks
MIME-Version: 1.0

On 14.01.2026 11:04:11, Oliver Hartkopp wrote:
> does this patch set need to be reworked due to this (AI) feedback from
> Jakub?

yes

> https://lore.kernel.org/linux-can/20260110223836.3890248-1-kuba@kernel.or=
g/
>
> The former/referenced PR has been pulled - so that specific patch might to
> be fixed again, so that usb_unanchor_urb(urb) is called after
> usb_submit_urb() ??

yes, probably. I'll look into that later this week (hopefully).

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2neutif7tdvctb6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlnbZsACgkQDHRl3/mQ
kZzSoAgAnuu1NlbPPcjncns8aO8Ey55nxNwqpYg5KjPyuSY3fIe5P9zMUzqiQK26
iFo3l6vfMQclxj0mef1nXNWjFA/0W3ET6zic6I/i6iq28GhuU75NAyX4b+Iqyo1U
uXD+y/4hiN5bNSHxtF2xMk8kMyJji7Hh02p4eKQjKRxBTtSygNWcW+dl08b9qp1J
kj9JsCJhPKvFIS9BwOL820ku+QSMb2XwrFbvs2qyKOAC/zI6dJubMGU+3qlQT3qW
mvH5Zy4UcQ02AOmC2SE85Mt5U4oEZBsANw1etqM+vjIXXaEGiru4bn4Yac+McKFE
LdcvgkXo2sTB+FqIbeGQN5yuUYFM0A==
=acqp
-----END PGP SIGNATURE-----

--2neutif7tdvctb6b--

