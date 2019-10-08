Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54303CF716
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 12:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfJHKiA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 06:38:00 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34485 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfJHKiA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2019 06:38:00 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iHmsR-0007Dg-7d; Tue, 08 Oct 2019 12:37:59 +0200
Received: from [IPv6:2a03:f580:87bc:d400:5c56:5f:3a91:7a40] (unknown [IPv6:2a03:f580:87bc:d400:5c56:5f:3a91:7a40])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4A77D4622FE;
        Tue,  8 Oct 2019 10:37:58 +0000 (UTC)
To:     Stephane Grosjean <s.grosjean@peak-system.com>,
        linux-can Mailing List <linux-can@vger.kernel.org>
References: <20191008083545.4569-1-s.grosjean@peak-system.com>
 <20191008083545.4569-3-s.grosjean@peak-system.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 2/2] can/peak_usb/pcan_usb: add support of rxerr/txerr
 counters
Message-ID: <4416597c-6db7-057d-36b5-dc4b2c15117f@pengutronix.de>
Date:   Tue, 8 Oct 2019 12:37:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191008083545.4569-3-s.grosjean@peak-system.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="zrompV2ld2shdBxJ0XnXA4629XQkgy4l7"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zrompV2ld2shdBxJ0XnXA4629XQkgy4l7
Content-Type: multipart/mixed; boundary="yEj4zppjot6huXNl5cNP5d2ICjYxnMNxX";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <4416597c-6db7-057d-36b5-dc4b2c15117f@pengutronix.de>
Subject: Re: [PATCH 2/2] can/peak_usb/pcan_usb: add support of rxerr/txerr
 counters
References: <20191008083545.4569-1-s.grosjean@peak-system.com>
 <20191008083545.4569-3-s.grosjean@peak-system.com>
In-Reply-To: <20191008083545.4569-3-s.grosjean@peak-system.com>

--yEj4zppjot6huXNl5cNP5d2ICjYxnMNxX
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 10/8/19 10:35 AM, Stephane Grosjean wrote:
> This patch adds the support of the rx/tx errors CAN counters to the
> driver of the PCAN-USB PC-CAN interface from PEAK-System GmbH.
>=20
> The PCAN-USB is internally equipped with a SJA1000 -like CAN controller=
,
> therefore it is capable of giving back the values of the rx/tx errors
> counters, to provide more details and statistics to the linux-can layer=
=2E
> Moreover, getting these values allows the driver to better tune
> CAN_ERR_CRTL_TX_xxx and CAN_ERR_CRTL_RX_xxx bits in case of
> the interface enters the CAN_STATE_ERROR_xxx state.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb.c | 175 ++++++++++++++++++++++--=

>  1 file changed, 160 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/=
usb/peak_usb/pcan_usb.c
> index d2539c95adb6..b0b722cb327c 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -66,6 +66,10 @@ MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB adapte=
r");
>  #define PCAN_USB_ERROR_QOVR		0x40
>  #define PCAN_USB_ERROR_TXQFULL		0x80
> =20
> +#define PCAN_USB_ERROR_BUS		(PCAN_USB_ERROR_BUS_LIGHT | \
> +					 PCAN_USB_ERROR_BUS_HEAVY | \
> +					 PCAN_USB_ERROR_BUS_OFF)
> +
>  /* SJA1000 modes */
>  #define SJA1000_MODE_NORMAL		0x00
>  #define SJA1000_MODE_INIT		0x01
> @@ -85,11 +89,31 @@ MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB adapt=
er");
>  #define PCAN_USB_REC_TS			4
>  #define PCAN_USB_REC_BUSEVT		5
> =20
> +/* CAN bus errors notifications */
> +#define PCAN_USB_ERR_ECC		0x01
> +#define PCAN_USB_ERR_RXERR		0x02
> +#define PCAN_USB_ERR_TXERR		0x04
> +#define PCAN_USB_ERR_RXERR_CNT		0x08
> +#define PCAN_USB_ERR_TXERR_CNT		0x10
> +
> +/* SJA1000 ECC register */

please add the common PCAN_ prefix (or PCAN_SJA1000_, ...)

