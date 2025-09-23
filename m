Return-Path: <linux-can+bounces-4892-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C004EB94E23
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6B61703D0
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249072580ED;
	Tue, 23 Sep 2025 07:56:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27BE314B64
	for <linux-can@vger.kernel.org>; Tue, 23 Sep 2025 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614189; cv=none; b=axcKzPVk5K3Kc7uhBlLb/4xUV+lnVWuRSnfhdY6MT0CaNoUx95DvYSK3xBULTT1GxQx9EjHbCwtgC8Kdj9gegNK/1S2H/N4hWxdYjYOl9Lk6IS4yQHKt5V3YYi6SfE0mmvYoH3PO3YoA4lzV7TiarrLzQljX10SV+pqOgNvIJwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614189; c=relaxed/simple;
	bh=czjeFbWL6mEfzT3no8tAGT2BnMUdT1Kh4lkm5v1oaEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzscaH9/h2zqIorGS4vgb0MX6tqoH3rvbEbe6MVX7TxwImwkGkqtOtJJIcVO7w/bU/FuB1GHaTWGPKst6oecLY2cTtbNDaecfSoJrN8imt2z9i8Hw9G45gm29hmNxUEyzY3I8Ck40I3S/YMiovAsT3a6QPwmQr17Qr0GoKzu8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0xsu-0005Ou-As; Tue, 23 Sep 2025 09:56:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0xsu-0003P3-0F;
	Tue, 23 Sep 2025 09:56:24 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B6103477B13;
	Tue, 23 Sep 2025 07:56:23 +0000 (UTC)
Date: Tue, 23 Sep 2025 09:56:23 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net 0/10] pull-request: can 2025-09-22
Message-ID: <20250923-free-hallowed-swallow-dc3871-mkl@pengutronix.de>
References: <20250922100913.392916-1-mkl@pengutronix.de>
 <20250922171926.63ec8518@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3opm7w2mydbbb4sb"
Content-Disposition: inline
In-Reply-To: <20250922171926.63ec8518@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--3opm7w2mydbbb4sb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/10] pull-request: can 2025-09-22
MIME-Version: 1.0

On 22.09.2025 17:19:26, Jakub Kicinski wrote:
> On Mon, 22 Sep 2025 12:07:30 +0200 Marc Kleine-Budde wrote:
> > Stefan M=C3=A4tje (3):
> >       can: esd_usb: Fix not detecting version reply in probe routine
> >       can: esd_usb: Fix handling of TX context objects
> >       can: esd_usb: Add watermark handling for TX jobs
>=20
> I have mixed feelings about these. Could you resend the PR for just=20
> the first 7 ASAP? Feel free to also send another with the (fixed) esd=20
> patches but whether those reach 6.17 final or not will depend on
> whether we can review them in time..

Makes sense, here's the updated one:

| https://lore.kernel.org/all/20250923073427.493034-1-mkl@pengutronix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3opm7w2mydbbb4sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjSUqQACgkQDHRl3/mQ
kZx30Qf/VPgryM0OjYkp7uNLPcnJvJvm4ewgs8XECTsHupvm3TvhlC7o0q8ZnC4R
ncvq/r+lZ9175Hp06YQ6YidujhVK8r2sP9haxO0gofne7HhATCNjwcWCMOptBP2I
PEKIaoZvakIzFLKU3U0JlqBm49+iwHx+9oLRuERjNuX0wWDY+AVCKtMav2FLZ7TY
v2WxoItqoVbcU6knrkZwIaOiLV2JpbB4yhW2ne7Ku4PfbofCSYgCDFkZ75Pd8dde
ZJjnFvlgJ9wNl/7OSF52rwEjHTCbKyPm41nt97mL/DvaethfJFD15ViE/S0B/Am7
2TtddJL9d07veejkRrEcvJYpKZMMIg==
=jArF
-----END PGP SIGNATURE-----

--3opm7w2mydbbb4sb--

