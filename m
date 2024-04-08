Return-Path: <linux-can+bounces-426-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92E289BD6C
	for <lists+linux-can@lfdr.de>; Mon,  8 Apr 2024 12:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33987B20F8B
	for <lists+linux-can@lfdr.de>; Mon,  8 Apr 2024 10:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784495F865;
	Mon,  8 Apr 2024 10:41:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B017D5F861
	for <linux-can@vger.kernel.org>; Mon,  8 Apr 2024 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572893; cv=none; b=gnSAftCLgL4QpzWXcpSJlNgq9NsBHYoW5imFB0OJiJZivRg8k5XnRWJruKv997tAp7PCSFQEEsFUevT6kcM8KoETJ+TnH9nr0b+PtQbZEHEgw+AOADt9g/pShOkpw+WWbATWUOVd9uzHp+/c2xaLnHgxrMhsqTd6qZOjcHwUGp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572893; c=relaxed/simple;
	bh=Dkm+loHCWuR63H0BRigmjl6rI+ouRg/iOK5pg3HSZUc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ixMWpRV/U1wDNsILlp8kh2I55qkQQxcuuXeHBE9M9/1PRtnzBfOsq3+bMWlPSvIM9pLxgPBMeByk0AkGBRDMFiWGldkcVFHfjFPaqmms6QfQWefindQjNi9OqkIbQkX/WrrBtkm8W0TbkBjDxcxJKGbVTtKRI5TMX2uwQMgIuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rtmRL-0005WG-NW
	for linux-can@vger.kernel.org; Mon, 08 Apr 2024 12:41:27 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rtmRL-00B5yM-AS
	for linux-can@vger.kernel.org; Mon, 08 Apr 2024 12:41:27 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 06FBF2B3E42
	for <linux-can@vger.kernel.org>; Mon,  8 Apr 2024 10:41:27 +0000 (UTC)
Date: Mon, 8 Apr 2024 12:41:26 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org
Subject: Embedded World 2024
Message-ID: <20240408-gusty-december-9ad3ad702781-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nhtyhzn2p6pysgij"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--nhtyhzn2p6pysgij
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

pretty short notice, I know :). I will be at Embedded World in Nuremberg
tomorrow, Tuesday 09.04.2024. Drop me a line if anyone wants to talk to
me and/or have a beverage of your choice with me.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nhtyhzn2p6pysgij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYTydMACgkQKDiiPnot
vG++rAgAjSEviazs8wEKZdRLuBohi9R3iXymhZiLskdQWKliVBNvq/Ak1U7zuDY/
9sKoATE/VPfi3ZOtwRBnYwVwPq8HK8ZJSlmrvDl8Fqk0GwCOzOE6tIOpCmBnkQKo
N31YfVuc2JSoZGRZBk6/brtIsvps9J0P81+xP54r0HWaTjCozJsKZK2ZjFdawUpj
3hwmsocVGSqb3THf64aiZ7oykMlBSQ6nDSnEgMjMG3CEYTL+rBz5dierv1SxlgzQ
Fy6Jhpqs2BFP0SPATG8zL2e9K1ZA2oHe2Fyzeh+XxGTdtp6e+MbS6/m7HuZffGOB
dO3ZrV9z9xc3MWbdM485oYdnZYqwqw==
=3DlF
-----END PGP SIGNATURE-----

--nhtyhzn2p6pysgij--