> +#define ECC_SEG				0x1f
> +#define ECC_DIR				0x20
> +#define ECC_ERR				6
> +#define ECC_BIT				0x00
> +#define ECC_FORM			0x40
> +#define ECC_STUFF			0x80
> +#define ECC_MASK			0xc0
> +
> +/* SJA1000 Bus Error Interrupt */
> +#define IRQ_BEI				0x80

same here

> +
>  /* private to PCAN-USB adapter */
>  struct pcan_usb {
>  	struct peak_usb_device dev;
>  	struct peak_time_ref time_ref;
>  	struct timer_list restart_timer;
> +	struct can_berr_counter bec;
>  };
> =20
>  /* incoming message context for decoding */
> @@ -193,6 +217,16 @@ static int pcan_usb_set_silent(struct peak_usb_dev=
ice *dev, u8 onoff)
>  	return pcan_usb_send_cmd(dev, 3, 3, args);
>  }
> =20
> +/* send the cmd to be notified from bus errors */
> +static int pcan_usb_set_err_frame(struct peak_usb_device *dev, u8 err_=
mask)
> +{
> +	u8 args[PCAN_USB_CMD_ARGS_LEN] =3D {
> +		[0] =3D err_mask,
> +	};
> +
> +	return pcan_usb_send_cmd(dev, 11, 2, args);

What does 11 and 2 mean? But in the other calls it's not documented eithe=
r.

> +}
> +
>  static int pcan_usb_set_ext_vcc(struct peak_usb_device *dev, u8 onoff)=

