Return-Path: <linux-can+bounces-309-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0EC85B3F1
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 08:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C9A2B22E6D
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 07:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AE45A4E2;
	Tue, 20 Feb 2024 07:26:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4965B1F6
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413968; cv=none; b=gtrfmiAyoDqtHfg5iFctMXCWe5ciqaQIjJrnlUkq+tv5CsOOVaPoVMxq3R6/H3NLILFKr5FSp+/SQSrY/0fLNux5oGN8vNi5T1ltFWYX8DUA3WOYnz/RPqt1tE2B5M9OIN9DqGCm/hH0M3lR/jRlDClxq47CDgcmPONXdJzyGYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413968; c=relaxed/simple;
	bh=o3N3eDsMuaK5IcqH5+y+rMqYvONftK7BFSBqKE+tDm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxSpiXgNHSwj0aDJRwVczkitzv3K+JnLmMFQF7B945nElIzymjhDj4gkBis1WZq7XL+IInoE1r3Rtu3E+yqoW2WL1yedvdu5NShegteDWdHvl3WCH37wCKxTr9NVqdR+fXnCF/NqwOn/6NE4POgqvmU4mPDe89uEZTpvCPESUT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcKVu-00062r-GZ; Tue, 20 Feb 2024 08:26:02 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcKVu-001nby-18; Tue, 20 Feb 2024 08:26:02 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AF930292DAD;
	Tue, 20 Feb 2024 07:26:01 +0000 (UTC)
Date: Tue, 20 Feb 2024 08:26:00 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] can: raw: fix getsockopt() for new CAN_RAW_XL_VCID_OPTS
Message-ID: <20240220-mobility-thigh-8ddfb02bfab9-mkl@pengutronix.de>
References: <20240219200021.12113-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m5qz2zkyou5fcxqg"
Content-Disposition: inline
In-Reply-To: <20240219200021.12113-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--m5qz2zkyou5fcxqg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.02.2024 21:00:21, Oliver Hartkopp wrote:
> The code for the CAN_RAW_XL_VCID_OPTS getsockopt() was incompletely adopt=
ed
> from the CAN_RAW_FILTER getsockopt().
>=20
> Add the missing put_user() and return statements.
>=20
> Flagged by Smatch.
> Fixes: c83c22ec1493 ("can: canxl: add virtual CAN network identifier supp=
ort")
> Reported-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to linux-can-next

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--m5qz2zkyou5fcxqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXUVAYACgkQKDiiPnot
vG/UVwf7BcUlf66S2Suv0hhwMBj8KbR/nEKfq/DGLANlFvETes4oLv69PVe5tYz6
SRnRkZhHW2wSblLTEHBcwM1TJ6yqlI9v+uHBgXqAVMTKILGWMfnJAW7JuRWnWkRP
MKSDjbyOTpJn1XspP7VvVfIPtUCyqeJRCHxwAe+qfzH6Ry//xzjrpas2RZ1RZDvM
waKo7dFweUOPLlfWr8TJA57nnpFpZ5eHw+ka8Xla5SZAycankIutrhPA2G/fR2/X
/FXFMuSCgRZsNPgSaqiA+P38rA0Op4dxu2Zun6jO/O2SzxsH2hTUiaYeGiG1G6Bx
DVsN3Yjg8vcJMIoPSHL76R+iwCsooQ==
=cavz
-----END PGP SIGNATURE-----

--m5qz2zkyou5fcxqg--

