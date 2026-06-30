Return-Path: <linux-can+bounces-7912-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0UPKMJA1Q2r0UwoAu9opvQ
	(envelope-from <linux-can+bounces-7912-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 05:18:40 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B01B6E002F
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 05:18:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="jts+We/U";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7912-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7912-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E8273010173
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 03:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555822690D5;
	Tue, 30 Jun 2026 03:16:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE51727144B
	for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 03:16:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789384; cv=none; b=FoNKYlt4lGciFs9+DPeqYAsM7t5tLNAbJx2Wq5MTUuplQB8jhT2SvLRieg6I0FQSPpZVZDa+3I84Il21VynfX4engGQ7SJX6x7c7/8ADrplYtg0WTfKr7kUXhC7KA8hy8eVKDtlYCGjiv01gwbUbEUF5M1J2piVY/0FhlKYYtHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789384; c=relaxed/simple;
	bh=W+hOjtGkwZCt8gyulp8SKXjtoM3Pj0cup//oyHWsZ84=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ot6nFun9Pl6qMi6zy75zEQN9pYtawKX7tlzBKjXLnAYmJrk1HPqa5x4Xac4MYB8sJQuNWUqlKiicF6jB7tSmW9t1xSzejG1Gt9KclQZHxbMdTSobAFYt/azPz0Enxv7Z8Cj4P+lC0hsiv627bLi2Wa6ikfOxrjJTNrZyfTX9554=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jts+We/U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F981F000E9;
	Tue, 30 Jun 2026 03:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782789382;
	bh=2vfEpaRDmMQhg+dCuKQ4ItgoAnr7aIZODx1wPhX+1qI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jts+We/UgGHXz3xeD52Q/xo7CqBmfvdrVqnzd0S8R1vVLtfM6v11mnTycUyk7eZiw
	 UUhnBzpzQ5HuhxpOb/BBVW+LL7L6MA74j+8p9ScskuIhsCCpsBp4xo5yfln1PrTlJV
	 aeckhf/hxwd5qR+kE/y0/mZE/ccoiswG4hr6LXaAPPKzSxfXG3hCKq/UMacGSz44h2
	 IMS4SjudW3vQ9qYwT7PDOXHcx22H9bKA4pSoIXu9mbDPoJRvKtOqCQ8YR580o1gsnz
	 K7pbmIUnNddr+TDuNBMcriR0mU0RkTfdkvNXKGovQWIQe4YEALC9NMpMnfHArcXMAA
	 cO/HYr3XSJrMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] can: Add Loongson CAN-FD controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <b80d271f63f6318a4060220e8107785bd147f1bd.1782787997.git.zhoubinbin@loongson.cn>
References: <cover.1782787997.git.zhoubinbin@loongson.cn>
 <b80d271f63f6318a4060220e8107785bd147f1bd.1782787997.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 03:16:21 +0000
Message-Id: <20260630031622.14F981F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7912-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto,vger.kernel.org:from_smtp,loongson.cn:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B01B6E002F

Thank you for your contribution! Sashiko AI review found 18 potential issue=
(s) to consider:
- [High] Missing `skb` check in `CAN_STATE_ERROR_ACTIVE` case leads to a NU=
LL pointer dereference.
- [High] SKB allocation failure or invalid frame in RX path permanently sta=
lls NAPI and corrupts RX FIFO.
- [High] NAPI poll list corruption due to calling `napi_complete_done` whil=
e returning `quota`.
- [High] Missing `napi_disable()` on error paths in `loongson_canfd_open()`=
 leads to a kernel panic on subsequent open attempts.
- [High] Race condition in `loongson_canfd_start_xmit` causes unexpected pa=
cket drops due to un-reaped TX buffers.
- [High] Missing bounds check on the hardware-provided word count `REG_FRAM=
E_META1_RWCNT` causes heap buffer overflow.
- [High] Unchecked return value of `device_property_read_u32` leaves `clk_r=
ate` uninitialized.
- [High] Premature hardware restart on Bus-Off when auto-restart is configu=
red.
- [High] Bitwise NOT on a 16-bit variable unintentionally unmasks all inter=
rupts due to integer promotion.
- [High] Overwriting of `isr` variable causes lost error interrupts and per=
manent interrupt masking.
- [High] Using `regmap_update_bits` on command-style SET/CLR registers caus=
es conflicting hardware commands.
- [High] Calling `kfree_skb()` with hardware interrupts disabled.
- [High] Potential infinite loop in TX interrupt handler due to repeated st=
atus reads of posted writes.
- [Medium] The driver advertises 'hardware timestamping' in commit message =
but does not implement it.
- [Medium] `ndev->stats.rx_errors` is modified concurrently from both hardi=
rq and NAPI softirq contexts without locking.
- [Medium] Incorrect check for RTR frames causes invalid RX byte statistics.
- [Medium] Missing `cf->len8_dlc` assignment for Classic CAN frames.
- [Low] Syntax error due to variable declarations immediately following a s=
witch case label.
--

