Return-Path: <linux-can+bounces-7789-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 85foIzVgKGqzCwMAu9opvQ
	(envelope-from <linux-can+bounces-7789-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 20:49:25 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 015AD663699
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 20:49:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gnlYuEGa;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7789-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7789-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06440302293D
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 18:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8207D331EC9;
	Tue,  9 Jun 2026 18:49:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AE8363094
	for <linux-can@vger.kernel.org>; Tue,  9 Jun 2026 18:49:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030961; cv=none; b=eMTU+yICsJg+Ehdkwn+EzZNioFcyn9VTDBKSR5G2knxAck693r/62MBLjCeSg73h4ajirotY0T7siRi0oa38vxOVyPWq2X/XmxY3r231XcJpjHXzAKQOJnYHOFmnZEKqsK9ysqveN2GEz6f4Mun+I6d/FNZEE9T/LbPDebSg7Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030961; c=relaxed/simple;
	bh=tZt73r2uHlf5IP11UKeGR2+7Rpf8UzbybVhd0498/a0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fk0e9bg2RGSo4eAQVyp6hrPXT7focZqn1GjexM7b6PwMmb4+TKkRLpHSIU/pnnlBmLs2WFnQpK1KSnhON0m62tYf2zhxQKqg8mJGJfVxXstfgBMB4qW8qKKQKWtITjZhIrtp0ZJAjdayy0Pml8adHQA4iLMw9o9vbRKd/5maREg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnlYuEGa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342881F00893;
	Tue,  9 Jun 2026 18:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781030959;
	bh=igbOUNO1BacUW/CBsFmZKhk9REOp74elGGlD72JkoR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gnlYuEGaFmDsb3yiUQo+WESOdsuZ3dAVpeyWoH5vbJ32efMn4q1eGxUinAyp71x6J
	 SXd1JnEyMUpw1jKonDJc395iHvGChXNM3PxLm9NMj8AIt+G1tk9ylGhPLZaQVID7yV
	 eyQJ1aebEvlc4yOl7Uuikbg39YzBEeRWh+0ggnF8XZ9fAqlgPaI7BQ808p//+Qwbb2
	 G4iizAjGg/O11EUBYm7Uaq5YTygOy7acF0PM6soBXZj1cDWfORZ0Bt65qj7/c32KCD
	 1g1kbZR8MFwTLB3Iw+1YlH6eEdUKS9RyBWRia2XsgTqiubQW3YtHAsvfkFzRjIzjZ4
	 k8herBJCYuhPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] can: Add Loongson CAN-FD controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <ed069249061d105d72d2115b8a05216a60cebffb.1780908445.git.zhoubinbin@loongson.cn>
References: <ed069249061d105d72d2115b8a05216a60cebffb.1780908445.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:49:18 +0000
Message-Id: <20260609184919.342881F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7789-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhoubinbin@loongson.cn,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:socketcan@hartkopp.net,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 015AD663699

Thank you for your contribution! Sashiko AI review found 14 potential issue=
(s) to consider:
- [Critical] Missing bounds checks on the hardware-provided RX word count (=
`RWCNT`) causes severe heap buffer overflow.
- [High] Uninitialized variable `buf_id` in `loongson_canfd_start_xmit()` c=
auses packet drops and potential out-of-bounds array access.
- [High] Unhandled Bus Error Interrupts (BEI) and overwritten ISR variables=
 lead to permanent loss of interrupts and device lockup.
- [High] Missing NULL pointer check in `CAN_STATE_ERROR_ACTIVE` handling ca=
uses a kernel panic.
- [High] Failing to drain the RX FIFO upon SKB allocation failure permanent=
ly desynchronizes the controller's packet stream.
- [High] Incorrect NAPI exit logic causes list corruption when `work_done =
=3D=3D quota`.
- [High] The NAPI poll loop permanently stalls the RX path if `loongson_can=
fd_rx()` encounters an error.
- [High] Race condition in driver initialization permanently drops RX capab=
ility if an interrupt fires early.
- [High] The driver misuses strictly reserved SocketCAN UAPI fields, corrup=
ting the length indicator for Classic CAN frames.
- [High] Syntax Error: Declarations immediately follow a label, violating C=
11 standard requirements.
- [High] The driver violates the SocketCAN standard by prematurely resettin=
g the hardware error counters upon entering BUS_OFF.
- [Medium] Incorrect logic in `loongson_canfd_txbuf_freed` forces a strict =
queue depth of 1, severely degrading transmission throughput.
- [Medium] Polling of MMIO asynchronous TX status without proper flow contr=
ol risks processing the same transmission multiple times.
- [Medium] Lost increments on `stats->rx_errors` across softirq and hardirq=
 contexts.
--

commit da73fa842fa0bacd63f1ec58f9a813c7b28476d3
Author: Binbin Zhou <zhoubinbin@loongson.cn>
Subject: can: Add Loongson CAN-FD controller driver

