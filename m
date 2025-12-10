Return-Path: <linux-can+bounces-5841-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14329CB2955
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 10:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CF3830194DC
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C3B27934B;
	Wed, 10 Dec 2025 09:39:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848851DF736
	for <linux-can@vger.kernel.org>; Wed, 10 Dec 2025 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765359550; cv=none; b=uXm82sKVygQkCOSRwWAmwuvgNWSfMteSGnXFc5nCTTWm0b0h7HdfZ18wilmuN+lOmXd8O+Hp8wjhqaVsQY1kg7WxoA9L66oAZHblnJpCgNJcnhK5GbIMWmoKPdLV1JQaHgxIxLXFYHIp5yeDk76Dz1aD85OuBXRjbdQuy9p3q20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765359550; c=relaxed/simple;
	bh=D/jLKbRMozp7T5MeVkxHwbQv16DDTd0qBIm0X6tO/UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVSgcUPWtqTDcSdzbpAk7035wyN+7hnaeTzdtlMs5r85RzsUtU0Kf86xznr9pI4auX2zKUbBxV+S1Evafy6ZNPniojuKZvcLv7ps88UFpOpi2z+JOHWGHsSMOF1UUOfy3C6yrWRFX55Z+OTdEAraUQKgiXthN20lno02zhH8MGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vTGey-0006jv-6k; Wed, 10 Dec 2025 10:39:00 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vTGex-004vzj-1t;
	Wed, 10 Dec 2025 10:38:59 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 417734B3C0A;
	Wed, 10 Dec 2025 09:38:59 +0000 (UTC)
Date: Wed, 10 Dec 2025 10:38:57 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: can: fix build dependency
Message-ID: <20251210-sassy-apricot-toad-239179-mkl@pengutronix.de>
References: <20251204100015.1033688-1-arnd@kernel.org>
 <5de9b33e-6129-4765-95a7-e3e12de1f8cd@kernel.org>
 <20251210-imported-pelican-from-tartarus-c1084f-mkl@pengutronix.de>
 <7427949a-ea7d-4854-9fe4-e01db7d878c7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bprbmtxeie7ybshn"
Content-Disposition: inline
In-Reply-To: <7427949a-ea7d-4854-9fe4-e01db7d878c7@app.fastmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--bprbmtxeie7ybshn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] net: can: fix build dependency
MIME-Version: 1.0

On 10.12.2025 10:10:27, Arnd Bergmann wrote:
> On Wed, Dec 10, 2025, at 09:16, Marc Kleine-Budde wrote:
> > On 05.12.2025 00:30:14, Vincent Mailhol wrote:
>
> >> >  	  can-dev.> -if CAN_DEV
> >> > +if CAN_DEV && CAN
> >>               ^^^^^^
> >> Is this needed? CAN_DEV depends on CAN, so the condition
> >>
> >>   CAN_DEV && !CAN
> >>
> >> should not be reachable.
> >
> > Removed the '&& CAN' while applying the patch.
>
> Sorry I forgot to reply here: the '&& CAN' is absolutely
> required here, otherwise you can configure CAN device drivers
> as built-in with CAN_DEV=3Dy CAN=3Dm, and that results in a
> link failure.

You mean:

| $ grep ^CONFIG_CAN .config
| CONFIG_CAN=3Dm
| CONFIG_CAN_RAW=3Dm
| CONFIG_CAN_BCM=3Dm
| CONFIG_CAN_GW=3Dm
| CONFIG_CAN_DEV=3Dy
| CONFIG_CAN_VXCAN=3Dy
| CONFIG_CAN_NETLINK=3Dy
| CONFIG_CAN_CALC_BITTIMING=3Dy
| CONFIG_CAN_RX_OFFLOAD=3Dy
| CONFIG_CAN_DUMMY=3Dy
| CONFIG_CAN_GS_USB=3Dy

=2E..which works for me.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bprbmtxeie7ybshn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmk5P6QACgkQDHRl3/mQ
kZybWwf9HDCYjsO3ixs2HLq1zjBBx7xBevYHvSy0OVgjv3YUWLmauEOZKSxBhiwr
tCJDzeQHlAfT19wbcVSGcFyAlAQpYuVsz5ITTwTiTxaxZCWChNcy1V/NMye1auhT
Lb9kb/AtgpdC5F/n8ugyrtqxw1TyXYSaTP5d0ym8FNcRbljZdDbny1FGcNSu77Qx
yJODC+mk0V/xZjJVB2qixZLXw1bjMjGLqCcvsEwqgq1KkjqDGube1RP7WHGLH3Rv
uke+0QdKc9g8OIglwsW08V0yYnKA3FP8UJXJhik7+8PAah0wvsQTKSDZI9FS7zrh
qmaygxSWomJD9aeZjkAZiO7rm2jnww==
=rMmc
-----END PGP SIGNATURE-----

--bprbmtxeie7ybshn--

