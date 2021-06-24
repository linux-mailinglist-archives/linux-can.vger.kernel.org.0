Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556EB3B2CE7
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 12:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhFXKw2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 06:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhFXKw1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Jun 2021 06:52:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CAEC061574
        for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 03:50:09 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lwMvv-0001CV-H3; Thu, 24 Jun 2021 12:50:07 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:47f5:be86:773e:3d3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 61983642AE2;
        Thu, 24 Jun 2021 10:50:06 +0000 (UTC)
Date:   Thu, 24 Jun 2021 12:50:05 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 3/3] can-calc-bittiming: add mcan
Message-ID: <20210624105005.2kgj6o5hwskl6rqo@pengutronix.de>
References: <20210624031954.26195-1-dev.kurt@vandijck-laurijssen.be>
 <20210624031954.26195-3-dev.kurt@vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kihqoxcs6p3kluj7"
Content-Disposition: inline
In-Reply-To: <20210624031954.26195-3-dev.kurt@vandijck-laurijssen.be>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--kihqoxcs6p3kluj7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.06.2021 05:19:54, Kurt Van Dijck wrote:
> Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> ---
>  can-calc-bit-timing.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
> index d0626f7..fd37886 100644
> --- a/can-calc-bit-timing.c
> +++ b/can-calc-bit-timing.c
> @@ -307,6 +307,23 @@ static void printf_btr_c_can(struct can_bittiming *b=
t, bool hdr)
>  	}
>  }
> =20
> +static void printf_btr_mcan(struct can_bittiming *bt, bool hdr)
> +{
> +	if (hdr) {
> +		printf("%10s", "NBTP");
> +	} else {
> +		uint32_t nbtp;
> +
> +
> +		nbtp =3D (((bt->brp -1) & 0x1ff) << 16) |
> +			(((bt->sjw -1) & 0x7f) << 25) |
> +			(((bt->prop_seg + bt->phase_seg1 -1) & 0xff) << 8) |
> +			(((bt->phase_seg2 -1) & 0x7f) << 0);
> +
> +		printf("0x%08x", nbtp);
> +	}
> +}
> +
>  static struct calc_bittiming_const can_calc_consts[] =3D {
>  	{
>  		.bittiming_const =3D {
> @@ -483,6 +500,22 @@ static struct calc_bittiming_const can_calc_consts[]=
 =3D {
>  			{ .clk =3D 24000000, },
>  		},
>  		.printf_btr =3D printf_btr_c_can,
> +	}, {
> +		.bittiming_const =3D {
> +			.name =3D "mcan",

This is for mcan > v3.1

> +			.tseg1_min =3D 1,
> +			.tseg1_max =3D 256,
> +			.tseg2_min =3D 1,

I just re-chcked the datasheet, and tseg{1,2} min are actually 2.

> +			.tseg2_max =3D 128,
> +			.sjw_max =3D 128,
> +			.brp_min =3D 1,
> +			.brp_max =3D 512,
> +			.brp_inc =3D 1,
> +		},
> +		.ref_clk =3D {
> +			{ .clk =3D 40000000, },
> +		},
> +		.printf_btr =3D printf_btr_mcan,
>  	},
>  };

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--kihqoxcs6p3kluj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDUY1sACgkQqclaivrt
76n3gAgAoQmN6Yx7hnW2RF70H8n2D/0gcQVXalXWcFlHY1MdmgFBoiclwO2wxSPP
5BaBPYhRfM+t4Ucvr+gOqGLLD35ArALZsVLmtGFLnGVvJQJ4Pennjym5MyIJ5xZU
Fdbv8fAL4tSGU6aqfSpuNDCqNr6h/g2vz5dVaDxTig2m9i4WHzKiGAXwhvaysmi1
ZsE45FM0Wnt3QYJVDYQ0UFGuquxkM8paortBenp9D12geWX4tpuY2wqKa++QB3FY
FGMfHWs3E96jADbyMnt67f2/zvRYAFFDgeyrOcyVwouQi6+5BB960TBS8eRCgBzz
oDGsflvtBoOvtVjlIk557oBUdKOmpA==
=lPOF
-----END PGP SIGNATURE-----

--kihqoxcs6p3kluj7--
