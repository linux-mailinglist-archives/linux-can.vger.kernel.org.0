Return-Path: <linux-can+bounces-576-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1288BCA64
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 11:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D64F4B22E0A
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 09:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4061422C8;
	Mon,  6 May 2024 09:19:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219931422AC
	for <linux-can@vger.kernel.org>; Mon,  6 May 2024 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714987159; cv=none; b=a5ZIz6pBHpVAtObvrYHnn4vahEap6bf2fYeGTTQ5GySNbc+kW2vZFV8su/6/pt4efvDPeiigxIrKvTEbZkGhXUHmY9UE4ySXuNsRKgOmLDO37NvZiZSQw1Vv1t9A3hTDazT4C9awYwDOrDnr6RnOGXUktYs8TsJJBjl66t6Px9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714987159; c=relaxed/simple;
	bh=4GJJvVcB67txL6x23xZi79tGkqfJu9ZkapJcsQpj8mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHia3tvVTIOXjCv44zyW8GWYfWsiDlH75+O5ug2gj8ZHSRVRxwIVMaKC+bO+w4yoj60c14Edn0cMunras5YDDQrRgRu/hprrC+CAb153vGjlWKN/w0FpC7bHiz8VCZ14/ZVhAbPVpez2ObkonMwE6QhVfh/3aQQgxNeORMo1LE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3uUt-0007aJ-6R; Mon, 06 May 2024 11:18:59 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3uUq-00GEqn-Vo; Mon, 06 May 2024 11:18:57 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 861EF2CB3C7;
	Mon, 06 May 2024 09:18:56 +0000 (UTC)
Date: Mon, 6 May 2024 11:18:55 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 4/6] can: mcp251xfd: mcp251xfd_regmap_crc_write():
 workaround for errata 5
Message-ID: <20240506-aromatic-dainty-orangutan-f8b57c-mkl@pengutronix.de>
References: <20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com>
 <20240506-mcp251xfd-gpio-feature-v2-4-615b16fa8789@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ltjwktyxpf7yjkxq"
Content-Disposition: inline
In-Reply-To: <20240506-mcp251xfd-gpio-feature-v2-4-615b16fa8789@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ltjwktyxpf7yjkxq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.05.2024 07:59:46, Gregor Herburger wrote:
> According to Errata DS80000789E 5 writing IOCON register using one SPI
> write command clears LAT0/LAT1.
>=20
> Errata Fix/Work Around suggests to write registers with single byte write
> instructions. However, it seems that every write to the second byte
> causes the overwrite of LAT0/LAT1.
>=20
> Never write byte 2 of IOCON register to avoid clearing of LAT0/LAT1.
>=20
> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c | 29 ++++++++++++++++++=
+++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/n=
et/can/spi/mcp251xfd/mcp251xfd-regmap.c
> index 65150e762007..43fcf7f50591 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> @@ -229,14 +229,41 @@ mcp251xfd_regmap_crc_gather_write(void *context,
>  	return spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
>  }
> =20
> +static int mcp251xfd_regmap_crc_write_iocon(void *context, const void *d=
ata)
> +{
> +	u16 reg =3D MCP251XFD_REG_IOCON;

const

> +
> +	/* Never write to bits 16..23 of IOCON register to avoid clearing of LA=
T0/LAT1
> +	 *
> +	 * According to Errata DS80000789E 5 writing IOCON register using one

Just for completeness add "mcp2518fd" in front of Errata.

> +	 * SPI write command clears LAT0/LAT1.
> +	 *
> +	 * Errata Fix/Work Around suggests to write registers with single byte
> +	 * write instructions. However, it seems that the byte at 0xe06(IOCON[2=
3:16])
> +	 * is for read-only access and writing to it causes the clearing of LAT=
0/LAT1.
> +	 */
> +
> +	/* Write IOCON[15:0] */
> +	mcp251xfd_regmap_crc_gather_write(context, &reg, 1, data, 2);
> +	reg +=3D 3;
> +	/* Write IOCON[31:24] */
> +	mcp251xfd_regmap_crc_gather_write(context, &reg, 1, data + 3, 1);

Please add error handling.

> +
> +	return 0;
> +}
> +
>  static int
>  mcp251xfd_regmap_crc_write(void *context,
>  			   const void *data, size_t count)
>  {
>  	const size_t data_offset =3D sizeof(__be16) +
>  		mcp251xfd_regmap_crc.pad_bits / BITS_PER_BYTE;
> +	u16 reg =3D *(u16 *)data;
> =20
> -	return mcp251xfd_regmap_crc_gather_write(context,
> +	if (reg =3D=3D MCP251XFD_REG_IOCON)
> +		return mcp251xfd_regmap_crc_write_iocon(context, data + data_offset);

Please also check that "count" is sizeof(__le32).

> +	else
> +		return mcp251xfd_regmap_crc_gather_write(context,
>  						 data, data_offset,
>  						 data + data_offset,
>  						 count - data_offset);
>=20

Also add the workaround for the nocrc regmap.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ltjwktyxpf7yjkxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmY4oHwACgkQKDiiPnot
vG/7lQf9Gfl2kI2VZm5ZoPgK5CZ2Qq1vPDA1Z+z3fSaaONgwCW2gyer3aMONMZmP
R/DMZNdouH6I3GvqCwSS+gxKTlZdciS4Kw3tIeS00EGeV7uquD6VHec5lXgDQ/hA
CMZxZKu35QCqmos1uzPYkzJcleR5Kyq5zM9z9NP7Mykfa0UwmHoe8BqKZT50VrFx
enu7bj5ABjai1ZJ7bFh0CebJNa2XZHD2VpUUZXQ8KllW+xgkm6HUNHPFGj3wLYbI
1hBowLc2WoQkuZGO2WniYLNpg5UTOM4QnHCiznLwRWd8PwtsI7vKXOSHJxk94q42
IOdRFpzeyJYyQ2x7c7CBK+z4rAnAkA==
=4dqj
-----END PGP SIGNATURE-----

--ltjwktyxpf7yjkxq--

