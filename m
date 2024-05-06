Return-Path: <linux-can+bounces-577-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDA78BCB01
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 11:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6671F21BC6
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 09:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88CA142645;
	Mon,  6 May 2024 09:43:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728A142635
	for <linux-can@vger.kernel.org>; Mon,  6 May 2024 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988602; cv=none; b=VizxT0Z/Ykljveqy6RDigWXOEpc7Mc9qN7n5a8RIO0lOpnmxGNtxC3muK7hObf68CsLeI7wnlVHEFas1CBuczqogY6PuBABNch0TyGlLopZOKYAyMFqdDbuG2owDHWBJF5pNvEqJToUDlKTiNMXFDH3jsoOp20oTJouldt2AAKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988602; c=relaxed/simple;
	bh=myTU4/Q6NGtbmF0r92u+3CCOIh0NaCf/KXPLPkrYEbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+kTeQb8n7aKtWpgNjXxiUVP2l2PEYbJ4VvtmFhMaECFXdg+7uQw4hAmDmxYaCSi/rS69lDvVekATiNkKZsA0q/r+JA8KbMgxQkX+SOjUSOf/D8SWo50kPU9fSAjY/IGeIjD5GJhDXDzJy4Hw+pyCaT6ITDHq084nikNcTHvVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3usD-0003qB-BH; Mon, 06 May 2024 11:43:05 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3usC-00GEwf-DY; Mon, 06 May 2024 11:43:04 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 026EB2CB411;
	Mon, 06 May 2024 09:43:04 +0000 (UTC)
Date: Mon, 6 May 2024 11:43:03 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 5/6] can: mcp251xfd: add gpio functionality
Message-ID: <20240506-pygmy-wolf-of-advance-afb194-mkl@pengutronix.de>
References: <20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com>
 <20240506-mcp251xfd-gpio-feature-v2-5-615b16fa8789@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2x6ow623o46vxnne"
Content-Disposition: inline
In-Reply-To: <20240506-mcp251xfd-gpio-feature-v2-5-615b16fa8789@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--2x6ow623o46vxnne
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.05.2024 07:59:47, Gregor Herburger wrote:
> The mcp251xfd devices allow two pins to be configured as gpio. Add this
> functionality to driver.
>=20
> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 173 +++++++++++++++++++=
++++++
>  drivers/net/can/spi/mcp251xfd/mcp251xfd.h      |   6 +
>  2 files changed, 179 insertions(+)
>=20
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net=
/can/spi/mcp251xfd/mcp251xfd-core.c
> index 4739ad80ef2a..de301f3a2f4e 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -16,6 +16,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/device.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> @@ -1768,6 +1769,172 @@ static int mcp251xfd_register_check_rx_int(struct=
 mcp251xfd_priv *priv)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_GPIOLIB
> +static const char * const mcp251xfd_gpio_names[] =3D {"GPIO0", "GPIO1"};

please add spaces after { and before }.

> +
> +static int mcp251xfd_gpio_request(struct gpio_chip *chip, unsigned int o=
ffset)
> +{
> +	struct mcp251xfd_priv *priv =3D gpiochip_get_data(chip);
> +	u32 pin_mask =3D MCP251XFD_REG_IOCON_PM0 << offset;

Can you add MCP251XFD_REG_IOCON_PM(), MCP251XFD_REG_IOCON_TRIS(),
MCP251XFD_REG_IOCON_LAT(), MCP251XFD_REG_IOCON_GPIO() macros?

> +	int ret;
> +
> +	if (priv->rx_int && offset =3D=3D 1) {
> +		netdev_err(priv->ndev, "Can't use GPIO 1 with RX-INT!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D pm_runtime_resume_and_get(priv->ndev->dev.parent);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
> +				  pin_mask, pin_mask);
> +}
> +
> +static void mcp251xfd_gpio_free(struct gpio_chip *chip, unsigned int off=
set)
> +{
> +	struct mcp251xfd_priv *priv =3D gpiochip_get_data(chip);
> +
> +	pm_runtime_put(priv->ndev->dev.parent);
> +}
> +
> +static int mcp251xfd_gpio_get_direction(struct gpio_chip *chip,
> +					unsigned int offset)
> +{
> +	struct mcp251xfd_priv *priv =3D gpiochip_get_data(chip);
> +	u32 mask =3D MCP251XFD_REG_IOCON_TRIS0 << offset;
> +	u32 val;
> +
> +	regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);

Please print an error if regmap_read() throws an error.

> +
> +	if (mask & val)
> +		return GPIO_LINE_DIRECTION_IN;
> +
> +	return GPIO_LINE_DIRECTION_OUT;
> +}
> +
> +static int mcp251xfd_gpio_get(struct gpio_chip *chip, unsigned int offse=
t)
> +{
> +	struct mcp251xfd_priv *priv =3D gpiochip_get_data(chip);
> +	u32 mask =3D MCP251XFD_REG_IOCON_GPIO0 << offset;
> +	u32 val;
> +
> +	regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);

