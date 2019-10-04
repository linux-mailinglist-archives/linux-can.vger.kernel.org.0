Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11762CC441
	for <lists+linux-can@lfdr.de>; Fri,  4 Oct 2019 22:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbfJDUdq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Oct 2019 16:33:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52965 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731273AbfJDUdq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Oct 2019 16:33:46 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iGUGm-0003bM-DD; Fri, 04 Oct 2019 22:33:44 +0200
Received: from [IPv6:2a03:f580:87bc:d400:44c4:7f7f:9bfe:66b5] (unknown [IPv6:2a03:f580:87bc:d400:44c4:7f7f:9bfe:66b5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B3C8E46043E;
        Fri,  4 Oct 2019 20:33:42 +0000 (UTC)
Subject: Re: [PATCH] can: xilinx_can: avoid non-requested bus error frames
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-can@vger.kernel.org,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
References: <20191004090256.13931-1-anssi.hannula@bitwise.fi>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8ce13d5e-32b7-cfb3-8f50-b9f79e1b32a8@pengutronix.de>
Date:   Fri, 4 Oct 2019 22:33:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191004090256.13931-1-anssi.hannula@bitwise.fi>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hLDYgJr0GDEkMlqdi7URFWXb60dIwXRzc"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hLDYgJr0GDEkMlqdi7URFWXb60dIwXRzc
Content-Type: multipart/mixed; boundary="Lu0Xc1OQUGjvpSL6ho9bqIf27vZAhb6yo";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-can@vger.kernel.org,
 Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Message-ID: <8ce13d5e-32b7-cfb3-8f50-b9f79e1b32a8@pengutronix.de>
Subject: Re: [PATCH] can: xilinx_can: avoid non-requested bus error frames
References: <20191004090256.13931-1-anssi.hannula@bitwise.fi>
In-Reply-To: <20191004090256.13931-1-anssi.hannula@bitwise.fi>

--Lu0Xc1OQUGjvpSL6ho9bqIf27vZAhb6yo
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/4/19 11:02 AM, Anssi Hannula wrote:
> Userspace can signal with CAN_CTRLMODE_BERR_REPORTING whether they need=

> reporting of bus errors (CAN_ERR_BUSERROR) or not.
>=20
> However, xilinx_can driver currently always sends CAN_ERR_BUSERROR
> frames to userspace on bus errors.
>=20
> To improve performance on error conditions when bus error reporting is
> not needed, avoid sending CAN_ERR_BUSERROR frames unless requested via
> CAN_CTRLMODE_BERR_REPORTING.
>=20
> The error interrupt is still kept enabled as there is no dedicated stat=
e
> transition interrupt, but just disabling error frame submission still
> yields a significant performance improvement. In a simple test with
> continuous bus errors and no userspace programs reading/writing CAN I
> saw system CPU load reduced by 1/3.
>=20
> Tested on a ZynqMP board with CAN-FD v1.0.
>=20
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> ---
>  drivers/net/can/xilinx_can.c | 84 +++++++++++++++++++-----------------=

>  1 file changed, 45 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.=
c
> index 911b34316c9d..9b9ec07f7e5b 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -471,6 +471,10 @@ static int xcan_chip_start(struct net_device *ndev=
)
>  		return err;
> =20
>  	/* Enable interrupts */
> +	/* We enable the ERROR interrupt even with CAN_CTRLMODE_BERR_REPORTIN=
G
> +	 * disabled as there is no dedicated interrupt for a state change to
> +	 * ERROR_WARNING/ERROR_PASSIVE.
> +	 */
>  	ier =3D XCAN_IXR_TXOK_MASK | XCAN_IXR_BSOFF_MASK |
>  		XCAN_IXR_WKUP_MASK | XCAN_IXR_SLP_MASK |
>  		XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
> @@ -981,11 +985,10 @@ static void xcan_err_interrupt(struct net_device =
*ndev, u32 isr)
>  {
>  	struct xcan_priv *priv =3D netdev_priv(ndev);
>  	struct net_device_stats *stats =3D &ndev->stats;
> -	struct can_frame *cf;
> -	struct sk_buff *skb;
> +	struct can_frame cf;
>  	u32 err_status;
> =20
> -	skb =3D alloc_can_err_skb(ndev, &cf);
> +	memset(&cf, 0, sizeof(cf));

You can use C99 initializers instead of the memset.

> =20
>  	err_status =3D priv->read_reg(priv, XCAN_ESR_OFFSET);
>  	priv->write_reg(priv, XCAN_ESR_OFFSET, err_status);
> @@ -996,32 +999,27 @@ static void xcan_err_interrupt(struct net_device =
*ndev, u32 isr)
>  		/* Leave device in Config Mode in bus-off state */
>  		priv->write_reg(priv, XCAN_SRR_OFFSET, XCAN_SRR_RESET_MASK);
>  		can_bus_off(ndev);
> -		if (skb)
> -			cf->can_id |=3D CAN_ERR_BUSOFF;
> +		cf.can_id |=3D CAN_ERR_BUSOFF;
>  	} else {
>  		enum can_state new_state =3D xcan_current_error_state(ndev);
> =20
>  		if (new_state !=3D priv->can.state)
> -			xcan_set_error_state(ndev, new_state, skb ? cf : NULL);
> +			xcan_set_error_state(ndev, new_state, &cf);
>  	}
> =20
>  	/* Check for Arbitration lost interrupt */
>  	if (isr & XCAN_IXR_ARBLST_MASK) {
>  		priv->can.can_stats.arbitration_lost++;
> -		if (skb) {
> -			cf->can_id |=3D CAN_ERR_LOSTARB;
> -			cf->data[0] =3D CAN_ERR_LOSTARB_UNSPEC;
> -		}
> +		cf.can_id |=3D CAN_ERR_LOSTARB;
> +		cf.data[0] =3D CAN_ERR_LOSTARB_UNSPEC;
>  	}
> =20
>  	/* Check for RX FIFO Overflow interrupt */
>  	if (isr & XCAN_IXR_RXOFLW_MASK) {
>  		stats->rx_over_errors++;
>  		stats->rx_errors++;
> -		if (skb) {
> -			cf->can_id |=3D CAN_ERR_CRTL;
> -			cf->data[1] |=3D CAN_ERR_CRTL_RX_OVERFLOW;
> -		}
> +		cf.can_id |=3D CAN_ERR_CRTL;
> +		cf.data[1] |=3D CAN_ERR_CRTL_RX_OVERFLOW;
>  	}
> =20
>  	/* Check for RX Match Not Finished interrupt */
> @@ -1029,68 +1027,76 @@ static void xcan_err_interrupt(struct net_devic=
e *ndev, u32 isr)
>  		stats->rx_dropped++;
>  		stats->rx_errors++;
>  		netdev_err(ndev, "RX match not finished, frame discarded\n");
> -		if (skb) {
> -			cf->can_id |=3D CAN_ERR_CRTL;
> -			cf->data[1] |=3D CAN_ERR_CRTL_UNSPEC;
> -		}
> +		cf.can_id |=3D CAN_ERR_CRTL;
> +		cf.data[1] |=3D CAN_ERR_CRTL_UNSPEC;
>  	}
> =20
>  	/* Check for error interrupt */
>  	if (isr & XCAN_IXR_ERROR_MASK) {
> -		if (skb)
> -			cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +		bool berr_reporting =3D !!(priv->can.ctrlmode &
> +					 CAN_CTRLMODE_BERR_REPORTING);

Please use if() instead of !!

> +
> +		if (berr_reporting)
> +			cf.can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
> =20
>  		/* Check for Ack error interrupt */
>  		if (err_status & XCAN_ESR_ACKER_MASK) {
>  			stats->tx_errors++;
> -			if (skb) {
> -				cf->can_id |=3D CAN_ERR_ACK;
> -				cf->data[3] =3D CAN_ERR_PROT_LOC_ACK;
> +			if (berr_reporting) {
> +				cf.can_id |=3D CAN_ERR_ACK;
> +				cf.data[3] =3D CAN_ERR_PROT_LOC_ACK;
>  			}
>  		}
> =20
>  		/* Check for Bit error interrupt */
>  		if (err_status & XCAN_ESR_BERR_MASK) {
>  			stats->tx_errors++;
> -			if (skb) {
> -				cf->can_id |=3D CAN_ERR_PROT;
> -				cf->data[2] =3D CAN_ERR_PROT_BIT;
> +			if (berr_reporting) {
> +				cf.can_id |=3D CAN_ERR_PROT;
> +				cf.data[2] =3D CAN_ERR_PROT_BIT;
>  			}
>  		}
> =20
>  		/* Check for Stuff error interrupt */
>  		if (err_status & XCAN_ESR_STER_MASK) {
>  			stats->rx_errors++;
> -			if (skb) {
> -				cf->can_id |=3D CAN_ERR_PROT;
> -				cf->data[2] =3D CAN_ERR_PROT_STUFF;
> +			if (berr_reporting) {
> +				cf.can_id |=3D CAN_ERR_PROT;
> +				cf.data[2] =3D CAN_ERR_PROT_STUFF;
>  			}
>  		}
> =20
>  		/* Check for Form error interrupt */
>  		if (err_status & XCAN_ESR_FMER_MASK) {
>  			stats->rx_errors++;
> -			if (skb) {
> -				cf->can_id |=3D CAN_ERR_PROT;
> -				cf->data[2] =3D CAN_ERR_PROT_FORM;
> +			if (berr_reporting) {
> +				cf.can_id |=3D CAN_ERR_PROT;
> +				cf.data[2] =3D CAN_ERR_PROT_FORM;
>  			}
>  		}
> =20
>  		/* Check for CRC error interrupt */
>  		if (err_status & XCAN_ESR_CRCER_MASK) {
>  			stats->rx_errors++;
> -			if (skb) {
> -				cf->can_id |=3D CAN_ERR_PROT;
> -				cf->data[3] =3D CAN_ERR_PROT_LOC_CRC_SEQ;
> +			if (berr_reporting) {
> +				cf.can_id |=3D CAN_ERR_PROT;
> +				cf.data[3] =3D CAN_ERR_PROT_LOC_CRC_SEQ;
>  			}
>  		}
>  		priv->can.can_stats.bus_error++;
>  	}
> =20
> -	if (skb) {
> -		stats->rx_packets++;
> -		stats->rx_bytes +=3D cf->can_dlc;
> -		netif_rx(skb);
> +	if (cf.can_id) {
> +		struct can_frame *skb_cf;
> +		struct sk_buff *skb =3D alloc_can_err_skb(ndev, &skb_cf);
> +
> +		if (skb) {
> +			skb_cf->can_id |=3D cf.can_id;
> +			memcpy(skb_cf->data, cf.data, CAN_ERR_DLC);
> +			stats->rx_packets++;
> +			stats->rx_bytes +=3D CAN_ERR_DLC;
> +			netif_rx(skb);
> +		}
>  	}
> =20
>  	netdev_dbg(ndev, "%s: error status register:0x%x\n",

I've send a v2 which incorporates these changes.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Lu0Xc1OQUGjvpSL6ho9bqIf27vZAhb6yo--

--hLDYgJr0GDEkMlqdi7URFWXb60dIwXRzc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2XrKEACgkQWsYho5Hk
nSDRmAgAoizkIlv4bcZuHXKDeG5Ac9xl0R3yq79JPpCNFY+tlX/K4MJDFqu3Vp2J
t2zeVcGewS/JrIgho8ZhTmTjdnwnz6lBnVELroqB1O2CsRzzm4RxGbjjA3uBdluK
dJLHpeZoJAgvYxQ87cnZlk785vuFk8p5DsbwXGSMElcHBssPlDWmcpY9bSjJqfjd
+kHYxXIDQwVTOpWaB4ZGY2hzb+56m+I9Jziq6oH7bZ5FIm3/HBxAvaPTQpPPMXdb
hcwMZ/YTC9CKo0y//4/XfvAdKQCGeGX3WU1FEMV2g9zgjPX2yCTwyHYSNiQHeB7V
IzJWUqfCc5RChlh3AvV9eCy4bOf6Zw==
=0TuP
-----END PGP SIGNATURE-----

--hLDYgJr0GDEkMlqdi7URFWXb60dIwXRzc--
