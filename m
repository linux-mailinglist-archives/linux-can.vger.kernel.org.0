Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCFE361AD3
	for <lists+linux-can@lfdr.de>; Fri, 16 Apr 2021 09:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbhDPHvv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Apr 2021 03:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbhDPHvu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Apr 2021 03:51:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5BDC061574
        for <linux-can@vger.kernel.org>; Fri, 16 Apr 2021 00:51:25 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lXJFv-0007Vj-FL; Fri, 16 Apr 2021 09:51:11 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:b21a:a98c:8cd:ce9c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AEC6260FFEB;
        Fri, 16 Apr 2021 07:51:09 +0000 (UTC)
Date:   Fri, 16 Apr 2021 09:51:09 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-can@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v4 3/3] phy: phy-can-transceiver: Add support for generic
 CAN transceiver driver
Message-ID: <20210416075109.yw3c47ii67gckeqd@pengutronix.de>
References: <20210416052647.2758-1-a-govindraju@ti.com>
 <20210416052647.2758-4-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ady7filrbecwiiya"
Content-Disposition: inline
In-Reply-To: <20210416052647.2758-4-a-govindraju@ti.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ady7filrbecwiiya
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.04.2021 10:56:47, Aswath Govindraju wrote:
> The driver adds support for generic CAN transceivers. Currently
> the modes supported by this driver are standby and normal modes for TI
> TCAN1042 and TCAN1043 CAN transceivers.
>=20
> The transceiver is modelled as a phy with pins controlled by gpios, to put
> the transceiver in various device functional modes. It also gets the phy
> attribute max_link_rate for the usage of CAN drivers.
>=20
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  MAINTAINERS                       |   1 +
>  drivers/phy/Kconfig               |   9 ++
>  drivers/phy/Makefile              |   1 +
>  drivers/phy/phy-can-transceiver.c | 146 ++++++++++++++++++++++++++++++
>  4 files changed, 157 insertions(+)
>  create mode 100644 drivers/phy/phy-can-transceiver.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e666d33af10d..4e868f2a97c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4048,6 +4048,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/gi=
t/mkl/linux-can-next.git
>  F:	Documentation/devicetree/bindings/net/can/
>  F:	Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
>  F:	drivers/net/can/
> +F:	drivers/phy/phy-can-transceiver.c
>  F:	include/linux/can/bittiming.h
>  F:	include/linux/can/dev.h
>  F:	include/linux/can/led.h
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 54c1f2f0985f..51902b629fc6 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -61,6 +61,15 @@ config USB_LGM_PHY
>  	  interface to interact with USB GEN-II and USB 3.x PHY that is part
>  	  of the Intel network SOC.
> =20
> +config PHY_CAN_TRANSCEIVER
> +	tristate "CAN transceiver PHY"
> +	select GENERIC_PHY
> +	help
> +	  This option enables support for CAN transceivers as a PHY. This
> +	  driver provides function for putting the transceivers in various
> +	  functional modes using gpios and sets the attribute max link
> +	  rate, for mcan drivers.
                    ^^^^

CAN

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ady7filrbecwiiya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmB5QeoACgkQqclaivrt
76lL2Af/UvxExvGuIijK2rChTwL3SRtvX/+pPjQvIocOQXS0k3f/Qrn4kekRnYra
L5E5CKfkfDyQ8+Z1hI10WxOKP12wtekyocXH06+wPYZfnSfVXTGa0udUzQsnDbZq
HWJcSdy1AIAuDuRCteWuaAKpXkvqRIKcg2i06DWKHnsM/CiHN6PHunf2pNO7vN6N
m+tM2haOcNWGb0MQ9MYL3q18rN+MtO/FyKhGnQ6G0WNPGzhwPoHHuYEk/tP2mMB8
kbqRyYOOTdtmssPqLGU9/w3N2AB+av9m+JtiVO4xfk9lcREN5NdF7DFsdCg3pC2q
uojUDhg536F1EyjPzsiuucbsPtSE7Q==
=WkZb
-----END PGP SIGNATURE-----

--ady7filrbecwiiya--
