Return-Path: <linux-can+bounces-1298-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0643968185
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 10:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB7A280F60
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 08:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C490154C00;
	Mon,  2 Sep 2024 08:18:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6718D2032A
	for <linux-can@vger.kernel.org>; Mon,  2 Sep 2024 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265123; cv=none; b=Mhwa4+tGmFra+2vk8pstpHHuNAY93vqqfvxD8Yh/zB9schIHu0NojPq++L4dk+hfY9bi7EP+ljW5WE12yXAsR+panN4aImLsAksommdj2A8V8c3ArTqg0UtfElZJSFJ+GBiJiQ6BpyblfI4V85BeSJazwX+FGH4F3XN4PTeBV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265123; c=relaxed/simple;
	bh=Sw4sCKgKgZ8Yo6pYHkDku1xC+DsorWohNF/ktEsf1ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcrDBakEpHigIMm+G110TVnc5NPcCriMrHbZNN13MzheLJmEs6fsGLPHYGhAubc0Q3lMUywXbO/qHEqyuPVBf2dfsqUwOWmiSDQgrJaJA7TIyxi0viCFwAcXvOFVRRVvsdj+sE/d+18XXThaXbz3anFrNKqFO+/3YGvWEknXBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sl2Gj-0000Gn-U3; Mon, 02 Sep 2024 10:18:37 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sl2Gj-004rAb-CO; Mon, 02 Sep 2024 10:18:37 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BB0E53302AD;
	Mon, 02 Sep 2024 07:41:57 +0000 (UTC)
Date: Mon, 2 Sep 2024 09:41:57 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alibek Omarov <a1ba.omarov@gmail.com>
Cc: linux-can@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [can-next,v3,00/20] can: rockchip_canfd: add support for CAN-FD
 IP core found on Rockchip RK3568
Message-ID: <20240902-fast-cream-magpie-6d5cea-mkl@pengutronix.de>
References: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
 <20240902073116.1620038-1-a1ba.omarov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vvj5dzyb7qvxxin6"
Content-Disposition: inline
In-Reply-To: <20240902073116.1620038-1-a1ba.omarov@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--vvj5dzyb7qvxxin6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.09.2024 10:31:17, Alibek Omarov wrote:
> Resent to include linux-can@vger.kernel.org by Marc's request.
>=20
> >This series adds support for the CAN-FD IP core found on the Rockchip
> >RK3568.
>=20
> >The IP core is a bit complicated and has several documented errata.
> >The driver is added in several stages, first the base driver including
> >the RX-path. Then several workarounds for errata and the TX-path, and
> >finally features like hardware time stamping, loop-back mode and
> >bus error reporting.
>=20
> We've tried this on v2 patch set, with a custom board with Radxa CM3I
> connected and it's even more stable than BSP driver we backported ourselv=
es.
>=20
> Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>

The difference between the v2 and v3 patch set was changes in DT
bindings and the yaml, so I added your Tested-by the upcoming v4.

Thanks again,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vvj5dzyb7qvxxin6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbVbEEACgkQKDiiPnot
vG/KsQf9GgcaVWqZu6MOKeNuM/fGIBrk3aNeuKZ9D+yGwdifGqa58/+//WfPR9Jw
/c0+WiCtXiiY1WwU4ulQmfluf9ADF62Vwd7Ep84mvqdgyGuIt+k+QGMga+uJf8uH
c6WYe+7jj1UMfXmuYzl1Rvog5rxhmz/26YHDRdmxnrl0a4JfnmXFHuosANmvNosu
GxxFZ2BQ2lq5UUXP70Z8c6dRRE90h2A7PExDD7f2zNX/PDpENggHZO2g+b0lJUBg
zPgSV3cI1L3DqNbdFh7SzpdzeceFsYz0BlnhDjmOVQuKfehLePHuYmXQuZF2mY9g
um1GuR0blObbLKYe2N+1GMbwSyK7TQ==
=yvUl
-----END PGP SIGNATURE-----

--vvj5dzyb7qvxxin6--

