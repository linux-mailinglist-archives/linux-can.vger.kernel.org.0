Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAD83C921F
	for <lists+linux-can@lfdr.de>; Wed, 14 Jul 2021 22:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGNUfB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 14 Jul 2021 16:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhGNUfA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Jul 2021 16:35:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E302C06175F
        for <linux-can@vger.kernel.org>; Wed, 14 Jul 2021 13:32:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m3lY7-0006gb-3z; Wed, 14 Jul 2021 22:32:07 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1d5a:f852:d9c2:1ad3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id F117F64F623;
        Wed, 14 Jul 2021 20:32:05 +0000 (UTC)
Date:   Wed, 14 Jul 2021 22:32:05 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] can: peak_usb: upgrades the handling of bus state
 changes
Message-ID: <20210714203205.kxgbopb2kkgujadu@pengutronix.de>
References: <20210628142043.15034-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uhbwwlkosdf6s4oi"
Content-Disposition: inline
In-Reply-To: <20210628142043.15034-1-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--uhbwwlkosdf6s4oi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.06.2021 16:20:42, Stephane Grosjean wrote:
> This patch updates old code by using the functions published since by the
> socket-can module. In particular, this new code better manages the change
> of bus state by also using the value of the error counters that the driver
> now systematically asks for when initializing the channel.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
> v2:
>  - do the statistics and state update, even if the allocation of the skb
>    fails.

BTW: please send the whole series with the same "v$NUMBER" as the b4
tool wants to have v2 on all patches of the series.

