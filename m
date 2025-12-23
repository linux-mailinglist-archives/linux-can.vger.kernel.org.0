Return-Path: <linux-can+bounces-5925-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E041CDA9C2
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 21:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E2723001BE5
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 20:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D37A30CDBB;
	Tue, 23 Dec 2025 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi35QThL"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2256B3090F1;
	Tue, 23 Dec 2025 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766523099; cv=none; b=HLekCulhsdVHFp2ApJjkRYjQe3KhFTDMk3dbuSQBfcRXtMEU235smp1b7iXep6pDkb3jMEeFgWw4P/hu7j0Jh891mDXClDNE96+e1RJQtYw+sCmULOJAQizgDx9gFAwH4nOEiKZyUwWsVPGirbrTaetKKf9fL8G794o9mbZ/6PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766523099; c=relaxed/simple;
	bh=ut3Y81owlcMVeBsbds3zy7YlP2sz3AG02+WxIthW+iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOMFmaVTBLKtgTOJP05HFo2JoN8HuqQZG3rI4NL5ZcA4XM4vxuJ1XZRNW6iJoDLCgvD5kT8bFwsq9s7Sod5GDBac8PyFhoOf9atdez9HcEp9p7O0jBTWSb4IFdorzdBbELQbSi8hkvuPQ6Q6kMECOCtd55fH+xa2rjRMSgArZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi35QThL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEC8C113D0;
	Tue, 23 Dec 2025 20:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766523098;
	bh=ut3Y81owlcMVeBsbds3zy7YlP2sz3AG02+WxIthW+iE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mi35QThLeIFq9FA4PSmOploK5UEx+bOMAbIGidx2H+kzoNIHEsBU+jOgDp1QrNlKw
	 hJ0IeHVP8MS7njO2vG4av280IhmWaiWEpCN5sjPGZq+kiWxAQ31ACFBCfFKEmP8O0+
	 oqR/BEWw6sG+fOoS+BrKkhiSkLs9JjejMEYUMpPeJr0SxJMppTUwUXwDmr/qz7xf+N
	 dmzeLPgJusFYVP61u02lhdh5FMV22bZo1TRRLCICxpjF0GXzzVHe4vah3DZCOduClW
	 dtrp9iHvLrhJJ8dZFcn1YhSv/756n4Oj80LQxXv4jALKPk349DJuvCGzJNJJtN6BDs
	 BZt/0axuIbn8A==
Message-ID: <0b15288b-7473-4969-aa58-11f131e47773@kernel.org>
Date: Tue, 23 Dec 2025 21:51:33 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] can: grcan: add FD capability detection and
 nominal bit-timing
To: Arun Muthusamy <arun.muthusamy@gaisler.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mkl@pengutronix.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, Daniel Hellstrom <daniel@gaisler.com>
References: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
 <20251223105604.12675-6-arun.muthusamy@gaisler.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20251223105604.12675-6-arun.muthusamy@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/12/2025 at 11:55, Arun Muthusamy wrote:
> From: Daniel Hellstrom <daniel@gaisler.com>
> 
> Add capability for the driver to detect CAN FD support
> and adjust accordingly. Introduce structures and functions
> for setting nominal bit-timing for standard CAN and CAN FD.
> The `grcan_hwcap` structure defines hardware capabilities like
> CAN FD support and baud-rate options. Additionally, improved
> device tree compatibility by updating the `of_device_id` table
> for better matching of GRCAN and GRCANFD devices. Also update
> Kconfig to mention GRCANFD support.

Your patch is doing a lot of things. Can you split it in smaller
changes? More specifically try to not mix together the refactors
with the introduction of new code.

> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> ---
>  drivers/net/can/Kconfig |   6 +-
>  drivers/net/can/grcan.c | 208 ++++++++++++++++++++++++++++------------
>  2 files changed, 151 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index d43d56694667..816b6e71a990 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -133,10 +133,12 @@ config CAN_FLEXCAN
>  	  Say Y here if you want to support for Freescale FlexCAN.
>  
>  config CAN_GRCAN
> -	tristate "Aeroflex Gaisler GRCAN and GRHCAN CAN devices"
> +	tristate "Aeroflex Gaisler GRCAN, GRCANFD and GRHCAN CAN devices"

