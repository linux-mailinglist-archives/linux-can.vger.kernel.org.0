Return-Path: <linux-can+bounces-5587-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9A6C7B99C
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B801135F940
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535F520C463;
	Fri, 21 Nov 2025 19:57:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034430499B
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763755067; cv=none; b=V9q7aS20OFIOZgFiIbwl5HEt9tjGdA2j9AgoMv+ntDlGS1oVUx+N+pSqmeMzIhMrCiFctqzzeWEMHOFMNJV/vfSmyMUsFI+7EJXWI42177sRix7Hj3BKdpSSLYuRaWzpBzitlSuJ/7olb0rPhVL1kpTTW9ueVNhDq+1s82wx3C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763755067; c=relaxed/simple;
	bh=BDWABv2tmK8d5Iixvp27NVCplot8ZHz3k86e4pbtxB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onGqCGfwooTxb4Ul6bZJWPMTW8F6m0qHaBJzJujKcjcb06m6A5k7MbDObe/2pl/JiRVAwa7Dx9DIanY30IMAWMUcvx6UOf+hX64H7pO1hpkzYgqOyUFKk8T5xwJIKj8VvO2NLTjCD9TpIgPpzG12xJOAlEqZ5DE5fHIO04Secn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMXGG-000589-Ld; Fri, 21 Nov 2025 20:57:40 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMXGG-001dah-1D;
	Fri, 21 Nov 2025 20:57:40 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1CBB14A4B8A;
	Fri, 21 Nov 2025 19:57:40 +0000 (UTC)
Date: Fri, 21 Nov 2025 20:57:39 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [canxl v5 17/17] can: dev: print bitrate error with two decimal
 digits
Message-ID: <20251121-judicious-dalmatian-from-hyperborea-085fe4-mkl@pengutronix.de>
References: <20251121193513.2097-1-socketcan@hartkopp.net>
 <20251121193513.2097-18-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h6iwozxdrwyrxrsn"
Content-Disposition: inline
In-Reply-To: <20251121193513.2097-18-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--h6iwozxdrwyrxrsn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [canxl v5 17/17] can: dev: print bitrate error with two decimal
 digits
MIME-Version: 1.0

On 21.11.2025 20:35:13, Oliver Hartkopp wrote:
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
> index 0b11c4e98172..71c5ba338f8f 100644
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

> +		/* print at least 0.01% when the error is smaller */
                                        ^^^^
                                        if
> +		bitrate_error =3D max(bitrate_error, 1U);

regards
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--h6iwozxdrwyrxrsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkgxDAACgkQDHRl3/mQ
kZy/CggAj8P78sWeO1ko4Uf6bMrmLpQTA2nGjKqLn4T8Fs5jKyfvhbEL67RzB6Tu
DEyW3gMyc4X/EDj2HRu6A16d+BVpH8vlB5QGv1jhbEkj2nvGh68wzncSYX19J/g7
EFsS1pHtD511ev5ExtvHOHctgF9FCU/ZBe2l2S1NIdM4Jkyp0xtN59HuV9QON5Fh
twn8ZdY96zzbzgddpo25MQO6TesiKaH4vlhjdgQH4alBGnugGZQ24b2OJK4zSAz9
TaAw024OWac15DBTx6iERpsTESai1NFugPPAJJUubpBiYoqk6Lsc5e1qdqQbkIhr
1WU3WccMa8qNYvj65LeV5kEaviBEeA==
=fx7U
-----END PGP SIGNATURE-----

--h6iwozxdrwyrxrsn--

