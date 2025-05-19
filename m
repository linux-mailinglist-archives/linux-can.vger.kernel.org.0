Return-Path: <linux-can+bounces-3578-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F3ABC1B1
	for <lists+linux-can@lfdr.de>; Mon, 19 May 2025 17:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA0918903CD
	for <lists+linux-can@lfdr.de>; Mon, 19 May 2025 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13C42820C2;
	Mon, 19 May 2025 15:08:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB29280CFF
	for <linux-can@vger.kernel.org>; Mon, 19 May 2025 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667307; cv=none; b=Ie4pirLR6R2xef4NW5sztayfnkEXn2b+S7jkkBvh2tzhkoNV7IBS6RxsDhv/yXNPdRVWFatQSRyOmgwCwJ/JvKJAPH7IDbgEPXiiv8hz4wkCgkZGT/rBkdsDFyPdBCbzfLCBUP8OevH0HbXt7pS3xY9KQ0wMetehh4B7xJQoMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667307; c=relaxed/simple;
	bh=in27uqZLQz3oYiT+xLQ4jtUuDDaoJPU98G+tKiMg4sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dssdz+oNElks5J9u1JKPJ5s/DLvliYoH8y/W9nCqAW57ra9Y89BIOHRmh5Wv2I2tF5wn+8T8DUSz9qglillTbpEGqI7paGcAEJIv2GgVWVaVHV0RpRK5gIVKfdDioI8DuQsJvqCwdAUWdzomxecXgX9X//XL4aLeHws9vo37LXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uH26B-0004nx-Fs; Mon, 19 May 2025 17:08:15 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uH26B-000GgT-0D;
	Mon, 19 May 2025 17:08:15 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009:2000::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 90EF0415305;
	Mon, 19 May 2025 15:08:14 +0000 (UTC)
Date: Mon, 19 May 2025 17:08:12 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, 
	Anderson Nascimento <anderson@allelesecurity.com>
Subject: Re: [PATCH 1/2] can: bcm: add locking for bcm_op runtime updates
Message-ID: <20250519-whimsical-asparagus-quail-7b8775-mkl@pengutronix.de>
References: <20250519125027.11900-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qbt2cuv26hmyfo4y"
Content-Disposition: inline
In-Reply-To: <20250519125027.11900-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--qbt2cuv26hmyfo4y
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] can: bcm: add locking for bcm_op runtime updates
MIME-Version: 1.0

On 19.05.2025 14:50:26, Oliver Hartkopp wrote:
> The CAN broadcast manager (CAN BCM) can send a sequence of CAN frames via
> hrtimer. The content and also the length of the sequence can be changed
> resp reduced at runtime where the 'currframe' counter is then set to zero.
>=20
> Although this appeared to be a safe operation the updates of 'currframe'
> can be triggered from user space and hrtimer context in bcm_can_tx().
> Anderson Nascimento created a proof of concept that triggered a KASAN
> slab-out-of-bounds read access which can be prevented with a spin_lock_bh.
>=20
> At the rework of bcm_can_tx() the 'count' variable has been moved into
> the protected section as this variable can be modified from both contexts
> too.
>=20
> Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
> Reported-by: Anderson Nascimento <anderson@allelesecurity.com>
> Tested-by: Anderson Nascimento <anderson@allelesecurity.com>
> Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to linux-can and added stable on Cc.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qbt2cuv26hmyfo4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgrSVkACgkQDHRl3/mQ
kZyxzwgAhjfeRSFy3eleB4HSqPsg8RMu6KVkWKEd7oCs22VWCJ/zzCsYim5rQZ5H
izzCFuLBPo179/7gzpfdXThWk7FCe83GVnZc6XhRYW9bTgu5iKjwLAw1ItKOQDws
XgCY4ndmzBAJ7wkna75w5jvwokBaz+F/s/lqoqoTUg94B+8w0AMVSChgAy/n8n9z
Asy9ZucswXMDCTNC5dsHZJw4Hwhdl3ZXXn4Q9NRKSF9lWb3usRPifbAJvrvhs0bh
yieQtizGpeAxJMf7DpKenfeyImdbHMBP8pSRWAPjw8AFc2vxUyYlWr9enr1ZA3wI
9ZLEhu+cYf9nVClvLLtk3jWUe/bJMA==
=hOhf
-----END PGP SIGNATURE-----

--qbt2cuv26hmyfo4y--

