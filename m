Return-Path: <linux-can+bounces-7947-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dCwJOiPsRWruGgsAu9opvQ
	(envelope-from <linux-can+bounces-7947-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 06:42:11 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A116F36F3
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 06:42:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7947-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7947-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A726C302C140
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 04:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE71313E34;
	Thu,  2 Jul 2026 04:42:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC92FDDA9
	for <linux-can@vger.kernel.org>; Thu,  2 Jul 2026 04:42:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782967329; cv=none; b=Dx+4vvEU/R2O7k0d0F2dn5FYyfM2ltbaShW+CKquV0US/oclo8aj+ikNYrJDjnd5DebFCy05FF237P9EjeHTYnu4oE8sXuHM/oaDNN4+jPir8jH9s+Ty8leDLCMahruvE+u3gwNGPgmRnJhHnV1jFUZspXFiEEn3uTeEvGo9Q+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782967329; c=relaxed/simple;
	bh=YdmdVyxlY/SkwPdnuclaBCq9hvusQAU69XixNydsWtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBUljzs+BrUImtJ8ufb5A5/o+2uo4RWrTrqoz0lGF4IY6m/OljORjUGUb+ZlkHoksQiZPp5uKcs3upAUkjMoRd2kTKsogD9O3U+gbTlWk9CYY3/qb9kK/ED15pV0zCaZsrwIRAN3QWu40L+tIuk4i2rz1zzr37igoEJwWPFFyus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Received: from loongson.cn (unknown [223.64.68.155])
	by gateway (Coremail) with SMTP id _____8DxZvAW7EVqrsUAAA--.4453S3;
	Thu, 02 Jul 2026 12:41:58 +0800 (CST)
Received: from [10.161.0.102] (unknown [223.64.68.155])
	by front1 (Coremail) with SMTP id qMiowJDxxsAS7EVqWJS7AA--.1570S2;
	Thu, 02 Jul 2026 12:41:57 +0800 (CST)
Message-ID: <4510421b-ca73-4db7-b5bd-14e7f4ecb970@loongson.cn>
Date: Thu, 2 Jul 2026 12:41:53 +0800
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] can: Add Loongson CAN-FD controller driver
To: sashiko-reviews@lists.linux.dev
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>,
 Huacai Chen <chenhuacai@loongson.cn>, zhoubb.aaron@gmail.com
References: <cover.1782787997.git.zhoubinbin@loongson.cn>
 <b80d271f63f6318a4060220e8107785bd147f1bd.1782787997.git.zhoubinbin@loongson.cn>
 <20260630031622.14F981F000E9@smtp.kernel.org>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20260630031622.14F981F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJDxxsAS7EVqWJS7AA--.1570S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEQCGpErGUdRQAAsn
