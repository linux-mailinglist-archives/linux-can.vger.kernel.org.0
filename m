Return-Path: <linux-can+bounces-6192-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEADD38632
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 20:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D1F63016FA0
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 19:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0347833CE80;
	Fri, 16 Jan 2026 19:46:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1B2797B5
	for <linux-can@vger.kernel.org>; Fri, 16 Jan 2026 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592805; cv=none; b=DJ55yYwagsH9XjWaZQ6m1dSno/4GciPCzW4o0vnJAk1ea4ywgWaXIU9/p5WIKZPr4pURlU7mRPBvRZJyBhldNQhW2n3Rsy876GkpBryfHiptByZDYYsA3fbKtMY7HscX8enAeqetgiVguPhlwzxRzjtC1YacSnUyeydaXDYXuFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592805; c=relaxed/simple;
	bh=ibV0QH/kzqyg+Mws7a4bx4PwSnQ9L4EXLnNHqSsTwzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVrKe51LnM5he+as32urnqynZiLPqytCmXCtplPbNm2NBxa3FhGwNRiXtLza0qOkDK0To1HPM1xgI1YgH+WVmqa6IB4XWyVFmJ1LpKF9npSME7Yeq7USuOQirxszbKONvbiyFJ/3CmuefKLDwzMkJjAs8gpT5T3XdRheJzUGJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgpmG-0002S3-UK; Fri, 16 Jan 2026 20:46:36 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgpmG-000yLJ-2u;
	Fri, 16 Jan 2026 20:46:36 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DAC304CEF58;
	Fri, 16 Jan 2026 19:46:35 +0000 (UTC)
Date: Fri, 16 Jan 2026 20:46:35 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Wolfgang Grandegger <wg@grandegger.com>, Sebastian Haas <haas@ems-wuensche.com>, 
	"David S. Miller" <davem@davemloft.net>, Frank Jungclaus <frank.jungclaus@esd.eu>, socketcan@esd.eu, 
	Yasushi SHOJI <yashi@spacecubics.com>, Daniel Berglund <db@kvaser.com>, 
	Olivier Sobrie <olivier@sobrie.be>, 
	Remigiusz =?utf-8?B?S2/FgsWCxIV0YWo=?= <remigiusz.kollataj@mobica.com>, Bernd Krumboeck <b.krumboeck@gmail.com>, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH can 0/5] can: usb: fix URB memory leaks
Message-ID: <20260116-unselfish-beneficial-coot-eab1c3-mkl@pengutronix.de>
References: <20260110-can_usb-fix-memory-leak-v1-0-4a7c082a7081@pengutronix.de>
 <5b5c8a8b-5832-4566-af45-dee6818fa44c@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p445ireluuhjz7yx"
Content-Disposition: inline
In-Reply-To: <5b5c8a8b-5832-4566-af45-dee6818fa44c@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--p445ireluuhjz7yx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can 0/5] can: usb: fix URB memory leaks
MIME-Version: 1.0

On 14.01.2026 11:04:11, Oliver Hartkopp wrote:
> does this patch set need to be reworked due to this (AI) feedback from
> Jakub?
>
> https://lore.kernel.org/linux-can/20260110223836.3890248-1-kuba@kernel.or=
g/

yes - done:

| https://lore.kernel.org/all/20260116-can_usb-fix-memory-leak-v2-0-4b8cb29=
15571@pengutronix.de/

> The former/referenced PR has been pulled - so that specific patch might to
> be fixed again, so that usb_unanchor_urb(urb) is called after
> usb_submit_urb() ??

yes - done:

| https://lore.kernel.org/all/20260116-can_usb-fix-reanchor-v1-1-9d74e72892=
25@pengutronix.de/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--p445ireluuhjz7yx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlqlZkACgkQDHRl3/mQ
kZxiIwf3RgwYCKdOvCyjb3R85GUOkhQUKqFTiNFMjrtVwd8VZPCLGC+3PjeCGrkY
iin1/W0Na/m+TfhYYIaSmVNL5J5XZnG7/AE6dTcUfURMElT3/RtzxuAOF1cOm5ql
3y18aHMOSlD/rSxS25EKo80WRqsAJ5cvRTYOd4L7hJbIncLylOmgmNAFPu5xDrPG
njT5AsodRXLR1pC8bm7Xi4C8EM+yvOJBmtFlBRXvnhPLbbozKx0YJi7GIjMCqUud
9lgh8lpYMiBeSa6SiowyW4t7Ekiv+Fsm35kj5VFswGsE2C9g0WLOhpAdkrOYvKw9
qksO8u07ELg7ix1MutQYIzpABLQu
=Bof9
-----END PGP SIGNATURE-----

--p445ireluuhjz7yx--

