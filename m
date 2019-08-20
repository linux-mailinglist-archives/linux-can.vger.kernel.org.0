Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2896957F4
	for <lists+linux-can@lfdr.de>; Tue, 20 Aug 2019 09:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfHTHMR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Aug 2019 03:12:17 -0400
Received: from first.geanix.com ([116.203.34.67]:54600 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728777AbfHTHMR (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Aug 2019 03:12:17 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 0134526E;
        Tue, 20 Aug 2019 07:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1566285132; bh=24zW+Z0O0qZu6i+vfKxWBN5AsaaOpI+2jDl7NKi05x4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mahO6flAGFRKdujW7G7rezpO4a8qOXvdnuKARh4qje9Ux+JJbdewtEtKU6tTs6AJz
         RVwnWlobYQhtGxt9qn0Iv7yeCu70mnTGoVTuLqr+kx4RJUbHCz5fxQHId8hy3iBvvz
         lak85W37hzeo/Es/In8GFLcmTypfo0VpeulcKW6QTlm05PulqVjQqa/ebF5kbxX885
         u3E0IfQUYsVsHeF7iaTv0n+jNsv9PK10ip0Ydsl+R46TmBnkV8umNdRrbS4W8iC+nO
         3qbI0ZNOet7GihDN1OO/LQvtzlM8haIK2yM74UL2eb80YH7HZqPZqXTcoIYso5TCtI
         yDmmOK8z6z12A==
Subject: Re: [PATCH 2/9] can: mcp251x: remove unnecessary blank lines
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru
References: <20190819153818.29293-1-mkl@pengutronix.de>
 <20190819153818.29293-3-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <9937351e-d03f-1294-7f93-0a10143d1b77@geanix.com>
Date:   Tue, 20 Aug 2019 09:11:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819153818.29293-3-mkl@pengutronix.de>
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
> This patch removes unnecessary blank lines, so that checkpatch doesn't
> complain anymore.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Acked-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/spi/mcp251x.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index e59b10525f46..3ec0907a0ee7 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -74,7 +74,6 @@
>   #define RTS_TXB2		0x04
>   #define INSTRUCTION_RTS(n)	(0x80 | ((n) & 0x07))
>   
> -
>   /* MPC251x registers */
>   #define CANSTAT	      0x0e
>   #define CANCTRL	      0x0f
> @@ -907,7 +906,6 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
>   			}
>   			netif_wake_queue(net);
>   		}
> -
>   	}
>   	mutex_unlock(&priv->mcp_lock);
>   	return IRQ_HANDLED;
> 
