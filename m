Return-Path: <linux-can+bounces-5924-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 692D5CDA8C0
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 21:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9986B3017F33
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDB52F0C68;
	Tue, 23 Dec 2025 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp7zeHqi"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B402BD5A7;
	Tue, 23 Dec 2025 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766522427; cv=none; b=F48MnXYQ6RcBIwyNVrPC0/5MtO/WsGX9voFk7u6o31a5bjnrelGLGK6lrbupmrd7w5TR/rHvTVjlVq9yF2sP1nwyxtIUzUjj9tiX3+kX7IFwzLIQi1Cb2P1EIH7kZ5WaEnU9Gv3R0ax0X98OcYCRr5Yy2U3v8SEtUgt3b0XTmfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766522427; c=relaxed/simple;
	bh=f0nIuBBKrHockh9xxshvuChHG+xLcOGUOvfhvGIc9yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKAfhNugL0+E69Vqe9Shws1TVnXVNdiJ6EpuSNcIiMpK1A61gcBWHxM3m2jBx6xpVzREwPW9oUrJzd3T0AVHx6LcFJcMOgWMqESLMOKNId2OjxduZQ707niQCFJYTboJ9GUlbDg9YaVNvKryFCNbXOLk7CKfT8e/DNZMVDlgwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp7zeHqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E295FC113D0;
	Tue, 23 Dec 2025 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766522426;
	bh=f0nIuBBKrHockh9xxshvuChHG+xLcOGUOvfhvGIc9yk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hp7zeHqihzcF7SF3Qx55xL2+m0fpB+LZJpimpvUX+q379Wekh9HDQC2mR6CIfI55G
	 oLi/he7tBOL7cC9+s2A+txcMcJAoa/JZIUSFwgU+AQeuumNfENDIrC7kV8DbR0e3nP
	 yY36IZLiSIhGYe0jiaB3qaYe56E2U+diqGkIa1he1/JBDq/CESG/nIf2tJiqAthYzc
	 VKfPZ/IVj6+yJgmowT9Ye4Sw329dPG9QHlzZqU9zTET+PRtHdexKKnW0/JjoCJIbDY
	 Qmun7bTIe3Ntd5t9OGbKHOzqykFt8f+tbzI47mjuEB74KUqcTmMevbQoCDfxfSmCWn
	 XQgwjjaQITbaQ==
Message-ID: <6a033bd5-e9be-49c9-82a7-33874321480b@kernel.org>
Date: Tue, 23 Dec 2025 21:40:21 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] can: grcan: optimize DMA by 32-bit accesses
To: Arun Muthusamy <arun.muthusamy@gaisler.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mkl@pengutronix.de,
 mailhol@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, Daniel Hellstrom <daniel@gaisler.com>
References: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
 <20251223105604.12675-7-arun.muthusamy@gaisler.com>
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
In-Reply-To: <20251223105604.12675-7-arun.muthusamy@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/12/2025 at 11:56, Arun Muthusamy wrote:
> From: Daniel Hellstrom <daniel@gaisler.com>
> 
> Optimizes DMA transfers in the GRCAN driver by reorganizing
> data handling to use 32-bit accesses instead of individual
> byte accesses.
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> ---
>  drivers/net/can/grcan.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index cac85fbe6acf..8a6c59473cf4 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -1218,7 +1218,7 @@ static int grcan_receive(struct net_device *dev, int budget)
>  	struct sk_buff *skb;
>  	u32 wr, rd, startrd;
>  	u32 *slot;
> -	u32 i, rtr, eff, j, shift;
> +	u32 rtr, eff;
>  	int work_done = 0;
>  
>  	rd = grcan_read_reg(&regs->rxrd);
> @@ -1254,10 +1254,10 @@ static int grcan_receive(struct net_device *dev, int budget)
>  		if (rtr) {
>  			cf->can_id |= CAN_RTR_FLAG;
>  		} else {
> -			for (i = 0; i < cf->len; i++) {
> -				j = GRCAN_MSG_DATA_SLOT_INDEX(i);
> -				shift = GRCAN_MSG_DATA_SHIFT(i);
> -				cf->data[i] = (u8)(slot[j] >> shift);
> +			if (cf->can_dlc > 0) {
> +				memcpy(cf->data, &slot[2], sizeof(u32));
> +				if (cf->can_dlc > 4)
> +					memcpy(cf->data + 4, &slot[3], sizeof(u32));
>  			}

Nitpick: you may instead do:

	if (cf->can_dlc > 0)
		memcpy(cf->data, &slot[2], sizeof(u32));
	if (cf->can_dlc > 4)
		memcpy(cf->data + 4, &slot[3], sizeof(u32));

and let the compiler take care of the optimization for you ;)

>  
>  			stats->rx_bytes += cf->len;
> @@ -1397,8 +1397,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
>  	u32 id, txwr, txrd, space, txctrl;
>  	int slotindex;
>  	u32 *slot;
> -	u32 i, rtr, eff, dlc, tmp, err;
> -	int j, shift;
> +	u32 rtr, eff, dlc, tmp, err;
>  	unsigned long flags;
>  	u32 oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
>  
> @@ -1451,10 +1450,11 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
>  	slot[1] = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
>  	slot[2] = 0;
>  	slot[3] = 0;
> -	for (i = 0; i < dlc; i++) {
> -		j = GRCAN_MSG_DATA_SLOT_INDEX(i);
> -		shift = GRCAN_MSG_DATA_SHIFT(i);
> -		slot[j] |= cf->data[i] << shift;
> +	if (dlc > 0) {
> +		memcpy(&slot[2], cf->data, sizeof(u32));
> +		slot[2] = *(u32 *)(cf->data);

Why do you have both the memcpy() and the "slot[2] =" assignment?

> +		if (dlc > 4)
> +			memcpy(&slot[3], cf->data + 4, sizeof(u32));
>  	}
>  
>  	/* Checking that channel has not been disabled. These cases

Don't forget also to remove the unused macros.


Yours sincerely,
Vincent Mailhol


