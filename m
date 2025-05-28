Return-Path: <linux-can+bounces-3715-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 681AFAC6395
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 10:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB11A20D12
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D44E20AF67;
	Wed, 28 May 2025 08:02:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8681FE461
	for <linux-can@vger.kernel.org>; Wed, 28 May 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419377; cv=none; b=qxntwaKqKFlGF8oC+rLnVX1y+s3qOdCoNT6SlAnkmkPr5xwSLk0DVtQVgqcVPaj/GKOAV38CFuuWEpa/8+usaRX0EFTf1xb2BTHqa8nOOakT3yEwcuVNsReqQp+HbGM6CECImNzeDYtRLACOGQ9WAv4V+1hFoiI4V/uOBqBvG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419377; c=relaxed/simple;
	bh=4vuYtXvhHNuLBCJnQpvdzV2zOiqxF5F+eBglupaNyNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsKGv/JDKkqZWVjhVBni2LyR6Q4VE7aL2y8epjzDKsjNtiQYd6Dv8sdvYKue0UMWGd4t/Nk4jCfHKCUdAM4AsuZmGUQ+TtNxhdzeoq3FwlNdSLoVv0o3Aa4pAt+JjUDjiQ6pT4HAxovzzuFW/t1wcWI68IR1496B4tLMlGhYsLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKBkO-000832-RZ; Wed, 28 May 2025 10:02:48 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKBkO-000YBn-0v;
	Wed, 28 May 2025 10:02:48 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0183D41B13A;
	Wed, 28 May 2025 08:02:48 +0000 (UTC)
Date: Wed, 28 May 2025 10:02:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org
Subject: Re: Latest patches - Re: CAN XL netlink AIP status
Message-ID: <20250528-pastel-quoll-of-genius-d1423a-mkl@pengutronix.de>
References: <AM9PR10MB4184729E14AD5C05ABC65718D496A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <1c502316-ddee-4f12-b0b8-3725cc522591@hartkopp.net>
 <AM9PR10MB418448751B1DA83EED7F50D4D498A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <63f2f51e-3fbd-4c8b-b7e4-29cb55246eaf@hartkopp.net>
 <AM9PR10MB41846346BC291F7CFE2CB71DD498A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <49245439-9822-449d-bf2c-5626349d909c@hartkopp.net>
 <20250527-lilac-panther-of-destiny-a13500-mkl@pengutronix.de>
 <AM9PR10MB4184E0842D24A4D7A2FEE09BD464A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <20250527-glistening-dog-of-apotheosis-293bd2-mkl@pengutronix.de>
 <04a7058c-95c7-4adc-a447-423aec0e0077@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zc3spihl5ohcuxv4"
Content-Disposition: inline
In-Reply-To: <04a7058c-95c7-4adc-a447-423aec0e0077@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--zc3spihl5ohcuxv4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Latest patches - Re: CAN XL netlink AIP status
MIME-Version: 1.0

On 27.05.2025 21:55:52, Oliver Hartkopp wrote:
> I uploaded the latest work on this GitHub repo where you three (in To:) a=
re
> requested as collaborators:
>=20
> https://github.com/hartkopp/canxl-nl

Thanks!

> Additionally I will send the patches for iproute2 and the Linux kernel he=
re
> on the mailing list for further discussions.

I've imported your series [1] to a git tree, that make development
easier than working on patch files.=20

[1] https://lore.kernel.org/all/20250527195625.65252-1-socketcan@hartkopp.n=
et/

The branch is called b4/can-xl and is available on my git.kernel.org accoun=
t:

| https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/lo=
g/?h=3Db4/can-xl

Oliver, regarding the series, I'm missing your Signed-of-by for
Vincent's patches.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zc3spihl5ohcuxv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmg2wyQACgkQDHRl3/mQ
kZz27wgAmtdRl47y9do0SlAg7zj6RvKIqRAjaHXLiCNPG0mTJ4IlCcS6mXCIa4i8
RoI+gddxuup/FfdbrPD093ENc2gYjTD5lm4ViIv0Cl0FNKzC6ayuivIDePiXT4AS
8MUGD4MpGfld53I+ImEfdlZERaMaT9XXscCBTpUoMGpwk4PvvHqYsNr1b0m2DToX
Y7TRizVAciyniGFPM66uVkvKTIrFFshk5YNu/7uoJeBDsAFycNJVhn4QcWp1dD0s
v8I6qsx17ZpDWUg2bFDEBu85ZZ0/R5hHC1qhIzj22yxqjPE/5O63JufyFgoLplD7
5xNJkiWNY6pPhlFbVqsbeZIUKmj5lQ==
=cd8v
-----END PGP SIGNATURE-----

--zc3spihl5ohcuxv4--

