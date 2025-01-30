Return-Path: <linux-can+bounces-2709-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFE6A22936
	for <lists+linux-can@lfdr.de>; Thu, 30 Jan 2025 08:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40977A28B2
	for <lists+linux-can@lfdr.de>; Thu, 30 Jan 2025 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E2AC2FB;
	Thu, 30 Jan 2025 07:34:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6221A8F9A
	for <linux-can@vger.kernel.org>; Thu, 30 Jan 2025 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738222471; cv=none; b=Y8W3tAAWkv2cYoIGUpGORyiAzkz7SjWBewcJ63avi1lywCqiUKd7RYUm2sWfYOP4RdCTfeT6jDCK0VqjN/FDn40M09dAalap5cCMJZQOYKJZhumwuWud6lBiw1D/FZ1nGzCRKmUGxRWjpku33L/Wh5sNvzLiLhM8Y6ZIPsWrms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738222471; c=relaxed/simple;
	bh=5q084CDknXT9pHSEwM3Msyk81pJ6YeV/mJcuIE2Nbrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKxKwFUNCxLgeXwfYpWgWhOJGgoiCCAGkat7vdfz2ohUmhxJLLmbNwPNmOUaKfx9MgpXCN9St+3Cr3gkXaX/fz5ES9iMEe5Y4Kzi0GZUlbtbGOcJOZPpGIxiVvqgem8i9rwQBB430cWF9QMXMra+/+CQicut2oQz21UZTgPnGLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tdP46-0007LC-8p; Thu, 30 Jan 2025 08:34:18 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tdP45-002axN-2Z;
	Thu, 30 Jan 2025 08:34:17 +0100
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:29d0:f16a:75e0:9efc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6816B3B4EF8;
	Thu, 30 Jan 2025 07:34:17 +0000 (UTC)
Date: Thu, 30 Jan 2025 08:34:16 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, 
	Robert Nawrath <mbro1689@gmail.com>, rsc@pengutronix.de
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
Message-ID: <20250130-solid-dolphin-of-sufficiency-a5b014-mkl@pengutronix.de>
References: <23c914cf-0af2-4619-9f83-e4b6339ef65f@hartkopp.net>
 <12e013c2-d6ff-42b2-91ef-921db4e7ee0e@hartkopp.net>
 <77331a33-ac82-4cfb-9881-159d6d2daf58@hartkopp.net>
 <CAMZ6RqLi1oywkSZ=pVFnV04efwk8mJWmwP+FzSyMknR2d+9=RA@mail.gmail.com>
 <8be877db-028a-413f-b55d-71311e0c88c9@hartkopp.net>
 <c4771c16-c578-4a6d-baee-918fe276dbe9@wanadoo.fr>
 <2bd47866-a995-4359-9639-724cd8a90a43@hartkopp.net>
 <4acc968e-d30e-400f-bc40-d4fc9f5299de@wanadoo.fr>
 <42b6acd2-dc9d-471b-b273-9b8094840935@hartkopp.net>
 <68e8c449-a6ab-4958-af3c-852ece2694c2@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ewltgwrobbkplijx"
Content-Disposition: inline
In-Reply-To: <68e8c449-a6ab-4958-af3c-852ece2694c2@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ewltgwrobbkplijx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
MIME-Version: 1.0

On 30.01.2025 14:42:59, Vincent Mailhol wrote:
>   - CiA 612-2 will be published as ISO 16845-1 when ready.
>=20
>   - The only method to get access to the current draft right now would
>     be either to become a CiA member or an ISO Working Group 3 member.

Let me see what I can do :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ewltgwrobbkplijx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmebK3EACgkQKDiiPnot
vG8EMggAh8ernYFB4uA7Qg5XNAQ3qBLIV4VlSbYvorUTmZ8sZ3/uZ2H3jxDPfyAf
boU1nRANHdkGDNtShFvAY8VKXRKqOV4Yfm/kANejQSY59MCCOHIiLrvVnmpdzNxc
a0AMGv71alwXggKvfLFsYZp2zzNPbVXZ48HLOb1E+i2BUk735YugI56ENzsbMnTk
HUptmYk4MFd4FiQiRXucXtH9JgzJ7H3LPU0pdPtjCXa2OMLs7DGgjjJW1wjX6sAL
X9wZo//yzCCKqEKeLitJCtp/fUqdQ8vAbBFRslNrfQ0Z1nr7h0NdUm0Afwr9tqdY
lQcetKvgaw9KqaYoFPuIymeMn6BIgQ==
=o9cE
-----END PGP SIGNATURE-----

--ewltgwrobbkplijx--

