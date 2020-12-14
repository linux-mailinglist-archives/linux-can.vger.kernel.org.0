Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1592D93DD
	for <lists+linux-can@lfdr.de>; Mon, 14 Dec 2020 09:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439050AbgLNIOG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Dec 2020 03:14:06 -0500
Received: from first.geanix.com ([116.203.34.67]:57830 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388775AbgLNIOD (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 14 Dec 2020 03:14:03 -0500
Received: from [IPv6:2a06:4004:10df:1:da27:a6d2:5305:fd0a] (_gateway [172.21.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id B068B480B23;
        Mon, 14 Dec 2020 08:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1607933599; bh=c956TMwJlOsUMMrSdajhfBqk1QVz6i8FTdtnxPzydnI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=As7o7kmL7iGitX/0b2bXAMuiEi6cjOssWxq3s6aIIUvy2i039fO1Fy5vJr3HWk4Cm
         GEsabern/+htY4edftwweuVkcVVm/9zWMWuwxe8fEQtxViyVpP64NCjcc00IFvNKGF
         /xi2RP/xCU4LWXEhFYX/JI8A56bKjl8eUPEuok6aOQdEY2bNMDyT/oMDcPwn3JUbwS
         qxFEJjvrPYJdlxgOL1qXVOCTx1UtGcnAqAo6mikkaOnW2EYvKhLCBtQPi44ETmB9ap
         EOC9ZpM5xnrA/KEpbGUJdzsdXRvduhX0INf/tChCmO3NIKkbZim7F6XILdJYDH6nX8
         akWb9VhoIeEgQ==
Subject: Re: [can-next-rfc 6/7] can: m_can: let m_can_class_allocate_dev()
 allocate driver specific private data
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>
References: <20201212175518.139651-1-mkl@pengutronix.de>
 <20201212175518.139651-7-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <9274ce71-33e4-a3c2-2d18-124793210ad8@geanix.com>
Date:   Mon, 14 Dec 2020 09:13:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201212175518.139651-7-mkl@pengutronix.de>
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
> This patch enhances m_can_class_allocate_dev() to allocate driver specific
> private data. The driver's private data struct must contain struct
> m_can_classdev as its first member followed by the remaining private data.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/m_can/m_can.c          |  5 +--
>   drivers/net/can/m_can/m_can.h          |  4 +--
>   drivers/net/can/m_can/m_can_pci.c      | 27 +++++++++-------
>   drivers/net/can/m_can/m_can_platform.c | 26 ++++++++-------
>   drivers/net/can/m_can/tcan4x5x.c       | 44 +++++++++++++-------------
>   5 files changed, 56 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index d556cd95bd8e..46b23fd33f4a 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1759,7 +1759,8 @@ int m_can_class_get_clocks(struct m_can_classdev *cdev)
>   }
>   EXPORT_SYMBOL_GPL(m_can_class_get_clocks);
>   
> -struct m_can_classdev *m_can_class_allocate_dev(struct device *dev)
> +struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
> +						int sizeof_priv)
>   {
>   	struct m_can_classdev *class_dev = NULL;
>   	u32 mram_config_vals[MRAM_CFG_LEN];
> @@ -1782,7 +1783,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev)
>   	tx_fifo_size = mram_config_vals[7];
>   
>   	/* allocate the m_can device */
> -	net_dev = alloc_candev(sizeof(*class_dev), tx_fifo_size);
> +	net_dev = alloc_candev(sizeof_priv, tx_fifo_size);
>   	if (!net_dev) {
>   		dev_err(dev, "Failed to allocate CAN device");
>   		goto out;
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index 3994e20249f8..3fda84cef351 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -86,8 +86,6 @@ struct m_can_classdev {
>   
>   	struct m_can_ops *ops;
>   
> -	void *device_data;
> -
>   	int version;
>   	u32 irqstatus;
>   
> @@ -97,7 +95,7 @@ struct m_can_classdev {
>   	struct mram_cfg mcfg[MRAM_CFG_NUM];
>   };
>   
> -struct m_can_classdev *m_can_class_allocate_dev(struct device *dev);
> +struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);
>   void m_can_class_free_dev(struct net_device *net);
>   int m_can_class_register(struct m_can_classdev *cdev);
>   void m_can_class_unregister(struct m_can_classdev *cdev);
> diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
> index 04010ee0407c..ebfbef25e3f9 100644
> --- a/drivers/net/can/m_can/m_can_pci.c
> +++ b/drivers/net/can/m_can/m_can_pci.c
> @@ -22,26 +22,33 @@
>   #define CTL_CSR_INT_CTL_OFFSET		0x508
>   
>   struct m_can_pci_priv {
> +	struct m_can_classdev cdev;
> +
>   	void __iomem *base;
>   };
>   
> +static inline struct m_can_pci_priv *cdev_to_priv(struct m_can_classdev *cdev)
> +{
> +	return container_of(cdev, struct m_can_pci_priv, cdev);
> +}
> +
>   static u32 iomap_read_reg(struct m_can_classdev *cdev, int reg)
>   {
> -	struct m_can_pci_priv *priv = cdev->device_data;
> +	struct m_can_pci_priv *priv = cdev_to_priv(cdev);
>   
>   	return readl(priv->base + reg);
>   }
>   
>   static u32 iomap_read_fifo(struct m_can_classdev *cdev, int offset)
>   {
> -	struct m_can_pci_priv *priv = cdev->device_data;
> +	struct m_can_pci_priv *priv = cdev_to_priv(cdev);
>   
>   	return readl(priv->base + offset);
>   }
>   
>   static int iomap_write_reg(struct m_can_classdev *cdev, int reg, int val)
>   {
> -	struct m_can_pci_priv *priv = cdev->device_data;
> +	struct m_can_pci_priv *priv = cdev_to_priv(cdev);
>   
>   	writel(val, priv->base + reg);
>   
> @@ -50,7 +57,7 @@ static int iomap_write_reg(struct m_can_classdev *cdev, int reg, int val)
>   
>   static int iomap_write_fifo(struct m_can_classdev *cdev, int offset, int val)
>   {
> -	struct m_can_pci_priv *priv = cdev->device_data;
> +	struct m_can_pci_priv *priv = cdev_to_priv(cdev);
>   
>   	writel(val, priv->base + offset);
>   
> @@ -89,21 +96,19 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>   		return -ENOMEM;
>   	}
>   
> -	priv = devm_kzalloc(&pci->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> -
> -	mcan_class = m_can_class_allocate_dev(&pci->dev);
> +	mcan_class = m_can_class_allocate_dev(&pci->dev,
> +					      sizeof(struct m_can_pci_priv));
>   	if (!mcan_class)
>   		return -ENOMEM;
>   
> +	priv = cdev_to_priv(mcan_class);
> +
>   	priv->base = base;
>   
>   	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_ALL_TYPES);
>   	if (ret < 0)
>   		return ret;
>   
> -	mcan_class->device_data = priv;
>   	mcan_class->dev = &pci->dev;
>   	mcan_class->net->irq = pci_irq_vector(pci, 0);
>   	mcan_class->pm_clock_support = 1;
> @@ -135,7 +140,7 @@ static void m_can_pci_remove(struct pci_dev *pci)
>   {
>   	struct net_device *dev = pci_get_drvdata(pci);
>   	struct m_can_classdev *mcan_class = netdev_priv(dev);
> -	struct m_can_pci_priv *priv = mcan_class->device_data;
> +	struct m_can_pci_priv *priv = cdev_to_priv(mcan_class);
>   
>   	pm_runtime_forbid(&pci->dev);
>   	pm_runtime_get_noresume(&pci->dev);
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
> index 36ef791da388..5758d25e42c8 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -10,27 +10,34 @@
>   #include "m_can.h"
>   
>   struct m_can_plat_priv {
> +	struct m_can_classdev cdev;
> +
>   	void __iomem *base;
>   	void __iomem *mram_base;
>   };
>   
> +static inline struct m_can_plat_priv *cdev_to_priv(struct m_can_classdev *cdev)
> +{
> +	return container_of(cdev, struct m_can_plat_priv, cdev);
> +}
> +
>   static u32 iomap_read_reg(struct m_can_classdev *cdev, int reg)
>   {
> -	struct m_can_plat_priv *priv = cdev->device_data;
> +	struct m_can_plat_priv *priv = cdev_to_priv(cdev);
>   
>   	return readl(priv->base + reg);
>   }
>   
>   static u32 iomap_read_fifo(struct m_can_classdev *cdev, int offset)
>   {
> -	struct m_can_plat_priv *priv = cdev->device_data;
> +	struct m_can_plat_priv *priv = cdev_to_priv(cdev);
>   
>   	return readl(priv->mram_base + offset);
>   }
>   
>   static int iomap_write_reg(struct m_can_classdev *cdev, int reg, int val)
>   {
> -	struct m_can_plat_priv *priv = cdev->device_data;
> +	struct m_can_plat_priv *priv = cdev_to_priv(cdev);
>   
>   	writel(val, priv->base + reg);
>   
> @@ -39,7 +46,7 @@ static int iomap_write_reg(struct m_can_classdev *cdev, int reg, int val)
>   
>   static int iomap_write_fifo(struct m_can_classdev *cdev, int offset, int val)
>   {
> -	struct m_can_plat_priv *priv = cdev->device_data;
> +	struct m_can_plat_priv *priv = cdev_to_priv(cdev);
>   
>   	writel(val, priv->mram_base + offset);
>   
> @@ -62,17 +69,12 @@ static int m_can_plat_probe(struct platform_device *pdev)
>   	void __iomem *mram_addr;
>   	int irq, ret = 0;
>   
> -	mcan_class = m_can_class_allocate_dev(&pdev->dev);
> +	mcan_class = m_can_class_allocate_dev(&pdev->dev,
> +					      sizeof(struct m_can_plat_priv));
>   	if (!mcan_class)
>   		return -ENOMEM;
>   
> -	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv) {
> -		ret = -ENOMEM;
> -		goto probe_fail;
> -	}
> -
> -	mcan_class->device_data = priv;
> +	priv = cdev_to_priv(mcan_class);
>   
>   	ret = m_can_class_get_clocks(mcan_class);
>   	if (ret)
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index a0fecc3fb829..24c737c4fc44 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -114,17 +114,23 @@
>   #define TCAN4X5X_WD_6_S_TIMER (BIT(28) | BIT(29))
>   
>   struct tcan4x5x_priv {
> +	struct m_can_classdev cdev;
> +
>   	struct regmap *regmap;
>   	struct spi_device *spi;
>   
> -	struct m_can_classdev *mcan_dev;
> -
>   	struct gpio_desc *reset_gpio;
>   	struct gpio_desc *device_wake_gpio;
>   	struct gpio_desc *device_state_gpio;
>   	struct regulator *power;
>   };
>   
> +static inline struct tcan4x5x_priv *cdev_to_priv(struct m_can_classdev *cdev)
> +{
> +	return container_of(cdev, struct tcan4x5x_priv, cdev);
> +
> +}
> +
>   static struct can_bittiming_const tcan4x5x_bittiming_const = {
>   	.name = DEVICE_NAME,
>   	.tseg1_min = 2,
> @@ -253,7 +259,7 @@ static struct regmap_bus tcan4x5x_bus = {
>   
>   static u32 tcan4x5x_read_reg(struct m_can_classdev *cdev, int reg)
>   {
> -	struct tcan4x5x_priv *priv = cdev->device_data;
> +	struct tcan4x5x_priv *priv = cdev_to_priv(cdev);
>   	u32 val;
>   
>   	regmap_read(priv->regmap, TCAN4X5X_MCAN_OFFSET + reg, &val);
> @@ -263,7 +269,7 @@ static u32 tcan4x5x_read_reg(struct m_can_classdev *cdev, int reg)
>   
>   static u32 tcan4x5x_read_fifo(struct m_can_classdev *cdev, int addr_offset)
>   {
> -	struct tcan4x5x_priv *priv = cdev->device_data;
> +	struct tcan4x5x_priv *priv = cdev_to_priv(cdev);
>   	u32 val;
>   
>   	regmap_read(priv->regmap, TCAN4X5X_MRAM_START + addr_offset, &val);
> @@ -273,7 +279,7 @@ static u32 tcan4x5x_read_fifo(struct m_can_classdev *cdev, int addr_offset)
>   
>   static int tcan4x5x_write_reg(struct m_can_classdev *cdev, int reg, int val)
>   {
> -	struct tcan4x5x_priv *priv = cdev->device_data;
> +	struct tcan4x5x_priv *priv = cdev_to_priv(cdev);
>   
>   	return regmap_write(priv->regmap, TCAN4X5X_MCAN_OFFSET + reg, val);
>   }
> @@ -281,7 +287,7 @@ static int tcan4x5x_write_reg(struct m_can_classdev *cdev, int reg, int val)
>   static int tcan4x5x_write_fifo(struct m_can_classdev *cdev,
>   			       int addr_offset, int val)
>   {
> -	struct tcan4x5x_priv *priv = cdev->device_data;
> +	struct tcan4x5x_priv *priv = cdev_to_priv(cdev);
>   
>   	return regmap_write(priv->regmap, TCAN4X5X_MRAM_START + addr_offset, val);
>   }
> @@ -300,7 +306,7 @@ static int tcan4x5x_power_enable(struct regulator *reg, int enable)
>   static int tcan4x5x_write_tcan_reg(struct m_can_classdev *cdev,
>   				   int reg, int val)
>   {
> -	struct tcan4x5x_priv *priv = cdev->device_data;
> +	struct tcan4x5x_priv *priv = cdev_to_priv(cdev);
>   
>   	return regmap_write(priv->regmap, reg, val);
>   }
> @@ -330,7 +336,7 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
>   
>   static int tcan4x5x_init(struct m_can_classdev *cdev)
>   {
> -	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
> +	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
>   	int ret;
>   
>   	tcan4x5x_check_wake(tcan4x5x);
> @@ -357,7 +363,7 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
>   
>   static int tcan4x5x_disable_wake(struct m_can_classdev *cdev)
>   {
> -	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
> +	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
>   
>   	return regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
>   				  TCAN4X5X_DISABLE_WAKE_MSK, 0x00);
> @@ -365,7 +371,7 @@ static int tcan4x5x_disable_wake(struct m_can_classdev *cdev)
>   
>   static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
>   {
> -	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
> +	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
>   
>   	return regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
>   				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
> @@ -373,7 +379,7 @@ static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
>   
>   static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
>   {
> -	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
> +	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
>   	int ret;
>   
>   	tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
> @@ -427,15 +433,12 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>   	struct m_can_classdev *mcan_class;
>   	int freq, ret;
>   
> -	mcan_class = m_can_class_allocate_dev(&spi->dev);
> +	mcan_class = m_can_class_allocate_dev(&spi->dev,
> +					      sizeof(struct tcan4x5x_priv));
>   	if (!mcan_class)
>   		return -ENOMEM;
>   
> -	priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv) {
> -		ret = -ENOMEM;
> -		goto out_m_can_class_free_dev;
> -	}
> +	priv = cdev_to_priv(mcan_class);
>   
>   	priv->power = devm_regulator_get_optional(&spi->dev, "vsup");
>   	if (PTR_ERR(priv->power) == -EPROBE_DEFER) {
> @@ -445,8 +448,6 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>   		priv->power = NULL;
>   	}
>   
> -	mcan_class->device_data = priv;
> -
>   	m_can_class_get_clocks(mcan_class);
>   	if (IS_ERR(mcan_class->cclk)) {
>   		dev_err(&spi->dev, "no CAN clock source defined\n");
> @@ -462,7 +463,6 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>   	}
>   
>   	priv->spi = spi;
> -	priv->mcan_dev = mcan_class;
>   
>   	mcan_class->pm_clock_support = 0;
>   	mcan_class->can.clock.freq = freq;
> @@ -518,11 +518,11 @@ static int tcan4x5x_can_remove(struct spi_device *spi)
>   {
>   	struct tcan4x5x_priv *priv = spi_get_drvdata(spi);
>   
> -	m_can_class_unregister(priv->mcan_dev);
> +	m_can_class_unregister(&priv->cdev);
>   
>   	tcan4x5x_power_enable(priv->power, 0);
>   
> -	m_can_class_free_dev(priv->mcan_dev->net);
> +	m_can_class_free_dev(priv->cdev.net);
>   
>   	return 0;
>   }

