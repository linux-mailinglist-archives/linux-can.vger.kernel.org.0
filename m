Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C743DFDCE
	for <lists+linux-can@lfdr.de>; Wed,  4 Aug 2021 11:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhHDJT1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Aug 2021 05:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbhHDJTQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Aug 2021 05:19:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB96C0613D5
        for <linux-can@vger.kernel.org>; Wed,  4 Aug 2021 02:19:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mBD3F-0004PM-TN; Wed, 04 Aug 2021 11:19:02 +0200
Received: from pengutronix.de (unknown [IPv6:2a02:810a:8940:aa0:e44:2d7c:bf4a:7b36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 485A96606DC;
        Wed,  4 Aug 2021 09:19:00 +0000 (UTC)
Date:   Wed, 4 Aug 2021 11:18:58 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Matt Kline <matt@bitbashing.io>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH v2 2/2] can: m_can: Batch FIFO writes during CAN transmit
Message-ID: <20210804091858.vvvrzrmnmi76mg3c@pengutronix.de>
References: <20210727015855.17482-1-matt@bitbashing.io>
 <20210727015855.17482-3-matt@bitbashing.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6lm5m36afn7usqet"
Content-Disposition: inline
In-Reply-To: <20210727015855.17482-3-matt@bitbashing.io>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--6lm5m36afn7usqet
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2021 18:58:55, Matt Kline wrote:
> Give FIFO writes the same treatment as reads to avoid fixed costs of
> individual transfers on a slow bus (e.g., tcan4x5x).
>=20
> Signed-off-by: Matt Kline <matt@bitbashing.io>
> ---
>  drivers/net/can/m_can/m_can.c          | 55 ++++++++++++--------------
>  drivers/net/can/m_can/m_can.h          |  2 +-
>  drivers/net/can/m_can/m_can_pci.c      |  5 ++-
>  drivers/net/can/m_can/m_can_platform.c |  5 ++-
>  drivers/net/can/m_can/tcan4x5x-core.c  |  4 +-
>  5 files changed, 34 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 233d5da907ec..7aae2d19ad65 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -278,7 +278,7 @@ enum m_can_reg {
>  /* Message RAM Elements */
>  #define M_CAN_FIFO_ID		0x0
>  #define M_CAN_FIFO_DLC		0x4
> -#define M_CAN_FIFO_DATA(n)	(0x8 + ((n) << 2))
> +#define M_CAN_FIFO_DATA		0x8
> =20
>  /* Rx Buffer Element */
>  /* R0 */
> @@ -331,18 +331,20 @@ static void m_can_fifo_read(struct m_can_classdev *=
cdev,
>  }
> =20
>  static void m_can_fifo_write(struct m_can_classdev *cdev,
> -			     u32 fpi, unsigned int offset, u32 val)
> +			     u32 fpi, unsigned int offset, const void *val, size_t val_count)
>  {
>  	u32 addr_offset =3D cdev->mcfg[MRAM_TXB].off + fpi * TXB_ELEMENT_SIZE +
>  		offset;
> +	int result;
> =20
> -	cdev->ops->write_fifo(cdev, addr_offset, val);
> +	result =3D cdev->ops->write_fifo(cdev, addr_offset, val, val_count);
> +	WARN_ON(result !=3D 0);

What about converting all read/write functions to return an error, and
handle the error in the caller?

>  }
> =20
>  static inline void m_can_fifo_write_no_off(struct m_can_classdev *cdev,
>  					   u32 fpi, u32 val)
>  {
> -	cdev->ops->write_fifo(cdev, fpi, val);
> +	cdev->ops->write_fifo(cdev, fpi, &val, 1);
>  }
> =20
>  static u32 m_can_txe_fifo_read(struct m_can_classdev *cdev, u32 fgi, u32=
 offset)
> @@ -506,7 +508,7 @@ static void m_can_read_fifo(struct net_device *dev, u=
32 rxfs)
>  		if (dlc & RX_BUF_BRS)
>  			cf->flags |=3D CANFD_BRS;
> =20
> -		m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA(0), cf->data, DIV_ROUND_UP(=
cf->len, 4));
> +		m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA, cf->data, DIV_ROUND_UP(cf-=
>len, 4));
>  	}
> =20
>  	/* acknowledge rx fifo 0 */
> @@ -1546,8 +1548,8 @@ static netdev_tx_t m_can_tx_handler(struct m_can_cl=
assdev *cdev)
>  	struct net_device *dev =3D cdev->net;
>  	struct sk_buff *skb =3D cdev->tx_skb;
>  	u32 id, cccr, fdflags;
> -	int i;
>  	int putidx;
> +	u32 id_and_dlc[2];

