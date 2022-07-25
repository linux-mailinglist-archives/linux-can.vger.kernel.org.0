Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9996A5805F9
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 22:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiGYUxj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 16:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiGYUxi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 16:53:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16254140B8
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 13:53:38 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oG555-0005fd-Uc; Mon, 25 Jul 2022 22:53:35 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DDD1BB9E35;
        Mon, 25 Jul 2022 20:53:34 +0000 (UTC)
Date:   Mon, 25 Jul 2022 22:53:34 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH 4/9] can: softing: add DRV_NAME to replace hardcoded names
Message-ID: <20220725205334.zf64w2lrpnrr4zad@pengutronix.de>
References: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
 <20220725153124.467061-5-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qg2o3te6j4rgtuba"
Content-Disposition: inline
In-Reply-To: <20220725153124.467061-5-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--qg2o3te6j4rgtuba
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2022 00:31:19, Vincent Mailhol wrote:
> The driver uses the string "softing" to populate platform_driver::name
> and can_bittiming_const::name. Add a new macro DRV_NAME which
> evaluates to "ems_ubs" and then use DRV_NAME and to get rid on the
> hardcoded string names.
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/softing/softing_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/sof=
ting/softing_main.c
> index 8d27ac66ca7f..d810fe6915a4 100644
> --- a/drivers/net/can/softing/softing_main.c
> +++ b/drivers/net/can/softing/softing_main.c
> @@ -11,6 +11,7 @@
> =20
>  #include "softing.h"
> =20
> +#define DRV_NAME "softing"
>  #define TX_ECHO_SKB_MAX (((TXMAX+1)/2)-1)
> =20
>  /*
> @@ -612,7 +613,7 @@ static const struct net_device_ops softing_netdev_ops=
 =3D {
>  };
> =20
>  static const struct can_bittiming_const softing_btr_const =3D {
> -	.name =3D "softing",
> +	.name =3D DRV_NAME,

KBUILD_MODNAME works here, too.

>  	.tseg1_min =3D 1,
>  	.tseg1_max =3D 16,
>  	.tseg2_min =3D 1,
> @@ -846,7 +847,7 @@ static int softing_pdev_probe(struct platform_device =
*pdev)
> =20
>  static struct platform_driver softing_driver =3D {
>  	.driver =3D {
> -		.name =3D "softing",
> +		.name =3D DRV_NAME,

same here

>  	},
>  	.probe =3D softing_pdev_probe,
>  	.remove =3D softing_pdev_remove,
> --=20
> 2.35.1
>=20
>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--qg2o3te6j4rgtuba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLfAssACgkQrX5LkNig
013/NQgAm3Vn8DiRVjXbZOLwwWSX+gYKSpKlbEQNy75eW6cqvOEgs8mrjI5I/uve
AcoEx0GsR8PVh1dsjsBcUglQlEIMgYup4mLkNv804DAebF8Gu+gRactXLkQzlJYN
SMnlVdVCX43dt1onv9+mwYpDUHUkQs8QTM7z6fifgE0XG37T8HlDDBzTWbXQuYrK
8EhZDT+CsBmnciyT4RA3atasaI0v8DFKpxSMtxQ2XNrJ6YeHqO7UScSfbsSRMi+S
LNiyU6nzIxBYPtobn7UwoT5EJEs/kxP+Cypi7Q9IM6c7mtxd068npncfu5bQMp3/
ov02C+rBcDCt8mUAFXq21j4ftN8erQ==
=EgKD
-----END PGP SIGNATURE-----

--qg2o3te6j4rgtuba--
