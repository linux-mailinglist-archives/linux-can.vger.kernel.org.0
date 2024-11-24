Return-Path: <linux-can+bounces-2206-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8861C9D7538
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 16:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4862873CD
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73887187555;
	Sun, 24 Nov 2024 14:31:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9355F166F29
	for <linux-can@vger.kernel.org>; Sun, 24 Nov 2024 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732458691; cv=none; b=RAouJXicDd/tsSree4WVj7XrQoGSiqeTs9G6JuhoPxIObf0dKwiH4ooK/+RWOyQFZNOp98CoV8+Za8t/V62O2ajygbDI8soWal0uOFvqpikqGssI3SkPSE2/GhutoJZPcIlKOfW35P10sZSjgijNBBTz/UKbMwZ+aGDWvTzPM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732458691; c=relaxed/simple;
	bh=/59a56Or+HC1qu+o35+V39sLsLBYoYpmr03qKThdn5Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cng1Tb1gcdwqDSV+zNbGno/A5Ib0MRcnF57SaLsl6A0VQkvm0GP4/7FaGgdLb1NUGS0xIL4WcCJNox3ceQrkT3Bl4cbybBpc5uBWDOOyRc+QK0JltEU1HL2+yASjVvBAKdd/xaQvZ3Pomfd5Pb1SPp43bw7n7p2g7C+oSO8tj8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFDe1-000665-Kj; Sun, 24 Nov 2024 15:31:25 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFDe1-002PKn-0y;
	Sun, 24 Nov 2024 15:31:25 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E6D8937B517;
	Sun, 24 Nov 2024 14:31:24 +0000 (UTC)
Date: Sun, 24 Nov 2024 15:31:24 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org, mw@iot-make.de
Subject: socanui
Message-ID: <20241124-solid-micro-hummingbird-776382-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tiahrbzorx5yes5m"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--tiahrbzorx5yes5m
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: socanui
MIME-Version: 1.0

Hello,

I just stumbled over https://github.com/miwagner/socanui by Michael
Wagner (Cc'ed). Haven't tested it yet, but it looks awesome.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tiahrbzorx5yes5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdDOLkACgkQKDiiPnot
vG9Mhgf+P+9mGd84mpPU+M00f5qfxSswhYxiHxzvrKnfP1ZhwT7xRmA+O2JGzCMl
tWzUP+p01kOzSuMDW7/GzBV3P7ttEmsUJwUAO7PZF8QwJoIw+8bYOlkBHIb3pYP6
h4GbyNAZFnBTF3/o9ywcxUF2arf/KUPk+vTy+bU/u+GQuYHILo8DM8Je3HWQabVq
BlTlUVsQy7axXi6z0wTHvnkHLEa+YkT+4ookQm34iDq56ypNJ4yXZNn2j9O5YckH
Oi0/KaMvrEh1wsr7U1nvoFn/HK7Y7/chbXv78rssOLBR0UcYEH2lTnc5fnO/ZKDz
9GTVXJZV+PCb3TZIJ0VXkxg3UcCDxw==
=W74W
-----END PGP SIGNATURE-----

--tiahrbzorx5yes5m--

