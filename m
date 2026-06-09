Return-Path: <linux-can+bounces-7796-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x+12ArBwKGovEwMAu9opvQ
	(envelope-from <linux-can+bounces-7796-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 21:59:44 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ACC663FCE
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 21:59:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DEB8hNSv;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7796-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7796-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B581C3039A04
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 19:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5823749F5;
	Tue,  9 Jun 2026 19:42:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A7B3043B2;
	Tue,  9 Jun 2026 19:42:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034173; cv=none; b=dK0L77EhuGt8qkav77z5BP+meMBxj/i4KN6iFOV1UltVvSv4yhcLjSxrSxi3RGy0a2DjBDcIrmyjoZLam5ENWEBmv20N4L6pIE0DYlsT9N7PyhuKMURzAxcqNKETcMAa8QKMqOAcOUF3cONlm2Cee2t2slOCQ2hP6r2AyNd7ffw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034173; c=relaxed/simple;
	bh=q1HQQMuSnv6EV8DHgmyALfGmCh5RPFiGXWibkcFpO/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3bksU5vbEYcpJwPheHUytrVTOcSpUPU8bf6M7CX1UGsLQnTu9ednpAo1w8o0RX7ODNuU35EKYeQ8/HqoUtrxJvgEuu1WI/NXzGYd4mAMH24x2rn9H/qrDu1+jlJkszT/hRUBdSgwwsWaxwON92sLDoLgaunKXRFLTvH0PZvelc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEB8hNSv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35BE1F00893;
	Tue,  9 Jun 2026 19:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781034171;
	bh=VF3viPuMEWMRZJosuNQWMzSXeAmE8fJkp4pt8onW/hA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DEB8hNSvqowoBsK7oJGEHssg8xawpxZ4XjOvZWYwOTV2tGTY8r4FZ0xm/DtI4yFen
	 20Cg4KP5QSUVKt3zu4X+uh24hFtE1M+fEybkvLSmlv5RJXXTZ4XpSjDItk3Kkhb7kc
	 3cdixxxdaQaNLZ9rhfnF8J7e7kHc2RXn6JZAlp/ilF+rndMLG1X1MkNZo9INrU9Z1s
	 uEReFLCk3DWijehGRsg1Xb1lCVZzotP7tkk5baiXWXWd8iZ3CA1qzdi07fqpGSrfmM
	 tUK4KhTleT85i7KjJSsMxn6QhmZGfCOxP7p1pcIt8iOfWX+5GvlOypiejBV0T9c0pc
	 vK+1MA1rTte4Q==
Message-ID: <3bf39b4d-123f-42d3-bc05-fdb86a256e7e@kernel.org>
Date: Tue, 9 Jun 2026 21:42:46 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] can: flexcan: split rx/tx masks per mailbox IRQ
 line
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
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Haibo Chen <haibo.chen@nxp.com>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
 <20260609142954.1807421-4-ciprianmarian.costea@oss.nxp.com>
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
In-Reply-To: <20260609142954.1807421-4-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ciprianmarian.costea@oss.nxp.com,m:mkl@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[oss.nxp.com,pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7796-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07ACC663FCE

On 09/06/2026 at 16:29, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> On S32G2, which has two mailbox IRQ lines (mb-0 for MBs 0-7, mb-1
> for MBs 8-63), both handlers currently process the full rx_mask/tx_mask
> range.
> 
> Introduce FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK and
> FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK to describe the split, and pass
> the selected mask to flexcan_do_mb() via a new mb_mask parameter.
> 
> In flexcan_irq_mb(), the irq argument selects the correct mask: the
> primary MB IRQ uses MB0_MASK and the secondary uses MB1_MASK.
> 
> For single-IRQ platforms, mb_mask is ~0ULL with no functional change.
> 
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>

Looks better than v5!

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>

> ---
>  drivers/net/can/flexcan/flexcan-core.c | 39 ++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index 7dde2e623def..0ed838f0719a 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -182,6 +182,12 @@
>  #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
>  #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
>  
> +/* On platforms with FLEXCAN_QUIRK_SECONDARY_MB_IRQ, the MB IRQ lines are
> + * split.
> + */
> +#define FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK	GENMASK_ULL(7, 0)
> +#define FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK	GENMASK_ULL(63, 8)

Nitpick: priv->rx_mask, priv->tx_mask and your mb_mask variable all have
type u64 so you could have used GENMASK_U64() to stay coherent with the
type. But you don't have to send a v6 just for this.

>  /* FLEXCAN message buffers */
>  #define FLEXCAN_MB_CODE_MASK		(0xf << 24)
>  #define FLEXCAN_MB_CODE_RX_BUSY_BIT	(0x1 << 24)
> @@ -957,14 +963,16 @@ static inline void flexcan_write64(struct flexcan_priv *priv, u64 val, void __io
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
> @@ -1071,12 +1079,14 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
>  }
>  
>  /* Process mailbox (RX + TX) events */
> -static irqreturn_t flexcan_do_mb(struct net_device *dev)
> +static irqreturn_t flexcan_do_mb(struct net_device *dev, u64 mb_mask)
>  {
>  	struct net_device_stats *stats = &dev->stats;
>  	struct flexcan_priv *priv = netdev_priv(dev);
>  	struct flexcan_regs __iomem *regs = priv->regs;
>  	irqreturn_t handled = IRQ_NONE;
> +	u64 rx_mask = priv->rx_mask & mb_mask;
> +	u64 tx_mask = priv->tx_mask & mb_mask;
>  	u64 reg_iflag_tx;
>  
>  	/* reception interrupt */
> @@ -1084,7 +1094,8 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
>  		u64 reg_iflag_rx;
>  		int ret;
>  
> -		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv))) {
> +		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv,
> +								 rx_mask))) {
>  			handled = IRQ_HANDLED;
>  			ret = can_rx_offload_irq_offload_timestamp(&priv->offload,
>  								   reg_iflag_rx);
> @@ -1110,10 +1121,10 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
>  		}
>  	}
>  
> -	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv);
> +	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv, tx_mask);
>  
>  	/* transmission complete interrupt */
> -	if (reg_iflag_tx & priv->tx_mask) {
> +	if (reg_iflag_tx & tx_mask) {
>  		u32 reg_ctrl = priv->read(&priv->tx_mb->can_ctrl);
>  
>  		handled = IRQ_HANDLED;
> @@ -1125,7 +1136,7 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
>  		/* after sending a RTR frame MB is in RX mode */
>  		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
>  			    &priv->tx_mb->can_ctrl);
> -		flexcan_write64(priv, priv->tx_mask, &regs->iflag1);
> +		flexcan_write64(priv, tx_mask, &regs->iflag1);
>  		netif_wake_queue(dev);
>  	}
>  
> @@ -1228,7 +1239,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>  	struct flexcan_priv *priv = netdev_priv(dev);
>  	irqreturn_t handled;
>  
> -	handled = flexcan_do_mb(dev);
> +	handled = flexcan_do_mb(dev, ~0ULL);
>  	handled |= flexcan_do_state(dev);
>  	handled |= flexcan_do_berr(dev);
>  
> @@ -1244,8 +1255,14 @@ static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
>  	struct net_device *dev = dev_id;
>  	struct flexcan_priv *priv = netdev_priv(dev);
>  	irqreturn_t handled;
> +	u64 mb_mask = ~0ULL;
> +
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
> +		mb_mask = (irq == priv->irq_secondary_mb) ?
> +			  FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK :
> +			  FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK;
>  
> -	handled = flexcan_do_mb(dev);
> +	handled = flexcan_do_mb(dev, mb_mask);
>  
>  	if (handled)
>  		can_rx_offload_irq_finish(&priv->offload);


Yours sincerely,
Vincent Mailhol


