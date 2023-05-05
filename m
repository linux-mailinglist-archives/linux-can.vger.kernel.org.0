Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5046F7D45
	for <lists+linux-can@lfdr.de>; Fri,  5 May 2023 08:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjEEGvT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 May 2023 02:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEEGvS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 May 2023 02:51:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630F215EE9
        for <linux-can@vger.kernel.org>; Thu,  4 May 2023 23:51:17 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pupHL-0003u0-PL; Fri, 05 May 2023 08:50:55 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 116EE1BE506;
        Fri,  5 May 2023 06:50:53 +0000 (UTC)
Date:   Fri, 5 May 2023 08:50:52 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-can@vger.kernel.org, Fedor Ross <fedor.ross@ifm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] can: mcp251xfd: Increase poll timeout
Message-ID: <20230505-kilt-exclusion-fd2a2423deb1-mkl@pengutronix.de>
References: <20230504195059.4706-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mrnf367gifvtkq2j"
Content-Disposition: inline
In-Reply-To: <20230504195059.4706-1-marex@denx.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--mrnf367gifvtkq2j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.05.2023 21:50:59, Marek Vasut wrote:
> From: Fedor Ross <fedor.ross@ifm.com>
>=20
> Make `MCP251XFD_POLL_TIMEOUT_US` timeout calculation dynamic. Use
> maximum of 1ms and bit time of one full 72 bytes CANFD frame at the
> current bitrate.

The 1ms was arbitrary chosen by me during development. The previous
driver by Martin Sperl uses a hardcoded loop of 256 retries and no
explicit sleep.

The datasheet "MCP25xxFD Family Reference Manual" says it needs an idle
bus.

> This seems to be necessary when configuring low
> bit rates like 10 Kbit/s for example. Otherwise during polling for
> the CAN controller to enter 'Normal CAN 2.0 mode' the timeout limit
> is exceeded and the configuration fails with:
>=20
> $ ip link set dev can1 up type can bitrate 10000
> [  731.911072] mcp251xfd spi2.1 can1: Controller failed to enter mode CAN=
 2.0 Mode (6) and stays in Configuration Mode (4) (con=3D0x068b0760, osc=3D=
0x00000468).
> [  731.927192] mcp251xfd spi2.1 can1: CRC read error at address 0x0e0c (l=
ength=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> [  731.938101] A link change request failed with some changes committed a=
lready. Interface can1 may have been left with an inconsistent configuratio=
n, please check.
> RTNETLINK answers: Connection timed out
>=20
> Fixes: 55e5b97f003e8 ("can: mcp25xxfd: add driver for Microchip MCP25xxFD=
 SPI CAN")
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Thomas Kopp <thomas.kopp@microchip.com>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: linux-can@vger.kernel.org
> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net=
/can/spi/mcp251xfd/mcp251xfd-core.c
> index 68df6d4641b5c..9908843798cef 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -227,6 +227,7 @@ static int
>  __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
>  			  const u8 mode_req, bool nowait)
>  {
> +	const struct can_bittiming *bt =3D &priv->can.bittiming;
>  	u32 con =3D 0, con_reqop, osc =3D 0;
>  	u8 mode;
>  	int err;
> @@ -251,7 +252,8 @@ __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv=
 *priv,
>  				       FIELD_GET(MCP251XFD_REG_CON_OPMOD_MASK,
>  						 con) =3D=3D mode_req,
>  				       MCP251XFD_POLL_SLEEP_US,
> -				       MCP251XFD_POLL_TIMEOUT_US);
> +				       max(MCP251XFD_POLL_TIMEOUT_US,
> +					   576 * USEC_PER_SEC / bt->bitrate));

Let's use CANFD_FRAME_LEN_MAX * BITS_PER_BYTE instead of 576. I can fix
this while applying.

>  	if (err !=3D -ETIMEDOUT && err !=3D -EBADMSG)
>  		return err;
> =20
> --=20
> 2.39.2
>=20
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mrnf367gifvtkq2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRUp0kACgkQvlAcSiqK
BOigoAf+IOvFkpt2SK79SEZjOStG3JF61sLviGeDIyBgnvNCdb2oPz0DV+9IEE1q
88JFmvGbQYOIThhCzKa0naW4yVN2MudtmixH/O1UGd1vV7AtUl0cqBT/Kg47YbKq
tdFu/XaIjEHvl99FHe0e/jEC8rUKYWMrybcLld6nVunxGVhScYH9jbxzeeLowJS6
QyQGu0RW8rMpX8cAqj1HoeI/DmTA4UTcLRcRc3fiM6JMzcJwwWuWZN8B2lwkfmc4
ELANH6dk4LDXiO1T3zj7TykO+APs3C49QS85fWZUi4kb2Uj9mKIFYaifAxIncixF
GCRnnSAisHEaB8+CpGB8M+B9+2lVOQ==
=wHy6
-----END PGP SIGNATURE-----

--mrnf367gifvtkq2j--
