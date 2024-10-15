Return-Path: <linux-can+bounces-1682-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E8299DE19
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 08:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FC5B2193E
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 06:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B08189B82;
	Tue, 15 Oct 2024 06:22:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6203188721
	for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973327; cv=none; b=LsWjg7vb9PbhI4JUPJGQGW5OAoCUIlWVi8CkPLwLEr9go8ig09ZybLnZWMlnwaYfy/6/wFld2l5QmZVY3VPLm6HCUD9DJGUo+cjORIxIUK/VxzusJUeYMFV2aON+83qfgT/S3Ykxom3OtBprfwX/CmIBs5vpPoYFOzzUMH/uvhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973327; c=relaxed/simple;
	bh=F0nO1ju9yrHwcLaUuiotyknrNbm/NPjEBqUywm3szCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPTHHv+1ZT5d61eqZ6B+72KUNd9b2+YlMVp+h1TZAzSs6FqR1m0yT52coIa+pWOM/Bl7oNIcDxc5hOHGkWGfbT/OuSSXU7nWkWOo2qXV67XTUR/yUzjcuOPJi7beFmHfaGynzA0MfTjvqKtL+F6tWLTO4JbDEVOQy8ocnoX/y5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t0aw2-0008D4-5Z; Tue, 15 Oct 2024 08:21:34 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t0avx-001xwW-6v; Tue, 15 Oct 2024 08:21:29 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B1B32352EC0;
	Tue, 15 Oct 2024 06:21:28 +0000 (UTC)
Date: Tue, 15 Oct 2024 08:21:28 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-wpan@vger.kernel.org, kernel-team@cloudflare.com, kuniyu@amazon.com, 
	alibuda@linux.alibaba.com, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH net-next v3 4/9] net: af_can: do not leave a dangling sk
 pointer in can_create()
Message-ID: <20241015-fast-smilodon-of-maturity-c983eb-mkl@pengutronix.de>
References: <20241014153808.51894-1-ignat@cloudflare.com>
 <20241014153808.51894-5-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ozf36irfkpdfb4wj"
Content-Disposition: inline
In-Reply-To: <20241014153808.51894-5-ignat@cloudflare.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ozf36irfkpdfb4wj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.10.2024 16:38:03, Ignat Korchagin wrote:
> On error can_create() frees the allocated sk object, but sock_init_data()
> has already attached it to the provided sock object. This will leave a
> dangling sk pointer in the sock object and may cause use-after-free later.
>=20
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ozf36irfkpdfb4wj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcOCeYACgkQKDiiPnot
vG/xXAf+LTXGlSudJMf/9rFosFeT91u30bZgRzlfS9tfAK9w2089Upi/Exhd/ogn
fV/Auin/lIVDdcenPoVsSApA5kWdKLvfP+pu/RPXN38IrDQV8rwel0JjEDCzSYOL
6KkFDtfEOHrDoikDtf1v+4wHX4Gy0hVXD8ODTIkXFwGolFBXK7+RTQx3O1H+Rw3p
6oMv4Ve2xrP/5i8Lh/5emQVq7M5XqkapXUwmyOImTRwCqrnCtjZYEiy8GqYDcbes
zGW5n5UvJOpiY6IM+tNdjOT5aEioR5XeuR/s0ORBiAppNrKjuIDgkkIC6gARZbzZ
hqMhoIOx2Mu2d0iEy8By7FqJ48ZoVg==
=wmsj
-----END PGP SIGNATURE-----

--ozf36irfkpdfb4wj--

