Return-Path: <linux-can+bounces-7787-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uWq0OSBgKGqvCwMAu9opvQ
	(envelope-from <linux-can+bounces-7787-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 20:49:04 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F2E66368C
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 20:49:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LGUlxbM3;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7787-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7787-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2A6230158AA
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 18:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A72425783A;
	Tue,  9 Jun 2026 18:47:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B8726056C
	for <linux-can@vger.kernel.org>; Tue,  9 Jun 2026 18:47:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030867; cv=none; b=b+WhraNyGFKeAeIgw7inQH6ztfpNECT11oUTEWXRUpneU/EVFi/0AsfADgZgg5wDtPM1PiGXhSLED5uaPpGrQVAN+TrwL4JiWD9lGe9O+eFDsY8Mxz9AHq0sIPLBz5Fvt6mnX3Q5RyiQ7bzTOPafvu4uFzDlQJldXhBkejW9N7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030867; c=relaxed/simple;
	bh=hugn/8Uh/F9rAMVE8rNfAM9qjHjJ3GpvDibN8p3y2Qw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=leHXzUctr1JyKdC7chKpFeRGqdjVGPqKNNYR+WJBXrlc8WFhxMoiAEKVDSLXHpJEBJhaNL1FvxgCCqu+2TmHe0eD+u9E1WFCHeShF6S/iTtrVQMZh9T0r7I+7Hg0eezPSKNzbPmWLp4XWhnpxiAEOwiNg2V4m/fKZE61GlINBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGUlxbM3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C201F00893;
	Tue,  9 Jun 2026 18:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781030865;
	bh=UuOPvrhK+kjzqOlCJSP/lUc3KgccAFbz6ipySVVF5S4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LGUlxbM3k0X40B3hwTIyj+BmFo/Mwdtw9B117LXjLTsQ8d+Cd9HAH6eRohoHvUUie
	 jX/BO5wvJcVnHFqwkqxgX1JcSSO+C7OVIRjKZwNDfHRN6Mxahq4ESojHLCCLuydfUi
	 hZeH4o3fnTDUQdM3ufCk3e5Hwk4Nf/O+gRTQ5GuqkvY1dOJcqbd6J0LFV35D9jatZD
	 NEi3aBL/Iex4uXXO62N+PkyHGFHLb+0Hgste7J86OaNxhlSxPlNMGy52W3NJ4xI0Jy
	 tlrpjOMKIV035xuNbgCDs1HnWgyO+8tlTwA01E3lXSRykeww+sLL3/j2VYMzwEQI6x
	 tU3NHy7fZr8Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15] can: virtio: Add virtio CAN driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matias Ezequiel Vara Larsen" <mvaralar@redhat.com>
Cc: linux-can@vger.kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <ahXNb+KzuHYbS24+@fedora>
References: <ahXNb+KzuHYbS24+@fedora>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:47:45 +0000
Message-Id: <20260609184745.91C201F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7787-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mvaralar@redhat.com,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:socketcan@hartkopp.net,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66F2E66368C

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Virtqueue interrupts arriving while NAPI is disabled (e.g. before =
open, or during close/re-open) permanently disable virtqueue callbacks and =
stall the queues.
- [High] Unbounded `wait_for_completion` in `virtio_can_send_ctrl_msg` can =
deadlock the networking subsystem.
- [High] Lockless evaluation of TX flow control creates a TOCTOU race that =
can permanently stall the TX queue.
- [High] The `can_ctr_msg` struct and the elements of the `rpkt` array are =
not cacheline aligned, leading to critical DMA cacheline sharing and memory=
 corruption on architectures with non-coherent DMA.
- [High] Valid RTR (Remote Transmission Request) frames are incorrectly dro=
pped due to flawed payload length validation.
- [High] The driver incorrectly drops received packets when the controller =
is in the `CAN_STATE_ERROR_PASSIVE` state.
- [High] If the synthesized Bus-Off error SKB is dropped by the networking =
stack, the NAPI poll routine permanently loses the event and leaves the dev=
ice stuck.
- [Medium] Concurrent modification of global `dev->stats` from separate NAP=
I and Qdisc contexts leads to lost statistic increments.
- [Medium] TX byte statistics are not properly accounted because can_put_ec=
ho_skb() is called with a frame_len of 0.
- [Medium] Control message failures due to a broken virtqueue silently retu=
rn success, misleading the caller.
--

commit 43be0c71c5752e0d7687d30df7f568cb87caee83
Author: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>

can: virtio: Add virtio CAN driver

This commit adds a virtio CAN driver based on the Virtio 1.4 specification.
The driver implements a complete CAN bus interface over Virtio transport,
supporting both CAN Classic and CAN-FD.

> diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
> index 0000000000000..f67d0bf09681f
> --- /dev/null
> +++ b/drivers/net/can/virtio_can.c

[ ... ]

