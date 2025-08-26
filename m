Return-Path: <linux-can+bounces-4378-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6F9B37BE9
	for <lists+linux-can@lfdr.de>; Wed, 27 Aug 2025 09:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B621BA1B8E
	for <lists+linux-can@lfdr.de>; Wed, 27 Aug 2025 07:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1943128C6;
	Wed, 27 Aug 2025 07:37:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA14318153
	for <linux-can@vger.kernel.org>; Wed, 27 Aug 2025 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280251; cv=none; b=mvu0Ihl0FVz819seXAdVxEfp1VHwiJpbB82oMJZby8AaoZIpiieF4Ptjd4KeXGTOVvAu+SxEsj8VNfAubG2cFRpVqEqCvalYZuoDPGzDBEO3j+aK1cRhhveqy4876C9rfFy+7xH96fR7KhWwOIiIcK5vibhZ2wG+yW5TfbwwV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280251; c=relaxed/simple;
	bh=l6k24yGZEM6cLCEawNuldJjag3rOVttP8oQYR6PamAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNSUIpHMAJIDrbLI7kMXF9q/WN5/Gmrq0ZRxSCngWqeiDxdHq3tfemOPB9h0c4kYT+ZfyDBxnCgSaP71uIm6Iqbb1b7R7zgmEZ3cUNGJqUTatIFMFacucyAgii2h1z9vrVe3TrNvAINkIIVF4etIPYT+tP7bYnZDl3KhvkehxFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1urAii-0007Bv-7W; Wed, 27 Aug 2025 09:37:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1urAig-002MGj-2Z;
	Wed, 27 Aug 2025 09:37:22 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C3EF345E212;
	Tue, 26 Aug 2025 08:44:10 +0000 (UTC)
Date: Tue, 26 Aug 2025 10:44:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, 
	Xichao Zhao <zhao.xichao@vivo.com>, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Subject: Re: [PATCH v2] can: m_can: use us_to_ktime() in m_can_set_coalesce()
Message-ID: <20250826-busy-masked-deer-1ef75a-mkl@pengutronix.de>
References: <20250826025131.112900-1-zhao.xichao@vivo.com>
 <735d62ba-51b5-4dc2-a8e4-0701ffb01f9a@web.de>
 <6b6ba240-e13a-4e99-ae76-500a7b530238@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="izepbhrtwhxojv37"
Content-Disposition: inline
In-Reply-To: <6b6ba240-e13a-4e99-ae76-500a7b530238@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--izepbhrtwhxojv37
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: m_can: use us_to_ktime() in m_can_set_coalesce()
MIME-Version: 1.0

On 26.08.2025 17:38:17, Vincent Mailhol wrote:
[...]
> TLDR; the v1 was better than the v2. Speaking of the format, the only nit=
pick I
> might have is that after your change, the code fits in one line without
> exceeding the 80th column:
>=20
> 	if (cdev->rx_coalesce_usecs_irq)
> 		cdev->irq_timer_wait =3D us_to_ktime(cdev->rx_coalesce_usecs_irq);
>  	else
> 		cdev->irq_timer_wait =3D us_to_ktime(cdev->tx_coalesce_usecs_irq);

Good idea! Fixed why applying v1.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--izepbhrtwhxojv37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmitc9YACgkQDHRl3/mQ
kZzX7gf/a/n9+IsQBHDPrhkzTsFj0AWEc9vpGBDBBNAKog2p9Yjw0jX9YwT2JJjc
534gE5V2eRY0XPIj8uz2z1ByoLOVRTcJwBPsuDGb8tLpGyBBNadhG5mANrUtR4lP
zNb2cHuJKmnQ59BQRP0ZTrngp+qnkTwqLhbpw0GNAoyuC+HpzOMVzGzmfsbP82ll
KOtlB9iy+HsodSJQlEsAnWda8oZOKsQ/KoBIsjviIKDoRlppOLooJ+bw20hNsAnU
r8pgRwu3jtLIJdDIVQx6cLj3WVb+F9aP3cv4fYj7b8zhU+txjs8jIFPg7Sw/kn+H
ly3WVq90KUzSwXiCtUBBF1KigPjFsg==
=YbRe
-----END PGP SIGNATURE-----

--izepbhrtwhxojv37--

