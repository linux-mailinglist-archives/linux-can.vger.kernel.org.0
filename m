Return-Path: <linux-can+bounces-4227-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 754A3B244A2
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 10:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2E21884734
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 08:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9BD2D1929;
	Wed, 13 Aug 2025 08:44:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA72EA48D
	for <linux-can@vger.kernel.org>; Wed, 13 Aug 2025 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074669; cv=none; b=eGwWxY+tgLhLbxGn1JcbrVtP1u8SsaseArZmnVGOGaR2I6rzeXV6cNU+eLdkodbjZlyUZL7Ihbqrp6rl0igKIJ1xphtIFcBS/EiKBlrqEu+Ra0B4nySX1GPlL1y/WeYOjSgmZXbdjUZfEvG/UbAQQnhIxH7REx4hj16o5+wpPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074669; c=relaxed/simple;
	bh=mS6kt8/x9Qd9WNbJzNv95A7uomDrcagr7m+4yrBGo/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMku36DcBJq+8kW5CwKATvG+9dC4fK/fGDTM6VG+wtPZuXectNN/0a9/7pwpRAxfF6zjSh8TEjd1pj5tg3Jl+Qqz3kgSRBIS0Fuk574C1R52yoN1l1MalC2886YI7Qh1J45+bA6belDnh1ns93FIgk14pMT+cscyVARviJcTAPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1um75q-00070c-HK; Wed, 13 Aug 2025 10:44:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1um75n-0003vK-0O;
	Wed, 13 Aug 2025 10:44:19 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B7D2F45691E;
	Wed, 13 Aug 2025 08:44:18 +0000 (UTC)
Date: Wed, 13 Aug 2025 10:44:18 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Patrik Flykt <patrik.flykt@linux.intel.com>, 
	Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
	Varka Bhadram <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH 7/7] can: m_can: add optional support for reset
Message-ID: <20250813-noisy-psychedelic-bear-350e15-mkl@pengutronix.de>
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
 <20250812-m_can-fix-state-handling-v1-7-b739e06c0a3b@pengutronix.de>
 <6f138742fe92b6d26f0cd87d3c57e141d63c6f3b.camel@pengutronix.de>
 <20250813-important-wisteria-toucan-35763e-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hid6feltxh72w5ja"
Content-Disposition: inline
In-Reply-To: <20250813-important-wisteria-toucan-35763e-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--hid6feltxh72w5ja
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 7/7] can: m_can: add optional support for reset
MIME-Version: 1.0

On 13.08.2025 10:34:12, Marc Kleine-Budde wrote:
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>=20
> Thanks, hmmm, why doesn't b4 pick that up?

Ahh, that's intentional. b4 will only apply the trailer if the patch is
unchanged to the posted one.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hid6feltxh72w5ja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmicUF8ACgkQDHRl3/mQ
kZy14gf+LmZO1LxZ1KLXCzB93eOXujjezBuNe/6C51ijD6tgHlBspKjmpsXFUtzM
I7hkCDIlcbdw6thA6ux8GATK2fE56Xx/n4zRJ0g4X+8zzzT1bPhS9uwXbsemNSK8
0zMTY8+1VkCTkp1fiCbWbSAU3nGO/qLvtg1OqWDjDXew+KxEsKS75vbaLj2Zphm8
hXlVgWte54yEDQ0OVG3H7VJ3gvIm1ybYSXqb1vgYccVcqsd01irBNEFCzu0sm458
8qzGMddXuV2GYFai2z/YadESvz0yBDvWSi26ZYs7//LF5dE0gP5YsOEzYA4i4F3a
LLSyQpEeY/DiG2pFO2iMz56ygMtCGQ==
=TIcv
-----END PGP SIGNATURE-----

--hid6feltxh72w5ja--

