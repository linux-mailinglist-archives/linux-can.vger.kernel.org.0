Return-Path: <linux-can+bounces-639-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC9E8C55FB
	for <lists+linux-can@lfdr.de>; Tue, 14 May 2024 14:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FC51F2242C
	for <lists+linux-can@lfdr.de>; Tue, 14 May 2024 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C25446B9F;
	Tue, 14 May 2024 12:24:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784E54594C
	for <linux-can@vger.kernel.org>; Tue, 14 May 2024 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689447; cv=none; b=KjDlsJqvIC6eRYeIRucLTsY6ARF2fDY/EhJa4FpL0rieKgVoul3KSVU33qckwAoBbvDB5Js2GlwEadFrTUc+5w3h6K+QiWKD841ulIe2NjqeLF6gySU/IoakFHPikR3vsqvmram3v07zsZAYQUj46t9RqcYYrJ2Mt/wPcZHmkVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689447; c=relaxed/simple;
	bh=EqHKt9WXkMKHHRU+UyQBV3cuavqzOgeguLjutSMzT0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGlLozaiEsRg7TSwfzhYfEqplDfxVk8lsYhznFKWRe/3nnVMTEbjX3OcYpOoJOqBue5jggYKbN0iL064c94OUTKuKRF8ghQxl/tVAjcEx7E6nZA1g88tSVpZIyxj75rBSAJrOkPeJ3zrNyXcnekJVUbZIoKLTzHskfvUUPQ6PwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s6rC8-0003TQ-R9; Tue, 14 May 2024 14:23:48 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s6rC6-001Lsl-ON; Tue, 14 May 2024 14:23:46 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4F9712D1385;
	Tue, 14 May 2024 12:23:46 +0000 (UTC)
Date: Tue, 14 May 2024 14:23:45 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vitor Soares <ivitro@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vitor Soares <vitor.soares@toradex.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5] can: mcp251xfd: fix infinite loop when xmit fails
Message-ID: <20240514-corgi-of-marvelous-peace-968f5c-mkl@pengutronix.de>
References: <20240514105822.99986-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tzjc4qdq45al67io"
Content-Disposition: inline
In-Reply-To: <20240514105822.99986-1-ivitro@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--tzjc4qdq45al67io
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.05.2024 11:58:22, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> When the mcp251xfd_start_xmit() function fails, the driver stops
> processing messages, and the interrupt routine does not return,
> running indefinitely even after killing the running application.
>=20
> Error messages:
> [  441.298819] mcp251xfd spi2.0 can0: ERROR in mcp251xfd_start_xmit: -16
> [  441.306498] mcp251xfd spi2.0 can0: Transmit Event FIFO buffer not empt=
y. (seq=3D0x000017c7, tef_tail=3D0x000017cf, tef_head=3D0x000017d0, tx_head=
=3D0x000017d3).
> ... and repeat forever.
>=20
> The issue can be triggered when multiple devices share the same
> SPI interface. And there is concurrent access to the bus.
>=20
> The problem occurs because tx_ring->head increments even if
> mcp251xfd_start_xmit() fails. Consequently, the driver skips one
> TX package while still expecting a response in
> mcp251xfd_handle_tefif_one().
>=20
> This patch resolves the issue by starting a workqueue to write
> the tx obj synchronously if err =3D -EBUSY. In case of another error,
> it decrements tx_ring->head, removes skb from the echo stack, and
> drops the message.

This looks quite good! Good work!

I think you better move the allocation/destroy of the wq into the open()
and stop() callbacks. You have to destroy the workqueue before putting
the interface to sleep.

>=20
> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD =
SPI CAN")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
>=20
> V4->V5:
>   - Start a workqueue to write tx obj with spi_sync() when spi_async() =
=3D=3D -EBUSY.
>=20
> V3->V4:
>   - Leave can_put_echo_skb() and stop the queue if needed, before mcp251x=
fd_tx_obj_write().
>   - Re-sync head and remove echo skb if mcp251xfd_tx_obj_write() fails.
>   - Revert -> return NETDEV_TX_BUSY if mcp251xfd_tx_obj_write() =3D=3D -E=
BUSY.
>=20
> V2->V3:
>   - Add tx_dropped stats.
>   - netdev_sent_queue() only if can_put_echo_skb() succeed.
>=20
> V1->V2:
>   - Return NETDEV_TX_BUSY if mcp251xfd_tx_obj_write() =3D=3D -EBUSY.
>   - Rework the commit message to address the change above.
>   - Change can_put_echo_skb() to be called after mcp251xfd_tx_obj_write()=
 succeed.
