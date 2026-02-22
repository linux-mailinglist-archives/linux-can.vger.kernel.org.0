Return-Path: <linux-can+bounces-6607-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6K0XL9Ikm2notgMAu9opvQ
	(envelope-from <linux-can+bounces-6607-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 22 Feb 2026 16:46:26 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1E216F8EA
	for <lists+linux-can@lfdr.de>; Sun, 22 Feb 2026 16:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8673B300F5C6
	for <lists+linux-can@lfdr.de>; Sun, 22 Feb 2026 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D42176FB1;
	Sun, 22 Feb 2026 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U60SBA08"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709F01096F;
	Sun, 22 Feb 2026 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771775182; cv=none; b=D/RqVZylYXFSm0iq/uh4oPlIOzB7XCdnMsePxCRVyTrDOw7XbSKBPyT7VwTMburIfLr9ZFCPIL/7eV2JlDOt0n2Pe8R51p8nKcHmYhzAQKGYq4oNRMqUl5yJZYeCHhG3urd9F909eT83kkj9zjMfCxO+MwqVudHszJ55sB2MjPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771775182; c=relaxed/simple;
	bh=vIUFdUFbzD8Je8hr3VYwtDKXRcdTcGR572L6CSWMyHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHGSXYuR895gCpzMBLCxAvj5LuJBBDidZ3u+5An91ncBsV6BQDUOB/jE2f0XML5dqfb9wSyOxy3+CHaUOGeD7/qn0TJaVepFfJiSo69VMVtQ0s1KfyjeMW4xr9iOj3xwA/lMpKq+Zca56aGCpgZszBVVMcUEG/o57rajy96Ek6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U60SBA08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE52C116D0;
	Sun, 22 Feb 2026 15:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771775182;
	bh=vIUFdUFbzD8Je8hr3VYwtDKXRcdTcGR572L6CSWMyHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U60SBA08ppCaVJvw/WA7/KemsXtBbDLDcfGvLI3z9mHJV0X+8Yoafaa4hp/zmmzpc
	 /lRp8htkM0iZ4EaBdBsttXe+CS4h5Gh1gIYOX+ivaslidPtVETjI8gNt61c163Ha6E
	 9NmSHJhAv+62dSnh3/4IlzyhE0fG4YOr202HoxC6p5R3qeo5ZFNounQmnXUoB8e99U
	 KYnngpSLbyXynnPLUbJXRKyIQPuiGjA7MXbHtlXrbPVqDY9IJJqjhI6QRlPFZNmX1v
	 o6LRfe+LJz/fb+COlOKfedKusjQQvl9d8l5ggsfE3501vk3lve5JOz6uPdZH2oikNe
	 EmRX68rrLxQrA==
Message-ID: <e1517670-92f9-405d-934e-b9341bea27ac@kernel.org>
Date: Sun, 22 Feb 2026 16:46:18 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/16] can: grcan: Refactor GRCAN DMA buffer to use
 structured memory layout
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mkl@pengutronix.de
References: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
 <20260216135344.23246-13-arun.muthusamy@gaisler.com>
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
In-Reply-To: <20260216135344.23246-13-arun.muthusamy@gaisler.com>
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
	TAGGED_FROM(0.00)[bounces-6607-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C1E216F8EA
X-Rspamd-Action: no action

On 16/02/2026 at 14:53, Arun Muthusamy wrote:
>  Introduce a structured layout that accurately represents the hardware memory by using struct grcan_msg_slot.
>  This structure encapsulates the message parameters, including id, dlc, and data.
> 
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> ---
>  drivers/net/can/grcan.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index 3104946071dd..28fa219e1c3b 100644
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
> @@ -239,9 +240,23 @@ struct grcan_hwcap {
>  	bool fd;
>  };
>  
> +union grcan_msg_slot {
> +	/*  First slot: header + 8 bytes payload */
> +	struct {
> +		u32 id;
> +		u32 ctrl;
> +		u8  data[GRCAN_CLASSIC_DATA_SIZE];
                         ^^^^^^^^^^^^^^^^^^^^^^^

Remove this GRCAN_CLASSIC_DATA_SIZE macro and instead use CAN_MAX_DLEN.

> +	} __packed header;
> +
> +	/* Continuation slot: payload only */
> +	struct {
> +		u8 data[GRCAN_MSG_SIZE];
> +	} __packed frags;
> +} __packed;
> +
>  struct grcan_dma_buffer {
>  	size_t size;
> -	void *buf;
> +	union grcan_msg_slot *msg_slot;
>  	dma_addr_t handle;
>  };

Nitpick: you can use an anonymous union:

	/*  First slot: header + 8 bytes payload */
	struct grcan_msg_header {
		u32 id;
		u32 ctrl;
		u8  data[CAN_MAX_DLEN];
	} __packed;

	/* Continuation slot: payload only */
	struct grcan_msg_fragment {
		u8 data[GRCAN_MSG_SIZE];
	} __packed;
	
	struct grcan_dma_buffer {
		size_t size;
		void *buf;
		union {
			struct grcan_msg_header *header;
			struct grcan_msg_fragment *frag;
		};
		dma_addr_t handle;
	};

With this, you can do:

	dma->rx->header
	dma->rx->frag

instead of:

	dma->rx.msg_slot->header
	dma->rx.msg_slot->frag

> @@ -1019,8 +1034,8 @@ static int grcan_allocate_dma_buffers(struct net_device *dev,
>  	small->handle = large->handle + lsize;
>  	shift = large->handle - dma->base_handle;
>  
> -	large->buf = dma->base_buf + shift;
> -	small->buf = large->buf + lsize;
> +	large->msg_slot = (union grcan_msg_slot *)((u8 *)dma->base_buf + shift);
> +	small->msg_slot = (union grcan_msg_slot *)((u8 *)large->msg_slot + lsize);
>  
>  	return 0;
>  }
> @@ -1237,7 +1252,7 @@ static int grcan_receive(struct net_device *dev, int budget)
>  			continue;
>  		}
>  
> -		slot = dma->rx.buf + rd;
> +		slot = (u32 *)((u8 *)dma->rx.msg_slot + rd);
>  		eff = slot[0] & GRCAN_MSG_IDE;
>  		rtr = slot[0] & GRCAN_MSG_RTR;
>  		if (eff) {
> @@ -1418,7 +1433,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
>  	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
>  
>  	slotindex = txwr / GRCAN_MSG_SIZE;
> -	slot = dma->tx.buf + txwr;
> +	slot = (u32 *)((u8 *)dma->tx.msg_slot + txwr);

As told in my previous message, refactor the code in this commit.

>  	if (unlikely(space == 1))
>  		netif_stop_queue(dev);


Yours sincerely,
Vincent Mailhol

