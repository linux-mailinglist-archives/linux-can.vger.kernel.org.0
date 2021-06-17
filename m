Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68723AA800
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 02:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhFQAU1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 20:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhFQAU1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 16 Jun 2021 20:20:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27090613BD;
        Thu, 17 Jun 2021 00:18:18 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] m68k: m5441x: add flexcan support
To:     Angelo Dureghello <angelo@kernel-space.org>, wg@grandegger.com,
        mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
References: <20210616231652.738027-1-angelo@kernel-space.org>
 <20210616231652.738027-3-angelo@kernel-space.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <45495fee-b026-0a2c-6b98-1631cbd8060f@linux-m68k.org>
Date:   Thu, 17 Jun 2021 10:18:16 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210616231652.738027-3-angelo@kernel-space.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Angelo,

On 17/6/21 9:16 am, Angelo Dureghello wrote:
> Add flexcan support.
> 
> ---
> Changes for v2:
> - add irq resources for ERR and BOFF interrutps
> 
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>

You should put your signed-off-by above the first "---".
Tools like "git am" drop everything below the first "---" and before the
patch proper. So it ends up losing your signed-off-by.

Regards
Greg



> ---
>   arch/m68k/coldfire/device.c       | 42 +++++++++++++++++++++++++++++++
>   arch/m68k/coldfire/m5441x.c       |  8 +++---
>   arch/m68k/include/asm/m5441xsim.h | 19 ++++++++++++++
>   3 files changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
> index 59f7dfe50a4d..1b2eaee6d6f6 100644
> --- a/arch/m68k/coldfire/device.c
> +++ b/arch/m68k/coldfire/device.c
> @@ -23,6 +23,7 @@
>   #include <linux/platform_data/edma.h>
>   #include <linux/platform_data/dma-mcf-edma.h>
>   #include <linux/platform_data/mmc-esdhc-mcf.h>
> +#include <linux/can/platform/mcf5441x.h>
>   
>   /*
>    *	All current ColdFire parts contain from 2, 3, 4 or 10 UARTS.
> @@ -581,6 +582,44 @@ static struct platform_device mcf_esdhc = {
>   };
>   #endif /* MCFSDHC_BASE */
>   
> +#if IS_ENABLED(CONFIG_CAN)
> +static struct mcf_flexcan_platform_data mcf_flexcan_info = {
> +	.clk_src = 1,
> +	.clock_frequency = 120000000,
> +};
> +
> +static struct resource mcf_flexcan0_resource[] = {
> +	{
> +		.start = MCFFLEXCAN_BASE0,
> +		.end = MCFFLEXCAN_BASE0 + MCFFLEXCAN_SIZE,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
> +		.start = MCF_IRQ_IFL0,
> +		.end = MCF_IRQ_IFL0,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +	{
> +		.start = MCF_IRQ_BOFF0,
> +		.end = MCF_IRQ_BOFF0,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +	{
> +		.start = MCF_IRQ_ERR0,
> +		.end = MCF_IRQ_ERR0,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device mcf_flexcan0 = {
> +	.name = "flexcan-mcf",
> +	.id = 0,
> +	.num_resources = ARRAY_SIZE(mcf_flexcan0_resource),
> +	.resource = mcf_flexcan0_resource,
> +	.dev.platform_data = &mcf_flexcan_info,
> +};
> +#endif /* IS_ENABLED(CONFIG_CAN) */
> +
>   static struct platform_device *mcf_devices[] __initdata = {
>   	&mcf_uart,
>   #if IS_ENABLED(CONFIG_FEC)
> @@ -616,6 +655,9 @@ static struct platform_device *mcf_devices[] __initdata = {
>   #ifdef MCFSDHC_BASE
>   	&mcf_esdhc,
>   #endif
> +#if IS_ENABLED(CONFIG_CAN)
> +	&mcf_flexcan0,
> +#endif
>   };
>   
>   /*
> diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
> index 1e5259a652d1..18b152edb69c 100644
> --- a/arch/m68k/coldfire/m5441x.c
> +++ b/arch/m68k/coldfire/m5441x.c
> @@ -18,8 +18,8 @@
>   #include <asm/mcfclk.h>
>   
>   DEFINE_CLK(0, "flexbus", 2, MCF_CLK);
> -DEFINE_CLK(0, "mcfcan.0", 8, MCF_CLK);
> -DEFINE_CLK(0, "mcfcan.1", 9, MCF_CLK);
> +DEFINE_CLK(0, "flexcan.0", 8, MCF_CLK);
> +DEFINE_CLK(0, "flexcan.1", 9, MCF_CLK);
>   DEFINE_CLK(0, "imx1-i2c.1", 14, MCF_CLK);
>   DEFINE_CLK(0, "mcfdspi.1", 15, MCF_CLK);
>   DEFINE_CLK(0, "edma", 17, MCF_CLK);
> @@ -146,6 +146,8 @@ struct clk *mcf_clks[] = {
>   
>   static struct clk * const enable_clks[] __initconst = {
>   	/* make sure these clocks are enabled */
> +	&__clk_0_8, /* flexcan.0 */
> +	&__clk_0_9, /* flexcan.1 */
>   	&__clk_0_15, /* dspi.1 */
>   	&__clk_0_17, /* eDMA */
>   	&__clk_0_18, /* intc0 */
> @@ -166,8 +168,6 @@ static struct clk * const enable_clks[] __initconst = {
>   	&__clk_1_37, /* gpio */
>   };
>   static struct clk * const disable_clks[] __initconst = {
> -	&__clk_0_8, /* can.0 */
> -	&__clk_0_9, /* can.1 */
>   	&__clk_0_14, /* i2c.1 */
>   	&__clk_0_22, /* i2c.0 */
>   	&__clk_0_23, /* dspi.0 */
> diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
> index e091e36d3464..f48cf63bd782 100644
> --- a/arch/m68k/include/asm/m5441xsim.h
> +++ b/arch/m68k/include/asm/m5441xsim.h
> @@ -73,6 +73,12 @@
>   #define MCFINT0_FECENTC1	55
>   
>   /* on interrupt controller 1 */
> +#define MCFINT1_FLEXCAN0_IFL	0
> +#define MCFINT1_FLEXCAN0_BOFF	1
> +#define MCFINT1_FLEXCAN0_ERR	3
> +#define MCFINT1_FLEXCAN1_IFL	4
> +#define MCFINT1_FLEXCAN1_BOFF	5
> +#define MCFINT1_FLEXCAN1_ERR	7
>   #define MCFINT1_UART4		48
>   #define MCFINT1_UART5		49
>   #define MCFINT1_UART6		50
> @@ -314,4 +320,17 @@
>   #define MCF_IRQ_SDHC		(MCFINT2_VECBASE + MCFINT2_SDHC)
>   #define MCFSDHC_CLK		(MCFSDHC_BASE + 0x2c)
>   
> +/*
> + * Flexcan module
> + */
> +#define MCFFLEXCAN_BASE0	0xfc020000
> +#define MCFFLEXCAN_BASE1	0xfc024000
> +#define MCFFLEXCAN_SIZE		0x4000
> +#define MCF_IRQ_IFL0		(MCFINT1_VECBASE + MCFINT1_FLEXCAN0_IFL)
> +#define MCF_IRQ_BOFF0		(MCFINT1_VECBASE + MCFINT1_FLEXCAN0_BOFF)
> +#define MCF_IRQ_ERR0		(MCFINT1_VECBASE + MCFINT1_FLEXCAN0_ERR)
> +#define MCF_IRQ_IFL1		(MCFINT1_VECBASE + MCFINT1_FLEXCAN1_IFL)
> +#define MCF_IRQ_BOFF1		(MCFINT1_VECBASE + MCFINT1_FLEXCAN1_BOFF)
> +#define MCF_IRQ_ERR1		(MCFINT1_VECBASE + MCFINT1_FLEXCAN1_ERR)
> +
>   #endif /* m5441xsim_h */
> 
