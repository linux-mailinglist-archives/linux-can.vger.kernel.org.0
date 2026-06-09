Return-Path: <linux-can+bounces-7769-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /IVCMjPcJ2oz3gIAu9opvQ
	(envelope-from <linux-can+bounces-7769-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 11:26:11 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C02765E4F5
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 11:26:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EQcaFDcv;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7769-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7769-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9C343026F27
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 09:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671773DDDC9;
	Tue,  9 Jun 2026 09:25:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E838539EF23;
	Tue,  9 Jun 2026 09:25:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997106; cv=none; b=JRbrW/1c0DhXReW/rN+uFNQKi8lRhTDJInU9VCj7wIk168/4/zpj/GZygYd7A5N1AR7+VMx1Rs732gGCY2IgJ4ZAmz8oCH8TuOhdmT/ZX4dT7jdim4jfxps+woInQwksi+YLpaeP6Ia2CZYxo8RyOKsDIZVm3AlZPDhMmEAI9eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997106; c=relaxed/simple;
	bh=fXmlF23Kc0Gz0DyIkV/VB7zl1qoh5iydFacWVlpna0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHyIGPUTqe2cZA3ObARUKAfH8Yiv6J+wz3FsvoxbQvxy3fdJ+EubWBTEXuHinTiup9uLpQJJjPbSXrsjf77QPyrNQUWMZDeDlt5FsBr9ObljFJM/wBWS3mGTRKBQIz6AEgS7LYoAdXc5ghnZt8G3fmrG2XRIuvOm6q1OCxFYk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQcaFDcv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FAE1F00893;
	Tue,  9 Jun 2026 09:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780997104;
	bh=yJ60kBjWAJGClfdgON5i50ME0WuDweXsexe8c1DjGOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EQcaFDcvAfJBZLt1sk2F4oVpqklrDooFDyAR9r8krEc6Cttbx38JBoke99EX5oJib
	 AZChEhROze4PqPSzWKRsvXXAlewpzJKxknovpGTuHmLf5gdLOFY8DPC8fDWl/5YHok
	 snctg/OfXjCKJlOojBpxLCDUqgMH3ZDO0Wj2O24IBet5+2whuRhwxurtAc2KtHXh2D
	 aBYFPGOrZclVsXVPHB7Gdd9ExuPALR0f50hXDqP4KAlGdtM7RZeD7dVGRugpj+dpvr
	 xmZc9YGlnF02UkKwPcX2YqSFLw9WC15mYNHfdLeaF0BN6oE/W0cwbJx7z68ttx4juG
	 cBKWior0bcVLQ==
Message-ID: <c50194dd-3a3c-4193-9296-1e35c6732351@kernel.org>
Date: Tue, 9 Jun 2026 11:24:57 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 3/8] can: flexcan: split rx/tx masks per mailbox
 IRQ line
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>
References: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
 <20260603071342.641874-4-ciprianmarian.costea@oss.nxp.com>
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
In-Reply-To: <20260603071342.641874-4-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7769-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ciprianmarian.costea@oss.nxp.com,m:mkl@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.nxp.com,pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORGED_SENDER(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C02765E4F5

On 03/06/2026 at 09:13, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> On S32G2, which has two mailbox IRQ lines (mb-0 for MBs 0-7, mb-1
> for MBs 8-127), both handlers currently process the full rx_mask/tx_mask
> range,
> 
> Introduce struct flexcan_mb_irq to hold per-IRQ-line rx and tx masks.
> 
> In flexcan_irq_mb(), the irq argument selects the correct mask set: the
> primary MB IRQ uses mb_irq[0] and the secondary uses mb_irq[1].
> 
> For single-IRQ platforms, mb_irq[0] holds the full combined masks with no
> functional change.
> 
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 61 +++++++++++++++++++-------
>  drivers/net/can/flexcan/flexcan.h      | 10 ++++-
>  2 files changed, 52 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index 7dde2e623def..32e4d4da00a1 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -957,14 +957,16 @@ static inline void flexcan_write64(struct flexcan_priv *priv, u64 val, void __io
>  		priv->write(lower_32_bits(val), addr);
>  }
>  
> -static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv)
> +static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv,
> +					    u64 rx_mask)
>  {
> -	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->rx_mask);
> +	return flexcan_read64_mask(priv, &priv->regs->iflag1, rx_mask);
>  }
>  
> -static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv)
> +static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv,
> +					    u64 tx_mask)
>  {
> -	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->tx_mask);
> +	return flexcan_read64_mask(priv, &priv->regs->iflag1, tx_mask);
>  }
>  
>  static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
> @@ -1071,7 +1073,8 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
>  }
>  
>  /* Process mailbox (RX + TX) events */
> -static irqreturn_t flexcan_do_mb(struct net_device *dev)
> +static irqreturn_t flexcan_do_mb(struct net_device *dev,
> +				 const struct flexcan_mb_irq *mb_irq)
>  {
>  	struct net_device_stats *stats = &dev->stats;
>  	struct flexcan_priv *priv = netdev_priv(dev);
> @@ -1084,7 +1087,8 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
>  		u64 reg_iflag_rx;
>  		int ret;
>  
> -		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv))) {
> +		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv,
> +								 mb_irq->rx_mask))) {
>  			handled = IRQ_HANDLED;
>  			ret = can_rx_offload_irq_offload_timestamp(&priv->offload,
>  								   reg_iflag_rx);
> @@ -1110,10 +1114,10 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
>  		}
>  	}
>  
> -	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv);
> +	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv, mb_irq->tx_mask);
>  
>  	/* transmission complete interrupt */
> -	if (reg_iflag_tx & priv->tx_mask) {
> +	if (reg_iflag_tx & mb_irq->tx_mask) {
>  		u32 reg_ctrl = priv->read(&priv->tx_mb->can_ctrl);
>  
>  		handled = IRQ_HANDLED;
> @@ -1125,7 +1129,7 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
>  		/* after sending a RTR frame MB is in RX mode */
>  		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
>  			    &priv->tx_mb->can_ctrl);
> -		flexcan_write64(priv, priv->tx_mask, &regs->iflag1);
> +		flexcan_write64(priv, mb_irq->tx_mask, &regs->iflag1);
>  		netif_wake_queue(dev);
>  	}
>  
> @@ -1228,7 +1232,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>  	struct flexcan_priv *priv = netdev_priv(dev);
>  	irqreturn_t handled;
>  
> -	handled = flexcan_do_mb(dev);
> +	handled = flexcan_do_mb(dev, &priv->mb_irq[0]);
>  	handled |= flexcan_do_state(dev);
>  	handled |= flexcan_do_berr(dev);
>  
> @@ -1243,9 +1247,15 @@ static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
>  {
>  	struct net_device *dev = dev_id;
>  	struct flexcan_priv *priv = netdev_priv(dev);
> +	const struct flexcan_mb_irq *mb_irq;
>  	irqreturn_t handled;
> +	int idx;
>  
> -	handled = flexcan_do_mb(dev);
> +	idx = (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ &&
> +	       irq == priv->irq_secondary_mb) ? 1 : 0;
> +	mb_irq = &priv->mb_irq[idx];
> +
> +	handled = flexcan_do_mb(dev, mb_irq);
>  
>  	if (handled)
>  		can_rx_offload_irq_finish(&priv->offload);
> @@ -1473,6 +1483,7 @@ static void flexcan_ram_init(struct net_device *dev)
>  static int flexcan_rx_offload_setup(struct net_device *dev)
>  {
>  	struct flexcan_priv *priv = netdev_priv(dev);
> +	u64 rx_mask, tx_mask;
>  	int err;
>  
>  	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
> @@ -1494,20 +1505,35 @@ static int flexcan_rx_offload_setup(struct net_device *dev)
>  			flexcan_get_mb(priv, FLEXCAN_TX_MB_RESERVED_RX_FIFO);
>  	priv->tx_mb_idx = priv->mb_count - 1;
>  	priv->tx_mb = flexcan_get_mb(priv, priv->tx_mb_idx);
> -	priv->tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
> -
>  	priv->offload.mailbox_read = flexcan_mailbox_read;
>  
>  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
>  		priv->offload.mb_first = FLEXCAN_RX_MB_RX_MAILBOX_FIRST;
>  		priv->offload.mb_last = priv->mb_count - 2;
>  
> -		priv->rx_mask = GENMASK_ULL(priv->offload.mb_last,
> -					    priv->offload.mb_first);
> +		rx_mask = GENMASK_ULL(priv->offload.mb_last,
> +				      priv->offload.mb_first);
> +		tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
> +
> +		if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
> +			/* S32G2 has two MB IRQ lines with the split at MB 8:
> +			 * mb-0 IRQ handles MBs 0-7,
> +			 * mb-1 IRQ handles MBs 8-127.
                                                  ^^^
Your comment says 8-127 but the code uses GENMASK_ULL(63, 8). Is this
intentional?

> +			 */
> +			priv->mb_irq[0].rx_mask = rx_mask & GENMASK_ULL(7, 0);
> +			priv->mb_irq[0].tx_mask = tx_mask & GENMASK_ULL(7, 0);
> +			priv->mb_irq[1].rx_mask = rx_mask & GENMASK_ULL(63, 8);
> +			priv->mb_irq[1].tx_mask = tx_mask & GENMASK_ULL(63, 8);
> +		} else {
> +			priv->mb_irq[0].rx_mask = rx_mask;
> +			priv->mb_irq[0].tx_mask = tx_mask;
> +		}
> +

The introduction of the struct flexcan_mb_irq seems a bit overkill.
Can't you just define two new masks and keep the existing struct
flexcan_stop_mode untouched:

	#define FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK GENMASK_U64(7, 0)
	#define FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK GENMASK_U64(63, 8)

and when you need to access the MB, just select the correct mask. For
example, flexcan_irq_mb() becomes something like this:

	u64 mb_mask;

	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ
	    && irq == priv->irq_secondary_mb)
		mb_mask = FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK;
	else
		mb_mask = FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK;

	handled = flexcan_do_mb(dev, mb_mask);

