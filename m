Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A0395805
	for <lists+linux-can@lfdr.de>; Tue, 20 Aug 2019 09:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfHTHOZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Aug 2019 03:14:25 -0400
Received: from first.geanix.com ([116.203.34.67]:55070 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfHTHOZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Aug 2019 03:14:25 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 235D126E;
        Tue, 20 Aug 2019 07:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1566285260; bh=cnp9IYbVJZIIy6EGEBerdU5tu1Xa5s1WTnf+tFjgIcI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=O5n3MEBlzIhLEMAHf/AF3HUjswyby1aRlevSlPFO13aqzEr2V0UlsQ5Aa13zM/0oP
         6xn51lsaN2hponQR5OLzpdMFD5sWEi+zG/9PltR91TbhEnVwUwHyuu7BL7UdCBeHEm
         emVX15JWUuOMNIK0av+OmJJQGTs1fEiqdEnA+HAWZh40sZBjziAZfmStJq1atUiBgn
         b+E5qs0kI7eqNAUS4b2dIcoxjcgcqiqQDhEthM0ZlOyo2c0R+qftqcYp2KgXkkcxHK
         ZH5RNA7bEUHmhwjB6/M+Rumj9zx1XhL1focVIdqaqwP3aB6SQEZi3tDkcKhO4u2AeT
         oXLGtsfXbO02w==
Subject: Re: [PATCH 5/9] can: mcp251x: use u8 instead of uint8_t
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru
References: <20190819153818.29293-1-mkl@pengutronix.de>
 <20190819153818.29293-6-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <0a7ec3e0-5923-e7f2-5eef-3ab3a33bb3b6@geanix.com>
Date:   Tue, 20 Aug 2019 09:14:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819153818.29293-6-mkl@pengutronix.de>
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
> This patch changes all the uint8_t in the arguments in several function
> to u8.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Acked-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/spi/mcp251x.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index d4ae47a0a850..44b57187a6f3 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -319,7 +319,7 @@ static int mcp251x_spi_trans(struct spi_device *spi, int len)
>   	return ret;
>   }
>   
> -static u8 mcp251x_read_reg(struct spi_device *spi, uint8_t reg)
> +static u8 mcp251x_read_reg(struct spi_device *spi, u8 reg)
>   {
>   	struct mcp251x_priv *priv = spi_get_drvdata(spi);
>   	u8 val = 0;
> @@ -333,8 +333,7 @@ static u8 mcp251x_read_reg(struct spi_device *spi, uint8_t reg)
>   	return val;
>   }
>   
> -static void mcp251x_read_2regs(struct spi_device *spi, uint8_t reg,
> -		uint8_t *v1, uint8_t *v2)
> +static void mcp251x_read_2regs(struct spi_device *spi, u8 reg, u8 *v1, u8 *v2)
>   {
>   	struct mcp251x_priv *priv = spi_get_drvdata(spi);
>   
> @@ -347,7 +346,7 @@ static void mcp251x_read_2regs(struct spi_device *spi, uint8_t reg,
>   	*v2 = priv->spi_rx_buf[3];
>   }
>   
> -static void mcp251x_write_reg(struct spi_device *spi, u8 reg, uint8_t val)
> +static void mcp251x_write_reg(struct spi_device *spi, u8 reg, u8 val)
>   {
>   	struct mcp251x_priv *priv = spi_get_drvdata(spi);
>   
> @@ -359,7 +358,7 @@ static void mcp251x_write_reg(struct spi_device *spi, u8 reg, uint8_t val)
>   }
>   
>   static void mcp251x_write_bits(struct spi_device *spi, u8 reg,
> -			       u8 mask, uint8_t val)
> +			       u8 mask, u8 val)
>   {
>   	struct mcp251x_priv *priv = spi_get_drvdata(spi);
>   
> 