commit e0d474f047900e47a73eaa207fc07dd8c35084bf
Author: Binbin Zhou <zhoubinbin@loongson.cn>
Subject: can: Add Loongson CAN-FD controller driver

This commit adds support for the CAN-FD controller integrated into=20
Loongson-2K series SoCs. It implements NAPI for the RX path, TX buffer=20
management, bus error reporting, and various timing configurations.

[Severity: Medium]
The commit message states the driver supports hardware timestamping, but is
this functionality actually implemented? Looking at the driver code, it sets
ethtool_op_get_ts_info but does not seem to extract the timestamp field from
the hardware or write to skb_hwtstamps in the receive path.

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> new file mode 100644
> index 0000000000000..1c7381129c2b6
> --- /dev/null
> +++ b/drivers/net/can/loongson_canfd.c
[ ... ]
> @@ -891,37 +891,24 @@ static int loongson_canfd_chip_start(struct net_dev=
ice *ndev)
[ ... ]
> +	/* Configure interrupts */
> +	int_ena =3D REG_INT_STAT_RBNEI | REG_INT_STAT_TXBHCI |
> +		  REG_INT_STAT_EWLI | REG_INT_STAT_FCSI;
> +
> +	/* Bus error reporting */
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> +		int_ena |=3D REG_INT_STAT_ALI | REG_INT_STAT_BEI;
> +
> +	/* It's after reset, so there is no need to clear anything */
> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, ~int_ena);

[Severity: High]
Will this bitwise NOT operation unmask all interrupts on the controller?
Because int_ena is a 16-bit unsigned integer, the bitwise NOT causes integer
promotion to a 32-bit signed int, filling the upper 16 bits with 1s. Since
the upper bits of this register clear the mask, does this unintentionally
enable every possible interrupt?

> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_ENA, int_ena);
[ ... ]
> @@ -1048,46 +1048,22 @@ static netdev_tx_t loongson_canfd_start_xmit(stru=
ct sk_buff *skb, struct net_device *ndev)
[ ... ]
> +	for_each_clear_bit(i, &tx_brp, LOONGSON_CANFD_TXBUF_NUM) {
> +		u32 transmission_complete_mask =3D 0x3 << (i * 2);
> +
> +		if (!(tx_bs & transmission_complete_mask)) {
> +			buf_id =3D i;
> +			break;
> +		}
> +	}
> +
> +	if (!loongson_canfd_insert_frame(priv, cf, buf_id, can_is_canfd_skb(skb=
))) {
> +		netdev_err(ndev, "TXNF set but cannot insert frame into TXTB! HW Bug?"=
);
> +		kfree_skb(skb);

[Severity: High]
Could a race condition here cause silent packet drops? The hardware clears
tx_brp immediately on completion, but tx_bs is cleared later in the ISR.
If all inactive buffers are awaiting a reap, the loop finishes without
finding a buffer, leaving buf_id at 0. This would cause the insert check to
fail, dropping the packet while incorrectly returning NETDEV_TX_OK.

[Severity: High]
Is it safe to call kfree_skb here? The tx_lock is held with
spinlock_irqsave which disables local interrupts. Calling kfree_skb with
hard interrupts disabled can lead to kernel warnings and potential deadlock=
s.
Should this use dev_kfree_skb_any instead?

> +		ndev->stats.tx_dropped++;
> +		return NETDEV_TX_OK;
> +	}
[ ... ]
> @@ -1105,37 +1105,25 @@ static void loongson_canfd_read_rx_frame(struct l=
oongson_canfd_priv *priv, struct canfd_frame *cf,
[ ... ]
> +	/* Data Length Code */
> +	len =3D FIELD_GET(REG_FRAME_META1_DLC, meta1);
> +	if (len > 8) {
> +		if (meta1 & REG_FRAME_META1_FDF)
> +			len =3D wc << 2;
> +		else
> +			len =3D 8;
> +	}
> +
> +	cf->len =3D len;

[Severity: Medium]
Does this properly support the CAN_CTRLMODE_CC_LEN8_DLC feature? For Classic
CAN frames with a DLC greater than 8, the length is appropriately capped to
8, but the original DLC is not saved to cf->len8_dlc. This might break
userspace protocols that rely on the original DLC data.

> +	if (unlikely(len > wc * LOONGSON_CANFD_DW_BYTE))
> +		len =3D wc * LOONGSON_CANFD_DW_BYTE;
> +
> +	/* Data */
> +	for (i =3D 0; i < len; i +=3D LOONGSON_CANFD_DW_BYTE)
> +		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, (u32 *)(cf->data + i=
));

