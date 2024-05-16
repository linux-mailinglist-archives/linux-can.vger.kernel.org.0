Return-Path: <linux-can+bounces-644-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB8C8C75E2
	for <lists+linux-can@lfdr.de>; Thu, 16 May 2024 14:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992332846EF
	for <lists+linux-can@lfdr.de>; Thu, 16 May 2024 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D743145B1E;
	Thu, 16 May 2024 12:20:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495AD14534B
	for <linux-can@vger.kernel.org>; Thu, 16 May 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862019; cv=none; b=MaI9wh8hw1SBgaF9K4R4IQLmb5An8lPDomf+99zwQVV7LoZmvRS1SjiTSmHwrzj/ptvqcPBRpMsk6v4B+pplKdYE7czgIOn7kRB8tDk4JgH13dDzLat8GmBwBQoXjfMBc4OHHxTV8wNAa9b0Emh9AmRh3ITTj2jyx5KDvPkcQMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862019; c=relaxed/simple;
	bh=gb2pFTNL5W3F4sj5zfxXi6KIRwk7CIQadAbSvCvTgSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjrloZt3r4BaB8LBovZZMMntWlsQqrefg/p7R/evHLhodppCgbhw/AQ92s1CjxphtxpnPebUsdeNtfFQJRRRfrIQ3671wt/YJ+F9DxWy2EP+fDqq0QjLUYCq8zCc+4krjfbiTf6y6deoLquyaGUBwV+8OdB2pjMK731cRAWLYsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s7a5l-0004cD-6K; Thu, 16 May 2024 14:20:13 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s7a5k-001i4U-Jc; Thu, 16 May 2024 14:20:12 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 44A4F2D27F5;
	Thu, 16 May 2024 12:20:12 +0000 (UTC)
Date: Thu, 16 May 2024 14:20:11 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin =?utf-8?B?Sm9jacSH?= <martin.jocic@kvaser.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>, Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH 0/3] can: kvaser_usb: Add support for three new devices
Message-ID: <20240516-large-diligent-dinosaur-00f17c-mkl@pengutronix.de>
References: <83e29b3a47819181797934a49d62f20591e96ec8.camel@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qtfwgslvjbtpwmcl"
Content-Disposition: inline
In-Reply-To: <83e29b3a47819181797934a49d62f20591e96ec8.camel@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--qtfwgslvjbtpwmcl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.05.2024 12:17:08, Martin Joci=C4=87 wrote:
> This patch series adds support for the following devices:

Please use "git send-email" or "b4" to send mail. The patches are html,
have been mangled and don't apply.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qtfwgslvjbtpwmcl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZF+fgACgkQKDiiPnot
vG9PeAf/TqoVAWfVlXXlBDmu5gTWrjeS4weGVdtbXOvSAfstdLD3JOqRiJtAeRUe
1PVQC1bHJYyeY1YSKvtKtDc4k/c6B9YBgb1KhhNPhUfVvZLOZYhNSOHF9wE2r1Yg
kDXGMuDI9Jc45etbKzEhSrbSFHJ0MdysDQBiq1UULZI8irHhzRlc7GxqxfE54Mss
HVB4zu2+WmSmOqsSPLP3jm0jv6k9YJiamiK08jCUmjQySq6h4iQ8AF0wT2tqFqr3
qLB96RkUwaqT446oonBh8u49CGD3PwqbDtwnriq1/MNiy3JO9qRWVEnfhG1inW1d
PfDaHZ94c+VhShP70JG044Ihi9i4Tg==
=i0BT
-----END PGP SIGNATURE-----

--qtfwgslvjbtpwmcl--

