Return-Path: <linux-can+bounces-1294-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C39D967FE9
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 09:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD501C20E08
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 07:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D9C32C85;
	Mon,  2 Sep 2024 07:03:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0961A15351B
	for <linux-can@vger.kernel.org>; Mon,  2 Sep 2024 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260590; cv=none; b=ipS0AdYrQ0Uag0fkMDYhMQw4RdA8adzW2nqPJS+1b/YroXl5t5LE+mSONaDuNo68AOpXjnD6q9dg2fvBKHHIZzP5pKiRpTDagkgdSIL+dKy5LMsPCB3S3EUHTiuA0WV8Tlxcgq6PNxpAJYg9OEX8C/X5kZP3TozOJOEj5iHJ46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260590; c=relaxed/simple;
	bh=QySykRywZU6hqWhgPeIw1ffWwRmkA7lz/DnMvRklqqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGs+h38js3U6Ts+NCPs8OaLCIIadEBoYYUpb6+tKvtts1B7/WOCgZVl3aabX2MoROvlbZtj9Uwn99vl8qnDlU4v2IZxi8UE8uipskUYwQnaWvYXJAlM3ZxlsjKc8N6tGrShHHmtFwKnUGfqXkjuD7/DuMYQvczDYCLYOSVJqUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sl15d-0000B0-JI; Mon, 02 Sep 2024 09:03:05 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sl15d-004qDp-0E; Mon, 02 Sep 2024 09:03:05 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 336FF32F1A0;
	Mon, 02 Sep 2024 07:01:40 +0000 (UTC)
Date: Mon, 2 Sep 2024 09:01:37 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alibek Omarov <a1ba.omarov@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-can@vger.kernel.org
Subject: Re: [can-next,v3,00/20] can: rockchip_canfd: add support for CAN-FD
 IP core found on Rockchip RK3568
Message-ID: <20240902-aspiring-amphibian-swan-f65506-mkl@pengutronix.de>
References: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
 <20240902032837.1513090-1-a1ba.omarov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mqo32kt2tutemk2n"
Content-Disposition: inline
In-Reply-To: <20240902032837.1513090-1-a1ba.omarov@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--mqo32kt2tutemk2n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.09.2024 06:28:37, Alibek Omarov wrote:
> >The IP core is a bit complicated and has several documented errata.
> >The driver is added in several stages, first the base driver including
> >the RX-path. Then several workarounds for errata and the TX-path, and
> >finally features like hardware time stamping, loop-back mode and
> >bus error reporting.
>=20
> We've tried this on v2, with a custom board with Radxa CM3I connected and
> it's even more stable than BSP driver we backported ourselves.
>=20
> Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>

Thanks for testing.

Are you using the CAN in production devices? The driver runs quite good
on a v3 chip, but still not stable on the v2. But as our customer now
only uses v3, I don't have any more time left to fix v2 issues. Drop me
a note, if you have issues with the v2 chip.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mqo32kt2tutemk2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbVYswACgkQKDiiPnot
vG/4pwf/XqsOn5T2gw6QPjXP5lu6vQUNgtmPrw2YFTTqxzcvJYQWrrf3TmJnzl2Z
AWzG8QH4W2HtSj0yPJlA4w3bUlbrU6mF7onnLWds+vssC2RkI0hrIqIkATsu1BKf
rWUT+Kpmq0xiRKkuXFMLBlb7yjPutpYV0NPyatTyVD1bwPE3uZ/KsYKsv8DFmvsB
EgAZ1kst0ZmBgDHdZSgcSg+WS+BfYa2piMFgWNmZ00Kni25rlFYE2fP+EE5WROqS
YhFuCqBLJqF4fvmyUTeKivnqEadLnHgG4QiDV5zziaKNcTs9/nMhxKV9E0GMCHDb
dn+UesNKwCdHe+hD9l3J/+gE5ATCYg==
=WTd/
-----END PGP SIGNATURE-----

--mqo32kt2tutemk2n--

