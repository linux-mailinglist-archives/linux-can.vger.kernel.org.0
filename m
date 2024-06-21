Return-Path: <linux-can+bounces-831-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F31C911EF2
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEF328798D
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E3916D4D9;
	Fri, 21 Jun 2024 08:38:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527D16D30C
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959122; cv=none; b=pq4CRnQL98q3pG+3x4OWnBXGkoPukzo9349p9WiAjhFlJKrYVpr2PZHSOilg0qLt3m2XSGOK2uo78DQCBsCeqOChQBreIG+sL8Q5on8etX+Z1SQOp8Esfe8Wv8fjHkjfUJ4QeclSjMAzRuQki3PrFkm6YJhNfqG470Pe+EFDX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959122; c=relaxed/simple;
	bh=o1IYIzTSxrVHDmd5kBhokWiItlnyDbsfGIJm1UM1NyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsVwbb7OEjC4LL5BK7z2TMDNVQGPPkxRJLj2aYmANnZNVRjkQp/nZOfNWhIZtogJbgYaRdYgtCBwFLVESA5EZuymFDWTRohQob6YqCMgk8zFk/08qw+1ZhQZh5HTcb/PYx3FxHdwpI1AloDu81I/X6CAdCyeMpPysMRYtVE6au0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZn4-0000o8-Kr; Fri, 21 Jun 2024 10:38:38 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZn4-003tw0-3k; Fri, 21 Jun 2024 10:38:38 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C954D2EE594;
	Fri, 21 Jun 2024 08:38:37 +0000 (UTC)
Date: Fri, 21 Jun 2024 10:38:37 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] can: rcar_canfd: Small improvements and cleanups
Message-ID: <20240621-positive-juicy-pelican-46e1d4-mkl@pengutronix.de>
References: <cover.1716973640.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sptk75ai3pqbtfay"
Content-Disposition: inline
In-Reply-To: <cover.1716973640.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--sptk75ai3pqbtfay
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.05.2024 11:12:12, Geert Uytterhoeven wrote:
> This series containssome improvements and cleanups for the R-Car CAN-FD
                    ^^^
I've added the missing space while merging this series.

> driver.  It has been tested on R-Car V4H (White Hawk and White Hawk
> Single).

Applied to linux-can-next. I'll include this in the next PR.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--sptk75ai3pqbtfay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ1PAkACgkQKDiiPnot
vG/pSggAgihV8zYNgQyEH/E6AYKACbrH2K3JAADqOfElbKlYqrWMfyC7liAXzH73
B4l9UXLkEEImKUXNy5hNlWskAv69dWpgXWDcZZK/wQvZy4SYUhrnNtshFIihnOkt
/vlOX8dPHgcy7qESmO+elHPECAMheA9MpA11arj2CzKfUFggDdZpEbYpjPAsJueV
jP0KCkyJQ0k34kR5YUdFL6kVxoYZT3x9dWdBnLAmsK6CUgGLYe4iep0yFah16mcn
d6AnyVQ8I4wGscuJkPMf5HwvrYCE7Idw23JrfTlokI9cF2uCSaMUBSRCNUgM6NfR
3nKdSa5EHdG8QPzs549i8ITfjkugjg==
=XJvY
-----END PGP SIGNATURE-----

--sptk75ai3pqbtfay--

