Return-Path: <linux-can+bounces-1299-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9593968186
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 10:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39001B21B2B
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 08:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D66E178CCA;
	Mon,  2 Sep 2024 08:18:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E326C7346D
	for <linux-can@vger.kernel.org>; Mon,  2 Sep 2024 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265123; cv=none; b=k5fVuLY1OoT8V5tFdYclBSMaTxpgKoeykRAIxL+sHgAKE4kDS9LpfhC4uUbQD2G3/2VCv94EyMb3dx4VkC1n8WV+sEkIfAMnNJua/Y9Xn6Xwrg2y9QsC9AqqfTegt/rydKQaSmJYG6a7S17/NyD1z0+VEX3TRNkYrNgwDIuHoVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265123; c=relaxed/simple;
	bh=gntOgkGjZssnj8n2oZYdnDVzW10lxISSrWvyq9iaFVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0LAGgShREa82PHeANN31o7jvryGEs5UM6Hh+dusdXQSSsswoZHWgIqUiqVoJ4uUxn6Mdjh6Slrn4lKCkAr/g1zU9fJ683m4rkPd11Y8ZJEfX+TyypqzWJfS+dfp/4lKjmRTp9LusPhB5WsOp1wY4m1SzxtZYfuUh9GyfYZLCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sl2Gj-0000Gm-U3; Mon, 02 Sep 2024 10:18:37 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sl2Gj-004rAa-Aa; Mon, 02 Sep 2024 10:18:37 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7E2DA3302AB;
	Mon, 02 Sep 2024 07:40:31 +0000 (UTC)
Date: Mon, 2 Sep 2024 09:40:31 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alibek Omarov <a1ba.omarov@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-can@vger.kernel.org
Subject: Re: [can-next,v3,00/20] can: rockchip_canfd: add support for CAN-FD
 IP core found on Rockchip RK3568
Message-ID: <20240902-skinny-benevolent-hamster-128048-mkl@pengutronix.de>
References: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
 <20240902032837.1513090-1-a1ba.omarov@gmail.com>
 <20240902-aspiring-amphibian-swan-f65506-mkl@pengutronix.de>
 <CAKyg=SXE5FVW4zHVX5qzsm80zco5A3eNe-pU8Xrzq1a7AcM-xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="33geriug7o7f6sxr"
Content-Disposition: inline
In-Reply-To: <CAKyg=SXE5FVW4zHVX5qzsm80zco5A3eNe-pU8Xrzq1a7AcM-xA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--33geriug7o7f6sxr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.09.2024 10:29:38, Alibek Omarov wrote:
> > Are you using the CAN in production devices? The driver runs quite good
> > on a v3 chip, but still not stable on the v2. But as our customer now
> > only uses v3, I don't have any more time left to fix v2 issues. Drop me
> > a note, if you have issues with the v2 chip.
>=20
> Oh, I meant v2 patch set.

Ok I see :) The difference between the patch series v2 and v3 was change
in the compatibles and DT bindings. I've added your Tested-by to the
upcoming v4, I thinks this is still OK, right?

> We're probably mostly running on v3 chips, since nobody so far
> complained about CAN bus and you're also telling it more stable there.
> :)

With the v3 SoC the CAN runs more stable than with the v2 SoC, but still
not 1000%. My basic idea was to get it mainline and thus a larger usage
and test coverage.

Nevertheless, I am very interested in any usage or test cases that break
the driver.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--33geriug7o7f6sxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbVa+sACgkQKDiiPnot
vG8McAf+O4iNvfKGXwBIY7G7WzrUQirLZj38OmJnOiLM/h0Rv+ClN+5wsrrSJjZ+
/2Lb8luKyt7QgDJsoQNjeqIkhJgrQWSMD3GE12aSHZmvcZxYVB4MU9gZignXqB9G
CsOcpX/5c4BYtK3Kf7Hw4v3t1c4Qo3KMbmT3tx9WmvuvLsyDn5NaMQQHvhVlvVAo
85LSTod7Ird8r1+goMdJ80N869ZWy0lWijD6aa7k68uc0b0RYtpGE3Rf3dZ0uDMP
C5lzXDV5TCwE8MuFJGVy6L0IugtGJaLkZUiuu9VcCs3FR713MTz1sCpZY7Bgqc5O
XZMmxlR6+5RIZeU/NeZXY1ofC9dzxQ==
=8VZE
-----END PGP SIGNATURE-----

--33geriug7o7f6sxr--

