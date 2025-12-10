Return-Path: <linux-can+bounces-5835-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 326BACB2611
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 09:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6408311D501
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 08:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3549A30149B;
	Wed, 10 Dec 2025 08:16:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA972FC009
	for <linux-can@vger.kernel.org>; Wed, 10 Dec 2025 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765354612; cv=none; b=bahuo/1HG0neweaeTKlfMjX3JHimcCwG59BVpf0apwNQhhlkaFcs+eCkpcjRJ30iVe13ABC5v/zHirloOmlnl8hEOx+G3I0WdU6ooIjCLQk06CvAarCCv2+J/Lxv4z+6LFJb+Ita2xrT6Reg8alkRmHu47zMS8+Yr+VJNsH2H18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765354612; c=relaxed/simple;
	bh=uPGV3L7itfstN34UqEuG5LYmnyBjolQhHOnOCG0KwGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFEtQzCRK3eJJKX94DBQ/7KdG6jiZeCxVRldh6wawHy+CsUOJs4d51B7PpuKxLobtT0ERkdlAl26UA1nSH9w74TYKDR5nlPJlM00ZrvIeiWOw5QB94FvuJa/ZMXh7ixnQ1KiEfL0dZBfZJHnagAKJoZlfvog9PYMVJm6ngrgumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vTFNK-0005kw-G1; Wed, 10 Dec 2025 09:16:42 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vTFNJ-004vGb-31;
	Wed, 10 Dec 2025 09:16:41 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 995244B3ADC;
	Wed, 10 Dec 2025 08:16:41 +0000 (UTC)
Date: Wed, 10 Dec 2025 09:16:39 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Arnd Bergmann <arnd@arndb.de>, 
	Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: can: fix build dependency
Message-ID: <20251210-imported-pelican-from-tartarus-c1084f-mkl@pengutronix.de>
References: <20251204100015.1033688-1-arnd@kernel.org>
 <5de9b33e-6129-4765-95a7-e3e12de1f8cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l2ysfpexgfutkppu"
Content-Disposition: inline
In-Reply-To: <5de9b33e-6129-4765-95a7-e3e12de1f8cd@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--l2ysfpexgfutkppu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] net: can: fix build dependency
MIME-Version: 1.0

On 05.12.2025 00:30:14, Vincent Mailhol wrote:
> > diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> > index e15e320db476..bc074218d0ee 100644
> > --- a/drivers/net/can/Kconfig
> > +++ b/drivers/net/can/Kconfig
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >
> >  menuconfig CAN_DEV
> > -	tristate "CAN Device Drivers"
> > +	bool "CAN Device Drivers"
> >  	default y
> >  	depends on CAN
> >  	help
> > @@ -20,7 +20,7 @@ menuconfig CAN_DEV
> >  	  To compile as a module, choose M here: the module will be called
>                                   ^^^^^^^^
> After this change, it is not possible to "choose M" for CAN_DEV anymore. =
I would
> suggest to modify (or remove) the above sentence.

Removed the sentence why applying the patch.

>
> >  	  can-dev.> -if CAN_DEV
> > +if CAN_DEV && CAN
>               ^^^^^^
> Is this needed? CAN_DEV depends on CAN, so the condition
>
>   CAN_DEV && !CAN
>
> should not be reachable.

Removed the '&& CAN' while applying the patch.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--l2ysfpexgfutkppu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmk5LGQACgkQDHRl3/mQ
kZxTaAgAg81XYek2LBhSwnEQCWtUSOEIBJnWQk7sOEYrk+sXj0zBtiO4e0INZVA6
EgOVfsCgqS4vX6+eqvrzCTM/ReEHrahxt5pB5ZpWeHUa/RFLrQem9Zs0hPkKvTBh
HnLuKaeZu+eosaOtV5VansgsD6wbWTVhdNu0eUASA/KFT2UvFm/gJdMjVRESsA7K
KIzzArTZuxnWdj1HBHeWcP42fJ1mq67pXKYMk4jWs98Lqk7EIPyYFRflLy93EX/f
XU+SSHn0AG7Rai7S9KZPEpBFS9j1QqgSrKayijvs9zEwyjPeVAVyL++Xa3ifhxaf
c+TkMmw8vT2lL9lVi6Y5UgANpH527A==
=Xu9M
-----END PGP SIGNATURE-----

--l2ysfpexgfutkppu--