X-Coremail-Antispam: 1Uk129KBj9fXoW3ZF45Ww13AF47Gr4kKFyxXrc_yoW8WrW3Zo
	WfWwsavw4rKr15J34Dta4fJFy3X3Z5ur13ZrZxtr1DJF9IqF1j9r45uw4fJrWrAFWYgFn5
	Was5GayrCan7tF4fl-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYh7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxU2MKZDUUUU
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7947-lists,linux-can=lfdr.de];
	FREEMAIL_CC(0.00)[pengutronix.de,vger.kernel.org,kernel.org,hartkopp.net,loongson.cn,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:socketcan@hartkopp.net,m:chenhuacai@loongson.cn,m:zhoubb.aaron@gmail.com,m:zhoubbaaron@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhoubinbin@loongson.cn,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,loongson.cn:email,loongson.cn:mid,loongson.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05A116F36F3

Hi Vincent:

I've checked these issues and tried to provide solutions. Please check 
to see if they are correct.

On 2026/6/30 11:16, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 18 potential issue(s) to consider:
> - [High] Missing `skb` check in `CAN_STATE_ERROR_ACTIVE` case leads to a NULL pointer dereference.
> - [High] SKB allocation failure or invalid frame in RX path permanently stalls NAPI and corrupts RX FIFO.
> - [High] NAPI poll list corruption due to calling `napi_complete_done` while returning `quota`.
> - [High] Missing `napi_disable()` on error paths in `loongson_canfd_open()` leads to a kernel panic on subsequent open attempts.
> - [High] Race condition in `loongson_canfd_start_xmit` causes unexpected packet drops due to un-reaped TX buffers.
> - [High] Missing bounds check on the hardware-provided word count `REG_FRAME_META1_RWCNT` causes heap buffer overflow.
> - [High] Unchecked return value of `device_property_read_u32` leaves `clk_rate` uninitialized.
> - [High] Premature hardware restart on Bus-Off when auto-restart is configured.
> - [High] Bitwise NOT on a 16-bit variable unintentionally unmasks all interrupts due to integer promotion.
> - [High] Overwriting of `isr` variable causes lost error interrupts and permanent interrupt masking.
> - [High] Using `regmap_update_bits` on command-style SET/CLR registers causes conflicting hardware commands.
> - [High] Calling `kfree_skb()` with hardware interrupts disabled.
> - [High] Potential infinite loop in TX interrupt handler due to repeated status reads of posted writes.
> - [Medium] The driver advertises 'hardware timestamping' in commit message but does not implement it.
> - [Medium] `ndev->stats.rx_errors` is modified concurrently from both hardirq and NAPI softirq contexts without locking.
> - [Medium] Incorrect check for RTR frames causes invalid RX byte statistics.
> - [Medium] Missing `cf->len8_dlc` assignment for Classic CAN frames.
> - [Low] Syntax error due to variable declarations immediately following a switch case label.
> --
> 
> commit e0d474f047900e47a73eaa207fc07dd8c35084bf
> Author: Binbin Zhou <zhoubinbin@loongson.cn>
> Subject: can: Add Loongson CAN-FD controller driver
> 
> This commit adds support for the CAN-FD controller integrated into
> Loongson-2K series SoCs. It implements NAPI for the RX path, TX buffer
> management, bus error reporting, and various timing configurations.
> 
> [Severity: Medium]
> The commit message states the driver supports hardware timestamping, but is
> this functionality actually implemented? Looking at the driver code, it sets
> ethtool_op_get_ts_info but does not seem to extract the timestamp field from
> the hardware or write to skb_hwtstamps in the receive path.

Hardware timestamps are not supported at this time; I will rewrite the 
commit.
> 
>> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_canfd.c
>> new file mode 100644
>> index 0000000000000..1c7381129c2b6
>> --- /dev/null
>> +++ b/drivers/net/can/loongson_canfd.c
> [ ... ]
>> @@ -891,37 +891,24 @@ static int loongson_canfd_chip_start(struct net_device *ndev)
> [ ... ]
>> +	/* Configure interrupts */
>> +	int_ena = REG_INT_STAT_RBNEI | REG_INT_STAT_TXBHCI |
>> +		  REG_INT_STAT_EWLI | REG_INT_STAT_FCSI;
>> +
>> +	/* Bus error reporting */
>> +	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
>> +		int_ena |= REG_INT_STAT_ALI | REG_INT_STAT_BEI;
>> +
>> +	/* It's after reset, so there is no need to clear anything */
>> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, ~int_ena);
> 
> [Severity: High]
> Will this bitwise NOT operation unmask all interrupts on the controller?
> Because int_ena is a 16-bit unsigned integer, the bitwise NOT causes integer
> promotion to a 32-bit signed int, filling the upper 16 bits with 1s. Since
> the upper bits of this register clear the mask, does this unintentionally
> enable every possible interrupt?

