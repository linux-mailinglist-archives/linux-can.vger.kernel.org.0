Return-Path: <linux-can+bounces-1966-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EE69C4D64
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 04:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7495FB27F97
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 03:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9780E204F7B;
	Tue, 12 Nov 2024 03:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPHS1LaR"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FAB1A072A;
	Tue, 12 Nov 2024 03:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731382345; cv=none; b=Phd86Jub0pXVrN1lKb+FvyquGv4+Ik5NuhlIoQtpjXhY9sVK1L1OTU8UPMaJKH9tS72YYNmNEXjWDlm4Q0NG0IYxogFy5Xs9LkMzUn3NZs1q+makwIvkddrgv8GFPnaAJo7XYrx4dEEoQZJcvMSyJ60Evv2HlXAzkWUc/mQC3DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731382345; c=relaxed/simple;
	bh=CRaC5wjfbFfQA5LdfDrUsa3MI7ETN4OH4NFZVHy3LZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOPYjepGjN6wYs2Xw4UEk9/cYJkq51WjLjWdNC1P8L8m8yVQYY6YdzTP10tilxiJqH7X/8CTSP4PpE+wj6ESsaXjAGjgGwmQAWyp7hisVBe4TGneQezsmevlF4EZmw3BKec/pdTP27CipJJ7wJ3YvMncA8crGHum4Phk5ossbtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPHS1LaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CC2C4CECD;
	Tue, 12 Nov 2024 03:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731382345;
	bh=CRaC5wjfbFfQA5LdfDrUsa3MI7ETN4OH4NFZVHy3LZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qPHS1LaRS738ZEdxN0SIOOejrDNeR3mIZxf8FoqvHVzE+3P3HSDY/j89/4CNJY/Yf
	 8hhjNmzYPFoAGbat558J4jia9L6DHohhw0myhq/FXq5DCXErxtsPeIeOtlclyDs4tR
	 LfkjrG0cQozV0elK6PBJl7JWLZP514f7/Y3EWaSRIJmk9w4wF+9bgZ52aUjfiJMbcB
	 N/ITfrxNiOAELhQo9fW15NPfJJq2o9RZ25mV2R+apxtOA0SrGqeurIZ9SvEQLUNYNo
	 TmkKiKJ3HtXv96XDD6L6cva4MvyIkSREmIoMo3a0fij2iRWm9tbbDpNfMAzK1xkj99
	 4cbvrSuUZL8ng==
Date: Mon, 11 Nov 2024 19:32:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Pantelis Antoniou
 <pantelis.antoniou@gmail.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Byungho An <bh74.an@samsung.com>, Kevin Brace
 <kevinbrace@bracecomputerlab.com>, Francois Romieu <romieu@fr.zoreil.com>,
 Michal Simek <michal.simek@amd.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Zhao Qiang
 <qiang.zhao@nxp.com>, linux-can@vger.kernel.org (open list:CAN NETWORK
 DRIVERS), linux-kernel@vger.kernel.org (open list),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi
 SoC support), linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi
 SoC support), linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC
 FS_ENET DRIVER)
Subject: Re: [PATCHv2 net-next] net: use pdev instead of OF funcs
Message-ID: <20241111193222.00ae2f3e@kernel.org>
In-Reply-To: <20241111210316.15357-1-rosenp@gmail.com>
References: <20241111210316.15357-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 13:03:16 -0800 Rosen Penev wrote:
> --- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
> +++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
> @@ -111,7 +111,7 @@ static int sxgbe_platform_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Get the SXGBE common INT information */
> -	priv->irq  = irq_of_parse_and_map(node, 0);
> +	priv->irq = platform_get_irq(pdev, 0);
>  	if (priv->irq <= 0) {
>  		dev_err(dev, "sxgbe common irq parsing failed\n");
>  		goto err_drv_remove;
> @@ -122,7 +122,7 @@ static int sxgbe_platform_probe(struct platform_device *pdev)
>  
>  	/* Get the TX/RX IRQ numbers */
>  	for (i = 0, chan = 1; i < SXGBE_TX_QUEUES; i++) {
> -		priv->txq[i]->irq_no = irq_of_parse_and_map(node, chan++);
> +		priv->txq[i]->irq_no = platform_get_irq(pdev, chan++);
>  		if (priv->txq[i]->irq_no <= 0) {
>  			dev_err(dev, "sxgbe tx irq parsing failed\n");
>  			goto err_tx_irq_unmap;
> @@ -130,14 +130,14 @@ static int sxgbe_platform_probe(struct platform_device *pdev)
>  	}
>  
>  	for (i = 0; i < SXGBE_RX_QUEUES; i++) {
> -		priv->rxq[i]->irq_no = irq_of_parse_and_map(node, chan++);
> +		priv->rxq[i]->irq_no = platform_get_irq(pdev, chan++);
>  		if (priv->rxq[i]->irq_no <= 0) {
>  			dev_err(dev, "sxgbe rx irq parsing failed\n");
>  			goto err_rx_irq_unmap;
>  		}
>  	}
>  
> -	priv->lpi_irq = irq_of_parse_and_map(node, chan);
> +	priv->lpi_irq = platform_get_irq(pdev, chan);
>  	if (priv->lpi_irq <= 0) {
>  		dev_err(dev, "sxgbe lpi irq parsing failed\n");
>  		goto err_rx_irq_unmap;

Coccicheck wants you to drop the errors:

drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c:116:2-9: line 116 is redundant because platform_get_irq() already prints an error
drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c:127:3-10: line 127 is redundant because platform_get_irq() already prints an error
drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c:135:3-10: line 135 is redundant because platform_get_irq() already prints an error
drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c:142:2-9: line 142 is redundant because platform_get_irq() already prints an error

You can make it a separate patch in a series, for clarity.
-- 
pw-bot: cr

