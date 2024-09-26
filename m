Return-Path: <linux-can+bounces-1568-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D1987728
	for <lists+linux-can@lfdr.de>; Thu, 26 Sep 2024 18:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130C11C24891
	for <lists+linux-can@lfdr.de>; Thu, 26 Sep 2024 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E681BC4E;
	Thu, 26 Sep 2024 16:02:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D214D45E
	for <linux-can@vger.kernel.org>; Thu, 26 Sep 2024 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366559; cv=none; b=XnPvepKfhjEbIo5Uz8k1D+0fs9DqzOYPfHwUXBsmtdCsA8JtWjaixwFM6htV+ioQqVKbWFmW42YiGusTGVpKaMfOZbwkwB0V14bMUdgeQiBKEBpLvXbtVri6slIIjPA9SYdJzarpp1EoA02xVdmZH93Ihpk5sJgX1rkPzV9x0aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366559; c=relaxed/simple;
	bh=W8OV05zAXlezDTGLnoH58/BLfiBWSuhzsD53lgbZDoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCLSJcilPQSltkKcIA4SjOJAVfSFlobihElC9nzYi63WyS7wHN5hwvrm9wzxPFt25AqTI36cy664VJKBys8Wevf1TfPPmk3EvUvFQHX1aTZDw6vUOPuInd2rJTeI9DcXP8VqAKjbMGE0CTTehatFDo2ZG4p4m2pHQXJ0QmKKpFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1stqwq-00029g-97; Thu, 26 Sep 2024 18:02:32 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1stqwp-001iog-IG; Thu, 26 Sep 2024 18:02:31 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 384F4343475;
	Thu, 26 Sep 2024 16:02:31 +0000 (UTC)
Date: Thu, 26 Sep 2024 18:02:30 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: AW: IRQ handler mcp251xfd_handle_tefif() returned -22
Message-ID: <20240926-pragmatic-colorful-lyrebird-dc8068-mkl@pengutronix.de>
References: <FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240925-simple-nondescript-porcupine-d66a23-mkl@pengutronix.de>
 <FR3P281MB15522178FE612C6B5B728C2BD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x4ik7utg7qj2dmio"
Content-Disposition: inline
In-Reply-To: <FR3P281MB15522178FE612C6B5B728C2BD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--x4ik7utg7qj2dmio
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.09.2024 15:42:17, Sven Schuchmann wrote:
> Now I tried to add the debug stuff you suggested and for that I used toda=
ys kernel which is 6.6.51
> https://github.com/raspberrypi/linux/tree/0fb3c83a9fa3011cb735ec011b7582d=
4749957b2

You need these 2 patches:

51b2a7216122 ("can: mcp251xfd: properly indent labels")
a7801540f325 ("can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into=
 mcp251xfd_chip_start/stop()")

I've already send a mail to stable to include these in the next stable
release.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x4ik7utg7qj2dmio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmb1hZMACgkQKDiiPnot
vG++lwgAhKWJaqciQAqLebkvGK+1ljOAQnVUEAqOGnJWm1XKz0ANDIzmUBcCWwHu
kE6W+pEThq9bvmYsJk4O3n8oI53wjVZM1vYycUTv4bGWD1l+qn3Dl4BMhDWD7jbs
HHxLNnPdJrl05NBs9SU+iTmFVvlznygLPMbTC0aCSUP8ClTKFopg1lJiS3zzrJxV
d50hlCFgI9F/y7vaNNiNbaMMQrsd+/GWQ6y0PvimLfSwhKbgVUfnjFJ7eKdim96+
9B2swpUDI+G87rty+tXVjnjkCX+oZIEKwFgGe3qLjZGd9wkYX7fBwzUKJILqLCjI
b9zek7vQZGBIAmo5QJHYS2XXaF8O+Q==
=p0ei
-----END PGP SIGNATURE-----

--x4ik7utg7qj2dmio--

