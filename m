Return-Path: <linux-can+bounces-1775-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B09AFF3E
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 12:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178F31C221B1
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 10:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5741D54C7;
	Fri, 25 Oct 2024 09:59:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF11D4359
	for <linux-can@vger.kernel.org>; Fri, 25 Oct 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850380; cv=none; b=EBw5A4tNYSaHj1LxiZbYDzR3SNvF/Eivq+Y+x2G3HD1v3RvbqcDCgm0Qk/u8AiXd6qy/3md5GLOdk4KiWNlz1R7UWEzrn73h89ibZjnRE7kyqKKPpRV7/W7CDvD2MCV99LuL32xkBEIrxjnzc0nJ0+uMkWngXejJfeL9v0Zl9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850380; c=relaxed/simple;
	bh=dcTdmb/t27UVDkK2gBNIHqWr93+7W4l8q8i/FoqyR5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rc3KOYfQNmOdR3KuvGSKu7R2vfAKX7g6tZaWyxivoTcZgYPfnmvy3rAdb3yCYS1LdPt5NW7gxYOi+TbRsg1LySDjGJtnhF2JFQFLgqnBriw8Sop5XuQnPofW5PztRV2anQfrx7dCrSxnuiAQEvH/Eh1CY287kE+p24ocPCgx/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t4H6S-0008Rc-5y; Fri, 25 Oct 2024 11:59:32 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t4H6R-000LM0-2y;
	Fri, 25 Oct 2024 11:59:31 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9881235E91E;
	Fri, 25 Oct 2024 09:59:31 +0000 (UTC)
Date: Fri, 25 Oct 2024 11:59:31 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: AW: [PATCH RFC can] can: mcp251xfd: mcp251xfd_get_tef_len(): fix
 length calculation
Message-ID: <20241025-turquoise-meerkat-from-tartarus-9686ed-mkl@pengutronix.de>
References: <20241001-mcp251xfd-fix-length-calculation-v1-1-598b46508d61@pengutronix.de>
 <BEZP281MB224549045AA4601B1951CD3BD97C2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <BEZP281MB2245544BA81549572750B368D94E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <20241024-warm-enthusiastic-jacamar-1e5757-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="id5js3migg4j64xt"
Content-Disposition: inline
In-Reply-To: <20241024-warm-enthusiastic-jacamar-1e5757-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--id5js3migg4j64xt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: AW: [PATCH RFC can] can: mcp251xfd: mcp251xfd_get_tef_len(): fix
 length calculation
MIME-Version: 1.0

On 24.10.2024 14:05:20, Marc Kleine-Budde wrote:
> On 24.10.2024 10:00:33, Sven Schuchmann wrote:
> > did you have a chance to look at it?
>=20
> Not yet. Hopefully tomorrow.

Here you go:

| https://lore.kernel.org/all/20241025-mcp251xfd-fix-length-calculation-v2-=
1-ea5db778b950@pengutronix.de/

Compile tested only, though.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--id5js3migg4j64xt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcbbAAACgkQKDiiPnot
vG+dbgf8DazBqy7p4Jj5aUQforai4EiZARKoUxLMH2hM7kOf8OLi7efjBMmFfEr7
VfOCr5QxNMpqjQqldGke7KLPdLuhSB0UcOWKANJE0vtCIFwq6X57FGV0JHL+SYfz
Ga76VyMB8BD59OnIqQcU0XiMDpFt/ktgpQ9+CMro8VuzEUgaMH9FaMYruVx5htpX
URQgrBmOWHzEL602tC69OwMmQ4ptCuNbhPF0zam4FqbQr0w+CrvWhgt1+YZvEUqj
AR6xYsrIEA6QBt4TT8HZYElNqgtwAuruUdkmshF1vVrrBWuodo9obW8Y940JL1D0
1RpV3eJIvA0TGbv9QUTQPvfNR7et7w==
=bCDg
-----END PGP SIGNATURE-----

--id5js3migg4j64xt--

