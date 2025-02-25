Return-Path: <linux-can+bounces-2965-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3C2A444F7
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 16:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF44E1899D1C
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4B91514EE;
	Tue, 25 Feb 2025 15:50:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7D1547CA
	for <linux-can@vger.kernel.org>; Tue, 25 Feb 2025 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498609; cv=none; b=RhW0Rbo7v3CnpwerZcVWpwEh1MBB+uXsiu8Apr15xkrLfCu+utbXnxr3z73PlQBSXEFfLxYlV7Iv2wsgwxbeomB39LVICCfdEk+Wr86d2tP6JgTe9LVV8tEWYWO/fFgdxe+M1tkN5A//VFU/+PGLpu0m01L1aK6/b2A2Cb2pJ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498609; c=relaxed/simple;
	bh=A4qPwvtA3ZB0DOdEAWxIQQuJco1FtvRXAsUeFjEyXKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igoD3hxr/fspZi3d9HsG+CyrYq0868Bg1oxRvoN4Z2V5zczFyBJfiGRBzVUv7+sQLPrzCNqdCaau4gEbwWkEOOuKHSVX5P54Xz+Q0gpUodPlKMfKhOeKId7BZ6O41Tzr84Ep/SIKprLcjcv7iAeKdqThTIhb5/ZFxwcOQRA71yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tmxC3-0003k9-SM; Tue, 25 Feb 2025 16:49:59 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tmxC3-002neM-1j;
	Tue, 25 Feb 2025 16:49:59 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 413A33CB973;
	Tue, 25 Feb 2025 15:49:59 +0000 (UTC)
Date: Tue, 25 Feb 2025 16:49:59 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 07/11] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
Message-ID: <20250225-athletic-graceful-jaguar-4a0486-mkl@pengutronix.de>
References: <20250225154058.59116-1-biju.das.jz@bp.renesas.com>
 <20250225154058.59116-8-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rv5fsux7xp2ivpvt"
Content-Disposition: inline
In-Reply-To: <20250225154058.59116-8-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--rv5fsux7xp2ivpvt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 07/11] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
MIME-Version: 1.0

On 25.02.2025 15:40:46, Biju Das wrote:
> R-Car Gen3 and Gen4 has some differences in the mask bits. Add a
> mask table to handle these differences.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3:
>  * New patch.
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 68 +++++++++++++++++++++++++------
>  1 file changed, 55 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index 268b9b8835c4..fcf5cb93f57c 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c

> +enum rcar_canfd_mask_id {
> +	EEF_MASK_ID,	/* Global Error Flag */
> +	RNC_MASK_ID,	/* Rule Number for Channel */
> +	AFLPN_MASK_ID,	/* Acceptance Filter List Page Number */
> +	NTSEG2_MASK_ID,	/* Nominal Bit Rate Time Segment 2 Control */
> +	NTSEG1_MASK_ID,	/* Nominal Bit Rate Time Segment 1 Control */
> +	NSJW_MASK_ID,	/* Nominal Bit Rate Resynchronization Jump Width Control =
*/
> +	DSJW_MASK_ID,	/* Data Bit Rate Resynchronization Jump Width Control */
> +	DTSEG2_MASK_ID,	/* Data Bit Rate Time Segment 2 Control */
> +	DTSEG1_MASK_ID,	/* Data Bit Rate Time Segment 1 Control */
> +	CFTML_MASK_ID,	/* Common FIFO TX Message Buffer Link */
> +};

Please add a common prefix to the enums, i.e. RCANFD_.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rv5fsux7xp2ivpvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme95qQACgkQDHRl3/mQ
kZyW/Af/RsPPz3hC0KDBTN1jC1yqP1oK65U3LwyuExpNCdas3o+BThRbWhSQnCEj
4C6WhXLGdNxmCmJhxxY7RDvb+UAyoaHaXBh+nmurs7q6zSInvkkPL8svyCMT8vuE
PycMRm5oOKHmE6MnWeb+YY7wO+FdU8uO0bZwIoRdfu6v9snsVV23/Gsyh9ZAncVg
GQxbRHhrHH95mDquGan36V96Kn2ZMKRfoM67NhRVkYBwva7BY5b/tcDsVqaSCWJU
h/EaPjO45cPZWBuSmu/ruS+RIHICtlDS0N9EQzWSMulNHd6wDuEgKNOT9cIT91UP
ruavJfUo489OD347nMsvTAwv1wLhHw==
=MC+w
-----END PGP SIGNATURE-----

--rv5fsux7xp2ivpvt--