>     Otherwise, we get Kernel NULL pointer dereference error.
>=20
>  .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 13 ++++-
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c  | 51 ++++++++++++++++---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  5 ++
>  3 files changed, 60 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net=
/can/spi/mcp251xfd/mcp251xfd-core.c
> index 1d9057dc44f2..6cca853f2b1e 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -2141,15 +2141,25 @@ static int mcp251xfd_probe(struct spi_device *spi)
>  	if (err)
>  		goto out_free_candev;
> =20
> +	priv->tx_work_obj =3D NULL;
> +	priv->wq =3D alloc_workqueue("mcp251xfd_wq", WQ_FREEZABLE, 0);

The m_can driver uses a ordered workqueue and you can add the name of
the spi device to the wq's name :)

        priv->wq =3D alloc_ordered_workqueue("%s-mcp251xfd_wq", WQ_FREEZABL=
E | WQ_MEM_RECLAIM, dev_name(&spi->dev));

> +	if (!priv->wq) {
> +		err =3D -ENOMEM;
> +		goto out_can_rx_offload_del;
> +	}
> +	INIT_WORK(&priv->tx_work, mcp251xfd_tx_obj_write_sync);
> +
>  	err =3D mcp251xfd_register(priv);
>  	if (err) {
>  		dev_err_probe(&spi->dev, err, "Failed to detect %s.\n",
>  			      mcp251xfd_get_model_str(priv));
> -		goto out_can_rx_offload_del;
> +		goto out_can_free_wq;

nitpick:
                     out_destroy_workqueue;

to match the function call.

>  	}
> =20
>  	return 0;
> =20
> + out_can_free_wq:
> +	destroy_workqueue(priv->wq);
>   out_can_rx_offload_del:
>  	can_rx_offload_del(&priv->offload);
>   out_free_candev:
> @@ -2165,6 +2175,7 @@ static void mcp251xfd_remove(struct spi_device *spi)
>  	struct mcp251xfd_priv *priv =3D spi_get_drvdata(spi);
>  	struct net_device *ndev =3D priv->ndev;
> =20
> +	destroy_workqueue(priv->wq);
>  	can_rx_offload_del(&priv->offload);
>  	mcp251xfd_unregister(priv);
>  	spi->max_speed_hz =3D priv->spi_max_speed_hz_orig;
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c b/drivers/net/c=
an/spi/mcp251xfd/mcp251xfd-tx.c
> index 160528d3cc26..1e7ddf316643 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> @@ -131,6 +131,41 @@ mcp251xfd_tx_obj_from_skb(const struct mcp251xfd_pri=
v *priv,
>  	tx_obj->xfer[0].len =3D len;
>  }
> =20
> +static void mcp251xfd_tx_failure_drop(const struct mcp251xfd_priv *priv,
> +				      struct mcp251xfd_tx_ring *tx_ring,
> +				      int err)
> +{
> +	struct net_device *ndev =3D priv->ndev;
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	unsigned int frame_len =3D 0;
> +	u8 tx_head;
> +
> +	tx_ring->head--;
> +	stats->tx_dropped++;
> +	tx_head =3D mcp251xfd_get_tx_head(tx_ring);
> +	can_free_echo_skb(ndev, tx_head, &frame_len);
> +	netdev_completed_queue(ndev, 1, frame_len);
> +	netif_wake_queue(ndev);
> +
> +	if (net_ratelimit())
> +		netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
> +}
> +
> +void mcp251xfd_tx_obj_write_sync(struct work_struct *ws)
> +{
> +	struct mcp251xfd_priv *priv =3D container_of(ws, struct mcp251xfd_priv,
> +						   tx_work);
> +	struct mcp251xfd_tx_obj *tx_obj =3D priv->tx_work_obj;
> +	struct mcp251xfd_tx_ring *tx_ring =3D priv->tx;
> +	int err;
> +
> +	err =3D spi_sync(priv->spi, &tx_obj->msg);
> +	if (err)
> +		mcp251xfd_tx_failure_drop(priv, tx_ring, err);
> +
> +	priv->tx_work_obj =3D NULL;

Race condition:
- after spi_sync() the CAN frame is send
- after the TX complete IRQ the TX queue is restarted
- the xmit handler might get BUSY
- fill the tx_work_obj again

> +}
> +
>  static int mcp251xfd_tx_obj_write(const struct mcp251xfd_priv *priv,
>  				  struct mcp251xfd_tx_obj *tx_obj)
>  {
> @@ -175,7 +210,7 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
>  	if (can_dev_dropped_skb(ndev, skb))
>  		return NETDEV_TX_OK;
> =20
> -	if (mcp251xfd_tx_busy(priv, tx_ring))
> +	if (mcp251xfd_tx_busy(priv, tx_ring) || priv->tx_work_obj)

This should not happen, but better save than sorry.

>  		return NETDEV_TX_BUSY;
> =20
>  	tx_obj =3D mcp251xfd_get_tx_obj_next(tx_ring);
> @@ -193,13 +228,13 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *sk=
b,
>  		netdev_sent_queue(priv->ndev, frame_len);
> =20
>  	err =3D mcp251xfd_tx_obj_write(priv, tx_obj);
> -	if (err)
> -		goto out_err;
> -
> -	return NETDEV_TX_OK;
> -
> - out_err:
> -	netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
> +	if (err =3D=3D -EBUSY) {
> +		priv->tx_work_obj =3D tx_obj;
> +		netif_stop_queue(ndev);
> +		queue_work(priv->wq, &priv->tx_work);

nitpick: I would do "netif_stop_queue(ndev);" first.

My mental idea of the code flow is:
- stop the queue
- do everything to start the workqueue.

> +	} else if (err) {
> +		mcp251xfd_tx_failure_drop(priv, tx_ring, err);
> +	}
> =20
>  	return NETDEV_TX_OK;
>  }
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/=
spi/mcp251xfd/mcp251xfd.h
> index 24510b3b8020..4e27a33f4030 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> @@ -633,6 +633,10 @@ struct mcp251xfd_priv {
>  	struct mcp251xfd_rx_ring *rx[MCP251XFD_FIFO_RX_NUM];
>  	struct mcp251xfd_tx_ring tx[MCP251XFD_FIFO_TX_NUM];
> =20
> +	struct workqueue_struct *wq;
> +	struct work_struct tx_work;
> +	struct mcp251xfd_tx_obj *tx_work_obj;
> +
>  	DECLARE_BITMAP(flags, __MCP251XFD_FLAGS_SIZE__);
> =20
>  	u8 rx_ring_num;
> @@ -952,6 +956,7 @@ void mcp251xfd_skb_set_timestamp(const struct mcp251x=
fd_priv *priv,
>  void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv);
>  void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv);
> =20
> +void mcp251xfd_tx_obj_write_sync(struct work_struct *ws);
>  netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
>  				 struct net_device *ndev);
> =20
> --=20
> 2.34.1
>=20
>=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tzjc4qdq45al67io
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZDV88ACgkQKDiiPnot
vG9hCwf/dI6WtY94bpYBU7R4g5F39HD1ptIEai1TYo8QYR9r+V8DD0PcSzmoB1oS
FcBQXDrYlPTbgm4rmGwC4ojYB66+CX48tJMh2vDLvmW9jXr6Q0Fh+O4G0MpSHAAC
a8/TLVjD833N3wxnBCofsAr95wpkUoflOGMB9pGW2B8b38XC+G9f/drpGDYMvo+l
Hn4FJCjPFuU9dUagUM3DPYSk0xjvoEDfY4tSU7XOafUsZ/qWbyt0H5B15iNAo07z
vFAiJm/PvVK2UNFcnAvXs5koi5+CywlcruCZaPF+YiWoBWIeOZ6brRKNNUSeywCl
pIi7ocWf97wyljokRaER2fgiMvU6RA==
=GG7y
-----END PGP SIGNATURE-----

--tzjc4qdq45al67io--

