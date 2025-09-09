Return-Path: <linux-can+bounces-4578-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B51B4FFA4
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 16:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86ED0160F96
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 14:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2507081E;
	Tue,  9 Sep 2025 14:38:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16EF1F0E2E
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428725; cv=none; b=cWtIMtrPWGy53FS9+smylqRCgrzm6yHmBjGDgiUDEkiMO4lYFNMfw7ztLRgRDCrkZBLs6QGsnHzjVtIvbrz4F0tb/81Uqc/lZK22HB4/8vRFejZyOQqIV2GCkxfnm+fTVsiDtkCaAWrM5iesafIrTB0i8aXpMcnBRiL9NszRs5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428725; c=relaxed/simple;
	bh=tJbcx/bk9C54Jm57BJ+fi7rGBD0k9Ovd/v5P+snaFx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzVJlZr+qTe5u/g/HGS/riFYEHwPxC/dTqqn+dzF3cFi3h6Ck8NUHE+ecOf4Sb6/es6+VMjIaREg79i0fx/zBqUfj/MKZomunzjdJ4LEsrHWHtl+D4rQ74CpmNRv3hdxWo8WsXEdT4chn9fPYWflyzr3sYhIcgVEC+9q93gRzd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvzUT-0006Ij-GW; Tue, 09 Sep 2025 16:38:37 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvzUR-000REA-2b;
	Tue, 09 Sep 2025 16:38:35 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 70BAE46A182;
	Tue, 09 Sep 2025 14:38:35 +0000 (UTC)
Date: Tue, 9 Sep 2025 16:38:35 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Patrik Flykt <patrik.flykt@linux.intel.com>, 
	Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
	Varka Bhadram <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH 3/7] can: m_can: m_can_handle_state_errors(): fix CAN
 state transition to Error Active
Message-ID: <20250909-curly-rousing-hyrax-d4eb4c-mkl@pengutronix.de>
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
 <20250812-m_can-fix-state-handling-v1-3-b739e06c0a3b@pengutronix.de>
 <DC74JEKBB6HL.1LJ53UZJ0T0Q9@baylibre.com>
 <DC74YGSPTL16.KG2SWZD4L3YV@baylibre.com>
 <20250909-nightingale-of-strange-defense-631196-mkl@pengutronix.de>
 <20250909-bulky-wolverine-of-artistry-49749f-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ghylx5zynkmh56yl"
Content-Disposition: inline
In-Reply-To: <20250909-bulky-wolverine-of-artistry-49749f-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ghylx5zynkmh56yl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/7] can: m_can: m_can_handle_state_errors(): fix CAN
 state transition to Error Active
MIME-Version: 1.0

On 09.09.2025 16:31:29, Marc Kleine-Budde wrote:
> > > Also looking at all the users added for the function above, could you
> > > read the register inside the function? Currently you are adding a
> > > reg variable and a read call for each call to this function.
> > > m_can_handle_state_errors() also doesn't need the psr value with your
> > > refactoring.
> >=20
> > That makes sense.
>=20
> I'm also preparing the driver to have error handling for all register
> reads...so I'll have to return in case of an error and pass the state
> via a pointer.

This has to wait until a later patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ghylx5zynkmh56yl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjAO+gACgkQDHRl3/mQ
kZwNFAf/SxdJiEB4XBelMF6fV6G8aPDd0EYMka2gwKCymQSTVykivv5gfJH+MkQb
jXxjKS8fheQ1bYxbiFTqp6tcPjEuGbaquQj3Ds6w1DDaqYoGx11c7/HWv7w/D6GS
MBCfMGNJqN8m8cVYVsEMivp+2jIHmzm8VIllH4KmkyTZ1lYLVJoJlKAo2zSX1TVB
OKFQ7QArRO1vtpT2Fn9CiAU1fQp0DyeS0erQrHfjsfGdsJGMnUmUHu3YdenIPGzt
mv7/AUuTELlBJrYPkHVtPNyW5NnuwjgFfZ2gWjcxl8F/e8LYEXTIe5kxmH0C0fAn
PfuY4//X7OdD1g/KzxSVhGggrM7LxQ==
=6GXS
-----END PGP SIGNATURE-----

--ghylx5zynkmh56yl--

