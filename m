Return-Path: <linux-can+bounces-1747-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A979AE45D
	for <lists+linux-can@lfdr.de>; Thu, 24 Oct 2024 14:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0282E1C21E73
	for <lists+linux-can@lfdr.de>; Thu, 24 Oct 2024 12:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8921CFED9;
	Thu, 24 Oct 2024 12:05:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D31CACFC
	for <linux-can@vger.kernel.org>; Thu, 24 Oct 2024 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771528; cv=none; b=h2CvfCMmLjGxAHrXdkoO1oApOHG/rKU3OBVOcrAXiJSVFW5/rrxDOhef+ShQMu0gdGAHAvdvXvI3BNe3+Et2Db0jpfEuohtFwjmK/aTlpL2uSF3ObRjF/g3I3cF7g/Ogx5oovNMcItjQx2KDpUN1uQdL+ortCZt5dPrzOXD96tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771528; c=relaxed/simple;
	bh=/6q2XAl6jLAhHHoryq0keprHtaNC9SfJ7xD+lq8sS3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjAdRy2fpQUygxpzHeZ4N4MH+ZFz/hxEeaT6bpRBtgcVn2jFnlkSFnrXm7kV1YLr+tSH7lRahzLWDvY04SBh238R3ruiREFtRm+UJqD2T3t5/UaqmcLwVk46VPvcHlQptXarjYfzf8MyLdU/aZJX00EstPa764KB5bM8jOLbfMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t3wag-00056R-1E; Thu, 24 Oct 2024 14:05:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t3waf-000BvP-1c;
	Thu, 24 Oct 2024 14:05:21 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2A51A35DABB;
	Thu, 24 Oct 2024 12:05:21 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:05:20 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: AW: [PATCH RFC can] can: mcp251xfd: mcp251xfd_get_tef_len(): fix
 length calculation
Message-ID: <20241024-warm-enthusiastic-jacamar-1e5757-mkl@pengutronix.de>
References: <20241001-mcp251xfd-fix-length-calculation-v1-1-598b46508d61@pengutronix.de>
 <BEZP281MB224549045AA4601B1951CD3BD97C2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <BEZP281MB2245544BA81549572750B368D94E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sp67rdvobq5h22sa"
Content-Disposition: inline
In-Reply-To: <BEZP281MB2245544BA81549572750B368D94E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--sp67rdvobq5h22sa
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: AW: [PATCH RFC can] can: mcp251xfd: mcp251xfd_get_tef_len(): fix
 length calculation
MIME-Version: 1.0

On 24.10.2024 10:00:33, Sven Schuchmann wrote:
> did you have a chance to look at it?

Not yet. Hopefully tomorrow.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--sp67rdvobq5h22sa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcaN/0ACgkQKDiiPnot
vG/dbgf/WIlBUy2jkE4vusBIRHmPlA9lj69MhV5ItKP8birTex+cD118/Lcd7/gl
vP5yekIZalLM8LYiJm1R3/se1CV3kssYQjVZLPDGoTQehKwLXp2tjoDZpzZpno6T
gNvCPLUyUL1TJg9pP0FgddaPNfO9MuqxUncb64zfLtCHbRZLM2XGxLwoLhyV2mQJ
0usQ33dGvjVgPgPSWt2e2zKEhB+T17D2yU5AETlunNkdqhqbS7D7NuSJ/Hrqb54D
6nbHnU4GkbUxWraK6cUWadAOXadk20y6rAWr5I6rCMXkFOE2iOxjC8DVmv3+DaCa
ceV1V+lRtCW7TVCyUh0XbReiJteU1A==
=Dpuv
-----END PGP SIGNATURE-----

--sp67rdvobq5h22sa--

