Return-Path: <linux-can+bounces-7966-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kGtMDKF8RmrJXAsAu9opvQ
	(envelope-from <linux-can+bounces-7966-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 16:58:41 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AE76F920B
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 16:58:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eKLEjSmd;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7966-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7966-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67ADD30781A6
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 14:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D237A845;
	Thu,  2 Jul 2026 14:48:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE337A84F
	for <linux-can@vger.kernel.org>; Thu,  2 Jul 2026 14:48:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003689; cv=none; b=NnWgIajBlIiRpbbRiWPL6RW0KTuBtrbhU+rBOZFnN2FPyN5bsoIWekaZW1n03NKKsQwI2UTQ+3nPU7aFUojmy1xyS0GKhGfCad5qRt27JYJxrc9UN5VDm1B1HUltVLo3vzHGVAzn9lFC2SJt3jjT1j0JvQoUiQ8XtEDmEL7Cw3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003689; c=relaxed/simple;
	bh=H50YfeRjvc3Bz4zpJ4EiyjPbddUq2rBXA3KxliHchbo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S4fzuv6Fza4iMXeh3W6b8+8kM7r2os1V1ZwusW3EAtzyv9RpixvYEVrRjJ088kZxtDQMIShmpljJ8aNKlZ0CDhNPShL9vqyD8ZcVwNxuZRjyDnAdIde9O96AKzlvGo0hoICjNUaK8Rj5lWm98/rzaqkpdvGYFKBxjKoyRjxwvXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKLEjSmd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF901F00A3A;
	Thu,  2 Jul 2026 14:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783003687;
	bh=UmGbOwIWjYZ0sLX/OHrkp4tS5I7h7/wHUnGEmIDohs0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eKLEjSmdRoTfqOdeSm3dcXfbRChD/tYjWkEaN15uNrgvUK2UPozGX6Wx3mBzE7S3l
	 nQNimXHPXj2NhrEV5SmJsRIUBcq6UFu6DdBV5QKgdPvYtIctWGH5fVzqvFmFwOW3Yk
	 SWT7R3/7ElRnOKEZlONa3p2RX7NDYYVhoDDP13FZEqg+7hDR1a15PqSxH3Z/z7z3VE
	 65plO/Ig2phzbKlrXmqK9GiGXrfVQsololhI1nQUBmbW/n8B276IGRzON15IcTf1CJ
	 hFo6fNQ1QjWfh6W0YiF+Yq+EPQshH9mLKiLfA3hEYNfAaLycpn+UT8z01AX+ozHnZf
	 mIo3IFEAATQag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] net: can: mpfs_can: add Polarfire SoC MSS CAN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Conor Dooley" <conor@kernel.org>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260702-lens-constrict-6dc7d287c647@spud>
References: <20260702-lens-constrict-6dc7d287c647@spud>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 14:48:06 +0000
Message-Id: <20260702144806.DAF901F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7966-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lists.linux.dev:replyto,microchip.com:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:conor@kernel.org,m:mkl@pengutronix.de,m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5AE76F920B

Thank you for your contribution! Sashiko AI review found 16 potential issue=
(s) to consider:
- [High] TX completion handler blindly echoes frames in FIFO order without =
checking hardware buffer status.
- [High] Infinite loop in NAPI RX poll upon SKB allocation failure (Hard CP=
U lockup).
- [High] Unvalidated DLC leads to invalid CAN frame length and out-of-bound=
s memory reads.
- [High] Clock resources and memory are leaked on probe error paths and on =
device removal.
- [High] request_irq called before napi_enable introduces a potential kerne=
l crash.
- [High] Probe error handling returns success for 0 or 1 clocks, leading to=
 Use-After-Free on removal.
