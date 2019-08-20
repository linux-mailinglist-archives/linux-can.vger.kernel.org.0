Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA97F95810
	for <lists+linux-can@lfdr.de>; Tue, 20 Aug 2019 09:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfHTHPu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Aug 2019 03:15:50 -0400
Received: from first.geanix.com ([116.203.34.67]:55212 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfHTHPu (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Aug 2019 03:15:50 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 9D2FB26E;
        Tue, 20 Aug 2019 07:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1566285345; bh=pdgawVF1DO9rtMBZM+zriqu2ydOuRAUv1rsJrKBH5V4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=H2FuP3dObNR4p7V5OXdnq5gyvXNLmfjlJJL+RLZnCfwNCnCP6veHYbJ9cUyiOJldT
         mwUnZXH3+0y09TckyVg+4P8uwM9nfB3oCEVVwHtagvA+NM0V7ZCnSmLzC6ad/vsWYF
         AsdpAjtIx01aZI9Ur5yGOBSGyqK6DWY6+h/MHCCfEEPZ/Q+7AcxNjA1zjI8+7VhiXE
         rGUSgXRF8U0fn4xGTM6kzoeRrvMZt5dymxbqx9vZgK9OImXT3M2j4+VcjAseqEYWua
         j/r7xM/f7Pf0oXdBSfOp86aWD3mLWBOwJozOZsVIT9/W9V0682t0dzoxIbACRaBCV4
         AYEcDFaeyqXmg==
Subject: Re: [PATCH 8/9] can: mcp251x: Use DT-supplied interrupt flags
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru,
        Phil Elwell <phil@raspberrypi.org>
References: <20190819153818.29293-1-mkl@pengutronix.de>
 <20190819153818.29293-9-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <4b203cb9-cdf2-76e4-ea01-87ed324b3de6@geanix.com>
Date:   Tue, 20 Aug 2019 09:15:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819153818.29293-9-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 19/08/2019 17.38, Marc Kleine-Budde wrote:
> From: Phil Elwell <phil@raspberrypi.org>
> 
> The MCP2515 datasheet clearly describes a level-triggered interrupt pin.
> Therefore the receiving interrupt controller must also be configured for
> level-triggered operation otherwise there is a danger of a missed
> interrupt condition blocking all subsequent interrupts. The ONESHOT
> flag ensures that the interrupt is masked until the threaded interrupt
> handler exits.
> 
> Rather than change the flags globally (they must have worked for at
> least one user), keep the old behavior for for non DT devices. DT based
> devices specify the flags in their corresonding DT node.
> 
> See: https://github.com/raspberrypi/linux/issues/2175
>       https://github.com/raspberrypi/linux/issues/2263
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/spi/mcp251x.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index 19756fb3921a..0cdb88a9525f 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -923,7 +923,7 @@ static int mcp251x_open(struct net_device *net)
>   {
>   	struct mcp251x_priv *priv = netdev_priv(net);
>   	struct spi_device *spi = priv->spi;
> -	unsigned long flags = IRQF_ONESHOT | IRQF_TRIGGER_FALLING;
> +	unsigned long flags = 0;
>   	int ret;
>   
>   	ret = open_candev(net);
> @@ -939,6 +939,9 @@ static int mcp251x_open(struct net_device *net)
>   	priv->tx_skb = NULL;
>   	priv->tx_len = 0;
>   
> +	if (!spi->dev.of_node)
> +		flags = IRQF_TRIGGER_FALLING;
> +
>   	ret = request_threaded_irq(spi->irq, NULL, mcp251x_can_ist,
>   				   flags | IRQF_ONESHOT, dev_name(&spi->dev),
>   				   priv);
> 
