Return-Path: <linux-can+bounces-2568-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924FBA08E01
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88542169154
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8877520B1E1;
	Fri, 10 Jan 2025 10:29:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC5C2080CB
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504948; cv=none; b=rXTjfVuBm0OKhnxD6k2WaInSOoPLCo+L2e6GC9rPq+unySM2Sw83YMqeHzJkAGflv3sIUo1kurcOFEifiawU9f3WbBy6dWUETdvbyd9sZ84r5bVXjDfLBAdbLkKkdzIuvXuS7Wbh8q/u279Qh6wSXXJfluPox4Cvo04J2YSpXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504948; c=relaxed/simple;
	bh=2ccwBU3fQgsIIo+h6C3AV/QWedDBs2AyrCm0lNMo9dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT+pY6bliuB0B9nBKXx+rQCaN14R7M6h/8Wt8rGXu6+Nr2a0g4DsQoN1SHZpWaeQg1b/AH97tLx7TcTZDBLaYTxTaXyZU2takSNlxrB/NZeTnQCS2WX5BX7jz0/6Qp14sjyctbuftL2ESW1eXsXFyQCz01RvxJpYHZ+7dMgtWgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWCG5-0008Ak-W6; Fri, 10 Jan 2025 11:28:54 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWCG4-0008u5-2X;
	Fri, 10 Jan 2025 11:28:52 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5B6953A44F2;
	Fri, 10 Jan 2025 10:28:52 +0000 (UTC)
Date: Fri, 10 Jan 2025 11:28:52 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Rob Herring <robh@kernel.org>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: can: st,stm32-bxcan: fix st,gcan property
 type
Message-ID: <20250110-horned-nebulous-condor-09243b-mkl@pengutronix.de>
References: <20241228150043.3926696-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="anwmo6ob52wfnpr4"
Content-Disposition: inline
In-Reply-To: <20241228150043.3926696-1-dario.binacchi@amarulasolutions.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--anwmo6ob52wfnpr4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: can: st,stm32-bxcan: fix st,gcan property
 type
MIME-Version: 1.0

On 28.12.2024 16:00:30, Dario Binacchi wrote:
> The SRAM memory shared pointed to by the st,gcan property is unique, so
> we don't need an array of phandles.
>=20
> Fixes: e43250c0ac81 ("dt-bindings: net: can: add STM32 bxcan DT bindings")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--anwmo6ob52wfnpr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmeA9mAACgkQKDiiPnot
vG9O5AgAlFntbK9yhpLpeCz1lm+o0dvDkJAg6SzSmwNVrDFP2y1ytnIzmcsZnIPS
63BnL7xaJhesheN4reHBf0rgtxgb3QaU+3niVWfl13XdQ79inx9PfZG8xo9TPj/V
xTTMdJWeskKObytetj+1ZLzr2WOsA8FVz6P4fuDgJhcVod21xoEj2UZIzveptxS0
EANnxs0pXr5vSubSDwg2R+1Z5uDEywNGKo9LsoJpugu7y4Sy+gfanoleRuJXsd2l
K2fSG+/XJbJXwnX32jvtWLaP9UIgdDtPdATlSPkdc95L3bVdCYoFx6fqr1MUsYBx
2bpswKMicMk4KQxSdPc3+7mipYOSfQ==
=xsOB
-----END PGP SIGNATURE-----

--anwmo6ob52wfnpr4--

