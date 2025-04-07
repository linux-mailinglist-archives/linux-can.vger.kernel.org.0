Return-Path: <linux-can+bounces-3369-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D9BA7E386
	for <lists+linux-can@lfdr.de>; Mon,  7 Apr 2025 17:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09C237A8888
	for <lists+linux-can@lfdr.de>; Mon,  7 Apr 2025 15:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A331F4E4B;
	Mon,  7 Apr 2025 15:04:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5111F63DD
	for <linux-can@vger.kernel.org>; Mon,  7 Apr 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038251; cv=none; b=SKM94vq8yfqi1PexXa3SQFhFs4oQRH8SigIhz9T+9UdCpaJ7Zcn1zx5WtbObHzjye3w+pRZ98BDKLB58ldZF5JlWw7X9GKFHlaiDoRbquyxSdP0K8QlFsnSjbyg2XtNR0KNolwzhTeCJmYeC6VvtCbSY24YDh/gSnEb8ychXjb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038251; c=relaxed/simple;
	bh=LvKk0Jxtqgf9ItwGff5IE8gGwedxdn9+ImONCKUGdfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYaKg5zN62EGeEYMIlvIoDdc3BhaVZu5aOYkt+Pa0iKFXNVbqS0Ku0qQRKAT3XBKNMmGADfmKbjyBTa62Nvc0bHu8sAYNYPa75mJgKcaQodv/0hXzAtKva9pB26LWiUkpibmqtmCA9iKIzFzlKin2BPUP3xf+4iYtcXuuaV2h0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1u1o16-0008Oj-Es; Mon, 07 Apr 2025 17:04:04 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1u1o15-003mLP-3C;
	Mon, 07 Apr 2025 17:04:04 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9E95C3F2147;
	Mon, 07 Apr 2025 15:04:03 +0000 (UTC)
Date: Mon, 7 Apr 2025 17:04:02 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Axel Forsman <axfo@kvaser.com>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	stable@vger.kernel.org, Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH 2/3] can: kvaser_pciefd: Fix echo_skb race conditions
Message-ID: <20250407-vanilla-lyrebird-of-leadership-5d0c72-mkl@pengutronix.de>
References: <20250331072528.137304-1-axfo@kvaser.com>
 <20250331072528.137304-3-axfo@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e2cqmecn4lasb2wb"
Content-Disposition: inline
In-Reply-To: <20250331072528.137304-3-axfo@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--e2cqmecn4lasb2wb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] can: kvaser_pciefd: Fix echo_skb race conditions
MIME-Version: 1.0

On 31.03.2025 09:25:27, Axel Forsman wrote:
> The functions kvaser_pciefd_start_xmit() and
> kvaser_pciefd_handle_ack_packet() raced to stop/wake TX queues and
> get/put echo skbs, as kvaser_pciefd_can->echo_lock was only ever taken
> when transmitting. E.g., this caused the following error:
>=20
>     can_put_echo_skb: BUG! echo_skb 5 is occupied!
>=20
> Instead, use the synchronization helpers in netdev_queues.h. As those
> piggyback on BQL barriers, start updating in-flight packets and bytes
> counts as well.

This looks like it does in the right direction. Using the
netif_subqueue_completed helpers is a great idea.

What usually works even better is to have 2 counters and a mask:
- unsigned int tx_head, tx_tail
- TXFIFO_DEPTH

The tx_head is incremented in the xmit function, tail is incremented in
the tx_done function.

There's no need to check how many buffers are free in the HW.

Have a look at the rockchip-canfd driver for an example.

Some comments inline.