- [High] `brp_min =3D 0` in bit timing constants is mathematically invalid =
and causes divide-by-zero kernel panics.
- [High] NULL pointer dereference in `mpfs_can_set_error_state()` if `alloc=
_can_err_skb()` fails.
- [High] `mpfs_can_set_error_state()` mishandles `CAN_STATE_BUS_OFF` and fa=
ils to update software state.
- [High] Unprotected concurrent modifications of CAN state and network stat=
istics across softirq and hardirq contexts.
- [Medium] Unconditional `netif_stop_queue()` in `mpfs_can_start_xmit()` re=
duces the TX queue depth to 1.
- [Medium] Failure to clear pending interrupts in device start due to W1C m=
isuse.
- [Medium] Permanent disablement of RTR interrupts.
- [Medium] Unchecked `platform_get_irq()` breaks deferred probing.
- [Medium] Fragile reliance on clock array index from clk_bulk_get_all.
- [Medium] Failure to flush echo SKBs during bus-off recovery causes memory=
 leaks.
--

commit 57e6dc05d07385bee78a46cd8d38b75b30a88ebe
Author: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Subject: net: can: mpfs_can: add Polarfire SoC MSS CAN

The Microchip Polarfire SoC has two instances of CAN devices inside the MSS
block. Add driver to support this MSS CAN.

> diff --git a/drivers/net/can/mpfs_can.c b/drivers/net/can/mpfs_can.c
> new file mode 100644
> index 0000000000000..3a82726492ec6
> --- /dev/null
> +++ b/drivers/net/can/mpfs_can.c
> @@ -0,0 +1,882 @@

[ ... ]

> +static const struct can_bittiming_const mpfs_can_bittiming_const =3D {
> +	.name =3D "mpfs_can",
> +	.tseg1_min =3D 2,
> +	.tseg1_max =3D 16,
> +	.tseg2_min =3D 1,
> +	.tseg2_max =3D 8,
> +	.sjw_max =3D 4,
> +	.brp_min =3D 0,

[Severity: High]
Is it intentional to set brp_min to 0? The hardware prescaler represents
division, and allowing brp_min =3D 0 can cause the core CAN bit timing
calculator (can_calc_bittiming) to start its calculation loop with brp =3D =
0,
which would lead to an immediate divide-by-zero kernel exception.

> +	.brp_max =3D 32767,
> +	.brp_inc =3D 1,
> +};
> +
> +static int mpfs_can_reset(struct net_device *ndev)
> +{
> +	struct mpfs_can_priv *priv =3D netdev_priv(ndev);
> +	int ret;
> +
> +	/* There is no separate register in the MSS CAN to do the soft reset
> +	 * hence do the full device reset and this is needed to bring back the
> +	 * bus to normal state in error cases.
> +	 */
> +	ret =3D device_reset(priv->dev);
> +	if (ret)
> +		return ret;
> +
> +	priv->tx_head =3D 0;
> +	priv->tx_tail =3D 0;

[Severity: Medium]
Will this leak memory during bus-off recovery? When handling a reset via
mpfs_can_reset(), the driver zeroes priv->tx_head and priv->tx_tail, but it
fails to call can_free_echo_skb() to clear out frames currently in the echo
ring. These trapped frames will be silently overwritten and leaked when
transmissions resume.

> +
> +	return 0;
> +}

[ ... ]

