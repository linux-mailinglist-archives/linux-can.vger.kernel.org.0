Return-Path: <linux-can+bounces-5548-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C20C78146
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31B834E9EDD
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FC533F37C;
	Fri, 21 Nov 2025 09:13:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1BE2E88BD
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716410; cv=none; b=b90AGpzz++V4LmPXIDNXUmAm13yhk3WQXgN2HJsPJNvcWEfyLkP5j7b48EBE2lxKrGtxihyRYL54Kvvbwrxra+WMKDsD+2Zyx6McVqnYWgb3RndzRTSqFOyE0k3tkSfio4wtIj3wYxxtzq3uVIlM3b3bj94hVhLag2T/W5NakV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716410; c=relaxed/simple;
	bh=SqlqZy7nz3NrmNSvTxJgV/rQ+l6JUN0wpxT6Pl0Hmx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Go8ddwfmJdH0SDb3FssjZ32923BRzl+BNk24HIKCGGgluv240Ux1XsBbzvD0rXc/jd1XbpThS85HIo3FG6Td7v+e078iHI8ZUlWd8OUuW0rz18iAW/ovD67NOsOPOoyTSoYl2OmRH/VH2coazlEOOIKyAPZ7F2FORmgcwfQYmKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMNCo-0002pS-Bu; Fri, 21 Nov 2025 10:13:26 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMNCn-001Ypg-0n;
	Fri, 21 Nov 2025 10:13:25 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id ED2184A45EC;
	Fri, 21 Nov 2025 09:13:24 +0000 (UTC)
Date: Fri, 21 Nov 2025 10:13:22 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [canxl v4 17/17] can: dev: print bitrate error with two decimal
 digits
Message-ID: <20251121-khaki-termite-of-glee-053933-mkl@pengutronix.de>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
 <20251121083414.3642-18-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vmjf77uxt555v2os"
Content-Disposition: inline
In-Reply-To: <20251121083414.3642-18-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--vmjf77uxt555v2os
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [canxl v4 17/17] can: dev: print bitrate error with two decimal
 digits
MIME-Version: 1.0

On 21.11.2025 09:34:14, Oliver Hartkopp wrote:
> Increase the resolution when printing the bitrate error and round-up the
> value to 0.01% in the case the resolution would still provide values
> which would lead to 0.00%.
>
> Suggested-by: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev/calc_bittiming.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/c=
alc_bittiming.c
> index 0b11c4e98172..103128773a7d 100644
> --- a/drivers/net/can/dev/calc_bittiming.c
> +++ b/drivers/net/can/dev/calc_bittiming.c
> @@ -150,23 +150,26 @@ int can_calc_bittiming(const struct net_device *dev=
, struct can_bittiming *bt,
>  		if (bitrate_error =3D=3D 0 && sample_point_error =3D=3D 0)
>  			break;
>  	}
>
>  	if (best_bitrate_error) {
> -		/* Error in one-tenth of a percent */
> -		v64 =3D (u64)best_bitrate_error * 1000;
> +		/* Error in one-hundredth of a percent */
> +		v64 =3D (u64)best_bitrate_error * 10000;
>  		do_div(v64, bt->bitrate);
>  		bitrate_error =3D (u32)v64;
>  		if (bitrate_error > CAN_CALC_MAX_ERROR) {
>  			NL_SET_ERR_MSG_FMT(extack,
> -					   "bitrate error: %u.%u%% too high",
> -					   bitrate_error / 10, bitrate_error % 10);
> +					   "bitrate error: %u.%02u%% too high",
> +					   bitrate_error / 100,
> +					   bitrate_error % 100);
>  			return -EINVAL;
>  		}

We already know we have a bitrate error, so we can set it to at least 1:

        bitrate_error =3D max(bitrate_error, 1U);

Please add a comment describe the reasoning.

>  		NL_SET_ERR_MSG_FMT(extack,
> -				   "bitrate error: %u.%u%%",
> -				   bitrate_error / 10, bitrate_error % 10);
> +				   "bitrate error: %u.%02u%%",
> +				   bitrate_error / 100,
> +				   ((bitrate_error / 100) || (bitrate_error % 100))?
> +				   (bitrate_error % 100):1);

So we can avoid this.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vmjf77uxt555v2os
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkgLTAACgkQDHRl3/mQ
kZyauwf/Ut0SMdVIfMXkDdehNU2dB3txgu/lRDxSqPJ/rXIndBugwYhijoH5rvd5
lZTiCPyBUH4qsRWiYTZOVWQrlR7/9GNhNoFcBI25GZMI7ZWqsa/1A5Cd3f50Zajz
SgHfGpf1CHflZvzdCcvwHCthUX1ItWatBIaVImbAyM8O1ZCtI3bwJC4U9HH77sgb
iPy9KvjhKGFJh0g/dyR8LkL0+orE+tGR2DA4nrRQPtkFqnkivOBSb9rh/mmvACR0
3Y8tTXhlYgWxXt31XU6znf1+s3ErM6wRbIDPnASfYNc0RzHMQ+e3tG4vu8y5nhvi
jZw5HnRzl2vUjPdNW5eUpVmDVZFlvw==
=JukZ
-----END PGP SIGNATURE-----

--vmjf77uxt555v2os--

