Return-Path: <linux-can+bounces-2679-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC51A19FFD
	for <lists+linux-can@lfdr.de>; Thu, 23 Jan 2025 09:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6124916A879
	for <lists+linux-can@lfdr.de>; Thu, 23 Jan 2025 08:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11C320C008;
	Thu, 23 Jan 2025 08:38:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830F202C2B
	for <linux-can@vger.kernel.org>; Thu, 23 Jan 2025 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621493; cv=none; b=C0nfkWzLnyLHmdzCPZ6h6CfGUB6ASn0LbESZYaGHNZ4RDiNtTRYMU2t/aUldvml13hyn5etYc9+P6/ktiqjr5giYFLxOTLRatDjhUkQIMY2iWlJKbNjPYHnYy1z0Oi4ODqyKGdDjwz8iFqF8FDiomuivw7u9w/lpuk/L6HKKQAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621493; c=relaxed/simple;
	bh=NRiffExoiBTywk957KDVuy9EQ+pNNEaSF22eieHGcFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNs7sUjZjVrwA3uaKYK9zfQQBF8m4+512l+9Qn0Z14LRm2eVYcnXHZyu1F+SUtiROgQMgrYgxrDEGjivrooW5fk0Dvy0G65NhGTtGiv+awI06Fv+Oa36C1QzKsDvOe08vAgB6aMpDZGEBHGChX1z0nHEVgJ6vmzJ6+vp24jPB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tasim-0003Is-5K; Thu, 23 Jan 2025 09:37:52 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tasih-001Qgl-0w;
	Thu, 23 Jan 2025 09:37:47 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E101B3AF428;
	Thu, 23 Jan 2025 08:37:46 +0000 (UTC)
Date: Thu, 23 Jan 2025 09:37:45 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
Cc: socketcan@hartkopp.net, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	shuah@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@vger.kernel.org
Subject: Re: [PATCH] documentation: networking: fix spelling mistakes
Message-ID: <20250123-gay-burgundy-swan-12800c-mkl@pengutronix.de>
References: <20250123082521.59997-1-khaledelnaggarlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h5fwl7em2i4tyu2z"
Content-Disposition: inline
In-Reply-To: <20250123082521.59997-1-khaledelnaggarlinux@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--h5fwl7em2i4tyu2z
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] documentation: networking: fix spelling mistakes
MIME-Version: 1.0

On 23.01.2025 10:25:20, Khaled Elnaggar wrote:
> Fix a couple of typos/spelling mistakes in the documentation.
>=20
> Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Feel free to take the patch via the net-tree.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--h5fwl7em2i4tyu2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmeR/9UACgkQKDiiPnot
vG9f6Af/anfRx98VLLIqnWOsh3E2GomHJIto2zRuuVgSgTc2KCKQdHJZGGPh5Ig5
nzH3EE7HuwBTkwlqHj7M0jj1mHw8DPhteH3gy8CVAFWdBkL9iMIhARZGJbOVu7ya
kAgPrSjens6mX3AXXRylVIWnl+9gHEqZC8KiAseuC3pxMakEpOskNJAVxuWLApen
gS3xIYPutRuMmbV/Mu3psefKGozs8shjJB6ynD9CAvUgeAHu9U7Erlx7q08H/21H
x8ikkr8scPaMlCXVPzZPnlsfWVM/lFULuncRod3bsg5/WYfMYHBZrUpLpnLmpSU6
AHjC2Q68ZQ0MabWciDB4BXv9gxnUNg==
=gq6t
-----END PGP SIGNATURE-----

--h5fwl7em2i4tyu2z--

