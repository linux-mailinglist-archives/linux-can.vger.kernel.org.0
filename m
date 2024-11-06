Return-Path: <linux-can+bounces-1911-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0677A9BEFC3
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2024 15:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF598281E99
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2024 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F8C17DFF2;
	Wed,  6 Nov 2024 14:03:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821491DED75
	for <linux-can@vger.kernel.org>; Wed,  6 Nov 2024 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901819; cv=none; b=dWqPZeJBeci6STTdgxx3IuAM2N8q6MFczGMtrvFZtcmuigTRhBYxIx8Hv1Jo1XQULrvaBprrIGjZqIdbcXVluMkU3HHgioICV1lJ3p/UdYoxPQ/2bU5YKHjfNew2/HqWBBdCHpfFjsmG/hSwGs7WVvRDNdDvljuW8p6lIsw3eR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901819; c=relaxed/simple;
	bh=yKnlfEY2XbVSpif5mYgC9WScl5HzhCLSh3qD4He8z1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNw8oHbIaYW2ETviGvZs7+IlwAfAal4d0uWmZr3+jXTmTlO8eEqoBCu72pQThr38ZGE7Fgf2JEiuqv/DUlj+gJxEyj8ho7Li/qKooNHCxWM/2zSRhXkQrcLsh7QXfF1c+XRK3Pf+sJsD40Lud+lZlcg+kY5/z/jAvhAhgvabVd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t8gd8-00033n-2W; Wed, 06 Nov 2024 15:03:30 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t8gd7-002JIv-1t;
	Wed, 06 Nov 2024 15:03:29 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2D72C36C0FB;
	Wed, 06 Nov 2024 14:02:42 +0000 (UTC)
Date: Wed, 6 Nov 2024 15:02:41 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Robert Nawrath <mbro1689@gmail.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Missing CAN-XL XL data bit timing
Message-ID: <20241106-fuzzy-robust-sawfish-17895c-mkl@pengutronix.de>
References: <CAEQ16vpxthctdrpv0kBKEZJA8VNYffjGGPBGBY93RmKDD49bAQ@mail.gmail.com>
 <CAMZ6Rq+9GO0-5BfauX73ReNTn2LzkZP04eGaybS6Vh+t3=Gmng@mail.gmail.com>
 <CAEQ16vokv=Xq+0T=6=e3UMooa_jJYCW-zXWSMKVrRPnM1HoZJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7svskqy3utx2bhaf"
Content-Disposition: inline
In-Reply-To: <CAEQ16vokv=Xq+0T=6=e3UMooa_jJYCW-zXWSMKVrRPnM1HoZJg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--7svskqy3utx2bhaf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Missing CAN-XL XL data bit timing
MIME-Version: 1.0

On 05.11.2024 10:13:00, Robert Nawrath wrote:
> @Vincent, thank you for the answer. Are there any plans to add the CAN
> XL driver and the netlink interface for CAN XL?
>=20
> I use the DCAN XL implemented in FPGA. I work for Digital Core Design
> and it's one of our latest IP cores. I know the CAN-XL controller is a
> rare product for now.

Does the IP core support CAN-CC only and CAN-CC/CAN-FD mixed mode? If
so, an option could be to write/mainline the driver for CAN-CC/CAN-FD
first and than add CAN-XL bits.

This has the advantage that it makes reviewing easier.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7svskqy3utx2bhaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcrdv4ACgkQKDiiPnot
vG+iBwf8Ci3z7e3lGb3WfRYWbt+3QdClgkKs3LfTCyTwnbDQeoK5ZOQSlaZpphiy
Be7FKssgvBQdNNCgItuXrSGySZkGRDit3NyK4OBcLUjxKCIx7ilYi9E+q20suLEW
6cF0O0RpXDwaXTKlbGCLMI9CiShU75mpx7ptTSV7UkHa0nZv++7mgksil5KDpTro
E+sS1Cqy8LUVBDCeKYNaLb3otROMBTOFRHyAtZSR6LHTo6tr3e1r7uTZ4ilaLeqM
Irq0l+vD1kwihgSKY2vWlgjdudVP4/FUmgFMWmyPOrNAKmcbFRoLE6RKB8Bkoa+q
NPuyozcC0Ch6UzBPfFUAF9mwZL26bA==
=znon
-----END PGP SIGNATURE-----

--7svskqy3utx2bhaf--

