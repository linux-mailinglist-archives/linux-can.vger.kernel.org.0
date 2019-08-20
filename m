Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5A49580C
	for <lists+linux-can@lfdr.de>; Tue, 20 Aug 2019 09:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfHTHP2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Aug 2019 03:15:28 -0400
Received: from first.geanix.com ([116.203.34.67]:55196 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfHTHP2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Aug 2019 03:15:28 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id D3D3C26E;
        Tue, 20 Aug 2019 07:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1566285323; bh=0ucM5ANPdYAUrsAkG8mhory7oiKuvDEWw37eqHSMHHM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JQWMTHDqktCBcIpwjKkazXXsF4uqS8kMrn1vgs0DMQd7W+/rYbM9q5UKLrBQCCfKK
         NzwM/xTzFtHxpNf0besPmFGidHyZTIr4kCdo94G0gjmNkvUuixuZcJEUnQRBihNLRz
         45Z0PsCa8gEw0w1MphShP5G/3/mN8UYilyHHGv2Tn5Khzzyl6L0k8nCk8H5mXQWkBK
         XJBOqspwbQDszjv7UauNIBCAhwisSe8EbEodGKzZ+8e54S592PJK39KooR1I97SrC6
         NfKpUNPv+AEU0JAc7chAr4Sg7cui6I+p5AtA0tFtCAinesPJi1eSOkiE5Inrik3I5a
         ZUAuVvnaA2REQ==
Subject: Re: [PATCH 7/9] can: mcp251x: Use dev_name() during
 request_threaded_irq()
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru
References: <20190819153818.29293-1-mkl@pengutronix.de>
 <20190819153818.29293-8-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <6beb6d27-dbeb-02bb-af17-b77041d9870f@geanix.com>
Date:   Tue, 20 Aug 2019 09:15:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819153818.29293-8-mkl@pengutronix.de>
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
> From: Alexander Shiyan <shc_work@mail.ru>
> 
> Passing driver name as name during request_threaded_irq() results in all
> CAN IRQs have same name. This does not help much to easily identify which
> IRQ belongs to which CAN instance. Therefore pass dev_name() during
> request_threaded_irq() so that better identifiable name is listed for
> CAN devices in cat /proc/interrupts output.
> 
> Output of cat /proc/interrupts
> Before this patch:
>    253:          2  gpio-mxc  13 Edge      mcp251x
>    259:          2  gpio-mxc  19 Edge      mcp251x
> After this patch:
>    253:          2  gpio-mxc  13 Edge      spi1.1
>    259:          2  gpio-mxc  19 Edge      spi1.2
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/spi/mcp251x.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index db69c04bac2d..19756fb3921a 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -940,7 +940,8 @@ static int mcp251x_open(struct net_device *net)
>   	priv->tx_len = 0;
>   
>   	ret = request_threaded_irq(spi->irq, NULL, mcp251x_can_ist,
> -				   flags | IRQF_ONESHOT, DEVICE_NAME, priv);
> +				   flags | IRQF_ONESHOT, dev_name(&spi->dev),
> +				   priv);
>   	if (ret) {
>   		dev_err(&spi->dev, "failed to acquire irq %d\n", spi->irq);
>   		mcp251x_power_enable(priv->transceiver, 0);
> 
