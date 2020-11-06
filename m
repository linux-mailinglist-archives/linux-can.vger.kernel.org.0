Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908692A9A93
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgKFRPc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFRPc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:15:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A75C0613CF
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 09:15:32 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kb5Kj-000436-Su; Fri, 06 Nov 2020 18:15:30 +0100
Received: from [IPv6:2a03:f580:87bc:d400:33f0:799f:c05f:fe06] (unknown [IPv6:2a03:f580:87bc:d400:33f0:799f:c05f:fe06])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DE07558C65C;
        Fri,  6 Nov 2020 17:15:28 +0000 (UTC)
To:     Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        linux-can@vger.kernel.org
Cc:     wg@grandegger.com
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
 <20201106170206.32162-6-uttenthaler@ems-wuensche.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 05/17] can: ems_usb: Replace constant define
 RX_BUFFER_SIZE by variable bulk_rd_buf_size, because this will have different
 values for CPC-USB/ARM7 and CPC-USB/FD. For the same reason added a function
 pointer ems_usb_write_mode. In device probe function added a switch statement
 to select between CPC-USB/ARM7 and CPC-USB/FD and rearranged initialization
 sequence accordingly.
Message-ID: <a5cabc30-4e7c-dd3d-9f4c-afc42864fe10@pengutronix.de>
Date:   Fri, 6 Nov 2020 18:15:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106170206.32162-6-uttenthaler@ems-wuensche.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="lYJhDPh3mri9Y3kdlLKqoS1X3bwgKVm4e"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lYJhDPh3mri9Y3kdlLKqoS1X3bwgKVm4e
Content-Type: multipart/mixed; boundary="dIXiYAV2Hp0rOjCsHf2fv4baS7tsTnbfO";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
 linux-can@vger.kernel.org
Cc: wg@grandegger.com
Message-ID: <a5cabc30-4e7c-dd3d-9f4c-afc42864fe10@pengutronix.de>
Subject: Re: [PATCH 05/17] can: ems_usb: Replace constant define
 RX_BUFFER_SIZE by variable bulk_rd_buf_size, because this will have different
 values for CPC-USB/ARM7 and CPC-USB/FD. For the same reason added a function
 pointer ems_usb_write_mode. In device probe function added a switch statement
 to select between CPC-USB/ARM7 and CPC-USB/FD and rearranged initialization
 sequence accordingly.
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
 <20201106170206.32162-6-uttenthaler@ems-wuensche.com>
In-Reply-To: <20201106170206.32162-6-uttenthaler@ems-wuensche.com>

--dIXiYAV2Hp0rOjCsHf2fv4baS7tsTnbfO
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Please keep the patch subject within reasonable length.
It sould describe what you have done. The patch description should descri=
be the why.

On 11/6/20 6:01 PM, Gerhard Uttenthaler wrote:
> Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
> ---
>  drivers/net/can/usb/ems_usb.c | 66 +++++++++++++++++++++++++----------=

