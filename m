Return-Path: <linux-can+bounces-6454-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM8AG8uCf2m6sQIAu9opvQ
	(envelope-from <linux-can+bounces-6454-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 01 Feb 2026 17:43:55 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA6CC688D
	for <lists+linux-can@lfdr.de>; Sun, 01 Feb 2026 17:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BD153001CFC
	for <lists+linux-can@lfdr.de>; Sun,  1 Feb 2026 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E303274FDB;
	Sun,  1 Feb 2026 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilEuMIyC"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF50A274B55;
	Sun,  1 Feb 2026 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769964210; cv=none; b=ecgiTMK1uanWhDmLIzi3VauPhXzs6yCZfkYGwNsN6DjczDFeW6jq5JQHvwEFAF3h19TKIECFeN2tfjYHSzLygMhg9BPhS9BgDClByn9esNcNUYgr/AC7Ol/IY/7PCV1IDeWgXchyO5ePldqSPk781aFP/j30NGWB6veM8jj6Ars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769964210; c=relaxed/simple;
	bh=YZPNXnO+Je5aQDUi3aiPGTbXVXRn6SUvcYsjdiGout4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yt/vSUq/J1wJ7shXplW1VgJW3YbrA7YOPhqBW0adB6/nzci0Qcc0gf1u9Yuo/crlOdt6u1Rnj4JhTEGrpaxo4v9Fs9kAAJe/ab8opaVDSdXaqN+Drh1b3P8IZfgoQ/FYJ0mbZg07rt0FAZaS5+hD73jJdTJm4Gei0H3EsBByZOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilEuMIyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EB7C19425;
	Sun,  1 Feb 2026 16:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769964210;
	bh=YZPNXnO+Je5aQDUi3aiPGTbXVXRn6SUvcYsjdiGout4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ilEuMIyCdQPH8PM+xVGDL9Ip+V1hdOi8piwWAagwUapkJyfcvI9OEm9MqivzQBP0E
	 k/jlnokdeszaZxyH+Qv6lQrhq2R0GYDQXB33YyElembNWrieht8GovEJWCeY5nQr+u
	 qvUhiOQPRg+RFoMVD/COyeQJ2rsteOBXlnKaUuhJShEAI1VXWKJJxTVooFllxjXQJj
	 EvuRnTnIa43D0chq322BxKq0v+VDV4EbFc9r1QlmjDbX3dtbx1jRwLG9ZMRk3ZWOVo
	 +XOJiQIK/3J+nv44FQMmN+6/KzxUKarSnx4gBfCw1PwZXc74TpOYlHEiTPNn2U1Ukz
	 kwRpaIpRGMc/Q==
Message-ID: <7be531be-bfef-48a0-be87-3426b1f3bbed@kernel.org>
Date: Sun, 1 Feb 2026 17:43:24 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] can: grcan: Add CANFD TX support alongside
 legacy CAN
To: Arun Muthusamy <arun.muthusamy@gaisler.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mkl@pengutronix.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
References: <20260128144921.5458-1-arun.muthusamy@gaisler.com>
 <20260128144921.5458-13-arun.muthusamy@gaisler.com>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20260128144921.5458-13-arun.muthusamy@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6454-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBA6CC688D
X-Rspamd-Action: no action

