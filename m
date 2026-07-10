Return-Path: <linux-can+bounces-8270-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qT1kCOOvUGrX3QIAu9opvQ
	(envelope-from <linux-can+bounces-8270-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 10:40:03 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E3973893E
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 10:40:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CKn7U5cd;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8270-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8270-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 624DC3038506
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 08:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED28A3B6370;
	Fri, 10 Jul 2026 08:36:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0253D170C
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 08:36:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672571; cv=none; b=E24c0grahEkF4T90YLWOh/cd/AsmVral/3NOb0wekyb7cLzfHfHKQXw0Nk/At8Ld6PENXCHp1ExFX5cEsUUn+QiBLV1knhUvhpJZ4OUw0nZCmAvhy3RanV5QNPXzMxJiSfIWZj1wu/nN6S+5aunCQC4zxWZ+KNV1cEGTaSggxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672571; c=relaxed/simple;
	bh=XfsVNENXbrF5EPRNIteQ6xYqHxBByQvAWIPwW89dK7Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nB8rY4yl042pPl51fMZn9pQ404g/nF7RN87iimAWonU+wGWicagfTIlRfC2v0w8bO7HUn2FzV3Er/BacqoBFk+eWhtR4KwaXcPz8ri50Hrt80zr5S3cyFlk13fBw9g5zhDOz+8BKiDK/bZBuGVvX9x1MzZGQV9JT+FQS5DpZPvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKn7U5cd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B231F000E9;
	Fri, 10 Jul 2026 08:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783672570;
	bh=Wqx6P79ovisWG8Uk7KnzNR/eLl1ztZgpWTuLjuOCCgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CKn7U5cd/PJVpI6Tf7ZcEQBWGQEK2vE/WI6C5MIIiJBbJ7+OM/9Q8onbs/HmLVI1Z
	 UHI/QHP0Rvk6vKyxbIQh/ioFcWH4IJTOgzIg27fpyuLiGlNvokFRW/aVXrIB7nSv7K
	 sqXdK6YZ78GySbcLSnymplbbx5xOtji5mnflEV09e3hBfwmz4R18iug0n330U+5vFA
	 i9xRxJohrDdn3LrWRvUeR4+5kJN7ygjbXt6agMWGhCk12b6F+bxqLwA9F31phm3a+r
	 v8oeT3H2QK7hPvfFEGrmduRsrouNHrwqt9Oc/4zCNVPln6992KOOazilJcI0T4q9fK
	 BT0ZoTC1pkjVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] can: Add Loongson CAN-FD controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20507209923b81f7902b3315d1b5837e36b31a67.1783670733.git.zhoubinbin@loongson.cn>
References: <cover.1783670733.git.zhoubinbin@loongson.cn>
 <20507209923b81f7902b3315d1b5837e36b31a67.1783670733.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:36:09 +0000
Message-Id: <20260710083609.E0B231F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8270-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,loongson.cn:email,smtp.kernel.org:mid,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhoubinbin@loongson.cn,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 49E3973893E

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Missing bounds check on the hardware-provided frame length (`rwcnt=
`) leads to a kernel heap buffer overflow when reading RX payloads.
- [High] NAPI polling is permanently stalled if SKB allocation fails in the=
 RX path due to skipping `napi_complete_done()`.
- [High] Spurious double processing of TX completions and infinite loop pot=
ential due to polling MMIO status immediately after issuing a clear command.
- [Medium] The driver advertises support for `CAN_CTRLMODE_3_SAMPLES` but f=
ails to implement it, leading to silent failures to honor user configuratio=
n.
- [Medium] The driver incorrectly resets hardware error counters immediatel=
y upon entering bus-off state, bypassing the CAN framework's restart delay =
mechanism.
- [Medium] Calling `kfree_skb()` with local interrupts disabled.
- [Low] A local variable declaration immediately following a switch case la=
bel violates C syntax standards and causes a build failure.
--

--- Patch [1]: [PATCH v5 1/2] can: Add Loongson CAN-FD controller driver ---
commit e34dfafbc093b1981c79c97332825864c52e75bd
Author: Binbin Zhou <zhoubinbin@loongson.cn>
Subject: can: Add Loongson CAN-FD controller driver

Add a new driver for the Loongson CAN-FD controller, which is integrated
into Loongson-2K series SoCs. The controller supports both CAN 2.0 and
CAN-FD protocols, with up to 8 TX buffers and a flexible RX buffer.

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> new file mode 100644
> index 0000000000000..0e85005a9bb12
> --- /dev/null
> +++ b/drivers/net/can/loongson_canfd.c

[ ... ]

> +static netdev_tx_t loongson_canfd_start_xmit(struct sk_buff *skb, struct=
 net_device *ndev)
