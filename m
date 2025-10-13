Return-Path: <linux-can+bounces-5146-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E938CBD252A
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE341882582
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E6F2FD1D3;
	Mon, 13 Oct 2025 09:36:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85CE2FDC3E
	for <linux-can@vger.kernel.org>; Mon, 13 Oct 2025 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348203; cv=none; b=fth3NRxktMA2+zAd9dMVSFmWktwuKD9+1Ki4JEGg8ynb2RsdfwJiTEJJr8Fi9UE1sbw3SxVKAhUtDv2MfvcuBUcERUakSbLfUPDQ8keqlm4pKFMpxopskkmQJoKHLKLO6/sBi+oeKTWAetuMBNCxNpiym4a7dnEWntGnXpo4964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348203; c=relaxed/simple;
	bh=avg9pKxSZ6687CrCL+XsvGs4bEu1PexWrKeZ/KTGD/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfPJ4Iy2YvqULX3XoQ4NOEgYuusEBHzBTNVChatlv3vv5VMHDjjyjnTN0HIJTAo7IC9csgdVuVw6xDpTmHSaxIJi2mrHuBKi7sG03N8xyLwC0KDEmHzclJWKXlOyxyIwZsNQNqV7xWa3+jOHjyO8o51lsc8S5ZOhL95GbXw41M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8EyX-0003N3-Tp; Mon, 13 Oct 2025 11:36:17 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8EyX-003MWO-0T;
	Mon, 13 Oct 2025 11:36:17 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C50734849F0;
	Mon, 13 Oct 2025 09:36:16 +0000 (UTC)
Date: Mon, 13 Oct 2025 11:36:16 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH v3 2/2] phy: add basic support for NXPs TJA1145 CAN
 transceiver
Message-ID: <20251013-marvellous-acoustic-bison-3ed5d4-mkl@pengutronix.de>
References: <20251013-tja1145-support-v3-0-4a9d245fe067@liebherr.com>
 <20251013-tja1145-support-v3-2-4a9d245fe067@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rvnjm33t2wagghg4"
Content-Disposition: inline
In-Reply-To: <20251013-tja1145-support-v3-2-4a9d245fe067@liebherr.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--rvnjm33t2wagghg4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] phy: add basic support for NXPs TJA1145 CAN
 transceiver
MIME-Version: 1.0

