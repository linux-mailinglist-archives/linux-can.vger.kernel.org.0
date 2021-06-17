Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895333AC4C4
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 09:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhFRHTf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Jun 2021 03:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhFRHTf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 03:19:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAB4C061574
        for <linux-can@vger.kernel.org>; Fri, 18 Jun 2021 00:17:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lu8kj-0003gY-O1; Fri, 18 Jun 2021 09:17:21 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:c73:4828:f436:de44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8E86163E54F;
        Thu, 17 Jun 2021 19:38:24 +0000 (UTC)
Date:   Thu, 17 Jun 2021 21:38:23 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v2 5/5] can: flexcan: add mcf5441x support
Message-ID: <20210617193823.w75gayd33jpmkw4d@pengutronix.de>
References: <20210616231652.738027-1-angelo@kernel-space.org>
 <20210616231652.738027-5-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i2ldg4tu5rm7bfve"
Content-Disposition: inline
In-Reply-To: <20210616231652.738027-5-angelo@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--i2ldg4tu5rm7bfve
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.06.2021 01:16:52, Angelo Dureghello wrote:
> Add flexcan support for NXP ColdFire mcf5441x family.
>=20
> This flexcan module is quite similar to imx6 flexcan module, but
> with some exceptions:
>=20
> - 3 separate interrupt sources, MB, BOFF and ERR,
> - implements 16 mb only,
> - m68k architecture is not supporting devicetrees, so a
>   platform data check/case has been added,
> - ColdFire is m68k, so big-endian cpu, with a little-endian flexcan
>   module.
>=20
> ---
> Changes for v2:
> - re-add platform data handling restarting from 2c0ac9208135
> - re-add flexcan_id_table, as from 2c0ac9208135
> - usinig irq resources for ERR and BOFF interrupts
> - add missing free_irq() for interrupts
> - minor syntax fixes
>=20
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> ---
>  drivers/net/can/flexcan.c | 95 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 84 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 57f3635ad8d7..2188dc36a010 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -28,6 +28,7 @@
>  #include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/can/platform/mcf5441x.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> @@ -246,6 +247,8 @@
>  #define FLEXCAN_QUIRK_SUPPORT_ECC BIT(10)
>  /* Setup stop mode with SCU firmware to support wakeup */
>  #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW BIT(11)
> +/* Setup for flexcan module as in mcf, 16 mb, 3 separate interrupts  */
> +#define FLEXCAN_QUIRK_SETUP_MCF BIT(12)

Can you split this into QUIRK_NR_IRQ_3 and QUIRK_NR_MB_16.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--i2ldg4tu5rm7bfve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDLpKsACgkQqclaivrt
76l8gAf+JJa/pQu3XiQoJRVqLAiDoMIpvyABMTN6NkmMjxGL6xYxlij1PnjgtVQw
BnwPQAmRIvuKq7ddsH2sItp6OPuM2vq5lvpogOCtJp7BwIIZf3WmHi5LYMbMlQdY
XPVDY4rjlJWGaZGYhT2U+RHENkl6mt2sfepgm07jvM/5cemLV3lvUXb+eGclvWgC
V5uDaQBRCf5GIpzXYqL7Aw4HqLF4dYwIDPCFxRhTMV3jPi/YixBFJl2mU7eIs/dq
fVgB3A8/Wsy8tksR9nAzAiTT/n7vTQ2RRSMNMDU8RuLZfc9Tvy7p2qDJQSmZOvND
RbPtaFZ2ePR7J57fJjeoxzbtS3tu7A==
=QoTw
-----END PGP SIGNATURE-----

--i2ldg4tu5rm7bfve--
