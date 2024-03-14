Return-Path: <linux-can+bounces-389-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE29087BBC8
	for <lists+linux-can@lfdr.de>; Thu, 14 Mar 2024 12:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B7C2846BD
	for <lists+linux-can@lfdr.de>; Thu, 14 Mar 2024 11:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046E31A38DD;
	Thu, 14 Mar 2024 11:16:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1A919473
	for <linux-can@vger.kernel.org>; Thu, 14 Mar 2024 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414999; cv=none; b=sA6XHN3YHaHVbqDztMl8sJFIZX/wFuMzMoNTCGOgF2sl+zGAPgf/w+QDI7O6PsoUDjhBpuLk6vzIhsVcMAWW9sbS1OhvwXCMfSlguX6a5Y6c40Gdz42uxRQRz51Yeix9bg9tABm7bCPQaceGaKzvOUahvRSRea6kZJku4hEbyuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414999; c=relaxed/simple;
	bh=trpigSTKkUAW4RnEE12GbDjH2EBnHMm9y95LDmqMmG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo5mrfRL/NkHzYmg6pzYzF8wsh5nUdQIbV8yRP61Ii8kXLz8NOxjviT50hPVUxcUwRAGfG/mpK9Kga+N5zYi/MD5uRPM4hFs55YOGMsSEXnHdoI8kwwDc7HKhyVQfSlVIpJgWgWLZGa7k2GxLJF3cl9bfPFMB3AdWkA7Tjc4erE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rkj4b-0001eT-S1; Thu, 14 Mar 2024 12:16:33 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rkj4b-006IhS-6p; Thu, 14 Mar 2024 12:16:33 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DA5A92A50B8;
	Thu, 14 Mar 2024 11:16:32 +0000 (UTC)
Date: Thu, 14 Mar 2024 12:16:32 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin =?utf-8?B?Sm9jacSH?= <martin.jocic@kvaser.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>, Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH] can: kvaser_pciefd: Add additional Xilinx interrupts
Message-ID: <20240314-delusion-flatfoot-a3b85b091108-mkl@pengutronix.de>
References: <2ab3c0585c3baba272ede0487182a423a420134b.camel@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ms6xum7jthtldink"
Content-Disposition: inline
In-Reply-To: <2ab3c0585c3baba272ede0487182a423a420134b.camel@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ms6xum7jthtldink
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.03.2024 10:25:14, Martin Joci=C4=87 wrote:
> Since Xilinx-based adapters now support up to eight CAN channels, the TX
> interrupt mask array must have eight elements.
>=20
> Link: https://lore.kernel.org/linux-can/2b2c720a788e1904283e354abb320adb5=
b631d26.camel@kvaser.com/
>=20
> Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>

I've converted the link into:

| Fixes: 9b221ba452aa ("can: kvaser_pciefd: Add support for Kvaser PCIe 8xC=
AN")

Applied. I'll send a PR after v6.9-rc1 is out.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ms6xum7jthtldink
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXy3I0ACgkQKDiiPnot
vG+d8ggAgCePwiZKjEIoTt35OZJwVWGi0BoUqL+Ip5ofoyhFziqYsGVOl9d79XrR
F0sk/SBkJXghZhJCL/c+OcxosUnvD9s2+GC2RXYd8Do6Rw17boAGqDMUfArMOC3P
b9MLTiXbCUzqIUSKZx1gmto+NXgjaSRPMwVwauHNufe6pOrJcSnmcKqi4z7StjNj
qgvQ6jznh1yrBZ4ozmmPnPI9T9t7mqCEpAhQMylL8jCXw5TziCDubVoTbGkX01xZ
6DksUr6saPc9d8XNdr7eUVyXHD1LYchgUHXps8eTwOvkDmpb3c4uw8+Q8kyTa+7F
BfI8LHEsb5WkWRryvgHC5kcGSvASaQ==
=gO6I
-----END PGP SIGNATURE-----

--ms6xum7jthtldink--