On 13.10.2025 11:19:19, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>=20
> Add basic driver support for NXPs TJA1145 CAN transceiver which brings the
> PHY up/down by switching to normal/standby mode using SPI commands.
>=20
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  drivers/phy/Kconfig           |  10 +++
>  drivers/phy/Makefile          |   1 +
>  drivers/phy/phy-nxp-tja1145.c | 185 ++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 196 insertions(+)
>=20
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 678dd0452f0aa0597773433f04d2a9ba77474d2a..2f2c8f29cce2beb20c584adfe=
8acfe23de14e128 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -101,6 +101,16 @@ config PHY_NXP_PTN3222
>  	  schemes. It supports all three USB 2.0 data rates: Low Speed, Full
>  	  Speed and High Speed.
> =20
> +config PHY_NXP_TJA1145
> +	tristate "NXP TJA1145 CAN transceiver PHY"
> +	select GENERIC_PHY
> +	select REGMAP_SPI
> +	depends on SPI
> +	help
> +	  This option enables support for NXPs TJA1145 CAN transceiver as a PHY.
> +	  This driver provides function for putting the transceiver in various
> +	  functional modes using SPI commands.
> +
>  source "drivers/phy/allwinner/Kconfig"
>  source "drivers/phy/amlogic/Kconfig"
>  source "drivers/phy/broadcom/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index bfb27fb5a494283d7fd05dd670ebd1b12df8b1a1..48eac644d1e2b20f986f80de9=
5b40c26d080358b 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_PHY_SNPS_EUSB2)		+=3D phy-snps-eusb2.o
>  obj-$(CONFIG_USB_LGM_PHY)		+=3D phy-lgm-usb.o
>  obj-$(CONFIG_PHY_AIROHA_PCIE)		+=3D phy-airoha-pcie.o
>  obj-$(CONFIG_PHY_NXP_PTN3222)		+=3D phy-nxp-ptn3222.o
> +obj-$(CONFIG_PHY_NXP_TJA1145)		+=3D phy-nxp-tja1145.o
>  obj-y					+=3D allwinner/	\
>  					   amlogic/	\
>  					   broadcom/	\
> diff --git a/drivers/phy/phy-nxp-tja1145.c b/drivers/phy/phy-nxp-tja1145.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..4d3aa5bfcd88d5755fa37e0d4=
2bfa8293dee2155
> --- /dev/null
> +++ b/drivers/phy/phy-nxp-tja1145.c
> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Liebherr-Electronics and Drives GmbH
> + */
> +#include <linux/bitfield.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/phy/phy.h>
> +#include <linux/spi/spi.h>
> +
> +#define TJA1145_MODE_CTRL		0x01
> +#define TJA1145_MODE_CTRL_MC		GENMASK(2, 0)
> +#define TJA1145_MODE_CRTL_STBY		BIT(2)
> +#define TJA1145_MODE_CRTL_NORMAL	TJA1145_MODE_CTRL_MC
> +
> +#define TJA1145_CAN_CTRL		0x20
> +#define TJA1145_CAN_CTRL_CMC		GENMASK(1, 0)
> +#define TJA1145_CAN_CTRL_ACTIVE		BIT(1)
> +
> +#define TJA1145_IDENT			0x7e
> +#define TJA1145_IDENT_TJA1145T		0x70
> +
> +#define TJA1145_SPI_READ_BIT		BIT(0)
> +#define TJA1145T_MAX_BITRATE		1000000
> +
> +static int tja1145_phy_power_on(struct phy *phy)
> +{
> +	struct regmap *map =3D phy_get_drvdata(phy);
> +	int ret;
> +
> +	/*
> +	 * Switch operating mode to normal which is the active operating mode.
> +	 * In this mode, the device is fully operational.
> +	 */
> +	ret =3D regmap_update_bits(map, TJA1145_MODE_CTRL, TJA1145_MODE_CTRL_MC,
> +				 TJA1145_MODE_CRTL_NORMAL);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Switch to CAN operating mode active where the PHY can transmit and
> +	 * receive data.
> +	 */
> +	return regmap_update_bits(map, TJA1145_CAN_CTRL, TJA1145_CAN_CTRL_CMC,
> +				  TJA1145_CAN_CTRL_ACTIVE);
> +}
> +
> +static int tja1145_phy_power_off(struct phy *phy)
> +{
> +	struct regmap *map =3D phy_get_drvdata(phy);
> +
> +	/*
> +	 * Switch to operating mode standby, the PHY is unable to transmit or
> +	 * receive data in standby mode.
> +	 */
> +	return regmap_update_bits(map, TJA1145_MODE_CTRL, TJA1145_MODE_CTRL_MC,
> +				  TJA1145_MODE_CRTL_STBY);
> +}
> +
> +static const struct phy_ops tja1145_phy_ops =3D {
> +	.power_on =3D tja1145_phy_power_on,
> +	.power_off =3D tja1145_phy_power_off,
> +};
> +
> +static const struct regmap_range tja1145_wr_holes_ranges[] =3D {
> +	regmap_reg_range(0x00, 0x00),
> +	regmap_reg_range(0x02, 0x03),
> +	regmap_reg_range(0x05, 0x05),
> +	regmap_reg_range(0x0b, 0x1f),
> +	regmap_reg_range(0x21, 0x22),
> +	regmap_reg_range(0x24, 0x25),
> +	regmap_reg_range(0x30, 0x4b),
> +	regmap_reg_range(0x4d, 0x60),
> +	regmap_reg_range(0x62, 0x62),
> +	regmap_reg_range(0x65, 0x67),
> +	regmap_reg_range(0x70, 0xff),
> +};
> +
> +static const struct regmap_access_table tja1145_wr_table =3D {
> +	.no_ranges =3D tja1145_wr_holes_ranges,
> +	.n_no_ranges =3D ARRAY_SIZE(tja1145_wr_holes_ranges),
> +};
> +
> +static const struct regmap_range tja1145_rd_holes_ranges[] =3D {
> +	regmap_reg_range(0x00, 0x00),
> +	regmap_reg_range(0x02, 0x02),
> +	regmap_reg_range(0x05, 0x05),
> +	regmap_reg_range(0x0b, 0x1f),
> +	regmap_reg_range(0x21, 0x21),
> +	regmap_reg_range(0x24, 0x25),
> +	regmap_reg_range(0x30, 0x4a),
> +	regmap_reg_range(0x4d, 0x5f),
> +	regmap_reg_range(0x62, 0x62),
> +	regmap_reg_range(0x65, 0x67),
> +	regmap_reg_range(0x70, 0x7d),
> +	regmap_reg_range(0x7f, 0xff),
> +};
> +
> +static const struct regmap_access_table tja1145_rd_table =3D {
> +	.no_ranges =3D tja1145_rd_holes_ranges,
> +	.n_no_ranges =3D ARRAY_SIZE(tja1145_rd_holes_ranges),
> +};
> +
> +

Nitpick: double newline.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rvnjm33t2wagghg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjsyA0ACgkQDHRl3/mQ
kZx+/wgApCIChGG9fLz5bu/mdV2+ehyx3Sr5WNY6o2vsqzqoxMmgWYNViOzOyB+P
bJWuAgOdtx/lwGbHh4nJ7VTJ9wJkDcXzaHtCPYI+ceQmu5lCSkg2dXqXOUNU8s74
g4MMWgbQ9y6/lVhJIjAjOSUU3CI8jbI4fn9I6eIYTawoItqfv3FIzxrGFxOKqa7+
BuwS1LYuXe7i1CojpZE6QMf5Y7Av3OCu+XHOm1JE95uSfEpb8qRjB/aqGxMWMJUg
ySocudvRFZ2Oco/xQRmdOofXrM6TUijNCSJxCoGkpFZAMmRoBj7VfnJYTwnTGkEk
gYZDLJKhEfAX3Xr6m6hQPl9vcoT4IQ==
=N8i0
-----END PGP SIGNATURE-----

--rvnjm33t2wagghg4--