same here

> +
> +	return !!(mask & val);
> +}
> +
> +static int mcp251xfd_gpio_get_multiple(struct gpio_chip *chip, unsigned =
long *mask,
> +				       unsigned long *bit)
> +{
> +	struct mcp251xfd_priv *priv =3D gpiochip_get_data(chip);
> +	u32 val;
> +	int ret;
> +
> +	ret =3D regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
> +	if (ret)
> +		return ret;
> +
> +	*bit =3D FIELD_GET(MCP251XFD_REG_IOCON_GPIO_MASK, val) & *mask;
> +
> +	return 0;
> +}
> +
> +static int mcp251xfd_gpio_direction_output(struct gpio_chip *chip,
> +					   unsigned int offset, int value)
> +{
> +	struct mcp251xfd_priv *priv =3D gpiochip_get_data(chip);
> +	u32 dir_mask =3D MCP251XFD_REG_IOCON_TRIS0 << offset;
> +	u32 val_mask =3D MCP251XFD_REG_IOCON_LAT0 << offset;
> +	u32 val;
> +
> +	if (value)
> +		val =3D val_mask;
> +	else
> +		val =3D 0;
> +
> +	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
> +				  dir_mask | val_mask, val);
> +}
> +
> +static int mcp251xfd_gpio_direction_input(struct gpio_chip *chip,
> +					  unsigned int offset)
> +{
> +	struct mcp251xfd_priv *priv =3D gpiochip_get_data(chip);
> +	u32 dir_mask =3D MCP251XFD_REG_IOCON_TRIS0 << offset;
> +
> +	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
> +				  dir_mask, dir_mask);
> +}
> +
> +static void mcp251xfd_gpio_set(struct gpio_chip *chip, unsigned int offs=
et,
> +			       int value)
> +{
> +	struct mcp251xfd_priv *priv =3D gpiochip_get_data(chip);
> +	u32 val_mask =3D MCP251XFD_REG_IOCON_LAT0 << offset;
> +	u32 val;
> +	int ret;
> +
> +	if (value)
> +		val =3D val_mask;
> +	else
> +		val =3D 0;
> +
> +	ret =3D regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
> +				 val_mask, val);
> +	if (ret)
> +		dev_warn(&priv->spi->dev,
> +			 "Failed to set GPIO %u: %d\n", offset, ret);

dev_error()

> +}
> +
> +static void mcp251xfd_gpio_set_multiple(struct gpio_chip *chip, unsigned=
 long *mask,
> +					unsigned long *bits)
> +{
> +	struct mcp251xfd_priv *priv =3D gpiochip_get_data(chip);
> +	u32 val;
> +	int ret;
> +
> +	val =3D FIELD_PREP(MCP251XFD_REG_IOCON_LAT_MASK, *bits);
> +
> +	ret =3D regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
> +				 MCP251XFD_REG_IOCON_LAT_MASK, val);
> +	if (ret)
> +		dev_warn(&priv->spi->dev, "Failed to set GPIOs %d\n", ret);

dev_error()

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2x6ow623o46vxnne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmY4piQACgkQKDiiPnot
vG+GyAf9EysdM/a8rlYZsemizlyNfZsVdm55Lvk/z1KBOe1AnQy1PSsj3nOlgbc+
aDLCX6Pk2aHeV/IdFI6WjVvyZnu9RLH7K/FfPu9WMgXb4d9tjb8eKvi4AZBgOoIL
FQvjYkGiURFEyNsyAg1LNrzE+vM6Hlbt0LRnBAHVQcTSeiPVj/a5F72mZH14/IfE
GHa8zxi9QMVuzTcdikJdMC4TrQMPM7LdrU4nDoEg96LbVMowmd2BpNViiD74UNtG
blBWbm7+IJysQABmL47o4JK0xdjseb6hACx8BtxNPKA3YNGvxHSmXw0nFCre7+2d
keEWG+PcOCG50FLfcYn0GrMQjqam4A==
=OZUz
-----END PGP SIGNATURE-----

--2x6ow623o46vxnne--

