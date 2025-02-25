Return-Path: <linux-can+bounces-2966-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A6CA444FA
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 16:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38553A59A1
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346611514EE;
	Tue, 25 Feb 2025 15:51:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EB91547CA
	for <linux-can@vger.kernel.org>; Tue, 25 Feb 2025 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498692; cv=none; b=fxY8eeOColHHVZ9llVFi1K9CsWBtMHk67UefQNQiiX6Y57XabNYnQWrrnFeORZzT4EHufWSzc0NswhoB3eItG5nBKTUa4sm/NSNNWJlzxvxnunjooP74LEfrfzqtZNy0hJzT77uBV62iw1jt1r2wq1lgomLqKteircy2YxfQ+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498692; c=relaxed/simple;
	bh=4L8WT6Lr2a21SbgbBkoDkOsvqgGQ4C+8PPulBTiaWKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzc0c7JJ0fjTTMrupVIPv1isx9B5Dr9KzH2kjeMfCuRIz3r7QiUilA2f6A3YczFebbnQQ3QKIedvH1p/rUHeoKMIhMfhGDuXtxW+kzqpffOMHUENwT1+B+taCPpNzS3o2yuZFLJuwdKWNEjWwYiAjJHTf5WN2TwHX10BIDjOAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tmxDP-0003sT-Ik; Tue, 25 Feb 2025 16:51:23 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tmxDP-002neU-0l;
	Tue, 25 Feb 2025 16:51:23 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EDC1A3CB977;
	Tue, 25 Feb 2025 15:51:22 +0000 (UTC)
Date: Tue, 25 Feb 2025 16:51:21 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 08/11] can: rcar_canfd: Add shift table to struct
 rcar_canfd_hw_info
Message-ID: <20250225-piquant-spiked-mouflon-3e88ac-mkl@pengutronix.de>
References: <20250225154058.59116-1-biju.das.jz@bp.renesas.com>
 <20250225154058.59116-9-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ycfonjcuzjhqmejj"
Content-Disposition: inline
In-Reply-To: <20250225154058.59116-9-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ycfonjcuzjhqmejj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 08/11] can: rcar_canfd: Add shift table to struct
 rcar_canfd_hw_info
MIME-Version: 1.0

On 25.02.2025 15:40:47, Biju Das wrote:
> R-Car Gen3 and Gen4 has some differences in the shift bits. Add a
> shift table to handle these differences. After this drop the unused
> functions reg_gen4() and is_gen4().
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3:
>  * New patch.
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 78 ++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index fcf5cb93f57c..09a9e548b022 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c

[...]

> +enum rcar_canfd_shift_id {
> +	FIRST_RNC_SH,	/* Rule Number for Channel x */
> +	SECOND_RNC_SH,	/* Rule Number for Channel x + 1 */
> +	NTSEG2_SH,	/* Nominal Bit Rate Time Segment 2 Control */
> +	NTSEG1_SH,	/* Nominal Bit Rate Time Segment 1 Control */
> +	NSJW_SH,	/* Nominal Bit Rate Resynchronization Jump Width Control */
> +	DTSEG2_SH,	/* Data Bit Rate Time Segment 2 Control */
> +	DTSEG1_SH,	/* Data Bit Rate Time Segment 1 Control */
> +	CFTML_SH,	/* Common FIFO TX Message Buffer Link */
> +	CFM_SH,		/* Common FIFO Mode */
> +	CFDC_SH,	/* Common FIFO Depth Configuration */
> +};

Please add a common prefix to the enums, i.e. RCANFD_.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ycfonjcuzjhqmejj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme95vYACgkQDHRl3/mQ
kZz2wAf/bNoPs32aPGZMS+JOZFWyGf1hwpFlyT/fKmNV3O2uoyYfEagGRTz6GUuN
aImjtRtTyJEGf8CRllQfZoyTp0ElziVxGv9ynJlDtq7B4vhm8/8lh3bYjOYPoi7p
wCnfprVs+1rqY/o73Lngk6cs38KrFKRYrz1QOEsRu5skphjq6SUgZnDVAwkpYLYc
KopOAdTkcbZLAvpjzIztjX/Gei+9f+M9MW678jD8eJPHyFPzYEUO3YWUpLGVsKoN
oOpeB66Ji0R3k2/ISxS4vZiqpOpzqr1aof9F/5O4xz1rNCoqQnB3tMv5VAo62MA7
NJi3j1BMT+3HMhnowEh9rDRsLXAAbA==
=5Q6K
-----END PGP SIGNATURE-----

--ycfonjcuzjhqmejj--

