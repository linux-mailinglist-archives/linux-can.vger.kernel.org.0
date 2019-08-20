Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A47B957F7
	for <lists+linux-can@lfdr.de>; Tue, 20 Aug 2019 09:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfHTHM1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Aug 2019 03:12:27 -0400
Received: from first.geanix.com ([116.203.34.67]:54680 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728947AbfHTHM1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Aug 2019 03:12:27 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 7EBD726E;
        Tue, 20 Aug 2019 07:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1566285141; bh=d5X/W7q5H/7pI+HgrH1HQjLizWQeiBPLAo/OfFluDq0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QLcW1ZbygTTJyyC7vQRbZB/kXKkg6Lzb3R3l3bXjTURvY5oGgCW8Iovq/OZPNWEjN
         81SealChSzOiHdog/MmwALbytQPsPANYdWJx2ZTd3KqSFbltO1CBG66zu2vKEUM8Au
         i23rNM0wd1fNeVFr5JIpkbOST4ItNoj/hK4PEFW9xWtoKlkwVd4yPlqfpEcKWP5JVP
         cJhkteOFkUbF1RmrwjtZdZRoASKhwcsByhajBPt1Nagu3CEBoVrQLstulzzhVgaXTh
         pmbvSeekhLU286H9Ktlm24lzed/QLIr/dez2ZjsJKdsQg7rhK6V53u0k9wdUsFNgeE
         RNtvUwsAMA5Gw==
Subject: Re: [PATCH 3/9] can: mcp251x: avoid long lines
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru
References: <20190819153818.29293-1-mkl@pengutronix.de>
 <20190819153818.29293-4-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <fdf57f64-fa5e-b32f-358e-a136c56ce775@geanix.com>
Date:   Tue, 20 Aug 2019 09:12:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819153818.29293-4-mkl@pengutronix.de>
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
> This patch fixes long lines in the driver.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Acked-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/spi/mcp251x.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index 3ec0907a0ee7..0fd559510d75 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -806,7 +806,8 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
>   			 * (The MCP2515/25625 does this automatically.)
>   			 */
>   			if (mcp251x_is_2510(spi))
> -				mcp251x_write_bits(spi, CANINTF, CANINTF_RX0IF, 0x00);
> +				mcp251x_write_bits(spi, CANINTF,
> +						   CANINTF_RX0IF, 0x00);
>   		}
>   
>   		/* receive buffer 1 */
> @@ -1133,7 +1134,8 @@ static int mcp251x_can_probe(struct spi_device *spi)
>   	ret = mcp251x_hw_probe(spi);
>   	if (ret) {
>   		if (ret == -ENODEV)
> -			dev_err(&spi->dev, "Cannot initialize MCP%x. Wrong wiring?\n", priv->model);
> +			dev_err(&spi->dev, "Cannot initialize MCP%x. Wrong wiring?\n",
> +				priv->model);
>   		goto error_probe;
>   	}
>   
> 
