Return-Path: <linux-can+bounces-4754-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1E8B8AB9A
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 19:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA991CC5258
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8157C1E5B73;
	Fri, 19 Sep 2025 17:18:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2167464
	for <linux-can@vger.kernel.org>; Fri, 19 Sep 2025 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302302; cv=none; b=TjvlOmvKcITu8W9vhUKg17Y/gj9vQcHJ731ZEeaep/ml2y0VJoUCsYQ8jP2NfBN5vGqa/PTXAwaArhcQq0oJ/jxr6L0U/EssJYP96eYeH20NIUaL/jCufKRbQd2rVAV1trVSyAicKGz5xVnyguXwTC8O2OWGsghEo2BpTeKee3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302302; c=relaxed/simple;
	bh=WZz3uS5sPzXnsf+ti7wuISx2IzPBHIJOt2F1K04n/GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKiPqBzMO/w8LB1xD7mmcaH3bB9f1AOmyp+7CRGrWVbv1YA7xibiWe9G+p7ORYpEq9V1h6RsD52ROZF9ruPWj2u1FVqcLZmGwKqTDR+RSM03wJtVo10kZwvWTKVZUFIvmsP5YQKImP/XHkKVbXrLqNsLpDeKIoBGAcuCEGCKrPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzekU-0003BL-BU; Fri, 19 Sep 2025 19:18:18 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzekT-0028pW-2w;
	Fri, 19 Sep 2025 19:18:17 +0200
Received: from pengutronix.de (ip-185-104-138-125.ptr.icomera.net [185.104.138.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5097F4750DA;
	Fri, 19 Sep 2025 17:18:17 +0000 (UTC)
Date: Fri, 19 Sep 2025 19:18:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>
Subject: Re: [PATCH] can: peak_usb: fix shift-out-of-bounds issue for 32-bit
 architectures
Message-ID: <20250919-witty-bustard-of-certainty-29de42-mkl@pengutronix.de>
References: <20250918132413.30071-1-stephane.grosjean@free.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oiqgzddrmiycj6a5"
Content-Disposition: inline
In-Reply-To: <20250918132413.30071-1-stephane.grosjean@free.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--oiqgzddrmiycj6a5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: peak_usb: fix shift-out-of-bounds issue for 32-bit
 architectures
MIME-Version: 1.0

On 18.09.2025 15:23:57, St=C3=A9phane Grosjean wrote:
> From: St=C3=A9phane Grosjean <stephane.grosjean@hms-networks.com>
>=20
> Explicitly uses a 64-bit constant when the number of bits used for its
> shifting is 32 (which is the case for PC CAN FD interfaces supported by
> this driver).
>=20
> Signed-off-by: St=C3=A9phane Grosjean <stephane.grosjean@hms-networks.com>

This problem is not limited to 32-bit architectures, so I've removed
this from the subject.

I don't know why, but the patch didn't apply to net/main, applied
manually, but removed the line break.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--oiqgzddrmiycj6a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjNkFEACgkQDHRl3/mQ
kZy3Dgf/ZxSmQw4gSslGL2HxWX6MyUzn53poHbbFUykkMuHFpBPcB7X8Js6iWHf+
lk8QyRSc6mz06DqM7/3rj02ekB2inpiSKbNXxQXpwDuQIBogPB0QYVuNRt/iYAFt
YCQ2Flwr2SdltXoAXfCApAq699ln+kyn4mkUS49Q/J+Zp5qjbv9BRPRXSnr8cobc
1lkueb7bjAy3oxJ6Zz/3Ua2cy8Stnnau+mCLSUqY+9mxr3FdlyqlJ7KhGP/1bC5h
0YM5KOxWqEKY1yAqIAMtV3WCPyX5tHq24oNgJOshyMZ4eudB5tXC6G+tEdo4GO8P
Po4DtAYx67oFqrBFeyO2Ya6iObkIZg==
=s3BS
-----END PGP SIGNATURE-----

--oiqgzddrmiycj6a5--

