Return-Path: <linux-can+bounces-4565-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6719B4FAD4
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 14:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840A05E164A
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 12:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11821322C63;
	Tue,  9 Sep 2025 12:29:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EAB334720
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420953; cv=none; b=SyLShUzrKJ90tNeMvRhHPda0snVyNxVHd/57/zQIFku8bRdz9yRw9tUBKjnGSpCWGbcLIU0Op0tdKarBvDFQXqn3ZkB4bodPo5zyAnsJokqG+8jdead+unYtSwokDkKtPfYZl2SC1OPxHMqp85zoovC9PFl9xKfm10yG/1ch5UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420953; c=relaxed/simple;
	bh=zoA+6GRK757ofKkAJffnVbvBntGS22T8pEj03B31h8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SO8WpAbFE6eygRwZ/s2mpaWfKf/ySqLvO+CkESeNyLVpB39F0QYgfQaaR8lMcTrld/n13JBGia+zl3OwYmy5oTf1Ipl+RLEIK4L3OOc0/l8rMQrwa0U017oAIp7nneTqgVGo1gj76UDWYZuhSD33/m+4QJTLRCaawnv9r3TMo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvxT9-000457-W9; Tue, 09 Sep 2025 14:29:08 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvxT9-000Pz5-2K;
	Tue, 09 Sep 2025 14:29:07 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 63C76469F17;
	Tue, 09 Sep 2025 12:29:07 +0000 (UTC)
Date: Tue, 9 Sep 2025 14:29:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chen Yufeng <chenyufeng@iie.ac.cn>
Cc: mailhol.vincent@wanadoo.fr, dario.binacchi@amarulasolutions.com, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH] can: hi311x: fix null pointer dereference when resuming
 from sleep before interface was enabled
Message-ID: <20250909-premium-lobster-of-happiness-e39176-mkl@pengutronix.de>
References: <20250906075019.124-1-chenyufeng@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="upnumg63pywgaioh"
Content-Disposition: inline
In-Reply-To: <20250906075019.124-1-chenyufeng@iie.ac.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--upnumg63pywgaioh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: hi311x: fix null pointer dereference when resuming
 from sleep before interface was enabled
MIME-Version: 1.0

On 06.09.2025 15:50:19, Chen Yufeng wrote:
> This issue is similar to the vulnerability in the `mcp251x` driver, which=
=20
> was fixed in  03c427147b2d("can: mcp251x: fix resume from sleep before=20
>  interface was brought up").
>=20
> In the `hi311x` driver, when the device resumes from sleep, the driver=20
> schedules `priv->restart_work`. However, if the network interface was=20
> not previously enabled, the `priv->wq` (workqueue) is not allocated and=
=20
> initialized, leading to a null pointer dereference.
>=20
> To fix this, we move the allocation and initialization of the workqueue=
=20
> from the `hi3110_open` function to the `hi3110_can_probe` function.=20
> This ensures that the workqueue is properly initialized before it is=20
> used during device resume. And added logic to destroy the workqueue=20
> in the error handling paths of `hi3110_can_probe` and in the=20
> `hi3110_can_remove` function to prevent resource leaks.
>=20
> Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>

This does not compile.

| drivers/net/can/spi/hi311x.c:902:8: error: use of undeclared label 'out_f=
ree_irq'
|   902 |                 goto out_free_irq;
|       |                      ^
| 1 error generated.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--upnumg63pywgaioh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjAHZAACgkQDHRl3/mQ
kZzIqAgAtFFQuAZvDbTCnwI/h6xANVlgOdqL7UglckAT/bCXqTHP3Xia8MgkGly3
l/EOU9OhBrSZNfmlTvOtSdq7BN+WOqbjwjtpWzezjKGZk+TZGq1PydcXEeKMkYEr
GpRw7X/IepirdUcDF8iqHIM6TQm39FnRqc7yGUu7Eo0KGw7/ZQVSag7pJSYgN4XJ
ynm2Rq5MuF7osOE/SJxv+io0mHJEd241eZ4tB6Hu6hIcAzTUgojf666N8Cn3iQ2i
ZZ+1F945UGE4NQyRYbYo17YB3pP+QyTJxlVN0PfdEGVTRw+Xx4WWjGvkgpofdM3f
IUpEmOc2pOpOH1dGdVMa4JVbDsLpbg==
=NwLj
-----END PGP SIGNATURE-----

--upnumg63pywgaioh--

