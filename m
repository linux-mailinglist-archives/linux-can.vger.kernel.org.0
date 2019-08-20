Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5444595811
	for <lists+linux-can@lfdr.de>; Tue, 20 Aug 2019 09:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbfHTHQX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Aug 2019 03:16:23 -0400
Received: from first.geanix.com ([116.203.34.67]:55234 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfHTHQW (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Aug 2019 03:16:22 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 0667726E;
        Tue, 20 Aug 2019 07:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1566285376; bh=qKKclbMPiiBiSs5hOno1OQFE+kET6BNO5Iq1xzhl0sE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=l0eHXxi0wSXmUXYnjpeVZbH5xOl9V0EEdEy6BNnST+deSxSgDJk+kz7QZZFPKZ3qE
         C+QEFaQeHQbE+BfyfhhOkTb8CEZ1qF55LZy6AShZdk2sW2vCetLzF4jvrUdhoAOyf0
         NY8g3lFLo0UsMc3wqfrJ8nctKKH81OooOqwa03bwcwvSyV3o3WY4SrECIB1bVF0N4S
         m9DlqAplIW5WxVpT2QUsDqJGBU0Xytq1/6rmBiqs3oq8PW3+V/eE4bQkPuZtOcwe91
         NPRLR5uMLrv1CU4zIUdXyFMeE0r0j5z+4fm332qbrsI4iIcAZ7+hpGTC/ZX5nNu3SR
         EEFcfwqru7YQA==
Subject: Re: [PATCH 9/9] can: mcp251x: remove custom DMA mapped buffer
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru
References: <20190819153818.29293-1-mkl@pengutronix.de>
 <20190819153818.29293-10-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <3b74696e-3ff5-a790-547e-05b1f7abda1f@geanix.com>
Date:   Tue, 20 Aug 2019 09:16:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819153818.29293-10-mkl@pengutronix.de>
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
> There is no need to duplicate what SPI core already does, i.e. mapping buffers
> for DMA capable transfers. This patch removes all related pices of code.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/spi/mcp251x.c | 58 ++++++-----------------------------
>   1 file changed, 10 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index 0cdb88a9525f..78d44801a0b5 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -47,7 +47,6 @@
>   #include <linux/completion.h>
>   #include <linux/delay.h>
>   #include <linux/device.h>
> -#include <linux/dma-mapping.h>
>   #include <linux/freezer.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
> @@ -202,10 +201,6 @@
>   
>   #define DEVICE_NAME "mcp251x"
>   
> -static int mcp251x_enable_dma; /* Enable SPI DMA. Default: 0 (Off) */
> -module_param(mcp251x_enable_dma, int, 0444);
> -MODULE_PARM_DESC(mcp251x_enable_dma, "Enable SPI DMA. Default: 0 (Off)");
> -
>   static const struct can_bittiming_const mcp251x_bittiming_const = {
>   	.name = DEVICE_NAME,
>   	.tseg1_min = 3,
> @@ -234,8 +229,6 @@ struct mcp251x_priv {
>   
>   	u8 *spi_tx_buf;
>   	u8 *spi_rx_buf;
> -	dma_addr_t spi_tx_dma;
> -	dma_addr_t spi_rx_dma;
>   
>   	struct sk_buff *tx_skb;
>   	int tx_len;
> @@ -304,13 +297,6 @@ static int mcp251x_spi_trans(struct spi_device *spi, int len)
>   	int ret;
>   
>   	spi_message_init(&m);
> -
> -	if (mcp251x_enable_dma) {
> -		t.tx_dma = priv->spi_tx_dma;
> -		t.rx_dma = priv->spi_rx_dma;
> -		m.is_dma_mapped = 1;
> -	}
> -
>   	spi_message_add_tail(&t, &m);
>   
>   	ret = spi_sync(spi, &m);
> @@ -1101,42 +1087,18 @@ static int mcp251x_can_probe(struct spi_device *spi)
>   	priv->spi = spi;
>   	mutex_init(&priv->mcp_lock);
>   
> -	/* If requested, allocate DMA buffers */
> -	if (mcp251x_enable_dma) {
> -		spi->dev.coherent_dma_mask = ~0;
> -
> -		/* Minimum coherent DMA allocation is PAGE_SIZE, so allocate
> -		 * that much and share it between Tx and Rx DMA buffers.
> -		 */
> -		priv->spi_tx_buf = dmam_alloc_coherent(&spi->dev,
> -						       PAGE_SIZE,
> -						       &priv->spi_tx_dma,
> -						       GFP_DMA);
> -
> -		if (priv->spi_tx_buf) {
> -			priv->spi_rx_buf = (priv->spi_tx_buf + (PAGE_SIZE / 2));
> -			priv->spi_rx_dma = (dma_addr_t)(priv->spi_tx_dma +
> -							(PAGE_SIZE / 2));
> -		} else {
> -			/* Fall back to non-DMA */
> -			mcp251x_enable_dma = 0;
> -		}
> +	priv->spi_tx_buf = devm_kzalloc(&spi->dev, SPI_TRANSFER_BUF_LEN,
> +					GFP_KERNEL);
> +	if (!priv->spi_tx_buf) {
> +		ret = -ENOMEM;
> +		goto error_probe;
>   	}
>   
> -	/* Allocate non-DMA buffers */
> -	if (!mcp251x_enable_dma) {
> -		priv->spi_tx_buf = devm_kzalloc(&spi->dev, SPI_TRANSFER_BUF_LEN,
> -						GFP_KERNEL);
> -		if (!priv->spi_tx_buf) {
> -			ret = -ENOMEM;
> -			goto error_probe;
> -		}
> -		priv->spi_rx_buf = devm_kzalloc(&spi->dev, SPI_TRANSFER_BUF_LEN,
> -						GFP_KERNEL);
> -		if (!priv->spi_rx_buf) {
> -			ret = -ENOMEM;
> -			goto error_probe;
> -		}
> +	priv->spi_rx_buf = devm_kzalloc(&spi->dev, SPI_TRANSFER_BUF_LEN,
> +					GFP_KERNEL);
> +	if (!priv->spi_rx_buf) {
> +		ret = -ENOMEM;
> +		goto error_probe;
>   	}
>   
>   	SET_NETDEV_DEV(net, &spi->dev);
> 
