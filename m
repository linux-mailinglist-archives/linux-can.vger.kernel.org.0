Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02227566A7
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 16:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjGQOk1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 10:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjGQOkX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 10:40:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18871E3
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 07:40:18 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLPOU-0005K2-Si; Mon, 17 Jul 2023 16:40:10 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id F3B6A1F36E3;
        Mon, 17 Jul 2023 14:40:09 +0000 (UTC)
Date:   Mon, 17 Jul 2023 16:40:09 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Fedor Ross <fedor.ross@ifm.com>,
        Marek Vasut <marex@denx.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase
 poll timeout
Message-ID: <20230717-acrobat-mortality-a968f7af4551-mkl@pengutronix.de>
References: <20230717100815.75764-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ci7chngldiqnrqkt"
Content-Disposition: inline
In-Reply-To: <20230717100815.75764-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ci7chngldiqnrqkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.07.2023 12:08:15, Marc Kleine-Budde wrote:
> From: Fedor Ross <fedor.ross@ifm.com>
>=20
> The mcp251xfd controller needs an idle bus to enter 'Normal CAN 2.0
> mode' or . The maximum length of a CAN frame is 736 bits (64 data
> bytes, CAN-FD, EFF mode, worst case bit stuffing and interframe
> spacing). For low bit rates like 10 kbit/s the arbitrarily chosen
> MCP251XFD_POLL_TIMEOUT_US of 1 ms is too small.
>=20
> Otherwise during polling for the CAN controller to enter 'Normal CAN
> 2.0 mode' the timeout limit is exceeded and the configuration fails
> with:
>=20
> | $ ip link set dev can1 up type can bitrate 10000
> | [  731.911072] mcp251xfd spi2.1 can1: Controller failed to enter mode C=
AN 2.0 Mode (6) and stays in Configuration Mode (4) (con=3D0x068b0760, osc=
=3D0x00000468).
> | [  731.927192] mcp251xfd spi2.1 can1: CRC read error at address 0x0e0c =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> | [  731.938101] A link change request failed with some changes committed=
 already. Interface can1 may have been left with an inconsistent configurat=
ion, please check.
> | RTNETLINK answers: Connection timed out
>=20
> Make MCP251XFD_POLL_TIMEOUT_US timeout calculation dynamic. Use
> maximum of 1ms and bit time of 1 full 64 data bytes CAN-FD frame in
> EFF mode, worst case bit stuffing and interframe spacing at the
> current bit rate.
>=20
> For easier backporting define the macro MCP251XFD_FRAME_LEN_MAX_BITS
> that holds the max frame length in bits, which is 736. This can be
> replaced by can_frame_bits(true, true, true, true, CANFD_MAX_DLEN) in
> a cleanup patch later.
>=20
> Fixes: 55e5b97f003e8 ("can: mcp25xxfd: add driver for Microchip MCP25xxFD=
 SPI CAN")
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Thomas Kopp <thomas.kopp@microchip.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello,
>=20
> picking up Fedor's and Marek's work. I decided to make it a minimal
> patch and add stable on Cc. The mentioned cleanup patch that replaces
> 736 by can_frame_bits() can be done later and will go upstream via
> can-next.
>=20
> regards,
> Marc
>=20
> v3:
> - use 736 as max CAN frame length, calculated by Vincent Mailhol's
>   80a2fbce456e ("can: length: refactor frame lengths definition to add si=
ze in bits")
> - update commit message
> - drop patch 2/2
>=20
> v2: https://lore.kernel.org/all/20230505222820.126441-1-marex@denx.de
> - Add macros for CAN_BIT_STUFFING_OVERHEAD and CAN_IDLE_CONDITION_SAMPLES
>   (thanks Thomas, but please double check the comments)
> - Update commit message
>=20
> v1: https://lore.kernel.org/all/20230504195059.4706-1-marex@denx.de
>=20
> drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 4 +++-
>  drivers/net/can/spi/mcp251xfd/mcp251xfd.h      | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net=
/can/spi/mcp251xfd/mcp251xfd-core.c
> index 68df6d4641b5..876e8e3cbb0b 100644
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
> +				       max_t(unsigned long, MCP251XFD_POLL_TIMEOUT_US,
> +					     MCP251XFD_FRAME_LEN_MAX_BITS * USEC_PER_SEC / bt->bitrate));

This segfaults with a div by zero if bitrate is not set, yet. Fixed in
v4.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ci7chngldiqnrqkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS1UsYACgkQvlAcSiqK
BOiOTAf+KbpQoCh2yWtTm/4FrPaSctKfebjPqgm6cs+JeuUvC38oI34T9T5LEW97
NjCHVgAxMmqoCv5sLefLYvxpsonuCBuWy/3jXBoBc049W1D8bhnXj0ehAXox/Phs
uFBGEFC+7c2y9aZzLhEAJDW0ePX8c0NDPy4T31UvwLlr4AWdDrzGsd8NNndK/NNG
vEDFiKRtuSGdG37MusOmaW1g6IQsKB+xqCby20AL42rV8iPX72a3BwVqV2HefcRT
AXoETw5ZTO/H1GsT7QOOw4K62Lfv5TVvgpGYuk8aLIDLY9HxITIpOKnPmUx/JTt1
DyVCpO9yDmb7myVxSjv2ILeOAJQSWw==
=ql9i
-----END PGP SIGNATURE-----

--ci7chngldiqnrqkt--
