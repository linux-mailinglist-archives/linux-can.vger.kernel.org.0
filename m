Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0D12A9B5C
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 19:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgKFSBO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 13:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgKFSBO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 13:01:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA80C0613CF
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 10:01:14 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kb62y-0008GY-4m; Fri, 06 Nov 2020 19:01:12 +0100
Received: from [IPv6:2a03:f580:87bc:d400:33f0:799f:c05f:fe06] (unknown [IPv6:2a03:f580:87bc:d400:33f0:799f:c05f:fe06])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2885558C6C5;
        Fri,  6 Nov 2020 18:01:11 +0000 (UTC)
To:     Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        linux-can@vger.kernel.org
Cc:     wg@grandegger.com
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
 <20201106170206.32162-14-uttenthaler@ems-wuensche.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 13/17] can: ems_usb: Rearrange code in ems_usb_start_xmit
 to check with can_is_canfd_skb for CAN FD frames.
Message-ID: <29cd1b51-395d-4768-e01d-989d20fb0f3c@pengutronix.de>
Date:   Fri, 6 Nov 2020 19:01:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106170206.32162-14-uttenthaler@ems-wuensche.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PcJucMxfvz4yWHhNCBeCuPMH6DOMSZaWV"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PcJucMxfvz4yWHhNCBeCuPMH6DOMSZaWV
Content-Type: multipart/mixed; boundary="RsCQObcFn3NTlx2nR5tBaKbO6WS68AIvs";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
 linux-can@vger.kernel.org
Cc: wg@grandegger.com
Message-ID: <29cd1b51-395d-4768-e01d-989d20fb0f3c@pengutronix.de>
Subject: Re: [PATCH 13/17] can: ems_usb: Rearrange code in ems_usb_start_xmit
 to check with can_is_canfd_skb for CAN FD frames.
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
 <20201106170206.32162-14-uttenthaler@ems-wuensche.com>
In-Reply-To: <20201106170206.32162-14-uttenthaler@ems-wuensche.com>

--RsCQObcFn3NTlx2nR5tBaKbO6WS68AIvs
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/6/20 6:02 PM, Gerhard Uttenthaler wrote:
> Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
> ---
>  drivers/net/can/usb/ems_usb.c | 87 +++++++++++++++++++----------------=

>  1 file changed, 47 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_us=
b.c
> index c464d644c833..c3159ffaa4fa 100644
> --- a/drivers/net/can/usb/ems_usb.c
> +++ b/drivers/net/can/usb/ems_usb.c
> @@ -899,64 +899,71 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_b=
uff *skb, struct net_device *ne
>  	struct ems_usb *dev =3D netdev_priv(netdev);
>  	struct ems_tx_urb_context *context =3D NULL;
>  	struct net_device_stats *stats =3D &netdev->stats;
> -	struct can_frame *cf =3D (struct can_frame *)skb->data;
>  	struct ems_cpc_msg *msg;
>  	struct urb *urb;
>  	int i, err;
> +	u8 dlc;
> =20
>  	u8 *buf;
>  	size_t buf_size;
>  	size_t buf_len =3D CPC_HEADER_SIZE + CPC_MSG_HEADER_LEN;
> =20
> -	if (can_dropped_invalid_skb(netdev, skb))

why move this into the if? it's common code with fd and non fd

