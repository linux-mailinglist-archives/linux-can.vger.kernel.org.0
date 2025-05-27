Return-Path: <linux-can+bounces-3692-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B80AC4CA3
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 13:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951DE17D609
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5A7253F2D;
	Tue, 27 May 2025 11:00:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEE1259CBC
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748343650; cv=none; b=f6PchXeFOfRD+AZvL9BrxFk+KUjABv4/9MIFpTX1NqH87l1QoOMnqJIqOb0ZM1HMIKBxVT/w17d/W7DcUJi8kzO/sCzSk9heRovaBrsI1qD6E/LYP3cvUIvkE2/FMzVyXf9EeOMWJoLh+EN7R/tlkc5sr61H5IsXnOjtV5As0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748343650; c=relaxed/simple;
	bh=s+cKXskkNZlKtpKX2XGpa9gvHjHeaiMvbRBgaAE7w5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfIhhsQe8mfJ62dtJnYEd8hMoMHyDtlATD0yw94v7PCEEmgM+9RNku5hB7MAFY67v3atxmKFLeI6qNOIV4cnOfL8E7viljYOx+Kfwef0IezYEuTAasucCW0Fx77LFHObeYY7APkhYulrhCrS/vsHO0nMVOGZwpyhNhMTPW1oD94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uJs2Y-0000Xh-40; Tue, 27 May 2025 13:00:14 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uJs2W-000PBd-0I;
	Tue, 27 May 2025 13:00:12 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9F4BA41A6F7;
	Tue, 27 May 2025 11:00:11 +0000 (UTC)
Date: Tue, 27 May 2025 13:00:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com, 
	kever.yang@rock-chips.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 4/4] net: can: rockchip: support dma for rk3576 rx
Message-ID: <20250527-benevolent-rainbow-sturgeon-55c33b-mkl@pengutronix.de>
References: <20250526062559.2061311-1-zhangqing@rock-chips.com>
 <20250526062559.2061311-5-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j7hntxwhinbwwsfs"
Content-Disposition: inline
In-Reply-To: <20250526062559.2061311-5-zhangqing@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--j7hntxwhinbwwsfs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 4/4] net: can: rockchip: support dma for rk3576 rx
MIME-Version: 1.0

On 26.05.2025 14:25:59, Elaine Zhang wrote:
> The new can controller of rk3576 supports rx dma.

I'm missing dma_sync_single_for_cpu() and dma_sync_single_for_device().

What does the overall picture look like?

The CAN controller receives a CAN frame, it triggers an interrupt, the
driver starts a RX-DMA, the RX-DMA finishes triggers the callback, the
driver allocates an skb and copies the data from the DMA dest memory to
the skb. Finally the skb is passed to the networking stack.

Have you done any measurements if using DMA brings any benefits here? I
doubt that.

If your hardware supports, a better setup would be to allocate a bunch
of skbs and setup the a DMA request per skb and push them all to the DMA
engine during open(). If the CAN controller receives a CAN frame, the
DMA automatically starts and raises an IRQ after finish of the DMA
transfer. Transform the header and then pass the skb to the networking
stack - no need for memcpy.

This _might_ lower the total CPU cost of RX, but a lot of additional
code is used for that.

Never the less, review inline.

> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../net/can/rockchip/rockchip_canfd-core.c    | 39 +++++++++
>  drivers/net/can/rockchip/rockchip_canfd-rx.c  | 87 +++++++++++++++++++
>  drivers/net/can/rockchip/rockchip_canfd.h     | 11 +++
>  3 files changed, 137 insertions(+)
>=20
> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net=
/can/rockchip/rockchip_canfd-core.c
> index 92e260cb2527..9ef4a9ae19d8 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
> @@ -433,6 +433,9 @@ static void rk3576canfd_chip_start(struct rkcanfd_pri=
v *priv)
>  		      RK3576CANFD_REG_BRS_CFG_BRS_NEGSYNC_EN |
>  		      RK3576CANFD_REG_BRS_CFG_BRS_POSSYNC_EN);
> =20
> +	if (priv->use_dma)
> +		rkcanfd_write(priv, RK3576CANFD_REG_DMA_CTRL,
> +			      RK3576CANFD_REG_DMA_CTRL_DMA_RX_EN | priv->dma_thr);
>  	rkcanfd_set_bittiming(priv);
> =20
>  	priv->devtype_data.interrupts_disable(priv);
> @@ -1324,10 +1327,31 @@ static const struct of_device_id rkcanfd_of_match=
[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, rkcanfd_of_match);
> =20
> +static void rk3576_canfd_dma_init(struct rkcanfd_priv *priv)
> +{
> +	struct dma_slave_config rxconf =3D {
> +		.direction =3D DMA_DEV_TO_MEM,
> +		.src_addr =3D priv->rx_dma_src_addr,
> +		.src_addr_width =3D 4,
> +		.dst_addr_width =3D 4,
> +		.src_maxburst =3D 9,
> +	};
> +
> +	priv->dma_thr =3D rxconf.src_maxburst - 1;
> +	priv->rxbuf =3D dma_alloc_coherent(priv->dev, priv->dma_size * 14,

Where does the 14 come from?

> +					 &priv->rx_dma_dst_addr, GFP_KERNEL);

I'm missing the cleanup for priv->rxbuf.

> +	if (!priv->rxbuf) {
> +		priv->use_dma =3D 0;
> +		return;
> +	}
> +	dmaengine_slave_config(priv->rxchan, &rxconf);

Please add error handling.

> +}
> +
>  static int rkcanfd_probe(struct platform_device *pdev)
>  {
>  	struct rkcanfd_priv *priv;
>  	struct net_device *ndev;
> +	struct resource *res;
>  	const void *match;
>  	int err;
> =20
> @@ -1349,6 +1373,7 @@ static int rkcanfd_probe(struct platform_device *pd=
ev)
>  		goto out_free_candev;
>  	}
> =20
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	priv->regs =3D devm_platform_ioremap_resource(pdev, 0);

Please use devm_platform_get_and_ioremap_resource();

