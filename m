Return-Path: <linux-can+bounces-5101-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C76E5BC3B6A
	for <lists+linux-can@lfdr.de>; Wed, 08 Oct 2025 09:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABE074FA008
	for <lists+linux-can@lfdr.de>; Wed,  8 Oct 2025 07:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57832F49F9;
	Wed,  8 Oct 2025 07:36:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9E2F5A1D
	for <linux-can@vger.kernel.org>; Wed,  8 Oct 2025 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908998; cv=none; b=bhzwr0KCpZv9x4s1F2sFren/FxsivYdtwzuJlKr06JK9pl8VeyGq044EPqc13bJp6L1LG4sOGmJY1FG+L7WGOp9POvtxZu23xMNTWJvrr+qqJ4ywR4ROnFYvoqr6epEMv9+pKT10heiUJVaWJyg+inkA7RSoIpP9V6QdrTdUiA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908998; c=relaxed/simple;
	bh=ZvB41AVtgiRBPBxAsCGR9bmG3uM6Im22kHN3Yl3n6xo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h4NvY7DmlE96ZmJ4mC/smoKgwaomWtmavT8ujbdppekMJWpB0eRq41MJFJnKwnDnGzi3blIeBBO9xAW24VgiVAhCt26veZzHtILkiMLNIv/bbM0HeyvziZ3c9MeTs66+QIfhFmFIsPIdNIYfzEDRtNVU3Z8gssC3kdUSR//EfyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6Ois-0000tP-PC; Wed, 08 Oct 2025 09:36:30 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6Ois-002X58-1O;
	Wed, 08 Oct 2025 09:36:30 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 64EDF481B4C;
	Wed, 08 Oct 2025 07:35:11 +0000 (UTC)
Date: Wed, 8 Oct 2025 09:35:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: m_can and old email address
Message-ID: <20251008-invaluable-amigurumi-deer-76c105-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fojl2vlyu7tltinv"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--fojl2vlyu7tltinv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: m_can and old email address
MIME-Version: 1.0

Hello Dong Aisheng,

someone with the name Dong Aisheng, but a different email address is
listed in the m_can driver:

| drivers/net/can/m_can/m_can.c:4://      Dong Aisheng <b29396@freescale.co=
m>
| drivers/net/can/m_can/m_can.c:2559:MODULE_AUTHOR("Dong Aisheng <b29396@fr=
eescale.com>");
| drivers/net/can/m_can/m_can_platform.c:4://      Dong Aisheng <b29396@fre=
escale.com>
| drivers/net/can/m_can/m_can_platform.c:239:MODULE_AUTHOR("Dong Aisheng <b=
29396@freescale.com>");

Is this you old email or is this a different person?

b4's --auto-to-cc feature regularly picks up that address and mails will
bounce. I would like to update or remove this address to get rid of the
bounces.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fojl2vlyu7tltinv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjmFCsACgkQDHRl3/mQ
kZyc6wgAieEXLW0A8Ofeb0kOf/pu++x+LyIeRS2+MurHz0FPoctvZy5p1hlGKnrt
pf3lh7rEyGZjVbbo50o48MOq3Z80uzEocT7gR1agvLC9/6gu2uE1EGJIlZp8eXg0
5AKgyybeDhtaXp4c2/VoAalgbTQbq5/sQzBis759xHofeuWIg4YjFvnXieiwBefH
XOeWRmY1XHudJ53PONgmp7NPvcpbLmn/6arl7tBBLK4RadUlD33n5DLKrWhL36/9
PPNw5vNlYAulZg1M64GbTgcrx17VbnJ2u433+ATrguwDqLE/xPNjZGdSOnVh31dh
SIVqZxobXE31hMeN0EP7dBL6zJmciw==
=tFAP
-----END PGP SIGNATURE-----

--fojl2vlyu7tltinv--

