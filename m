Return-Path: <linux-can+bounces-2964-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86B5A444F1
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 16:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FC6860DC6
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1780A1547CA;
	Tue, 25 Feb 2025 15:48:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6A156F3A
	for <linux-can@vger.kernel.org>; Tue, 25 Feb 2025 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498527; cv=none; b=B0CielwmSIqlgHvcuvZvegqr4Fp7ezJZx8u3N/hpzklrx1bAcOwqS37HrcPL2wmArH9F1F8wW2tK8hiX2YuT8H36EvANQa9MSOWw46FO7rl1aqxViiJGIzx/c9kIna/MjQVW9T+cs25ItRfEq6nTVXR/qJ1PhAB83WAyf8xNfZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498527; c=relaxed/simple;
	bh=69WQbe0mRCE3CaPtHemThOBRz8Pl81wjhiLOBI9zM5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q69VceJa2xkydfjmVx1RqciAMb0zn/HRkeovpf/kD66smQIOWadZNgEb4PJjmpX6Ivz2aN3mkA7/9VM0rgpNAS2PaOOV8/d8O7/C70cHG/kopjw0HPTtC4tdRdEUZwoEe+HbllnkonX/ebam2JP98J1ZD0BaRcudUIoZjWcE4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tmxAd-0003XD-6d; Tue, 25 Feb 2025 16:48:31 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tmxAc-002neG-0l;
	Tue, 25 Feb 2025 16:48:30 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DB2393CB96A;
	Tue, 25 Feb 2025 15:48:29 +0000 (UTC)
Date: Tue, 25 Feb 2025 16:48:29 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 06/11] can: rcar_canfd: Add register mapping table to
 struct rcar_canfd_hw_info
Message-ID: <20250225-urban-devious-worm-f1e178-mkl@pengutronix.de>
References: <20250225154058.59116-1-biju.das.jz@bp.renesas.com>
 <20250225154058.59116-7-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iuc4toxmdra5wso7"
Content-Disposition: inline
In-Reply-To: <20250225154058.59116-7-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--iuc4toxmdra5wso7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 06/11] can: rcar_canfd: Add register mapping table to
 struct rcar_canfd_hw_info
MIME-Version: 1.0

On 25.02.2025 15:40:45, Biju Das wrote:
> R-Car Gen3 and Gen4 has some differences in the register offsets. Add a
> mapping table to handle these differences.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3:
>  * New patch.
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 48 ++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index f71725da57ce..268b9b8835c4 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c

[...]

> +enum rcar_canfd_reg_offset_id {
> +	RFCC,		/* RX FIFO Configuration/Control Register */
> +	CFCC,		/* Common FIFO Configuration/Control Register */
> +	CFSTS,		/* Common FIFO Status Register */
> +	CFPCTR,		/* Common FIFO Pointer Control Register */
> +	F_DCFG,		/* Global FD Configuration Register */
> +	RFOFFSET,	/* Receive FIFO buffer access ID register */
> +	CFOFFSET,	/* Transmit/receive FIFO buffer access ID register */
> +};

Please add a common prefix to the enums, i.e. RCANFD

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--iuc4toxmdra5wso7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme95koACgkQDHRl3/mQ
kZxm7wf+J7mCowpPWAQvsWgkuldZ6tE3gZGp7SUBGjhXnFIA8UW9owrxmo6viUTz
m017MIJBvD+17w5bIYaafDHmALbYV8PeiJ4YU7V/JAQZY0ECQm82hRAhk7pvL/2f
2QUU/BXA2trlfUxSvhGuR22vpKktHub/VDhAsa1ALlbKP6epb304d2VgOhDJH0jO
gUubfKOw2EofBUzje9PZ31Qrg+cs/Ueg+u4Ud3pAHVQRPHtadSJrw+Ypj6alLguu
45nZNTsYW/iUp4sc7tWX/u+jlb1zTi64s6EORKBcbZRKwRy9rtdR6ZzmP1VqZxWt
4Uiu6O+4C9jS2Gv67Gf/YQimSXL7ow==
=JDak
-----END PGP SIGNATURE-----

--iuc4toxmdra5wso7--

