Return-Path: <linux-can+bounces-1295-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20F1968082
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 09:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10661B23297
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 07:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2889176FD2;
	Mon,  2 Sep 2024 07:24:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5261741DA
	for <linux-can@vger.kernel.org>; Mon,  2 Sep 2024 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261866; cv=none; b=XXtSzv1Xzk2cTrkaz0QAXFV6MzfJj6A0YNJ0g9onl+aFHUUB0my3CSk6OLFALtcJFgo5WgnxUxGvycinJRDWCzunS1ItwnOit7rCyYalLF3DM4ggyzCDV86Vc3UBhsDTmWJMyZZF8d+3pBRPKWqee5zqK3galLg2L/fOJhjDfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261866; c=relaxed/simple;
	bh=YEXp6iEnFwoyN5CrP6g30wwV26+B+8HmWFxrMTbgRS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTblEdSs16q9KBxfGwgXhcDNFi+FiO20Gvv13vz+lDm9O/zOLP5U5djznznepAUs5Js2XQMs5RTrfvibJjUZTCnTT5f0glFykRciE+VjwzBypwzABJ056T1cHX29zWansVRpmKZFniNfopEXgk8SddCEtS2nSIly4bVly5gIVYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sl1QD-0000ZX-0G; Mon, 02 Sep 2024 09:24:21 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sl1QC-004qbM-D8; Mon, 02 Sep 2024 09:24:20 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2105232F281;
	Mon, 02 Sep 2024 07:24:20 +0000 (UTC)
Date: Mon, 2 Sep 2024 09:24:19 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alibek Omarov <a1ba.omarov@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-can@vger.kernel.org
Subject: Re: [can-next,v3,00/20] can: rockchip_canfd: add support for CAN-FD
 IP core found on Rockchip RK3568
Message-ID: <20240902-encouraging-fine-otter-a7db7a-mkl@pengutronix.de>
References: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
 <20240902032837.1513090-1-a1ba.omarov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sse3wtb42fe4by46"
Content-Disposition: inline
In-Reply-To: <20240902032837.1513090-1-a1ba.omarov@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--sse3wtb42fe4by46
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

Can you bounce or resend this message to the linux-can@vger.kernel.org
mailing list, as this is our primary review channel.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--sse3wtb42fe4by46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbVaB4ACgkQKDiiPnot
vG+uRwf/R7F13WFLDYQCVzRdn0E7y7DtJa/k9L1cuZM0oQEKh//eWZEfsc5Wh/kB
B/s5mdqM9Itz6L5f9AIHLbzVrqMZelGW+ZlQZP/msrOmZxijbJ/hw6UuiQeMaX52
SuUXq5uf7ZhI3EZf8hDEYOvWWWA3SSNfsoIQhbrJfuM8NU14K78sMuEFvQrhxKih
WNvoZhGsONSnlciQ7jIViMDVaUyBg98QWkgOWsM9MmO2kDchAtyRaMl9lXQAOaF6
nxNQ5ScB7SfXsyHvyR738mW8/awNc3tg1SYmpk6u22x5p5pXGX+OxzSUb++8vTOy
RAlDqkt4og3iuzxJkqVaI+N6trwVUQ==
=0BE2
-----END PGP SIGNATURE-----

--sse3wtb42fe4by46--

