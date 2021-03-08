Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE814330C68
	for <lists+linux-can@lfdr.de>; Mon,  8 Mar 2021 12:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCHL3y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 Mar 2021 06:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhCHL3Z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 Mar 2021 06:29:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B29FC06174A
        for <linux-can@vger.kernel.org>; Mon,  8 Mar 2021 03:29:25 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJE4h-0004xn-5H; Mon, 08 Mar 2021 12:29:23 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:2b48:a475:d90d:3f7e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2224B5F0A6C;
        Mon,  8 Mar 2021 11:29:21 +0000 (UTC)
Date:   Mon, 8 Mar 2021 12:29:20 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org, Pankaj Sharma <pankj.sharma@samsung.com>
Subject: Re: [PATCH v2 3/3] can: m_can: fix periph RX path: use rx-offload to
 ensure skbs are sent from softirq context
Message-ID: <20210308112920.wqlbjq2maiqopa5j@pengutronix.de>
References: <20210308102427.63916-1-torin@maxiluxsystems.com>
 <20210308102427.63916-4-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ckke6rww6ulguwsf"
Content-Disposition: inline
In-Reply-To: <20210308102427.63916-4-torin@maxiluxsystems.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ckke6rww6ulguwsf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.03.2021 10:24:28, Torin Cooper-Bennun wrote:
> For peripheral devices, m_can sent skbs directly from a threaded irq
> instead of from a softirq context, breaking the tcan4x5x peripheral
> driver completely. This patch transitions the driver to use the
> rx-offload helper for peripherals, ensuring the skbs are sent from the
> correct context, with h/w timestamping to ensure correct ordering.
>=20
> Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
> ---
>  drivers/net/can/m_can/m_can.c | 109 +++++++++++++++++++++++++++++-----
>  drivers/net/can/m_can/m_can.h |   2 +
>  2 files changed, 97 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index e61b7e186d80..80519b5cec31 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -457,6 +457,20 @@ static void m_can_clean(struct net_device *net)
>  	}
>  }
> =20
> +/* For peripherals, pass skb to rx-offload, which will push skb from nap=
i. For
> + * non-peripherals, RX is done in napi already, so push directly. timest=
amp is
> + * used to ensure good skb ordering in rx-offload and is ignored
> + * for non-peripherals */

nitpick:
networking subsystem multiline comments have the closing "*/" in a
separate line. fixed.

