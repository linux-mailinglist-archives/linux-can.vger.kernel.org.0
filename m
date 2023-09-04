Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC22B791636
	for <lists+linux-can@lfdr.de>; Mon,  4 Sep 2023 13:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjIDLY2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Sep 2023 07:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352797AbjIDLYZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Sep 2023 07:24:25 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171D8EC
        for <linux-can@vger.kernel.org>; Mon,  4 Sep 2023 04:24:22 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qd7QZ-0003VO-GV; Mon, 04 Sep 2023 13:07:31 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 14BC8218474;
        Mon,  4 Sep 2023 11:07:31 +0000 (UTC)
Date:   Mon, 4 Sep 2023 13:07:30 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        Lizhi Hou <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] of: overlay: Fix of_overlay_fdt_apply prototype when
 !CONFIG_OF_OVERLAY
Message-ID: <20230904-kebab-ladle-cb9db3ecf58f-mkl@pengutronix.de>
References: <20230904100002.7913-1-pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qgiehgcd3yqtpsgd"
Content-Disposition: inline
In-Reply-To: <20230904100002.7913-1-pisa@cmp.felk.cvut.cz>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--qgiehgcd3yqtpsgd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.09.2023 12:00:02, Pavel Pisa wrote:
> The of_overlay_fdt_apply has been changed but when CONFIG_OF_OVERLAY
> support is not configured then old stub prototype is declared
> by of.h header.
>=20
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

You please add:

Fixes: 47284862bfc7 ("of: overlay: Extend of_overlay_fdt_apply() to specify=
 the target node")
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

> ---
>  include/linux/of.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/of.h b/include/linux/of.h
> index ed679819c279..6a9ddf20e79a 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1676,8 +1676,8 @@ int of_overlay_notifier_unregister(struct notifier_=
block *nb);
> =20
>  #else
> =20
> -static inline int of_overlay_fdt_apply(void *overlay_fdt, u32 overlay_fd=
t_size,
> -				       int *ovcs_id)
> +static inline int of_overlay_fdt_apply(const void *overlay_fdt, u32 over=
lay_fdt_size,
> +				       int *ovcs_id, struct device_node *target_base)
>  {
>  	return -ENOTSUPP;
>  }
> --=20
> 2.39.2
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qgiehgcd3yqtpsgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmT1um8ACgkQvlAcSiqK
BOhpRQf+JHbOWDt//XdSpUm6e9wqWIYBNXaKGbsGV3+zyr2n0ZU07Pb2Ipm7c+bn
AFcFDnJaoUm0/b9OwdMicJJU0Vb7kif7+LAgsEVdUVVLQmc0feje8PeZGji274ga
04rYU92BYBziyoeZlhLc9X9iiv7V4aKHZgApsvrb5Mf1tN0BVRX4QzrMZfauxuR0
+Uh9S6qqXOgGb9uEo9bwL7SZ507dDWdYeOjmUdO8qJVJPzHPvOYzLM2/aWmwCrTw
GT3MB1jMQa/a3/w1FMUzcw6pzqRIB9Vlv88ULeHYytFggZx5p+U5z/7WL8OedQbQ
5nMOlo04DX9QYB3fQJl7UVo2RPmkUg==
=lL2s
-----END PGP SIGNATURE-----

--qgiehgcd3yqtpsgd--