[Severity: High]
Can a malformed hardware word count cause a heap buffer overflow? The len
variable is checked against the hardware-provided word count, but not again=
st
CANFD_MAX_DLEN. If the hardware yields an invalid read word count, the leng=
th
could exceed the 64-byte payload limit, causing out of bounds memory writes
to the skb data.

[ ... ]
> @@ -1164,28 +1164,22 @@ static int loongson_canfd_rx(struct net_device *n=
dev)
[ ... ]
> +	/* Flexible Data-rate Format */
> +	if (meta1 & REG_FRAME_META1_FDF)
> +		skb =3D alloc_canfd_skb(ndev, &cf);
> +	else
> +		skb =3D alloc_can_skb(ndev, (struct can_frame **)&cf);
> +	if (unlikely(!skb))
> +		return 0;

[Severity: High]
If the skb allocation fails, does returning 0 early permanently stall the
NAPI loop? Since the rest of the data payload is not read from the hardware
FIFO, the RX stream might desynchronize. Also, returning 0 here causes the
caller to exit its loop without completing NAPI, potentially leaving it
permanently in a scheduled state.

> +
> +	loongson_canfd_read_rx_frame(priv, cf, meta0, meta1);
> +
> +	if (cf->can_id !=3D CAN_RTR_FLAG)
> +		stats->rx_bytes +=3D cf->len;

[Severity: Medium]
Is this RTR check accurate? The can_id field contains both the CAN ID and
the flags, so a direct inequality comparison to CAN_RTR_FLAG might evaluate
true for almost all RTR frames, erroneously inflating the RX byte statistics
for frames with no actual payload.