> +static void m_can_receive_skb(struct m_can_classdev *cdev,
> +			      struct sk_buff *skb,
> +			      u32 timestamp)
> +{
> +	if (cdev->is_peripheral)
> +		can_rx_offload_queue_sorted(&cdev->offload, skb, timestamp);
> +	else
> +		netif_receive_skb(skb);
> +}
> +
>  static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
>  {
>  	struct net_device_stats *stats =3D &dev->stats;
> @@ -464,6 +478,7 @@ static void m_can_read_fifo(struct net_device *dev, u=
32 rxfs)
>  	struct canfd_frame *cf;
>  	struct sk_buff *skb;
>  	u32 id, fgi, dlc;
> +	u32 timestamp =3D 0;
>  	int i;
> =20
>  	/* calculate the fifo get index for where to read data */
> @@ -512,7 +527,9 @@ static void m_can_read_fifo(struct net_device *dev, u=
32 rxfs)
>  	stats->rx_packets++;
>  	stats->rx_bytes +=3D cf->len;
> =20
> -	netif_receive_skb(skb);
> +	timestamp =3D FIELD_GET(RX_BUF_RXTS_MASK, dlc);
> +
> +	m_can_receive_skb(cdev, skb, timestamp);
>  }
> =20
>  static int m_can_do_rx_poll(struct net_device *dev, int quota)
> @@ -546,9 +563,11 @@ static int m_can_do_rx_poll(struct net_device *dev, =
int quota)
> =20
>  static int m_can_handle_lost_msg(struct net_device *dev)
>  {
> +	struct m_can_classdev *cdev =3D netdev_priv(dev);
>  	struct net_device_stats *stats =3D &dev->stats;
>  	struct sk_buff *skb;
>  	struct can_frame *frame;
> +	u32 timestamp =3D 0;
> =20
>  	netdev_err(dev, "msg lost in rxf0\n");
> =20
> @@ -562,7 +581,10 @@ static int m_can_handle_lost_msg(struct net_device *=
dev)
>  	frame->can_id |=3D CAN_ERR_CRTL;
>  	frame->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
> =20
> -	netif_receive_skb(skb);
> +	if (cdev->is_peripheral)
> +		timestamp =3D m_can_get_timestamp(cdev);
> +
> +	m_can_receive_skb(cdev, skb, timestamp);
> =20
>  	return 1;
>  }
> @@ -574,6 +596,7 @@ static int m_can_handle_lec_err(struct net_device *de=
v,
>  	struct net_device_stats *stats =3D &dev->stats;
>  	struct can_frame *cf;
>  	struct sk_buff *skb;
> +	u32 timestamp =3D 0;
> =20
>  	cdev->can.can_stats.bus_error++;
>  	stats->rx_errors++;
> @@ -619,7 +642,11 @@ static int m_can_handle_lec_err(struct net_device *d=
ev,
> =20
>  	stats->rx_packets++;
>  	stats->rx_bytes +=3D cf->len;
> -	netif_receive_skb(skb);
> +
> +	if (cdev->is_peripheral)
> +		timestamp =3D m_can_get_timestamp(cdev);
> +
> +	m_can_receive_skb(cdev, skb, timestamp);
> =20
>  	return 1;
>  }
> @@ -677,6 +704,7 @@ static int m_can_handle_state_change(struct net_devic=
e *dev,
>  	struct sk_buff *skb;
>  	struct can_berr_counter bec;
>  	unsigned int ecr;
> +	u32 timestamp;

Better initialize =3D 0 here.

> =20
>  	switch (new_state) {
>  	case CAN_STATE_ERROR_WARNING:
> @@ -738,7 +766,11 @@ static int m_can_handle_state_change(struct net_devi=
ce *dev,
> =20
>  	stats->rx_packets++;
>  	stats->rx_bytes +=3D cf->len;
> -	netif_receive_skb(skb);
> +
> +	if (cdev->is_peripheral)
> +		timestamp =3D m_can_get_timestamp(cdev);
> +
> +	m_can_receive_skb(cdev, skb, timestamp);
> =20
>  	return 1;
>  }
> @@ -803,6 +835,7 @@ static int m_can_handle_protocol_error(struct net_dev=
ice *dev, u32 irqstatus)
>  	struct m_can_classdev *cdev =3D netdev_priv(dev);
>  	struct can_frame *cf;
>  	struct sk_buff *skb;
> +	u32 timestamp;

Here, too.

> =20
>  	/* propagate the error condition to the CAN stack */
>  	skb =3D alloc_can_err_skb(dev, &cf);
> @@ -824,7 +857,11 @@ static int m_can_handle_protocol_error(struct net_de=
vice *dev, u32 irqstatus)
>  		netdev_dbg(dev, "allocation of skb failed\n");
>  		return 0;
>  	}
> -	netif_receive_skb(skb);
> +
> +	if (cdev->is_peripheral)
> +		timestamp =3D m_can_get_timestamp(cdev);
> +
> +	m_can_receive_skb(cdev, skb, timestamp);
> =20
>  	return 1;
>  }
> @@ -925,6 +962,28 @@ static int m_can_poll(struct napi_struct *napi, int =
quota)
>  	return work_done;
>  }
> =20
> +/* Echo tx skb and update net stats. Peripherals use rx-offload for echo.
> + * timestamp is used for peripherals to ensure correct ordering by rx-of=
fload,
> + * and is ignored for non-peripherals */

