Return-Path: <linux-can+bounces-1570-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1870987F64
	for <lists+linux-can@lfdr.de>; Fri, 27 Sep 2024 09:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8C3286248
	for <lists+linux-can@lfdr.de>; Fri, 27 Sep 2024 07:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA76F16D9B8;
	Fri, 27 Sep 2024 07:26:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA5170A27
	for <linux-can@vger.kernel.org>; Fri, 27 Sep 2024 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421972; cv=none; b=HIn3QeytnfNTN6EFtyf4rk7qubRTXgKG4/Bh9vcvYPiMf9oZxuOwvnrzT2899OHUixLSeXkykZQxL3PMLsOQ38uM9D9sKHiPAMGCcvgIouki9QA5psD35GD03P5mnnivTOSH4HaVq8YExiOIwXZSJ754LiaJ0jZgdxBl4b22cPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421972; c=relaxed/simple;
	bh=6dImF9S+mRahQHaTlgCCA/DMRrVd2hD0HiGSAzomfkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qi71MNPFEVgf3sOQovQjlN4lJpeM6FiVzA+WwsuOyzm66HoEyghgg4jBHt1vyb8OsudUJVjuJsI3oCD2HQdKtwyZuzDMHILMq4HGqkWiW/9aCPyLvL3EZTo/llaIUYgMzITVQTx4U1mdNtGlNoqiodhdAKQ1mSaP5xFH4hC//zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1su5Ma-0002SG-6G; Fri, 27 Sep 2024 09:26:04 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1su5MZ-001s3d-GL; Fri, 27 Sep 2024 09:26:03 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 24270343A18;
	Fri, 27 Sep 2024 07:26:03 +0000 (UTC)
Date: Fri, 27 Sep 2024 09:26:02 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: AW: AW: IRQ handler mcp251xfd_handle_tefif() returned -22
Message-ID: <20240927-utopian-super-dolphin-88a1d9-mkl@pengutronix.de>
References: <FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240925-simple-nondescript-porcupine-d66a23-mkl@pengutronix.de>
 <FR3P281MB15522178FE612C6B5B728C2BD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240926-pragmatic-colorful-lyrebird-dc8068-mkl@pengutronix.de>
 <FR3P281MB1552B40D19AF9DE8CA8150AAD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3a7dzkrhynbttckd"
Content-Disposition: inline
In-Reply-To: <FR3P281MB1552B40D19AF9DE8CA8150AAD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--3a7dzkrhynbttckd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.09.2024 18:52:19, Sven Schuchmann wrote:
> > You need these 2 patches:
> > 51b2a7216122 ("can: mcp251xfd: properly indent labels")
> > a7801540f325 ("can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() =
into mcp251xfd_chip_start/stop()")
> Finally I had to modify this one a little so it applied...

Can you test v6.11? I'm not 1000% happy with stable at the moment when
it comes to the mcp251xfd driver.

Nevertheless, I will look at your findings later.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3a7dzkrhynbttckd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmb2XgYACgkQKDiiPnot
vG8s3Qf8DbTEf0ULV1EXnvuo1hvL6k0KePzBl4dBvU3U7wHg639B7JU/bfnQlWuZ
JLeRw+2xLhViPqyz2flpd+RLebjJul0Q3yz/mIpuHUhCurxVGGjjs9reJ+zrC8uO
TkybCeNY7yjzgFHVKfiGBZQtE4/y3cfWfuNk9KtlYTXpTe2Hm1ftWK6K5mHjU1TI
hIooOByVXmCA48UUqqAgkAB+AEO+ibsejeTV/XyjonGogp16iT3Lh7kEJVhtMVRu
I/zJzcA8r3Sm2ZcEoCVs93yqa5GkKYxZy/m9RV7Du/lV2BlU229s6D06icKxo58z
BIfJYbysJJKAgYOBB5d1uZSlWVWdPg==
=oi1H
-----END PGP SIGNATURE-----

--3a7dzkrhynbttckd--

