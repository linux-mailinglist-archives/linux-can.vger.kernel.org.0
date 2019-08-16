Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C858A8FF39
	for <lists+linux-can@lfdr.de>; Fri, 16 Aug 2019 11:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfHPJnp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Aug 2019 05:43:45 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44711 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfHPJno (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Aug 2019 05:43:44 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hyYlp-0000PG-8K; Fri, 16 Aug 2019 11:43:41 +0200
Received: from [IPv6:2001:67c:670:202:595f:209f:a34b:fbc1] (unknown [IPv6:2001:67c:670:202:595f:209f:a34b:fbc1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4F2C3446701;
        Fri, 16 Aug 2019 09:43:40 +0000 (UTC)
Subject: Re: [PATCH v12 4/5] can: tcan4x5x: Add tcan4x5x driver to the kernel
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-can@vger.kernel.org
References: <20190509161109.10499-1-dmurphy@ti.com>
 <20190509161109.10499-4-dmurphy@ti.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f6a07c62-3a2b-85a9-b402-0283ace18222@pengutronix.de>
Date:   Fri, 16 Aug 2019 11:43:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190509161109.10499-4-dmurphy@ti.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4pWqFJ6OKLr5wcEpFUImo4hx9T5faw743"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4pWqFJ6OKLr5wcEpFUImo4hx9T5faw743
Content-Type: multipart/mixed; boundary="6aTJ1vAl6IU6I0tkWzG0IjKmD7idMlr94";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-can@vger.kernel.org
Message-ID: <f6a07c62-3a2b-85a9-b402-0283ace18222@pengutronix.de>
Subject: Re: [PATCH v12 4/5] can: tcan4x5x: Add tcan4x5x driver to the kernel
References: <20190509161109.10499-1-dmurphy@ti.com>
 <20190509161109.10499-4-dmurphy@ti.com>
In-Reply-To: <20190509161109.10499-4-dmurphy@ti.com>

--6aTJ1vAl6IU6I0tkWzG0IjKmD7idMlr94
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 5/9/19 6:11 PM, Dan Murphy wrote:
> Add the TCAN4x5x SPI CAN driver.  This device uses the
> Bosch MCAN IP core along with a SPI interface map.
> Register to the MCAN common core code to manage the MCAN IP.
>=20
> This device has a special method to indicate a write/read
> operation on the data payload.
>=20
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>=20
> v12 - No changes - https://lore.kernel.org/patchwork/patch/1052301/
>=20
> v11 - No changes - https://lore.kernel.org/patchwork/patch/1051180/
> v10 - No changes - https://lore.kernel.org/patchwork/patch/1050490/
> v9 - No changes - https://lore.kernel.org/patchwork/patch/1050119/
> v8 - No changes - https://lore.kernel.org/patchwork/patch/1047978/
> v7 - Fixed remaining checkpatch issues and renamed callbacks for m_can =
change -
> https://lore.kernel.org/patchwork/patch/1047221/
> v6 - Updated Kconfig help and added REGMAP_SPI dependency, fixed coding=
 style issues,
> removed setting GPIO high in wake routine, change -EIO to return ret in=
 init and
> setup functions - https://lore.kernel.org/patchwork/patch/1042443/
>=20
>  drivers/net/can/m_can/Kconfig    |   9 +
>  drivers/net/can/m_can/Makefile   |   1 +
>  drivers/net/can/m_can/tcan4x5x.c | 533 +++++++++++++++++++++++++++++++=

>  3 files changed, 543 insertions(+)
>  create mode 100644 drivers/net/can/m_can/tcan4x5x.c
>=20
> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kcon=
fig
> index f7119fd72df4..cf4f32765efa 100644
> --- a/drivers/net/can/m_can/Kconfig
> +++ b/drivers/net/can/m_can/Kconfig
> @@ -12,3 +12,12 @@ config CAN_M_CAN_PLATFORM
>  	  Say Y here if you want support for IO Mapped Bosch M_CAN controller=
=2E
>  	  This support is for devices that have the Bosch M_CAN controller
>  	  IP embedded into the device and the IP is IO Mapped to the processo=
r.
> +
> +config CAN_M_CAN_TCAN4X5X
> +	depends on CAN_M_CAN
> +	depends on REGMAP_SPI
> +	tristate "TCAN4X5X M_CAN device"
> +	---help---
> +	  Say Y here if you want support for Texas Instruments TCAN4x5x
> +	  M_CAN controller.  This device is a peripherial device that uses th=
e
> +	  SPI bus for communication.
> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Mak=
efile
> index 057bbcdb3c74..e77f0eccff97 100644
> --- a/drivers/net/can/m_can/Makefile
> +++ b/drivers/net/can/m_can/Makefile
> @@ -4,3 +4,4 @@
> =20
>  obj-$(CONFIG_CAN_M_CAN) +=3D m_can.o
>  obj-$(CONFIG_CAN_M_CAN_PLATFORM) +=3D m_can_platform.o
> +obj-$(CONFIG_CAN_M_CAN_TCAN4X5X) +=3D tcan4x5x.o
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/t=
can4x5x.c
> new file mode 100644
> index 000000000000..411502c3c98e
> --- /dev/null
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -0,0 +1,533 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPI to CAN driver for the Texas Instruments TCAN4x5x
> +// Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.t=
i.com/
> +
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/regulator/consumer.h>
> +#include <linux/gpio/consumer.h>
> +
> +#include "m_can.h"
> +
> +#define DEVICE_NAME "tcan4x5x"
> +#define TCAN4X5X_EXT_CLK_DEF	40000000
> +
> +#define TCAN4X5X_DEV_ID0	0x00
> +#define TCAN4X5X_DEV_ID1	0x04
> +#define TCAN4X5X_REV		0x08
> +#define TCAN4X5X_STATUS		0x0C
> +#define TCAN4X5X_ERROR_STATUS	0x10
> +#define TCAN4X5X_CONTROL	0x14
> +
> +#define TCAN4X5X_CONFIG		0x800
> +#define TCAN4X5X_TS_PRESCALE	0x804
> +#define TCAN4X5X_TEST_REG	0x808
> +#define TCAN4X5X_INT_FLAGS	0x820
> +#define TCAN4X5X_MCAN_INT_REG	0x824
> +#define TCAN4X5X_INT_EN		0x830
> +
> +/* Interrupt bits */
> +#define TCAN4X5X_CANBUSTERMOPEN_INT_EN	BIT(30)
> +#define TCAN4X5X_CANHCANL_INT_EN	BIT(29)
> +#define TCAN4X5X_CANHBAT_INT_EN		BIT(28)
> +#define TCAN4X5X_CANLGND_INT_EN		BIT(27)
> +#define TCAN4X5X_CANBUSOPEN_INT_EN	BIT(26)
> +#define TCAN4X5X_CANBUSGND_INT_EN	BIT(25)
> +#define TCAN4X5X_CANBUSBAT_INT_EN	BIT(24)
> +#define TCAN4X5X_UVSUP_INT_EN		BIT(22)
> +#define TCAN4X5X_UVIO_INT_EN		BIT(21)
> +#define TCAN4X5X_TSD_INT_EN		BIT(19)
> +#define TCAN4X5X_ECCERR_INT_EN		BIT(16)
> +#define TCAN4X5X_CANINT_INT_EN		BIT(15)
> +#define TCAN4X5X_LWU_INT_EN		BIT(14)
> +#define TCAN4X5X_CANSLNT_INT_EN		BIT(10)
> +#define TCAN4X5X_CANDOM_INT_EN		BIT(8)
> +#define TCAN4X5X_CANBUS_ERR_INT_EN	BIT(5)
> +#define TCAN4X5X_BUS_FAULT		BIT(4)
> +#define TCAN4X5X_MCAN_INT		BIT(1)
> +#define TCAN4X5X_ENABLE_TCAN_INT	(TCAN4X5X_MCAN_INT | \
> +					TCAN4X5X_BUS_FAULT | \
> +					TCAN4X5X_CANBUS_ERR_INT_EN | \
> +					TCAN4X5X_CANINT_INT_EN)
> +
> +/* MCAN Interrupt bits */
> +#define TCAN4X5X_MCAN_IR_ARA		BIT(29)
> +#define TCAN4X5X_MCAN_IR_PED		BIT(28)
> +#define TCAN4X5X_MCAN_IR_PEA		BIT(27)
> +#define TCAN4X5X_MCAN_IR_WD		BIT(26)
> +#define TCAN4X5X_MCAN_IR_BO		BIT(25)
> +#define TCAN4X5X_MCAN_IR_EW		BIT(24)
> +#define TCAN4X5X_MCAN_IR_EP		BIT(23)
> +#define TCAN4X5X_MCAN_IR_ELO		BIT(22)
> +#define TCAN4X5X_MCAN_IR_BEU		BIT(21)
> +#define TCAN4X5X_MCAN_IR_BEC		BIT(20)
> +#define TCAN4X5X_MCAN_IR_DRX		BIT(19)
> +#define TCAN4X5X_MCAN_IR_TOO		BIT(18)
> +#define TCAN4X5X_MCAN_IR_MRAF		BIT(17)
> +#define TCAN4X5X_MCAN_IR_TSW		BIT(16)
> +#define TCAN4X5X_MCAN_IR_TEFL		BIT(15)
> +#define TCAN4X5X_MCAN_IR_TEFF		BIT(14)
> +#define TCAN4X5X_MCAN_IR_TEFW		BIT(13)
> +#define TCAN4X5X_MCAN_IR_TEFN		BIT(12)
> +#define TCAN4X5X_MCAN_IR_TFE		BIT(11)
> +#define TCAN4X5X_MCAN_IR_TCF		BIT(10)
> +#define TCAN4X5X_MCAN_IR_TC		BIT(9)
> +#define TCAN4X5X_MCAN_IR_HPM		BIT(8)
> +#define TCAN4X5X_MCAN_IR_RF1L		BIT(7)
> +#define TCAN4X5X_MCAN_IR_RF1F		BIT(6)
> +#define TCAN4X5X_MCAN_IR_RF1W		BIT(5)
> +#define TCAN4X5X_MCAN_IR_RF1N		BIT(4)
> +#define TCAN4X5X_MCAN_IR_RF0L		BIT(3)
> +#define TCAN4X5X_MCAN_IR_RF0F		BIT(2)
> +#define TCAN4X5X_MCAN_IR_RF0W		BIT(1)
> +#define TCAN4X5X_MCAN_IR_RF0N		BIT(0)
> +#define TCAN4X5X_ENABLE_MCAN_INT	(TCAN4X5X_MCAN_IR_TC | \
> +					TCAN4X5X_MCAN_IR_RF0N | \
> +					TCAN4X5X_MCAN_IR_RF1N | \
> +					TCAN4X5X_MCAN_IR_RF0F | \
> +					TCAN4X5X_MCAN_IR_RF1F)
> +#define TCAN4X5X_MRAM_START	0x8000
> +#define TCAN4X5X_MCAN_OFFSET	0x1000
> +#define TCAN4X5X_MAX_REGISTER	0x8fff
> +
> +#define TCAN4X5X_CLEAR_ALL_INT	0xffffffff
> +#define TCAN4X5X_SET_ALL_INT	0xffffffff
> +
> +#define TCAN4X5X_WRITE_CMD	(0x61 << 24)
> +#define TCAN4X5X_READ_CMD	(0x41 << 24)
> +
> +#define TCAN4X5X_MODE_SEL_MASK		(BIT(7) | BIT(6))
> +#define TCAN4X5X_MODE_SLEEP		0x00
> +#define TCAN4X5X_MODE_STANDBY		BIT(6)
> +#define TCAN4X5X_MODE_NORMAL		BIT(7)
> +
> +#define TCAN4X5X_SW_RESET	BIT(2)
> +
> +#define TCAN4X5X_MCAN_CONFIGURED	BIT(5)
> +#define TCAN4X5X_WATCHDOG_EN		BIT(3)
> +#define TCAN4X5X_WD_60_MS_TIMER		0
> +#define TCAN4X5X_WD_600_MS_TIMER	BIT(28)
> +#define TCAN4X5X_WD_3_S_TIMER		BIT(29)
> +#define TCAN4X5X_WD_6_S_TIMER		(BIT(28) | BIT(29))
> +
> +struct tcan4x5x_priv {
> +	struct regmap *regmap;
> +	struct spi_device *spi;
> +	struct mutex tcan4x5x_lock; /* SPI device lock */
> +
> +	struct m_can_classdev *mcan_dev;
> +
> +	struct gpio_desc *reset_gpio;
> +	struct gpio_desc *interrupt_gpio;
> +	struct gpio_desc *device_wake_gpio;
> +	struct gpio_desc *device_state_gpio;
> +	struct regulator *power;
> +
> +	/* Register based ip */
> +	int mram_start;
> +	int reg_offset;
> +};
> +
> +static struct can_bittiming_const tcan4x5x_bittiming_const =3D {
> +	.name =3D DEVICE_NAME,
> +	.tseg1_min =3D 2,
> +	.tseg1_max =3D 31,
> +	.tseg2_min =3D 2,
> +	.tseg2_max =3D 16,
> +	.sjw_max =3D 16,
> +	.brp_min =3D 1,
> +	.brp_max =3D 32,
> +	.brp_inc =3D 1,
> +};
> +
> +static struct can_bittiming_const tcan4x5x_data_bittiming_const =3D {
> +	.name =3D DEVICE_NAME,
> +	.tseg1_min =3D 1,
> +	.tseg1_max =3D 32,
> +	.tseg2_min =3D 1,
> +	.tseg2_max =3D 16,
> +	.sjw_max =3D 16,
> +	.brp_min =3D 1,
> +	.brp_max =3D 32,
> +	.brp_inc =3D 1,
> +};
> +
> +static void tcan4x5x_check_wake(struct tcan4x5x_priv *priv)
> +{
> +	int wake_state =3D 0;
> +
> +	if (priv->device_state_gpio)
> +		wake_state =3D gpiod_get_value(priv->device_state_gpio);
> +
> +	if (priv->device_wake_gpio && wake_state) {
> +		gpiod_set_value(priv->device_wake_gpio, 0);
> +		usleep_range(5, 50);
> +		gpiod_set_value(priv->device_wake_gpio, 1);
> +	}
> +}
> +
> +static int regmap_spi_gather_write(void *context, const void *reg,
> +				   size_t reg_len, const void *val,
> +				   size_t val_len)
> +{
> +	struct device *dev =3D context;
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	struct spi_message m;
> +	u32 addr;
> +	struct spi_transfer t[2] =3D {
> +		{ .tx_buf =3D &addr, .len =3D reg_len, .cs_change =3D 0,},
> +		{ .tx_buf =3D val, .len =3D val_len, },
> +	};
> +
> +	addr =3D TCAN4X5X_WRITE_CMD | (*((u16 *)reg) << 8) | val_len >> 3;
> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&t[0], &m);
> +	spi_message_add_tail(&t[1], &m);
> +
> +	return spi_sync(spi, &m);
> +}
> +
> +static int tcan4x5x_regmap_write(void *context, const void *data, size=
_t count)
> +{
> +	u16 *reg =3D (u16 *)(data);
> +	const u32 *val =3D data + 4;
> +
> +	return regmap_spi_gather_write(context, reg, 4, val, count);
> +}
> +
> +static int regmap_spi_async_write(void *context,
> +				  const void *reg, size_t reg_len,
> +				  const void *val, size_t val_len,
> +				  struct regmap_async *a)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static struct regmap_async *regmap_spi_async_alloc(void)
> +{
> +	return NULL;
> +}
> +
> +static int tcan4x5x_regmap_read(void *context,
> +				const void *reg, size_t reg_size,
> +				void *val, size_t val_size)
> +{
> +	struct device *dev =3D context;
> +	struct spi_device *spi =3D to_spi_device(dev);
> +
> +	u32 addr =3D TCAN4X5X_READ_CMD | (*((u16 *)reg) << 8) | val_size >> 2=
;
> +
> +	return spi_write_then_read(spi, &addr, reg_size, (u32 *)val, val_size=
);
> +}
> +
> +static struct regmap_bus tcan4x5x_bus =3D {
> +	.write =3D tcan4x5x_regmap_write,
> +	.gather_write =3D regmap_spi_gather_write,
> +	.async_write =3D regmap_spi_async_write,
> +	.async_alloc =3D regmap_spi_async_alloc,
> +	.read =3D tcan4x5x_regmap_read,
> +	.read_flag_mask =3D 0x00,
> +	.reg_format_endian_default =3D REGMAP_ENDIAN_NATIVE,
> +	.val_format_endian_default =3D REGMAP_ENDIAN_NATIVE,
> +};
> +
> +static u32 tcan4x5x_read_reg(struct m_can_classdev *cdev, int reg)
> +{
> +	struct tcan4x5x_priv *priv =3D (struct tcan4x5x_priv *)cdev->device_d=
ata;
> +	u32 val;
> +
> +	tcan4x5x_check_wake(priv);

Do you have to call this every time you access the Chip? Can you move
this into the open() function?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6aTJ1vAl6IU6I0tkWzG0IjKmD7idMlr94--

--4pWqFJ6OKLr5wcEpFUImo4hx9T5faw743
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1WeskACgkQWsYho5Hk
nSCQuQf+JkHHJl+ru4ZRiwNhfTPNdVWtvR4eMC7SCP1BeXzYF5NcbHMUSD5PmfKv
tB1F7Yw7lDi/HAN32jBXiBhWunFGnNm7WcYFGARSHUdx29vFPHU649yPQABxp5Az
hqv4kr1EPjC9U+I0ST4qrsZ7f6Q0v8cbvbceG+Jg+12SAZcUEHkDxhta+V+UvNoD
vAcVaJAfmj40Pk9nvf2NyRRBGt2iLojVuJcYGj/zrjcM+/BSwK/EQ9lOKlvsCj3Y
RgvueejxLYvMum1gV+raComuYJYqucwSv6Ev7sfQAL5Kq0o5pvVu4RGqqWVoeQAa
64rkfz+bT24J/MvwIqTSF2LJZrRiow==
=zFpD
-----END PGP SIGNATURE-----

--4pWqFJ6OKLr5wcEpFUImo4hx9T5faw743--