nitpick about net comment style :)

> +static void m_can_tx_update_stats(struct m_can_classdev *cdev,
> +				  unsigned int msg_mark,
> +				  u32 timestamp)
> +{
> +	struct net_device *dev =3D cdev->net;
> +	struct net_device_stats *stats =3D &dev->stats;
> +
> +	if (cdev->is_peripheral)
> +		stats->tx_bytes +=3D
> +			can_rx_offload_get_echo_skb(&cdev->offload,
> +						    msg_mark,
> +						    timestamp,
> +						    NULL);
> +	else
> +		stats->tx_bytes +=3D can_get_echo_skb(dev, msg_mark, NULL);
> +
> +	stats->tx_packets++;
> +}
> +
>  static void m_can_echo_tx_event(struct net_device *dev)
>  {
>  	u32 txe_count =3D 0;
> @@ -934,7 +993,6 @@ static void m_can_echo_tx_event(struct net_device *de=
v)
>  	unsigned int msg_mark;
> =20
>  	struct m_can_classdev *cdev =3D netdev_priv(dev);
> -	struct net_device_stats *stats =3D &dev->stats;
> =20
>  	/* read tx event fifo status */
>  	m_can_txefs =3D m_can_read(cdev, M_CAN_TXEFS);
> @@ -944,21 +1002,24 @@ static void m_can_echo_tx_event(struct net_device =
*dev)
> =20
>  	/* Get and process all sent elements */
>  	for (i =3D 0; i < txe_count; i++) {
> +		u32 txe;
> +		u32 timestamp;

Here, too.

> +
>  		/* retrieve get index */
>  		fgi =3D (m_can_read(cdev, M_CAN_TXEFS) & TXEFS_EFGI_MASK) >>
>  			TXEFS_EFGI_SHIFT;
> =20
> -		/* get message marker */
> -		msg_mark =3D (m_can_txe_fifo_read(cdev, fgi, 4) &
> -			    TX_EVENT_MM_MASK) >> TX_EVENT_MM_SHIFT;
> +		/* get message marker, timestamp */
> +		txe =3D m_can_txe_fifo_read(cdev, fgi, 4);
> +		msg_mark =3D (txe & TX_EVENT_MM_MASK) >> TX_EVENT_MM_SHIFT;
> +		timestamp =3D FIELD_GET(TX_EVENT_TXTS_MASK, txe);
> =20
>  		/* ack txe element */
>  		m_can_write(cdev, M_CAN_TXEFA, (TXEFA_EFAI_MASK &
>  						(fgi << TXEFA_EFAI_SHIFT)));
> =20
>  		/* update stats */
> -		stats->tx_bytes +=3D can_get_echo_skb(dev, msg_mark, NULL);
> -		stats->tx_packets++;
> +		m_can_tx_update_stats(cdev, msg_mark, timestamp);
>  	}
>  }
> =20
> @@ -966,7 +1027,6 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
>  {
>  	struct net_device *dev =3D (struct net_device *)dev_id;
>  	struct m_can_classdev *cdev =3D netdev_priv(dev);
> -	struct net_device_stats *stats =3D &dev->stats;
>  	u32 ir;
> =20
>  	if (pm_runtime_suspended(cdev->dev))
> @@ -999,8 +1059,12 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
>  	if (cdev->version =3D=3D 30) {
>  		if (ir & IR_TC) {
>  			/* Transmission Complete Interrupt*/
> -			stats->tx_bytes +=3D can_get_echo_skb(dev, 0, NULL);
> -			stats->tx_packets++;
> +			u32 timestamp =3D 0;
> +
> +			if (cdev->is_peripheral)
> +				timestamp =3D m_can_get_timestamp(cdev);
> +			m_can_tx_update_stats(cdev, 0, timestamp);
> +
>  			can_led_event(dev, CAN_LED_EVENT_TX);
>  			netif_wake_queue(dev);
>  		}
> @@ -1461,6 +1525,9 @@ static int m_can_close(struct net_device *dev)
>  		cdev->tx_wq =3D NULL;
>  	}
> =20
> +	if (cdev->is_peripheral)
> +		can_rx_offload_disable(&cdev->offload);
> +
>  	close_candev(dev);
>  	can_led_event(dev, CAN_LED_EVENT_STOP);
> =20
> @@ -1659,6 +1726,9 @@ static int m_can_open(struct net_device *dev)
>  		goto exit_disable_clks;
>  	}
> =20
> +	if (cdev->is_peripheral)
> +		can_rx_offload_enable(&cdev->offload);
> +
>  	/* register interrupt handler */
>  	if (cdev->is_peripheral) {
>  		cdev->tx_skb =3D NULL;
> @@ -1700,6 +1770,8 @@ static int m_can_open(struct net_device *dev)
>  	if (cdev->is_peripheral)
>  		destroy_workqueue(cdev->tx_wq);
>  out_wq_fail:
> +	if (cdev->is_peripheral)
> +		can_rx_offload_disable(&cdev->offload);
>  	close_candev(dev);
>  exit_disable_clks:
>  	m_can_clk_stop(cdev);
> @@ -1853,6 +1925,13 @@ int m_can_class_register(struct m_can_classdev *cd=
ev)
>  			return ret;
>  	}
> =20
> +	if (cdev->is_peripheral) {
> +		ret =3D can_rx_offload_add_manual(cdev->net, &cdev->offload,
> +						M_CAN_NAPI_WEIGHT);
> +		if (ret)
> +			goto clk_disable;
> +	}
> +
>  	ret =3D m_can_dev_setup(cdev);
>  	if (ret)
>  		goto clk_disable;

