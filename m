Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225DC957FB
	for <lists+linux-can@lfdr.de>; Tue, 20 Aug 2019 09:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfHTHNK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Aug 2019 03:13:10 -0400
Received: from first.geanix.com ([116.203.34.67]:54880 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfHTHNK (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Aug 2019 03:13:10 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 2171C26E;
        Tue, 20 Aug 2019 07:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1566285185; bh=z63fLAUmXYsxP138Z1aGwEDAut3RWh37rV7wCdcxi0Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YdZbPQZhd39sQopN6+bM5PpWKlJjRSIMXa0Ass7oznoVqTsMbRF5Vbmf4k2kPCO+G
         lsC/I4QyUTMoXjuV+yPjJTe15141A9gxQteMGJJNso//JCuVCN0l6505uNajFkj1Gy
         gMovIIf4bCrrRf1ssYwPvZ6ACFQRBPPrY+eylrQBGE9cb/MPkYxkJmV77ZNfUzoF9M
         EGygfW1S1fdB2HiSlukCty8nYed0RVD/AxSklOoQKQD1ksyQsyjzYK34Jf7it3B48I
         gWZGhiZVrKpi2OlWgwuCm5q/YwP7yXREvfBb52wQ/02IQcLmNduGgGvMvybRCId5D9
         qxE0mZut0wrjg==
Subject: Re: [PATCH 4/9] can: mcp251x: fix print formating strings
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru
References: <20190819153818.29293-1-mkl@pengutronix.de>
 <20190819153818.29293-5-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <07086f13-c771-48cf-441e-7abc07069b6c@geanix.com>
Date:   Tue, 20 Aug 2019 09:12:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819153818.29293-5-mkl@pengutronix.de>
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
> This patch fixes the print format strings in the driver.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Acked-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/spi/mcp251x.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index 0fd559510d75..d4ae47a0a850 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -561,8 +561,7 @@ static int mcp251x_set_normal_mode(struct spi_device *spi)
>   		while (mcp251x_read_reg(spi, CANSTAT) & CANCTRL_REQOP_MASK) {
>   			schedule();
>   			if (time_after(jiffies, timeout)) {
> -				dev_err(&spi->dev, "MCP251x didn't"
> -					" enter in normal mode\n");
> +				dev_err(&spi->dev, "MCP251x didn't enter in normal mode\n");
>   				return -EBUSY;
>   			}
>   		}
> 