>  {
>  	u8 args[PCAN_USB_CMD_ARGS_LEN] =3D {
> @@ -426,7 +460,7 @@ static int pcan_usb_decode_error(struct pcan_usb_ms=
g_context *mc, u8 n,
>  			new_state =3D CAN_STATE_BUS_OFF;
>  			break;
>  		}
> -		if (n & (PCAN_USB_ERROR_RXQOVR | PCAN_USB_ERROR_QOVR)) {
> +		if (n & ~PCAN_USB_ERROR_BUS) {
>  			/*
>  			 * trick to bypass next comparison and process other
>  			 * errors
> @@ -450,7 +484,7 @@ static int pcan_usb_decode_error(struct pcan_usb_ms=
g_context *mc, u8 n,
>  			new_state =3D CAN_STATE_ERROR_WARNING;
>  			break;
>  		}
> -		if (n & (PCAN_USB_ERROR_RXQOVR | PCAN_USB_ERROR_QOVR)) {
> +		if (n & ~PCAN_USB_ERROR_BUS) {
>  			/*
>  			 * trick to bypass next comparison and process other
>  			 * errors
> @@ -489,15 +523,23 @@ static int pcan_usb_decode_error(struct pcan_usb_=
msg_context *mc, u8 n,
> =20
>  	case CAN_STATE_ERROR_PASSIVE:
>  		cf->can_id |=3D CAN_ERR_CRTL;
> -		cf->data[1] |=3D CAN_ERR_CRTL_TX_PASSIVE |
> -			       CAN_ERR_CRTL_RX_PASSIVE;
> +		cf->data[1] =3D (mc->pdev->bec.txerr > mc->pdev->bec.rxerr) ?
> +				CAN_ERR_CRTL_TX_PASSIVE :
> +				CAN_ERR_CRTL_RX_PASSIVE;
> +		cf->data[6] =3D mc->pdev->bec.txerr;
> +		cf->data[7] =3D mc->pdev->bec.rxerr;
> +
>  		mc->pdev->dev.can.can_stats.error_passive++;
>  		break;
> =20
>  	case CAN_STATE_ERROR_WARNING:
>  		cf->can_id |=3D CAN_ERR_CRTL;
> -		cf->data[1] |=3D CAN_ERR_CRTL_TX_WARNING |
> -			       CAN_ERR_CRTL_RX_WARNING;
> +		cf->data[1] =3D (mc->pdev->bec.txerr > mc->pdev->bec.rxerr) ?
> +				CAN_ERR_CRTL_TX_WARNING :
> +				CAN_ERR_CRTL_RX_WARNING;
> +		cf->data[6] =3D mc->pdev->bec.txerr;
> +		cf->data[7] =3D mc->pdev->bec.rxerr;
> +
>  		mc->pdev->dev.can.can_stats.error_warning++;
>  		break;
> =20
> @@ -508,10 +550,19 @@ static int pcan_usb_decode_error(struct pcan_usb_=
msg_context *mc, u8 n,
> =20
>  	default:
>  		/* CAN_STATE_MAX (trick to handle other errors) */
> -		cf->can_id |=3D CAN_ERR_CRTL;
> -		cf->data[1] |=3D CAN_ERR_CRTL_RX_OVERFLOW;
> -		mc->netdev->stats.rx_over_errors++;
> -		mc->netdev->stats.rx_errors++;
> +		if (n & PCAN_USB_ERROR_TXQFULL)
> +			netdev_dbg(mc->netdev, "device Tx queue full)\n");
> +
> +		if (n & PCAN_USB_ERROR_RXQOVR) {
> +			netdev_dbg(mc->netdev, "data overrun interrupt\n");
> +			cf->can_id |=3D CAN_ERR_CRTL;
> +			cf->data[1] |=3D CAN_ERR_CRTL_RX_OVERFLOW;
> +			mc->netdev->stats.rx_over_errors++;
> +			mc->netdev->stats.rx_errors++;
> +		}
> +
> +		cf->data[6] =3D mc->pdev->bec.txerr;
> +		cf->data[7] =3D mc->pdev->bec.rxerr;
> =20
>  		new_state =3D mc->pdev->dev.can.state;
>  		break;
> @@ -533,6 +584,74 @@ static int pcan_usb_decode_error(struct pcan_usb_m=
sg_context *mc, u8 n,
>  	return 0;
>  }
> =20
> +static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8=
 ir,
> +				   u8 status_len)
> +{
> +	struct pcan_usb *pdev =3D mc->pdev;
> +
> +	/* process bus error interrupt */
> +	if (ir & IRQ_BEI) {
> +		struct net_device_stats *stats =3D &mc->netdev->stats;
> +		struct sk_buff *skb;
> +		struct can_frame *cf;
> +		u8 ecc =3D mc->ptr[0];
> +
> +		/* save rx/tx error counters from data bytes */
> +		pdev->bec.rxerr =3D mc->ptr[1];
> +		pdev->bec.txerr =3D mc->ptr[2];
> +
> +		/* allocate an skb to store the error frame */
> +		skb =3D alloc_can_err_skb(mc->netdev, &cf);
> +		if (!skb)
> +			return -ENOMEM;
> +
> +		cf->data[6] =3D pdev->bec.txerr;
> +		cf->data[7] =3D pdev->bec.rxerr;
> +
> +		/* The PCAN-USB is equipped with a SJA1000, thus copy from
> +		 * sja1000.c how to handle the BEI:
> +		 */
> +		pdev->dev.can.can_stats.bus_error++;
> +		stats->rx_errors++;
> +
> +		cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +
> +		/* set error type according to 1st data byte (ECC) */
> +		switch (ecc & ECC_MASK) {
> +		case ECC_BIT:
> +			cf->data[2] |=3D CAN_ERR_PROT_BIT;
> +			break;
> +		case ECC_FORM:
> +			cf->data[2] |=3D CAN_ERR_PROT_FORM;
> +			break;
> +		case ECC_STUFF:
> +			cf->data[2] |=3D CAN_ERR_PROT_STUFF;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		/* set error location */
> +		cf->data[3] =3D ecc & ECC_SEG;
> +
> +		/* Error occurred during transmission? */
> +		if ((ecc & ECC_DIR) =3D=3D 0)
> +			cf->data[2] |=3D CAN_ERR_PROT_TX;
> +		if (status_len & PCAN_USB_STATUSLEN_TIMESTAMP) {
> +			struct skb_shared_hwtstamps *hwts =3D skb_hwtstamps(skb);
> +
> +			peak_usb_get_ts_time(&mc->pdev->time_ref, mc->ts16,
> +					     &hwts->hwtstamp);
> +		}
> +
> +		stats->rx_packets++;
> +		stats->rx_bytes +=3D cf->can_dlc;
> +		netif_rx(skb);
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * decode non-data usb message
>   */
> @@ -587,9 +706,9 @@ static int pcan_usb_decode_status(struct pcan_usb_m=
sg_context *mc,
>  		break;
> =20
>  	case PCAN_USB_REC_BUSEVT:
> -		/* error frame/bus event */
> -		if (n & PCAN_USB_ERROR_TXQFULL)
> -			netdev_dbg(mc->netdev, "device Tx queue full)\n");
> +		err =3D pcan_usb_handle_bus_evt(mc, n, status_len);
> +		if (err)
> +			return err;
>  		break;
>  	default:
>  		netdev_err(mc->netdev, "unexpected function %u\n", f);
> @@ -773,20 +892,45 @@ static int pcan_usb_encode_msg(struct peak_usb_de=
vice *dev, struct sk_buff *skb,
>  	return 0;
>  }
> =20
> +/* socket callback used to copy berr counters values receieved through=
 USB */
> +static int pcan_usb_get_berr_counter(const struct net_device *netdev,
> +				     struct can_berr_counter *bec)
> +{
> +	struct peak_usb_device *dev =3D netdev_priv(netdev);
> +	struct pcan_usb *pdev =3D container_of(dev, struct pcan_usb, dev);
> +
> +	*bec =3D pdev->bec;
> +
> +	/* must return 0 */
> +	return 0;
> +}
> +
>  /*
>   * start interface
>   */
>  static int pcan_usb_start(struct peak_usb_device *dev)
>  {
>  	struct pcan_usb *pdev =3D container_of(dev, struct pcan_usb, dev);
> +	int err;
> =20
>  	/* number of bits used in timestamps read from adapter struct */
>  	peak_usb_init_time_ref(&pdev->time_ref, &pcan_usb);
> =20
> +	pdev->bec.rxerr =3D 0;
> +	pdev->bec.txerr =3D 0;
> +
> +	/* be notified on any error counter change */

Does the device offer the possibility to read the error counters? If so
please do it in pcan_usb_get_berr_counter().

> +	err =3D pcan_usb_set_err_frame(dev, PCAN_USB_ERR_ECC |
> +				     PCAN_USB_ERR_RXERR | PCAN_USB_ERR_TXERR |
> +				     PCAN_USB_ERR_RXERR_CNT |
> +				     PCAN_USB_ERR_TXERR_CNT);

Better only enable bus errors, if the user has requested them. See:


https://elixir.bootlin.com/linux/latest/source/drivers/net/can/sja1000/sj=
a1000.c#L152

> +	if (err)
> +		netdev_warn(dev->netdev,
> +			    "CAN bus error counters not available (err %u)\n",
> +			    err);
> +
>  	/* if revision greater than 3, can put silent mode on/off */
>  	if (dev->device_rev > 3) {
> -		int err;
> -
>  		err =3D pcan_usb_set_silent(dev,
>  				dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY);
>  		if (err)
> @@ -906,4 +1050,5 @@ const struct peak_usb_adapter pcan_usb =3D {
>  	.dev_encode_msg =3D pcan_usb_encode_msg,
>  	.dev_start =3D pcan_usb_start,
>  	.dev_restart_async =3D pcan_usb_restart_async,
> +	.do_get_berr_counter =3D pcan_usb_get_berr_counter,
>  };
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--yEj4zppjot6huXNl5cNP5d2ICjYxnMNxX--

--zrompV2ld2shdBxJ0XnXA4629XQkgy4l7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2cZv0ACgkQWsYho5Hk
nSCi6wf9HkgrT/9uVDLjgoekT2zozlHuaLp2tUWY4oe8nMjrLgSqeU5qlaQZbFjn
DOsAdubgvwjF0u+H4ZAQlP2dtCfShvzo3Yu5ZFbU5HgicUg7OSEUIsm1oVomtXRc
i1KKc7fR6RckQ/dGRjK0VJ7k/CZPBYfrg0RnXdnXBgqSVjIL8qUPjHdJedN3aYNr
MTtXBUg7z634Kt5juHt61yeiHAmGLbttzO8dhQedEQCo81nzsjlSB370YZ5gnRXm
auNkVyuhbtS5lrNnyDxKW6h0gzyx5oQNnIpu3okOYyRk3j8+nmpLIRhVCC9XZ4iO
o6nJkc6Xy69H8M0Gborqo7E0ZRWVFA==
=y4Ow
-----END PGP SIGNATURE-----

--zrompV2ld2shdBxJ0XnXA4629XQkgy4l7--
