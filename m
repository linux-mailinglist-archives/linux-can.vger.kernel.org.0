Return-Path: <linux-can+bounces-1383-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A582B96BB5A
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 13:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD4D1F21E70
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 11:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2221D2F69;
	Wed,  4 Sep 2024 11:57:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C90188590
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451075; cv=none; b=BF47OINbLRtVjZNtQpLK3gpRnJkpUCoo8TlNq7CjHl5ilgNRQ+D+2RHufLmZN9aP7ojfyU+qzaux095Aod+1rtNtpC5cSvqW1Af/vvWDzYwRceioK6MJSrL9A/XSJqJ9rBPBYGPR4r7HdeGELqmeO2Y8mwi0stON2LQVLt+Sw10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451075; c=relaxed/simple;
	bh=hXM9kDUzyzcchOF10V4Nqns7SR1oeoeAq3LjeHrlGoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAQxlom2/5PBncgYQ1k9u52qNaNlwlMEzsrcvlhWMlgol+Tz5wNcKqpeoXz3BObfWbewkcCtetHPPNjmAPpuIsEb3A99w42/T9wvL1b5shOHqGgD6Q54QTmlqUVihJTYGvQYO0iEPLeYN1erUsZmcY2YL3MjatjYciVy11lomLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slodt-00043Y-17; Wed, 04 Sep 2024 13:57:45 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slodr-005Rbu-H0; Wed, 04 Sep 2024 13:57:43 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2A342332677;
	Wed, 04 Sep 2024 11:57:43 +0000 (UTC)
Date: Wed, 4 Sep 2024 13:57:42 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, David Jander <david@protonic.nl>, 
	Alibek Omarov <a1ba.omarov@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH net-next 03/20] arm64: dts: rockchip: mecsbc: add CAN0
 and CAN1 interfaces
Message-ID: <20240904-resolute-mutant-bull-8000b7-mkl@pengutronix.de>
References: <20240904094218.1925386-1-mkl@pengutronix.de>
 <20240904094218.1925386-4-mkl@pengutronix.de>
 <00a04ead-e262-4b13-b6c0-4f814b26b221@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="75u5brmjkmdwmt47"
Content-Disposition: inline
In-Reply-To: <00a04ead-e262-4b13-b6c0-4f814b26b221@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--75u5brmjkmdwmt47
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.09.2024 13:51:52, Krzysztof Kozlowski wrote:
> On 04/09/2024 11:38, Marc Kleine-Budde wrote:
> > From: David Jander <david@protonic.nl>
> >=20
> > This patch adds support for the CAN0 and CAN1 interfaces to the board.
> >=20
> > Signed-off-by: David Jander <david@protonic.nl>
> > Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
> > Link: https://patch.msgid.link/20240904-rockchip-canfd-v5-3-8ae22bcb27c=
c@pengutronix.de
> > [mkl: fixed order of phandles]
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts | 14 ++++++++++++++
>=20
> DTS patches should never be taken via net/can or or any other driver
> subsystem.

Ok.

> DTS is independent hardware description. Embedding it here suggests
> there is dependency thus ABI break.

It might suggest, but it isn't.

> Please drop all DTS patches and never apply them via net.

Ok, will send an updated PR to net-next and an independent PR to
upstream the DTS changes.

regards
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--75u5brmjkmdwmt47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbYSzQACgkQKDiiPnot
vG+orAf+N9mzsTECnapO0VF9JRHqjFmo7KkV2G+nCzZZwi1jotFVdNjNTXoPPTb1
uU4WikoRy3cGUmkatijPtCzwX7cU2DcyIWBFj/56HeUzkLjUZwwmBfy8hdjt4Y9M
LAjUGITLSpFCZQ42PDwqVHM9RxWBT226z1yc0FTwFR0B3Zy/Npazoyrefq4nWtLX
SVLC4fEcF31dBsGWpmz74qCCg4OqYObVJDoFYUQmiDjSGQeM/XM7IR8NBwcbU/fx
53p4aVKJaUpy762dFviOm3winZNnK8pf3YMC7EpPBYIdqpLrsVkLkwtPw9BHs7+M
7jWFoAVjsmFwsK+c6ZuouLYue9Rc1w==
=h2ob
-----END PGP SIGNATURE-----

--75u5brmjkmdwmt47--

