Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057CF44E35F
	for <lists+linux-can@lfdr.de>; Fri, 12 Nov 2021 09:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhKLIne (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Nov 2021 03:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhKLInd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Nov 2021 03:43:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3557CC061766
        for <linux-can@vger.kernel.org>; Fri, 12 Nov 2021 00:40:43 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mlS6o-0007Ca-BP; Fri, 12 Nov 2021 09:40:30 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-de63-3764-bcb9-a107.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:de63:3764:bcb9:a107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CF6296AA391;
        Fri, 12 Nov 2021 08:40:27 +0000 (UTC)
Date:   Fri, 12 Nov 2021 09:40:27 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH RFC 2/2] phy: phy-can-transceiver: Add support for
 setting mux
Message-ID: <20211112084027.b2t2beqiiodnwjtv@pengutronix.de>
References: <20211111164313.649-1-a-govindraju@ti.com>
 <20211111164313.649-3-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7j22je4qercubawa"
Content-Disposition: inline
In-Reply-To: <20211111164313.649-3-a-govindraju@ti.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--7j22je4qercubawa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.11.2021 22:13:12, Aswath Govindraju wrote:
> On some boards, for routing CAN signals from controller to transceiver,
> muxes might need to be set. Therefore, add support for setting the mux by
> reading the mux-controls property from the device tree node.
>=20
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/phy/phy-can-transceiver.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-tran=
sceiver.c
> index 6f3fe37dee0e..3d8da5226e27 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -10,6 +10,7 @@
>  #include<linux/module.h>
>  #include<linux/gpio.h>
>  #include<linux/gpio/consumer.h>
> +#include <linux/mux/consumer.h>
> =20
>  struct can_transceiver_data {
>  	u32 flags;
> @@ -21,13 +22,22 @@ struct can_transceiver_phy {
>  	struct phy *generic_phy;
>  	struct gpio_desc *standby_gpio;
>  	struct gpio_desc *enable_gpio;
> +	struct mux_control *mux_ctrl;
>  };
> =20
>  /* Power on function */
>  static int can_transceiver_phy_power_on(struct phy *phy)
>  {
> +	int ret;
>  	struct can_transceiver_phy *can_transceiver_phy =3D phy_get_drvdata(phy=
);
> =20
> +	if (can_transceiver_phy->mux_ctrl) {
> +		ret =3D mux_control_select(can_transceiver_phy->mux_ctrl, 1);

Hard coding the "1" looks wrong here. I have seen some boards where you
can select between a CAN-2.0 and a single wire CAN transceiver with a
mux. So I think we cannot hard code the "1" here.

> +		if (ret) {
> +			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
> +			return ret;
> +		}
> +	}
>  	if (can_transceiver_phy->standby_gpio)
>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
>  	if (can_transceiver_phy->enable_gpio)
> @@ -45,6 +55,8 @@ static int can_transceiver_phy_power_off(struct phy *ph=
y)
>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
>  	if (can_transceiver_phy->enable_gpio)
>  		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
> +	if (can_transceiver_phy->mux_ctrl)
> +		mux_control_deselect(can_transceiver_phy->mux_ctrl);
> =20
>  	return 0;
>  }
> @@ -95,6 +107,15 @@ static int can_transceiver_phy_probe(struct platform_=
device *pdev)
>  	match =3D of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
>  	drvdata =3D match->data;
> =20
> +	if (of_property_read_bool(dev->of_node, "mux-controls")) {

Is this the proper way of doing this? Looks like we need a
devm_mux_control_get_optional(), which doesn't return a -ENODEV if the
device doesn't exist.

Cc'ed Peter Rosin.

> +		struct mux_control *control;
> +
> +		control =3D devm_mux_control_get(dev, NULL);
> +		if (IS_ERR(control))
> +			return PTR_ERR(control);

What about making use of dev_err_probe()?

> +		can_transceiver_phy->mux_ctrl =3D control;
> +	}
> +
>  	phy =3D devm_phy_create(dev, dev->of_node,
>  			      &can_transceiver_phy_ops);
>  	if (IS_ERR(phy)) {
> --=20
> 2.17.1
>=20
>

Regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--7j22je4qercubawa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGOKHgACgkQqclaivrt
76krsgf9HZyC31LNyXDMlw5iHHC/MjqR3DUT87FwBU5xiFUcgGq6QjNRUKF6b162
P0VpnrQR3dTA/dZDN4MPfgUZeLxH88QuhcAQAN3PVWU5CQd/njoI/O1Idk7+F1BS
QyVGGXV2EEMovB9ZD5xqiZ/9uBrrLvv278lHKxhZN6GFR+UV+0PKbOeJWzMmWafx
6p+ql/gYigs44hYs5WwGHAFiwT5Poisk5qA4E7kzG542PyiKW14+YxyYooBXbCV+
9Wss9w+3lgdgfDykYmVS961utCwlKwMGcojyxsVCao1+7VuqZb9lT8bMdaX1cqlD
uexl6a2K8MrvoKwNELhqCjfvp9vIKA==
=/gnY
-----END PGP SIGNATURE-----

--7j22je4qercubawa--
