Return-Path: <linux-can+bounces-6606-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1kWRBrggm2k1tQMAu9opvQ
	(envelope-from <linux-can+bounces-6606-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 22 Feb 2026 16:28:56 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A22A116F862
	for <lists+linux-can@lfdr.de>; Sun, 22 Feb 2026 16:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E27300E718
	for <lists+linux-can@lfdr.de>; Sun, 22 Feb 2026 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7825633859C;
	Sun, 22 Feb 2026 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa9a9yGy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDEC19C542;
	Sun, 22 Feb 2026 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771774133; cv=none; b=fHyMXWBdJkiUJ+BsQPwJQojwVmM+Geciy3iYX+gwgpiPwtOEiiRBlNZZhRiXZhw+EiiCbcE9DJGBYyURDS0AgZD3BNAuoUdDKsXb3/wsq6tBncO8DRHbrdFRqMBGLbpplO5ofEi7k5s6dmjXaHGYddlE1ZwHewgEU8CJvxRft7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771774133; c=relaxed/simple;
	bh=q2cGKKdvla+o+4FtJpmFvQN0eovG0cAnAAbWAwEI4ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9oFFdfHeqj9K+9dkqIhl8UDfvPDFI8F0P3lppFtXJ4iV0qXDfH0bcZsA8ddpKoxfIFeGY1d8DeR7VYpFDpCDaxvwI1jJgCBjSL8ptVfS6fkTs7PSyeKFcCWPf9KK+hpvxE7eBhK4KqbWJz+9NDxBC74oGTf0UbPPgu2jv+OiAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa9a9yGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1C8C19424;
	Sun, 22 Feb 2026 15:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771774132;
	bh=q2cGKKdvla+o+4FtJpmFvQN0eovG0cAnAAbWAwEI4ls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fa9a9yGySJ3nBtMygNhU9EE+Efxqjz060+aJV/YQyvZxndGu9fPmWth1j/iQI+cfg
	 GjgrvpOhGZoT3/nmLsz4/EEmrwXWTuamPTx48p7ZH9k67pLeXPD5GYK9/MsDgcKOlY
	 BEtP8mgSBOVkPWYuvjVav5seWdw7GebrNo0mN7WymZGLeLBVK7fy70RswNI1yf4wTu
	 8OOMAggMPFJqg0dNLGQWYjc5xcUlDk72TK0IekM4jQnbK5nT0KwIlfSiB4vMwEVLi3
	 5TW7qxZLPAx+RBC/5eNpo6CAubLcEvqQcGzASAkIpyez1DxfsrRRDLjZ7PvDap7bG4
	 HQtCMoGBGQJJA==
Message-ID: <4fb9e8fa-8bc1-42da-a173-bb8f84e266b6@kernel.org>
Date: Sun, 22 Feb 2026 16:28:48 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/16] can: grcan: Add CANFD TX support alongside
 legacy CAN
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mkl@pengutronix.de
References: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
 <20260216135344.23246-14-arun.muthusamy@gaisler.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20260216135344.23246-14-arun.muthusamy@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6606-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A22A116F862
X-Rspamd-Action: no action

