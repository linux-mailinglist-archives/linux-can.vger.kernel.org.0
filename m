Return-Path: <linux-can+bounces-6664-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GOCCDhopWmx+wUAu9opvQ
	(envelope-from <linux-can+bounces-6664-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 11:36:40 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB331D6A47
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 11:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 287FC30094D8
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ABD318ED2;
	Mon,  2 Mar 2026 10:31:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FB72E92D2
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447472; cv=none; b=m7UImj/v9BJjLlBQYqBmOOoZihvNtmdT+wOxoNb3ZKtQIUBAYTH4gxGJhXm4GcY2cEI4upxzuhPpp1gw8sW1HYdGjo6jN6x1FZllGN7cr7VvG3QjD+VnQOdJgkhEtgXH9wjN4mVHllKLWoT0PUFeR1bmLtp1WY0mhN5NYPTD02o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447472; c=relaxed/simple;
	bh=qaBmA7uDnoVSe3freHiGPaE9bjj5uIDf5KhUCrnEqIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFonOgZaDsXrC8ig6/LI5eks3egb01ENF95oi2A4Vkwrix4RQ1k05nQb6x1Hr6FWaSiegr4lJWxRTXcnOX+UVyVBDLSBi7MqVNWFi0BeFOYx8ZI5bkTXvGZHagsklhAt/lzizRfgt6oWgqOGLjx40diZMr67AEf3g7d7AWWwhkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx0Xs-0004II-0q; Mon, 02 Mar 2026 11:30:36 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx0Xp-003Mbd-1Q;
	Mon, 02 Mar 2026 11:30:34 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6CAA54F5086;
	Mon, 02 Mar 2026 10:30:34 +0000 (UTC)
Date: Mon, 2 Mar 2026 11:30:34 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Harald Mommer <harald.mommer@oss.qualcomm.com>, 
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-can@vger.kernel.org, virtualization@lists.linux.dev, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, francesco@valla.it
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
Message-ID: <20260302-mighty-wondrous-seagull-75085c-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <aZRB7Reu/D6HvRcb@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ngzzyx3mmxaqkupc"
Content-Disposition: inline
In-Reply-To: <aZRB7Reu/D6HvRcb@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6664-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.843];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AB331D6A47
X-Rspamd-Action: no action


--ngzzyx3mmxaqkupc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
MIME-Version: 1.0

The nipa/ai-review bot found these problems:

| https://netdev-ai.bots.linux.dev/ai-review.html?id=3De2753951-0455-4ce7-a=
d95-3da80456b40e

commit bab72ffd354779765bf84bc17cc185e0662d3717
Author: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>

can: virtio: Add virtio CAN driver

This commit adds a new virtio CAN driver implementing a complete CAN bus
interface over Virtio transport, supporting both CAN Classic and CAN-FD
frames.

> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index e15e320db476..ec941f3c25f6 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -234,6 +234,18 @@ config CAN_XILINXCAN
>  	  Xilinx CAN driver. This driver supports both soft AXI CAN IP and
>  	  Zynq CANPS IP.
>
> +config CAN_VIRTIO_CAN
> +	depends on VIRTIO
> +	tristate "Virtio CAN device support"

The CAN_VIRTIO_CAN config entry is placed after CAN_XILINXCAN, breaking
the alphabetical ordering maintained by all other config entries in this
file. Since V comes before X alphabetically, should CAN_VIRTIO_CAN be
placed between CAN_TI_HECC and CAN_XILINXCAN? The Makefile entry is
correctly ordered (virtio_can.o appears before xilinx_can.o), which makes
this inconsistency more evident.

> +	default n
> +	help
> +	  Say Y here if you want to support for Virtio CAN.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called virtio-can.
> +
> +	  If unsure, say N.
> +

[ ... ]

> diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
> new file mode 100644
> index 000000000000..8d60336b3ebe
> --- /dev/null
> +++ b/drivers/net/can/virtio_can.c
> @@ -0,0 +1,934 @@

[ ... ]

> +static int virtio_can_alloc_tx_idx(struct virtio_can_priv *priv)
> +{
> +	int tx_idx;
> +
> +	tx_idx =3D ida_alloc_max(&priv->tx_putidx_ida,
> +			 priv->can.echo_skb_max - 1, GFP_KERNEL);

Is GFP_KERNEL safe here? This function is called from
virtio_can_start_xmit(), which is the ndo_start_xmit callback. This
callback can be invoked from softirq context with BH disabled, where
sleeping is not allowed. Should this use GFP_ATOMIC to match the calling
context?

> +	if (tx_idx >=3D 0)
> +		atomic_inc(&priv->tx_inflight);
> +
> +	return tx_idx;
> +}

