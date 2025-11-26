Return-Path: <linux-can+bounces-5691-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3C0C89429
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C68F3A2B11
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7A329E112;
	Wed, 26 Nov 2025 10:23:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819E02D23BC
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152604; cv=none; b=KO8N8z6pYD0OfrNTGUV56Qp2nomz4XpkywiVbLjijrkXzwYPpqz39kinGSaLiaZIAhVK0nnxpSUzHad2n9+G+dhXF85Iv7dIK+5HbcJIc4JJDddgsbAsZ1UfTdlh3bLvYn2HUacYTDt/S3fulokZxlFpsilnYeDeztaoUBJ2sDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152604; c=relaxed/simple;
	bh=X1j54G4F/HJGBsuafhi5Vj1NIHj8qr0Uafwa/6pp+zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELJWEehDMaEPm2zFO9q8GBDccaYZtWuA1a74R5Qg3ezxWAzJNVuM/3I5HXgdyZRwS0+Yc0huwFP9aHoaHhzw/KeASgDJff07v+gCFijUAmW+N96w5I+UdM80i16fqp3pfUAG1g1wNLNwDB870bxuzXYZINjPf0Ho2WovbC1cQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCg8-0001vl-9v; Wed, 26 Nov 2025 11:23:16 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCg7-002aUC-1T;
	Wed, 26 Nov 2025 11:23:15 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1D8CA4A8956;
	Wed, 26 Nov 2025 10:23:15 +0000 (UTC)
Date: Wed, 26 Nov 2025 11:23:14 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju <biju.das.au@gmail.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 0/7] Add R-Car CAN-FD suspend/resume support
Message-ID: <20251126-active-goat-from-tartarus-ab5fb7-mkl@pengutronix.de>
References: <20251124102837.106973-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="37khvae3yo4xczk6"
Content-Disposition: inline
In-Reply-To: <20251124102837.106973-1-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--37khvae3yo4xczk6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/7] Add R-Car CAN-FD suspend/resume support
MIME-Version: 1.0

On 24.11.2025 10:28:25, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Hi all,
>
> This patch series adds proper suspend/resume support to the Renesas
> R-Car CAN-FD controller driver, after the customary cleanups and fixes.
> It aims to fix CAN-FD operation after resume from s2ram on systems where
> PSCI powers down the SoC.
>
> This patch series has been tested on RZ/G3E SMARC EVK and RZ/G2L SMARC
> EVK.
>
> This patch series depend upon [1]
> [1] https://lore.kernel.org/all/20251123112326.128448-1-biju.das.jz@bp.re=
nesas.com/

applied to linux-can-next.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--37khvae3yo4xczk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkm1Q8ACgkQDHRl3/mQ
kZwpigf/eiU969K6HVmX7/iaELrT6qfZo+VsubJEjSnT6m6PKoy4UCnPVUvfr/Vz
NGNyW237h+vsvnhO83HNhNLxcGIOzX5LRahCnbUTjDSW9GCv/X9qixBKpyO63wMz
QzRDynWQeHcltT9KDdT4z670+oA783rD2IPKBT1zIXEE0+/jgVmVQIYeL4qja6H0
1ZBFHojz5DrxpOza/kJrFTASMO4pQDbaWspBpHo2C1jzjgprxuOWJCbHZuz5w3OS
abH9rlYXEozKPyL9J62d82NpI7gUqXpXpTLRUUg1FdD6FJT2l5t0kgg8tuB8y193
X3/ae7AqepcXby7bslxesJyUzI6e3A==
=qHVr
-----END PGP SIGNATURE-----

--37khvae3yo4xczk6--

