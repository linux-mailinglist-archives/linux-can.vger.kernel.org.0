Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFB446D1EE
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 12:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhLHLVO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 06:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhLHLVO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 06:21:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EEDC061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 03:17:42 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1muuxA-0000Au-El; Wed, 08 Dec 2021 12:17:40 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-e45e-c028-b01c-c307.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:e45e:c028:b01c:c307])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2EF686BFAAD;
        Wed,  8 Dec 2021 11:17:39 +0000 (UTC)
Date:   Wed, 8 Dec 2021 12:17:38 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH v2 3/3] can: kvaser_usb: Get CAN clock frequency from
 device
Message-ID: <20211208111738.d4gb3n4axxmt7kil@pengutronix.de>
References: <20211208110940.185629-1-extja@kvaser.com>
 <20211208110940.185629-4-extja@kvaser.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zsf7jhjbbhkufzsj"
Content-Disposition: inline
In-Reply-To: <20211208110940.185629-4-extja@kvaser.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--zsf7jhjbbhkufzsj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.12.2021 12:09:40, Jimmy Assarsson wrote:
> Get the CAN clock frequency from device, since the various Kvaser Leaf
> products use different CAN clocks.
>=20
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
> Changes in v2:
>   - Rebased on [PATCH v5 0/5] fix statistics and payload issues for
>     error [1] series.
>=20
> [1]
> https://lore.kernel.org/all/20211207121531.42941-1-mailhol.vincent@wanado=
o.fr
>=20
>  .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 69 ++++++++++++++++---
>  1 file changed, 60 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/n=
et/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index 533e25cb4337..093c092226b6 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -29,10 +29,12 @@
> =20
>  #include "kvaser_usb.h"
> =20
> -/* Forward declaration */
> -static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg;
> +/* Forward declarations */
> +static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_8mhz;
> +static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_16mhz;
> +static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_24mhz;
> +static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_32mhz;

Can you re-arrange the code, so that you don't need the forward
declarations?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--zsf7jhjbbhkufzsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGwlE8ACgkQqclaivrt
76k5Jgf/YW2YOoxhtorkcrFqF5TsSMYc8eTeW3KlCHHlub9afuWiOOhGbnI1TayJ
dW/YhZ2fH6wMvqxJLfH9fgZz9Lh7OoUP2DNyEPp2LIcS9vOSTBAiHXtcMOU8VRfG
636ztcNzlVuq4ol1qOHPmfCKpunmDarspiUzHlUAX1daS5wIylCmRCx+2dO/Q/nK
gqmWyBJf8MNBGHB7dMUuyHwdHVagXuXmc53XYQd+1rhkqks6Gq3cepVw70xVb02J
rIV/DnyqcVwbCOB3pIyonHJ9AD+1EOQHOK4TNVw2NViYi3N51z7E/z/bAktfrOQy
8FVtD2HdklCU4lbx8USGnWaA0knWow==
=XCWH
-----END PGP SIGNATURE-----

--zsf7jhjbbhkufzsj--