>=20
>  drivers/net/can/usb/peak_usb/pcan_usb.c | 161 ++++++------------------
>  1 file changed, 38 insertions(+), 123 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/us=
b/peak_usb/pcan_usb.c
> index 7d18bc6911f5..4c3e18ca3181 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -453,146 +453,61 @@ static int pcan_usb_decode_error(struct pcan_usb_m=
sg_context *mc, u8 n,
>  {
>  	struct sk_buff *skb;
>  	struct can_frame *cf;
> -	enum can_state new_state;
> +	enum can_state new_state =3D CAN_STATE_ERROR_ACTIVE;
> =20
>  	/* ignore this error until 1st ts received */
>  	if (n =3D=3D PCAN_USB_ERROR_QOVR)
>  		if (!mc->pdev->time_ref.tick_count)
>  			return 0;
> =20
> -	new_state =3D mc->pdev->dev.can.state;
> -
> -	switch (mc->pdev->dev.can.state) {
> -	case CAN_STATE_ERROR_ACTIVE:
> -		if (n & PCAN_USB_ERROR_BUS_LIGHT) {
> -			new_state =3D CAN_STATE_ERROR_WARNING;
> -			break;
> -		}
> -		fallthrough;
> -
> -	case CAN_STATE_ERROR_WARNING:
> -		if (n & PCAN_USB_ERROR_BUS_HEAVY) {
> -			new_state =3D CAN_STATE_ERROR_PASSIVE;
> -			break;
> -		}
> -		if (n & PCAN_USB_ERROR_BUS_OFF) {
> -			new_state =3D CAN_STATE_BUS_OFF;
> -			break;
> -		}
> -		if (n & ~PCAN_USB_ERROR_BUS) {
> -			/*
> -			 * trick to bypass next comparison and process other
> -			 * errors
> -			 */
> -			new_state =3D CAN_STATE_MAX;
> -			break;
> -		}
> -		if ((n & PCAN_USB_ERROR_BUS_LIGHT) =3D=3D 0) {
> -			/* no error (back to active state) */
> -			new_state =3D CAN_STATE_ERROR_ACTIVE;
> -			break;
> -		}
> -		break;
> -
> -	case CAN_STATE_ERROR_PASSIVE:
> -		if (n & PCAN_USB_ERROR_BUS_OFF) {
> -			new_state =3D CAN_STATE_BUS_OFF;
> -			break;
> -		}
> -		if (n & PCAN_USB_ERROR_BUS_LIGHT) {
> -			new_state =3D CAN_STATE_ERROR_WARNING;
> -			break;
> -		}
> -		if (n & ~PCAN_USB_ERROR_BUS) {
> -			/*
> -			 * trick to bypass next comparison and process other
> -			 * errors
> -			 */
> -			new_state =3D CAN_STATE_MAX;
> -			break;
> -		}
> -
> -		if ((n & PCAN_USB_ERROR_BUS_HEAVY) =3D=3D 0) {
> -			/* no error (back to warning state) */
> -			new_state =3D CAN_STATE_ERROR_WARNING;
> -			break;
> -		}
> -		break;
> -
> -	default:
> -		/* do nothing waiting for restart */
> -		return 0;
> -	}
> -
> -	/* donot post any error if current state didn't change */
> -	if (mc->pdev->dev.can.state =3D=3D new_state)
> -		return 0;
> -
>  	/* allocate an skb to store the error frame */
>  	skb =3D alloc_can_err_skb(mc->netdev, &cf);
> -	if (!skb)
> -		return -ENOMEM;
> -
> -	switch (new_state) {
> -	case CAN_STATE_BUS_OFF:
> -		cf->can_id |=3D CAN_ERR_BUSOFF;
> -		mc->pdev->dev.can.can_stats.bus_off++;
> -		can_bus_off(mc->netdev);
> -		break;
> -
> -	case CAN_STATE_ERROR_PASSIVE:
> -		cf->can_id |=3D CAN_ERR_CRTL;
> -		cf->data[1] =3D (mc->pdev->bec.txerr > mc->pdev->bec.rxerr) ?
> -				CAN_ERR_CRTL_TX_PASSIVE :
> -				CAN_ERR_CRTL_RX_PASSIVE;
> -		cf->data[6] =3D mc->pdev->bec.txerr;
> -		cf->data[7] =3D mc->pdev->bec.rxerr;

The TX and RX error counters are not supplied anymore, was this intentional?

> -
> -		mc->pdev->dev.can.can_stats.error_passive++;
> -		break;
> -
> -	case CAN_STATE_ERROR_WARNING:
> -		cf->can_id |=3D CAN_ERR_CRTL;
> -		cf->data[1] =3D (mc->pdev->bec.txerr > mc->pdev->bec.rxerr) ?
> -				CAN_ERR_CRTL_TX_WARNING :
> -				CAN_ERR_CRTL_RX_WARNING;
> -		cf->data[6] =3D mc->pdev->bec.txerr;
> -		cf->data[7] =3D mc->pdev->bec.rxerr;
> -
> -		mc->pdev->dev.can.can_stats.error_warning++;
> -		break;
> =20
> -	case CAN_STATE_ERROR_ACTIVE:
> -		cf->can_id |=3D CAN_ERR_CRTL;
> -		cf->data[1] =3D CAN_ERR_CRTL_ACTIVE;
> -
> -		/* sync local copies of rxerr/txerr counters */
> -		mc->pdev->bec.txerr =3D 0;
> -		mc->pdev->bec.rxerr =3D 0;
> -		break;
> -
> -	default:
> -		/* CAN_STATE_MAX (trick to handle other errors) */
> -		if (n & PCAN_USB_ERROR_TXQFULL)
> -			netdev_dbg(mc->netdev, "device Tx queue full)\n");
> -
> -		if (n & PCAN_USB_ERROR_RXQOVR) {
> -			netdev_dbg(mc->netdev, "data overrun interrupt\n");
> +	if (n & PCAN_USB_ERROR_RXQOVR) {
> +		/* data overrun interrupt */
> +		netdev_dbg(mc->netdev, "data overrun interrupt\n");
> +		mc->netdev->stats.rx_over_errors++;
> +		mc->netdev->stats.rx_errors++;
> +		if (skb) {
>  			cf->can_id |=3D CAN_ERR_CRTL;
>  			cf->data[1] |=3D CAN_ERR_CRTL_RX_OVERFLOW;
> -			mc->netdev->stats.rx_over_errors++;
> -			mc->netdev->stats.rx_errors++;
>  		}
> +	}
> =20
> -		cf->data[6] =3D mc->pdev->bec.txerr;
> -		cf->data[7] =3D mc->pdev->bec.rxerr;
> +	if (n & PCAN_USB_ERROR_TXQFULL)
> +		netdev_dbg(mc->netdev, "device Tx queue full)\n");
> =20
> -		new_state =3D mc->pdev->dev.can.state;
> -		break;
> +	if (n & PCAN_USB_ERROR_BUS_OFF) {
> +		new_state =3D CAN_STATE_BUS_OFF;
> +	} else if (n & PCAN_USB_ERROR_BUS_HEAVY) {
> +		new_state =3D ((mc->pdev->bec.txerr >=3D 128) ||
> +			     (mc->pdev->bec.rxerr >=3D 128)) ?
> +				CAN_STATE_ERROR_PASSIVE :
> +				CAN_STATE_ERROR_WARNING;
> +	} else {
> +		new_state =3D CAN_STATE_ERROR_ACTIVE;
>  	}
> =20
> -	mc->pdev->dev.can.state =3D new_state;
> +	/* handle change of state */
> +	if (new_state !=3D mc->pdev->dev.can.state) {
> +		if (skb) {
> +			enum can_state tx_state =3D
> +				(mc->pdev->bec.txerr >=3D mc->pdev->bec.rxerr) ?
> +					new_state : 0;
> +			enum can_state rx_state =3D
> +				(mc->pdev->bec.txerr <=3D mc->pdev->bec.rxerr) ?
> +					new_state : 0;
> +
> +			can_change_state(mc->netdev, cf, tx_state, rx_state);

You have to call can_change_state() even if cf is NULL, because it does
the change state and can handle cf =3D=3D NULL.

> +		}
> +
> +		/* things must be done even in case of OOM */
> +		if (new_state =3D=3D CAN_STATE_BUS_OFF)
> +			can_bus_off(mc->netdev);
> +	}
> =20
> +	if (!skb)
> +		return -ENOMEM;
>  	if (status_len & PCAN_USB_STATUSLEN_TIMESTAMP) {
>  		struct skb_shared_hwtstamps *hwts =3D skb_hwtstamps(skb);

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--uhbwwlkosdf6s4oi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDvScIACgkQqclaivrt
76msTwf+PrW/vfWWETxg5g32h7rts6Xdql2vePPH2IFo2LLkTzZANzfVpAqK4F9/
sv0RPJTCSFVs8OzHElRtfDVWxIyrF3gIFeAG8uCE4+VT1uCHe1HHgEufyzkBkfbg
1mC+KXgmSRFeFmHy+WNNsKtndeelSpLA1fXpTsKfE9pChU3HM1QuS8Gt+cYZ9Ij0
Eoq8ZEvGJnSWiV62LZoZsd7QiIO/uWnOHUCDavv67gXIazk1f5UH7LQU83G+tN7V
zXMNXQ0B12CJatELzvCKWEGtURB2gVSf4GacUcrB8mDZrvJlNTDqfi9OgujAM9Kl
DrDHR9Cu88/bh3UJOqKdeOvSg7oRMw==
=twYQ
-----END PGP SIGNATURE-----

--uhbwwlkosdf6s4oi--
