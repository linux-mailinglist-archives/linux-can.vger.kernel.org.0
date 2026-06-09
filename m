Return-Path: <linux-can+bounces-7797-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TdqnMv9vKGq2EgMAu9opvQ
	(envelope-from <linux-can+bounces-7797-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 21:56:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF8F663F55
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 21:56:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dziBB5dH;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7797-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7797-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C2FE30CDC63
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 19:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C8330F7E8;
	Tue,  9 Jun 2026 19:51:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4586C374A1E;
	Tue,  9 Jun 2026 19:51:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034684; cv=none; b=fB0NN34KWLWGz9uuEr4gxmdtkQLB2RmNhlunnR2Uws2GbjBc0Lj78o04h1NWIrver2RXOhk12m2od7OsGxQh8UaedJ08VuOYAydgP6sbuxLPD0bujjkFR9Lhdx8pE68PVO1pIBapzvAPLw6Sp/+DwbiYUJ+rwL3aWI0IzGXQOiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034684; c=relaxed/simple;
	bh=vMyOOIGOAJsdIqCGloHoKrEpv78+bdnXCx7uXU5nR7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLKN0jLKCCxd9DKP+ZoxDKVp2WQ+/eWtEr0vd5PWFTyuqMJjSuwWMgiynjmKESx3EikfPhKLMVUFjMWGMvxVE2q/AQblicRIiVD1K9htksL9JyFqF9OKhIv4zEp9nHCA7qIf+NN296gTMeUHjFVCkKi6CNZ9p1vBv4x2XWwhSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dziBB5dH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22091F00893;
	Tue,  9 Jun 2026 19:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781034678;
	bh=QMeBqfIANjuB2z0BodQbfcwU2KdM59UZ/QBGLC1c+2k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dziBB5dHsa7EnBkYvZDTTxHglDhPLrVZO5+5Ty/q/KUfuf/21PM2gnqk5xIzBahWF
	 AuRqNBEiYUEO3IhT9ELTw07O66FMMRYXMvm0QyJQLmfNuyCHKDnpHj3QZO4TtPeB+0
	 i4og588mJkrYb/mqVF9EZoHg2E+e+x6f+twDCqi+8KVVjCanGfmI7epCqf0AiR7yAt
	 t/A3BWzKnUDpgdSPP4Ir3rziUxvasVpFbTrX+GMcchlxxXOU4Ln0t5WYs7PMfG0IFl
	 S6YpNpk3xeGIhCQ0dtw4ikZuCkeL2vYsbD/gUnwRvGiqFbPJCHdI5YRC8z1jh+zi46
	 end+eultxPHqA==
Message-ID: <132bb73c-b98d-41aa-a8bb-0f93abbd408b@kernel.org>
Date: Tue, 9 Jun 2026 21:51:13 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
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
 Larisa Grigore <larisa.grigore@nxp.com>, Haibo Chen <haibo.chen@nxp.com>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
 <20260609142954.1807421-6-ciprianmarian.costea@oss.nxp.com>
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
In-Reply-To: <20260609142954.1807421-6-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ciprianmarian.costea@oss.nxp.com,m:mkl@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:larisa.grigore@nxp.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[oss.nxp.com,pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7797-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2AF8F663F55

On 09/06/2026 at 16:29, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Introduce FLEXCAN_QUIRK_IRQ_BERR quirk to handle hardware integration
> where the FlexCAN module has a dedicated interrupt line for signaling
> bus errors and device state changes.
> 
> This adds the flexcan_irq_esr() handler which composes
> flexcan_do_state() and flexcan_do_berr() to handle platforms where
> these events share a single IRQ line.
> 
> Also extend flexcan_chip_interrupts_enable() to disable/enable the
> new IRQ line during IMASK register writes.
> 
> This is required for NXP S32N79 SoC support.
> 
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>

> ---
>  drivers/net/can/flexcan/flexcan-core.c | 54 +++++++++++++++++++++-----
>  drivers/net/can/flexcan/flexcan.h      |  2 +
>  2 files changed, 47 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index 0ed838f0719a..adf3af57fb0a 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -1300,6 +1300,22 @@ static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
>  	return handled;
>  }
>  
> +/* Combined bus error and state change IRQ handler */
> +static irqreturn_t flexcan_irq_esr(int irq, void *dev_id)
> +{
> +	struct net_device *dev = dev_id;
> +	struct flexcan_priv *priv = netdev_priv(dev);
> +	irqreturn_t handled;
> +
> +	handled = flexcan_do_state(dev);
> +	handled |= flexcan_do_berr(dev);
> +
> +	if (handled)
> +		can_rx_offload_irq_finish(&priv->offload);
> +
> +	return handled;
> +}
> +
>  static void flexcan_set_bittiming_ctrl(const struct net_device *dev)
>  {
>  	const struct flexcan_priv *priv = netdev_priv(dev);
> @@ -1540,10 +1556,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
>  	u64 reg_imask;
>  
>  	disable_irq(dev->irq);
> -	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
> +	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3)
>  		disable_irq(priv->irq_boff);
> +	if (quirks & (FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
>  		disable_irq(priv->irq_err);
> -	}
>  	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
>  		disable_irq(priv->irq_secondary_mb);
>  
> @@ -1554,10 +1570,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
>  	enable_irq(dev->irq);
>  	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
>  		enable_irq(priv->irq_secondary_mb);
> -	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
> -		enable_irq(priv->irq_boff);
> +	if (quirks & (FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
>  		enable_irq(priv->irq_err);
> -	}
> +	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3)
> +		enable_irq(priv->irq_boff);
>  }
>  
>  static void flexcan_chip_interrupts_disable(const struct net_device *dev)
> @@ -1881,7 +1897,8 @@ static int flexcan_open(struct net_device *dev)
>  
>  	can_rx_offload_enable(&priv->offload);
>  
> -	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
> +	if (priv->devtype_data.quirks &
> +			(FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
>  		err = request_irq(dev->irq, flexcan_irq_mb,
>  				  IRQF_SHARED, dev->name, dev);
>  	else
> @@ -1902,6 +1919,13 @@ static int flexcan_open(struct net_device *dev)
>  			goto out_free_irq_boff;
>  	}
>  
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
> +		err = request_irq(priv->irq_err,
> +				  flexcan_irq_esr, IRQF_SHARED, dev->name, dev);
> +		if (err)
> +			goto out_free_irq_boff;
> +	}
> +
>  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
>  		err = request_irq(priv->irq_secondary_mb,
>  				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
> @@ -1916,7 +1940,8 @@ static int flexcan_open(struct net_device *dev)
>  	return 0;
>  
>   out_free_irq_err:
> -	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
> +	if (priv->devtype_data.quirks &
> +			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
>  		free_irq(priv->irq_err, dev);
>   out_free_irq_boff:
>  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
> @@ -1948,10 +1973,12 @@ static int flexcan_close(struct net_device *dev)
>  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
>  		free_irq(priv->irq_secondary_mb, dev);
>  
> -	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
> +	if (priv->devtype_data.quirks &
> +			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
>  		free_irq(priv->irq_err, dev);
> +
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
>  		free_irq(priv->irq_boff, dev);
> -	}
>  
>  	free_irq(dev->irq, dev);
>  	can_rx_offload_disable(&priv->offload);
> @@ -2338,12 +2365,21 @@ static int flexcan_probe(struct platform_device *pdev)
>  	if (transceiver)
>  		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
>  
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
> +		priv->irq_err = platform_get_irq_byname(pdev, "berr");
> +		if (priv->irq_err < 0) {
> +			err = priv->irq_err;
> +			goto failed_platform_get_irq;
> +		}
> +	}
> +
>  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
>  		priv->irq_boff = platform_get_irq(pdev, 1);
>  		if (priv->irq_boff < 0) {
>  			err = priv->irq_boff;
>  			goto failed_platform_get_irq;
>  		}
> +

Nitpick: you shouldn't have unrelated changes, like this newline
addition, in you patches.

@Marc, do you mind removing this while applying?

>  		priv->irq_err = platform_get_irq(pdev, 2);
>  		if (priv->irq_err < 0) {
>  			err = priv->irq_err;
> diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
> index 16692a2502eb..bbb1a8dd4777 100644
> --- a/drivers/net/can/flexcan/flexcan.h
> +++ b/drivers/net/can/flexcan/flexcan.h
> @@ -74,6 +74,8 @@
>   * both need to have an interrupt handler registered.
>   */
>  #define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
> +/* Setup dedicated bus error and state change IRQ */
> +#define FLEXCAN_QUIRK_IRQ_BERR	BIT(19)
>  
>  struct flexcan_devtype_data {
>  	u32 quirks;		/* quirks needed for different IP cores */


Yours sincerely,
Vincent Mailhol


