Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BA05BDE9F
	for <lists+linux-can@lfdr.de>; Tue, 20 Sep 2022 09:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiITHoO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Sep 2022 03:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiITHnv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Sep 2022 03:43:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CF261DA9
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 00:42:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oaXtg-0004aj-EO; Tue, 20 Sep 2022 09:42:24 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:5f01:4019:fc9a:d27f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B2A87E6A8C;
        Mon, 19 Sep 2022 19:33:51 +0000 (UTC)
Date:   Mon, 19 Sep 2022 21:33:43 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "Trevitz, Daniel" <Daniel.Trevitz@wika.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Ryan Edwards <ryan.edwards@gmail.com>
Subject: Re: [PATCH v2 3/3] can: gs_usb: add switchable termination support
Message-ID: <20220919193343.jcepx2lccia6lmdn@pengutronix.de>
References: <20220918211802.692405-1-mkl@pengutronix.de>
 <20220918211802.692405-4-mkl@pengutronix.de>
 <46b828feda4c4ef3bf978dd186b094af@wika.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xsw2dn3ofe24lvx2"
Content-Disposition: inline
In-Reply-To: <46b828feda4c4ef3bf978dd186b094af@wika.com>
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


--xsw2dn3ofe24lvx2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.09.2022 17:14:39, Trevitz, Daniel wrote:
> +       if (feature & GS_CAN_FEATURE_TERMINATION) {
> +               dev->can.termination_const =3D gs_usb_termination_const;
> +               dev->can.termination_const_cnt =3D ARRAY_SIZE(gs_usb_term=
ination_const);
> +               dev->can.do_set_termination =3D gs_usb_set_termination;
> +
> +               rc =3D gs_usb_get_termination(netdev, &dev->can.terminati=
on);
> +               if (rc) {
> +                       dev_err(&intf->dev,
> +                               "Couldn't get current termination state f=
or channel %d (%pe)\n",
> +                               channel, ERR_PTR(rc));
> +                       goto out_free_candev;
> +               }
> +       }
>=20
> Does it make sense to check if we have the termination support, then
> set the values? My logic is that just because the termination is not
> working correctly, it does not mean everything is broken.

Makes sense!

> This way you could have a multi-can-channel USB device but with only
> specific channels supporting configurable termination resistors.

At least from the Linux driver's perspective the feature bits are per
channel not per device.

> Something like:
>=20
> rc =3D gs_usb_get_termination(netdev, &dev->can.termination);
>  if (rc) {
> 	dev_err(&intf->dev,
> 		"Couldn't get current termination state for channel %d (%pe). Not enabl=
ing termination support for this channel\n",
> 		channel, ERR_PTR(rc));
>  } else {
> 	dev->can.termination_const =3D gs_usb_termination_const;
> 	dev->can.termination_const_cnt =3D ARRAY_SIZE(gs_usb_termination_const);
> 	dev->can.do_set_termination =3D gs_usb_set_termination;
> }

I've reduced the dev_err() to dev_info() and tried to keep the error
message short. Also I remove the termination feature flag. The
incremental patch looks like this:

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 5c988e528734..b0273fab1843 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1287,16 +1287,17 @@ static struct gs_can *gs_make_candev(unsigned int c=
hannel,
        }
=20
        if (feature & GS_CAN_FEATURE_TERMINATION) {
-               dev->can.termination_const =3D gs_usb_termination_const;
-               dev->can.termination_const_cnt =3D ARRAY_SIZE(gs_usb_termin=
ation_const);
-               dev->can.do_set_termination =3D gs_usb_set_termination;
-
                rc =3D gs_usb_get_termination(netdev, &dev->can.termination=
);
                if (rc) {
-                       dev_err(&intf->dev,
-                               "Couldn't get current termination state for=
 channel %d (%pe)\n",
-                               channel, ERR_PTR(rc));
-                       goto out_free_candev;
+                       dev->feature &=3D ~GS_CAN_FEATURE_TERMINATION;
+
+                       dev_info(&intf->dev,
+                                "Disabling termination support for channel=
 %d (%pe)\n",
+                                channel, ERR_PTR(rc));
+               } else {
+                       dev->can.termination_const =3D gs_usb_termination_c=
onst;
+                       dev->can.termination_const_cnt =3D ARRAY_SIZE(gs_us=
b_termination_const);
+                       dev->can.do_set_termination =3D gs_usb_set_terminat=
ion;
                }
        }

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xsw2dn3ofe24lvx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMoxBMACgkQrX5LkNig
011yGwf/Qt+m+5nqS4i+8fEeRyNUg1H4/Q9CYBbZQSTXrNdrZrNIiiR46XYX47VD
ftDMwVkVYXRR2WF8VArPwuVskTzmmfCrZ2ldecYBYct8fqrP+i4d/XvUhhLKhOAt
b1dVmBhZlwRPVuDMaIEFw2KdhhMEeR3Gtv3aJQdxKJsHrWTcoIjKGoibLz/7NVlG
TltQ+2GJSwRbtwiGRgA4h6YwxqXKn18mjGnwYJuEFPirie6SyLISOWlieEh4N2rG
oC8TInhPlIfgY92m3rvJjjjKCB7/zpndWBjJUQLn9WW0eRWpbqgWGB5/68xTNBIs
/V9BO4NrwyUAKiqZzi8QmmdcIa4ECw==
=z5yq
-----END PGP SIGNATURE-----

--xsw2dn3ofe24lvx2--
