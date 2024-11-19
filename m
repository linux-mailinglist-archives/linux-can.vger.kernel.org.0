Return-Path: <linux-can+bounces-2110-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE88A9D2277
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 10:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D961F22AEB
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB3B1AA1CF;
	Tue, 19 Nov 2024 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OBgK1bxg"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642D619C54F;
	Tue, 19 Nov 2024 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732008436; cv=none; b=sqvSR4anK19onABy444a67Rj4uFNos0UL0RI7nAC9/5kK/KXne5Erz3TPdNWDXvHlIHIXUXRyRwRvZ69poAYMIz18+uI6mBA574zHjZPH9l9feeAbdZjRTCQVcMX+lAKv5RoHycs7m5vMgFiaDN1kPJURSYvl7A69rFY6MO9sMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732008436; c=relaxed/simple;
	bh=f5ihpDJvqgir0zv3QuZSwywjiBQF+KN1/Y5HpEPSIiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRuYhGooZAxgn39t+4S2RjxBYLzf6pdif3D0sG9RxzQUjUWlIJp2xwj5ZcpzVM+zNzAdWQFxABUj73MzxeIulE3/BrV4A5SKHCAPlmZeZpsrAeP5vro5nTzojBLhY1g8b0+nAhp4WfPTSoZm3OqRfGtHoyPMNWb4HZ8wjdQ8/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OBgK1bxg; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id DKVZtsAoVdDuoDKVatxUbR; Tue, 19 Nov 2024 10:27:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1732008423;
	bh=fyZEfuN/RV8KWKotZDgCoJOAeqacw5DLGXuvDWF6C8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=OBgK1bxgCLcgXVA4T6noDrGW+Cl3qCA8KWHR+nbfwNGyShxwaeJoK7+F8hSFc3QG8
	 oTd0onsCbce7dhtuxEJ2aKDFedzM5vl9GYJJFA7O0wWdUW/VeQ9r4fh7QhEaYx2tdq
	 Oar18FH6zHMTp82VwAfIG6hJbYK8Diz4bi3cyez1f3Y814FrCrRq3Pn8jIfFghEIEw
	 c+HehiRTck6rQQOoP/Qkq3zRgHebVY1tXwo/ZrsY6Jnzp37QqhvSz030Ky5iaXEzE4
	 rtMFfpgNMbgfR1IF1vOkfal/AEg5E6YHih9R06ER90GINggZx308IJ0U3TArkiyP9I
	 ZFLeV/cX/Gw8A==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Nov 2024 10:27:03 +0100
X-ME-IP: 124.33.176.97
Message-ID: <57915ed9-e57e-4ca3-bc31-6405893c937e@wanadoo.fr>
Date: Tue, 19 Nov 2024 18:26:51 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, NXP Linux Team <s32@nxp.com>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-4-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241119081053.4175940-4-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/11/2024 at 17:10, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> On S32G2/S32G3 SoC, there are separate interrupts
> for state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
> 
> In order to handle this FlexCAN hardware particularity, reuse
> the 'FLEXCAN_QUIRK_NR_IRQ_3' quirk provided by mcf5441x's irq
> handling support.
> 
> Additionally, introduce 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk,
> which can be used in case there are two separate mailbox ranges
> controlled by independent hardware interrupt lines, as it is
> the case on S32G2/S32G3 SoC.
> 
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 25 +++++++++++++++++++++++--
>  drivers/net/can/flexcan/flexcan.h      |  3 +++
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index f0dee04800d3..dc56d4a7d30b 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -390,9 +390,10 @@ static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
>  	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
>  		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
>  		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
> -		FLEXCAN_QUIRK_SUPPORT_ECC |
> +		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_NR_IRQ_3 |
>  		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
> -		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
> +		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
> +		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
>  };
>  
>  static const struct can_bittiming_const flexcan_bittiming_const = {
> @@ -1771,12 +1772,21 @@ static int flexcan_open(struct net_device *dev)
>  			goto out_free_irq_boff;
>  	}
>  
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
> +		err = request_irq(priv->irq_secondary_mb,
> +				  flexcan_irq, IRQF_SHARED, dev->name, dev);
> +		if (err)
> +			goto out_free_irq_err;
> +	}

Is the logic here correct?

  request_irq(priv->irq_err, flexcan_irq, IRQF_SHARED, dev->name, dev);

is called only if the device has the FLEXCAN_QUIRK_NR_IRQ_3 quirk.

So, if the device has the FLEXCAN_QUIRK_SECONDARY_MB_IRQ but not the
FLEXCAN_QUIRK_NR_IRQ_3, you may end up trying to free an irq which was
not initialized.

Did you confirm if it is safe to call free_irq() on an uninitialized irq?

(and I can see that currently there is no such device with
FLEXCAN_QUIRK_SECONDARY_MB_IRQ but without FLEXCAN_QUIRK_NR_IRQ_3, but
who knows if such device will be introduced in the future?)

>  	flexcan_chip_interrupts_enable(dev);
>  
>  	netif_start_queue(dev);
>  
>  	return 0;
>  
> + out_free_irq_err:
> +	free_irq(priv->irq_err, dev);
>   out_free_irq_boff:
>  	free_irq(priv->irq_boff, dev);
>   out_free_irq:
> @@ -1808,6 +1818,9 @@ static int flexcan_close(struct net_device *dev)
>  		free_irq(priv->irq_boff, dev);
>  	}
>  
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
> +		free_irq(priv->irq_secondary_mb, dev);
> +
>  	free_irq(dev->irq, dev);
>  	can_rx_offload_disable(&priv->offload);
>  	flexcan_chip_stop_disable_on_error(dev);
> @@ -2197,6 +2210,14 @@ static int flexcan_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
> +		priv->irq_secondary_mb = platform_get_irq(pdev, 3);
> +		if (priv->irq_secondary_mb < 0) {
> +			err = priv->irq_secondary_mb;
> +			goto failed_platform_get_irq;
> +		}
> +	}
> +
>  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
>  		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
>  			CAN_CTRLMODE_FD_NON_ISO;
> diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
> index 4933d8c7439e..d4b1a954c538 100644
> --- a/drivers/net/can/flexcan/flexcan.h
> +++ b/drivers/net/can/flexcan/flexcan.h
> @@ -70,6 +70,8 @@
>  #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
>  /* Setup stop mode with ATF SCMI protocol to support wakeup */
>  #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
> +/* Setup secondary mailbox interrupt */
> +#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
>  
>  struct flexcan_devtype_data {
>  	u32 quirks;		/* quirks needed for different IP cores */
> @@ -105,6 +107,7 @@ struct flexcan_priv {
>  	struct regulator *reg_xceiver;
>  	struct flexcan_stop_mode stm;
>  
> +	int irq_secondary_mb;
>  	int irq_boff;
>  	int irq_err;
>  

Yours sincerely,
Vincent Mailhol


