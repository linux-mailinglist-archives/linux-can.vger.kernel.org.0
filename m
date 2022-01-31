Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D34B4A47C7
	for <lists+linux-can@lfdr.de>; Mon, 31 Jan 2022 14:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378529AbiAaNJS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 Jan 2022 08:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378521AbiAaNJR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 31 Jan 2022 08:09:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775F3C061714
        for <linux-can@vger.kernel.org>; Mon, 31 Jan 2022 05:09:17 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nEWQl-0004jm-Vi; Mon, 31 Jan 2022 14:09:16 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 60A9A285E8;
        Mon, 31 Jan 2022 13:09:15 +0000 (UTC)
Date:   Mon, 31 Jan 2022 14:09:11 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     petter@ka-long.de
Cc:     linux-can@vger.kernel.org
Subject: Re: MCP2518FD : Failed to detect MCP2518FD (osc=0x00000000)
Message-ID: <20220131130911.nyfg5ojq77hbqc7d@pengutronix.de>
References: <20220131083304.122C45B0007E@dd15738.kasserver.com>
 <20220131084205.53otmukeyt2dt4zj@pengutronix.de>
 <20220131093554.505C65B0025F@dd15738.kasserver.com>
 <20220131095849.5iw4jgeexc3egnb6@pengutronix.de>
 <20220131124428.B17CE5B0007E@dd15738.kasserver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yuo4tni7ycqx3sjt"
Content-Disposition: inline
In-Reply-To: <20220131124428.B17CE5B0007E@dd15738.kasserver.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--yuo4tni7ycqx3sjt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.01.2022 13:44:28, petter@ka-long.de wrote:
> DMA is disabled. CLK and MOSI are looking fine.
>=20
> Very interessing, CSs are not asserted when loading driver (on old
> kernel it does), but I can measure "high" after HW initialisation.

Asserted means low?

> Since I did not change the IOs between the old and new device tree
> assuming the "high" on CS also showing correct PAD / GPIO
> configuration there seems a problem asserting the CS.

| &ecspi2 {
|         pinctrl-names =3D "default";
|         pinctrl-0 =3D <&pinctrl_ecspi2>;
|         status =3D "okay";
|=20
|         fsl,spi-num-chipselects =3D <2>;
                           V
|         cs-gpios =3D <&gpio5 1 0>, <&gpio1 3 0>;
                               ^             ^
Have a look at include/dt-bindings/gpio/gpio.h:

/* Bit 0 express polarity */
#define GPIO_ACTIVE_HIGH 0
#define GPIO_ACTIVE_LOW 1

I'm using GPIO_ACTIVE_LOW in my DT on imx6dl.

|                             =20
|=20
|         mcp2518fd@0 {
|                 compatible =3D "microchip,mcp2518fd";
|                 reg =3D <0>;
|                 interrupts-extended =3D <&gpio3 0 IRQ_TYPE_LEVEL_LOW>;
|                 spi-max-frequency =3D <20000000>;
|                 clocks =3D <&mcp2518fd_clk>;
|         };                                                               =
                                                                           =
                                                                           =
                                =20
|=20
|         mcp2518fd@1 {
|                 compatible =3D "microchip,mcp2518fd";
|                 reg =3D <1>;
|                 interrupts-extended =3D <&gpio4 23 IRQ_TYPE_LEVEL_LOW>;
|                 spi-max-frequency =3D <20000000>;
|                 clocks =3D <&mcp2518fd_clk>;
|         };                                                               =
                                                                           =
                                                                           =
                                =20
| };          =20

> cat /sys/kernel/debug/gpio looks good (gpio-3 and gpio-129)

This doesn't look consistent with your DT, above. I'm always confused
with numbering starting with 0 and 1 in the DT, but I think:

gpiochip0: gpio-3       =3D=3D &gpio1 3
gpiochip3: gpio-129     =3D=3D &gpio4 1     (not &gpio5 1 as in you DT)

> gpiochip0: GPIOs 0-31, parent: platform/30200000.gpio, 30200000.gpio:
>  gpio-3   (                    |spi1 CS1            ) out hi ACTIVE LOW
>  gpio-5   (                    |regulator-vbus      ) out lo
>=20
> gpiochip1: GPIOs 64-95, parent: platform/30220000.gpio, 30220000.gpio:
>  gpio-67  (                    |spi3 CS0            ) out hi ACTIVE LOW
>=20
> gpiochip2: GPIOs 96-127, parent: platform/30230000.gpio, 30230000.gpio:
>=20
> gpiochip3: GPIOs 128-159, parent: platform/30240000.gpio, 30240000.gpio:
>  gpio-128 (                    |cd                  ) in  hi IRQ ACTIVE L=
OW
>  gpio-129 (                    |spi1 CS0            ) out hi ACTIVE LOW

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--yuo4tni7ycqx3sjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmH333QACgkQqclaivrt
76nZLgf+NF3DTFQUSgjcXZZ8amvJofEgnE7ucevnuKytlOwKTAY78VA3i1HE3iV+
0z3Ymu7zch5BS5kxMvXNvM9M38pY1DPZvfhFJp8cS2CXwX6vt6qusqJQoTzqGX+R
hBPgUnFazyXD9T2CUDnhDYc2XsqvRLQBsPMn91tQW8b8AHJoUDlacyJSfSRSm6lT
SBlr/Uk9+2KOzQ+KCMOA0nZzsgnygSgzKj5pfPlCZmEW6amyp0HXxDhVxkB249VL
OHGLNQ/kVDfciJM6GDvV3ztCXDwME8Id+jZhtk0mPGaPIOeziLjEPmDDuXQG/mEb
3M4Me7O+EdJgmu/TUltFUylUgslIkQ==
=9T83
-----END PGP SIGNATURE-----

--yuo4tni7ycqx3sjt--