Nitpick: try a more compact approach:

  tristate "Aeroflex Gaisler GRCAN(FD) and GRHCAN devices"

>  	depends on OF && HAS_DMA && HAS_IOMEM
>  	help
> -	  Say Y here if you want to use Aeroflex Gaisler GRCAN or GRHCAN.
> +	  Say Y here if you want to use Aeroflex Gaisler GRCAN or GRCANFD
> +	  or GRHCAN.
> +

OK to be more verbose here ;)

>  	  Note that the driver supports little endian, even though little
>  	  endian syntheses of the cores would need some modifications on
>  	  the hardware level to work.
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index 538a9b4f82ab..cac85fbe6acf 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -33,9 +33,11 @@
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_irq.h>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/bitfield.h>
>  
>  #define DRV_NAME	"grcan"
>  
> @@ -50,7 +52,11 @@ struct grcan_registers {
>  	u32 __reserved1[GRCAN_RESERVE_SIZE(0x08, 0x18)];
>  	u32 smask;	/* 0x18 - CanMASK */
>  	u32 scode;	/* 0x1c - CanCODE */
> -	u32 __reserved2[GRCAN_RESERVE_SIZE(0x1c, 0x100)];
> +	u32 __reserved2[GRCAN_RESERVE_SIZE(0x1c, 0x40)];
> +	u32 nbtr;	/* 0x40 */
> +	u32 fdbtr;	/* 0x44 */
> +	u32 tdelay;	/* 0x48 */
> +	u32 __reserved2_[GRCAN_RESERVE_SIZE(0x48, 0x100)];
>  	u32 pimsr;	/* 0x100 */
>  	u32 pimr;	/* 0x104 */
>  	u32 pisr;	/* 0x108 */
> @@ -93,16 +99,6 @@ struct grcan_registers {
>  	(GRCAN_CONF_BPR | GRCAN_CONF_RSJ | GRCAN_CONF_PS1		\
>  	 | GRCAN_CONF_PS2 | GRCAN_CONF_SCALER)
>  
> -#define GRCAN_CONF_RSJ_MIN	1
> -#define GRCAN_CONF_RSJ_MAX	4
> -#define GRCAN_CONF_PS1_MIN	1
> -#define GRCAN_CONF_PS1_MAX	15
> -#define GRCAN_CONF_PS2_MIN	2
> -#define GRCAN_CONF_PS2_MAX	8
> -#define GRCAN_CONF_SCALER_MIN	0
> -#define GRCAN_CONF_SCALER_MAX	255
> -#define GRCAN_CONF_SCALER_INC	1
> -
>  #define GRCAN_CONF_BPR_BIT	8
>  #define GRCAN_CONF_RSJ_BIT	12
>  #define GRCAN_CONF_PS1_BIT	20
> @@ -212,6 +208,39 @@ struct grcan_registers {
>  #error "Invalid default buffer size"
>  #endif
>  
> +#define GRCANFD_NBTR_SCALER     GENMASK(23, 16)
> +#define GRCANFD_NBTR_PS1        GENMASK(17, 10)
> +#define GRCANFD_NBTR_PS2        GENMASK(9, 5)
> +#define GRCANFD_NBTR_SJW        GENMASK(4, 0)
> +#define GRCANFD_NBTR_TIMING						\
> +	(GRCANFD_NBTR_SCALER | GRCANFD_NBTR_PS1 | GRCANFD_NBTR_PS2 |	\
> +	 GRCANFD_NBTR_SJW)
> +
> +#define GRCANFD_FDBTR_SCALER 0x00ff0000
> +#define GRCANFD_FDBTR_PS1 0x00003c00
> +#define GRCANFD_FDBTR_PS2 0x000001e0
> +#define GRCANFD_FDBTR_SJW 0x0000000f
> +#define GRCANFD_FDBTR_TIMING						\
> +	(GRCANFD_FDBTR_SCALER | GRCANFD_FDBTR_PS1 | GRCANFD_FDBTR_PS2 |	\
> +	 GRCANFD_FDBTR_SJW)
> +
> +#define GRCANFD_FDBTR_SCALER_BIT 16
> +#define GRCANFD_FDBTR_PS1_BIT 10
> +#define GRCANFD_FDBTR_PS2_BIT 5
> +#define GRCANFD_FDBTR_SJW_BIT 0
> +
> +/* Hardware capabilities */
> +struct grcan_hwcap {
> +	/* CAN-FD capable, indicates GRCANFD IP.
> +	 * The GRCANFD has different baud-rate registers and extended DMA
> +	 * format to also describe FD-frames.
> +	 */
> +	const struct can_bittiming_const *bt_const;
> +	int (*set_bittiming)(struct net_device *dev);
> +	bool txbug_possible;
> +	bool fd;
> +};
> +
>  struct grcan_dma_buffer {
>  	size_t size;
>  	void *buf;
> @@ -254,6 +283,7 @@ struct grcan_priv {
>  	struct napi_struct napi;
>  
>  	struct grcan_registers __iomem *regs;	/* ioremap'ed registers */
> +	const struct grcan_hwcap *hwcap;
>  	struct grcan_device_config config;
>  	struct grcan_dma dma;
>  
> @@ -304,6 +334,7 @@ struct grcan_priv {
>  	 */
>  	bool resetting;
>  	bool closing;
> +
>  };
>  
>  /* Wait time for a short wait for ongoing to clear */
> @@ -392,55 +423,79 @@ static struct grcan_device_config grcan_module_config =
>  
>  static const struct can_bittiming_const grcan_bittiming_const = {
>  	.name		= DRV_NAME,
> -	.tseg1_min	= GRCAN_CONF_PS1_MIN + 1,
> -	.tseg1_max	= GRCAN_CONF_PS1_MAX + 1,
> -	.tseg2_min	= GRCAN_CONF_PS2_MIN,
> -	.tseg2_max	= GRCAN_CONF_PS2_MAX,
> -	.sjw_max	= GRCAN_CONF_RSJ_MAX,
> -	.brp_min	= GRCAN_CONF_SCALER_MIN + 1,
> -	.brp_max	= GRCAN_CONF_SCALER_MAX + 1,
> -	.brp_inc	= GRCAN_CONF_SCALER_INC,
> +	.tseg1_min	= 2,
> +	.tseg1_max	= 16,
> +	.tseg2_min	= 2,
> +	.tseg2_max	= 8,
> +	.sjw_max	= 4,
> +	.brp_min	= 1,
> +	.brp_max	= 256,
> +	.brp_inc	= 1,

For example, removing those macros and replacing them by literal
values is not related to adding FD capabilities.

This should go to a preparation clean-up patch.

> +};
> +
> +/* GRCANFD nominal boundaries for baud-rate parameters */
> +static const struct can_bittiming_const grcanfd_bittiming_const = {
> +	.name		= DRV_NAME,
> +	.tseg1_min	= 2,
> +	.tseg1_max	= 63,
> +	.tseg2_min	= 2,
> +	.tseg2_max	= 16,
> +	.sjw_max	= 16,
> +	.brp_min	= 1,
> +	.brp_max	= 256,
> +	.brp_inc	= 1,
>  };
>  
>  static int grcan_set_bittiming(struct net_device *dev)
>  {
>  	struct grcan_priv *priv = netdev_priv(dev);
> -	struct grcan_registers __iomem *regs = priv->regs;
> -	struct can_bittiming *bt = &priv->can.bittiming;
> -	u32 timing = 0;
> +	struct grcan_registers __iomem *regs;
>  	int bpr, rsj, ps1, ps2, scaler;
> +	struct can_bittiming *bt;
> +	u32 timing = 0;
>  
> -	/* Should never happen - function will not be called when
> -	 * device is up
> -	 */
> -	if (grcan_read_bits(&regs->ctrl, GRCAN_CTRL_ENABLE))
> -		return -EBUSY;
> +	regs = priv->regs;
> +	bt = &priv->can.bittiming;
>  
>  	bpr = 0; /* Note bpr and brp are different concepts */
>  	rsj = bt->sjw;
>  	ps1 = (bt->prop_seg + bt->phase_seg1) - 1; /* tseg1 - 1 */
>  	ps2 = bt->phase_seg2;
> -	scaler = (bt->brp - 1);
> -	netdev_dbg(dev, "Request for BPR=%d, RSJ=%d, PS1=%d, PS2=%d, SCALER=%d",
> -		   bpr, rsj, ps1, ps2, scaler);
> -	if (!(ps1 > ps2)) {
> -		netdev_err(dev, "PS1 > PS2 must hold: PS1=%d, PS2=%d\n",
> -			   ps1, ps2);
> -		return -EINVAL;
> -	}
> -	if (!(ps2 >= rsj)) {
> -		netdev_err(dev, "PS2 >= RSJ must hold: PS2=%d, RSJ=%d\n",
> -			   ps2, rsj);
> -		return -EINVAL;
> -	}
> +	scaler = bt->brp - 1;
> +
> +	timing |= FIELD_PREP(GRCAN_CONF_BPR, bpr);
> +	timing |= FIELD_PREP(GRCAN_CONF_RSJ, rsj);
> +	timing |= FIELD_PREP(GRCAN_CONF_PS1, ps1);
> +	timing |= FIELD_PREP(GRCAN_CONF_PS2, ps2);
> +	timing |= FIELD_PREP(GRCAN_CONF_SCALER, scaler);
> +	netdev_dbg(dev, "setting timing=0x%x\n", timing);
> +	grcan_write_bits(&regs->conf, timing, GRCAN_CONF_TIMING);
> +
> +	return 0;
> +}
> +
> +static int grcanfd_set_bittiming(struct net_device *dev)
> +{
> +	struct grcan_priv *priv = netdev_priv(dev);
> +	struct grcan_registers __iomem *regs;
> +	int sjw, ps1, ps2, scaler;
> +	struct can_bittiming *bt;
> +	u32 timing = 0;
> +
> +	regs = priv->regs;
> +	bt = &priv->can.bittiming;
> +
> +	sjw = bt->sjw;
> +	ps1 = (bt->prop_seg + bt->phase_seg1);
> +	ps2 = bt->phase_seg2;
> +	scaler = bt->brp - 1;
>  
> -	timing |= (bpr << GRCAN_CONF_BPR_BIT) & GRCAN_CONF_BPR;
> -	timing |= (rsj << GRCAN_CONF_RSJ_BIT) & GRCAN_CONF_RSJ;
> -	timing |= (ps1 << GRCAN_CONF_PS1_BIT) & GRCAN_CONF_PS1;
> -	timing |= (ps2 << GRCAN_CONF_PS2_BIT) & GRCAN_CONF_PS2;
> -	timing |= (scaler << GRCAN_CONF_SCALER_BIT) & GRCAN_CONF_SCALER;
> +	timing |= FIELD_PREP(GRCANFD_NBTR_SJW, sjw);
> +	timing |= FIELD_PREP(GRCANFD_NBTR_PS1, ps1);
> +	timing |= FIELD_PREP(GRCANFD_NBTR_PS2, ps2);
> +	timing |= FIELD_PREP(GRCANFD_NBTR_SCALER, scaler);
>  	netdev_info(dev, "setting timing=0x%x\n", timing);
> -	grcan_write_bits(&regs->conf, timing, GRCAN_CONF_TIMING);
> +	grcan_write_bits(&regs->nbtr, timing, GRCANFD_NBTR_TIMING);

Same here. That's another preparation patch.

>  	return 0;
>  }
> @@ -1569,7 +1624,8 @@ static const struct ethtool_ops grcan_ethtool_ops = {
>  
>  static int grcan_setup_netdev(struct platform_device *ofdev,
>  			      void __iomem *base,
> -			      int irq, u32 ambafreq, bool txbug)
> +			      int irq, u32 ambafreq, bool txbug,
> +			      const struct grcan_hwcap *hwcap)
>  {
>  	struct net_device *dev;
>  	struct grcan_priv *priv;
> @@ -1592,14 +1648,14 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
>  	priv->dev = dev;
>  	priv->ofdev_dev = &ofdev->dev;
>  	priv->regs = base;
> -	priv->can.bittiming_const = &grcan_bittiming_const;
> -	priv->can.do_set_bittiming = grcan_set_bittiming;
> +	priv->can.bittiming_const = hwcap->bt_const;
>  	priv->can.do_set_mode = grcan_set_mode;
>  	priv->can.do_get_berr_counter = grcan_get_berr_counter;
>  	priv->can.clock.freq = ambafreq;
>  	priv->can.ctrlmode_supported =
>  		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
>  	priv->need_txbug_workaround = txbug;
> +	priv->hwcap = hwcap;
>  
>  	/* Discover if triple sampling is supported by hardware */
>  	regs = priv->regs;
> @@ -1644,22 +1700,33 @@ static int grcan_probe(struct platform_device *ofdev)
>  {
>  	struct device_node *np = ofdev->dev.of_node;
>  	struct device_node *sysid_parent;
> +	const struct grcan_hwcap *hwcap;
>  	struct clk *clk;
>  	u32 sysid, ambafreq;
>  	int irq, err;
>  	void __iomem *base;
>  	bool txbug = true;
>  
> +	hwcap = device_get_match_data(&ofdev->dev);
> +	if (!hwcap) {
> +		dev_err(&ofdev->dev, "Platform data not provided!\n");
> +		return -ENODEV;
> +	}
> +
>  	/* Compare GRLIB version number with the first that does not
>  	 * have the tx bug (see start_xmit)
>  	 */
> -	sysid_parent = of_find_node_by_path("/ambapp0");
> -	if (sysid_parent) {
> -		err = of_property_read_u32(sysid_parent, "systemid", &sysid);
> -		if (!err && ((sysid & GRLIB_VERSION_MASK) >=
> -			     GRCAN_TXBUG_SAFE_GRLIB_VERSION))
> -			txbug = false;
> -		of_node_put(sysid_parent);
> +	if (!hwcap->txbug_possible) {
> +		txbug = false;
> +	} else {
> +		sysid_parent = of_find_node_by_path("/ambapp0");
> +		if (sysid_parent) {
> +			err = of_property_read_u32(sysid_parent, "systemid", &sysid);
> +			if (!err && ((sysid & GRLIB_VERSION_MASK) >=
> +				     GRCAN_TXBUG_SAFE_GRLIB_VERSION))
> +				txbug = false;
> +			of_node_put(sysid_parent);
> +		}
>  	}
>  
>  	err = of_property_read_u32(np, "freq", &ambafreq);
> @@ -1695,7 +1762,7 @@ static int grcan_probe(struct platform_device *ofdev)
>  
>  	grcan_sanitize_module_config(ofdev);
>  
> -	err = grcan_setup_netdev(ofdev, base, irq, ambafreq, txbug);
> +	err = grcan_setup_netdev(ofdev, base, irq, ambafreq, txbug, hwcap);
>  	if (err)
>  		goto exit_dispose_irq;
>  
> @@ -1722,11 +1789,30 @@ static void grcan_remove(struct platform_device *ofdev)
>  	free_candev(dev);
>  }
>  
> +static const struct grcan_hwcap grcan_hwcap = {
> +	.fd = false,
> +	.txbug_possible = true,
> +	.bt_const = &grcan_bittiming_const,
> +	.set_bittiming = grcan_set_bittiming,
> +};
> +
> +static const struct grcan_hwcap grcanfd_hwcap = {
> +	.fd = true,
> +	.txbug_possible = false,
> +	.bt_const = &grcanfd_bittiming_const,
> +	.set_bittiming = grcanfd_set_bittiming,
> +};
> +
>  static const struct of_device_id grcan_match[] = {
> -	{.name = "GAISLER_GRCAN"},
> -	{.name = "01_03d"},
> -	{.name = "GAISLER_GRHCAN"},
> -	{.name = "01_034"},
> +	{.name = "GAISLER_GRCAN", .data = &grcan_hwcap},
> +	{.name = "01_03d", .data = &grcan_hwcap},
> +	{.name = "GAISLER_GRHCAN", .data = &grcan_hwcap},
> +	{.name = "01_034", .data = &grcan_hwcap},
> +	{.compatible = "gaisler,grcan", .data = &grcan_hwcap},
> +	/* GRCANFD */
> +	{.compatible = "gaisler,grcanfd", .data = &grcanfd_hwcap},
> +	{.name = "GAISLER_GRCANFD", .data = &grcanfd_hwcap},
> +	{.name = "01_0B5", .data = &grcanfd_hwcap},
>  	{},
>  };
>  


Yours sincerely,
Vincent Mailhol