On 28/01/2026 at 15:49, Arun Muthusamy wrote:
> Include CANFD TX support with the legacy CAN support, enabling
> support for extended data payloads to provide higher bit rates.
> 
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> ---
>  drivers/net/can/grcan.c | 103 +++++++++++++++++++++++++++++-----------
>  1 file changed, 75 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index 3104946071dd..da0b5c129aae 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -174,6 +174,7 @@ struct grcan_registers {
>  #define GRCAN_IRQ_DEFAULT (GRCAN_IRQ_RX | GRCAN_IRQ_TX | GRCAN_IRQ_ERRORS)
> 
>  #define GRCAN_MSG_SIZE		16
> +#define GRCAN_CLASSIC_DATA_SIZE 8
> 
>  #define GRCAN_MSG_IDE		0x80000000
>  #define GRCAN_MSG_RTR		0x40000000
> @@ -195,6 +196,10 @@ struct grcan_registers {
>  #define GRCAN_MSG_OFF		0x00000002
>  #define GRCAN_MSG_PASS		0x00000001
> 
> +#define GRCAN_MSG_EID_MASK      GENMASK(28, 0)
> +#define GRCAN_MSG_BID_MASK      GENMASK(28, 18)
> +#define GRCAN_MSG_DLC_MASK      GENMASK(31, 28)
> +
>  #define GRCAN_BUFFER_ALIGNMENT		1024
>  #define GRCAN_DEFAULT_BUFFER_SIZE	1024
>  #define GRCAN_VALID_TR_SIZE_MASK	0x001fffc0
> @@ -227,6 +232,9 @@ struct grcan_registers {
>  #define GRCANFD_FDBTR_PS2_BIT 5
>  #define GRCANFD_FDBTR_SJW_BIT 0
> 
> +#define GRCAN_TX_BRS  BIT(25)
> +#define GRCAN_TX_FDF  BIT(26)
> +
>  /* Hardware capabilities */
>  struct grcan_hwcap {
>  	/* CAN-FD capable, indicates GRCANFD IP.
> @@ -1207,6 +1215,14 @@ static void grcan_transmit_catch_up(struct net_device *dev)
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  }
> 
> +static int grcan_numbds(int len)
> +{
> +	if (len <= GRCAN_CLASSIC_DATA_SIZE)
> +		return 1;
> +
> +	return 1 + DIV_ROUND_UP(len - GRCAN_CLASSIC_DATA_SIZE, GRCAN_MSG_SIZE);
> +}
> +
>  static int grcan_receive(struct net_device *dev, int budget)
>  {
>  	struct grcan_priv *priv = netdev_priv(dev);
> @@ -1389,15 +1405,22 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
>  				    struct net_device *dev)
>  {
>  	struct grcan_priv *priv = netdev_priv(dev);
> -	struct grcan_registers __iomem *regs = priv->regs;
> +	struct grcan_registers __iomem *regs;
> +	u32 eff, rtr, dlc, tmp, err, can_id;
>  	struct grcan_dma *dma = &priv->dma;
> -	struct can_frame *cf = (struct can_frame *)skb->data;
> +	u32 bds, copy_len, payload_offset;
>  	u32 id, txwr, txrd, space, txctrl;
> -	int slotindex;
> -	u32 *slot;
> -	u32 rtr, eff, dlc, tmp, err;
> +	struct canfd_frame *cfd;
> +	struct can_frame *cf;
>  	unsigned long flags;
> -	u32 oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
> +	u32 oneshotmode;
> +	u8 *payload;
> +	u32 *slot;
> +	u8 len;
> +	int i;
> +
> +	regs = priv->regs;
> +	oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
> 
>  	if (can_dev_dropped_skb(dev, skb))
>  		return NETDEV_TX_OK;
> @@ -1408,6 +1431,18 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
>  	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
>  		return NETDEV_TX_BUSY;
> 
> +	cfd = (struct canfd_frame *)skb->data;
> +	len = cfd->len;
> +	can_id  = cfd->can_id;
> +	payload = cfd->data;
> +
> +	if (can_is_canfd_skb(skb)) {
> +		dlc = can_fd_len2dlc(len);
> +	} else {
> +		cf = (struct can_frame *)skb->data;
> +		dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
> +	}
> +
>  	/* Reads of priv->eskbp and shut-downs of the queue needs to
>  	 * be atomic towards the updates to priv->eskbp and wake-ups
>  	 * of the queue in the interrupt handler.
> @@ -1416,9 +1451,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
> 
>  	txwr = grcan_read_reg(&regs->txwr);
>  	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
> -
> -	slotindex = txwr / GRCAN_MSG_SIZE;
> -	slot = dma->tx.buf + txwr;
> +	bds = grcan_numbds(len);
> 
>  	if (unlikely(space == 1))
>  		netif_stop_queue(dev);
> @@ -1434,24 +1467,39 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
>  		return NETDEV_TX_BUSY;
>  	}
> 
> -	/* Convert and write CAN message to DMA buffer */
> -	eff = cf->can_id & CAN_EFF_FLAG;
> -	rtr = cf->can_id & CAN_RTR_FLAG;
> -	id = cf->can_id & (eff ? CAN_EFF_MASK : CAN_SFF_MASK);
> -	dlc = cf->len;
> -	if (eff)
> -		tmp = (id << GRCAN_MSG_EID_BIT) & GRCAN_MSG_EID;
> -	else
> -		tmp = (id << GRCAN_MSG_BID_BIT) & GRCAN_MSG_BID;
> -	slot[0] = (eff ? GRCAN_MSG_IDE : 0) | (rtr ? GRCAN_MSG_RTR : 0) | tmp;
> +	payload_offset = 0;
> +	for (i = 0; i < bds; i++) {
> +		slot = dma->tx.buf + txwr;

It is hard to follow what is going on here. Please avoid this pointer
arithmetic on an opaque buffer.

Instead of having grcan_dma_buffer->buf being a void*, use a struct
which describes the actual layout of your memory. Something like that:


	struct grcan_msg {
		u32 msg_id;
		u32 dlc;
		u8 data[CANFD_MAX_DLEN];
	};

	struct grcan_dma_buffer {
		size_t size;
		struct grcan_msg *msg;
		dma_addr_t handle;
	};

(This is just for illustration purpose, I didn't double check the
offsets. Please adjust it to your actual needs).

Please introduce this in a seperate preparation patch.

> +		memset(slot, 0, GRCAN_MSG_SIZE);
> +
> +		if (i == 0) {

This should stay outside the loop. You should start to iterate with a
loop when handling the CAN frame payload, not before. Once you do the
refactor with the struct, this should become natural.

> +			eff = can_id & CAN_EFF_FLAG;
> +			rtr = can_id & CAN_RTR_FLAG;
> +			id = can_id & (eff ? CAN_EFF_MASK : CAN_SFF_MASK);
> +			if (eff)
> +				tmp = FIELD_PREP(GRCAN_MSG_EID_MASK, id);
> +			else
> +				tmp = FIELD_PREP(GRCAN_MSG_BID_MASK, id);
> +			slot[0] = (eff ? GRCAN_MSG_IDE : 0) | (rtr ? GRCAN_MSG_RTR : 0) | tmp;
> +			slot[1] = FIELD_PREP(GRCAN_MSG_DLC_MASK, dlc);
> +			if (can_is_canfd_skb(skb)) {
> +				slot[1] |= GRCAN_TX_FDF;
> +				if (cfd->flags & CANFD_BRS)
> +					slot[1] |= GRCAN_TX_BRS;
> +			}
> 
> -	slot[1] = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
> -	slot[2] = 0;
> -	slot[3] = 0;
> -	if (dlc > 0)
> -		memcpy(&slot[2], cf->data, sizeof(u32));
> -	if (dlc > 4)
> -		memcpy(&slot[3], cf->data + 4, sizeof(u32));
> +			copy_len = min(len, 8);
> +			memcpy(&slot[2], payload, copy_len);
> +			payload_offset += copy_len;
> +		} else {
> +			copy_len =  min(len - payload_offset, GRCAN_MSG_SIZE);
> +			memcpy(slot, payload + payload_offset, copy_len);
> +			payload_offset += copy_len;
> +		}
> +		txwr += GRCAN_MSG_SIZE;
> +		if (txwr >= dma->tx.size)
> +			txwr -= dma->tx.size;
> +	}
> 
>  	/* Checking that channel has not been disabled. These cases
>  	 * should never happen
> @@ -1493,8 +1541,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
>  	wmb();
> 
>  	/* Update write pointer to start transmission */
> -	grcan_write_reg(&regs->txwr,
> -			grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size));
> +	grcan_write_reg(&regs->txwr, txwr);
> 
>  	return NETDEV_TX_OK;
>  }


Yours sincerely,
Vincent Mailhol


