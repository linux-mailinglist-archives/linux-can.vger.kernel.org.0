Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0334458F23
	for <lists+linux-can@lfdr.de>; Mon, 22 Nov 2021 14:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbhKVNKI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Nov 2021 08:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbhKVNKG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Nov 2021 08:10:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A07C061748
        for <linux-can@vger.kernel.org>; Mon, 22 Nov 2021 05:06:59 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mp91z-0001ZE-Uu; Mon, 22 Nov 2021 14:06:47 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-c7fb-0fe8-e8cb-8e33.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:c7fb:fe8:e8cb:8e33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 937536B2CF5;
        Mon, 22 Nov 2021 13:06:46 +0000 (UTC)
Date:   Mon, 22 Nov 2021 14:06:45 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH RFC v2 4/4] phy: phy-can-transceiver: Add support for
 setting mux
Message-ID: <20211122130645.3dkhzneakbjdcynm@pengutronix.de>
References: <20211122125624.6431-1-a-govindraju@ti.com>
 <20211122125624.6431-5-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oqpw7laziakkmvw"
Content-Disposition: inline
In-Reply-To: <20211122125624.6431-5-a-govindraju@ti.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--2oqpw7laziakkmvw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.11.2021 18:26:24, Aswath Govindraju wrote:
> On some boards, for routing CAN signals from controller to transceiver,
> muxes might need to be set. Therefore, add support for setting the mux by
> reading the mux-controls property from the device tree node.
>=20
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/phy/phy-can-transceiver.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-tran=
sceiver.c
> index 6f3fe37dee0e..15056b9d68ba 100644
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
> @@ -21,13 +22,23 @@ struct can_transceiver_phy {
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
> +		ret =3D mux_control_select(can_transceiver_phy->mux_ctrl,
> +					 mux_control_enable_state(can_transceiver_phy->mux_ctrl));
> +		if (ret) {
> +			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
> +			return ret;
> +		}
> +	}
>  	if (can_transceiver_phy->standby_gpio)
>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
>  	if (can_transceiver_phy->enable_gpio)
> @@ -45,6 +56,8 @@ static int can_transceiver_phy_power_off(struct phy *ph=
y)
>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
>  	if (can_transceiver_phy->enable_gpio)
>  		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
> +	if (can_transceiver_phy->mux_ctrl)
> +		mux_control_deselect(can_transceiver_phy->mux_ctrl);
> =20
>  	return 0;
>  }
> @@ -95,6 +108,19 @@ static int can_transceiver_phy_probe(struct platform_=
device *pdev)
>  	match =3D of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
>  	drvdata =3D match->data;
> =20
> +	if (of_property_read_bool(dev->of_node, "mux-controls")) {
> +		struct mux_control *control;
> +		int ret;
> +
> +		control =3D devm_mux_control_get(dev, NULL);
> +		if (IS_ERR(control)) {
> +			ret =3D PTR_ERR(control);
> +			dev_err_probe(&pdev->dev, ret, "failed to get mux\n");
> +			return PTR_ERR(control);
> +		}

	if (IS_ERR(control))
		return dev_err_probe(&pdev, PTR_ERR(control),
                        "failed to get mux\n");

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

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2oqpw7laziakkmvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGbleIACgkQqclaivrt
76lZYwf+LCpeXxyv+nkG2BtcQzm3Bz0OFT1tL7ZZVBG71SlA7mhy8apJ5VsSUFoU
yCyS4DlwBBeaP/nmA8hThpOn/ivCmA1vugtbe7fmJEmW6AAUnZ1cJC0f2080BgXX
ehVlh2TYvctmj2wgGfhkF0lg6gLmxtQl7gTK/eFL86LajEUFXsqsL2v62fCg7dvk
eAP/OhlSFpPv6xXh/5FXH22yNTj3qauauk0c0h8U1bZmFEQE7i8bR9gzcaZe1eal
/qyoMZ4O8t2xOhdLTscZeZ42hGWYXyE3gvS8AT5juLY8VqskwHTq3pCN20tPafbz
I+iVkVjMyWf+XU5wGMrI0xcqpHSM4A==
=ZLad
-----END PGP SIGNATURE-----

--2oqpw7laziakkmvw--