> +	if (can_is_canfd_skb(skb)) {
> +		// Placeholder for next patch

no placeholders please

>  		return NETDEV_TX_OK;
> +	} else {
> +		struct can_frame *cf =3D (struct can_frame *)skb->data;
> =20
> -	buf_size =3D CPC_HEADER_SIZE +
> -		   CPC_MSG_HEADER_LEN +
> -		   sizeof(struct cpc_can_msg);
> +		if (can_dropped_invalid_skb(netdev, skb))
> +			return NETDEV_TX_OK;
> =20
> -	/* Create an URB, and a buffer for it
> -	 * and copy the data to the URB
> -	 */
> -	urb =3D usb_alloc_urb(0, GFP_ATOMIC);
> -	if (!urb)
> -		goto nomem;
> -
> -	buf =3D usb_alloc_coherent(dev->udev,
> -				 buf_size,
> -				 GFP_ATOMIC,
> -				 &urb->transfer_dma);
> -	if (!buf) {
> -		netdev_err(netdev, "No memory left for USB buffer\n");
> -		usb_free_urb(urb);
> -		goto nomem;
> -	}
> -	// Clear first 4 bytes
> -	*(u32 *)buf =3D 0;
> +		buf_size =3D CPC_HEADER_SIZE +
> +			   CPC_MSG_HEADER_LEN +
> +			   sizeof(struct cpc_can_msg);
> =20
> -	msg =3D (struct ems_cpc_msg *)&buf[CPC_HEADER_SIZE];
> +		/* Create an URB, and a buffer for it
> +		 * and copy the data to the URB
> +		 */
> +		urb =3D usb_alloc_urb(0, GFP_ATOMIC);
> +		if (!urb)
> +			goto nomem;
> +
> +		buf =3D usb_alloc_coherent(dev->udev,
> +					 buf_size,
> +					 GFP_ATOMIC,
> +					 &urb->transfer_dma);
> +		if (!buf) {
> +			netdev_err(netdev, "No memory left for USB buffer\n");
> +			usb_free_urb(urb);
> +			goto nomem;
> +		}
> +		// Clear first 4 bytes
> +		*(u32 *)buf =3D 0;
> =20
> -	msg->msg.can_msg.id =3D cpu_to_le32(cf->can_id & CAN_ERR_MASK);
> -	msg->msg.can_msg.length =3D cf->can_dlc;
> +		msg =3D (struct ems_cpc_msg *)&buf[CPC_HEADER_SIZE];
> =20
> -	if (cf->can_id & CAN_RTR_FLAG) {
> -		msg->type =3D cf->can_id & CAN_EFF_FLAG ?
> -			CPC_CMD_TYPE_EXT_RTR_FRAME : CPC_CMD_TYPE_RTR_FRAME;
> +		msg->msg.can_msg.id =3D cpu_to_le32(cf->can_id & CAN_ERR_MASK);
> +		dlc =3D cf->can_dlc;
> +		msg->msg.can_msg.length =3D dlc;
> =20
> -		msg->length =3D CPC_CAN_MSG_MIN_SIZE;
> -	} else {
> -		msg->type =3D cf->can_id & CAN_EFF_FLAG ?
> -			CPC_CMD_TYPE_EXT_CAN_FRAME : CPC_CMD_TYPE_CAN_FRAME;
> +		if (cf->can_id & CAN_RTR_FLAG) {
> +			msg->type =3D cf->can_id & CAN_EFF_FLAG ?
> +				CPC_CMD_TYPE_EXT_RTR_FRAME : CPC_CMD_TYPE_RTR_FRAME;
> =20
> -		for (i =3D 0; i < cf->can_dlc; i++)
> -			msg->msg.can_msg.msg[i] =3D cf->data[i];
> +			msg->length =3D CPC_CAN_MSG_MIN_SIZE;
> +		} else {
> +			msg->type =3D cf->can_id & CAN_EFF_FLAG ?
> +				CPC_CMD_TYPE_EXT_CAN_FRAME : CPC_CMD_TYPE_CAN_FRAME;
> =20
> -		msg->length =3D CPC_CAN_MSG_MIN_SIZE + cf->can_dlc;
> -	}
> +			for (i =3D 0; i < cf->can_dlc; i++)
> +				msg->msg.can_msg.msg[i] =3D cf->data[i];
> =20
> -	// Send only significant bytes of buffer
> -	buf_len +=3D msg->length;
> +			msg->length =3D CPC_CAN_MSG_MIN_SIZE + cf->can_dlc;
> +		}
> =20
> +		// Send only significant bytes of buffer
> +		buf_len +=3D msg->length;
> +	}
>  	for (i =3D 0; i < MAX_TX_URBS; i++) {
>  		if (dev->tx_contexts[i].echo_index =3D=3D MAX_TX_URBS) {
>  			context =3D &dev->tx_contexts[i];
> @@ -978,7 +985,7 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buf=
f *skb, struct net_device *ne
> =20
>  	context->dev =3D dev;
>  	context->echo_index =3D i;
> -	context->dlc =3D cf->can_dlc;
> +	context->dlc =3D dlc;
> =20
>  	usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 2), buf,=

>  			  buf_len, ems_usb_write_bulk_callback, context);
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--RsCQObcFn3NTlx2nR5tBaKbO6WS68AIvs--

--PcJucMxfvz4yWHhNCBeCuPMH6DOMSZaWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+lj2IACgkQqclaivrt
76lnfwgAoNrP4xUeIetTX2aCylYC5iwIrWI7udVpBMxoVWdH7cukjThpWD7LzeB5
MxT72DpkmzoasoqjA2UbJvoJgNDR19VH5A6sFYyvpdfExcIFTJBJOv4EakJ/4ve7
IhHp0NrZO0S/2Ya38GndKS/V/T8/8At/Xxfqs5VYWp1L7gi8yHcwVkB2Aizabl8o
AVKuKm24nj+0CYrPi2auEb4p3p1QRPK3w9eyn+B0D3j3BN9lAj52rwTSF/bmOc2g
oKlbqq01hgXXla7AfPvksmr3A043GjKJ5+O3ZKJT+tIcGDw5f7TbFHeiMxUqkxZ7
TZjIms4+HEnOPfqGpqyVgZhoB3WxwQ==
=t0FK
-----END PGP SIGNATURE-----

--PcJucMxfvz4yWHhNCBeCuPMH6DOMSZaWV--
