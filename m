Return-Path: <linux-can+bounces-1552-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1C3983D5D
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 08:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC4D1F23EF0
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 06:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190698F7D;
	Tue, 24 Sep 2024 06:51:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D05A79B
	for <linux-can@vger.kernel.org>; Tue, 24 Sep 2024 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160673; cv=none; b=R5hg2W8XW82ADHUu6XiveJ3GgD8epyfXX9Q/H8gGGnanXsDkbc9LZeQ8+9D4+WaKCxOqPiZ9eEAP+sM6TbG14QyX5ipyKE65qQaRM5Cx4I3IRHHllspgn/jx66tpz1AKW/+3S3Ig21AbTVSYkMuZyaE8jLtZNs0dYvbVZAzL+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160673; c=relaxed/simple;
	bh=15eo4TyxcJOP/+fo7M57tCN8fQGnDjXxQdyb0TOAAKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fXHkBdtmV0Zhbee308ztex3X+1lFTy5yDD/+m/xLwbt7Cs4afTicUkpum+MUE5kx1gpsX51C68tv688dFpeceNbYbi/UtuPTcFDhrLnbPkdr4unZ0LSfSqQyhT4xzclsoMltXO20ojOnA41vfsP6MVvv/nuYELlnCVaiyHy7vT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sszO3-0003Gl-9Q; Tue, 24 Sep 2024 08:51:03 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sszO2-0018Ri-IY; Tue, 24 Sep 2024 08:51:02 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C1AF434198E;
	Tue, 24 Sep 2024 06:51:01 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:51:00 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, 
	Francesco Dolcini <francesco@dolcini.it>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-can@vger.kernel.org, 
	Thomas Kopp <thomas.kopp@microchip.com>, kernel@pengutronix.de
Subject: mcp251xfd: please add to the stable trees
Message-ID: <20240924-truthful-authentic-basilisk-aaab90-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mysrjg5j2zurblds"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--mysrjg5j2zurblds
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello stable-team,

Francesco Dolcini reported a regression on v6.6.52 [1], it turns out
since v6.6.51~34 a.k.a. 5ea24ddc26a7 ("can: mcp251xfd: rx: add
workaround for erratum DS80000789E 6 of mcp2518fd") the mcp25xfd driver
is broken.

Cherry picking the following commits fixes the problem:

51b2a7216122 ("can: mcp251xfd: properly indent labels")
a7801540f325 ("can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into=
 mcp251xfd_chip_start/stop()")

Please pick these patches for

- 6.10.x
- 6.6.x
- 6.1.x

[1] https://lore.kernel.org/all/20240923115310.GA138774@francesco-nb

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mysrjg5j2zurblds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbyYVAACgkQKDiiPnot
vG8o2gf/c9vzrwNc60LjRrnQBHLiIydOJmdbOarFLzeu1EkOPfJ13KGZwyrvtSNw
OJEJ/XPMg3meRj/cy5+3Q0UhhT8k+zxoirjyTNMcda9TVBLUA9w5lHtllKnjSks5
9IXkemuCYieSrvo5xIfO7SZcGcFhq5N6diIUJ6XX5A2ls9s3OLIN8p4lq42IQmEi
INhpJqeA3IECRnTJmMM1coMiH/Kwe7tE8XwWmQdtqIShrH3fUWGqpLT63LZJca2F
jDJ+5zmBlrK09INm53QO2iTZzlADXjxKt/Ibxwr2SuMotbf8mSO1D+E3prQiCdui
0dSznCXxwlgIUEhTMeYZiWTQjNVDGA==
=7zU2
-----END PGP SIGNATURE-----

--mysrjg5j2zurblds--

