Return-Path: <linux-can+bounces-4764-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEDFB8B114
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 21:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE6F1CC2956
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 19:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6FF256C6C;
	Fri, 19 Sep 2025 19:18:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254342641C3
	for <linux-can@vger.kernel.org>; Fri, 19 Sep 2025 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309531; cv=none; b=S4+M8yYl1U8V16stysfeouamCnqOPeCdchVkmJI0U8FUFO3C//zYnYl/BSyy9RAFguKcCxWoRiWEvxdBuXRRI4t6dZFMyuPFK+uA8E7HQvh26kEGoNRZYqZrblKCsfncF3hCWelw5tqgyUThni2w4XJKcUvDX6NyWd54reipeUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309531; c=relaxed/simple;
	bh=Nm+atkHlX329nBUD+ou4VUp5OVx7b5SAjbLtVdyGzew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+v9AI2G74H63tXZ6Lvgok/bA/LnyFL995HaOsqJ2apuC2SFxaPeh/aSPxAZntA7XW16CeDHj3AbHQJIsFwNApbB/HDKFbH2fTmvrPlteRYWVlTng7NVQLE5Gdp++3X9PD92Qr8WWwgiAg8jzgJO/7nqRmo6VcrirJ/JVTCNV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzgcr-0004Qj-VG; Fri, 19 Sep 2025 21:18:33 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzgcq-0029eE-2e;
	Fri, 19 Sep 2025 21:18:32 +0200
Received: from pengutronix.de (ip-185-104-138-125.ptr.icomera.net [185.104.138.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B75A847520E;
	Fri, 19 Sep 2025 19:18:29 +0000 (UTC)
Date: Fri, 19 Sep 2025 21:18:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Peng Fan <peng.fan@nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	Haibo Chen <haibo.chen@nxp.com>, linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 5/9] phy: phy-can-transceiver: Propagate return value
 of gpiod_set_value_cansleep
Message-ID: <20250919-lovely-amethyst-bullmastiff-5cef8b-mkl@pengutronix.de>
References: <20250909-can-v6-0-1cc30715224c@nxp.com>
 <20250909-can-v6-5-1cc30715224c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t6u4zda4cx5kdnck"
Content-Disposition: inline
In-Reply-To: <20250909-can-v6-5-1cc30715224c@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--t6u4zda4cx5kdnck
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 5/9] phy: phy-can-transceiver: Propagate return value
 of gpiod_set_value_cansleep
MIME-Version: 1.0

On 09.09.2025 13:40:15, Peng Fan wrote:
> gpiod_set_value_cansleep might return failure, propagate the return value
> of gpiod_set_value_cansleep to parent.

Are there any expectations of the phy framework from the driver if the
switch on or off fails? Do you have to roll back any changes in case of
an error?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--t6u4zda4cx5kdnck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjNrHoACgkQDHRl3/mQ
kZwqYQf/c1/IXd7aRBuqdaMALPyXhUQLb5zDa8xv15HZudLAlb4N3ZCTwnOa8WuR
6C1PiBoxg6JPbbcgfCADKc3ADq/+nxjr8fk1rU3bPf/9t3p+BNJFfX8jiwL7B42w
X/Yt9MEtmxWaOBWeNXedyM4pFB2qT+GJncKrl6lBIjyjIRkhABKaiNyt/M/DFenK
rA+xEFrZVljI5iLMktjI92K1FlNaRiaEyOvCSYrM33pHz8RQWPECEF0T4D9z9siI
XPy/dP9YRUkUszZ1kp+vh//bd2I8Z1R7fwNBWZf+ZwLMISDDx/lt06ohQQwTcLgs
fHVzHn541sJjrfMO6kikrs8r0W3FQg==
=qpEC
-----END PGP SIGNATURE-----

--t6u4zda4cx5kdnck--

