Return-Path: <linux-can+bounces-8023-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id he6OJLSmTGqTngEAu9opvQ
	(envelope-from <linux-can+bounces-8023-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 09:11:48 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 836B1718514
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 09:11:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kiNtAU9l;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8023-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8023-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8954D30291F0
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 07:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646F237754B;
	Tue,  7 Jul 2026 07:03:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69EA3B19BB
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 07:03:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407833; cv=none; b=Px895ZHDi/kqBF4o4LrFZG6LVcITHzjL3KM5swTApE45BysmBrOle2f0Kps836+xOo9XcJz72tJHIe+Xc8C8n7q9BJVg+mQ4b0caAbycG/wTcL88SB9v6SqHCdKSATgZLn/cqCztaBtmvMthOcZ2ISSsw8FMJ2dnJ/SS2SXmXww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407833; c=relaxed/simple;
	bh=meE0OlO9gs3ADxVIcYpEWWoKN2FAwZ9vd2SbDLoFdYY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kghpYWfcchsJ08SQIfu0MTFlaJ8rPorJ/9LCT6EJARWNqQWl8yYD7HO4VfGN0iwIlUJXuSe2mH6eI9T33YvF7WlIyuwWQFAQAugmNTp0KbyvdEQ6sH2qjTU0WuT/6i1B9QoJfsZghDRmaYGEDFZxjohO+Ws/ODSciObNT0hy1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiNtAU9l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A4A1F00A3D;
	Tue,  7 Jul 2026 07:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783407831;
	bh=GPPeEgkH08/zUjTWIBtkd+5RcOsa1F/cIYKNIu9vMK4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kiNtAU9lM+Juz9mt4GZqoSEiStWz3D7KwIcqCZcQWu0TlPO33+1U5Lai1ibtA0+Ta
	 JQLW/dNcp7XCXinC2B0snwZ1a9j8HP2vMrgVUKXOKpRCLb9CHtUx/wj4JTeNsCG0xR
	 NhUPEG+Uy9zTgxsbwe7M6j1ELrkJtmQMUcVdK8/L1KNc7Tazl6QiRBgLxX/C+mrMaC
	 NftweQ+vsKPD3t70jUikUrHkfzGsHBUk8RlAmtvHIM+IH/K0+e4YFZaEWZIlPb5RBX
	 cakthbeVC86XzGCKl1+3YDTGVyUMwKyjqPbwBn9RAFEwNHUgdMmzqVP9W7Eq9ZRa1u
	 7THcOMXB5dyiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] can: Add Loongson CAN-FD controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <bbfa82e81607ce600126692d77b763d6f8f412e4.1783391759.git.zhoubinbin@loongson.cn>
References: <cover.1783391759.git.zhoubinbin@loongson.cn>
 <bbfa82e81607ce600126692d77b763d6f8f412e4.1783391759.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:03:50 +0000
Message-Id: <20260707070351.34A4A1F00A3D@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8023-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto,loongson.cn:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhoubinbin@loongson.cn,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:socketcan@hartkopp.net,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 836B1718514

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [High] Lockless queue stop in `start_xmit` races with queue wake in the T=
X interrupt, risking a permanent deadlock.
- [High] Failing to allocate an SKB in the RX path causes early return with=
out draining the hardware FIFO, permanently desynchronizing the RX stream a=
nd hanging NAPI.
- [High] Clearing the TX Hardware Command Interrupt flag at the end of `loo=
ngson_canfd_tx_interrupt()` creates a race condition leading to lost TX int=
errupts.
- [High] The driver immediately clears hardware error counters upon enterin=
g BUS_OFF, bypassing the mandatory software restart delay.
- [High] Overwriting the `isr` variable in `loongson_canfd_err_interrupt()`=
 drops concurrent error interrupts and leaves them permanently masked.
- [High] Using the logical `cfd->len` to pop payload data from the RX FIFO =
permanently corrupts the hardware FIFO state for CAN 2.0 RTR frames.
- [High] Incorrect constraints and silent truncation for CAN FD data phase =
timing lead to corrupted bit-timing configurations.
- [High] Missing volatile register definition for `LOONGSON_CANFD_TRV_DLY` =
causes stale cached TDCV readings.
- [Medium] The queue space check incorrectly evaluates if ALL transmit buff=
ers are free instead of AT LEAST ONE, severely throttling transmission.
- [Medium] The driver passes a hardcoded 0 frame length to `can_put_echo_sk=
b()`, preventing the `tx_bytes` statistic from ever incrementing.
- [Medium] Synchronous polling of hardware status in TX interrupt causes ru=
naway double counting of the `tx_packets` statistic.
--

--- Patch [1]: [PATCH v4 1/2] can: Add Loongson CAN-FD controller driver ---
commit ecb7c7be40459261656c18cd36d4c01fa4e29b1d
Author: Binbin Zhou <zhoubinbin@loongson.cn>
Subject: can: Add Loongson CAN-FD controller driver

