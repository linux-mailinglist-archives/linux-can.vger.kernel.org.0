Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A547148B209
	for <lists+linux-can@lfdr.de>; Tue, 11 Jan 2022 17:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbiAKQYa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jan 2022 11:24:30 -0500
Received: from foss.arm.com ([217.140.110.172]:49066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241083AbiAKQY1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 11 Jan 2022 11:24:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 879AD6D;
        Tue, 11 Jan 2022 08:24:26 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F31BB3F774;
        Tue, 11 Jan 2022 08:24:24 -0800 (PST)
Date:   Tue, 11 Jan 2022 16:24:22 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-can@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: Re: [PATCH v2 2/3] can: sun4i_can: add support for R40 CAN
 controller
Message-ID: <20220111162422.62d0ceb0@donnerap.cambridge.arm.com>
In-Reply-To: <20220111155709.56501-3-boger@wirenboard.com>
References: <20220111155709.56501-1-boger@wirenboard.com>
        <20220111155709.56501-3-boger@wirenboard.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 11 Jan 2022 18:57:08 +0300
Evgeny Boger <boger@wirenboard.com> wrote:

Hi,

> Allwinner R40 (also known as A40i, T3, V40) has a CAN controller. The
> controller is the same as in earlier A10 and A20 SoCs, but needs reset
> line to be deasserted before use.
> 
> This patch adds a new compatible for R40 CAN controller. Depending
> on the compatible, reset line can be requested from DT.
> 
> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
> ---
>  drivers/net/can/sun4i_can.c | 61 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
> index 54aa7c25c4de..24a61326915e 100644
> --- a/drivers/net/can/sun4i_can.c
> +++ b/drivers/net/can/sun4i_can.c
> @@ -61,6 +61,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  
>  #define DRV_NAME "sun4i_can"
>  
> @@ -200,10 +201,20 @@
>  #define SUN4I_CAN_MAX_IRQ	20
>  #define SUN4I_MODE_MAX_RETRIES	100
>  
> +/**
> + * struct sun4ican_quirks - Differences between SoC variants.
> + *
> + * @has_reset: SoC needs reset deasserted.
> + */
> +struct sun4ican_quirks {
> +	bool		has_reset;
> +};
> +
>  struct sun4ican_priv {
>  	struct can_priv can;
>  	void __iomem *base;
>  	struct clk *clk;
> +	struct reset_control *reset;
>  	spinlock_t cmdreg_lock;	/* lock for concurrent cmd register writes */
>  };
>  
> @@ -702,6 +713,13 @@ static int sun4ican_open(struct net_device *dev)
>  		goto exit_irq;
>  	}
>  
> +	/* software reset deassert */
> +	err = reset_control_deassert(priv->reset);
> +	if (err) {
> +		netdev_err(dev, "could not deassert CAN reset\n");
> +		goto exit_soft_reset;
> +	}
> +
>  	/* turn on clocking for CAN peripheral block */
>  	err = clk_prepare_enable(priv->clk);
>  	if (err) {
> @@ -723,6 +741,8 @@ static int sun4ican_open(struct net_device *dev)
>  exit_can_start:
>  	clk_disable_unprepare(priv->clk);
>  exit_clock:
> +	reset_control_assert(priv->reset);
> +exit_soft_reset:
>  	free_irq(dev->irq, dev);
>  exit_irq:
>  	close_candev(dev);
> @@ -736,6 +756,7 @@ static int sun4ican_close(struct net_device *dev)
>  	netif_stop_queue(dev);
>  	sun4i_can_stop(dev);
>  	clk_disable_unprepare(priv->clk);
> +	reset_control_assert(priv->reset);
>  
>  	free_irq(dev->irq, dev);
>  	close_candev(dev);
> @@ -750,8 +771,27 @@ static const struct net_device_ops sun4ican_netdev_ops = {
>  	.ndo_start_xmit = sun4ican_start_xmit,
>  };
>  
> +static const struct sun4ican_quirks sun4ican_quirks_a10 = {
> +	.has_reset = false,
> +};
> +
> +static const struct sun4ican_quirks sun4ican_quirks_r40 = {
> +	.has_reset = true,
> +};
> +
>  static const struct of_device_id sun4ican_of_match[] = {
> -	{.compatible = "allwinner,sun4i-a10-can"},
> +	{
> +		.compatible = "allwinner,sun4i-a10-can",
> +		.data = &sun4ican_quirks_a10
> +	},
> +	{
> +		.compatible = "allwinner,sun7i-a20-can",
> +		.data = &sun4ican_quirks_a10
> +	},

This one looks unnecessary, the binding says that it must be paired with
the A10 fallback.
We should only add an A20 compatible match if there is really a reason,
otherwise it encourages people to produce DTs with *only* the A20
compatible (violating the binding).

Cheers,
Andre

> +	{
> +		.compatible = "allwinner,sun8i-r40-can",
> +		.data = &sun4ican_quirks_r40
> +	},
>  	{},
>  };
>  
> @@ -771,10 +811,28 @@ static int sun4ican_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	struct clk *clk;
> +	struct reset_control *reset = NULL;
>  	void __iomem *addr;
>  	int err, irq;
>  	struct net_device *dev;
>  	struct sun4ican_priv *priv;
> +	const struct sun4ican_quirks *quirks;
> +
> +	quirks = of_device_get_match_data(&pdev->dev);
> +	if (!quirks) {
> +		dev_err(&pdev->dev, "failed to determine the quirks to use\n");
> +		err = -ENODEV;
> +		goto exit;
> +	}
> +
> +	if (quirks->has_reset) {
> +		reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +		if (IS_ERR(reset)) {
> +			dev_err(&pdev->dev, "unable to request reset\n");
> +			err = PTR_ERR(reset);
> +			goto exit;
> +		}
> +	}
>  
>  	clk = of_clk_get(np, 0);
>  	if (IS_ERR(clk)) {
> @@ -818,6 +876,7 @@ static int sun4ican_probe(struct platform_device *pdev)
>  				       CAN_CTRLMODE_3_SAMPLES;
>  	priv->base = addr;
>  	priv->clk = clk;
> +	priv->reset = reset;
>  	spin_lock_init(&priv->cmdreg_lock);
>  
>  	platform_set_drvdata(pdev, dev);

