Return-Path: <linux-can+bounces-2668-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED45A17106
	for <lists+linux-can@lfdr.de>; Mon, 20 Jan 2025 18:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7602C1887394
	for <lists+linux-can@lfdr.de>; Mon, 20 Jan 2025 17:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DCE1EC00C;
	Mon, 20 Jan 2025 17:11:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A37B1494CC
	for <linux-can@vger.kernel.org>; Mon, 20 Jan 2025 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393071; cv=none; b=C31mAWtH0CbDenRpn10sgZhTcNHwy3AIbPhFbJpmvksN6LndNF9F7hzZflpRvBx9W4aoE2b09P9DlvuGGIMBv61U6BoNOh+I25LyRRNaQxALgobMit8Qzav1OZD+/UMEaeSGrpTpj3GsQP7LVeGehmjcZQ1CzsVcpqlaEDBe2+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393071; c=relaxed/simple;
	bh=z75F0ElXyo1lgXb+1KQOW7JoTALsI1fxsJcp6IEAW8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sveYPkdXYLUzgxsEIgDcFqh4QvR1tp+Q5s+cBAaqa1ZoydT5LQ0su9p9EiQWeqsyIFnYNwx4OFLJC55L7ZB3InoM2rArC8qv7YYLTT7bZbcgO8ee+IxZiSBqnRbqUuL13QG7SHKQD6MTSVIY3lPv/GyfvRmoT7fcvDyk090FlyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tZvIo-00072G-5J; Mon, 20 Jan 2025 18:11:06 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tZvIn-000yGB-29;
	Mon, 20 Jan 2025 18:11:05 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 526683AD122;
	Mon, 20 Jan 2025 17:11:05 +0000 (UTC)
Date: Mon, 20 Jan 2025 18:11:04 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: mark.jonas@de.bosch.com
Cc: linux-can@vger.kernel.org, Zhu Yi <yi.zhu5@cn.bosch.com>, 
	Hubert Streidl <hubert.streidl@de.bosch.com>
Subject: Re: [can-utils][PATCH 2/3] canbusload: support busload statistic
Message-ID: <20250120-vigorous-almond-toad-a28dc0-mkl@pengutronix.de>
References: <20250120162332.19157-1-mark.jonas@de.bosch.com>
 <20250120162332.19157-2-mark.jonas@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yst6iwmrdizfbgv5"
Content-Disposition: inline
In-Reply-To: <20250120162332.19157-2-mark.jonas@de.bosch.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--yst6iwmrdizfbgv5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [can-utils][PATCH 2/3] canbusload: support busload statistic
MIME-Version: 1.0

On 20.01.2025 17:23:31, mark.jonas@de.bosch.com wrote:
> From: Zhu Yi <yi.zhu5@cn.bosch.com>
>=20
> Add '-s' option for display busload statistic, the output contains
> minimal, maximum and exponentially-damped moving sums of one second
> average (borrowed from Linux load average algorithm) since start or
> reset (press 'r' while running).
>=20
> canbusload 2024-09-23 17:15:18 (exact bitstuffing)
>  can0@500k   942  107535   60168       0  18% min:  0%, max: 21%, load: 1=
6%   6%   2% |XXX.................|
>=20
> Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
> Signed-off-by: Hubert Streidl <hubert.streidl@de.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> ---
>  canbusload.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
>=20
> diff --git a/canbusload.c b/canbusload.c
> index 753d658..577d99c 100644
> --- a/canbusload.c
> +++ b/canbusload.c
> @@ -48,11 +48,13 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <termios.h>
>  #include <time.h>
>  #include <unistd.h>
> =20
>  #include <net/if.h>
>  #include <sys/ioctl.h>
> +#include <sys/param.h>
>  #include <sys/socket.h>
>  #include <sys/time.h>
>  #include <sys/types.h>
> @@ -72,6 +74,34 @@
>  #define NUMBAR (100 / PERCENTRES) /* number of bargraph elements */
>  #define BRSTRLEN 20
> =20
> +/*
> + * Inspired from
> + * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/
> + * include/linux/sched/loadavg.h
> + *
> + * Following are the fixed-point math constants and the exponential-damp=
ing
> + * factors for:
> + *  - 1 samples/s in 1 minute
> + *  - 1 samples/s in 5 minutes
> + *  - 1 samples/s in 15 minutes
> + * in fixed-point representation.
> + */
> +#define FP_SHIFT 12              /* bits of precision */
> +#define FP_ONE   (1 << FP_SHIFT) /* 1.0 fixed-point representation */
> +#define EXP_1    4028            /* (1 / e ^ (1 /  60)) * FP_ONE */
> +#define EXP_5    4082            /* (1 / e ^ (1 / 300)) * FP_ONE */
> +#define EXP_15   4091            /* (1 / e ^ (1 / 900)) * FP_ONE */
> +
> +inline unsigned int calc_load(unsigned int load_fp,
> +                              unsigned int exp_fp,
> +                              unsigned int sample)
> +{
> +	unsigned int sample_fp  =3D sample << FP_SHIFT;
> +	unsigned int damped_sum =3D (load_fp * exp_fp) +
> +	                          (sample_fp * (FP_ONE - exp_fp));
> +	return damped_sum >> FP_SHIFT;
> +}
> +

Had to make this a "static" function, otherwise it fails to link. Some
singed/unsigned changes were also needed. Can you check if this still
works for you:

| https://github.com/linux-can/can-utils/pull/571

So far compile tested only.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--yst6iwmrdizfbgv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmeOg6YACgkQKDiiPnot
vG+0ygf/U/J9tCwruKVWcMa5cYP5GFXMvIGIWnRZEPjy3sBVija8/tW7HtYxnNWa
s3zced5t1WsCrRjgL/HlkT0f7wZ8jdkrOX+7COzDcABH0tttENZrbFBMDCrowMSo
F14/dQNEgRaIR1D9GosydkgWOK3Wts30eRogjMMsG8aTKF27TNd4+DN78stR1shx
YAofDuXCKRmzSz5H/NBf1qIHKwwXxZ/z3QEQR2yu/0zivLRb+KjZGl9q9LpNIYcs
4JU9lzG+Oeccrh8xE5cvfs+x6En3/LbRfk375qp26ueWZsiNJfbIOiJsN0kg1SPy
4lkW+/YU+bJK1jOT7Fy4TFI7sLovrg==
=9Gb9
-----END PGP SIGNATURE-----

--yst6iwmrdizfbgv5--

