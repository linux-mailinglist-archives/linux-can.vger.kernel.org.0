Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B63A2D93D1
	for <lists+linux-can@lfdr.de>; Mon, 14 Dec 2020 09:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439059AbgLNIMQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Dec 2020 03:12:16 -0500
Received: from first.geanix.com ([116.203.34.67]:57718 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388775AbgLNIMP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 14 Dec 2020 03:12:15 -0500
Received: from [IPv6:2a06:4004:10df:1:da27:a6d2:5305:fd0a] (_gateway [172.21.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 8C4F4481A89;
        Mon, 14 Dec 2020 08:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1607933492; bh=nuFsM+UUbX/52onYT6DdYCzq2OOHgNNR+P0AXt4dbc8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Eh3wtaQ1b8goiRbWTAdD27LeeINR2Q9YIPM5HTvpByRkARLVlP9OcwEFsGJJUM1+T
         ivGUuFwuUz9/k/pKN40ZlBgmJdgdm20twl+nKEXs5pbHi9uZLzVZQsnGy5y/QWz6LG
         Z7X6tk0viPcXQAR9xMW1h9giohspC2S21hsMlAprZowt48kQizYVyZtJgVheM1NOyE
         GCigWzRemcVJNG0brKwiP/hXZRZgQ/IEXGCNKTLgKMWTx6syjcIn38L2bpOsqo3pOf
         LBu+ZwkS0s4v14i13iNg8sOkJ+7eHrLM+u0JbyNX0JXB1frMlGZjhyG+B7tHM0qrEP
         kvk3JSPy9A7YA==
Subject: Re: [can-next-rfc 1/7] can: m_can: update link to M_CAN user manual
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>
References: <20201212175518.139651-1-mkl@pengutronix.de>
 <20201212175518.139651-2-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <c7850081-4a94-7feb-172d-c0cfe18304a8@geanix.com>
Date:   Mon, 14 Dec 2020 09:11:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201212175518.139651-2-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on ff3d05386fc5
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 12/12/2020 18.55, Marc Kleine-Budde wrote:
> Old versions of the user manual are regularly depublished, so change link to
> point to the product page instead. This will be hopefully more stable.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/m_can/m_can.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 06c136961c7c..8873f6f6f6da 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -5,8 +5,7 @@
>   // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
>   
>   /* Bosch M_CAN user manual can be obtained from:
> - * http://www.bosch-semiconductors.de/media/pdf_1/ipmodules_1/m_can/
> - * mcan_users_manual_v302.pdf
> + * https://www.bosch-semiconductors.com/ip-modules/can-ip-modules/m-can/
>    */
>   
>   #include <linux/interrupt.h>
>
> base-commit: 46d5e62dd3c34770f3bfd0642daa9a7772a00362