>  	if (IS_ERR(priv->regs)) {
>  		err =3D PTR_ERR(priv->regs);
> @@ -1376,6 +1401,7 @@ static int rkcanfd_probe(struct platform_device *pd=
ev)
>  	priv->can.do_set_mode =3D rkcanfd_set_mode;
>  	priv->can.do_get_berr_counter =3D rkcanfd_get_berr_counter;
>  	priv->ndev =3D ndev;
> +	priv->dev =3D &pdev->dev;

Please remove, priv->dev is not used in the hot path, use
priv->ndev->dev.parent instead.

> =20
>  	match =3D device_get_match_data(&pdev->dev);
>  	if (match) {
> @@ -1384,6 +1410,19 @@ static int rkcanfd_probe(struct platform_device *p=
dev)
>  			priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD;
>  	}
> =20
> +	priv->rxchan =3D dma_request_chan(&pdev->dev, "rx");

I'm missing the cleanup for priv->rxchan.

> +	if (IS_ERR(priv->rxchan)) {

Please handle -EPROBE_DEFER properly.

> +		dev_warn(&pdev->dev, "Failed to request rxchan\n");

Please print the error value and state that you are continuing w/o DMA,
e.g.:

    netdev_warn("Failed to request RX-DMA channel: %pe, continuing without =
DMA", priv->rxchan);

> +		priv->rxchan =3D NULL;
> +		priv->use_dma =3D 0;
> +	} else {
> +		priv->rx_dma_src_addr =3D res->start + RK3576CANFD_REG_RXFRD;
> +		priv->dma_size =3D RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT * 4;

Why do you need priv->dma_size, it doesn't change during runtime, does it?

> +		priv->use_dma =3D 1;
> +	}
> +	if (priv->use_dma)
> +		rk3576_canfd_dma_init(priv);
> +

Can you move all DMA related functionality into rk3576_canfd_dma_init(),
pass res as a parameter, remove rx_dma_src_addr.

I think you don't need use_dma, checking rxchan !=3D NULL should be
sufficient.

>  	err =3D can_rx_offload_add_manual(ndev, &priv->offload,
>  					RKCANFD_NAPI_WEIGHT);
>  	if (err)
> diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/c=
an/rockchip/rockchip_canfd-rx.c
> index 8a383cabd9d2..ac06e876552e 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
> @@ -285,6 +285,52 @@ static int rk3576canfd_handle_rx_int_one(struct rkca=
nfd_priv *priv)
>  	return 0;
>  }
> =20
> +static int rk3576canfd_handle_rx_dma(struct rkcanfd_priv *priv, u32 addr)
> +{
> +	struct net_device_stats *stats =3D &priv->ndev->stats;
> +	struct canfd_frame cfd[1] =3D { }, *skb_cfd;
> +	struct rk3576canfd_fifo_header header[1] =3D { };
> +	struct sk_buff *skb;
> +	u32 __iomem *rxbuf =3D (u32 __iomem *)priv->rxbuf;

Why do you cast rx_buf to __iomem? It's normal memory, isn't it?

> +	unsigned int len;
> +	int i;
> +
> +	header->frameinfo =3D readl(rxbuf +
> +				  addr * RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
> +	header->id =3D readl(rxbuf + 1 +
> +			   addr * RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
> +	for (i =3D 0; i < (RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT - 2); i=
++)
> +		cfd->data[i] =3D readl(rxbuf + 2 + i +
> +				     addr * RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
> +

Remove cfd and header and directly access the rxbuf.

> +	len =3D rk3576canfd_fifo_header_to_cfd_header(priv, header, cfd);
> +
> +	/* Manual handling of CAN Bus Error counters. See
> +	 * rkcanfd_get_corrected_berr_counter() for detailed
> +	 * explanation.
> +	 */
> +	if (priv->bec.rxerr)
> +		priv->bec.rxerr =3D min(CAN_ERROR_PASSIVE_THRESHOLD,
> +				      priv->bec.rxerr) - 1;
> +
> +	if (header->frameinfo & RK3576CANFD_REG_RXFRD_FRAMEINFO_FDF)
> +		skb =3D alloc_canfd_skb(priv->ndev, &skb_cfd);
> +	else
> +		skb =3D alloc_can_skb(priv->ndev, (struct can_frame **)&skb_cfd);

copy the data to the allocated skb directly.

> +
> +	if (!skb) {
> +		stats->rx_dropped++;
> +
> +		return 0;
> +	}
> +
> +	memcpy(skb_cfd, cfd, len);
> +	stats->rx_packets++;
> +	stats->rx_bytes +=3D cfd->len;
> +	netif_rx(skb);

Use the rx_offload_helper here too.

> +	return 0;
> +}
> +
>  static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
>  {
>  	struct net_device_stats *stats =3D &priv->ndev->stats;
> @@ -380,6 +426,43 @@ rk3576canfd_rx_fifo_get_len(const struct rkcanfd_pri=
v *priv)
>  	return DIV_ROUND_UP(val, RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
>  }
> =20
> +static void rk3576_canfd_rx_dma_callback(void *data)
> +{
> +	struct rkcanfd_priv *priv =3D data;
> +	int i;
> +
> +	for (i =3D 0; i < priv->quota; i++)
> +		rk3576canfd_handle_rx_dma(priv, i);
> +
> +	rkcanfd_write(priv, RK3576CANFD_REG_INT_MASK, priv->reg_int_mask_defaul=
t);
> +}
> +
> +static int rk3576_canfd_rx_dma(struct rkcanfd_priv *priv)
> +{
> +	struct dma_async_tx_descriptor *rxdesc =3D NULL;
> +	const u32 reg =3D rkcanfd_read(priv, RK3576CANFD_REG_STR_STATE);
> +	int quota =3D FIELD_GET(RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT, reg);
> +
> +	quota =3D DIV_ROUND_UP(quota, RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_U=
NIT);
> +	priv->quota =3D quota;
> +	if (priv->quota =3D=3D 0) {
> +		rkcanfd_write(priv, RK3576CANFD_REG_INT_MASK, priv->reg_int_mask_defau=
lt);
> +		return 0;
> +	}
> +
> +	rxdesc =3D dmaengine_prep_slave_single(priv->rxchan, priv->rx_dma_dst_a=
ddr,
> +					     priv->dma_size * priv->quota, DMA_DEV_TO_MEM, 0);
> +	if (!rxdesc)
> +		return -ENOMSG;
> +
> +	rxdesc->callback =3D rk3576_canfd_rx_dma_callback;
> +	rxdesc->callback_param =3D priv;
> +
> +	dmaengine_submit(rxdesc);

Please add error handling.

> +	dma_async_issue_pending(priv->rxchan);
> +	return 0;
> +}
> +
>  int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv)
>  {
>  	unsigned int len;
> @@ -399,6 +482,10 @@ int rkcanfd_handle_rk3576_rx_int(struct rkcanfd_priv=
 *priv)
>  	unsigned int len;
>  	int err;
> =20
> +	if (priv->use_dma) {
> +		rk3576_canfd_rx_dma(priv);
> +		return 0;

Please add error handling.

> +	}
>  	while ((len =3D rk3576canfd_rx_fifo_get_len(priv))) {
>  		err =3D rk3576canfd_handle_rx_int_one(priv);
>  		if (err)
> diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/=
rockchip/rockchip_canfd.h
> index 9b91d757d054..c7d6845c6d95 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd.h
> +++ b/drivers/net/can/rockchip/rockchip_canfd.h
> @@ -11,6 +11,8 @@
>  #include <linux/can/dev.h>
>  #include <linux/can/rx-offload.h>
>  #include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
>  #include <linux/io.h>
>  #include <linux/netdevice.h>
>  #include <linux/reset.h>
> @@ -737,6 +739,7 @@ struct rkcanfd_priv {
>  	struct can_priv can;
>  	struct can_rx_offload offload;
>  	struct net_device *ndev;
> +	struct device *dev;

It's not used in the hot path, please remove.

> =20
>  	void __iomem *regs;
>  	unsigned int tx_head;
> @@ -758,6 +761,14 @@ struct rkcanfd_priv {
>  	struct reset_control *reset;
>  	struct clk_bulk_data *clks;
>  	int clks_num;
> +	bool use_dma;
> +	u32 dma_size;
> +	u32 dma_thr;
> +	int quota;
> +	struct dma_chan *rxchan;
> +	u32 *rxbuf;
> +	dma_addr_t rx_dma_src_addr;
> +	dma_addr_t rx_dma_dst_addr;
>  };
> =20
>  static inline u32

I'll look at patch 3/4 later this week or next week.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--j7hntxwhinbwwsfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmg1mzcACgkQDHRl3/mQ
kZzOXAf/TYabUQyhdGNPjHw0LKOWksE2Xv+8bdz36Aoq9CdEH9daXwHjgAEf/y+f
m8a8tYtjpVgGfEefGOTZ5tf5mS1B0nPda71T8Iy7QGtWWFGKbkS6Eyfty7SyYZCs
mwtVPn3cXuQOOXjFreFNVRUy5fxbpS7NloKlE92dyV/xWZnEwERQluBr9KN9PEcL
KcRVt3dwMTP7V5xzhkdcD85kKdSR8+4WfPMhH2FWUfjdVq7PVDviNQBdArafNgAw
5Vuous8/ZRWl0GTX+YDL+vac+kZKNyR3A2a3cIR7Z4gngLpt2rtgJRz6ZldBz+8g
4HHrIZsM0pzGo4cDvu7n9urNwjZWpA==
=+uWm
-----END PGP SIGNATURE-----

--j7hntxwhinbwwsfs--