Add support for the CAN-FD controller integrated into Loongson-2K series
SoCs. The controller supports both Classic CAN and CAN FD, with up to 8
transmit buffers, hardware timestamping, error counters, and various
control modes (loopback, listen-only, one-shot, non-ISO FD, etc.).

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> new file mode 100644
> index 0000000000000..3794700e04c8d
> --- /dev/null
> +++ b/drivers/net/can/loongson_canfd.c

[ ... ]

> +static bool loongson_canfd_txbuf_freed(struct loongson_canfd_priv *priv)
> +{
> +	return !regmap_test_bits(priv->regmap, LOONGSON_CANFD_TX_STAT, REG_TX_S=
TAT_BRP);
> +}

[Severity: Medium]
Does this logic overly restrict the transmission queue? Since regmap_test_b=
its()
returns true if ANY bit is set in the mask, checking it with ! means this
returns true only when ALL hardware buffers are completely free. This force=
s a
strict queue depth of 1 and prevents utilizing the 8-buffer hardware pipeli=
ne.

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

[Severity: High]
What happens in loongson_canfd_start_xmit() if the conditional
!(tx_bs & transmission_complete_mask) is false for all clear bits?

The loop would exit without assigning a value to buf_id. Passing an
uninitialized buf_id to loongson_canfd_insert_frame() could lead to silent
packet drops or unpredictable out-of-bounds array access.

[ ... ]

> +	/* Timesamp */
> +	cf->__res0 =3D meta1;
> +	cf->__res1 =3D meta1 >> 8;

[Severity: High]
Is it safe to write to cf->__res1 here?

For Classic CAN frames, alloc_can_skb() returns a struct can_frame where the
offset of __res1 physically aliases with the len8_dlc field. Overwriting th=
is
memory corrupts the length indicator for 8-byte frames in the upstream
networking stack.

[ ... ]