Can you create a struct for this?

> =20
>  	cdev->tx_skb =3D NULL;
> =20
> @@ -1563,18 +1565,16 @@ static netdev_tx_t m_can_tx_handler(struct m_can_=
classdev *cdev)
>  	if (cf->can_id & CAN_RTR_FLAG)
>  		id |=3D TX_BUF_RTR;
> =20
> +	id_and_dlc[0] =3D id;
> +
>  	if (cdev->version =3D=3D 30) {
>  		netif_stop_queue(dev);
> =20
> -		/* message ram configuration */
> -		m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, id);
> -		m_can_fifo_write(cdev, 0, M_CAN_FIFO_DLC,
> -				 can_fd_len2dlc(cf->len) << 16);
> +		id_and_dlc[1] =3D can_fd_len2dlc(cf->len) << 16;
> =20
> -		for (i =3D 0; i < cf->len; i +=3D 4)
> -			m_can_fifo_write(cdev, 0,
> -					 M_CAN_FIFO_DATA(i / 4),
> -					 *(u32 *)(cf->data + i));
> +		/* Write the frame ID, DLC, and payload to the FIFO element. */
> +		m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, id_and_dlc, ARRAY_SIZE(id_and=
_dlc));
> +		m_can_fifo_write(cdev, 0, M_CAN_FIFO_DATA, cf->data, DIV_ROUND_UP(cf->=
len, 4));

Does it make sense to combine these, too? Same for the v3.1 variant.