> +{
> +	struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	u32 buf_id =3D 0, tx_stat, i =3D 0;
> +	unsigned long tx_brp;
> +	u16 tx_bs;
> +
> +	if (can_dropped_invalid_skb(ndev, skb))
> +		return NETDEV_TX_OK;
> +
> +	guard(spinlock_irqsave)(&priv->tx_lock);
> +
> +	if (unlikely(!loongson_canfd_txbuf_freed(priv))) {
> +		netif_stop_queue(ndev);
> +		netdev_err(ndev, "BUG!, no TXB free when queue awake!\n");
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	regmap_read(priv->regmap, LOONGSON_CANFD_TX_STAT, &tx_stat);
> +	tx_brp =3D FIELD_GET(REG_TX_STAT_BRP, tx_stat);
> +	tx_bs =3D FIELD_GET(REG_TX_STAT_BS, tx_stat);
> +
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
[Severity: Medium]
Is it safe to call kfree_skb() here with local hardware interrupts disabled?

Since this block of code runs with priv->tx_lock held via=20
guard(spinlock_irqsave), could we use dev_kfree_skb_any() instead to avoid=
=20
potentially sleeping or violating atomic context APIs?

> +		ndev->stats.tx_dropped++;
> +		return NETDEV_TX_OK;
> +	}

[ ... ]

> +static int loongson_canfd_rx(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	u32 meta0, meta1, dlc, rwcnt, dbcnt, i, data;
> +	struct canfd_frame *cfd;
> +	struct can_frame *ccf;
> +	struct sk_buff *skb;
> +	bool is_can_fd;
> +
> +	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta0);
> +	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta1);
> +
> +	/* Number of characters received */
> +	rwcnt =3D FIELD_GET(REG_FRAME_META1_RWCNT, meta1);
> +	if (!rwcnt)
> +		return -EAGAIN;
> +	dbcnt =3D (rwcnt - 2) * LOONGSON_CANFD_DW_BYTE;
[Severity: High]
Can dbcnt underflow if the hardware provides a value of 1 for rwcnt?

If a malfunctioning or malicious CAN controller provides an rwcnt of 1,=20
the subtraction will underflow, causing dbcnt to become a very large number=
.=20
This would lead to a kernel heap buffer overflow when the subsequent code=20
reads payload data into cfd->data.

Could we add a bounds check to ensure rwcnt >=3D 2 and dbcnt <=3D CANFD_MAX=
_DLEN?

> +
> +	/* Flexible Data-rate Format */

[ ... ]

