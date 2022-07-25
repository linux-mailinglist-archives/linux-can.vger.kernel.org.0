Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D545805F4
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 22:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiGYUuq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 16:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiGYUup (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 16:50:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9B9140B7
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 13:50:45 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oG52J-0005J9-56; Mon, 25 Jul 2022 22:50:43 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5E523B9E2B;
        Mon, 25 Jul 2022 20:50:42 +0000 (UTC)
Date:   Mon, 25 Jul 2022 22:50:39 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH 7/9] can: softing: add DRV_NAME to replace hardcoded names
Message-ID: <20220725205039.pyza7hd5cw6hnltt@pengutronix.de>
References: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
 <20220725153124.467061-8-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="264ofefyexwvo2u5"
Content-Disposition: inline
In-Reply-To: <20220725153124.467061-8-mailhol.vincent@wanadoo.fr>
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


--264ofefyexwvo2u5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2022 00:31:22, Vincent Mailhol wrote:
> The driver uses the string "kvaser_usb" to populate
> usb_driver::name. Add a new macro DRV_NAME which evaluates to
> "ems_ubs" and then use DRV_NAME and to get rid on the hardcoded string
> names.
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/n=
et/can/usb/kvaser_usb/kvaser_usb_core.c
> index f211bfcb1d97..a6cff8da5a41 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> @@ -29,6 +29,8 @@
> =20
>  #include "kvaser_usb.h"
> =20
> +#define DRV_NAME "kvaser_usb"
> +
>  /* Kvaser USB vendor id. */
>  #define KVASER_VENDOR_ID			0x0bfd
> =20
> @@ -869,7 +871,7 @@ static void kvaser_usb_disconnect(struct usb_interfac=
e *intf)
>  }
> =20
>  static struct usb_driver kvaser_usb_driver =3D {
> -	.name =3D "kvaser_usb",
> +	.name =3D DRV_NAME,
>  	.probe =3D kvaser_usb_probe,
>  	.disconnect =3D kvaser_usb_disconnect,
>  	.id_table =3D kvaser_usb_table,

KBUILD_MODNAME works here, too. I just checked with:

| make drivers/net/can/usb/kvaser_usb/kvaser_usb_core.i
| grep -A5 "struct usb_driver kvaser_usb_driver" drivers/net/can/usb/kvaser=
_usb/kvaser_usb_core.i
| static struct usb_driver kvaser_usb_driver =3D {
|  .name =3D "kvaser_usb",
|  .probe =3D kvaser_usb_probe,
|  .disconnect =3D kvaser_usb_disconnect,
|  .id_table =3D kvaser_usb_table,
| };

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--264ofefyexwvo2u5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLfAh0ACgkQrX5LkNig
01208gf+JAzSiAba0wIzRWaSA3I0Y/i4Lk/AFziV2hV2gCNGhKOFlGJlyC5Z38qU
d3WCXrDpZ8KJkzLg6pNNxKAzGy9CFJQ9HJO8DFL4NokVKdH60bdOce0a1y92aBRi
pMPLtqUYXP82zx9coBXsbfsGOlLOVRFCYqS2b2cq58Ew/g2w2oWkx22/f+cs34GW
A45vKDmRZ7mfJn4tyNwetbFs7WuJ5LVhYhqk3AdYdMQemNDZeABkYzduoFZSnkZg
pA7TUPvbrbKrYYp1gpLjjCMhuVv9WpHEZ5WOWY7xfkwHMWohIIZhFiKoU6azhl6G
aRiR6j6YiSu8ROl/Bhc8SdPpSaLUJg==
=sGqW
-----END PGP SIGNATURE-----

--264ofefyexwvo2u5--
