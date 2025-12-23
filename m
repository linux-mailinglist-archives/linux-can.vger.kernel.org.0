Return-Path: <linux-can+bounces-5926-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB51CDAAA2
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 22:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42577300384C
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AA52D5C86;
	Tue, 23 Dec 2025 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReOgeKjg"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CE1286897;
	Tue, 23 Dec 2025 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766524155; cv=none; b=jBzTtxoTg/23/YVFrTQ4CkR3YsXyCbTPhGcEMmU0cOZ4iaqeQJsqawq78j7lME8zllPbUrldKTwIU6IzeFa+JeYe6Ibmyk6O5RuxoTfTWNU6NPdLbY6vLqDca760p5rPdn8mqoRV+qWqyMbfx7GSkEWN/c1Tcu84U7YfE6laWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766524155; c=relaxed/simple;
	bh=acATEELOe8qG5mMmpBGoevEzQLXk2TKugT0Y6VYvdF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G06HJXcGThYChKId4dw5MhB9IPI9ORBGhxUQMCpckzu0mjPA9itYQhGl9c45l2YzxZw/bCK8b3cPQuuqW8IqzcMz4hl9jt6lX1Qe9WZ+Z2sdX8JH/KsI0+L1B4uTFte6spU1FqgfMLQ3uc/zJLKb/3A5HmX99eAFAVDeO9ClAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReOgeKjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AFAC113D0;
	Tue, 23 Dec 2025 21:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766524152;
	bh=acATEELOe8qG5mMmpBGoevEzQLXk2TKugT0Y6VYvdF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ReOgeKjgv6kcl+i/seVl3rwnzu8Gdn427BWc2S4lrPFn5GE7qV3JUcXR7j/1LoTu9
	 x1AAlIsjH24+QK25cw5T2V/rmYHquTzGw7MOARbKp31icKFXKQeIW+CB6Vwifis0jx
	 KOTXSqzUCtj3Oc2VrNweyvm9hkWgdikrrhQb0FNfcS3CwdqZbTW6xEaajxLQy9QDlg
	 eNPSswtwGj4y9p1Y6IMnoeqcFiyq78kgqbxzhuQxi2XdBtA8yBGKhSwcU4d8M+E/Qg
	 8jyiDOOEmoiWj6I7UCJeORAmppyp4dnEIem2iG8lW1ep8QlSOpf/1IH8GDjF2wsvQU
	 wYw7ZBHH2y6ng==
Message-ID: <a53ed3b5-0fbb-4f44-ab1a-3bad0373068d@kernel.org>
Date: Tue, 23 Dec 2025 22:09:08 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] can: grcan: Add CANFD support alongside legacy
 CAN
To: Arun Muthusamy <arun.muthusamy@gaisler.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mkl@pengutronix.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
References: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
 <20251223105604.12675-11-arun.muthusamy@gaisler.com>
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
In-Reply-To: <20251223105604.12675-11-arun.muthusamy@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/12/2025 at 11:56, Arun Muthusamy wrote:
> Include CANFD support with the legacy CAN support, enabling
> support for extended data payloads up to 64 bytes, higher bit rates,
> handle canecho frames.

The patch mixes code refactor with introduction of new feature. I am
only a partial review for now, waiting for a proper split to do the
full review.

> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> ---
>  drivers/net/can/grcan.c | 259 +++++++++++++++++++++++++++-------------
>  1 file changed, 177 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index bf1c503d575d..3d5b4c7e58bc 100644
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
> @@ -230,6 +231,12 @@ struct grcan_registers {
>  #define GRCANFD_FDBTR_PS2_BIT 5
>  #define GRCANFD_FDBTR_SJW_BIT 0
>  
> +#define GRCAN_TX_BRS  BIT(25)
> +#define GRCAN_TX_FDF  BIT(26)
> +
> +#define GRCAN_RX_BRS  BIT(25)
> +#define GRCAN_RX_FDF  BIT(26)
> +
>  /* Hardware capabilities */
>  struct grcan_hwcap {
>  	/* CAN-FD capable, indicates GRCANFD IP.
> @@ -290,6 +297,13 @@ struct grcan_priv {
>  
>  	struct sk_buff **echo_skb;	/* We allocate this on our own */
>  
> +	/*
> +	 * Since the CAN FD frame has a variable length, this variable is used
> +	 * to keep track of the index of the CAN echo skb (socket buffer) frame.
> +	 * It's important for ensuring that we correctly manage the echo skb.
> +	 */
> +	u32 echo_skb_idx;
> +
>  	/* The echo skb pointer, pointing into echo_skb and indicating which
>  	 * frames can be echoed back. See the "Notes on the tx cyclic buffer
>  	 * handling"-comment for grcan_start_xmit for more details.
> @@ -570,7 +584,7 @@ static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
>  	struct grcan_registers __iomem *regs = priv->regs;
>  	struct grcan_dma *dma = &priv->dma;
>  	struct net_device_stats *stats = &dev->stats;
> -	int i, work_done;
> +	int work_done;
>  
>  	/* Updates to priv->eskbp and wake-ups of the queue needs to
>  	 * be atomic towards the reads of priv->eskbp and shut-downs
> @@ -581,19 +595,22 @@ static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
>  	for (work_done = 0; work_done < budget || budget < 0; work_done++) {
>  		if (priv->eskbp == txrd)
>  			break;
> -		i = priv->eskbp / GRCAN_MSG_SIZE;
> -		if (echo) {
> -			/* Normal echo of messages */
> -			stats->tx_packets++;
> -			stats->tx_bytes += can_get_echo_skb(dev, i, NULL);
> -		} else {
> -			/* For cleanup of untransmitted messages */
> -			can_free_echo_skb(dev, i, NULL);
> -		}
>  
>  		priv->eskbp = grcan_ring_add(priv->eskbp, GRCAN_MSG_SIZE,
>  					     dma->tx.size);
>  		txrd = grcan_read_reg(&regs->txrd);
> +
> +		/* Grab the packet once the  packet is send or free untransmitted packet*/
> +		if (priv->eskbp == txrd) {
> +			if (echo) {
> +				/* Normal echo of messages */
> +				stats->tx_packets++;
> +				stats->tx_bytes += can_get_echo_skb(dev, priv->echo_skb_idx, NULL);
> +			} else {
> +				/* For cleanup of untransmitted messages */
> +				can_free_echo_skb(dev, priv->echo_skb_idx, NULL);
> +			}
> +		}
>  	}
>  	return work_done;
>  }
> @@ -676,10 +693,8 @@ static void grcan_err(struct net_device *dev, u32 sources, u32 status)
>  	    (status & GRCAN_STAT_ERRCTR_RELATED)) {
>  		enum can_state state = priv->can.state;
>  		enum can_state oldstate = state;
> -		u32 txerr = (status & GRCAN_STAT_TXERRCNT)
> -			>> GRCAN_STAT_TXERRCNT_BIT;
> -		u32 rxerr = (status & GRCAN_STAT_RXERRCNT)
> -			>> GRCAN_STAT_RXERRCNT_BIT;
> +		u32 txerr = (status & GRCAN_STAT_TXERRCNT) >> GRCAN_STAT_TXERRCNT_BIT;
> +		u32 rxerr = (status & GRCAN_STAT_RXERRCNT) >> GRCAN_STAT_RXERRCNT_BIT;

Do not add random code refactors to your patch. If you want to change
those lines, put it in a separate patch.

>  		/* Figure out current state */
>  		if (status & GRCAN_STAT_OFF) {
> @@ -1101,6 +1116,7 @@ static int grcan_set_mode(struct net_device *dev, enum can_mode mode)
>  			if (!(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
>  				netif_wake_queue(dev);
>  		}
> +		priv->echo_skb_idx = 0;
>  		spin_unlock_irqrestore(&priv->lock, flags);
>  		return err;
>  	}
> @@ -1150,7 +1166,6 @@ static int grcan_open(struct net_device *dev)
>  		netif_start_queue(dev);
>  	priv->resetting = false;
>  	priv->closing = false;
> -
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  
>  	return 0;
> @@ -1221,20 +1236,31 @@ static void grcan_transmit_catch_up(struct net_device *dev)
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  }
>  
> +static int grcan_numbds(int len)
> +{
> +	if (len <= GRCAN_CLASSIC_DATA_SIZE)
> +		return 1;
> +	return 1 + ((len - GRCAN_CLASSIC_DATA_SIZE + GRCAN_MSG_SIZE) / GRCAN_MSG_SIZE);
> +}
> +
>  static int grcan_receive(struct net_device *dev, int budget)
>  {
> +	struct net_device_stats *stats = &dev->stats;
>  	struct grcan_priv *priv = netdev_priv(dev);
> -	struct grcan_registers __iomem *regs = priv->regs;
> +	struct grcan_registers __iomem *regs;
>  	struct grcan_dma *dma = &priv->dma;
> -	struct net_device_stats *stats = &dev->stats;
> -	struct can_frame *cf;
> +	u32 bds, copy_len, payload_offset;
> +	u32 wr, rd, dlc, startrd;
> +	struct canfd_frame *cf;
> +	int i, work_done = 0;
>  	struct sk_buff *skb;
> -	u32 wr, rd, startrd;
> -	u32 *slot;
>  	u32 rtr, eff;
> -	int work_done = 0;
> +	u32 *slot;
> +	u8 *data;
>  
> +	regs = priv->regs;
>  	rd = grcan_read_reg(&regs->rxrd);
> +
>  	startrd = rd;
>  	for (work_done = 0; work_done < budget; work_done++) {
>  		/* Check for packet to receive */
> @@ -1242,44 +1268,70 @@ static int grcan_receive(struct net_device *dev, int budget)
>  		if (rd == wr)
>  			break;
>  
> -		/* Take care of packet */
> -		skb = alloc_can_skb(dev, &cf);
> -		if (skb == NULL) {
> +		slot = dma->rx.buf + rd;
> +
> +		if (slot[1] & GRCAN_RX_FDF)
> +			skb = alloc_canfd_skb(dev, &cf);
> +		else
> +			skb = alloc_can_skb(priv->dev, (struct can_frame **)&cf);
> +
> +		if (unlikely(!skb)) {
>  			netdev_err(dev,
>  				   "dropping frame: skb allocation failed\n");
>  			stats->rx_dropped++;
>  			continue;
>  		}
>  
> -		slot = dma->rx.buf + rd;
> -		eff = slot[0] & GRCAN_MSG_IDE;
> -		rtr = slot[0] & GRCAN_MSG_RTR;
> -		if (eff) {
> -			cf->can_id = ((slot[0] & GRCAN_MSG_EID)
> -				      >> GRCAN_MSG_EID_BIT);
> -			cf->can_id |= CAN_EFF_FLAG;
> -		} else {
> -			cf->can_id = ((slot[0] & GRCAN_MSG_BID)
> -				      >> GRCAN_MSG_BID_BIT);
> -		}
> -		cf->len = can_cc_dlc2len((slot[1] & GRCAN_MSG_DLC)
> -					  >> GRCAN_MSG_DLC_BIT);
> -		if (rtr) {
> -			cf->can_id |= CAN_RTR_FLAG;
> -		} else {
> -			if (cf->can_dlc > 0) {
> -				memcpy(cf->data, &slot[2], sizeof(u32));
> -				if (cf->can_dlc > 4)
> -					memcpy(cf->data + 4, &slot[3], sizeof(u32));
> +		dlc = (slot[1] & GRCAN_MSG_DLC) >> GRCAN_MSG_DLC_BIT;
> +		if (slot[1] & GRCAN_RX_FDF)
> +			cf->len = can_fd_dlc2len(dlc);
> +		else
> +			cf->len = can_cc_dlc2len(dlc);
> +
> +		bds = grcan_numbds(cf->len);
> +		payload_offset = 0;
> +		data = cf->data;
> +
> +		for (i = 0; i < bds; i++) {
> +			slot = dma->rx.buf + rd;
> +
> +			if (i == 0) {
> +				eff = slot[0] & GRCAN_MSG_IDE;
> +				rtr = slot[0] & GRCAN_MSG_RTR;
> +				if (eff) {
> +					cf->can_id = ((slot[0] & GRCAN_MSG_EID)
> +						>> GRCAN_MSG_EID_BIT);

Use FIELD_GET() here. Add the required GRCAN_MSG_EID_MASK macro in a
dedicated clean-up patch.

> +					cf->can_id |= CAN_EFF_FLAG;
> +				} else {
> +					cf->can_id = ((slot[0] & GRCAN_MSG_BID)
> +						>> GRCAN_MSG_BID_BIT);
> +				}
> +				if (rtr)
> +					cf->can_id |= CAN_RTR_FLAG;
> +
> +				dlc = (slot[1] & GRCAN_MSG_DLC) >> GRCAN_MSG_DLC_BIT;

Same.

> +				if (slot[1] & GRCAN_RX_FDF)
> +					cf->len = can_fd_dlc2len(dlc);
> +				else
> +					cf->len = can_cc_dlc2len(dlc);
> +
> +				copy_len = min(cf->len, GRCAN_CLASSIC_DATA_SIZE);
> +				memcpy(data, &slot[2], copy_len);
> +				payload_offset += copy_len;
> +			} else {
> +				copy_len =  min(cf->len - payload_offset, GRCAN_MSG_SIZE);
> +				memcpy(data + payload_offset, slot, copy_len);
> +				payload_offset += copy_len;
>  			}
> -
> -			stats->rx_bytes += cf->len;
> +			rd += GRCAN_MSG_SIZE;
> +			if (rd >= dma->tx.size)
> +				rd -= dma->tx.size;
>  		}
> -		stats->rx_packets++;
>  
> +		/* Update statistics and read pointer */
> +		stats->rx_packets++;
> +		stats->rx_bytes += cf->len;
>  		netif_receive_skb(skb);
> -
> -		rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
>  	}
>  
>  	/* Make sure everything is read before allowing hardware to
> @@ -1404,15 +1456,22 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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
> @@ -1423,6 +1482,20 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
>  	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
>  		return NETDEV_TX_BUSY;
>  
> +	if (can_is_canfd_skb(skb)) {
> +		cfd = (struct canfd_frame *)skb->data;
> +		len = cfd->len;
> +		dlc = can_fd_len2dlc(cfd->len);
> +		can_id = cfd->can_id;
> +		payload = cfd->data;
> +	} else {
> +		cf = (struct can_frame *)skb->data;
> +		len = cf->len;
> +		dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
> +		can_id = cf->can_id;
> +		payload = cf->data;
> +	}

struct canfd_frame and struct can_frame share the same layout so try
to factorize what can be factorized, that is to say, everything except
of the dlc assignment.

>  	/* Reads of priv->eskbp and shut-downs of the queue needs to
>  	 * be atomic towards the updates to priv->eskbp and wake-ups
>  	 * of the queue in the interrupt handler.
> @@ -1431,9 +1504,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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
> @@ -1449,25 +1520,38 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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
> -
> -	slot[1] = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
> -	slot[2] = 0;
> -	slot[3] = 0;
> -	if (dlc > 0) {
> -		memcpy(&slot[2], cf->data, sizeof(u32));
> -		slot[2] = *(u32 *)(cf->data);
> -		if (dlc > 4)
> -			memcpy(&slot[3], cf->data + 4, sizeof(u32));
> +	payload_offset = 0;
> +	for (i = 0; i < bds; i++) {
> +		slot = dma->tx.buf + txwr;
> +		memset(slot, 0, GRCAN_MSG_SIZE);
> +
> +		if (i == 0) {
> +			eff = can_id & CAN_EFF_FLAG;
> +			rtr = can_id & CAN_RTR_FLAG;
> +			id = can_id & (eff ? CAN_EFF_MASK : CAN_SFF_MASK);
> +			if (eff)
> +				tmp = (id << GRCAN_MSG_EID_BIT) & GRCAN_MSG_EID;
> +			else
> +				tmp = (id << GRCAN_MSG_BID_BIT) & GRCAN_MSG_BID;
> +			slot[0] = (eff ? GRCAN_MSG_IDE : 0) | (rtr ? GRCAN_MSG_RTR : 0) | tmp;
> +			slot[1] = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
> +			if (can_is_canfd_skb(skb)) {
> +				slot[1] |= GRCAN_TX_FDF;
> +				if (cfd->flags & CANFD_BRS)
> +					slot[1] |= GRCAN_TX_BRS;
> +			}
> +
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
>  	}
>  
>  	/* Checking that channel has not been disabled. These cases
> @@ -1502,7 +1586,14 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
>  	 * can_put_echo_skb would be an error unless other measures are
>  	 * taken.
>  	 */
> -	can_put_echo_skb(skb, dev, slotindex, 0);
> +
> +	can_put_echo_skb(skb, dev, priv->echo_skb_idx, 0);
> +
> +	/* Move to the next index in the echo skb buffer */
> +	priv->echo_skb_idx = (priv->echo_skb_idx + 1) % priv->can.echo_skb_max;
> +
> +	if (priv->can.echo_skb[priv->echo_skb_idx])
> +		netif_stop_queue(dev);
>  
>  	/* Make sure everything is written before allowing hardware to
>  	 * read from the memory
> @@ -1510,8 +1601,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
>  	wmb();
>  
>  	/* Update write pointer to start transmission */
> -	grcan_write_reg(&regs->txwr,
> -			grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size));
> +	grcan_write_reg(&regs->txwr, txwr);
>  
>  	return NETDEV_TX_OK;
>  }
> @@ -1662,11 +1752,16 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
>  	priv->ofdev_dev = &ofdev->dev;
>  	priv->regs = base;
>  	priv->can.bittiming_const = hwcap->bt_const;
> +	priv->can.fd.data_bittiming_const = hwcap->bt_const;
>  	priv->can.do_set_mode = grcan_set_mode;
>  	priv->can.do_get_berr_counter = grcan_get_berr_counter;
>  	priv->can.clock.freq = ambafreq;
> -	priv->can.ctrlmode_supported =
> -		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
> +	if (hwcap->fd)
> +		priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
> +			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_FD;
> +	else
> +		priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
> +			CAN_CTRLMODE_ONE_SHOT;

Do it like this:

	priv->can.ctrlmode_supported =
		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
	if (hwcap->fd)
		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;

>  	priv->need_txbug_workaround = txbug;
>  	priv->hwcap = hwcap;
>  

Yours sincerely,
Vincent Mailhol

