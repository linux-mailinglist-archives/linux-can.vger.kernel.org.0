Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FFB3C4317
	for <lists+linux-can@lfdr.de>; Mon, 12 Jul 2021 06:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhGLEgf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 12 Jul 2021 00:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhGLEgf (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 12 Jul 2021 00:36:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AC4D61153;
        Mon, 12 Jul 2021 04:33:44 +0000 (UTC)
Subject: Re: [PATCH v5 3/5] m68k: m5441x: add flexcan support
To:     Angelo Dureghello <angelo@kernel-space.org>, wg@grandegger.com,
        mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
References: <20210702094841.327679-1-angelo@kernel-space.org>
 <20210702094841.327679-3-angelo@kernel-space.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <1a95b055-5d14-f43e-81dd-d0a0ddbdb1f1@linux-m68k.org>
Date:   Mon, 12 Jul 2021 14:33:42 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702094841.327679-3-angelo@kernel-space.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Angelo,

There is a couple of changes I would like to see here to make this
not depend on patch 1/5.


On 2/7/21 7:48 pm, Angelo Dureghello wrote:
> Add flexcan support.
> 
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> ---
> Changes for v2:
> - add irq resources for ERR and BOFF interrutps
> Changes for v3:
> - differentiate device name, for future variants addition
> Changes for v4:
> - change platform data structure name to flexcan_platform_data
> Changes for v5:
> none
> ---
>   arch/m68k/coldfire/device.c       | 42 +++++++++++++++++++++++++++++++
>   arch/m68k/coldfire/m5441x.c       |  8 +++---
>   arch/m68k/include/asm/m5441xsim.h | 19 ++++++++++++++
>   3 files changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
> index 59f7dfe50a4d..5f7effbf7c60 100644
> --- a/arch/m68k/coldfire/device.c
> +++ b/arch/m68k/coldfire/device.c
> @@ -23,6 +23,7 @@
>   #include <linux/platform_data/edma.h>
>   #include <linux/platform_data/dma-mcf-edma.h>
>   #include <linux/platform_data/mmc-esdhc-mcf.h>
> +#include <linux/can/platform/flexcan.h>

Move this to inside the CONFIG_CAN block.

>   
>   /*
>    *	All current ColdFire parts contain from 2, 3, 4 or 10 UARTS.
> @@ -581,6 +582,44 @@ static struct platform_device mcf_esdhc = {
>   };
>   #endif /* MCFSDHC_BASE */
>   
> +#if IS_ENABLED(CONFIG_CAN)

Change this to IS_ENABLED(CONFIG_CAN_FLEXCAN).

All the other device resource blocks in this file depend on the
actual driver being enabled that they apply to. Not the general subsystem
(in this case CAN).

That way the timing of patches 1, 4 and 5 being applied doesn't matter.
There is no way to enable CONFIG_CAN_FLEXCAN until patch 4 is applied.
(And you probably should have swapped the order of patches 4 and 5, so that
the Kconfig change is the last in the series.)

Regards
Greg



> +static struct flexcan_platform_data mcf5441x_flexcan_info = {
> +	.clk_src = 1,
> +	.clock_frequency = 120000000,
> +};
> +
> +static struct resource mcf5441x_flexcan0_resource[] = {
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
> +	.name = "flexcan-mcf5441x",
> +	.id = 0,
> +	.num_resources = ARRAY_SIZE(mcf5441x_flexcan0_resource),
> +	.resource = mcf5441x_flexcan0_resource,
> +	.dev.platform_data = &mcf5441x_flexcan_info,
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