> +static void loongson_canfd_err_interrupt(struct net_device *ndev, u32 is=
r)
> +{
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	struct can_berr_counter bec;
> +	u32 capt, alc, mask =3D 0;
> +	enum can_state state;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	loongson_canfd_get_bec(priv, &bec);
> +
> +	state =3D loongson_canfd_read_fault_state(ndev);

[ ... ]

> +	if ((isr & REG_INT_STAT_FCSI) || (isr & REG_INT_STAT_EWLI)) {
> +		netdev_info(ndev, "state changes from %s to %s\n",
> +			    can_get_state_str(priv->can.state), can_get_state_str(state));
> +
> +		if (priv->can.state =3D=3D state)
> +			netdev_warn(ndev, "cur and pre state is the same!(miss intr?)\n");
> +
> +		mask |=3D REG_INT_STAT_FCSI | REG_INT_STAT_EWLI;
> +		priv->can.state =3D state;
> +		switch (state) {
> +		case CAN_STATE_BUS_OFF:
> +			priv->can.can_stats.bus_off++;
> +			if (priv->can.restart_ms)
> +				regmap_write(priv->regmap, LOONGSON_CANFD_CMD,
> +					     REG_CMD_ERCRST);
[Severity: Medium]
Does resetting the hardware error counters immediately upon entering bus-off
state bypass the CAN framework's restart delay mechanism?

Clearing the hardware error counters here forces the controller to attempt
recovery instantly, which circumvents the software-defined isolation delay
(restart_ms) that is supposed to keep the device off the bus before
can_restart() eventually re-enables it.

> +
> +			can_bus_off(ndev);
> +			if (skb)
> +				cf->can_id |=3D CAN_ERR_BUSOFF;
> +			break;

[ ... ]

> +static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
> +{
> +	struct net_device *ndev =3D napi->dev;
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	int work_done =3D 0, ret =3D 1;
> +	bool rxbuf_is_empty;
> +	u32 sts;
> +
> +	rxbuf_is_empty =3D loongson_canfd_rxbuf_empty(priv);
> +
> +	while (!rxbuf_is_empty && work_done < quota && ret > 0) {
> +		ret =3D loongson_canfd_rx(ndev);
> +		work_done++;
> +		rxbuf_is_empty =3D loongson_canfd_rxbuf_empty(priv);
> +	}
> +
> +	/* Check for RX FIFO Overflow */

[ ... ]

> +	if (rxbuf_is_empty && ret !=3D 0) {
> +		if (napi_complete_done(napi, work_done)) {
[Severity: High]
Can NAPI polling stall permanently if SKB allocation fails in the RX path?

If alloc_can_skb() fails due to memory pressure, loongson_canfd_rx() returns
0. The NAPI while loop breaks early because ret > 0 evaluates to false.=20

Because of the condition above (ret !=3D 0), napi_complete_done() is then=20
skipped. This leaves the NAPI instance stuck in the NAPI_STATE_SCHED state=
=20
without unmasking the RX interrupt, permanently deadlocking the receive pat=
h=20
until the interface is brought down and back up.

> +			/*
> +			 * Clear and enable RBNEI. It is level-triggered,
> +			 * so there is no race condition.
> +			 */
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_RBNE=
I);

[ ... ]

> +static void loongson_canfd_tx_interrupt(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	enum loongson_canfd_txbuf_sts sts;
> +	bool some_buffers_processed;
> +	u32 buf_id;
> +
> +	do {
> +		some_buffers_processed =3D false;
> +
> +		guard(spinlock_irqsave)(&priv->tx_lock);
> +
> +		while ((buf_id =3D loongson_canfd_get_txbuf_id(priv, &sts)) <
> +			LOONGSON_CANFD_TXBUF_NUM) {
> +			switch (sts) {
> +			case TX_BS_VALID:
> +				stats->tx_bytes +=3D can_get_echo_skb(ndev, buf_id, NULL);
> +				stats->tx_packets++;
> +				break;
> +			case TX_BS_FAIL:
> +				u32 cnt;
[Severity: Low]
Does this local variable declaration directly following a label violate C
syntax rules?

Under standard C11 rules (gnu11), a label must be attached to a statement,=
=20
and a declaration is not considered a statement. This can cause compilation=
=20
to fail with modern GCC versions.=20

Could we move this declaration outside the switch block, or wrap the logic=
=20
for this case inside braces?

> +				/*
> +				 * This indicated that retransmit limit has been reached.
> +				 * Obviously we should not echo the frame, but also not indicate any
> +				 * kind of error. If desired, it was already reported (possible
> +				 * multiple times) on each arbitration lost.
> +				 */

[ ... ]

> +			loongson_canfd_set_txbuf_cmd(ndev, TXT_CMD_SR_CLEAN, buf_id);
> +			some_buffers_processed =3D true;
> +		}
> +
> +		/*
> +		 * If no buffers were processed this time, we cannot clear - that woul=
d introduce
> +		 * a race condition.
> +		 */
> +		if (some_buffers_processed) {
> +			/*
> +			 * Clear the interrupt again. We do not want to receive again interru=
pt
> +			 * for the buffer already handled. If it is the last finished one then
> +			 * it would cause log of spurious interrupt.
> +			 */
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_TXBH=
CI);
> +		}
> +	} while (some_buffers_processed);
[Severity: High]
Could this loop result in spurious double-processing of TX completions?

If the MMIO write to clear the status bit (TXT_CMD_SR_CLEAN) takes time to
propagate through the hardware, the next immediate iteration of the loop=20
could read the old status from LOONGSON_CANFD_TX_STAT.

This would cause the driver to process the exact same TX buffer multiple=20
times, inflating tx_packets or tx_dropped and spamming the logs with warnin=
gs=20
until the hardware finally updates the register.

> +
> +	guard(spinlock_irqsave)(&priv->tx_lock);

[ ... ]

> +static int loongson_canfd_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct loongson_canfd_priv *priv;
> +	struct net_device *ndev;
> +	struct regmap *regmap;
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret =3D 0, irq;
> +	u32 clk_rate;

[ ... ]

> +	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK | CAN_CTRLMODE_L=
ISTENONLY |
> +				       CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_ONE_SHOT |
[Severity: Medium]
Does the driver actually support CAN_CTRLMODE_3_SAMPLES in hardware?

The driver advertises 3-samples mode here, allowing userspace to request it=
,=20
but functions like loongson_canfd_set_bittiming() and loongson_canfd_set_bt=
r()=20
do not appear to check for this flag or program the hardware appropriately=
=20
to use multiple samples.=20

Could this lead to silent failures to honor the user's requested configurat=
ion?

> +				       CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_FD |
> +				       CAN_CTRLMODE_PRESUME_ACK | CAN_CTRLMODE_FD_NON_ISO |
> +				       CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_CC_LEN8_DLC;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783670733.gi=
t.zhoubinbin@loongson.cn?part=3D1