> Cc: stable@vger.kernel.org
> Signed-off-by: Axel Forsman <axfo@kvaser.com>
> Tested-by: Jimmy Assarsson <extja@kvaser.com>
> Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  drivers/net/can/kvaser_pciefd.c | 70 ++++++++++++++++++++++-----------
>  1 file changed, 48 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pci=
efd.c
> index 0d1b895509c3..6251a1ddfa7e 100644
> --- a/drivers/net/can/kvaser_pciefd.c
> +++ b/drivers/net/can/kvaser_pciefd.c
> @@ -16,6 +16,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
>  #include <linux/timer.h>
> +#include <net/netdev_queues.h>
> =20
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_AUTHOR("Kvaser AB <support@kvaser.com>");
> @@ -412,8 +413,9 @@ struct kvaser_pciefd_can {
>  	u8 cmd_seq;
>  	int err_rep_cnt;
>  	int echo_idx;
> +	unsigned int completed_tx_pkts;
> +	unsigned int completed_tx_bytes;
>  	spinlock_t lock; /* Locks sensitive registers (e.g. MODE) */
> -	spinlock_t echo_lock; /* Locks the message echo buffer */
>  	struct timer_list bec_poll_timer;
>  	struct completion start_comp, flush_comp;
>  };
> @@ -745,11 +747,24 @@ static int kvaser_pciefd_stop(struct net_device *ne=
tdev)
>  		del_timer(&can->bec_poll_timer);
>  	}
>  	can->can.state =3D CAN_STATE_STOPPED;
> +	netdev_reset_queue(netdev);
>  	close_candev(netdev);
> =20
>  	return ret;
>  }
> =20
> +static unsigned int kvaser_pciefd_tx_avail(struct kvaser_pciefd_can *can)
> +{
> +	u8 count =3D FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
> +		ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
> +
> +	if (count < can->can.echo_skb_max) /* Free TX FIFO slot? */
> +		/* Avoid reusing unacked seqno */
> +		return !can->can.echo_skb[can->echo_idx];
> +	else
> +		return 0;
> +}
> +
>  static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packe=
t *p,
>  					   struct kvaser_pciefd_can *can,
>  					   struct sk_buff *skb)
> @@ -797,23 +812,31 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct =
sk_buff *skb,
>  					    struct net_device *netdev)
>  {
>  	struct kvaser_pciefd_can *can =3D netdev_priv(netdev);
> -	unsigned long irq_flags;
>  	struct kvaser_pciefd_tx_packet packet;
> +	unsigned int frame_len =3D 0;
>  	int nr_words;
> -	u8 count;
> =20
>  	if (can_dev_dropped_skb(netdev, skb))
>  		return NETDEV_TX_OK;
> =20
> +	/*
> +	 * Without room for a new message, stop the queue until at least
> +	 * one successful transmit.
> +	 */
> +	if (!netif_subqueue_maybe_stop(netdev, 0, kvaser_pciefd_tx_avail(can), =
1, 1))
> +		return NETDEV_TX_BUSY;

Returning NETDEV_TX_BUSY is quite expensive, stop the queue at the end
of this function, if the buffers are full.

> +
>  	nr_words =3D kvaser_pciefd_prepare_tx_packet(&packet, can, skb);
> =20
> -	spin_lock_irqsave(&can->echo_lock, irq_flags);
>  	/* Prepare and save echo skb in internal slot */
> -	can_put_echo_skb(skb, netdev, can->echo_idx, 0);
> +	frame_len =3D can_skb_get_frame_len(skb);
> +	can_put_echo_skb(skb, netdev, can->echo_idx, frame_len);
> =20
>  	/* Move echo index to the next slot */
>  	can->echo_idx =3D (can->echo_idx + 1) % can->can.echo_skb_max;
> =20
> +	netdev_sent_queue(netdev, frame_len);
> +
>  	/* Write header to fifo */
>  	iowrite32(packet.header[0],
>  		  can->reg_base + KVASER_PCIEFD_KCAN_FIFO_REG);
> @@ -836,15 +859,6 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct s=
k_buff *skb,
>  			     KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
>  	}
> =20
> -	count =3D FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
> -			  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
> -	/* No room for a new message, stop the queue until at least one
> -	 * successful transmit
> -	 */
> -	if (count >=3D can->can.echo_skb_max || can->can.echo_skb[can->echo_idx=
])
> -		netif_stop_queue(netdev);
> -	spin_unlock_irqrestore(&can->echo_lock, irq_flags);
> -
>  	return NETDEV_TX_OK;
>  }
> =20
> @@ -970,6 +984,8 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvase=
r_pciefd *pcie)
>  		can->kv_pcie =3D pcie;
>  		can->cmd_seq =3D 0;
>  		can->err_rep_cnt =3D 0;
> +		can->completed_tx_pkts =3D 0;
> +		can->completed_tx_bytes =3D 0;
>  		can->bec.txerr =3D 0;
>  		can->bec.rxerr =3D 0;
> =20
> @@ -987,7 +1003,6 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvas=
er_pciefd *pcie)
>  		can->can.clock.freq =3D pcie->freq;
>  		can->can.echo_skb_max =3D min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_pa=
ckets_max - 1);
>  		can->echo_idx =3D 0;
> -		spin_lock_init(&can->echo_lock);
>  		spin_lock_init(&can->lock);
> =20
>  		can->can.bittiming_const =3D &kvaser_pciefd_bittiming_const;
> @@ -1510,19 +1525,16 @@ static int kvaser_pciefd_handle_ack_packet(struct=
 kvaser_pciefd *pcie,
>  		netdev_dbg(can->can.dev, "Packet was flushed\n");
>  	} else {
>  		int echo_idx =3D FIELD_GET(KVASER_PCIEFD_PACKET_SEQ_MASK, p->header[0]=
);
> -		int len;
> -		u8 count;
> +		unsigned int len, frame_len =3D 0;
>  		struct sk_buff *skb;
> =20
>  		skb =3D can->can.echo_skb[echo_idx];
>  		if (skb)
>  			kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
> -		len =3D can_get_echo_skb(can->can.dev, echo_idx, NULL);
> -		count =3D FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
> -				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
> +		len =3D can_get_echo_skb(can->can.dev, echo_idx, &frame_len);
> =20
> -		if (count < can->can.echo_skb_max && netif_queue_stopped(can->can.dev))
> -			netif_wake_queue(can->can.dev);
> +		can->completed_tx_pkts++;
> +		can->completed_tx_bytes +=3D frame_len;
> =20
>  		if (!one_shot_fail) {
>  			can->can.dev->stats.tx_bytes +=3D len;
> @@ -1638,11 +1650,25 @@ static int kvaser_pciefd_read_buffer(struct kvase=
r_pciefd *pcie, int dma_buf)
>  {
>  	int pos =3D 0;
>  	int res =3D 0;
> +	unsigned int i;
> =20
>  	do {
>  		res =3D kvaser_pciefd_read_packet(pcie, &pos, dma_buf);
>  	} while (!res && pos > 0 && pos < KVASER_PCIEFD_DMA_SIZE);
> =20
> +	for (i =3D 0; i < pcie->nr_channels; ++i) {
> +		struct kvaser_pciefd_can *can =3D pcie->can[i];
> +
> +		if (!can->completed_tx_pkts)
> +			continue;
> +		netif_subqueue_completed_wake(can->can.dev, 0,
> +					      can->completed_tx_pkts,
> +					      can->completed_tx_bytes,
> +					      kvaser_pciefd_tx_avail(can), 1);

You can do this as soon as as one packet is finished, if you want to
avoid too frequent wakeups, use threshold of more than 1.

Marc

> +		can->completed_tx_pkts =3D 0;
> +		can->completed_tx_bytes =3D 0;
> +	}
> +
>  	return res;
>  }
> =20
> --=20
> 2.47.2
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--e2cqmecn4lasb2wb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfz6V8ACgkQDHRl3/mQ
kZzAlQf/XX5PamxBM6LWFMcbLgbRPyWiHwY8yikJW7uRtFVNdGCcdQ8CHqCm1UZK
QBzzEot4gM+s1aK3pa/SQwwBUCdn3kPwoeK5w08mUOYgJyGnPI95q66vjSERnjrI
yiQ3sH+jB1c/GYsRrB5mh+GSK/ab7E2Ba5IjCyvhu4r3VRUp01ErHoNaklmtpnoR
zEj1iiRCpq94TXx8MwfptH3zKQBdIPzcU9LsPasj65iooeBwk0PMKKEvVBcFe13v
VCfl94DPfkeoVewCQY0me0GiIFk4jFTXRyRGb6oDnar3RIDccV0FU3PdG6SFYG57
uFnjzg2cB/+6vLRH59kg4q9aDreQaw==
=xWz3
-----END PGP SIGNATURE-----

--e2cqmecn4lasb2wb--