This commit adds a new driver for the Loongson CAN-FD controller integrated
into Loongson-2K series SoCs. It implements the core CAN device operations,
including a NAPI-based receive path, TX echo support, error reporting, and
various CAN controller modes.

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> new file mode 100644
> index 0000000000000..83aa620c9d587
> --- /dev/null
> +++ b/drivers/net/can/loongson_canfd.c
> @@ -0,0 +1,1688 @@
[ ... ]
> +static const struct can_bittiming_const loongson_canfd_bit_timing_data =
=3D {
> +	.name		=3D DEV_NAME,
> +	.tseg1_min	=3D 2,
> +	.tseg1_max	=3D 190,
> +	.tseg2_min	=3D 2,
> +	.tseg2_max	=3D 63,

[Severity: High]
Are these data phase bounds correct for the FD hardware? The struct
loongson_canfd_bit_timing_data advertises tseg1_max as 190 and tseg2_max
as 63. However, looking at loongson_canfd_set_btr(), the phase segments are
passed to FIELD_PREP(REG_BTR_FD_PH1...) which is bounded by a 5-bit mask
(GENMASK(11, 7)). Will values greater than 31 be silently truncated here?

> +	.sjw_max	=3D 31,
> +	.brp_min	=3D 1,
> +	.brp_max	=3D 255,
> +	.brp_inc	=3D 1,
> +};
[ ... ]
> +static bool loongson_canfd_txbuf_freed(struct loongson_canfd_priv *priv)
> +{
> +	return !regmap_test_bits(priv->regmap, LOONGSON_CANFD_TX_STAT, REG_TX_S=
TAT_BRP);
> +}

[Severity: Medium]
Does this check properly evaluate if a transmit buffer is free? The use
of !regmap_test_bits() requires all 8 Buffer Request Pending bits to be 0
for the function to return true. In loongson_canfd_start_xmit(), this leads
to the queue being stopped immediately after a single frame is queued,
effectively reducing the 8-buffer queue down to a depth of 1.

[ ... ]
> +static netdev_tx_t loongson_canfd_start_xmit(struct sk_buff *skb, struct=
 net_device *ndev)
> +{
[ ... ]
> +	if (unlikely(!loongson_canfd_txbuf_freed(priv))) {
> +		netif_stop_queue(ndev);
> +		netdev_err(ndev, "BUG!, no TXB free when queue awake!\n");
> +		return NETDEV_TX_BUSY;
> +	}

[Severity: High]
Is this check safe from a race condition with the TX interrupt? The queue
status is read locklessly outside of tx_lock. If this detects a full queue,
but gets preempted before netif_stop_queue() is called, a concurrent TX
interrupt could free a buffer and call netif_wake_queue().

When this thread resumes, it would stop the queue despite free space being
available, potentially resulting in a permanent stall.

> +
> +	guard(spinlock_irqsave)(&priv->tx_lock);
[ ... ]
> +	can_put_echo_skb(skb, ndev, buf_id, 0);

[Severity: Medium]
Is it intentional to pass 0 as the frame length to can_put_echo_skb()?
When the TX interrupt later fires, can_get_echo_skb() will return this
length of 0, meaning stats->tx_bytes will never increment.

> +
> +	loongson_canfd_set_txbuf_cmd(ndev, TXT_CMD_ADD, buf_id);
> +
> +	/* Check if all TX buffers are full */
> +	if (!loongson_canfd_txbuf_freed(priv))
> +		netif_stop_queue(ndev);
> +
> +	return NETDEV_TX_OK;
> +}
[ ... ]
> +static int loongson_canfd_rx(struct net_device *ndev)
> +{
[ ... ]
> +	/* Flexible Data-rate Format */
> +	if (is_can_fd) {
> +		skb =3D alloc_canfd_skb(ndev, &cfd);
> +	} else {
> +		skb =3D alloc_can_skb(ndev, &ccf);
> +		cfd =3D (struct canfd_frame *)ccf;
> +	}
> +
> +	if (unlikely(!skb))
> +		return 0;

[Severity: High]
Can returning 0 here when skb allocation fails corrupt the hardware FIFO
state? This early return skips popping the remaining payload words from
the FIFO. The next read operation might then mistakenly interpret payload
data as frame headers.

Additionally, returning 0 breaks the NAPI polling loop in
loongson_canfd_rx_napi(), which will then exit without calling
napi_complete_done() when ret =3D=3D 0, potentially hanging the receive pat=
h.

> +
> +	/* Extended Identifier Type */
[ ... ]
> +	/* Data Length Code */
> +	dlc =3D FIELD_GET(REG_FRAME_META1_DLC, meta1);
> +	if (is_can_fd)
> +		cfd->len =3D can_fd_dlc2len(dlc);
> +	else
> +		can_frame_set_cc_len(ccf, dlc, priv->can.ctrlmode);
> +
> +	/* Data */
> +	for (unsigned int i =3D 0; i < cfd->len; i +=3D LOONGSON_CANFD_DW_BYTE)
> +		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, (u32 *)(cfd->data + =
i));

