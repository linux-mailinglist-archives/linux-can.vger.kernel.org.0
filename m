Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1C0D1B3A
	for <lists+linux-can@lfdr.de>; Wed,  9 Oct 2019 23:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfJIVwP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Oct 2019 17:52:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35799 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731155AbfJIVwP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Oct 2019 17:52:15 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iIJsT-0004Ss-RS; Wed, 09 Oct 2019 23:52:14 +0200
Received: from [IPv6:2a03:f580:87bc:d400:a936:4bb2:bd47:1f85] (unknown [IPv6:2a03:f580:87bc:d400:a936:4bb2:bd47:1f85])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E51BF463BE7;
        Wed,  9 Oct 2019 21:52:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     =?UTF-8?Q?Timo_Schl=c3=bc=c3=9fler?= <t.schluessler@krause.de>
References: <20191009213136.28776-1-mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2] can: mcp251x: add GPIO support
Message-ID: <1b1cbdaa-cfef-e6a4-99f8-44674bb06609@pengutronix.de>
Date:   Wed, 9 Oct 2019 23:52:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009213136.28776-1-mkl@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4k1DNsjWVKBYR4khPCYWPUMYZQI52kKCI"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4k1DNsjWVKBYR4khPCYWPUMYZQI52kKCI
Content-Type: multipart/mixed; boundary="7ZtTje1zytyKntIVScJa9ANZBMr7KsNWG";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org
Cc: =?UTF-8?Q?Timo_Schl=c3=bc=c3=9fler?= <t.schluessler@krause.de>
Message-ID: <1b1cbdaa-cfef-e6a4-99f8-44674bb06609@pengutronix.de>
Subject: Re: [PATCH v2] can: mcp251x: add GPIO support
References: <20191009213136.28776-1-mkl@pengutronix.de>
In-Reply-To: <20191009213136.28776-1-mkl@pengutronix.de>

--7ZtTje1zytyKntIVScJa9ANZBMr7KsNWG
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/9/19 11:31 PM, Marc Kleine-Budde wrote:
> From: Timo Schl=C3=BC=C3=9Fler <t.schluessler@krause.de>
>=20
> ---
> Hello,
>=20
> for easier reivew send via git-send-email

please fix the following checkpatch warnings:

CHECK: Macro argument 'n' may be better as '(n)' to avoid precedence issu=
es
#166: FILE: drivers/net/can/spi/mcp251x.c:166:
+#define RXFSID(n) ((n < 3) ? 0 : 4)

CHECK: Macro argument reuse 'n' - possible side-effects?
#167: FILE: drivers/net/can/spi/mcp251x.c:167:
+#define RXFSIDH(n) ((n) * 4 + RXFSID(n))

CHECK: Macro argument reuse 'n' - possible side-effects?
#168: FILE: drivers/net/can/spi/mcp251x.c:168:
+#define RXFSIDL(n) ((n) * 4 + 1 + RXFSID(n))

CHECK: Macro argument reuse 'n' - possible side-effects?
#169: FILE: drivers/net/can/spi/mcp251x.c:169:
+#define RXFEID8(n) ((n) * 4 + 2 + RXFSID(n))

CHECK: Macro argument reuse 'n' - possible side-effects?
#170: FILE: drivers/net/can/spi/mcp251x.c:170:
+#define RXFEID0(n) ((n) * 4 + 3 + RXFSID(n))