> +static int mpfs_can_start(struct net_device *ndev)
> +{
> +	struct mpfs_can_priv *priv =3D netdev_priv(ndev);
> +	int ret, buf;
> +	u32 val;
> +
> +	//TODO this means that the device is reset twice on setting the device
> +	//"up" with ip link. Is that excessive? Could we get away with only
> +	//resetting in mpfs_can_open() instead of mpfs_can_start()?
> +	ret =3D mpfs_can_reset(ndev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mpfs_can_set_bittiming(ndev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Clear pending interrupts */
> +	writel(0x0, priv->base + MPFS_CAN_ISR_OFFSET);

[Severity: Medium]
Does writing 0x0 actually clear the interrupts? The ISR register appears to
be a Write-1-to-Clear register based on mpfs_can_interrupt(). Writing 0x0
would be a no-op, leaving stale interrupts that will fire immediately upon
unmasking.

> +
> +	/* Enable interrupts */
> +	writel(MPFS_CAN_IER_MASK, priv->base + MPFS_CAN_IER_OFFSET);

[ ... ]

> +static netdev_tx_t mpfs_can_start_xmit(struct sk_buff *skb, struct net_d=
evice *ndev)
> +{
> +	struct mpfs_can_priv *priv =3D netdev_priv(ndev);
> +	int buf_off;
> +	unsigned long flags;
> +
> +	if (can_dropped_invalid_skb(ndev, skb))
> +		return NETDEV_TX_OK;
> +
> +	buf_off =3D mpfs_can_get_txmsg_index(priv);
> +	if (buf_off < 0) {
> +		netdev_err(ndev, "BUG!, TX full when queue awake!\n");
> +		netif_stop_queue(ndev);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	spin_lock_irqsave(&priv->tx_lock, flags);
> +	mpfs_can_tx(ndev, skb, buf_off);
> +
> +	if ((priv->tx_head - priv->tx_tail) =3D=3D priv->tx_max)
> +		netif_stop_queue(ndev);
> +
> +	netif_stop_queue(ndev);

[Severity: Medium]
Why is netif_stop_queue() called unconditionally here? This will stop
the network queue after every single packet transmission, capping the active
transmission queue at 1 and significantly reducing the throughput, regardle=
ss
of the available capacity in the hardware.

> +
> +	spin_unlock_irqrestore(&priv->tx_lock, flags);
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +static int mpfs_can_rx(struct net_device *ndev, int buf_off)
> +{
> +	struct mpfs_can_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	struct can_frame *frame;
> +	struct sk_buff *skb;
> +	u32 data[2] =3D {0, 0};
> +	u32 id, ctrl;
> +
> +	skb =3D alloc_can_skb(ndev, &frame);
> +	if (unlikely(!skb)) {
> +		stats->rx_dropped++;
> +		return 0;
> +	}

[Severity: High]
Can this cause a system lockup? If alloc_can_skb() fails, this returns 0
without clearing the pending hardware buffer status flag
(MPFS_CAN_RXMSG_CTRL_CMD_AVAIL_MASK). Back in mpfs_can_rx_poll(), the
processed count does not increase, but mpfs_can_get_rxmsg_index() will
continue to return the exact same buffer index. This could cause the NAPI
while-loop to spin infinitely in softirq context.

> +
> +	id =3D readl(priv->base + MPFS_CAN_RX_MSG_ID_OFFSET(buf_off));
> +	ctrl =3D readl(priv->base + MPFS_CAN_RX_MSG_CTR_OFFSET(buf_off));
> +
> +	if (ctrl & MPFS_CAN_RXMSG_CTRL_CMD_IDE_MASK) {
> +		frame->can_id =3D CAN_EFF_FLAG;
> +		frame->can_id |=3D (id >> MPFS_CAN_EXTID_SHIFT);
> +	} else {
> +		frame->can_id =3D (id >> MPFS_CAN_STDID_SHIFT);
> +	}
> +
> +	if (ctrl & MPFS_CAN_RXMSG_CTRL_CMD_RTR_MASK)
> +		frame->can_id |=3D CAN_RTR_FLAG;
> +
> +	frame->len =3D (ctrl & MPFS_CAN_DLC_MASK) >> 16;

[Severity: High]
Does this field need to be validated via can_cc_dlc2len()? By directly
assigning the hardware DLC field (which can be up to 15) without sanitizing
it, frame->len can exceed the 8-byte limit for Classical CAN. This violates
the can_frame UAPI constraint and could cause SocketCAN applications iterat=
ing
over frame->len to perform out-of-bounds reads on the 8-byte data payload a=
rray.

> +
> +	data[0] =3D readl(priv->base + MPFS_CAN_RX_DATAL_OFFSET(buf_off));
> +	data[1] =3D readl(priv->base + MPFS_CAN_RX_DATAH_OFFSET(buf_off));

[ ... ]

> +static void mpfs_can_set_error_state(struct net_device *ndev, enum can_s=
tate new_state,
> +				     struct can_frame *frame)
> +{
> +	struct mpfs_can_priv *priv =3D netdev_priv(ndev);
> +	enum can_state tx_state, rx_state;
> +	u32 ecr, txerr, rxerr;
> +
> +	ecr =3D readl(priv->base + MPFS_CAN_ESR_OFFSET);
> +	txerr =3D ecr & MPFS_CAN_ERR_TXCNT_MASK;
> +	rxerr =3D (ecr & MPFS_CAN_ERR_RXCNT_MASK) >> MPFS_CAN_ERR_RXCNT_SHIFT;
> +
> +	tx_state =3D txerr >=3D rxerr ? new_state : 0;
> +	rx_state =3D txerr <=3D rxerr ? new_state : 0;
> +
> +	if (new_state > CAN_STATE_ERROR_PASSIVE) {
> +		frame->can_id |=3D CAN_ERR_CRTL;

[Severity: High]
Could this result in a NULL pointer dereference? In
mpfs_can_update_error_state(), if alloc_can_err_skb() fails, it passes NULL
as the frame parameter to mpfs_can_set_error_state(). If the controller
enters the bus-off state (new_state > CAN_STATE_ERROR_PASSIVE), the function
unconditionally dereferences the frame pointer here.

Additionally, this if-branch entirely bypasses the else block containing
can_change_state(). As a result, the internal software state (priv->can.sta=
te)
is never updated to CAN_STATE_BUS_OFF and the can_bus_off() recovery helper
is never invoked, leaving the device locked up.

> +		frame->data[1] =3D (txerr > rxerr) ?
> +				  CAN_ERR_CRTL_TX_PASSIVE : CAN_ERR_CRTL_RX_PASSIVE;
> +	} else {
> +		can_change_state(ndev, frame, tx_state, rx_state);
> +
> +		if (frame) {
> +			frame->data[6] =3D txerr;
> +			frame->data[7] =3D rxerr;
> +		}
> +	}
> +}

[ ... ]

> +static void mpfs_can_err_interrupt(struct net_device *ndev, u32 int_stat=
us)
> +{
> +	struct mpfs_can_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	struct can_frame cf =3D { };
> +	u32 err_status;
> +
> +	err_status =3D readl(priv->base + MPFS_CAN_ESR_OFFSET);

[ ... ]

> +		if (err_status & MPFS_CAN_ISR_OVR_LOAD_MASK) {
> +			stats->rx_over_errors++;
> +			stats->rx_errors++;
> +			cf.can_id |=3D CAN_ERR_PROT;
> +			cf.data[3] |=3D CAN_ERR_PROT_OVERLOAD;
> +		}
> +	}
> +
> +	if (cf.can_id) {
> +		struct can_frame *frame;
> +		struct sk_buff *skb =3D alloc_can_err_skb(ndev, &frame);
> +
> +		if (skb) {
> +			frame->can_id |=3D cf.can_id;
> +			memcpy(frame->data, cf.data, CAN_ERR_DLC);
> +			stats->rx_packets++;
> +			stats->rx_bytes +=3D CAN_ERR_DLC;

[Severity: High]
Are there unprotected concurrent modifications of network statistics here?
The NAPI poll routine mpfs_can_rx() runs in softirq context and updates
stats->rx_packets and stats->rx_bytes. Concurrently, mpfs_can_err_interrupt=
()
runs in hardirq context and updates the exact same variables on the same
structure without any locking. An interrupt firing during the softirq
read-modify-write operation can corrupt the network statistics.

> +			netif_rx(skb);
> +		}
> +	}
> +
> +	netdev_dbg(ndev, "error status register:0x%x\n", err_status);
> +}
> +
> +static int mpfs_can_rx_poll(struct napi_struct *napi, int quota)
> +{
> +	struct net_device *ndev =3D napi->dev;
> +	struct mpfs_can_priv *priv =3D netdev_priv(ndev);
> +	int processed =3D 0, buf_off;
> +	u32 int_enable;
> +
> +	while ((buf_off =3D mpfs_can_get_rxmsg_index(priv)) >=3D 0 && (processe=
d < quota))
> +		processed +=3D mpfs_can_rx(ndev, buf_off);
> +
> +	if (processed)
> +		mpfs_can_update_error_state(ndev);
> +
> +	if (processed < quota) {
> +		if (napi_complete_done(napi, processed)) {
> +			int_enable =3D readl(priv->base + MPFS_CAN_IER_OFFSET);
> +			int_enable |=3D (MPFS_CAN_IER_RXMSG_SNT_MASK);

[Severity: Medium]
When an RX or RTR interrupt fires, mpfs_can_interrupt() masks both
MPFS_CAN_IER_RXMSG_SNT_MASK and MPFS_CAN_IER_RTR_SNT_MASK in the IER regist=
er.
However, when NAPI polling completes here, only MPFS_CAN_IER_RXMSG_SNT_MASK
is unmasked. Will this cause Remote Transmission Request (RTR) interrupts to
be permanently disabled after the first receive event?

> +			writel(int_enable, priv->base + MPFS_CAN_IER_OFFSET);
> +		}
> +	}
> +
> +	return processed;
> +}
> +
> +static void mpfs_can_tx_interrupt(struct net_device *ndev)
> +{
> +	struct mpfs_can_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	unsigned int frames_in_fifo;
> +	unsigned long flags;
> +	int bytes =3D 0;
> +
> +	spin_lock_irqsave(&priv->tx_lock, flags);
> +	frames_in_fifo =3D priv->tx_head - priv->tx_tail;
> +
> +	while (frames_in_fifo--) {
> +		bytes =3D can_get_echo_skb(ndev, priv->tx_tail % priv->tx_max, NULL);

[Severity: High]
Does this blindly echo frames in FIFO order without checking hardware buffer
status? CAN arbitration means multiple queued frames can be transmitted out
of order based on priority. The TX interrupt handler loops over
tx_head - tx_tail and echoes all pending frames unconditionally. If two fra=
mes
are queued and only the higher-priority one transmits, a single TX interrupt
will fire, and the driver will erroneously echo both frames and free them
before the second one is actually sent to the bus.

> +		stats->tx_bytes +=3D bytes;
> +		priv->tx_tail++;
> +		stats->tx_packets++;
> +	}
> +
> +	netif_wake_queue(ndev);
> +	spin_unlock_irqrestore(&priv->tx_lock, flags);
> +	mpfs_can_update_error_state(ndev);
> +}

[ ... ]

> +static int mpfs_can_open(struct net_device *ndev)
> +{
> +	struct mpfs_can_priv *priv =3D netdev_priv(ndev);
> +	int ret;
> +
> +	ret =3D request_irq(ndev->irq, mpfs_can_interrupt, priv->irq_flags,
> +			  ndev->name, ndev);

[Severity: High]
Could this cause a kernel crash by requesting the IRQ before enabling NAPI?
request_irq() is called here before napi_enable(). Furthermore,
mpfs_can_start(), which unmasks hardware interrupts, is also called before
napi_enable(). If a pending interrupt fires immediately,
mpfs_can_interrupt() will invoke napi_schedule() on a NAPI instance that has
not yet been initialized or enabled, leading to a kernel panic.

> +	if (ret < 0) {
> +		netdev_err(ndev, "irq allocation for CAN failed\n");
> +		return ret;
> +	}
> +
> +	ret =3D mpfs_can_reset(ndev);
> +	if (ret)
> +		goto err_irq;
> +
> +	ret =3D open_candev(ndev);
> +	if (ret)
> +		goto err_irq;
> +
> +	ret =3D mpfs_can_start(ndev);
> +	if (ret < 0) {
> +		netdev_err(ndev, "mpfs_can_start() failed!\n");
> +		goto err_candev;
> +	}
> +
> +	napi_enable(&priv->napi);
> +	netif_start_queue(ndev);
> +
> +	return 0;

[ ... ]

> +static int mpfs_can_probe(struct platform_device *pdev)
> +{
> +	struct net_device *ndev;
> +	struct mpfs_can_priv *priv;
> +	struct resource *res;
> +	int ret;
> +
> +	ndev =3D alloc_candev(sizeof(struct mpfs_can_priv), MPFS_CAN_TX_BUFFERS=
);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	priv =3D netdev_priv(ndev);
> +	priv->dev =3D &pdev->dev;
> +	priv->can.bittiming_const =3D &mpfs_can_bittiming_const;
> +	priv->can.do_set_mode =3D mpfs_can_do_set_mode;
> +	priv->can.do_get_berr_counter =3D mpfs_can_get_berr_counter;
> +	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK | CAN_CTRLMODE_B=
ERR_REPORTING;
> +	priv->tx_max =3D MPFS_CAN_TX_BUFFERS;
> +
> +	priv->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(priv->base)) {
> +		ret =3D PTR_ERR(priv->base);
> +		goto err_free_candev;
> +	}
> +
> +	spin_lock_init(&priv->tx_lock);
> +
> +	ndev->irq =3D platform_get_irq(pdev, 0);
> +	ndev->flags |=3D IFF_ECHO;

[Severity: Medium]
Is it safe to proceed without checking the return value of platform_get_irq=
()?
The driver assigns the result directly to ndev->irq without verifying if the
result is a negative error code (e.g., -EPROBE_DEFER). The probe would
complete successfully, but a subsequent request_irq() during device open
will fail with the negative irq number.

> +	ndev->netdev_ops =3D &mpfs_can_netdev_ops;
> +	platform_set_drvdata(pdev, ndev);
> +	SET_NETDEV_DEV(ndev, &pdev->dev);
> +
> +	ret =3D clk_bulk_get_all(&pdev->dev, &priv->clks);
> +	if (ret < 2)
> +		goto err_free_candev;

[Severity: High]
Does this return success on error? clk_bulk_get_all() returns the number of
clocks found (>=3D 0). If ret < 2 (0 or 1), the driver jumps to
err_free_candev which frees the ndev structure but returns ret (which is 0
or 1, not a negative error code). The driver core will interpret this as a
successful probe. When the device is later unbound, mpfs_can_remove() will
dereference the already freed ndev, causing a Use-After-Free.

> +
> +	priv->num_clocks =3D ret;
> +	ret =3D clk_bulk_prepare_enable(priv->num_clocks, priv->clks);
> +	if (ret)
> +		goto err_free_candev;
> +
> +	/* Retrieve the CAN clock rate */
> +	priv->can.clock.freq =3D clk_get_rate(priv->clks[1].clk);

[Severity: Medium]
Is it safe to rely on a hardcoded array index to fetch the CAN core
frequency clock? clk_bulk_get_all() returns clocks based on arbitrary Device
Tree property order. Relying on priv->clks[1].clk makes the driver extremely
fragile against DT variations and will silently miscalculate baud rates if
the order changes.

[Severity: High]
The driver acquires and enables clocks using clk_bulk_get_all() and
clk_bulk_prepare_enable() but lacks corresponding
clk_bulk_disable_unprepare() and clk_bulk_put_all() calls on the probe
failure paths (e.g., if register_candev() fails). Will this leak both memory
and active clock references indefinitely?

> +
> +	netif_napi_add_weight(ndev, &priv->napi, mpfs_can_rx_poll, MPFS_CAN_RX_=
BUFFERS);
> +
> +	ret =3D register_candev(ndev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register can device\n");
> +		goto err_del_napi;
> +	}
> +
> +	netdev_dbg(ndev, "reg=3D0x%p irq=3D%d clock=3D%d, max tx buffers %d\n",
> +		   priv->base, ndev->irq, priv->can.clock.freq,
> +		   priv->tx_max);
> +
> +	return 0;
> +
> +err_del_napi:
> +	netif_napi_del(&priv->napi);
> +err_free_candev:
> +	free_candev(ndev);
> +
> +	return ret;
> +}
> +
> +static void mpfs_can_remove(struct platform_device *pdev)
> +{
> +	struct net_device *ndev =3D platform_get_drvdata(pdev);
> +	struct mpfs_can_priv *priv =3D netdev_priv(ndev);
> +
> +	unregister_candev(ndev);
> +	netif_napi_del(&priv->napi);
> +	free_candev(ndev);

[Severity: High]
This device removal function seems to entirely lack clock cleanup. Should
there be a clk_bulk_disable_unprepare() and clk_bulk_put_all() here to avoid
leaking memory and leaving clocks enabled indefinitely upon module unload?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-lens-const=
rict-6dc7d287c647@spud?part=3D1

