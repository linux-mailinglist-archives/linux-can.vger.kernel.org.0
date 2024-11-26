Return-Path: <linux-can+bounces-2227-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E68B9D94F4
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 10:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDE75B29015
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 09:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70B23A268;
	Tue, 26 Nov 2024 09:48:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229D1C3F36
	for <linux-can@vger.kernel.org>; Tue, 26 Nov 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614526; cv=none; b=nnxq/MH7kHvtZSkHLnh4P/8fIHbc6CC5+5pY4QW2Zgi6EfkDuISK+VCVlvb2fXnHcxxZ8PRn9vElZg+eSjjaFP0ihfn+vMAmsGO3y/tIlFpUJ2YCYQx0CgujjU7/GmngOD++qEcuIKRmLNqHrK4JSvo+LczKcTRxRGxdB5yUN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614526; c=relaxed/simple;
	bh=oDPWtoPMXNgFwHFMLeNLa9T2A6HBoy6LgbNyilvHNSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS0HNDZ4gI0EksWUNFZeeD6H46NePjbXN0psTDxVxFuuDLgXZQAas/CcvbMGIaTbN5lfWHfeFl2t+NBABOlsgfNp6uqDYFxs35cVKWIXhKezKxrNlZes/ZTrsBkb3xdFLFhS8b6csNpSI3qUrM35K8R7Gj363RNXvl2OGv0cYKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFsBW-0000br-7b; Tue, 26 Nov 2024 10:48:42 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFsBU-000E7a-3D;
	Tue, 26 Nov 2024 10:48:41 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7572B37D869;
	Tue, 26 Nov 2024 09:48:41 +0000 (UTC)
Date: Tue, 26 Nov 2024 10:48:41 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH v2 04/12] can: hi311x: fix txerr and rxerr reporting
Message-ID: <20241126-saffron-angelfish-of-unity-31108e-mkl@pengutronix.de>
References: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
 <20241122221650.633981-5-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eqv5zvhfl65aq6jc"
Content-Disposition: inline
In-Reply-To: <20241122221650.633981-5-dario.binacchi@amarulasolutions.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--eqv5zvhfl65aq6jc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 04/12] can: hi311x: fix txerr and rxerr reporting
MIME-Version: 1.0

On 22.11.2024 23:15:45, Dario Binacchi wrote:
> The commit a22bd630cfff ("can: hi311x: do not report txerr and rxerr
> during bus-off") removed the reporting of rxerr and txerr even in case
> of correct operation (i. e. not bus-off). The CAN frame is unnecessarily
> set since netif_rx() has already been called. The patch fixes the issue
> by postponing the netif_rx() call in case of txerr and rxerr reporting.

re-phrased to:

can: hi311x: hi3110_can_ist(): fix potential use-after-free

The commit a22bd630cfff ("can: hi311x: do not report txerr and rxerr
during bus-off") removed the reporting of rxerr and txerr even in case
of correct operation (i. e. not bus-off).

The error count information added to the CAN frame after netif_rx() is
a potential use after free, since there is no guarantee that the skb
is in the same state. It might be freed or reused.

Fix the issue by postponing the netif_rx() call in case of txerr and
rxerr reporting.

> Fixes: a22bd630cfff ("can: hi311x: do not report txerr and rxerr during b=
us-off")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--eqv5zvhfl65aq6jc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdFmXYACgkQKDiiPnot
vG+pdAf+Ni/CTEuTV5xnQix+yopxg4s2OwTR6Y1wDlEUE87+PlEODrcorPjaz/PP
jqpqQhAF9ijZXfAVuuwsN9Z3ywpbYJeQNVsgzVrmS8zMzb/ScZamsVZb3kDQ7cd0
st+asE02+J/kYUXQn8OTGybxpMyuP+O/QBakH0ZAEAqafKD7Z2t9GjHvU2YyCCgQ
HkRyN98Ip0DGrEHFwYT9zEraZ8M0FmWvM6DPnGTRbatbIdbUJhsAYWM01ZGG17lR
kLGrWQOqcd0F8+B98SoaQLCy+Q/CIJEcq1DTAuKnDdHxT2nHPbSgjGnuCG9tKOrV
t+/xTClfor2+RC7GoOGsMr6/M2cMTA==
=Dnos
-----END PGP SIGNATURE-----

--eqv5zvhfl65aq6jc--

