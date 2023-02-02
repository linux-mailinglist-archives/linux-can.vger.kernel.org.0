Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9601E687F93
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 15:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjBBOK2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 09:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBBOK1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 09:10:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F42F8A7C4
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 06:10:26 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNaI5-0008BG-Fk; Thu, 02 Feb 2023 15:10:17 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:fff9:bfd9:c514:9ad9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1036916D5F0;
        Thu,  2 Feb 2023 14:10:15 +0000 (UTC)
Date:   Thu, 2 Feb 2023 15:10:06 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas Kopp <thomas.kopp@microchip.com>
Cc:     linux-can@vger.kernel.org, mani@kernel.org
Subject: Re: [PATCH] can: mcp251xfd: optimizing transfer size for CRC
 transfers size 1
Message-ID: <20230202141006.qhahaaibft4tlyfn@pengutronix.de>
References: <20230127124258.2764-1-thomas.kopp@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="37rxvsaezb32pk4f"
Content-Disposition: inline
In-Reply-To: <20230127124258.2764-1-thomas.kopp@microchip.com>
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


--37rxvsaezb32pk4f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.01.2023 13:42:58, Thomas Kopp wrote:
> For CRC transfers with size 1 it is more efficient to use the
> write_safe command instead of the write_crc command. This saves the
> length byte on the SPI transfer.

Looks good to me. But I cannot measure a difference.

> Signed-off-by: Thomas Kopp <thomas.kopp@microchip.com>
> ---
>  .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    | 31 ++++++++++++-------
>  drivers/net/can/spi/mcp251xfd/mcp251xfd.h     | 26 +++++++++++++---
>  2 files changed, 42 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net=
/can/spi/mcp251xfd/mcp251xfd-ring.c
> index f69d5fc8c9afd..3c3bc9be1f295 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
> @@ -30,22 +30,31 @@ mcp251xfd_cmd_prepare_write_reg(const struct mcp251xf=
d_priv *priv,
>  	last_byte =3D mcp251xfd_last_byte_set(mask);
>  	len =3D last_byte - first_byte + 1;
> =20
> -	data =3D mcp251xfd_spi_cmd_write(priv, write_reg_buf, reg + first_byte);
> +	data =3D mcp251xfd_spi_cmd_write(priv, write_reg_buf, reg + first_byte,=
 len);
>  	val_le32 =3D cpu_to_le32(val >> BITS_PER_BYTE * first_byte);
>  	memcpy(data, &val_le32, len);
> =20
>  	if (priv->devtype_data.quirks & MCP251XFD_QUIRK_CRC_REG) {
>  		u16 crc;
> -
> -		mcp251xfd_spi_cmd_crc_set_len_in_reg(&write_reg_buf->crc.cmd,
> -						     len);
> -		/* CRC */
> -		len +=3D sizeof(write_reg_buf->crc.cmd);
> -		crc =3D mcp251xfd_crc16_compute(&write_reg_buf->crc, len);
> -		put_unaligned_be16(crc, (void *)write_reg_buf + len);
> -
> -		/* Total length */
> -		len +=3D sizeof(write_reg_buf->crc.crc);
> +		if (len =3D=3D 1) {
> +			/* CRC */
> +			len +=3D sizeof(write_reg_buf->safe.cmd);
> +			crc =3D mcp251xfd_crc16_compute(&write_reg_buf->safe, len);
> +			put_unaligned_be16(crc, (void *)write_reg_buf + len);
> +
> +			/* Total length */
> +			len +=3D sizeof(write_reg_buf->safe.crc);
> +		} else {
> +			mcp251xfd_spi_cmd_crc_set_len_in_reg(&write_reg_buf->crc.cmd,
> +							     len);
> +			/* CRC */
> +			len +=3D sizeof(write_reg_buf->crc.cmd);
> +			crc =3D mcp251xfd_crc16_compute(&write_reg_buf->crc, len);
> +			put_unaligned_be16(crc, (void *)write_reg_buf + len);
> +
> +			/* Total length */
> +			len +=3D sizeof(write_reg_buf->crc.crc);
> +		}
>  	} else {
>  		len +=3D sizeof(write_reg_buf->nocrc.cmd);
>  	}

I've moved changed the if() logic a bit, saving 1 level of indention.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--37rxvsaezb32pk4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmPbxDsACgkQvlAcSiqK
BOjDvgf/b8MkOXAAHedYnyGNQFYhpPuT/2PNeuCFhK7cFgS0u7os8O0MSNb9mo/f
g0x54JAKIQL+IomKVDrQ3hEaFXUMX0ECaelV70ch3jc0EGX1ldadbxRwWO8mc2Gg
/Chi2k+mDyy2G4T9fuOMEpV9KmQ8VRwMSvaZ1Dkf99x/Iou3htcO1nV2vM3KP/pN
Pc2O//Z/S9xwUbotfUZ/ut7WN7H+0L0H9BpDSfPaDW3bcuOE/wbIz0xLnLkIVUu/
HKR2mZZW8C6o+rnjGuYYdbzuolZtQeoalaqt2eyVFalbNoY84hM+wqX/jMuKbThV
mDmljHZs0qbmwh9xz/aJOUX6KHDgcQ==
=N/yh
-----END PGP SIGNATURE-----

--37rxvsaezb32pk4f--
