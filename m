Return-Path: <linux-can+bounces-509-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C508B6A3B
	for <lists+linux-can@lfdr.de>; Tue, 30 Apr 2024 08:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1CB1F23771
	for <lists+linux-can@lfdr.de>; Tue, 30 Apr 2024 06:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8DA17995;
	Tue, 30 Apr 2024 06:13:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22626FB1
	for <linux-can@vger.kernel.org>; Tue, 30 Apr 2024 06:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457628; cv=none; b=cTJHY8Q3vfhoCQn7rfFtYHCA+AJb6ZdSqvQZAP7QqBQExlh3rJy4S4R2BHMtiDY6Xgs3Pekl574AJWBlIqw4qa+eIf+yF872GoZhF2uFdn6kGw9J4kjfpCddnvsbiV+npYfxQ5TMxrW1EXMsNRTx+QLMO7L7WX4QDT6+x+Z2C8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457628; c=relaxed/simple;
	bh=/oJK25SlW4bJKAFPz3EBH0+rUatqMo/4OxLzoyvhzL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBvywPGtibtcqutaEiXaVF+oYWmMKv4MHdnNMy2GLoJ3/vcBTwWSJUIMoYv6B9M2wQC9IoncV2S1uaccLATffnsxZwB1XFYOE6PMt3/fxz3L58HGJ+xrWnFonB19cJtXZcsczEgBEjY6OiEnVbE0vKOZOVtZOxCI85NOau5wLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s1gkH-0003H0-Bw; Tue, 30 Apr 2024 08:13:41 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s1gkG-00F7BQ-RP; Tue, 30 Apr 2024 08:13:40 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 868B52C294A;
	Tue, 30 Apr 2024 06:13:40 +0000 (UTC)
Date: Tue, 30 Apr 2024 08:13:39 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Francesco Valla <valla.francesco@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Documentation: networking: document ISO 15765-2
Message-ID: <20240430-speedy-ara-of-refinement-73ac60-mkl@pengutronix.de>
References: <20240426151825.80120-1-valla.francesco@gmail.com>
 <20240429-mighty-starfish-of-speed-c76ddf-mkl@pengutronix.de>
 <Zi_ycjkN9b95Rsx9@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iaxb5lp3k75xfltv"
Content-Disposition: inline
In-Reply-To: <Zi_ycjkN9b95Rsx9@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--iaxb5lp3k75xfltv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.04.2024 21:18:42, Francesco Valla wrote:
> Is there still time for a v4? I have a couple of typos to be fixed plus
> an additional Reviewed-by. See:

Feel free to send the v4.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--iaxb5lp3k75xfltv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYwjBAACgkQKDiiPnot
vG8xjggAjh5P8b3HmX5GqT327ziNORo8PBLZBp9DJlJlZgBOm9OtJ9HttoWqugUq
aAFln2DXIdMIRjChD2GGVdh7+LK/F44Vk8UQP6eic0UKhkaM0HV2YS1nA0dWjnKA
HwlzAe9Xr/GJfik8XZM1KuH3TPwA02oBOYUsgjxW3fR4LwJKFeZzzf9dIGs0F8M2
NydcczmUq6PKw1y/WpwmmhW4iMxBrC76AlhqiV+6qVcXmF4vivmQQne0Zdm9HgP0
EHzOeUwIugukB4igDV0zVyqTAWaRgjkWGVVfsJZP5ePgEIkyArQ9mQS561P63TH1
dEfpRLtZoMcVLsCXuK2ganQyGUx5uw==
=9dO0
-----END PGP SIGNATURE-----

--iaxb5lp3k75xfltv--

