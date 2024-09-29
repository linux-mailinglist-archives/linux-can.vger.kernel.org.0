Return-Path: <linux-can+bounces-1573-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 966B7989617
	for <lists+linux-can@lfdr.de>; Sun, 29 Sep 2024 17:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277B21F22918
	for <lists+linux-can@lfdr.de>; Sun, 29 Sep 2024 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75591E507;
	Sun, 29 Sep 2024 15:22:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C218C31
	for <linux-can@vger.kernel.org>; Sun, 29 Sep 2024 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727623339; cv=none; b=BayCiXqM4PjrDaznId0h/uSjoFuHcSXFfOr2z1MC2joGA8Qy3Lc5vpCUz0iPeBUlsZJfuJ4GrDrU7LmtH3K3gifUOL+U7b7Fnxx9d+GdGFwqkVuhHLDUuKCiJ11BdChvNVtO9p3rB9Pii9CBGcYVNFO5quuARSQZq1cwxecyIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727623339; c=relaxed/simple;
	bh=s6EZON28BnmDoGyLMq2QvY3zp1nVraXLVvMnUVBp9Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fG2ddEZLKK4H34R7gYCb9DVIN10vXzZAr83HF4JWIHQy4QriZS1DRF7F5l6r/gFw8cKHK8n22un+2clgUM5qmQSQmArBORDJwvia5XaxPpz8mOlSLNivjXQ1iQW3E0lAyNw8HbOXStz4W5HntauipZqAsEyXax5OZy5V0iumdCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1suvkN-0004YN-DH; Sun, 29 Sep 2024 17:22:07 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1suvkM-002Ply-B1; Sun, 29 Sep 2024 17:22:06 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0C0453454DE;
	Sun, 29 Sep 2024 15:22:06 +0000 (UTC)
Date: Sun, 29 Sep 2024 17:22:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: AW: AW: AW: IRQ handler mcp251xfd_handle_tefif() returned -22
Message-ID: <20240929-upbeat-carrot-whippet-bc3e9c-mkl@pengutronix.de>
References: <FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240925-simple-nondescript-porcupine-d66a23-mkl@pengutronix.de>
 <FR3P281MB15522178FE612C6B5B728C2BD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240926-pragmatic-colorful-lyrebird-dc8068-mkl@pengutronix.de>
 <FR3P281MB1552B40D19AF9DE8CA8150AAD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240927-utopian-super-dolphin-88a1d9-mkl@pengutronix.de>
 <FR3P281MB1552D0C69616DA620C2629ACD96B2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yaxxyhkyvbcahsey"
Content-Disposition: inline
In-Reply-To: <FR3P281MB1552D0C69616DA620C2629ACD96B2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--yaxxyhkyvbcahsey
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.09.2024 13:23:54, Sven Schuchmann wrote:
> > Can you test v6.11?=20
>=20
> Not that easy, but what I at least did was to copy the mcp251xfd drivers
> from the 6.11 kernel to my 6.6 kernel and gave it a try, same result:

That should be fine.

> [   45.126666] mcp251xfd spi1.0 canfd1: IRQ handler mcp251xfd_handle_tefi=
f() returned -22.
> [   45.126694] mcp251xfd spi1.0 canfd1: IRQ handler returned -22 (intf=3D=
0xbf1a0010).
>=20
> > I'm not 1000% happy with stable at the moment when it comes to the
> > mcp251xfd driver.

I just wanted to be sure, that there are no patches missing.

> I'll be away next week, but after that I can at least=20
> continue testing and maybe write some code ;-)

Can you please copy

| https://github.com/linux-can/can-utils/tree/master/mcp251xfd/99-devcoredu=
mp.rules

to "/etc/udev/rules.d" and

| https://github.com/linux-can/can-utils/blob/master/mcp251xfd/devcoredump

to "/usr/sbin"

If the IRQ handler fails with an error, the driver will generate a dump
of the driver and chip state and write it to
"/var/log/devcoredump-*.dump". Please send me this file.

Please use the unmodified v6.11 version of the driver on your v6.6
kernel.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--yaxxyhkyvbcahsey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmb5cJoACgkQKDiiPnot
vG/W3wf/VHa4r0j3Yla20G1E8usZ5Y9Y9tzwgA1FPPLA1P6OhYaXyH4G8S8pHIxH
8fsXjd9Piub+/9Ag5kZi6a7z9BFlXaj9gnWTt6eWGZCHii7EuNtKksUotVBSZsnQ
NruWnO1FHavtemQkzMevGsBkf1bv8cIUQbX+eYBsONLFVsS9MJXjKGPN8JPE2+B+
lddAqF4d3jDPRr2nJGG3Kliy6xwtP7gl6CD/AaE78lFt1WsRZ2eJrw6CoV9FgQ8d
WRkYaKGvGjaPfl+elYUwscDmzjmB3nB4QIqabR1+JdzBL7+tfP+Shg+4Ez2cuLXA
KSBvW/xJvr3yl3sDf7qb0jmLnKUeoQ==
=Bwa7
-----END PGP SIGNATURE-----

--yaxxyhkyvbcahsey--

