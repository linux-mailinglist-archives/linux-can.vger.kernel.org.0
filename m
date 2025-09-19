Return-Path: <linux-can+bounces-4753-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CF6B8AB15
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 19:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7913B8866
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFE7270553;
	Fri, 19 Sep 2025 17:05:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03431A811
	for <linux-can@vger.kernel.org>; Fri, 19 Sep 2025 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301541; cv=none; b=Iij/inCerXynQ/7AD6Bn4Ui9OiDuRmpfscW+RC3I95pzHFT1ktbyo3okt71FvW1vAGZ2dE/lXioucGx0bwWQjcQRyivM46gOgft1em8CtpTYluDbswNoxxOGcXv4gF3d+schikStFwVWUpYl0MAdxg5+ElscR+ByrMDHvMGS3AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301541; c=relaxed/simple;
	bh=Jun/eny7AO4nRsxcc4nqem1oHNpPIf/cnXbidpAGD24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/kdcJrBtfKJ5aT9gGg6l90viL6QijH3KQ3q8gxLQvcAIDd7JDaq4OtuJB9poffW0l4gOsornr663l9jhEv9r6W7iRsLKOlxcdqndpr3CWFl/u8BgWc1PAxGfo33v+KOtyQrHHLxva3qQJWp9rl183M6+qUoVYayEauYi8MqGZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzeXu-0001YL-3W; Fri, 19 Sep 2025 19:05:18 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzeXs-0028co-0G;
	Fri, 19 Sep 2025 19:05:16 +0200
Received: from pengutronix.de (ip-185-104-138-125.ptr.icomera.net [185.104.138.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C39A64750C9;
	Fri, 19 Sep 2025 17:05:14 +0000 (UTC)
Date: Fri, 19 Sep 2025 19:05:13 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Duy Nguyen <duy.nguyen.rh@renesas.com>
Cc: "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, "socketcan@hartkopp.net" <socketcan@hartkopp.net>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Nguyen Hong Thuan <thuan.nguyen-hong@banvien.com.vn>, 
	Tong Duc Duy <duy.tong-duc@banvien.com.vn>, Tranh Ha <tranh.ha.xb@renesas.com>, 
	Minh Le <minh.le.aj@renesas.com>
Subject: Re: [PATCH] can: rcar_canfd: Fix controller mode setting
Message-ID: <20250919-fractal-camel-of-thunder-b079b8-mkl@pengutronix.de>
References: <TYWPR01MB87434739F83E27EDCD23DF44B416A@TYWPR01MB8743.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ra4qxpq2x5dghwz7"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB87434739F83E27EDCD23DF44B416A@TYWPR01MB8743.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ra4qxpq2x5dghwz7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: rcar_canfd: Fix controller mode setting
MIME-Version: 1.0

On 18.09.2025 07:03:45, Duy Nguyen wrote:
> Driver configures register to choose controller mode before
> setting all channels to reset mode leading to failure.
> The patch corrects operation of mode setting.
>=20
> Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> Signed-off-by: Tranh Ha <tranh.ha.xb@renesas.com>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ra4qxpq2x5dghwz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjNjUYACgkQDHRl3/mQ
kZzkOwgApVY3adbNWGXcgk0McMzVaeI5baedcXddNut/rOrm5m/LXkXPP+1ZC2AZ
XEq7NudlVqnAFaek1t/2EdiEH64GEntfkgU2VNBxvO2UWTabyAWTQp5BXGhoSajD
6mFUILf0aU6DXW0EXh9RpOSRiv3bsAqbjLPzqsnOwORCC9/ydEBhDNAj56cTdy8H
ohB0X3vj2OmL1PKxK4urVw3Fx2hehD/5enOBoCGZwjubPG+yEKqZSDfSNsi+bnOM
MGwgfiDPJBmIgiDDFstjQS2yLkntnJ5J5vgThH6Xn39fQNriV4XU3MgUcBls+RNa
AhmoqLhu2FRRj1Kzk0cgFqR+pyKnrg==
=/rMh
-----END PGP SIGNATURE-----

--ra4qxpq2x5dghwz7--