[ ... ]
> @@ -1203,32 +1203,26 @@ static enum can_state loongson_canfd_read_fault_s=
tate(struct net_device *ndev)
[ ... ]
> +	switch (FIELD_GET(REG_FSTAT_MASK, fstat)) {
> +	case REG_FSTAT_ERA:
> +		u32 ewl, erl, rec_tec, max_tec;

[Severity: Low]
Will this compile on strict C11 compilers? The C11 standard does not allow
variable declarations immediately following a switch case label.

[ ... ]
> @@ -1278,82 +1278,28 @@ static void loongson_canfd_err_interrupt(struct n=
et_device *ndev, u32 isr)
[ ... ]
> +	if ((isr & REG_INT_STAT_FCSI) || (isr & REG_INT_STAT_EWLI)) {
> +		netdev_info(ndev, "state changes from %s to %s\n",
> +			    can_get_state_str(priv->can.state), can_get_state_str(state));
> +
> +		if (priv->can.state =3D=3D state)
> +			netdev_warn(ndev, "cur and pre state is the same!(miss intr?)\n");
> +
> +		isr =3D REG_INT_STAT_FCSI | REG_INT_STAT_EWLI;

[Severity: High]
Does overwriting the isr variable here permanently disable other interrupts?
If arbitration lost or bus error flags are pending, this assignment destroys
them. Later in the function, isr is shifted to unmask interrupts, meaning t=
he
erased flags will never be unmasked again.

> +		priv->can.state =3D state;
> +		switch (state) {
> +		case CAN_STATE_BUS_OFF:
> +			priv->can.can_stats.bus_off++;
> +			if (priv->can.restart_ms)
> +				regmap_write(priv->regmap, LOONGSON_CANFD_CMD,
> +					     REG_CMD_ERCRST);

[Severity: High]
Does this prematurely restart the hardware upon a bus-off event? Instantly
writing the error reset command clears the hardware error state and rejoins
the bus immediately, ignoring the restart delay contract enforced by the co=
re
can_bus_off timer.

[ ... ]
> +		case CAN_STATE_ERROR_ACTIVE:
> +			cf->can_id |=3D CAN_ERR_CNT;
> +			cf->data[1] =3D CAN_ERR_CRTL_ACTIVE;
> +			cf->data[6] =3D bec.txerr;

[Severity: High]
Could this lead to a null pointer dereference? The alloc_can_err_skb call
earlier in the function can fail and leave cf uninitialized. While the other
switch cases check if skb is valid before modifying cf data, this case does
not, which would crash if memory pressure prevents allocation.

[ ... ]
> +	/* Check for Bus Error interrupt */
> +	if (isr & REG_INT_STAT_BEI) {
> +		isr =3D REG_INT_STAT_BEI;
> +		netdev_err(ndev, "Bus Error interrupt\n");
> +		priv->can.can_stats.bus_error++;
> +		stats->rx_errors++;

[Severity: Medium]
Is it safe to increment stats->rx_errors without locking here? This counter
is modified from hardirq context here and concurrently from softirq context
in the NAPI poll routine, which could cause lost increments due to data rac=
es
on 32-bit systems.

[ ... ]
> @@ -1391,37 +1391,25 @@ static int loongson_canfd_rx_napi(struct napi_str=
uct *napi, int quota)
[ ... ]
> +	/* Check for RX FIFO Overflow */
> +	regmap_read(priv->regmap, LOONGSON_CANFD_STAT, &sts);
> +	if (sts & REG_STAT_DOR) {
> +		struct net_device_stats *stats =3D &ndev->stats;
> +		struct can_frame *cf;
> +		struct sk_buff *skb;
> +
> +		netdev_info(ndev, "Loongson canfd RX overflow\n");
> +		stats->rx_over_errors++;
> +		stats->rx_errors++;

[Severity: Medium]
As noted above, stats->rx_errors is updated concurrently in both softirq and
hardirq contexts without locking.

[ ... ]
> +	if (rxbuf_is_empty && ret !=3D 0) {
> +		if (napi_complete_done(napi, work_done)) {

[Severity: High]
Should this check if work_done is less than quota? If exactly quota frames
are processed and the hardware buffer becomes empty, this logic calls
napi_complete_done and then returns quota to the networking core. Returning
the full quota instructs the core to reschedule the instance, but the state
has already been manipulated, which can corrupt the NAPI poll list.

[ ... ]
> @@ -1425,33 +1425,18 @@ static void loongson_canfd_tx_interrupt(struct ne=
t_device *ndev)
[ ... ]
> +	while ((buf_id =3D loongson_canfd_get_txbuf_id(priv, &sts)) < LOONGSON_=
CANFD_TXBUF_NUM) {
> +		switch (sts) {
> +		case TX_BS_VALID:
> +			stats->tx_bytes +=3D can_get_echo_skb(ndev, buf_id, NULL);
> +			stats->tx_packets++;
> +			break;

[Severity: High]
Could this result in an inescapable infinite loop? When the driver writes a
clear command to the posted MMIO register at the end of the loop, it
immediately reads the status register back in the while condition. Because
the hardware takes cycles to clear the bit, the old status is read, causing
the driver to repeatedly process the same buffer and spin in the ISR.

> +		case TX_BS_FAIL:
> +			u32 cnt;

[Severity: Low]
Similar to the fault state read function, this violates C11 syntax by
declaring a variable immediately following a switch case label.

[ ... ]
> @@ -1584,20 +1584,14 @@ static void loongson_canfd_chip_stop(struct net_d=
evice *ndev)
>  {
>  	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> =20
>  	/* Disable interrupts and disable CAN */
>  	regmap_update_bits(priv->regmap, LOONGSON_CANFD_INT_ENA, REG_INT_ENA_CL=
R, REG_INT_ENA_CLR);
>  	regmap_update_bits(priv->regmap, LOONGSON_CANFD_INT_MASK,
>  			   REG_INT_MASK_SET, REG_INT_MASK_SET);

[Severity: High]
Are these regmap_update_bits calls safe for W1S/W1C command registers? This
function reads the current 1s from the lower half of INT_ENA and writes them
back along with the clear mask in the upper half, which commands the hardwa=
re
to simultaneously set and clear the exact same interrupts.

[ ... ]
> @@ -1604,45 +1604,22 @@ static int loongson_canfd_open(struct net_device =
*ndev)
[ ... ]
> +err_chip_start:
> +	free_irq(ndev->irq, ndev);
> +err_irq:
> +	close_candev(ndev);
> +	return ret;
> +}

[Severity: High]
Are we missing a napi_disable call on these error paths? If the driver fails
to open, the candev is closed but NAPI is left enabled. A subsequent attempt
to bring the interface up will call napi_enable on an already enabled
instance, triggering a BUG_ON in the core.

[ ... ]
> @@ -1690,46 +1690,24 @@ static int loongson_canfd_probe(struct platform_d=
evice *pdev)
[ ... ]
> +	regmap =3D devm_regmap_init_mmio(dev, base, &loongson_cangfd_regmap);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	device_property_read_u32(dev, "clock-frequency", &clk_rate);
> +
> +	irq =3D platform_get_irq(pdev, 0);

[Severity: High]
Should the return value of device_property_read_u32 be checked? If the
property is missing, clk_rate retains uninitialized stack garbage which is
then assigned to priv->can.clock.freq, leading to unpredictable hardware
timing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782787997.gi=
t.zhoubinbin@loongson.cn?part=3D1

