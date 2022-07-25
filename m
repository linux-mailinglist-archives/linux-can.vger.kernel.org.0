Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A225805E4
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 22:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiGYUqa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 16:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGYUq3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 16:46:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB546420
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 13:46:28 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oG4y7-0004zJ-8J; Mon, 25 Jul 2022 22:46:23 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2B588B9E23;
        Mon, 25 Jul 2022 20:46:20 +0000 (UTC)
Date:   Mon, 25 Jul 2022 22:46:18 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Frank Jungclaus <frank.jungclaus@esd.eu>
Subject: Re: [PATCH 5/9] can: esd_usb: use KBUILD_MODNAME instead of hard
 coded name
Message-ID: <20220725204618.46raedk5bzujz64j@pengutronix.de>
References: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
 <20220725153124.467061-6-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vy56e7bxmyu5jmy5"
Content-Disposition: inline
In-Reply-To: <20220725153124.467061-6-mailhol.vincent@wanadoo.fr>
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


--vy56e7bxmyu5jmy5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2022 00:31:20, Vincent Mailhol wrote:
> The driver uses the string "ems_usb" to populate
> usb_driver::name. KBUILD_MODNAME also evaluates to "esd_ubs". Use
> KBUILD_MODNAME and get rid on the hardcoded string names.
>=20
> CC: Frank Jungclaus <frank.jungclaus@esd.eu>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/usb/ems_usb.c | 4 ++--
>  drivers/net/can/usb/esd_usb.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
> index 89a64e05cbd7..e86a2033db60 100644
> --- a/drivers/net/can/usb/ems_usb.c
> +++ b/drivers/net/can/usb/ems_usb.c
> @@ -880,7 +880,7 @@ static const struct net_device_ops ems_usb_netdev_ops=
 =3D {
>  };
> =20
>  static const struct can_bittiming_const ems_usb_bittiming_const =3D {
> -	.name =3D KBUILD_NAME,
> +	.name =3D KBUILD_MODNAME,
>  	.tseg1_min =3D 1,
>  	.tseg1_max =3D 16,
>  	.tseg2_min =3D 1,
> @@ -1074,7 +1074,7 @@ static void ems_usb_disconnect(struct usb_interface=
 *intf)
> =20
>  /* usb specific object needed to register this driver with the usb subsy=
stem */
>  static struct usb_driver ems_usb_driver =3D {
> -	.name =3D KBUILD_NAME,
> +	.name =3D KBUILD_MODNAME,

These 2 hunks should go into patch 2.

Marc

>  	.probe =3D ems_usb_probe,
>  	.disconnect =3D ems_usb_disconnect,
>  	.id_table =3D ems_usb_table,
> diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
> index 177ed33e08d9..7b849bd3cc9c 100644
> --- a/drivers/net/can/usb/esd_usb.c
> +++ b/drivers/net/can/usb/esd_usb.c
> @@ -1138,7 +1138,7 @@ static void esd_usb_disconnect(struct usb_interface=
 *intf)
> =20
>  /* usb specific object needed to register this driver with the usb subsy=
stem */
>  static struct usb_driver esd_usb_driver =3D {
> -	.name =3D "esd_usb",
> +	.name =3D KBUILD_MODNAME,
>  	.probe =3D esd_usb_probe,
>  	.disconnect =3D esd_usb_disconnect,
>  	.id_table =3D esd_usb_table,
> --=20
> 2.35.1
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vy56e7bxmyu5jmy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLfARgACgkQrX5LkNig
013pqQf8D7NKjPamEkrJ9it6TBcm9i913Yd+ZpRx5V6P/LZqiBgKTvesbVE2Dnq+
y5ary2aQBX0/V4o4xE80yDNAgYYO0tXS3EESsTsbgfDXNIlDUFV2lTTK61NbzPXJ
9oYDr7kCElEy+d25EVPDjMmsT0/lWtmz9Lfxu46izjd7nptPB5CxM/Kr05lpvV9r
2/JBt3CKddUx57zX5DSh8ADRnXCMYUgirTk4BaNoHvPt23TSop1wiij0huetP/0Y
xgznG0ZcVSngEKeB5bcjogFryNeqRQvCd1/0CYSZKlnDsIJskPJ1Nt5NFyG5isFt
RYg+YWmZO1Yetned+C7PSO0kIaF8/w==
=IonV
-----END PGP SIGNATURE-----

--vy56e7bxmyu5jmy5--