You need to update the error handling here. I've done this while
applying.

> @@ -1883,6 +1962,8 @@ EXPORT_SYMBOL_GPL(m_can_class_register);
> =20
>  void m_can_class_unregister(struct m_can_classdev *cdev)
>  {
> +	if (cdev->is_peripheral)
> +		can_rx_offload_del(&cdev->offload);
>  	unregister_candev(cdev->net);
>  }
>  EXPORT_SYMBOL_GPL(m_can_class_unregister);
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index 3fda84cef351..ace071c3e58c 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -8,6 +8,7 @@
> =20
>  #include <linux/can/core.h>
>  #include <linux/can/led.h>
> +#include <linux/can/rx-offload.h>
>  #include <linux/completion.h>
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
> @@ -71,6 +72,7 @@ struct m_can_ops {
> =20
>  struct m_can_classdev {
>  	struct can_priv can;
> +	struct can_rx_offload offload;
>  	struct napi_struct napi;
>  	struct net_device *net;
>  	struct device *dev;
> --=20
> 2.30.1

I'll send a v3.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ckke6rww6ulguwsf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBGCo0ACgkQqclaivrt
76nPtwgAsfPmSZFLBW63P5XanAdF9LbIwHrZP9f23T/U9QcV9+lQptqdZkQM9YOH
JoMMU8nBoLG3erbyJpaatarQsT0dVsNLHMtrjM2umtKbemnmsVxZi6nJqDsU/2+a
jKkBsXrpfOyOrW8sUhyX5bjM5hpAlad4ovYr1IZSz0O31XNmT/hxw/9V2PKcCgus
V62qoSZk7NYbDam94Et0Ya8DPyuPIZ/MR/4DlkiXPfekl7nOTraFLnunMNOCHGB1
0LaRvNn2rClajspy+2grK1vfp7UMouBNkQDdkI62RUE8bOEA42Xi9Bo667JzFfNq
esu6WKXJtx0j0XdqfXOEZRM5Kt040Q==
=WMK/
-----END PGP SIGNATURE-----

--ckke6rww6ulguwsf--