[Severity: High]
Does iterating based on cfd->len safely handle CAN 2.0 RTR frames? For
Remote Transmission Request frames, cfd->len specifies the requested
length (up to 8) even though there is no physical payload on the wire.
Reading from the FIFO based on this length could consume data belonging
to the next frame, breaking stream synchronization. Would it be safer to
read exactly REG_FRAME_META1_RWCNT words?

> +
> +	if (!(cfd->can_id & CAN_RTR_FLAG))
> +		stats->rx_bytes +=3D cfd->len;
> +	stats->rx_packets++;
> +	netif_receive_skb(skb);
> +
> +	return 1;
> +}
[ ... ]
> +static void loongson_canfd_err_interrupt(struct net_device *ndev, u32 is=
r)
> +{
[ ... ]
> +	/*
> +	 * EWLI: error warning limit condition met
> +	 * FCSI: fault confinement state changed
> +	 * ALI:  arbitration lost (just informative)
> +	 * BEI:  bus error interrupt
> +	 */
> +	if ((isr & REG_INT_STAT_FCSI) || (isr & REG_INT_STAT_EWLI)) {
> +		netdev_info(ndev, "state changes from %s to %s\n",
> +			    can_get_state_str(priv->can.state), can_get_state_str(state));
> +
> +		if (priv->can.state =3D=3D state)
> +			netdev_warn(ndev, "cur and pre state is the same!(miss intr?)\n");
> +
> +		isr =3D REG_INT_STAT_FCSI | REG_INT_STAT_EWLI;

[Severity: High]
Does overwriting the isr variable here drop concurrent error interrupts? If
multiple errors occur simultaneously, this assignment destroys the other
flags (like REG_INT_STAT_ALI).

Because this modified isr variable is later used to write back to
LOONGSON_CANFD_INT_MASK at the end of the function, the dropped interrupts
could remain permanently masked in the hardware.

> +		priv->can.state =3D state;
> +		switch (state) {
> +		case CAN_STATE_BUS_OFF:
> +			priv->can.can_stats.bus_off++;
> +			if (priv->can.restart_ms)
> +				regmap_write(priv->regmap, LOONGSON_CANFD_CMD,
> +					     REG_CMD_ERCRST);

[Severity: High]
Does clearing the error counters here bypass the software recovery
protocol? The REG_CMD_ERCRST command instantly zeroes the hardware TEC/REC
counters, which could cause the controller to immediately rejoin the bus,
bypassing the mandatory CAN subsystem recovery delay specified by
priv->can.restart_ms.

> +
> +			can_bus_off(ndev);
[ ... ]
> +static void loongson_canfd_tx_interrupt(struct net_device *ndev)
> +{
[ ... ]
> +	while ((buf_id =3D loongson_canfd_get_txbuf_id(priv, &sts)) < LOONGSON_=
CANFD_TXBUF_NUM) {
> +		switch (sts) {
> +		case TX_BS_VALID:
> +			stats->tx_bytes +=3D can_get_echo_skb(ndev, buf_id, NULL);
> +			stats->tx_packets++;
> +			break;
> +		case TX_BS_FAIL:
> +			u32 cnt;
[ ... ]
> +			stats->tx_dropped++;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		loongson_canfd_set_txbuf_cmd(ndev, TXT_CMD_SR_CLEAN, buf_id);
> +	}

[Severity: Medium]
Can this loop sequence artificially inflate the tx_packets statistic? The
code issues a TXT_CMD_SR_CLEAN command and immediately continues the loop
without verifying the status cleared.

Since hardware register updates take time, the very next regmap_read() in
loongson_canfd_get_txbuf_id() could yield the same TX_BS_VALID status. The
buffer would then be processed again, safely returning 0 from
can_get_echo_skb(), but unconditionally incrementing stats->tx_packets
over and over.

> +
> +	/*
> +	 * Clear the interrupt again. We do not want to receive again interrupt
> +	 * for the buffer already handled. If it is the last finished one then
> +	 * it would cause log of spurious interrupt.
> +	 */
> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_TXBHCI=
);

[Severity: High]
Is it safe to clear the hardware interrupt flag after processing the buffers
instead of before? If a new buffer finishes transmission between the end of
the loop and this regmap_write, the newly set interrupt flag would be
cleared without getting processed, potentially causing a lost interrupt.

> +
> +	/* Check if at least one TX buffer is free */
> +	if (loongson_canfd_txbuf_freed(priv))
> +		netif_wake_queue(ndev);
> +}
[ ... ]
> +static bool loongson_canfd_volatile_reg(struct device *dev, unsigned int=
 reg)
> +{
> +	switch (reg) {
> +	case LOONGSON_CANFD_MODE:
> +	case LOONGSON_CANFD_CONF:

[Severity: High]
Should LOONGSON_CANFD_TRV_DLY be included in this volatile register list?
Since regmap uses REGCACHE_MAPLE, omitting this register causes the first
read in loongson_canfd_get_auto_tdcv() to be cached indefinitely. This
would continuously feed stale TDCV readings into the auto-TDC logic.

> +	case LOONGSON_CANFD_STAT:
> +	case LOONGSON_CANFD_INT_STAT:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783391759.gi=
t.zhoubinbin@loongson.cn?part=3D1

