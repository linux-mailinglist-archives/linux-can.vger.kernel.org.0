Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A084014D3
	for <lists+linux-can@lfdr.de>; Mon,  6 Sep 2021 03:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbhIFBqK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 5 Sep 2021 21:46:10 -0400
Received: from mx20.baidu.com ([111.202.115.85]:41548 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241026AbhIFBns (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 5 Sep 2021 21:43:48 -0400
Received: from BC-Mail-EX04.internal.baidu.com (unknown [172.31.51.44])
        by Forcepoint Email with ESMTPS id 88C946C3F1D14F6AD4FE;
        Mon,  6 Sep 2021 09:42:32 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX04.internal.baidu.com (172.31.51.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Mon, 6 Sep 2021 09:42:32 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 6
 Sep 2021 09:42:32 +0800
Date:   Mon, 6 Sep 2021 09:42:31 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-renesas-soc@vger.kernel.org>, <linux-can@vger.kernel.org>
Subject: Re: [PATCH] can: rcar_canfd: add __maybe_unused annotation to
 silence warning
Message-ID: <20210906014231.GA471@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20210904130701.641078-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210904130701.641078-1-mkl@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex09.internal.baidu.com (10.127.64.32) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

+Cc: linux-renesas-soc@vger.kernel.org
On 04 Sep 21 15:07:01, Marc Kleine-Budde wrote:
> Since commit
> 
> | dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
> 
> the rcar_canfd driver can be compile tested on all architectures. On
> non OF enabled archs, or archs where OF is optional (and disabled in
> the .config) the compilation throws the following warning:
> 
> | drivers/net/can/rcar/rcar_canfd.c:2020:34: warning: unused variable 'rcar_canfd_of_table' [-Wunused-const-variable]
> | static const struct of_device_id rcar_canfd_of_table[] = {
> |                                  ^
> 
> This patch fixes the warning by marking the variable
> rcar_canfd_of_table as __maybe_unused.
> 
> Fixes: ac4224087312 ("can: rcar: Kconfig: Add helper dependency on COMPILE_TEST")
> Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
> Cc: Cai Huoqing <caihuoqing@baidu.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index c47988d3674e..c05a7f60c0a8 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -2017,7 +2017,7 @@ static int __maybe_unused rcar_canfd_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
>  			 rcar_canfd_resume);
>  
> -static const struct of_device_id rcar_canfd_of_table[] = {
> +static const struct of_device_id rcar_canfd_of_table[] __maybe_unused = {
>  	{ .compatible = "renesas,rcar-gen3-canfd", .data = (void *)RENESAS_RCAR_GEN3 },
>  	{ .compatible = "renesas,rzg2l-canfd", .data = (void *)RENESAS_RZG2L },
>  	{ }
> -- 
> 2.33.0
> 
> 