> +struct virtio_can_priv {
> +	struct can_priv can;	/* must be the first member */
> +	/* NAPI for RX messages */
> +	struct napi_struct napi;
> +	/* NAPI for TX messages */
> +	struct napi_struct napi_tx;
> +	/* The network device we're associated with */
> +	struct net_device *dev;
> +	/* The virtio device we're associated with */
> +	struct virtio_device *vdev;
> +	/* The virtqueues */
> +	struct virtqueue *vqs[VIRTIO_CAN_QUEUE_COUNT];
> +	/* Lock for TX operations */
> +	spinlock_t tx_lock;
> +	/* Control queue lock */
> +	struct mutex ctrl_lock;
> +	/* Wait for control queue processing without polling */
> +	struct completion ctrl_done;
> +	/* Array of receive queue messages */
> +	struct virtio_can_rx *rpkt;
> +	struct virtio_can_control can_ctr_msg;
> +	/* Data to get and maintain the putidx for local TX echo */

[Severity: High]
The can_ctr_msg struct and the elements of the rpkt array are not cacheline
aligned.

Since can_ctr_msg is embedded without cacheline alignment, it shares a CPU
cacheline with fields like tx_putidx_ida and tx_inflight. On non-coherent
architectures, the DMA unmap invalidation for the control response can
silently overwrite concurrent CPU updates to these fields.

Could this cause memory corruption during DMA mapping?

[ ... ]

> +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
> +{
> +	struct scatterlist sg_out, sg_in, *sgs[2] =3D { &sg_out, &sg_in };
> +	struct virtio_can_priv *priv =3D netdev_priv(ndev);
> +	struct virtqueue *vq =3D priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> +	struct device *dev =3D &priv->vdev->dev;
> +	unsigned int len;
> +	int err;
> +
> +	if (!vq)
> +		return VIRTIO_CAN_RESULT_NOT_OK;
> +
> +	guard(mutex)(&priv->ctrl_lock);
> +
> +	priv->can_ctr_msg.cpkt_out.msg_type =3D cpu_to_le16(msg_type);
> +	sg_init_one(&sg_out, &priv->can_ctr_msg.cpkt_out,
> +		    sizeof(priv->can_ctr_msg.cpkt_out));
> +	sg_init_one(&sg_in, &priv->can_ctr_msg.cpkt_in, sizeof(priv->can_ctr_ms=
g.cpkt_in));
> +
> +	reinit_completion(&priv->ctrl_done);
> +
> +	err =3D virtqueue_add_sgs(vq, sgs, 1u, 1u, priv, GFP_ATOMIC);
> +	if (err !=3D 0) {
> +		dev_err(dev, "%s(): virtqueue_add_sgs() failed\n", __func__);
> +		return VIRTIO_CAN_RESULT_NOT_OK;
> +	}
> +
> +	if (!virtqueue_kick(vq)) {
> +		dev_err(dev, "%s(): Kick failed\n", __func__);
> +		return VIRTIO_CAN_RESULT_NOT_OK;
> +	}
> +
> +	while (!virtqueue_get_buf(vq, &len) && !virtqueue_is_broken(vq))
> +		wait_for_completion(&priv->ctrl_done);
> +
> +	return priv->can_ctr_msg.cpkt_in.result;
> +}

[Severity: High]
This unbounded wait_for_completion() can deadlock if the device is removed
or becomes unresponsive.

Since the wait is indefinite and uninterruptible, the loop condition checki=
ng
virtqueue_is_broken(vq) is never re-evaluated while sleeping. This function
is called from ndo_open and ndo_stop with the global rtnl_lock held.

Could this freeze the networking subsystem if the hypervisor fails to respo=
nd?

[Severity: Medium]
If the virtqueue goes into a broken state, virtqueue_is_broken(vq) evaluates
to true, which breaks the wait loop. However, the function then uncondition=
ally
returns the possibly stale cpkt_in.result since virtqueue_get_buf never
successfully retrieved the new buffer.

Does this cause callers to erroneously assume the operation succeeded when
it actually failed?

[ ... ]

> +static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
> +					 struct net_device *dev)
> +{

[ ... ]

> +	/* Push loopback echo. Will be looped back on TX interrupt/TX NAPI */
> +	err =3D can_put_echo_skb(skb, dev, can_tx_msg->putidx, 0);

[Severity: Medium]
The frame_len parameter is hardcoded to 0 here.

When the TX packet is successfully acknowledged, virtio_can_read_tx_queue()
will increment stats->tx_bytes by the return value of can_get_echo_skb().
Since 0 was stored, the returned length is 0, and tx_bytes is never
incremented.

Should this use can_skb_get_frame_len(skb) to track TX bytes correctly?

[ ... ]

> +	/* Normal flow control: stop queue when no transmission slots left */
> +	if (atomic_read(&priv->tx_inflight) >=3D priv->can.echo_skb_max ||
> +	    vq->num_free =3D=3D 0 || (vq->num_free < ARRAY_SIZE(sgs) &&
> +	    !virtio_has_feature(vq->vdev, VIRTIO_RING_F_INDIRECT_DESC))) {
> +		netif_stop_queue(dev);
> +		netdev_dbg(dev, "TX: Normal stop queue\n");
> +	}

[Severity: High]
This flow control evaluation and netif_stop_queue() are performed outside
of the priv->tx_lock critical section.

If the CPU executing xmit evaluates the condition as true but gets preempted
before executing netif_stop_queue(), the device might process the packet
and trigger a TX interrupt. The NAPI polling function will run, evaluate
netif_queue_stopped(dev) as false, and do nothing to wake the queue. When
this thread resumes, it will execute netif_stop_queue(), leaving the queue
stopped permanently.

Does this create a TOCTOU race that stalls the TX queue?

[ ... ]

> +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> +{

[ ... ]

> +	if (can_priv->can.state < CAN_STATE_BUS_OFF) {
> +		if (result !=3D VIRTIO_CAN_RESULT_OK) {

[ ... ]

> +		} else {
> +			stats->tx_bytes +=3D can_get_echo_skb(dev, can_tx_msg->putidx,
> +				NULL);
> +			stats->tx_packets++;
> +		}

[Severity: Medium]
This function modifies the global dev->stats structure without holding a
common lock or using atomics. This pattern is also present in
virtio_can_read_rx_queue() for rx_packets.

The driver initializes independent NAPI instances for RX and TX, and
virtio_can_start_xmit() runs in Qdisc context. Concurrent read-modify-write
operations on dev->stats from these contexts will lead to torn or lost
updates.

Should this use per-CPU stats or u64_stats_sync to safely track statistics?

[ ... ]

> +static int virtio_can_read_rx_queue(struct virtqueue *vq)
> +{

[ ... ]

> +	if (priv->can.state >=3D CAN_STATE_ERROR_PASSIVE) {
> +		netdev_dbg(dev, "%s(): Controller not active\n", __func__);
> +		goto putback;
> +	}

[Severity: High]
This check drops incoming frames when the controller is in the
CAN_STATE_ERROR_PASSIVE state.

In the CAN protocol, a node in the Error Passive state is fully operational
and must continue to receive and transmit frames.

Should this check be >=3D CAN_STATE_BUS_OFF instead to avoid breaking bus
functionality in degraded environments?

[ ... ]

> +	if (transport_len < header_size + len) {
> +		netdev_warn(dev, "RX: Message too small for payload\n");
> +		goto putback;
> +	}

[Severity: High]
This length validation incorrectly enforces the presence of a payload for
RTR frames.

For CAN RTR frames, the len variable represents the requested Data Length
Code, but the frame contains no actual payload. If the device strictly adhe=
res
to the protocol and transmits only the header for RTR frames, transport_len
will equal header_size, and this check will drop valid frames.

Can this be updated to handle RTR frames correctly?

[ ... ]

> +static int virtio_can_handle_busoff(struct net_device *dev)
> +{

[ ... ]

> +	/* Ensure that the BusOff indication does not get lost */
> +	if (netif_receive_skb(skb) =3D=3D NET_RX_SUCCESS)
> +		priv->busoff_pending =3D false;
> +
> +	return 1;
> +}

[Severity: High]
If the synthesized Bus-Off error SKB is dropped by the networking stack (e.=
g.
returning NET_RX_DROP), the busoff_pending flag fails to clear.

The function returns 1, allowing the NAPI poll loop to eventually complete
and sleep. Because the physical device is now in a Bus-Off state, it will
never generate another RX or configuration interrupt, leaving the driver
permanently stuck with busoff_pending =3D true.

Will the NAPI loop fail to retry the failed event, permanently blinding the
system to the hardware failure?

[ ... ]

> +static void virtio_can_rx_intr(struct virtqueue *vq)
> +{
> +	struct virtio_can_priv *can_priv =3D vq->vdev->priv;
> +
> +	virtqueue_disable_cb(vq);
> +	napi_schedule(&can_priv->napi);
> +}

[Severity: High]
This disables the virtqueue callback and schedules NAPI.

If an interrupt fires while NAPI is disabled (e.g., before virtio_can_open
enables it, or after close), napi_schedule() is a no-op and silently drops
the wakeup. When NAPI is eventually enabled, it is not scheduled, and the
virtqueue callbacks are never re-enabled.

Can this permanently stall the virtqueues if an interrupt arrives at the
wrong time?

[ ... ]

> +static int virtio_can_probe(struct virtio_device *vdev)
> +{

[ ... ]

> +	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD))
> +		priv->rpkt_len +=3D CANFD_MAX_DLEN;
> +	else
> +		priv->rpkt_len +=3D CAN_MAX_DLEN;

[Severity: High]
This calculates rpkt_len dynamically without aligning to cacheline boundari=
es.

When virtqueue_add_inbuf() maps these unaligned chunks for DMA, they will
overlap cachelines. On non-coherent architectures, this violates the DMA
API.

Could this cause memory corruption during receive operations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ahXNb+KzuHYbS24+@fe=
dora?part=3D1