> +	cf->len =3D len;
> +	if (unlikely(len > wc * LOONGSON_CANFD_DW_BYTE))
> +		len =3D wc * LOONGSON_CANFD_DW_BYTE;
> +
> +	/* Data */
> +	for (i =3D 0; i < len; i +=3D LOONGSON_CANFD_DW_BYTE) {

[Severity: Critical]
Is it possible for the hardware-provided RX word count to exceed expected
bounds here?=20

The wc variable is derived from RWCNT - 2. If RWCNT is large, len could exc=
eed
CANFD_MAX_DLEN, leading to a massive buffer overflow when writing directly
into cf->data. Furthermore, if RWCNT is 0 or 1, wc would underflow, resulti=
ng
in an infinite loop and massive memory corruption.

[ ... ]

> +	/* Flexible Data-rate Format */
> +	if (meta1 & REG_FRAME_META1_FDF)
> +		skb =3D alloc_canfd_skb(ndev, &cf);
> +	else
> +		skb =3D alloc_can_skb(ndev, (struct can_frame **)&cf);
> +	if (unlikely(!skb))
> +		return -ENOMEM;

[Severity: High]
If this allocation fails, loongson_canfd_rx() returns early without draining
the remaining data payload words for this frame from the RX FIFO. Will this
leave unread payload words in the stream that get mistakenly parsed as meta=
data
headers for the next frame, permanently misaligning the parser?

[ ... ]

> +	switch (FIELD_GET(REG_FSTAT_MASK, fstat)) {
> +	case REG_FSTAT_ERA:
> +		u32 ewl, erl, rec_tec, max_tec;

[Severity: High]
Does this compile? Under the C11 standard (-std=3Dgnu11), a label cannot be
followed immediately by a variable declaration. This needs to be wrapped in=
 a
block or the variables must be declared earlier.

[ ... ]

> +		if (priv->can.state =3D=3D state)
> +			netdev_warn(ndev, "cur and pre state is the same!(miss intr?)\n");
> +
> +		isr =3D REG_INT_STAT_FCSI | REG_INT_STAT_EWLI;
> +		priv->can.state =3D state;

[Severity: High]
Overwriting the isr variable here discards any other concurrent interrupt
flags (such as REG_INT_STAT_ALI) that were present. Since this function
later writes the overwritten isr value to LOONGSON_CANFD_INT_MASK, does
this permanently fail to unmask those erased interrupts?

> +		switch (state) {
> +		case CAN_STATE_BUS_OFF:
> +			priv->can.can_stats.bus_off++;
> +			if (priv->can.restart_ms)
> +				regmap_write(priv->regmap, LOONGSON_CANFD_CMD,
> +					     REG_CMD_ERCRST);

[Severity: High]
Does issuing a hardware reset immediately upon detecting BUS_OFF bypass the
standard CAN bus backoff mechanism?

The kernel's CAN core manages the auto-restart delay using a timer for
restart_ms. Resetting the controller's error counters here causes it to rej=
oin
the bus immediately, bypassing the configured recovery delay.

[ ... ]

> +		case CAN_STATE_ERROR_ACTIVE:
> +			cf->can_id |=3D CAN_ERR_CNT;
> +			cf->data[1] =3D CAN_ERR_CRTL_ACTIVE;

[Severity: High]
If alloc_can_err_skb() failed earlier due to memory pressure, cf will be
NULL here. The other error state cases guard their writes with if (skb), but
this case writes unconditionally, which would cause a kernel panic.

[ ... ]

> +	/* Check for Bus Error interrupt */
> +	if (isr & REG_INT_STAT_BEI) {
> +		isr =3D REG_INT_STAT_BEI;
> +		netdev_err(ndev, "Bus Error interrupt\n");
> +		priv->can.can_stats.bus_error++;
> +		stats->rx_errors++;

[Severity: Medium]
Could this increment of stats->rx_errors race with the identical increment =
in
loongson_canfd_rx_napi()?=20

This runs in hardirq context, while the other runs in softirq context. A ha=
rdirq
interrupting the softirq's read-modify-write cycle on the exact same statis=
tic
could cause the hardirq's increment to be overwritten and lost.

[ ... ]

> +	while (rx_frc && work_done < quota && ret > 0) {
> +		ret =3D loongson_canfd_rx(ndev);

[Severity: High]
If loongson_canfd_rx() encounters an error (e.g. -ENOMEM), ret becomes nega=
tive
and the loop terminates early. Because rx_frc remains non-zero, the logic b=
elow
will skip napi_complete_done() and return work_done < quota.

Returning less than the quota without completing NAPI puts it into an inval=
id
state, removing the device from the poll list but leaving the SCHED bit set,
which will silently stall the RX path.

[ ... ]

> +		netdev_info(ndev, "Loongson canfd RX overflow\n");
> +		stats->rx_over_errors++;
> +		stats->rx_errors++;

[Severity: Medium]
As mentioned earlier, could this unprotected increment in softirq context r=
ace
with the identical increment in the hardirq error handler, resulting in lost
updates to stats->rx_errors?

[ ... ]

> +	if (!rx_frc && ret !=3D 0) {
> +		if (napi_complete_done(napi, work_done)) {

[Severity: High]
Is it safe to call napi_complete_done() when work_done equals quota?

If the FIFO happens to empty on exactly the last frame of the budget, this =
will
call napi_complete_done() and still return quota to the caller. Returning q=
uota
indicates to the core networking stack that the driver consumed its budget =
and
remains scheduled, but napi_complete_done() detaches it from the poll list,
leading to list corruption.

[ ... ]

> +	guard(spinlock_irqsave)(&priv->tx_lock);
> +
> +	while ((buf_id =3D loongson_canfd_get_txbuf_id(priv, &sts)) < LOONGSON_=
CANFD_TXBUF_NUM) {
> +		switch (sts) {

[Severity: Medium]
Could this tight loop re-process the exact same TX buffer multiple times?

The loop sends a hardware clean command (TXT_CMD_SR_CLEAN) at the end of the
iteration and immediately polls the live status via loongson_canfd_get_txbu=
f_id()
on the next pass. Since MMIO propagation may take multiple cycles, the read=
 might
fetch the un-cleared stale status, leading to redundant register writes and
double increments of stats->tx_packets.

> +		case TX_BS_FAIL:
> +			u32 cnt;

[Severity: High]
Similar to the error handler earlier, does this code compile under C11? A
variable declaration immediately following a case label is a syntax error.

[ ... ]

> +		/* Error interrupts */
> +		imask =3D isr & REG_INT_STAT_ERRORI;

[Severity: High]
Does this logic handle Bus Error Interrupts (BEI) correctly?

REG_INT_STAT_BEI is enabled during setup, but it is not included in the
REG_INT_STAT_ERRORI mask. Consequently, if a BEI fires, imask evaluates to =
0,
skipping the handler and failing to clear the interrupt in the hardware, wh=
ich
would generate an interrupt storm and lock up the device.

[ ... ]

> +	netdev_info(ndev, "loongson_canfd_device registered\n");
> +	napi_enable(&priv->napi);
> +	netif_start_queue(ndev);

[Severity: High]
Is there a race condition between unmasking the hardware interrupts and ena=
bling
NAPI?

loongson_canfd_chip_start() fully arms the hardware interrupts before
napi_enable() is called. If a frame is received in this narrow window, the =
ISR
will fire, mask the interrupt, and call napi_schedule(). Since NAPI is still
disabled, the schedule request is silently ignored. When napi_enable()
subsequently executes, the interrupt remains masked, resulting in a complet=
ely
dead RX path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780908445.gi=
t.zhoubinbin@loongson.cn?part=3D1