WARNING: static const char * array should probably be static const char
* const
#901: FILE: drivers/net/can/spi/mcp251x.c:901:
+static const char * mcp251x_gpio_names[] =3D {

ERROR: "foo * bar" should be "foo *bar"
#901: FILE: drivers/net/can/spi/mcp251x.c:901:
+static const char * mcp251x_gpio_names[] =3D {

CHECK: braces {} should be used on all arms of this statement
#959: FILE: drivers/net/can/spi/mcp251x.c:959:
+       if (offset <=3D TX2RTS) {
[...]
+       } else if (offset <=3D RX1BF) {
[...]
+       } else
[...]

CHECK: Unbalanced braces around else statement
#965: FILE: drivers/net/can/spi/mcp251x.c:965:
+       } else


>=20
> Marc
>=20
>  drivers/net/can/spi/mcp251x.c | 208 ++++++++++++++++++++++++++++++++++=

>  1 file changed, 208 insertions(+)
>=20
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251=
x.c
> index bee9f7b8dad6..070da1ff7a18 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -39,6 +39,8 @@
>  #include <linux/spi/spi.h>
>  #include <linux/uaccess.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/driver.h>
> =20
>  /* SPI interface instruction set */
>  #define INSTRUCTION_WRITE	0x02
> @@ -53,6 +55,15 @@
>  #define INSTRUCTION_RTS(n)	(0x80 | ((n) & 0x07))
> =20
>  /* MPC251x registers */
> +#define BFPCTRL			0x0c
> +#  define BFPCTRL_B0BFE		0x04
> +#  define BFPCTRL_B1BFE		0x08
> +#  define BFPCTRL_B0BFS		0x10
> +#  define BFPCTRL_B1BFS		0x20
> +#define TXRTSCTRL		0x0d
> +#  define TXRTSCTRL_B0RTS	0x08
> +#  define TXRTSCTRL_B1RTS	0x10
> +#  define TXRTSCTRL_B2RTS	0x20
>  #define CANSTAT	      0x0e
>  #define CANCTRL	      0x0f
>  #  define CANCTRL_REQOP_MASK	    0xe0
> @@ -226,6 +237,9 @@ struct mcp251x_priv {
>  	struct regulator *power;
>  	struct regulator *transceiver;
>  	struct clk *clk;
> +#ifdef CONFIG_GPIOLIB
> +	struct gpio_chip gpio;
> +#endif
>  };
> =20
>  #define MCP251X_IS(_model) \
> @@ -581,6 +595,8 @@ static int mcp251x_hw_reset(struct spi_device *spi)=

>  	if (ret)
>  		return ret;
> =20
> +	/* TODO: What to do with the GPIOs here? Reset last state? */
> +
>  	/* Wait for oscillator startup timer after reset */
>  	mdelay(MCP251X_OST_DELAY_MS);
> =20
> @@ -873,6 +889,183 @@ static irqreturn_t mcp251x_can_ist(int irq, void =
*dev_id)
>  	return IRQ_HANDLED;
>  }
> =20
> +#ifdef CONFIG_GPIOLIB

please remove the ifdef here

> +
> +#define TX0RTS 0
> +#define TX1RTS 1
> +#define TX2RTS 2
> +#define RX0BF 3
> +#define RX1BF 4
> +#define NGPIO 5

please add a common prefix like MCP251X_

> +
> +static const char * mcp251x_gpio_names[] =3D {
> +	"TX0RTS",
> +	"TX1RTS",
> +	"TX2RTS",
> +	"RX0BF",
> +	"RX1BF"
> +};
> +
> +static int mcp251x_gpio_request(struct gpio_chip *chip,
> +				unsigned int offset)

You might need to add a "__maybe_unused" to the functions to avoid
warnings, like this:

static int __maybe_unused mcp251x_gpio_request(struct gpio_chip *chip,
					       unsigned int offset)