>  1 file changed, 47 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_us=
b.c
> index 4ed0d681a68c..a3943042b8c8 100644
> --- a/drivers/net/can/usb/ems_usb.c
> +++ b/drivers/net/can/usb/ems_usb.c
> @@ -266,7 +266,6 @@ static struct usb_device_id ems_usb_table[] =3D {
> =20
>  MODULE_DEVICE_TABLE(usb, ems_usb_table);
> =20
> -#define RX_BUFFER_SIZE      64

Can you keep this define instead of using a "64" below? Give it a proper
prefix/postfix if needed.

>  #define CPC_HEADER_SIZE     4
>  #define INTR_IN_BUFFER_SIZE 4
> =20
> @@ -290,6 +289,8 @@ struct ems_usb {
>  	struct usb_device *udev;
>  	struct net_device *netdev;
> =20
> +	u32 bulk_rd_buf_size;
> +
>  	atomic_t active_tx_urbs;
>  	struct usb_anchor tx_submitted;
>  	struct ems_tx_urb_context tx_contexts[MAX_TX_URBS];
> @@ -301,7 +302,9 @@ struct ems_usb {
>  	u8 *tx_msg_buffer;
> =20
>  	u8 *intr_in_buffer;
> -	unsigned int free_slots; /* remember number of available slots */
> +	u32 free_slots; /* remember number of available slots */

nitpick
Why this change?

> +
> +	int (*ems_usb_write_mode)(struct ems_usb *dev, u32 mode);
> =20
>  	struct ems_cpc_msg active_params; /* active controller parameters */
>  };
> @@ -522,7 +525,7 @@ static void ems_usb_read_bulk_callback(struct urb *=
urb)
> =20
>  resubmit_urb:
>  	usb_fill_bulk_urb(urb, dev->udev, usb_rcvbulkpipe(dev->udev, 2),
> -			  urb->transfer_buffer, RX_BUFFER_SIZE,
> +			  urb->transfer_buffer, dev->bulk_rd_buf_size,
>  			  ems_usb_read_bulk_callback, dev);
> =20
>  	retval =3D usb_submit_urb(urb, GFP_ATOMIC);
> @@ -596,9 +599,18 @@ static int ems_usb_command_msg(struct ems_usb *dev=
, struct ems_cpc_msg *msg)
> =20
>  /* Change CAN controllers' mode register
>   */
> -static int ems_usb_write_mode(struct ems_usb *dev, u8 mode)
> +static int ems_usb_write_mode_arm7(struct ems_usb *dev, u32 mode)
>  {
> -	dev->active_params.msg.can_params.cc_params.sja1000.mode =3D mode;
> +	struct cpc_sja1000_params *sja1000 =3D
> +		&dev->active_params.msg.can_params.cc_params.sja1000;
> +
> +	if (mode =3D=3D CPC_USB_RESET_MODE)
> +		sja1000->mode |=3D SJA1000_MOD_RM;
> +	else if (mode =3D=3D CPC_USB_RUN_MODE)
> +		sja1000->mode &=3D ~SJA1000_MOD_RM;
> +
> +	else
> +		return -EINVAL;
> =20
>  	return ems_usb_command_msg(dev, &dev->active_params);
>  }
> @@ -641,7 +653,7 @@ static int ems_usb_start(struct ems_usb *dev)
>  			break;
>  		}
> =20
> -		buf =3D usb_alloc_coherent(dev->udev, RX_BUFFER_SIZE, GFP_KERNEL,
> +		buf =3D usb_alloc_coherent(dev->udev, dev->bulk_rd_buf_size, GFP_KER=
NEL,
>  					 &urb->transfer_dma);
>  		if (!buf) {
>  			netdev_err(netdev, "No memory left for USB buffer\n");
> @@ -651,7 +663,7 @@ static int ems_usb_start(struct ems_usb *dev)
>  		}
> =20
>  		usb_fill_bulk_urb(urb, dev->udev, usb_rcvbulkpipe(dev->udev, 2),
> -				  buf, RX_BUFFER_SIZE,
> +				  buf, dev->bulk_rd_buf_size,
>  				  ems_usb_read_bulk_callback, dev);
>  		urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
>  		usb_anchor_urb(urb, &dev->rx_submitted);
> @@ -659,7 +671,7 @@ static int ems_usb_start(struct ems_usb *dev)
>  		err =3D usb_submit_urb(urb, GFP_KERNEL);
>  		if (err) {
>  			usb_unanchor_urb(urb);
> -			usb_free_coherent(dev->udev, RX_BUFFER_SIZE, buf,
> +			usb_free_coherent(dev->udev, dev->bulk_rd_buf_size, buf,
>  					  urb->transfer_dma);
>  			usb_free_urb(urb);
>  			break;
> @@ -708,7 +720,7 @@ static int ems_usb_start(struct ems_usb *dev)
>  	if (err)
>  		goto failed;
> =20
> -	err =3D ems_usb_write_mode(dev, SJA1000_MOD_NORMAL);
> +	err =3D dev->can.do_set_mode(netdev, CAN_MODE_START);
>  	if (err)
>  		goto failed;
> =20
> @@ -742,7 +754,7 @@ static int ems_usb_open(struct net_device *netdev)
>  	struct ems_usb *dev =3D netdev_priv(netdev);
>  	int err;
> =20
> -	err =3D ems_usb_write_mode(dev, SJA1000_MOD_RM);
> +	err =3D dev->ems_usb_write_mode(dev, CPC_USB_RESET_MODE);
>  	if (err)
>  		return err;
> =20
> @@ -900,7 +912,7 @@ static int ems_usb_close(struct net_device *netdev)=

>  	netif_stop_queue(netdev);
> =20
>  	/* Set CAN controller to reset mode */
> -	if (ems_usb_write_mode(dev, SJA1000_MOD_RM))
> +	if (dev->ems_usb_write_mode(dev, CPC_USB_RESET_MODE))
>  		netdev_warn(netdev, "couldn't stop device");
> =20
>  	close_candev(netdev);
> @@ -915,8 +927,8 @@ static const struct net_device_ops ems_usb_netdev_o=
ps =3D {
>  	.ndo_change_mtu =3D can_change_mtu,
>  };
> =20
> -static const struct can_bittiming_const ems_usb_bittiming_const =3D {
> -	.name =3D "ems_usb",
> +static const struct can_bittiming_const ems_usb_bittiming_const_arm7 =3D=
 {
> +	.name =3D "ems_usb_arm7",

You are changing the user space visible name of the CAN device. Is this n=
eeded?

>  	.tseg1_min =3D 1,
>  	.tseg1_max =3D 16,
>  	.tseg2_min =3D 1,
> @@ -933,7 +945,7 @@ static int ems_usb_set_mode(struct net_device *netd=
ev, enum can_mode mode)
> =20
>  	switch (mode) {
>  	case CAN_MODE_START:
> -		if (ems_usb_write_mode(dev, SJA1000_MOD_NORMAL))
> +		if (dev->ems_usb_write_mode(dev, CPC_USB_RUN_MODE))
>  			netdev_warn(netdev, "couldn't start device");
> =20
>  		if (netif_queue_stopped(netdev))
> @@ -947,7 +959,7 @@ static int ems_usb_set_mode(struct net_device *netd=
ev, enum can_mode mode)
>  	return 0;
>  }
> =20
> -static int ems_usb_set_bittiming(struct net_device *netdev)
> +static int ems_usb_set_bittiming_arm7(struct net_device *netdev)
>  {
>  	struct ems_usb *dev =3D netdev_priv(netdev);
>  	struct can_bittiming *bt =3D &dev->can.bittiming;
> @@ -1018,11 +1030,29 @@ static int ems_usb_probe(struct usb_interface *=
intf,
>  	dev->netdev =3D netdev;
> =20
>  	dev->can.state =3D CAN_STATE_STOPPED;
> +
> +	/* Select CPC-USB/ARM7 or CPC-USB/FD */
> +	switch (dev->udev->descriptor.idProduct) {
> +	case USB_CPCUSB_ARM7_PRODUCT_ID:

please indent one level after the case

> +
>  	dev->can.clock.freq =3D EMS_USB_ARM7_CLOCK;
> -	dev->can.bittiming_const =3D &ems_usb_bittiming_const;
> -	dev->can.do_set_bittiming =3D ems_usb_set_bittiming;
> +	dev->can.bittiming_const =3D &ems_usb_bittiming_const_arm7;
> +	dev->can.do_set_bittiming =3D ems_usb_set_bittiming_arm7;
>  	dev->can.do_set_mode =3D ems_usb_set_mode;
>  	dev->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES;
> +	init_params_sja1000(&dev->active_params);
> +	dev->ems_usb_write_mode =3D ems_usb_write_mode_arm7;
> +	dev->bulk_rd_buf_size =3D 64;
> +	break;
> +
> +	case USB_CPCUSB_FD_PRODUCT_ID:
> +	// Placeholder for next patchess

Add this case in the patch where you fill the placeholder.

> +	break;
> +
> +	default:
> +		err =3D -ENODEV;
> +		goto cleanup_candev;
> +	}
> =20
>  	netdev->netdev_ops =3D &ems_usb_netdev_ops;
> =20
> @@ -1053,8 +1083,6 @@ static int ems_usb_probe(struct usb_interface *in=
tf,
> =20
>  	SET_NETDEV_DEV(netdev, &intf->dev);
> =20
> -	init_params_sja1000(&dev->active_params);
> -
>  	err =3D ems_usb_command_msg(dev, &dev->active_params);
>  	if (err) {
>  		netdev_err(netdev, "couldn't initialize controller: %d\n", err);
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--dIXiYAV2Hp0rOjCsHf2fv4baS7tsTnbfO--

--lYJhDPh3mri9Y3kdlLKqoS1X3bwgKVm4e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+lhKwACgkQqclaivrt
76mSSAf+MKQYDWSxOUNKo69nMeeoaEFeK3sCW2P41yrDl7hk/BZ6YYHFlKkYYVlg
WfNIub36MR0Ex5Rz6uPNZ/oz/J7z9A6Db/hrijPFu3NDcigO0Q1hV9P5DBCsFALQ
9j2jOzJ+tJ6BUp763F6CinnvH82prnIhwdjdhOZtowi6njOMe4G47l0RYn6/343n
RvNR5P4L/Kex7LDzrbfzIQ16R7znA7gstFH4R90dz0qjaseVoRtEPFCkWY11QjVm
i2hj3zAXE/s/10tsQfLbwoinaFgalFNdBU2iZtMlKpd69NU3oPQCqCqMxUcDBJx5
nNjlajayWl8pB/rtONXkj/KJr0paZw==
=2N7p
-----END PGP SIGNATURE-----

--lYJhDPh3mri9Y3kdlLKqoS1X3bwgKVm4e--
