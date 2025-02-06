Return-Path: <linux-can+bounces-2734-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB28A2A2D4
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 09:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765D7160D9E
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 08:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B325D1FF7D1;
	Thu,  6 Feb 2025 08:01:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11331AAA1A
	for <linux-can@vger.kernel.org>; Thu,  6 Feb 2025 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828873; cv=none; b=B5xHrFYflLHxtQbfwo4+GCL3YW+3LFrajg9Mvrj2I14VKgWsye7mEfM4Htj3V/x/2uNts8LZpMyVs8TXmimS9qvFZb+9vpbFADhXynWAIPnxHUfjVF/Bdlx+IkpIzliJ7c2FX+KgH7ULK3MMp7rVo5a+iMDkO20S2dfoB2MTxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828873; c=relaxed/simple;
	bh=VQ5m3cvH3u/AFsPK3G4NSiEakzmd1XQfjHR8EDNe6YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2OgEUW79zR5+gvKiWbXSfVEQAQMYryzPU/guBrmZUmm/EluLcpFl5PGpYXkfxrSPnPKx14u/h/oP0sj1HWx/Xv415YKpsOWXnupIgBpRYGp5qL8yMKfpG1m0c9sOzFFNWrzSgWxSFnjPWOKqo+bCy/2cLJIPEH+FPO1MCSR0kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tfwov-0003kr-4c; Thu, 06 Feb 2025 09:01:09 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tfwou-003lj5-1x;
	Thu, 06 Feb 2025 09:01:08 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 46E2D3BB120;
	Thu, 06 Feb 2025 08:01:08 +0000 (UTC)
Date: Thu, 6 Feb 2025 09:01:08 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yan kang <kangyan91@outlook.com>, yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCH] can: etas_es58x: fix potential NULL pointer dereference
 on udev->serial
Message-ID: <20250206-romantic-sloth-of-ecstasy-de9305-mkl@pengutronix.de>
References: <20250204154859.9797-2-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u2hwymt3mhe6d7bg"
Content-Disposition: inline
In-Reply-To: <20250204154859.9797-2-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--u2hwymt3mhe6d7bg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: etas_es58x: fix potential NULL pointer dereference
 on udev->serial
MIME-Version: 1.0

On 05.02.2025 00:48:15, Vincent Mailhol wrote:
> The driver assumed that es58x_dev->udev->serial could never be NULL.
> While this is true on commercially available devices, an attacker
> could spoof the device identity providing a NULL USB serial number.
> That would trigger a NULL pointer dereference.
>=20
> Add a check on es58x_dev->udev->serial before accessing it.
>=20
> Reported-by: yan kang <kangyan91@outlook.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/linux-can/SY8P300MB0421E0013C0EBD2AA46BA7=
09A1F42@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM/
> Fixes: 9f06631c3f1f ("can: etas_es58x: export product information through=
 devlink_ops::info_get()")
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--u2hwymt3mhe6d7bg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmekbEEACgkQDHRl3/mQ
kZwGFQgAoBQoNbnOJT0kFId0fK9EcDCobP6NiivFFRVAcE/WD4iXWTAigPBBMsjH
1Vz3kK7SSg372Jh/TxulEI569WJYfYdDWu1W4RUbEbhUAh8putGeX/zX7gOKkyFn
IIvhI+alssMetrQRttfPVJ3nu18zvA2VwRbMPUd6/ECZZAFrzlmu/TY2/3Pe1UEs
6DWh6gAZTeQBEo60og5ZOR/mqKuMqsIhiCa5Txdy+SOWNlZf7a9NlUIrJy2w1TWZ
Y4+E+aPb2AqxntShz9fbUmUfucjwiylkPb+/Q0g/7mL/fErVvpQOrqu/BsaT9Ww1
1mE8u6Qa59Ro0S7+eJNm6UrF8YbYIQ==
=W+kw
-----END PGP SIGNATURE-----

--u2hwymt3mhe6d7bg--

