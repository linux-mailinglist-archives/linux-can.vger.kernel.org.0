Return-Path: <linux-can+bounces-1541-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C496497EB21
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 13:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0AC281297
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 11:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CC526AC3;
	Mon, 23 Sep 2024 11:57:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1361E487
	for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092639; cv=none; b=CK9I7t5DRfIycWOpGzkEwrSwA9O7L9iw/wfO3KEkdNVXg1c/pw7BhEBzPfl22QegbKA+wMXBjiIMDrSSci06h/eMSe/xLTxFe1tmYq7i5ZIKyQQv20P50vOdUnwfD58nDadihu9JAVO7jqWy0mknXwQvnnpV303ycdSMz+I0qcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092639; c=relaxed/simple;
	bh=H+EePcZXh1CMnl23zt3xgYDTed7UNb02a94gP4gojMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1kOENMSO2gdIoARpZzO1LQ+z6NLPx34pNziPGaqpQD9aijiZr907nJrniC1fRLVO0RGcEojPtRYxooUpOvt/osdmji4S38yvvv+lGg6Jb8l16YSPV1oIcW8je5jMIAfTVw41k+bIxFdN7EYP7bpSSkk3SawjIzzNox40iY7yeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sshgl-0005wR-8W; Mon, 23 Sep 2024 13:57:11 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sshgk-000wvU-Gy; Mon, 23 Sep 2024 13:57:10 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 86B9E341294;
	Mon, 23 Sep 2024 11:57:09 +0000 (UTC)
Date: Mon, 23 Sep 2024 13:57:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: Oops on mcp251xfd open on 6.6.52
Message-ID: <20240923-spry-badger-of-perception-303c63-mkl@pengutronix.de>
References: <20240923115310.GA138774@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="foh2fxbyrwc4zgay"
Content-Disposition: inline
In-Reply-To: <20240923115310.GA138774@francesco-nb>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--foh2fxbyrwc4zgay
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.09.2024 13:53:10, Francesco Dolcini wrote:
> I got the following Oops on doing a simple ip link set canX up, running
> on an i.MX8MM SoC.
>=20
> This was reproduced with some automated testing, I have not tried to
> reproduce it so far. Any idea or hint? It seems systematic, introduced
> around 12th september on the v6.6.y branch.

Which Kernel version are you using?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--foh2fxbyrwc4zgay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbxV4sACgkQKDiiPnot
vG8m9gf/X2P7Bz/lIGqVpdbe/lkktdvY21sgyXFY/M70OhAEvyudsl3cXunNhhja
xJbY2meO8FjsbIE2pTsneDPhDlJLNA3mDv+94lgaT1zZhLCFLxiT0QDvBADcpxoL
92jzJXcq29n/ATDGW08fDzhW5xvxkwMgsaKz6dVjbwKZqDhPTUcVYpY5R6+BjI66
f4G6IiNPZcYvmfeG4rhv+5/1ocRbxr9qA5bL9j9TDHrMwdU5a5M9fzZfjithKoDo
BVwbjy9MfYuinm+/4aHKClnNEYizwEj4VPxaUlMF2D5ZhcCLdD6+PJiO5igin2qj
UVDeGSaDq6KwhSoTv81jle7yCINUXg==
=fnFr
-----END PGP SIGNATURE-----

--foh2fxbyrwc4zgay--