> =20
>  		can_put_echo_skb(skb, dev, 0, 0);
> =20
> @@ -1618,8 +1618,11 @@ static netdev_tx_t m_can_tx_handler(struct m_can_c=
lassdev *cdev)
>  		/* get put index for frame */
>  		putidx =3D FIELD_GET(TXFQS_TFQPI_MASK,
>  				   m_can_read(cdev, M_CAN_TXFQS));
> -		/* Write ID Field to FIFO Element */
> -		m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, id);
> +
> +		/* Construct the DLC Field, with CAN-FD configuration.
> +		 * Use the put index of fifo as message the marker,
> +		 * used in the TX interrupt for sending the correct echo frame.
> +		 */
> =20
>  		/* get CAN FD configuration of frame */
>  		fdflags =3D 0;
> @@ -1628,21 +1631,13 @@ static netdev_tx_t m_can_tx_handler(struct m_can_=
classdev *cdev)
>  			if (cf->flags & CANFD_BRS)
>  				fdflags |=3D TX_BUF_BRS;
>  		}
> +		id_and_dlc[1] =3D FIELD_PREP(TX_BUF_MM_MASK, putidx) |
> +				 FIELD_PREP(TX_BUF_DLC_MASK, can_fd_len2dlc(cf->len)) |
> +				 fdflags | TX_BUF_EFC;
> =20
> -		/* Construct DLC Field. Also contains CAN-FD configuration
> -		 * use put index of fifo as message marker
> -		 * it is used in TX interrupt for
> -		 * sending the correct echo frame
> -		 */
> -		m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DLC,
> -				 FIELD_PREP(TX_BUF_MM_MASK, putidx) |
> -				 FIELD_PREP(TX_BUF_DLC_MASK,
> -					    can_fd_len2dlc(cf->len)) |
> -				 fdflags | TX_BUF_EFC);
> -
> -		for (i =3D 0; i < cf->len; i +=3D 4)
> -			m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DATA(i / 4),
> -					 *(u32 *)(cf->data + i));
> +		/* Write the frame ID, DLC, and payload to the FIFO element. */
> +		m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, id_and_dlc, ARRAY_SIZE(i=
d_and_dlc));
> +		m_can_fifo_write(cdev, 0, M_CAN_FIFO_DATA, cf->data, DIV_ROUND_UP(cf->=
len, 4));
> =20
>  		/* Push loopback echo.
>  		 * Will be looped back on TX interrupt based on message marker
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index 2571ec1efec4..edf2477b064f 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -66,7 +66,7 @@ struct m_can_ops {
>  	int (*write_reg)(struct m_can_classdev *cdev, int reg, int val);
>  	int (*read_fifo)(struct m_can_classdev *cdev, int addr_offset, void *va=
l, size_t val_count);
>  	int (*write_fifo)(struct m_can_classdev *cdev, int addr_offset,
> -			  int val);
> +			  const void *val, size_t val_count);
>  	int (*init)(struct m_can_classdev *cdev);
>  };
> =20
> diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_=
can_pci.c
> index 11614a635796..89cc3d41e952 100644
> --- a/drivers/net/can/m_can/m_can_pci.c
> +++ b/drivers/net/can/m_can/m_can_pci.c
> @@ -57,11 +57,12 @@ static int iomap_write_reg(struct m_can_classdev *cde=
v, int reg, int val)
>  	return 0;
>  }
> =20
> -static int iomap_write_fifo(struct m_can_classdev *cdev, int offset, int=
 val)
> +static int iomap_write_fifo(struct m_can_classdev *cdev, int offset,
> +			    const void *val, size_t val_count)
>  {
>  	struct m_can_pci_priv *priv =3D cdev_to_priv(cdev);
> =20
> -	writel(val, priv->base + offset);
> +	iowrite32_rep(priv->base + offset, val, val_count);
> =20
>  	return 0;
>  }
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_c=
an/m_can_platform.c
> index 94c82dd39076..40e5351c7f74 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -46,11 +46,12 @@ static int iomap_write_reg(struct m_can_classdev *cde=
v, int reg, int val)
>  	return 0;
>  }
> =20
> -static int iomap_write_fifo(struct m_can_classdev *cdev, int offset, int=
 val)
> +static int iomap_write_fifo(struct m_can_classdev *cdev, int offset,
> +			    const void *val, size_t val_count)
>  {
>  	struct m_can_plat_priv *priv =3D cdev_to_priv(cdev);
> =20
> -	writel(val, priv->mram_base + offset);
> +	iowrite32_rep(priv->base + offset, val, val_count);
> =20
>  	return 0;
>  }
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_ca=
n/tcan4x5x-core.c
> index 4f77b1dbd492..89d2009c895b 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -170,11 +170,11 @@ static int tcan4x5x_write_reg(struct m_can_classdev=
 *cdev, int reg, int val)
>  }
> =20
>  static int tcan4x5x_write_fifo(struct m_can_classdev *cdev,
> -			       int addr_offset, int val)
> +			       int addr_offset, const void *val, size_t val_count)
>  {
>  	struct tcan4x5x_priv *priv =3D cdev_to_priv(cdev);
> =20
> -	return regmap_write(priv->regmap, TCAN4X5X_MRAM_START + addr_offset, va=
l);
> +	return regmap_bulk_write(priv->regmap, TCAN4X5X_MRAM_START + addr_offse=
t, val, val_count);
>  }
> =20
>  static int tcan4x5x_power_enable(struct regulator *reg, int enable)
> --=20
> 2.32.0

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--6lm5m36afn7usqet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmEKW3gACgkQqclaivrt
76lzFQgAoGyP7PWrdUH3/xPmFAnsp7gczwJXdHjgZ0zzjbfct3uQEenSkVVFT+RN
sS8gN+B+Q7jIRk5QI+zUyeQqsbuPqWO76oguQIFkqCiKMkLyIQ5zi0cZhZcE5BUn
Gr5no5wpH/jOVE6yW7UYKasm56+VqX5G5mSGl773mlK6B5Tp35RgVzo0BtmulBE7
RtzXmy5FS8I6xCf11dzZ8o5WJuUxpDcRcrs8BQCUKeuZn2httzWLmhms73e9fyZ9
O+9UKg6NvuC9etyas3pTdvTOH+B+bu1yWc+rhlwRm4aNG1pa9sFzcqSaUl4/O2Gp
Do/FlRoh1s0SNmflPcgn6HPBVT8q0Q==
=2Hg8
-----END PGP SIGNATURE-----

--6lm5m36afn7usqet--
