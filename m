Return-Path: <linux-can+bounces-5352-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E503C514D4
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 10:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C193A380E
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85062FD684;
	Wed, 12 Nov 2025 09:09:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3E32BEC2C
	for <linux-can@vger.kernel.org>; Wed, 12 Nov 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938544; cv=none; b=j8vV/5p9f4F5J4NBi59+ZJYxfXE80jYVbsm9VN9r99+MKx5lWi6V4A17EkN2sbXNrshszilMBhuG74PIhgpg9XWdb8G1GKHLdOgYhJd2G57VjFJliyLYe/6Ihp+iduiqbeHfGBRZPOH7IaVCoP/ZRdUCQhGur9yzU7dlfTWNLO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938544; c=relaxed/simple;
	bh=k8PUUUoON4ioUKVyzZHebFbj55jWd2G4MlMWSybPofQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVj0sdEVbKAEHFafvo5Uko/zQEC4OUkjNDsQpLESh6Gjf2TQR274w+2g20f/0K6v4j15rXtUG3LX3dJ6xpB5rfoPw/e8cUViXVZHXKgGZt+YuyVa+fJhkTspg5hd2Lh+OaUalrvx/QG2Pre2FEN5ajSR55/S4UNkfNueHT3xeQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6qa-0006Po-QN; Wed, 12 Nov 2025 10:09:00 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6qa-0003av-1l;
	Wed, 12 Nov 2025 10:09:00 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3E52749D98A;
	Wed, 12 Nov 2025 09:09:00 +0000 (UTC)
Date: Wed, 12 Nov 2025 10:08:56 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] can: calc_bittiming: get rid of the incorrect
 "nominal" word
Message-ID: <20251112-remarkable-puzzling-fox-3b3202-mkl@pengutronix.de>
References: <20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org>
 <20251102-pwm_sample_point-v1-1-3bbea180f59e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iscfgqwfaar6nfd2"
Content-Disposition: inline
In-Reply-To: <20251102-pwm_sample_point-v1-1-3bbea180f59e@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--iscfgqwfaar6nfd2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 1/3] can: calc_bittiming: get rid of the incorrect
 "nominal" word
MIME-Version: 1.0

On 02.11.2025 23:01:22, Vincent Mailhol wrote:
> The functions can_update_sample_point() and can_calc_bittiming() are
> generic and meant to be used for both the nominal and the data
> bittiming calculation.

""There are 2 hard problems in computer science: cache invalidation,
  naming things, and off-by-1 errors.""

Here it's naming things. Back in the days, in commit 7da29f97d6c8 ("can:
dev: can-calc-bit-timing(): better sample point calculation"), I wanted
to distinguish between the sample point the user requested and the
current sample point.

I was thinking about the signal that goes into a control loops, but at
university the lecture was in German, so I picked the wrong term. I
think "set point" or "reference value" are better terms.

> However, those functions use terminologies such as "bitrate nominal"
> or "sample point nominal". This is a leftover from when only Classical
> CAN was supported and now became incorrect.
>
> Remove or replace any occurrences of the word "nominal" with something
> more accurate.

What about replacing "nominal" with "reference"

> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
>  drivers/net/can/dev/calc_bittiming.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/c=
alc_bittiming.c
> index 268ec6fa7c49..222117596704 100644
> --- a/drivers/net/can/dev/calc_bittiming.c
> +++ b/drivers/net/can/dev/calc_bittiming.c
> @@ -24,7 +24,7 @@
>   */
>  static int
>  can_update_sample_point(const struct can_bittiming_const *btc,
> -			const unsigned int sample_point_nominal, const unsigned int tseg,
> +			unsigned int sp_origin, unsigned int tseg,

Please don't remove the "const".

>  			unsigned int *tseg1_ptr, unsigned int *tseg2_ptr,
>  			unsigned int *sample_point_error_ptr)
>  {
> @@ -35,8 +35,7 @@ can_update_sample_point(const struct can_bittiming_cons=
t *btc,
>
>  	for (i =3D 0; i <=3D 1; i++) {
>  		tseg2 =3D tseg + CAN_SYNC_SEG -
> -			(sample_point_nominal * (tseg + CAN_SYNC_SEG)) /
> -			1000 - i;
> +			(sp_origin * (tseg + CAN_SYNC_SEG)) / 1000 - i;
>  		tseg2 =3D clamp(tseg2, btc->tseg2_min, btc->tseg2_max);
>  		tseg1 =3D tseg - tseg2;
>  		if (tseg1 > btc->tseg1_max) {
> @@ -46,9 +45,9 @@ can_update_sample_point(const struct can_bittiming_cons=
t *btc,
>
>  		sample_point =3D 1000 * (tseg + CAN_SYNC_SEG - tseg2) /
>  			(tseg + CAN_SYNC_SEG);
> -		sample_point_error =3D abs(sample_point_nominal - sample_point);
> +		sample_point_error =3D abs(sp_origin - sample_point);
>
> -		if (sample_point <=3D sample_point_nominal &&
> +		if (sample_point <=3D sp_origin &&
>  		    sample_point_error < best_sample_point_error) {
>  			best_sample_point =3D sample_point;
>  			best_sample_point_error =3D sample_point_error;
> @@ -68,11 +67,11 @@ int can_calc_bittiming(const struct net_device *dev, =
struct can_bittiming *bt,
>  {
>  	struct can_priv *priv =3D netdev_priv(dev);
>  	unsigned int bitrate;			/* current bitrate */
> -	unsigned int bitrate_error;		/* difference between current and nominal =
value */
> +	unsigned int bitrate_error;		/* difference between current and calculat=
ed value */

What about: "difference between reference and calculated value"

>  	unsigned int best_bitrate_error =3D UINT_MAX;
> -	unsigned int sample_point_error;	/* difference between current and nomi=
nal value */
> +	unsigned int sample_point_error;	/* difference between current and calc=
ulated value */
>  	unsigned int best_sample_point_error =3D UINT_MAX;
> -	unsigned int sample_point_nominal;	/* nominal sample point */
> +	unsigned int sample_point;
>  	unsigned int best_tseg =3D 0;		/* current best value for tseg */
>  	unsigned int best_brp =3D 0;		/* current best value for brp */
>  	unsigned int brp, tsegall, tseg, tseg1 =3D 0, tseg2 =3D 0;
> @@ -81,14 +80,14 @@ int can_calc_bittiming(const struct net_device *dev, =
struct can_bittiming *bt,
>
>  	/* Use CiA recommended sample points */
>  	if (bt->sample_point) {
> -		sample_point_nominal =3D bt->sample_point;
> +		sample_point =3D bt->sample_point;
>  	} else {
>  		if (bt->bitrate > 800 * KILO /* BPS */)
> -			sample_point_nominal =3D 750;
> +			sample_point =3D 750;
>  		else if (bt->bitrate > 500 * KILO /* BPS */)
> -			sample_point_nominal =3D 800;
> +			sample_point =3D 800;
>  		else
> -			sample_point_nominal =3D 875;
> +			sample_point =3D 875;
>  	}
>
>  	/* tseg even =3D round down, odd =3D round up */
> @@ -115,7 +114,7 @@ int can_calc_bittiming(const struct net_device *dev, =
struct can_bittiming *bt,
>  		if (bitrate_error < best_bitrate_error)
>  			best_sample_point_error =3D UINT_MAX;
>
> -		can_update_sample_point(btc, sample_point_nominal, tseg / 2,
> +		can_update_sample_point(btc, sample_point, tseg / 2,
>  					&tseg1, &tseg2, &sample_point_error);
>  		if (sample_point_error >=3D best_sample_point_error)
>  			continue;
> @@ -146,9 +145,8 @@ int can_calc_bittiming(const struct net_device *dev, =
struct can_bittiming *bt,
>  	}
>
>  	/* real sample point */
> -	bt->sample_point =3D can_update_sample_point(btc, sample_point_nominal,
> -						   best_tseg, &tseg1, &tseg2,
> -						   NULL);
> +	bt->sample_point =3D can_update_sample_point(btc, sample_point, best_ts=
eg,
> +						   &tseg1, &tseg2, NULL);
>
>  	v64 =3D (u64)best_brp * 1000 * 1000 * 1000;
>  	do_div(v64, priv->clock.freq);

Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--iscfgqwfaar6nfd2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkUTqUACgkQDHRl3/mQ
kZzVaggAqp3ZD1N3MTv3r+gEIZmlx2Pz8d53BUC/QWS2FpdBcAVi4Rn+ZKPzroPi
9Z3Pht8hUg26R7Nq0dtmsvmiywbus6FI7/lJS6yfYyoZswCmYHMDhNRElquFKdN5
5RPCXpK3wl64VMLQL52M86O8VGxV3zAiV7WYjEkf5cjA1Bl3I6lDTX/7yfTjpfv/
CQ9Fkl3bonyrkdRRxV8aaHjFHleO1rgxmJIOikxHvS7sR5OWsQ2BK0oQOayKC9ea
pc/0/w+UKLoCe+RIaABNsAF6XTsi++AYc64yh98z9gJk3Mt9yR8XkdS9rhk7IvwC
Keuae6a9A/YkR3z0a8he5Gc65a0JVA==
=Yhch
-----END PGP SIGNATURE-----

--iscfgqwfaar6nfd2--

