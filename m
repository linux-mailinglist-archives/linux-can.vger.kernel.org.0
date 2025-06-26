Return-Path: <linux-can+bounces-3904-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF58AE9F8B
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 15:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 506337AA5A4
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 13:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD2528C86E;
	Thu, 26 Jun 2025 13:57:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDCA26B970
	for <linux-can@vger.kernel.org>; Thu, 26 Jun 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946257; cv=none; b=pVInGsOJchi6lJ1e8/LodMJejjJhgxD/T2rK6tFQWRRuDwruluuouQwosSbFwjjztxajEKsMziiba8b5r7stZQBVI0SV1GxRp8KkX1KiFE3RWXL0QLOjEpZeytQKwX+l195P4YGuqkS/D0+UP0KZN0rGNXtSzZhkP/A/f3RmkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946257; c=relaxed/simple;
	bh=p3pmOFZqG2foxfhTMDICNAFt3FpMHKfFAZ7apfgJC4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPKiMGeMQQfJJ73x2fTOYldsydfb1Y3Y/aL+8Fz19okp1WJ/81gM/oy7fr8L+elzY3jQDqLSNxWqOD/rJOp9Dd2kDw8qs84wf2YkN+nlaSzxIQythKjoFbf4mq6krr1lvFK5EMZdnEy6t31swfI7tzBCRJPWGim266WYmpnxcy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uUn6M-0006uy-3x; Thu, 26 Jun 2025 15:57:18 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uUn6K-005SOl-1l;
	Thu, 26 Jun 2025 15:57:16 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2AFE9431201;
	Thu, 26 Jun 2025 13:57:16 +0000 (UTC)
Date: Thu, 26 Jun 2025 15:57:14 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Fengguang Wu <fengguang.wu@intel.com>, 
	Varka Bhadram <varkabhadram@gmail.com>, Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH] can: m_can: apply rate-limiting to lost msg in rx
Message-ID: <20250626-rigorous-gentle-foxhound-d864c1-mkl@pengutronix.de>
References: <20250620-mcan_ratelimit-v1-1-e747ee30f71f@geanix.com>
 <d855c26a-1982-4fc6-9333-93df4a5a98d9@wanadoo.fr>
 <wldhiihvxg42yqaccizms4xfupfv2c7w7jec7jy6iht6dbnr7k@os6f2gyrr45m>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gjc6jtpqapf4k5xt"
Content-Disposition: inline
In-Reply-To: <wldhiihvxg42yqaccizms4xfupfv2c7w7jec7jy6iht6dbnr7k@os6f2gyrr45m>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gjc6jtpqapf4k5xt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: m_can: apply rate-limiting to lost msg in rx
MIME-Version: 1.0

On 26.06.2025 13:45:09, Sean Nyekjaer wrote:
> Hi,
>=20
> On Sat, Jun 21, 2025 at 11:13:33AM +0100, Vincent Mailhol wrote:
> > On 20/06/2025 at 19:00, Sean Nyekjaer wrote:
> > > Wrap the "msg lost in rxf0" error in m_can_handle_lost_msg() with
> > > a call to net_ratelimit() to prevent flooding the kernel log
> > > with repeated error messages.
> >=20
> > Note that another solution is to simply remove the error message. The u=
sers can
> > use the CAN error frames or the netstasts instead to see if lost messag=
es occurred.
> >=20
> > That said, I am OK with your proposed patch. See above comment as a sim=
ple FYI.
>=20
> I'm up for both solutions :)
>=20
> @Marc what would you prefer?

If it is my call, then make it a netdev_dbg();

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gjc6jtpqapf4k5xt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhdUbcACgkQDHRl3/mQ
kZy2ugf/Ybp8xPyZ5wBEXgtHwORfcRr5f6ee7M1D47DJiiGxWWzKMxkcODxpdzmL
biItBK1YE5o5ert4jfCMyElJIQKiu872lhnxOLGigFg10spbWRWDyF9BJAYt7q3t
Mf2aBdgs70R4Mt+6Kz43SasRUQbEw0kYEPHeoE5+t/6glKZuf4ICBjKu7XDWP24C
MTW8sjhH1gpEAcBrksvYM2qaRXjADTzAnKD/Frd1s1F//1PmKMkC0vWBk6pzKQeR
wqu9h5mUSTICfXYHakEMU5N8omBa49S7Qz3BxIGUE7JSk2W7Vv+CLSQfCFSIiQSF
2/3zxAVHCPlUJ5p4fWNcO+cJpu+/Ag==
=uPcY
-----END PGP SIGNATURE-----

--gjc6jtpqapf4k5xt--