> +{
> +	struct mcp251x_priv *priv =3D gpiochip_get_data(chip);
> +	u8 bit =3D BFPCTRL_B0BFE << (offset - RX0BF);
> +
> +	if (offset >=3D NGPIO)
> +		return -EINVAL;
> +	if (offset <=3D TX2RTS) // nothing to be done for inputs

Please use /* */ for comments.

> +		return 0;
> +
> +	mutex_lock(&priv->mcp_lock);
> +	mcp251x_write_bits(priv->spi, BFPCTRL, bit, bit);
> +	mutex_unlock(&priv->mcp_lock);
> +
> +	return 0;
> +}
> +
> +static void mcp251x_gpio_free(struct gpio_chip *chip,
> +			      unsigned int offset)
> +{
> +	struct mcp251x_priv *priv =3D gpiochip_get_data(chip);
> +	u8 bit =3D BFPCTRL_B0BFE << (offset - RX0BF);
> +
> +	if (offset >=3D NGPIO)
> +		return;
> +	if (offset <=3D TX2RTS) // nothing to be done for inputs

same here

> +		return;
> +
> +	mutex_lock(&priv->mcp_lock);
> +	mcp251x_write_bits(priv->spi, BFPCTRL, bit, 0);
> +	mutex_unlock(&priv->mcp_lock);
> +}
> +
> +static int mcp251x_gpio_get_direction(struct gpio_chip *chip,
> +				      unsigned int offset)
> +{
> +	if (offset <=3D TX2RTS)
> +		return GPIOF_DIR_IN;
> +	else if (offset <=3D RX1BF)
> +		return GPIOF_DIR_OUT;
> +
> +	return -EINVAL;
> +}
> +
> +static int mcp251x_gpio_get(struct gpio_chip *chip, unsigned int offse=
t)
> +{
> +	struct mcp251x_priv *priv =3D gpiochip_get_data(chip);
> +	u8 reg, mask, val;
> +
> +	if (offset <=3D TX2RTS) {
> +		reg =3D TXRTSCTRL;
> +		mask =3D TXRTSCTRL_B0RTS << offset;
> +	} else if (offset <=3D RX1BF) {
> +		reg =3D BFPCTRL;
> +		mask =3D BFPCTRL_B0BFS << (offset - RX0BF);
> +	} else
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->mcp_lock);
> +	val =3D mcp251x_read_reg(priv->spi, reg);
> +	mutex_unlock(&priv->mcp_lock);
> +
> +	if (val & mask)
> +		return 1;
> +	return 0;
> +}
> +
> +static int mcp251x_gpio_get_multiple(struct gpio_chip *chip,
> +				     unsigned long *mask, unsigned long *bits)
> +{
> +	struct mcp251x_priv *priv =3D gpiochip_get_data(chip);
> +	unsigned long retbits =3D 0;
> +
> +	mutex_lock(&priv->mcp_lock);
> +
> +	if (mask[0] & GENMASK(TX2RTS, TX0RTS))
> +		retbits |=3D mcp251x_read_reg(priv->spi, TXRTSCTRL)
> +					>> __ffs(TXRTSCTRL_B0RTS);

please move the >> to the end of the preevious line

> +	if (mask[0] & GENMASK(RX1BF, RX0BF))
> +		retbits |=3D (mcp251x_read_reg(priv->spi, BFPCTRL)
> +					>> (__ffs(BFPCTRL_B0BFS) - RX0BF))
> +					& GENMASK(RX1BF, RX0BF);

same here
> +
> +	mutex_unlock(&priv->mcp_lock);
> +
> +	bits[0] =3D retbits;
> +	return 0;
> +}
> +
> +static void mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offs=
et,
> +			     int value)
> +{
> +	struct mcp251x_priv *priv =3D gpiochip_get_data(chip);
> +	u8 mask;
> +
> +	if (offset < RX0BF)
> +		return;
> +
> +	mask =3D BFPCTRL_B0BFS << (offset - RX0BF);
> +
> +	mutex_lock(&priv->mcp_lock);
> +	mcp251x_write_bits(priv->spi, BFPCTRL, mask, value ? mask : 0);
> +	mutex_unlock(&priv->mcp_lock);
> +}
> +
> +static void mcp251x_gpio_set_multiple(struct gpio_chip *chip,
> +				      unsigned long *mask, unsigned long *bits)
> +{
> +	struct mcp251x_priv *priv =3D gpiochip_get_data(chip);
> +	u8 reg_mask =3D 0, value =3D 0;
> +	int pin;
> +
> +	for (pin =3D RX0BF; pin <=3D RX1BF; pin++) {
> +		if (test_bit(pin, mask)) {
> +			u8 mask_val =3D BFPCTRL_B0BFS << (pin - RX0BF);
> +
> +			reg_mask |=3D mask_val;
> +			if (test_bit(pin, bits))
> +				value |=3D mask_val;
> +		}
> +	}
> +
> +	if (!reg_mask)
> +		return;
> +
> +	mutex_lock(&priv->mcp_lock);
> +	mcp251x_write_bits(priv->spi, BFPCTRL, reg_mask, value);
> +	mutex_unlock(&priv->mcp_lock);
> +}
> +

I think it's enough to move the #ifdef CONFIG_GPIOLIB here...

