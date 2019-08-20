Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892EC957F3
	for <lists+linux-can@lfdr.de>; Tue, 20 Aug 2019 09:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfHTHMG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Aug 2019 03:12:06 -0400
Received: from first.geanix.com ([116.203.34.67]:54582 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728777AbfHTHMG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Aug 2019 03:12:06 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 6758326E;
        Tue, 20 Aug 2019 07:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1566285119; bh=E4uegiftyW+5HTpJMr3NNC7zMbw/0/pZcSSf2txOnUA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Hu6N8KY9bTmtp9SqU27onFS5RuwHEBYtQweWKCEPGM5Piehw0jj49Q8UUplPU0tgJ
         jldyctIP8+4EoOZr/qAejfEi5u8dTBem6zkquBaqQzmOGg60zUx6CmhBujccYbcEm4
         1LuhdHMNgqq0XtTcPvrU9OMLdEv/MJIC4E89qJsnU2I+mIwYwXPXI6hnnBwmoscaF5
         g6d3ARXyKgJ+F6BwKAZ2zZMWO9kumfMNTddSdgWdaZY4RQGyAl5YudritgxRJZMcBi
         NR9NYUJv+I1tO/wxC0gzKEYpJJod84/0L1BJJiTvN1vHn7xmkVqGbVOwEkRZ9olwgp
         LChYGJSYDCXkQ==
Subject: Re: [PATCH 1/9] can: mcp251x: convert block comments to network style
 comments
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru
References: <20190819153818.29293-1-mkl@pengutronix.de>
 <20190819153818.29293-2-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <6c97ae4c-24b9-a9c7-75b0-5ed9d07cdc56@geanix.com>
Date:   Tue, 20 Aug 2019 09:11:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819153818.29293-2-mkl@pengutronix.de>
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
> This patch converts all block comments to network subsystem style block
> comments.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Acked-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/spi/mcp251x.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index 44e99e3d7134..e59b10525f46 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * CAN bus driver for Microchip 251x/25625 CAN Controller with SPI Interface
> +/* CAN bus driver for Microchip 251x/25625 CAN Controller with SPI Interface
>    *
>    * MCP2510 support and bug fixes by Christian Pellegrin
>    * <chripell@evolware.org>
> @@ -191,8 +190,7 @@
>   #define SET_BYTE(val, byte)			\
>   	(((val) & 0xff) << ((byte) * 8))
>   
> -/*
> - * Buffer size required for the largest SPI transfer (i.e., reading a
> +/* Buffer size required for the largest SPI transfer (i.e., reading a
>    * frame)
>    */
>   #define CAN_FRAME_MAX_DATA_LEN	8
> @@ -282,8 +280,7 @@ static void mcp251x_clean(struct net_device *net)
>   	priv->tx_len = 0;
>   }
>   
> -/*
> - * Note about handling of error return of mcp251x_spi_trans: accessing
> +/* Note about handling of error return of mcp251x_spi_trans: accessing
>    * registers via SPI is not really different conceptually than using
>    * normal I/O assembler instructions, although it's much more
>    * complicated from a practical POV. So it's not advisable to always
> @@ -1098,8 +1095,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
>   	if (mcp251x_enable_dma) {
>   		spi->dev.coherent_dma_mask = ~0;
>   
> -		/*
> -		 * Minimum coherent DMA allocation is PAGE_SIZE, so allocate
> +		/* Minimum coherent DMA allocation is PAGE_SIZE, so allocate
>   		 * that much and share it between Tx and Rx DMA buffers.
>   		 */
>   		priv->spi_tx_buf = dmam_alloc_coherent(&spi->dev,
> @@ -1193,8 +1189,7 @@ static int __maybe_unused mcp251x_can_suspend(struct device *dev)
>   
>   	priv->force_quit = 1;
>   	disable_irq(spi->irq);
> -	/*
> -	 * Note: at this point neither IST nor workqueues are running.
> +	/* Note: at this point neither IST nor workqueues are running.
>   	 * open/stop cannot be called anyway so locking is not needed
>   	 */
>   	if (netif_running(net)) {
> 