>  		err = can_rx_offload_add_timestamp(dev, &priv->offload);
>  	} else {
> -		priv->rx_mask = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
> +		priv->mb_irq[0].rx_mask = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
>  			FLEXCAN_IFLAG_RX_FIFO_AVAILABLE;
> +		priv->mb_irq[0].tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
>  		err = can_rx_offload_add_fifo(dev, &priv->offload,
>  					      FLEXCAN_NAPI_WEIGHT);
>  	}
> @@ -1531,7 +1557,8 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
>  		disable_irq(priv->irq_secondary_mb);
>  
>  	priv->write(priv->reg_ctrl_default, &regs->ctrl);
> -	reg_imask = priv->rx_mask | priv->tx_mask;
> +	reg_imask = priv->mb_irq[0].rx_mask | priv->mb_irq[0].tx_mask |
> +		    priv->mb_irq[1].rx_mask | priv->mb_irq[1].tx_mask;
>  	priv->write(upper_32_bits(reg_imask), &regs->imask2);
>  	priv->write(lower_32_bits(reg_imask), &regs->imask1);
>  	enable_irq(dev->irq);
> diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
> index 16692a2502eb..22aa097ec3c0 100644
> --- a/drivers/net/can/flexcan/flexcan.h
> +++ b/drivers/net/can/flexcan/flexcan.h
> @@ -75,10 +75,17 @@
>   */
>  #define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
>  
> +#define FLEXCAN_NR_MB_IRQS	2
> +
>  struct flexcan_devtype_data {
>  	u32 quirks;		/* quirks needed for different IP cores */
>  };
>  
> +struct flexcan_mb_irq {
> +	u64 rx_mask;
> +	u64 tx_mask;
> +};
> +
>  struct flexcan_stop_mode {
>  	struct regmap *gpr;
>  	u8 req_gpr;
> @@ -99,8 +106,7 @@ struct flexcan_priv {
>  	u8 clk_src;	/* clock source of CAN Protocol Engine */
>  	u8 scu_idx;
>  
> -	u64 rx_mask;
> -	u64 tx_mask;
> +	struct flexcan_mb_irq mb_irq[FLEXCAN_NR_MB_IRQS];
>  	u32 reg_ctrl_default;
>  
>  	struct clk *clk_ipg;


Yours sincerely,
Vincent Mailhol