> +static int mcp251x_gpio_setup(struct mcp251x_priv *priv)
> +{
> +	struct gpio_chip *gpio =3D &priv->gpio;
> +
> +	/* gpiochip handles TX[0..2]RTS and RX[0..1]BF */
> +	gpio->label                =3D priv->spi->modalias;
> +	gpio->parent               =3D &priv->spi->dev;
> +	gpio->owner                =3D THIS_MODULE;
> +	gpio->request              =3D mcp251x_gpio_request;
> +	gpio->free                 =3D mcp251x_gpio_free;
> +	gpio->get_direction        =3D mcp251x_gpio_get_direction;
> +	gpio->get                  =3D mcp251x_gpio_get;
> +	gpio->get_multiple         =3D mcp251x_gpio_get_multiple;
> +	gpio->set                  =3D mcp251x_gpio_set;
> +	gpio->set_multiple         =3D mcp251x_gpio_set_multiple;
> +	gpio->base                 =3D -1;
> +	gpio->ngpio                =3D NGPIO;
> +	gpio->names                =3D mcp251x_gpio_names;
> +	gpio->can_sleep            =3D 1;

please use only one space in front of the "=3D"

> +
> +	return gpiochip_add_data(gpio, priv);
> +}

=2E..and provide a static inline nop for the mcp251x_gpio_setup() and
remove() functions in the #else branch, like this:

static inline int mcp251x_gpio_setup(struct mcp251x_priv *priv)
{
	return 0;
}

> +
> +static void mcp251x_gpio_remove(struct mcp251x_priv *priv)
> +{
> +	gpiochip_remove(&priv->gpio);
> +}
> +#endif // CONFIG_GPIOLIB
> +
>  static int mcp251x_open(struct net_device *net)
>  {
>  	struct mcp251x_priv *priv =3D netdev_priv(net);
> @@ -1089,9 +1282,20 @@ static int mcp251x_can_probe(struct spi_device *=
spi)
> =20
>  	devm_can_led_init(net);
> =20
> +#ifdef CONFIG_GPIOLIB

Then it should be possible to remove these ifdefs...

> +	ret =3D mcp251x_gpio_setup(priv);
> +	if (ret)
> +		goto error_gpio;
> +#endif
> +
>  	netdev_info(net, "MCP%x successfully initialized.\n", priv->model);
>  	return 0;
> =20
> +#ifdef CONFIG_GPIOLIB
> +error_gpio:
> +	mcp251x_gpio_remove(priv);
> +#endif
> +
>  error_probe:
>  	mcp251x_power_enable(priv->power, 0);
> =20
> @@ -1112,6 +1316,10 @@ static int mcp251x_can_remove(struct spi_device =
*spi)
> =20
>  	unregister_candev(net);
> =20
> +#ifdef CONFIG_GPIOLIB
> +	mcp251x_gpio_remove(priv);
> +#endif
> +
>  	mcp251x_power_enable(priv->power, 0);
> =20
>  	clk_disable_unprepare(priv->clk);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7ZtTje1zytyKntIVScJa9ANZBMr7KsNWG--

--4k1DNsjWVKBYR4khPCYWPUMYZQI52kKCI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2eVocACgkQWsYho5Hk
nSCAVQgArooFP934oHJiKe9b6wKfjVmM6+4Lp0yIM+4fV+c4tRsW8h4exqQegQDz
c1K/Io5hsFJsyTH5lnPCVVsc1B0NjjpTYqLk+PD3BqP3wWsDNUtfBGS1tMoneY9y
7FC95diQBrMt6vEpkx/B5QsfCTjSGGkeUhAzAFCLFGitwo9Tqx4usjTq2qTPwf1e
YvKyfn2++6EKJFykacd4wXLF3DpjP8LshUPpqcW/Oa3KcVfTwhYT28nMpzrc0r9m
QEVFjye7sxvjq433z+NkfpY5AbGD66YubKYiHf2CWa54AC1HmaFkY1mIjOx1T0uu
m9LBWg/FbP+Oseg1gxX85mYbBt8NwA==
=qZqL
-----END PGP SIGNATURE-----

--4k1DNsjWVKBYR4khPCYWPUMYZQI52kKCI--