Use FIELD_GET(REG_INT_MASK_SET, ~int_ena) instsed.
> 
>> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_ENA, int_ena);
> [ ... ]
>> @@ -1048,46 +1048,22 @@ static netdev_tx_t loongson_canfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
> [ ... ]
>> +	for_each_clear_bit(i, &tx_brp, LOONGSON_CANFD_TXBUF_NUM) {
>> +		u32 transmission_complete_mask = 0x3 << (i * 2);
>> +
>> +		if (!(tx_bs & transmission_complete_mask)) {
>> +			buf_id = i;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!loongson_canfd_insert_frame(priv, cf, buf_id, can_is_canfd_skb(skb))) {
>> +		netdev_err(ndev, "TXNF set but cannot insert frame into TXTB! HW Bug?");
>> +		kfree_skb(skb);
> 
> [Severity: High]
> Could a race condition here cause silent packet drops? The hardware clears
> tx_brp immediately on completion, but tx_bs is cleared later in the ISR.
> If all inactive buffers are awaiting a reap, the loop finishes without
> finding a buffer, leaving buf_id at 0. This would cause the insert check to
> fail, dropping the packet while incorrectly returning NETDEV_TX_OK.
> 
> [Severity: High]
> Is it safe to call kfree_skb here? The tx_lock is held with
> spinlock_irqsave which disables local interrupts. Calling kfree_skb with
> hard interrupts disabled can lead to kernel warnings and potential deadlocks.
> Should this use dev_kfree_skb_any instead?
> 
>> +		ndev->stats.tx_dropped++;
>> +		return NETDEV_TX_OK;
>> +	}
> [ ... ]
>> @@ -1105,37 +1105,25 @@ static void loongson_canfd_read_rx_frame(struct loongson_canfd_priv *priv, struct canfd_frame *cf,
> [ ... ]
>> +	/* Data Length Code */
>> +	len = FIELD_GET(REG_FRAME_META1_DLC, meta1);
>> +	if (len > 8) {
>> +		if (meta1 & REG_FRAME_META1_FDF)
>> +			len = wc << 2;
>> +		else
>> +			len = 8;
>> +	}
>> +
>> +	cf->len = len;
> 
> [Severity: Medium]
> Does this properly support the CAN_CTRLMODE_CC_LEN8_DLC feature? For Classic
> CAN frames with a DLC greater than 8, the length is appropriately capped to
> 8, but the original DLC is not saved to cf->len8_dlc. This might break
> userspace protocols that rely on the original DLC data.

Yes, I should use the relevant standard APIs, as follows:

         /* Data Length Code */
         dlc = FIELD_GET(REG_FRAME_META1_DLC, meta1);
         if (is_can_fd)
                 cfd->len = can_fd_dlc2len(dlc);
         else
                 can_frame_set_cc_len(ccf, dlc, priv->can.ctrlmode);


> 
>> +	if (unlikely(len > wc * LOONGSON_CANFD_DW_BYTE))
>> +		len = wc * LOONGSON_CANFD_DW_BYTE;
>> +
>> +	/* Data */
>> +	for (i = 0; i < len; i += LOONGSON_CANFD_DW_BYTE)
>> +		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, (u32 *)(cf->data + i));
> 
> [Severity: High]
> Can a malformed hardware word count cause a heap buffer overflow? The len
> variable is checked against the hardware-provided word count, but not against
> CANFD_MAX_DLEN. If the hardware yields an invalid read word count, the length
> could exceed the 64-byte payload limit, causing out of bounds memory writes
> to the skb data.

I think using the method described above to obtain `cf->len` should 
resolve this issue.
> 
> [ ... ]
>> @@ -1164,28 +1164,22 @@ static int loongson_canfd_rx(struct net_device *ndev)
> [ ... ]
>> +	/* Flexible Data-rate Format */
>> +	if (meta1 & REG_FRAME_META1_FDF)
>> +		skb = alloc_canfd_skb(ndev, &cf);
>> +	else
>> +		skb = alloc_can_skb(ndev, (struct can_frame **)&cf);
>> +	if (unlikely(!skb))
>> +		return 0;
> 
> [Severity: High]
> If the skb allocation fails, does returning 0 early permanently stall the
> NAPI loop? Since the rest of the data payload is not read from the hardware
> FIFO, the RX stream might desynchronize. Also, returning 0 here causes the
> caller to exit its loop without completing NAPI, potentially leaving it
> permanently in a scheduled state.
> 
>> +
>> +	loongson_canfd_read_rx_frame(priv, cf, meta0, meta1);
>> +
>> +	if (cf->can_id != CAN_RTR_FLAG)
>> +		stats->rx_bytes += cf->len;
> 
> [Severity: Medium]
> Is this RTR check accurate? The can_id field contains both the CAN ID and
> the flags, so a direct inequality comparison to CAN_RTR_FLAG might evaluate
> true for almost all RTR frames, erroneously inflating the RX byte statistics
> for frames with no actual payload.

Emm, it should be:

if (!(cf->can_id & CAN_RTR_FLAG))
> 
> [ ... ]
>> @@ -1203,32 +1203,26 @@ static enum can_state loongson_canfd_read_fault_state(struct net_device *ndev)
> [ ... ]
>> +	switch (FIELD_GET(REG_FSTAT_MASK, fstat)) {
>> +	case REG_FSTAT_ERA:
>> +		u32 ewl, erl, rec_tec, max_tec;
> 
> [Severity: Low]
> Will this compile on strict C11 compilers? The C11 standard does not allow
> variable declarations immediately following a switch case label.
> 
> [ ... ]
>> @@ -1278,82 +1278,28 @@ static void loongson_canfd_err_interrupt(struct net_device *ndev, u32 isr)
> [ ... ]
>> +	if ((isr & REG_INT_STAT_FCSI) || (isr & REG_INT_STAT_EWLI)) {
>> +		netdev_info(ndev, "state changes from %s to %s\n",
>> +			    can_get_state_str(priv->can.state), can_get_state_str(state));
>> +
>> +		if (priv->can.state == state)
>> +			netdev_warn(ndev, "cur and pre state is the same!(miss intr?)\n");
>> +
>> +		isr = REG_INT_STAT_FCSI | REG_INT_STAT_EWLI;
> 
> [Severity: High]
> Does overwriting the isr variable here permanently disable other interrupts?
> If arbitration lost or bus error flags are pending, this assignment destroys
> them. Later in the function, isr is shifted to unmask interrupts, meaning the
> erased flags will never be unmasked again.
> 
>> +		priv->can.state = state;
>> +		switch (state) {
>> +		case CAN_STATE_BUS_OFF:
>> +			priv->can.can_stats.bus_off++;
>> +			if (priv->can.restart_ms)
>> +				regmap_write(priv->regmap, LOONGSON_CANFD_CMD,
>> +					     REG_CMD_ERCRST);
> 
> [Severity: High]
> Does this prematurely restart the hardware upon a bus-off event? Instantly
> writing the error reset command clears the hardware error state and rejoins
> the bus immediately, ignoring the restart delay contract enforced by the core
> can_bus_off timer.

The meaning of `REG_CMD_ERCRST` is as follows:
Used to clear the error count while waiting for the controller to rejoin 
the bus after entering `BUS_OFF`.
A `1` can be written to this register at any time before or after 
entering `BUS_OFF`; it takes effect once and then becomes invalid.

This command is used only to reset the count and does not affect the reboot.
> 
> [ ... ]
>> +		case CAN_STATE_ERROR_ACTIVE:
>> +			cf->can_id |= CAN_ERR_CNT;
>> +			cf->data[1] = CAN_ERR_CRTL_ACTIVE;
>> +			cf->data[6] = bec.txerr;
> 
> [Severity: High]
> Could this lead to a null pointer dereference? The alloc_can_err_skb call
> earlier in the function can fail and leave cf uninitialized. While the other
> switch cases check if skb is valid before modifying cf data, this case does
> not, which would crash if memory pressure prevents allocation.

Add skb check, as follows:

if (skb) {
	cf->can_id |= CAN_ERR_CNT;
	cf->data[1] = CAN_ERR_CRTL_ACTIVE;
	cf->data[6] = bec.txerr;
	cf->data[7] = bec.rxerr;
}

> 
> [ ... ]
>> +	/* Check for Bus Error interrupt */
>> +	if (isr & REG_INT_STAT_BEI) {
>> +		isr = REG_INT_STAT_BEI;
>> +		netdev_err(ndev, "Bus Error interrupt\n");
>> +		priv->can.can_stats.bus_error++;
>> +		stats->rx_errors++;
> 
> [Severity: Medium]
> Is it safe to increment stats->rx_errors without locking here? This counter
> is modified from hardirq context here and concurrently from softirq context
> in the NAPI poll routine, which could cause lost increments due to data races
> on 32-bit systems.
> 
> [ ... ]
>> @@ -1391,37 +1391,25 @@ static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
> [ ... ]
>> +	/* Check for RX FIFO Overflow */
>> +	regmap_read(priv->regmap, LOONGSON_CANFD_STAT, &sts);
>> +	if (sts & REG_STAT_DOR) {
>> +		struct net_device_stats *stats = &ndev->stats;
>> +		struct can_frame *cf;
>> +		struct sk_buff *skb;
>> +
>> +		netdev_info(ndev, "Loongson canfd RX overflow\n");
>> +		stats->rx_over_errors++;
>> +		stats->rx_errors++;
> 
> [Severity: Medium]
> As noted above, stats->rx_errors is updated concurrently in both softirq and
> hardirq contexts without locking.
> 
> [ ... ]
>> +	if (rxbuf_is_empty && ret != 0) {
>> +		if (napi_complete_done(napi, work_done)) {
> 
> [Severity: High]
> Should this check if work_done is less than quota? If exactly quota frames
> are processed and the hardware buffer becomes empty, this logic calls
> napi_complete_done and then returns quota to the networking core. Returning
> the full quota instructs the core to reschedule the instance, but the state
> has already been manipulated, which can corrupt the NAPI poll list.
> 
> [ ... ]
>> @@ -1425,33 +1425,18 @@ static void loongson_canfd_tx_interrupt(struct net_device *ndev)
> [ ... ]
>> +	while ((buf_id = loongson_canfd_get_txbuf_id(priv, &sts)) < LOONGSON_CANFD_TXBUF_NUM) {
>> +		switch (sts) {
>> +		case TX_BS_VALID:
>> +			stats->tx_bytes += can_get_echo_skb(ndev, buf_id, NULL);
>> +			stats->tx_packets++;
>> +			break;
> 
> [Severity: High]
> Could this result in an inescapable infinite loop? When the driver writes a
> clear command to the posted MMIO register at the end of the loop, it
> immediately reads the status register back in the while condition. Because
> the hardware takes cycles to clear the bit, the old status is read, causing
> the driver to repeatedly process the same buffer and spin in the ISR.
> 
>> +		case TX_BS_FAIL:
>> +			u32 cnt;
> 
> [Severity: Low]
> Similar to the fault state read function, this violates C11 syntax by
> declaring a variable immediately following a switch case label.
> 
> [ ... ]
>> @@ -1584,20 +1584,14 @@ static void loongson_canfd_chip_stop(struct net_device *ndev)
>>   {
>>   	struct loongson_canfd_priv *priv = netdev_priv(ndev);
>>   
>>   	/* Disable interrupts and disable CAN */
>>   	regmap_update_bits(priv->regmap, LOONGSON_CANFD_INT_ENA, REG_INT_ENA_CLR, REG_INT_ENA_CLR);
>>   	regmap_update_bits(priv->regmap, LOONGSON_CANFD_INT_MASK,
>>   			   REG_INT_MASK_SET, REG_INT_MASK_SET);
> 
> [Severity: High]
> Are these regmap_update_bits calls safe for W1S/W1C command registers? This
> function reads the current 1s from the lower half of INT_ENA and writes them
> back along with the clear mask in the upper half, which commands the hardware
> to simultaneously set and clear the exact same interrupts.

Use `regmap_write()` directly, as follows:

static void loongson_canfd_disable_interrupts(struct loongson_canfd_priv 
*priv)
{
         regmap_write(priv->regmap, LOONGSON_CANFD_INT_ENA, 
FIELD_MAX(REG_INT_ENA_CLR) << 16);
         regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, 
FIELD_MAX(REG_INT_MASK_SET));
}

> 
> [ ... ]
>> @@ -1604,45 +1604,22 @@ static int loongson_canfd_open(struct net_device *ndev)
> [ ... ]
>> +err_chip_start:
>> +	free_irq(ndev->irq, ndev);
>> +err_irq:
>> +	close_candev(ndev);
>> +	return ret;
>> +}
> 
> [Severity: High]
> Are we missing a napi_disable call on these error paths? If the driver fails
> to open, the candev is closed but NAPI is left enabled. A subsequent attempt
> to bring the interface up will call napi_enable on an already enabled
> instance, triggering a BUG_ON in the core.

Update as follows:

exit_free_irq:
         free_irq(ndev->irq, ndev);
exit_napi_disable:
         napi_disable(&priv->napi);
         close_candev(ndev);
         return ret;

> 
> [ ... ]
>> @@ -1690,46 +1690,24 @@ static int loongson_canfd_probe(struct platform_device *pdev)
> [ ... ]
>> +	regmap = devm_regmap_init_mmio(dev, base, &loongson_cangfd_regmap);
>> +	if (IS_ERR(regmap))
>> +		return PTR_ERR(regmap);
>> +
>> +	device_property_read_u32(dev, "clock-frequency", &clk_rate);
>> +
>> +	irq = platform_get_irq(pdev, 0);
> 
> [Severity: High]
> Should the return value of device_property_read_u32 be checked? If the
> property is missing, clk_rate retains uninitialized stack garbage which is
> then assigned to priv->can.clock.freq, leading to unpredictable hardware
> timing.
> 

Update as follows:

ret = device_property_read_u32(dev, "clock-frequency", &clk_rate);
         if (ret)
                 return dev_err_probe(dev, ret, "Missing clock-frequency 
property\n");


-- 
Thanks.
Binbin


