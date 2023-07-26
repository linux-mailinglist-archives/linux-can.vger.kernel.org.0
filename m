Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A184762B89
	for <lists+linux-can@lfdr.de>; Wed, 26 Jul 2023 08:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGZGgB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jul 2023 02:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjGZGf7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Jul 2023 02:35:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5014211F
        for <linux-can@vger.kernel.org>; Tue, 25 Jul 2023 23:35:53 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qOY7S-0001KQ-K6; Wed, 26 Jul 2023 08:35:34 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 20D031FADA3;
        Wed, 26 Jul 2023 06:35:33 +0000 (UTC)
Date:   Wed, 26 Jul 2023 08:35:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     haibo.chen@nxp.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        wg@grandegger.com, kernel@pengutronix.de, linux-imx@nxp.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] can: flexcan: remove the auto stop mode for IMX93
Message-ID: <20230726-deflected-slider-8e928de8616a-mkl@pengutronix.de>
References: <20230726035032.3073951-1-haibo.chen@nxp.com>
 <20230726035032.3073951-2-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hx4h6g6ggdhiiilv"
Content-Disposition: inline
In-Reply-To: <20230726035032.3073951-2-haibo.chen@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--hx4h6g6ggdhiiilv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2023 11:50:32, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>=20
> IMX93 A0 chip involve the internal q-channel handshake in LPCG and
> CCM to automatically handle the Flex-CAN IPG STOP signal. Only after
> FLEX-CAN enter stop mode then can support the self-wakeup feature.
>=20
> But meet issue when do the continue system PM stress test. When config
> the CAN as wakeup source, the first time after system suspend, any data
> on CAN bus can wakeup the system, this is as expect. But the second time
> when system suspend, data on CAN bus can't wakeup the system. If continue
> this test, we find in odd time system enter suspend, CAN can wakeup the
> system, but in even number system enter suspend, CAN can't wakeup the
> system.
>=20
> IC find a bug in the auto stop mode logic when handle the q-channel, and
> can't fix it easily. So for the new imx93 A1, IC drop the auto stop mode
> and involve the GPR to support stop mode (used before). IC define a bit
> in GPR which can trigger the IPG STOP signal to Flex-CAN, let it go into
> stop mode.
>=20
> Now NXP claim to drop IMX93 A0, and only support IMX93 A1. So this patch
> remove the auto stop mode, and add flag FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR
> to imx93.
>=20
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 37 ++++----------------------
>  drivers/net/can/flexcan/flexcan.h      |  2 --
>  2 files changed, 5 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index ff0fc18baf13..a3f3a9c909be 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -348,7 +348,7 @@ static struct flexcan_devtype_data fsl_imx8mp_devtype=
_data =3D {
>  static struct flexcan_devtype_data fsl_imx93_devtype_data =3D {
>  	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS=
 |
>  		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
> -		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_AUTO_STOP_MODE |
> +		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR |

AFAICS this change breaks systems with old device trees (i.e. without
"fsl,stop-mode") and new kernels. The flexcan driver will not probe
anymore.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hx4h6g6ggdhiiilv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTAvrEACgkQvlAcSiqK
BOimMQf8CbCC3vkKR1bq5S9ISSxAdjCCx+f2nJirLRFI2gps6MSeKLI5qRaOAxpD
HZpTNUxI0yr4vSKr/NRq2rJasNUiTGSJ3BYqZCqwxeIzmIFKwUMRTH0J49H8mgvt
6dgvEr7/sqMsmS1RhFPT1p7Zh5+haYE3MgCZStZz1UM8RkOUdvRq/2cSCCJzU8pH
axjrOH4L95zyOumPwWoSAp+q9+RwS3KbyXCE4+DPrXBdaXnEb68+NGxM7r/k2V/I
Tz3874I58DBeXf4wDpvfOBWcmw9Dap1Hvlbvixtw7bB5t35OvsHCnenkfOCIgRkb
D20d8hY390kF2YSZEBlciSmegrrKwQ==
=l5IQ
-----END PGP SIGNATURE-----

--hx4h6g6ggdhiiilv--
