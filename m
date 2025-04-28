Return-Path: <linux-can+bounces-3497-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD47A9EB26
	for <lists+linux-can@lfdr.de>; Mon, 28 Apr 2025 10:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB1A3BB6BE
	for <lists+linux-can@lfdr.de>; Mon, 28 Apr 2025 08:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5425E829;
	Mon, 28 Apr 2025 08:50:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124625D1EC
	for <linux-can@vger.kernel.org>; Mon, 28 Apr 2025 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830233; cv=none; b=hRvNQRR/hKLZ36Kn7edrUv8S1RN6QQA4gaTDX2Zc8AltLAjmIac7sGFaKAjA8puFuQ2d1x1mqsqlW2Rw/o0k5D6g/c9jj+5NqW+SKG/MzHNGh7vRDjLyZyvrWcRyl1FoHYP+Gu/0IXqAonAOu7/KwaKQoqKlmZW7yeC1LENuxR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830233; c=relaxed/simple;
	bh=F7+2e2LCRjyzP5iiptXwOuLsBQTadyTATFPLcCgPpCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdW4zVk/PdSjuhrubHEEaA9wWBBjvLBToUefg8/o+rgaf30dvw3HNXxLrZuQD5RcRerxH/lgMpSTORMtatoAdHWmaDpG0i9Y+/Vvzw6LAT2iKC2Y/qGZWy0adngf8mue+OTWsSpy/NyZ7B1vuxkM1G5zjifWzjnhF2xeOa7QFvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1u9KC3-0004nA-Gt; Mon, 28 Apr 2025 10:50:27 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1u9KC3-00042U-05;
	Mon, 28 Apr 2025 10:50:27 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A8E9D403502;
	Mon, 28 Apr 2025 08:50:26 +0000 (UTC)
Date: Mon, 28 Apr 2025 10:50:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Antonios Salios <antonios@mwa.re>
Cc: rcsekar@samsung.com, mailhol.vincent@wanadoo.fr, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@mwa.re, jan@mwa.re, 
	msp@baylibre.com
Subject: Re: [PATCH v2] can: m_can: initialize spin lock on device probe
Message-ID: <20250428-tentacled-stoat-of-warranty-a9465c-mkl@pengutronix.de>
References: <20250424142525.69930-2-antonios@mwa.re>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="77v3de343k77ggtf"
Content-Disposition: inline
In-Reply-To: <20250424142525.69930-2-antonios@mwa.re>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--77v3de343k77ggtf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: m_can: initialize spin lock on device probe
MIME-Version: 1.0

On 24.04.2025 16:25:26, Antonios Salios wrote:
> The spin lock tx_handling_spinlock in struct m_can_classdev is not being
> initialized. This leads to bug complaints from the kernel, eg. when
> trying to send CAN frames with cansend from can-utils.
>=20
> This patch fixes that by initializing the spin lock in the corresponding
> device probe functions.
>=20
> Fixes: 1fa80e23c150 ("can: m_can: Introduce a tx_fifo_in_flight counter")
>=20
> Signed-off-by: Antonios Salios <antonios@mwa.re>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--77v3de343k77ggtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgPQUoACgkQDHRl3/mQ
kZzpGQf/UtMKCSbXC45rXta8h+DvIjkCOyBK6tgzc3aQ4fqOtEMTMPML/+G9iQz2
d6QtEBO2SoyvAmVB/4PUSnoFXW3/AwV35d3mvzFFBSGHMGX7BOmOMzue5R7vProV
nB2C9r+e1JQphUb5TUA16cnSXuKy0MDxK/zSSooLwXgxZ3ruO1RLWalMfIsOESjq
c//WxjK+/E9AdiUar4FEMo4Z/qnxyGPn2f5cdDLi6WWcvRE2VhG1nuOFQNAQT9FL
YPYLYSjJbZ/i4UaxrBAnVOlJNByJ3+Q73XaOgp0jdSa4BGDvHwz1J6dq6Ghod1p/
Zgoqk9sqIYFZQg+TuqJyBvGKWOnWMg==
=605h
-----END PGP SIGNATURE-----

--77v3de343k77ggtf--