[ ... ]

> +static int virtio_can_open(struct net_device *ndev)
> +{
> +	virtio_can_start(ndev);
> +
> +	netif_start_queue(ndev);
> +
> +	return 0;
> +}

Is open_candev() missing? The CAN framework requires drivers to call
open_candev() in their ndo_open handler. open_candev() validates that
bittiming has been configured (returns -EINVAL if bitrate is 0), checks
CAN FD data bitrate requirements, and manages carrier state. Without this
call, can the device be brought up without configuring bitrate? The driver
does call close_candev() in virtio_can_close(), showing awareness of the
CAN lifecycle. Every other CAN driver in the kernel calls open_candev() in
its open function.

[ ... ]

> +static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
> +					 struct net_device *dev)
> +{

[ ... ]

> +	can_tx_msg =3D kzalloc(sizeof(*can_tx_msg) + cf->len, GFP_ATOMIC);
> +	if (!can_tx_msg) {
> +		dev->stats.tx_dropped++;
> +		goto kick; /* No way to return NET_XMIT_DROP here */
> +	}

Does this leak the skb? When can_dev_dropped_skb() returns false (valid
frame, skb not consumed) and kzalloc() for can_tx_msg fails, the code
jumps to 'kick' without freeing the skb. The skb is still owned by the
caller at this point. Should kfree_skb(skb) be called before goto kick?

> +
> +	can_tx_msg->tx_out.msg_type =3D cpu_to_le16(VIRTIO_CAN_TX);
> +	can_flags =3D 0;

[ ... ]

> +	putidx =3D virtio_can_alloc_tx_idx(priv);
> +
> +	if (unlikely(putidx < 0)) {
> +		/* -ENOMEM or -ENOSPC here. -ENOSPC should not be possible as
> +		 * tx_inflight >=3D can.echo_skb_max is checked in flow control
> +		 */
> +		WARN_ON_ONCE(putidx =3D=3D -ENOSPC);
> +		kfree(can_tx_msg);
> +		dev->stats.tx_dropped++;
> +		goto kick; /* No way to return NET_XMIT_DROP here */
> +	}

Does this also leak the skb? When ida_alloc_max() returns -ENOMEM,
can_tx_msg is correctly freed but the skb is not. can_put_echo_skb() has
not been called yet at this point, so the skb is still owned by
virtio_can_start_xmit. Should kfree_skb(skb) be called before goto kick?

> +
> +	can_tx_msg->putidx =3D (unsigned int)putidx;
> +
> +	/* Push loopback echo. Will be looped back on TX interrupt/TX NAPI */
> +	can_put_echo_skb(skb, dev, can_tx_msg->putidx, 0);

[ ... ]

> +static void virtio_can_populate_rx_vq(struct virtio_device *vdev)
> +{
> +	struct virtio_can_priv *priv =3D vdev->priv;
> +	struct virtqueue *vq =3D priv->vqs[VIRTIO_CAN_QUEUE_RX];
> +	struct virtio_can_rx *buf =3D priv->rpkt;
> +	unsigned int buf_size =3D priv->rpkt_len;
> +	int num_elements =3D vq->num_free;
> +	unsigned int idx;
> +	int ret;
> +
> +	for (idx =3D 0; idx < num_elements; idx++) {
> +		ret =3D virtio_can_add_inbuf(vq, buf, buf_size);
> +		if (ret < 0) {
> +			dev_dbg(&vdev->dev, "rpkt fill: ret=3D%d, idx=3D%u, size=3D%u\n",
> +				ret, idx, buf_size);
> +			break;
> +		}
> +		buf +=3D buf_size;
> +	}

Does this cause an out-of-bounds memory access? 'buf' is declared as
'struct virtio_can_rx *' and 'buf_size' equals 'priv->rpkt_len'
(sizeof(struct virtio_can_rx) + CAN[FD]_MAX_DLEN). The expression
'buf +=3D buf_size' advances by buf_size * sizeof(struct virtio_can_rx)
bytes instead of the intended buf_size bytes, because C pointer arithmetic
scales by the pointed-to type size.

For CAN classic (rpkt_len=3D24, sizeof(struct virtio_can_rx)=3D16), this
advances 384 bytes per iteration instead of 24. The allocation in
virtio_can_probe only provides rpkt_len bytes per element, so doesn't the
second and all subsequent loop iterations pass out-of-bounds pointers to
the virtqueue as RX buffers? When the device writes to these buffers, can
this corrupt adjacent kernel memory?

virtio_can_probe():
    priv->rpkt =3D devm_kzalloc(&vdev->dev, priv->rpkt_len *
                                priv->vqs[VIRTIO_CAN_QUEUE_RX]->num_free,
                                GFP_KERNEL);

Should a 'char *' or 'u8 *' pointer be used for the byte-level iteration
instead, e.g. 'u8 *p =3D (u8 *)priv->rpkt; ... p +=3D buf_size;' and pass '=
p'
to virtio_can_add_inbuf?

> +
> +	if (!ret)

Does this use an uninitialized variable? The variable 'ret' is declared as
'int ret;' without initialization. If vq->num_free equals 0, the for loop
body never executes, and 'ret' is read uninitialized here. Should this be
initialized to 0?

> +		virtqueue_kick(vq);
> +
> +	dev_dbg(&vdev->dev, "%u rpkt added\n", idx);
> +}

[ ... ]

> +/* Function must not be called before virtio_can_find_vqs() has been run=
 */
> +static void virtio_can_del_vq(struct virtio_device *vdev)
> +{
> +	struct virtio_can_priv *priv =3D vdev->priv;
> +	int q;
> +
> +	/* Reset the device */
> +	if (vdev->config->reset)
> +		vdev->config->reset(vdev);

Should this use virtio_reset_device() instead? When
CONFIG_VIRTIO_HARDEN_NOTIFICATION is enabled, virtio_reset_device() calls
virtio_break_device() to mark all virtqueues as broken and
virtio_synchronize_cbs() to wait for in-flight callbacks to complete
before performing the actual reset. Calling config->reset directly skips
these hardening steps, meaning virtqueue callbacks may still be executing
when del_vqs destroys the queues. All other virtio network drivers
(virtio_net.c, caif_virtio.c, mac80211_hwsim.c) use virtio_reset_device().
The NULL check is also unnecessary as this op is always present in virtio
devices.

> +
> +	/* From here we have dead silence from the device side so no locks
> +	 * are needed to protect against device side events.
> +	 */
> +
> +	for (q =3D 0; q < VIRTIO_CAN_QUEUE_COUNT; q++)
> +		while (virtqueue_detach_unused_buf(priv->vqs[q]))
> +			;
> +
> +	if (vdev->config->del_vqs)
> +		vdev->config->del_vqs(vdev);
> +}
> +
> +static void virtio_can_remove(struct virtio_device *vdev)
> +{
> +	struct virtio_can_priv *priv =3D vdev->priv;
> +	struct net_device *dev =3D priv->dev;
> +
> +	unregister_candev(dev);
> +
> +	virtio_can_del_vq(vdev);

Are napi_disable() calls missing here? The probe function enables both NAPI
instances:

virtio_can_probe():
    napi_enable(&priv->napi);
    napi_enable(&priv->napi_tx);

And virtio_can_freeze() correctly disables them:

virtio_can_freeze():
    napi_disable(&priv->napi);
    napi_disable(&priv->napi_tx);

But virtio_can_remove() never disables NAPI. The ndo_stop callback
(virtio_can_close) intentionally leaves NAPI active per its comment.
Can the NAPI poll callbacks (virtio_can_rx_poll, virtio_can_tx_poll)
execute concurrently with virtio_can_del_vq() deleting virtqueues and
virtio_can_free_candev() freeing the net_device? Should napi_disable() be
called for both instances before unregister_candev()?

> +
> +	virtio_can_free_candev(dev);
> +}

[ ... ]
--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ngzzyx3mmxaqkupc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaaVmxwAKCRDMOmT6rpmt
0rmiAP4x0A2XuA4cUy5pOygQM0TfZdeawi9jFWxLp+yn93gISgD+Mt/kZ7s0qbw8
WsjBdHFiNCiPCexi+t/dg5v62AX/AQQ=
=JBHm
-----END PGP SIGNATURE-----

--ngzzyx3mmxaqkupc--

