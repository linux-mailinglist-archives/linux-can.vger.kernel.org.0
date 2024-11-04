Return-Path: <linux-can+bounces-1872-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117689BB647
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 14:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91357B22BC1
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D993FB1B;
	Mon,  4 Nov 2024 13:33:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FA2E40B
	for <linux-can@vger.kernel.org>; Mon,  4 Nov 2024 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727239; cv=none; b=bBOC5zsTq3nplVdIFpPoHE7AJJG5jHNoFbe2YTh0HXbhvAlwxTlJs2+w5awE31WXyepHuilnJLlKEKquV+1ivx2GQnGoD7QmaunTpXVGGU1kO+D/gY6iukBQuMs8NeywRKw5+ChelOS9xK8+QZaylx6o8tIot90Fz/B3FsfcgQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727239; c=relaxed/simple;
	bh=nacsC2K/MdlKf+gchrPIFNGMEy+tvM6o7Hw6JWJRtco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZxtKXqRXQlmC2hYekJ7PtAelkpRB84diQQR656dJnAVSg34UbIXsvy/P3qAaG8YtCg2z9mntbS+ltKMHzsk0oEkk94ddMJPyMklnZ6Tu2arzPZKeSrRLeoSMQLrCr0CWDg3RMY3DuCyc40J0KLYUYKe6ab2aIiK79feVgVHdY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t7xDL-0003SJ-E1; Mon, 04 Nov 2024 14:33:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t7xDK-001zSn-2C;
	Mon, 04 Nov 2024 14:33:50 +0100
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 54921367C2F;
	Mon, 04 Nov 2024 13:33:50 +0000 (UTC)
Date: Mon, 4 Nov 2024 14:33:49 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len():
 fix length calculation
Message-ID: <20241104-ludicrous-quartz-kakapo-07219e-mkl@pengutronix.de>
References: <20241025-mcp251xfd-fix-length-calculation-v2-1-ea5db778b950@pengutronix.de>
 <BEZP281MB2245A3077CC6306F78C623AAD94F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4tlduksgquin6st2"
Content-Disposition: inline
In-Reply-To: <BEZP281MB2245A3077CC6306F78C623AAD94F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--4tlduksgquin6st2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len():
 fix length calculation
MIME-Version: 1.0

On 25.10.2024 15:50:37, Sven Schuchmann wrote:
> this looks good to me!
> I have no crashes here anymore.

Thanks, can I interpret this as a Tested-by: and add it to the patch?

Regards,,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4tlduksgquin6st2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcozToACgkQKDiiPnot
vG9fIgf5AScEFsjutS2oRQpi1FGoH87//kfnzdo4RxXbVX9vjpvy0U55QnQ0KUdt
07Ji1cq7GCpSPtFk3D14OM3kVxGqY63fhETVqW0fkjk/VjeGltJyg1BVHBWW5mB2
4NL01o0mZGH1+8IUZLLpHgZ83gttgHEDWq/83vTDQL8zJUmcAVzsKkJgA3a4i1FT
y/mdXOKk1UElT21p+73Z+MWHZqpSp+8T2jXxzGswmTc3N5zrey+DumUQb0U/P0s6
EUgqWd4zCYEiDN4TjtaSWTVFC29ZOIQjimdQ7asA1/ytfKsQ4HH4D9o+TX00CA0Q
lSnkMz0QL1ZDqYFcKGIC12y4y+IF7Q==
=v62R
-----END PGP SIGNATURE-----

--4tlduksgquin6st2--