On 16/02/2026 at 14:53, Arun Muthusamy wrote:
> Include CANFD TX support with the legacy CAN support, enabling
> support for extended data payloads to provide higher bit rates.
> 
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> ---
>  drivers/net/can/grcan.c | 111 ++++++++++++++++++++++++++++++----------
>  1 file changed, 85 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index 28fa219e1c3b..ae9f6fd4c8bf 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -196,6 +196,10 @@ struct grcan_registers {
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
> @@ -228,6 +232,9 @@ struct grcan_registers {
>  #define GRCANFD_FDBTR_PS2_BIT 5
>  #define GRCANFD_FDBTR_SJW_BIT 0
>  
> +#define GRCAN_TX_BRS  BIT(25)
> +#define GRCAN_TX_FDF  BIT(26)
> +
>  /* Hardware capabilities */
>  struct grcan_hwcap {
>  	/* CAN-FD capable, indicates GRCANFD IP.
> @@ -1222,6 +1229,19 @@ static void grcan_transmit_catch_up(struct net_device *dev)
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
> +static inline union grcan_msg_slot *grcan_tx_msg_slot(struct grcan_dma *dma, u32 off)
> +{
> +	return (union grcan_msg_slot *)((u8 *)dma->tx.msg_slot + off);
> +}
> +
>  static int grcan_receive(struct net_device *dev, int budget)
>  {
>  	struct grcan_priv *priv = netdev_priv(dev);
> @@ -1404,15 +1424,23 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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

All the slot refactor is not part of adding CANFD support. It should
be squashed in previous patch:

  can: grcan: Refactor GRCAN DMA buffer to use structured memory layout

As a result, it is hard to understand which part of this patch is
related to struct grcan_dma_buffer refactor and which part is the
introduction of the new CAN FD feature.

> -	u32 rtr, eff, dlc, tmp, err;
> +	union grcan_msg_slot *msg;
> +	struct canfd_frame *cfd;
> +	struct can_frame *cf;
>  	unsigned long flags;
> -	u32 oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
> +	u32 oneshotmode;
> +	int slotindex;
> +	u8 *payload;
> +	u8 len;
> +	int i;
> +
> +	regs = priv->regs;
> +	oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
>  
>  	if (can_dev_dropped_skb(dev, skb))
>  		return NETDEV_TX_OK;
> @@ -1423,6 +1451,18 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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
> @@ -1433,7 +1473,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
>  	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
>  
>  	slotindex = txwr / GRCAN_MSG_SIZE;
> -	slot = (u32 *)((u8 *)dma->tx.msg_slot + txwr);
> +	bds = grcan_numbds(len);
>  
>  	if (unlikely(space == 1))
>  		netif_stop_queue(dev);
> @@ -1449,24 +1489,44 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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
> +	msg = grcan_tx_msg_slot(dma, txwr);
> +	memset(msg, 0, sizeof(*msg));
> +
> +	eff = can_id & CAN_EFF_FLAG;
> +	rtr = can_id & CAN_RTR_FLAG;
> +	id  = can_id & (eff ? CAN_EFF_MASK : CAN_SFF_MASK);
> +
> +	tmp = eff ? FIELD_PREP(GRCAN_MSG_EID_MASK, id)
> +		  : FIELD_PREP(GRCAN_MSG_BID_MASK, id);
> +
> +	msg->header.id = (eff ? GRCAN_MSG_IDE : 0) |
> +		      (rtr ? GRCAN_MSG_RTR : 0) |
> +		      tmp;
>  
> -	slot[1] = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
> -	slot[2] = 0;
> -	slot[3] = 0;
> -	if (dlc > 0)
> -		memcpy(&slot[2], cf->data, sizeof(u32));
> -	if (dlc > 4)
> -		memcpy(&slot[3], cf->data + 4, sizeof(u32));

You introduced this in patch #5:

  can: grcan: optimize DMA by 32-bit accesses

to just remove it here. Please rework your series. You shouldn't undo
what you previously introduced. If patch #8 becomes unneeded, just drop
it.

> +	msg->header.ctrl = FIELD_PREP(GRCAN_MSG_DLC_MASK, dlc);
> +
> +	if (can_is_canfd_skb(skb)) {
> +		msg->header.ctrl |= GRCAN_TX_FDF;
> +		if (cfd->flags & CANFD_BRS)
> +			msg->header.ctrl |= GRCAN_TX_BRS;
> +	}
> +
> +	copy_len = min_t(u32, len, GRCAN_CLASSIC_DATA_SIZE);
> +	memcpy(msg->header.data, payload, copy_len);
> +	payload_offset = copy_len;
> +
> +	txwr = grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size);
> +
> +	for (i = 1; i < bds; i++) {
> +		msg = grcan_tx_msg_slot(dma, txwr);
> +
> +		memset(msg, 0, sizeof(*msg));
> +		copy_len = min_t(u32, (u32)len - payload_offset, (u32)GRCAN_MSG_SIZE);
> +		memcpy(msg->frags.data, payload + payload_offset, copy_len);
> +		payload_offset += copy_len;
> +
> +		txwr = grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size);
> +	}
>  
>  	/* Checking that channel has not been disabled. These cases
>  	 * should never happen
> @@ -1508,8 +1568,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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

