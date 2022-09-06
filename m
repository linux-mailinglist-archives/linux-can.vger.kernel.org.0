Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0125AE586
	for <lists+linux-can@lfdr.de>; Tue,  6 Sep 2022 12:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiIFKkq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Sep 2022 06:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiIFKkp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Sep 2022 06:40:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701F85A3E6
        for <linux-can@vger.kernel.org>; Tue,  6 Sep 2022 03:40:41 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oVW0C-0006VS-EB; Tue, 06 Sep 2022 12:40:20 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:b512:8477:12a4:5bf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C3D24DB8E6;
        Tue,  6 Sep 2022 10:40:07 +0000 (UTC)
Date:   Tue, 6 Sep 2022 12:40:07 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH v3 4/4] can: bxcan: add support for ST bxCAN
 controller
Message-ID: <20220906104007.qlnysyntnxby4rs6@pengutronix.de>
References: <20220828133329.793324-1-dario.binacchi@amarulasolutions.com>
 <20220828133329.793324-5-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jhjhxecelkgx3kxs"
Content-Disposition: inline
In-Reply-To: <20220828133329.793324-5-dario.binacchi@amarulasolutions.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--jhjhxecelkgx3kxs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.08.2022 15:33:29, Dario Binacchi wrote:
> Add support for the basic extended CAN controller (bxCAN) found in many
> low- to middle-end STM32 SoCs. It supports the Basic Extended CAN
> protocol versions 2.0A and B with a maximum bit rate of 1 Mbit/s.
>=20
> The controller supports two channels (CAN1 as master and CAN2 as slave)
> and the driver can enable either or both of the channels. They share
> some of the required logic (e. g. clocks and filters), and that means
> you cannot use the slave CAN without enabling some hardware resources
> managed by the master CAN.

I don't like the concept of the core driver. E.g. the r-m-w of shared
registers bxcan_enable_filters() is racy by design.

How is the memory layout?
- 0x000 - 0x1ff: CAN1
- 0x200 - 0x3ff: shared mem
- 0x400 - 0x5ff: CAN2

Better model the shared mem as a "syscon" node:

| https://elixir.bootlin.com/linux/v6.0-rc4/source/drivers/net/ethernet/stm=
icro/stmmac/dwmac-rk.c#L1445

Then you can use regmap_*() functions to access the register space. The
regmap functions are always locked against each other.

[...]

> diff --git a/drivers/net/can/bxcan/bxcan-core.c b/drivers/net/can/bxcan/b=
xcan-core.c
> new file mode 100644
> index 000000000000..3644449095e9
> --- /dev/null
> +++ b/drivers/net/can/bxcan/bxcan-core.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* bxcan-core.c - STM32 Basic Extended CAN core controller driver
> + *
> + * This file is part of STM32 bxcan driver
> + *
> + * Copyright (c) 2022 Dario Binacchi <dario.binacchi@amarulasolutions.co=
m>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +
> +#include "bxcan-core.h"
> +
> +#define BXCAN_FILTER_ID(master)       (master ? 0 : 14)
> +
> +/* Filter master register (FMR) bits */
> +#define BXCAN_FMR_CANSB_MASK	GENMASK(13, 8)
> +#define BXCAN_FMR_CANSB(x)	(((x) & 0x3f) << 8)
> +#define BXCAN_FMR_FINIT		BIT(0)

nitpick:
please use 1 space instead of tabs

> +
> +/* Structure of the filter bank */
> +struct bxcan_fb {
> +	u32 fr1;		/* filter 1 */
> +	u32 fr2;		/* filter 2 */
> +};
> +
> +/* Structure of the hardware filter registers */
> +struct bxcan_fregs {
> +	u32 fmr;		/* 0x00 - filter master */
> +	u32 fm1r;		/* 0x04 - filter mode */
> +	u32 reserved2;		/* 0x08 */
> +	u32 fs1r;		/* 0x0c - filter scale */
> +	u32 reserved3;		/* 0x10 */
> +	u32 ffa1r;		/* 0x14 - filter FIFO assignment */
> +	u32 reserved4;		/* 0x18 */
> +	u32 fa1r;		/* 0x1c - filter activation */
> +	u32 reserved5[8];	/* 0x20 */
> +	struct bxcan_fb fb[28];	/* 0x40 - filter banks */
> +};
> +
> +struct bxcan_core_priv {
> +	void __iomem *base;
> +	struct bxcan_fregs __iomem *fregs;
> +	struct clk *clk_master;
> +	unsigned int clk_master_ref;
> +};
> +
> +void bxcan_disable_filters(struct device *dev, bool master)
> +{
> +	struct bxcan_core_priv *priv =3D dev_get_drvdata(dev);
> +	unsigned int fid =3D BXCAN_FILTER_ID(master);
> +	u32 fmask =3D BIT(fid);
> +
> +	bxcan_rmw(&priv->fregs->fa1r, fmask, 0);

This is racy, same for bxcan_rmw() on other shared registers.

> +}
> +
> +void bxcan_enable_filters(struct device *dev, bool master)
> +{
> +	struct bxcan_core_priv *priv =3D dev_get_drvdata(dev);
> +	unsigned int fid =3D BXCAN_FILTER_ID(master);
> +	u32 fmask =3D BIT(fid);
> +
> +	/* Filter settings:
> +	 *
> +	 * Accept all messages.
> +	 * Assign filter 0 to CAN1 and filter 14 to CAN2 in identifier
> +	 * mask mode with 32 bits width.
> +	 */
> +
> +	/* Enter filter initialization mode and assing filters to CAN
> +	 * controllers.
> +	 */
> +	bxcan_rmw(&priv->fregs->fmr, BXCAN_FMR_CANSB_MASK,
> +		  BXCAN_FMR_CANSB(14) | BXCAN_FMR_FINIT);
> +
> +	/* Deactivate filter */
> +	bxcan_rmw(&priv->fregs->fa1r, fmask, 0);
> +
> +	/* Two 32-bit registers in identifier mask mode */
> +	bxcan_rmw(&priv->fregs->fm1r, fmask, 0);
> +
> +	/* Single 32-bit scale configuration */
> +	bxcan_rmw(&priv->fregs->fs1r, 0, fmask);
> +
> +	/* Assign filter to FIFO 0 */
> +	bxcan_rmw(&priv->fregs->ffa1r, fmask, 0);
> +
> +	/* Accept all messages */
> +	writel(0, &priv->fregs->fb[fid].fr1);
> +	writel(0, &priv->fregs->fb[fid].fr2);
> +
> +	/* Activate filter */
> +	bxcan_rmw(&priv->fregs->fa1r, 0, fmask);
> +
> +	/* Exit filter initialization mode */
> +	bxcan_rmw(&priv->fregs->fmr, BXCAN_FMR_FINIT, 0);
> +}
> +
> +int bxcan_enable_master_clk(struct device *dev)
> +{
> +	struct bxcan_core_priv *priv =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	if (priv->clk_master_ref =3D=3D 0) {
> +		err =3D clk_prepare_enable(priv->clk_master);
> +		if (err)
> +			return err;
> +	}
> +
> +	priv->clk_master_ref++;

In general, don't do clock ref-counting. You can enable and disable the
same clock several times.

If you convert to syscon, you can add a clock node to the syscon node
and the syscon driver will take care of the clocks.

> +	return 0;
> +}
> +
> +void bxcan_disable_master_clk(struct device *dev)
> +{
> +	struct bxcan_core_priv *priv =3D dev_get_drvdata(dev);
> +
> +	if (priv->clk_master_ref =3D=3D 0)
> +		return;
> +
> +	if (priv->clk_master_ref =3D=3D 1)
> +		clk_disable_unprepare(priv->clk_master);
> +
> +	priv->clk_master_ref--;
> +}
> +
> +unsigned long bxcan_get_master_clk_rate(struct device *dev)
> +{
> +	struct bxcan_core_priv *priv =3D dev_get_drvdata(dev);
> +
> +	return clk_get_rate(priv->clk_master);
> +}
> +
> +void __iomem *bxcan_get_base_addr(struct device *dev)
> +{
> +	struct bxcan_core_priv *priv =3D dev_get_drvdata(dev);
> +
> +	return priv->base;
> +}
> +
> +static const struct of_device_id bxcan_core_of_match[] =3D {
> +	{.compatible =3D "st,stm32f4-bxcan-core"},
> +	{ /* sentinel */ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, bxcan_core_of_match);
> +
> +static int bxcan_core_probe(struct platform_device *pdev)
> +{
> +	struct bxcan_core_priv *priv;
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D pdev->dev.of_node;
> +	void __iomem *regs;
> +	struct clk *clk;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +	regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "failed to get clock\n");
> +		return PTR_ERR(clk);
> +	}
> +
> +	priv->base =3D regs;
> +	priv->fregs =3D regs + 0x200;
> +	priv->clk_master =3D clk;
> +
> +	ret =3D of_platform_populate(np, NULL, NULL, dev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to populate DT children\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver bxcan_core_driver =3D {
> +	.driver =3D {
> +		.name =3D KBUILD_MODNAME,
> +		.of_match_table =3D bxcan_core_of_match,
> +	},
> +	.probe =3D bxcan_core_probe,
> +};
> +
> +module_platform_driver(bxcan_core_driver);
> +
> +MODULE_AUTHOR("Dario Binacchi <dario.binacchi@amarulasolutions.com>");
> +MODULE_DESCRIPTION("STMicroelectronics Basic Extended CAN core driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/net/can/bxcan/bxcan-core.h b/drivers/net/can/bxcan/b=
xcan-core.h
> new file mode 100644
> index 000000000000..925449cbc3bd
> --- /dev/null
> +++ b/drivers/net/can/bxcan/bxcan-core.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * bxcan-core - STM32 Basic Extended CAN core controller driver
> + *
> + * Copyright (c) 2022 Dario Binacchi <dario.binacchi@amarulasolutions.co=
m>
> + */
> +
> +#ifndef __BXCAN_CORE_H
> +#define __BXCAN_CORE_H
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +int bxcan_enable_master_clk(struct device *dev);
> +void bxcan_disable_master_clk(struct device *dev);
> +unsigned long bxcan_get_master_clk_rate(struct device *dev);
> +void __iomem *bxcan_get_base_addr(struct device *dev);
> +void bxcan_enable_filters(struct device *dev, bool master);
> +void bxcan_disable_filters(struct device *dev, bool master);
> +
> +static inline void bxcan_rmw(void __iomem *addr, u32 clear, u32 set)
> +{
> +	u32 old, val;
> +
> +	old =3D readl(addr);
> +	val =3D (old & ~clear) | set;
> +	if (val !=3D old)
> +		writel(val, addr);
> +}
> +
> +#endif
> diff --git a/drivers/net/can/bxcan/bxcan-drv.c b/drivers/net/can/bxcan/bx=
can-drv.c
> new file mode 100644
> index 000000000000..7ac1ee7a4269
> --- /dev/null
> +++ b/drivers/net/can/bxcan/bxcan-drv.c
> @@ -0,0 +1,1045 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// bxcan-drv.c - STM32 Basic Extended CAN controller driver
> +//
> +// Copyright (c) 2022 Dario Binacchi <dario.binacchi@amarulasolutions.co=
m>
> +//
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "bxcan-core.h"
> +
> +#define BXCAN_NAPI_WEIGHT		3
> +#define BXCAN_TIMEOUT_US		10000
> +
> +#define BXCAN_TX_MB_NUM			3
> +
> +/* Master control register (MCR) bits */
> +#define BXCAN_MCR_DBF			BIT(16)
> +#define BXCAN_MCR_RESET			BIT(15)
> +#define BXCAN_MCR_TTCM			BIT(7)
> +#define BXCAN_MCR_ABOM			BIT(6)
> +#define BXCAN_MCR_AWUM			BIT(5)
> +#define BXCAN_MCR_NART			BIT(4)
> +#define BXCAN_MCR_RFLM			BIT(3)
> +#define BXCAN_MCR_TXFP			BIT(2)
> +#define BXCAN_MCR_SLEEP			BIT(1)
> +#define BXCAN_MCR_INRQ			BIT(0)
> +
> +/* Master status register (MSR) bits */
> +#define BXCAN_MSR_RX			BIT(11)
> +#define BXCAN_MSR_SAMP			BIT(10)
> +#define BXCAN_MSR_RXM			BIT(9)
> +#define BXCAN_MSR_TXM			BIT(8)
> +#define BXCAN_MSR_SLAKI			BIT(4)
> +#define BXCAN_MSR_WKUI			BIT(3)
> +#define BXCAN_MSR_ERRI			BIT(2)
> +#define BXCAN_MSR_SLAK			BIT(1)
> +#define BXCAN_MSR_INAK			BIT(0)
> +
> +/* Transmit status register (TSR) bits */
> +#define BXCAN_TSR_LOW2			BIT(31)
> +#define BXCAN_TSR_LOW1			BIT(30)
> +#define BXCAN_TSR_LOW0			BIT(29)
> +#define BXCAN_TSR_TME			GENMASK(28, 26)
> +#define BXCAN_TSR_TME_SHIFT		(26)

unused

> +#define BXCAN_TSR_TME2			BIT(28)
> +#define BXCAN_TSR_TME1			BIT(27)
> +#define BXCAN_TSR_TME0			BIT(26)
> +#define BXCAN_TSR_CODE			GENMASK(25, 24)
> +#define BXCAN_TSR_ABRQ2			BIT(23)
> +#define BXCAN_TSR_TERR2			BIT(19)
> +#define BXCAN_TSR_ALST2			BIT(18)
> +#define BXCAN_TSR_TXOK2			BIT(17)
> +#define BXCAN_TSR_RQCP2			BIT(16)
> +#define BXCAN_TSR_ABRQ1			BIT(15)
> +#define BXCAN_TSR_TERR1			BIT(11)
> +#define BXCAN_TSR_ALST1			BIT(10)
> +#define BXCAN_TSR_TXOK1			BIT(9)
> +#define BXCAN_TSR_RQCP1			BIT(8)
> +#define BXCAN_TSR_ABRQ0			BIT(7)
> +#define BXCAN_TSR_TERR0			BIT(3)
> +#define BXCAN_TSR_ALST0			BIT(2)
> +#define BXCAN_TSR_TXOK0			BIT(1)
> +#define BXCAN_TSR_RQCP0			BIT(0)
> +
> +/* Receive FIFO 0 register (RF0R) bits */
> +#define BXCAN_RF0R_RFOM0		BIT(5)
> +#define BXCAN_RF0R_FOVR0		BIT(4)
> +#define BXCAN_RF0R_FULL0		BIT(3)
> +#define BXCAN_RF0R_FMP0			GENMASK(1, 0)
> +
> +/* Interrupt enable register (IER) bits */
> +#define BXCAN_IER_SLKIE			BIT(17)
> +#define BXCAN_IER_WKUIE			BIT(16)
> +#define BXCAN_IER_ERRIE			BIT(15)
> +#define BXCAN_IER_LECIE			BIT(11)
> +#define BXCAN_IER_BOFIE			BIT(10)
> +#define BXCAN_IER_EPVIE			BIT(9)
> +#define BXCAN_IER_EWGIE			BIT(8)
> +#define BXCAN_IER_FOVIE1		BIT(6)
> +#define BXCAN_IER_FFIE1			BIT(5)
> +#define BXCAN_IER_FMPIE1		BIT(4)
> +#define BXCAN_IER_FOVIE0		BIT(3)
> +#define BXCAN_IER_FFIE0			BIT(2)
> +#define BXCAN_IER_FMPIE0		BIT(1)
> +#define BXCAN_IER_TMEIE			BIT(0)
> +
> +/* Error status register (ESR) bits */
> +#define BXCAN_ESR_REC_SHIFT		(24)
> +#define BXCAN_ESR_REC			GENMASK(31, 24)
> +#define BXCAN_ESR_TEC_SHIFT		(16)
> +#define BXCAN_ESR_TEC			GENMASK(23, 16)
> +#define BXCAN_ESR_LEC_SHIFT		(4)

please remove the _SHIFT macros, no need for them...

> +#define BXCAN_ESR_LEC			GENMASK(6, 4)
> +#define BXCAN_ESR_BOFF			BIT(1)
> +#define BXCAN_ESR_EPVF			BIT(1)
> +#define BXCAN_ESR_EWGF			BIT(0)
> +#define BXCAN_TEC(esr)			(((esr) & BXCAN_ESR_TEC) >> \
> +					 BXCAN_ESR_TEC_SHIFT)
> +#define BXCAN_REC(esr)			(((esr) & BXCAN_ESR_REC) >> \
> +					 BXCAN_ESR_REC_SHIFT)

=2E.. remove these and use FIELD_GET() directly.

> +
> +/* Bit timing register (BTR) bits */
> +#define BXCAN_BTR_SILM			BIT(31)
> +#define BXCAN_BTR_LBKM			BIT(30)
> +#define BXCAN_BTR_SJW_MASK		GENMASK(25, 24)
> +#define BXCAN_BTR_SJW(x)		(((x) & 0x03) << 24)
> +#define BXCAN_BTR_TS2_MASK		GENMASK(22, 20)
> +#define BXCAN_BTR_TS2(x)		(((x) & 0x07) << 20)
> +#define BXCAN_BTR_TS1_MASK		GENMASK(19, 16)
> +#define BXCAN_BTR_TS1(x)		(((x) & 0x0f) << 16)
> +#define BXCAN_BTR_BRP_MASK		GENMASK(9, 0)
> +#define BXCAN_BTR_BRP(x)		((x) & 0x3ff)

same for these

> +
> +/* TX mailbox identifier register (TIxR, x =3D 0..2) bits */
> +#define BXCAN_TIxR_STID(x)		(((x) & 0x7ff) << 21)
> +#define BXCAN_TIxR_EXID(x)		((x) << 3)

same here

> +#define BXCAN_TIxR_IDE			BIT(2)
> +#define BXCAN_TIxR_RTR			BIT(1)
> +#define BXCAN_TIxR_TXRQ			BIT(0)
> +
> +/* TX mailbox data length and time stamp register (TDTxR, x =3D 0..2 bit=
s */
> +#define BXCAN_TDTxR_TIME(x)		(((x) & 0x0f) << 16)

same

> +#define BXCAN_TDTxR_TGT			BIT(8)
> +#define BXCAN_TDTxR_DLC_MASK		GENMASK(3, 0)
> +#define BXCAN_TDTxR_DLC(x)		((x) & 0x0f)

same

> +
> +/* RX FIFO mailbox identifier register (RIxR, x =3D 0..1 */
> +#define BXCAN_RIxR_STID_SHIFT		(21)
> +#define BXCAN_RIxR_EXID_SHIFT		(3)
> +#define BXCAN_RIxR_IDE			BIT(2)
> +#define BXCAN_RIxR_RTR			BIT(1)
> +
> +/* RX FIFO mailbox data length and timestamp register (RDTxR, x =3D 0..1=
) bits */
> +#define BXCAN_RDTxR_TIME		GENMASK(31, 16)
> +#define BXCAN_RDTxR_FMI			GENMASK(15, 8)
> +#define BXCAN_RDTxR_DLC			GENMASK(3, 0)
> +
> +enum bxcan_lec_code {
> +	LEC_NO_ERROR =3D 0,
> +	LEC_STUFF_ERROR,
> +	LEC_FORM_ERROR,
> +	LEC_ACK_ERROR,
> +	LEC_BIT1_ERROR,
> +	LEC_BIT0_ERROR,
> +	LEC_CRC_ERROR,
> +	LEC_UNUSED

Please add BXCAN_ as prefix

> +};
> +
> +/* Structure of the message buffer */
> +struct bxcan_mb {
> +	u32 id;			/* can identifier */
> +	u32 dlc;		/* data length control and timestamp */
> +	u32 data[2];		/* data */
> +};
> +
> +/* Structure of the hardware registers */
> +struct bxcan_regs {
> +	u32 mcr;			/* 0x00 - master control */
> +	u32 msr;			/* 0x04 - master status */
> +	u32 tsr;			/* 0x08 - transmit status */
> +	u32 rf0r;			/* 0x0c - FIFO 0 */
> +	u32 rf1r;			/* 0x10 - FIFO 1 */
> +	u32 ier;			/* 0x14 - interrupt enable */
> +	u32 esr;			/* 0x18 - error status */
> +	u32 btr;			/* 0x1c - bit timing*/
> +	u32 reserved0[88];		/* 0x20 */
> +	struct bxcan_mb tx_mb[BXCAN_TX_MB_NUM];	/* 0x180 - tx mailbox */
> +	struct bxcan_mb rx_mb[2];	/* 0x1b0 - rx mailbox */

Please add a define for the "2", as well.

> +};
> +
> +struct bxcan_priv {
> +	struct can_priv can;
> +	struct device *dev;
> +	struct net_device *ndev;
> +	struct napi_struct napi;

consider using can_rx_offload().

The idea is to read from the mailbox in the IRQ handler and push the
frame into the networking stack in the napi.

> +
> +	struct bxcan_regs __iomem *regs;
> +	int tx_irq;
> +	int sce_irq;
> +	u8 tx_dlc[BXCAN_TX_MB_NUM];

unused

> +	bool master;
> +	struct clk *clk;
> +	unsigned int tx_head;
> +	unsigned int tx_tail;
> +};
> +
> +static const struct can_bittiming_const bxcan_bittiming_const =3D {
> +	.name =3D KBUILD_MODNAME,
> +	.tseg1_min =3D 1,
> +	.tseg1_max =3D 16,
> +	.tseg2_min =3D 1,
> +	.tseg2_max =3D 8,
> +	.sjw_max =3D 4,
> +	.brp_min =3D 1,
> +	.brp_max =3D 1024,
> +	.brp_inc =3D 1,
> +};
> +
> +static inline u8 bxcan_get_tx_head(const struct bxcan_priv *priv)
> +{
> +	return priv->tx_head % BXCAN_TX_MB_NUM;
> +}
> +
> +static inline u8 bxcan_get_tx_tail(const struct bxcan_priv *priv)
> +{
> +	return priv->tx_tail % BXCAN_TX_MB_NUM;
> +}
> +
> +static inline u8 bxcan_get_tx_free(const struct bxcan_priv *priv)
> +{
> +	return BXCAN_TX_MB_NUM - (priv->tx_head - priv->tx_tail);
> +}
> +
> +static bool bxcan_tx_busy(const struct bxcan_priv *priv)
> +{
> +	if (bxcan_get_tx_free(priv) > 0)
> +		return false;
> +
> +	netif_stop_queue(priv->ndev);
> +
> +	/* Memory barrier before checking tx_free (head and tail) */
> +	smp_mb();
> +
> +	if (bxcan_get_tx_free(priv) =3D=3D 0) {
> +		netdev_dbg(priv->ndev,
> +			   "Stopping tx-queue (tx_head=3D0x%08x, tx_tail=3D0x%08x, len=3D%d).=
\n",
> +			   priv->tx_head, priv->tx_tail,
> +			   priv->tx_head - priv->tx_tail);
> +
> +		return true;
> +	}
> +
> +	netif_start_queue(priv->ndev);
> +
> +	return false;
> +}
> +
> +static int bxcan_chip_softreset(struct bxcan_priv *priv)
> +{
> +	struct bxcan_regs __iomem *regs =3D priv->regs;
> +	unsigned int timeout =3D BXCAN_TIMEOUT_US / 10;
> +
> +	bxcan_rmw(&regs->mcr, 0, BXCAN_MCR_RESET);
> +	while (timeout-- && !(readl(&regs->msr) & BXCAN_MSR_SLAK))
> +		udelay(10);

make use of readx_poll_timeout(), see:

| https://elixir.bootlin.com/linux/v6.0-rc4/source/drivers/net/can/spi/mcp2=
51x.c#L410

> +
> +	if (!(readl(&regs->msr) & BXCAN_MSR_SLAK))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int bxcan_enter_init_mode(struct bxcan_priv *priv)
> +{
> +	struct bxcan_regs __iomem *regs =3D priv->regs;
> +	unsigned int timeout =3D BXCAN_TIMEOUT_US / 10;
> +
> +	bxcan_rmw(&regs->mcr, 0, BXCAN_MCR_INRQ);
> +	while (timeout-- && !(readl(&regs->msr) & BXCAN_MSR_INAK))
> +		udelay(100);

same here

> +
> +	if (!(readl(&regs->msr) & BXCAN_MSR_INAK))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int bxcan_leave_init_mode(struct bxcan_priv *priv)
> +{
> +	struct bxcan_regs __iomem *regs =3D priv->regs;
> +	unsigned int timeout =3D BXCAN_TIMEOUT_US / 10;
> +
> +	bxcan_rmw(&regs->mcr, BXCAN_MCR_INRQ, 0);
> +	while (timeout-- && (readl(&regs->msr) & BXCAN_MSR_INAK))
> +		udelay(100);

same

> +
> +	if (readl(&regs->msr) & BXCAN_MSR_INAK)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int bxcan_leave_sleep_mode(struct bxcan_priv *priv)
> +{
> +	struct bxcan_regs __iomem *regs =3D priv->regs;
> +	unsigned int timeout =3D BXCAN_TIMEOUT_US / 10;
> +
> +	bxcan_rmw(&regs->mcr, BXCAN_MCR_SLEEP, 0);
> +	while (timeout-- && (readl(&regs->msr) & BXCAN_MSR_SLAK))
> +		udelay(100);

same

> +
> +	if (readl(&regs->msr) & BXCAN_MSR_SLAK)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int bxcan_enter_sleep_mode(struct bxcan_priv *priv)
> +{
> +	struct bxcan_regs __iomem *regs =3D priv->regs;
> +	unsigned int timeout =3D BXCAN_TIMEOUT_US / 10;
> +
> +	bxcan_rmw(&regs->mcr, 0, BXCAN_MCR_SLEEP);
> +	while (timeout-- && !(readl(&regs->msr) & BXCAN_MSR_SLAK))
> +		udelay(100);

same

> +
> +	if (!(readl(&regs->msr) & BXCAN_MSR_SLAK))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static irqreturn_t bxcan_rx_isr(int irq, void *dev_id)
> +{
> +	struct net_device *ndev =3D dev_id;
> +	struct bxcan_priv *priv =3D netdev_priv(ndev);
> +	struct bxcan_regs __iomem *regs =3D priv->regs;
> +
> +	if (napi_schedule_prep(&priv->napi)) {
> +		/* Disable Rx FIFO message pending interrupt */
> +		bxcan_rmw(&regs->ier, BXCAN_IER_FMPIE0, 0);
> +		__napi_schedule(&priv->napi);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bxcan_tx_isr(int irq, void *dev_id)
> +{
> +	struct net_device *ndev =3D dev_id;
> +	struct bxcan_priv *priv =3D netdev_priv(ndev);
> +	struct bxcan_regs __iomem *regs =3D priv->regs;
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	u32 tsr, rqcp_bit, bytes =3D 0, pkts =3D 0;
> +	int n, idx;
> +
> +	tsr =3D readl(&regs->tsr);
> +	for (n =3D 0, idx =3D bxcan_get_tx_tail(priv); n < BXCAN_TX_MB_NUM; n++=
) {

loop from tail to head:

| while (priv->tx_head - priv->tx_tail > 0) {
| ...
|       idx =3D bxcan_get_tx_tail()
| ...


> +		rqcp_bit =3D BXCAN_TSR_RQCP0 << (idx << 3);
> +		if (tsr & rqcp_bit) {
> +			pkts++;
> +			bytes +=3D can_get_echo_skb(ndev, idx, NULL);
> +		}
> +
> +		idx +=3D 1;
> +		if (idx =3D=3D BXCAN_TX_MB_NUM)
> +			idx =3D 0;
> +	}
> +
> +	if (!pkts)
> +		return IRQ_HANDLED;

This looks wrong. Better check if any relevant bits in tsr are set, if
not return IRQ_NONE.

> +
> +	writel(tsr, &regs->tsr);
> +
> +	priv->tx_tail +=3D pkts;
> +	if (bxcan_get_tx_free(priv)) {
> +		/* Make sure that anybody stopping the queue after
> +		 * this sees the new tx_ring->tail.
> +		 */
> +		smp_mb();
> +		netif_wake_queue(ndev);
> +	}
> +
> +	stats->tx_bytes +=3D bytes;
> +	stats->tx_packets +=3D pkts;
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void bxcan_handle_state_change(struct net_device *ndev, u32 esr)
> +{
> +	struct bxcan_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	enum can_state new_state =3D priv->can.state;
> +	struct can_berr_counter bec;
> +	enum can_state rx_state, tx_state;
> +	struct sk_buff *skb;
> +	struct can_frame *cf;
> +
> +	/* Early exit if no error flag is set */
> +	if (!(esr & (BXCAN_ESR_EWGF | BXCAN_ESR_EPVF | BXCAN_ESR_BOFF)))
> +		return;
> +
> +	bec.txerr =3D BXCAN_TEC(esr);
> +	bec.rxerr =3D BXCAN_REC(esr);
> +
> +	if (esr & BXCAN_ESR_BOFF)
> +		new_state =3D CAN_STATE_BUS_OFF;
> +	else if (esr & BXCAN_ESR_EPVF)
> +		new_state =3D CAN_STATE_ERROR_PASSIVE;
> +	else if (esr & BXCAN_ESR_EWGF)
> +		new_state =3D CAN_STATE_ERROR_WARNING;
> +
> +	/* state hasn't changed */
> +	if (unlikely(new_state =3D=3D priv->can.state))
> +		return;
> +
> +	skb =3D alloc_can_err_skb(ndev, &cf);
> +	if (unlikely(!skb))
> +		return;

Continue, even if you got no skb.

> +
> +	tx_state =3D bec.txerr >=3D bec.rxerr ? new_state : 0;
> +	rx_state =3D bec.txerr <=3D bec.rxerr ? new_state : 0;
> +	can_change_state(ndev, cf, tx_state, rx_state);

can_change_state() handles cf =3D=3D NULL....

> +
> +	if (new_state =3D=3D CAN_STATE_BUS_OFF)
> +		can_bus_off(ndev);
> +
> +	stats->rx_bytes +=3D cf->len;
> +	stats->rx_packets++;

no statistics for error frames.

> +	netif_rx(skb);
> +}
> +
> +static void bxcan_handle_bus_err(struct net_device *ndev, u32 esr)
> +{
> +	struct bxcan_priv *priv =3D netdev_priv(ndev);
> +	enum bxcan_lec_code lec_code;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	lec_code =3D (esr & BXCAN_ESR_LEC_SHIFT) >> BXCAN_ESR_LEC_SHIFT;

Use FIELD_GET()

> +
> +	/* Early exit if no lec update or no error.
> +	 * No lec update means that no CAN bus event has been detected
> +	 * since CPU wrote LEC_UNUSED value to status reg.
> +	 */
> +	if (lec_code =3D=3D LEC_UNUSED || lec_code =3D=3D LEC_NO_ERROR)
> +		return;
> +
> +	if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
> +		return;

Can you disable the generation of the bus error interrupt?

> +
> +	/* Common for all type of bus errors */
> +	priv->can.can_stats.bus_error++;
> +
> +	/* Propagate the error condition to the CAN stack */
> +	skb =3D alloc_can_err_skb(ndev, &cf);
> +	if (unlikely(!skb))
> +		return;

continue, even without skb

> +
> +	ndev->stats.rx_bytes +=3D cf->len;

no stats

> +
> +	/* Check for 'last error code' which tells us the
> +	 * type of the last error to occur on the CAN bus
> +	 */
> +	cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +
> +	switch (lec_code) {
> +	case LEC_STUFF_ERROR:
> +		netdev_dbg(ndev, "Stuff error\n");
> +		ndev->stats.rx_errors++;
> +		cf->data[2] |=3D CAN_ERR_PROT_STUFF;
> +		break;
> +	case LEC_FORM_ERROR:
> +		netdev_dbg(ndev, "Form error\n");
> +		ndev->stats.rx_errors++;
> +		cf->data[2] |=3D CAN_ERR_PROT_FORM;
> +		break;
> +	case LEC_ACK_ERROR:
> +		netdev_dbg(ndev, "Ack error\n");
> +		ndev->stats.tx_errors++;
> +		cf->data[3] =3D CAN_ERR_PROT_LOC_ACK;
> +		break;
> +	case LEC_BIT1_ERROR:
> +		netdev_dbg(ndev, "Bit error (recessive)\n");
> +		ndev->stats.tx_errors++;
> +		cf->data[2] |=3D CAN_ERR_PROT_BIT1;
> +		break;
> +	case LEC_BIT0_ERROR:
> +		netdev_dbg(ndev, "Bit error (dominant)\n");
> +		ndev->stats.tx_errors++;
> +		cf->data[2] |=3D CAN_ERR_PROT_BIT0;
> +		break;
> +	case LEC_CRC_ERROR:
> +		netdev_dbg(ndev, "CRC error\n");
> +		ndev->stats.rx_errors++;
> +		cf->data[3] =3D CAN_ERR_PROT_LOC_CRC_SEQ;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	netif_rx(skb);
> +}
> +
> +static irqreturn_t bxcan_state_change_isr(int irq, void *dev_id)
> +{
> +	struct net_device *ndev =3D dev_id;
> +	struct bxcan_priv *priv =3D netdev_priv(ndev);
> +	struct bxcan_regs __iomem *regs =3D priv->regs;
> +	u32 msr, esr;
> +
> +	msr =3D readl(&regs->msr);
> +	if (!(msr & BXCAN_MSR_ERRI))
> +		return IRQ_NONE;
> +
> +	esr =3D readl(&regs->esr);
> +	bxcan_handle_state_change(ndev, esr);
> +	bxcan_handle_bus_err(ndev, esr);
> +
> +	msr |=3D BXCAN_MSR_ERRI;
> +	writel(msr, &regs->msr);

nitpick: please add an empty line in front of return

> +	return IRQ_HANDLED;
> +}
> +
> +static int bxcan_start(struct net_device *ndev)

please rename to bxcan_chip_start()

> +{
> +	struct bxcan_priv *priv =3D netdev_priv(ndev);
> +	struct bxcan_regs __iomem *regs =3D priv->regs;
> +	struct can_bittiming *bt =3D &priv->can.bittiming;
> +	u32 set;
> +	int err;
> +
> +	err =3D bxcan_chip_softreset(priv);
> +	if (err) {
> +		netdev_err(ndev, "failed to reset chip, error %d\n", err);
> +		return err;
> +	}
> +
> +	err =3D bxcan_leave_sleep_mode(priv);
> +	if (err) {
> +		netdev_err(ndev, "failed to leave sleep mode, error %d\n", err);
> +		goto failed_leave_sleep;
> +	}
> +
> +	err =3D bxcan_enter_init_mode(priv);
> +	if (err) {
> +		netdev_err(ndev, "failed to enter init mode, error %d\n", err);
> +		goto failed_enter_init;
> +	}
> +
> +	/* MCR
> +	 *
> +	 * select request order priority
> +	 * disable time triggered mode
> +	 * bus-off state left on sw request
> +	 * sleep mode left on sw request
> +	 * retransmit automatically on error
> +	 * do not lock RX FIFO on overrun
> +	 */
> +	bxcan_rmw(&regs->mcr, BXCAN_MCR_TTCM | BXCAN_MCR_ABOM | BXCAN_MCR_AWUM |
> +		  BXCAN_MCR_NART | BXCAN_MCR_RFLM, BXCAN_MCR_TXFP);
> +
> +	/* Bit timing register settings */
> +	set =3D BXCAN_BTR_BRP(bt->brp - 1) |
> +		BXCAN_BTR_TS1(bt->phase_seg1 + bt->prop_seg - 1) |
> +		BXCAN_BTR_TS2(bt->phase_seg2 - 1) | BXCAN_BTR_SJW(bt->sjw - 1);
> +
> +	/* loopback + silent mode put the controller in test mode,
> +	 * useful for hot self-test
> +	 */
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
> +		set |=3D BXCAN_BTR_LBKM;
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +		set |=3D BXCAN_BTR_SILM;
> +
> +	netdev_dbg(ndev,
> +		   "TQ[ns]: %d, PrS: %d, PhS1: %d, PhS2: %d, SJW: %d, BRP: %d, CAN_BTR=
: 0x%08x\n",
> +		   bt->tq, bt->prop_seg, bt->phase_seg1, bt->phase_seg2,
> +		   bt->sjw, bt->brp, set);
> +	bxcan_rmw(&regs->btr, BXCAN_BTR_SILM | BXCAN_BTR_LBKM |
> +		  BXCAN_BTR_BRP_MASK | BXCAN_BTR_TS1_MASK | BXCAN_BTR_TS2_MASK |
> +		  BXCAN_BTR_SJW_MASK, set);
> +
> +	bxcan_enable_filters(priv->dev->parent, priv->master);
> +
> +	/* Clear all internal status */
> +	priv->tx_head =3D 0;
> +	priv->tx_tail =3D 0;
> +
> +	err =3D bxcan_leave_init_mode(priv);
> +	if (err) {
> +		netdev_err(ndev, "failed to leave init mode, error %d\n", err);
> +		goto failed_leave_init;
> +	}
> +
> +	/* Set a `lec` value so that we can check for updates later */
> +	bxcan_rmw(&regs->esr, BXCAN_ESR_LEC, LEC_UNUSED << BXCAN_ESR_LEC_SHIFT);
> +
> +	/* IER
> +	 *
> +	 * Enable interrupt for:
> +	 * bus-off
> +	 * passive error
> +	 * warning error
> +	 * last error code
> +	 * RX FIFO pending message
> +	 * TX mailbox empty
> +	 */
> +	bxcan_rmw(&regs->ier, BXCAN_IER_WKUIE | BXCAN_IER_SLKIE |
> +		  BXCAN_IER_FOVIE1 | BXCAN_IER_FFIE1 | BXCAN_IER_FMPIE1 |
> +		  BXCAN_IER_FOVIE0 | BXCAN_IER_FFIE0,
> +		  BXCAN_IER_ERRIE | BXCAN_IER_LECIE | BXCAN_IER_BOFIE |
> +		  BXCAN_IER_EPVIE | BXCAN_IER_EWGIE | BXCAN_IER_FMPIE0 |
> +		  BXCAN_IER_TMEIE);
> +
> +	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +	return 0;
> +
> +failed_leave_init:
> +failed_enter_init:
> +failed_leave_sleep:
> +	bxcan_chip_softreset(priv);
> +	return err;
> +}
> +
> +static int bxcan_open(struct net_device *ndev)
> +{
> +	struct bxcan_priv *priv =3D netdev_priv(ndev);
> +	int err;
> +
> +	err =3D open_candev(ndev);
> +	if (err) {
> +		netdev_err(ndev, "open_candev() failed, error %d\n", err);
> +		goto failed_open;
> +	}
> +
> +	napi_enable(&priv->napi);
> +	err =3D request_irq(ndev->irq, bxcan_rx_isr, IRQF_SHARED, ndev->name,
> +			  ndev);
> +	if (err) {
> +		netdev_err(ndev, "failed to register rx irq(%d), error %d\n",
> +			   ndev->irq, err);
> +		goto failed_rx_irq_request;
> +	}
> +
> +	err =3D request_irq(priv->tx_irq, bxcan_tx_isr, IRQF_SHARED, ndev->name,
> +			  ndev);
> +	if (err) {
> +		netdev_err(ndev, "failed to register tx irq(%d), error %d\n",
> +			   priv->tx_irq, err);
> +		goto failed_tx_irq_request;
> +	}
> +
> +	err =3D request_irq(priv->sce_irq, bxcan_state_change_isr, IRQF_SHARED,
> +			  ndev->name, ndev);
> +	if (err) {
> +		netdev_err(ndev, "failed to register sce irq(%d), error %d\n",
> +			   priv->sce_irq, err);
> +		goto failed_sce_irq_request;
> +	}
> +
> +	err =3D bxcan_start(ndev);
> +	if (err)
> +		goto failed_start;
> +
> +	netif_start_queue(ndev);
> +	return 0;
> +
> +failed_start:
> +failed_sce_irq_request:
> +	free_irq(priv->tx_irq, ndev);
> +failed_tx_irq_request:
> +	free_irq(ndev->irq, ndev);
> +failed_rx_irq_request:
> +	napi_disable(&priv->napi);
> +	close_candev(ndev);
> +failed_open:
> +	return err;
> +}
> +
> +static void bxcan_stop(struct net_device *ndev)

please rename to bxcan_chip_stop()
> +{
> +	struct bxcan_priv *priv =3D netdev_priv(ndev);
> +
> +	bxcan_disable_filters(priv->dev->parent, priv->master);

do you have to disable the IRQs?

> +	bxcan_enter_sleep_mode(priv);
> +	priv->can.state =3D CAN_STATE_STOPPED;
> +}
> +
> +static int bxcan_close(struct net_device *ndev)

and this bxcan_stop() to match the .ndo_stop.

> +{
> +	struct bxcan_priv *priv =3D netdev_priv(ndev);
> +
> +	netif_stop_queue(ndev);
> +	bxcan_stop(ndev);
> +	free_irq(ndev->irq, ndev);
> +	free_irq(priv->tx_irq, ndev);
> +	free_irq(priv->sce_irq, ndev);
> +	napi_disable(&priv->napi);
> +	close_candev(ndev);
> +	return 0;
> +}
> +
> +static netdev_tx_t bxcan_start_xmit(struct sk_buff *skb,
> +				    struct net_device *ndev)
> +{
> +	struct bxcan_priv *priv =3D netdev_priv(ndev);
> +	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	struct bxcan_regs __iomem *regs =3D priv->regs;
> +	struct bxcan_mb __iomem *mb_regs;
> +	unsigned int idx;
> +	u32 id;
> +	int i, j;
> +
> +	if (can_dropped_invalid_skb(ndev, skb))
> +		return NETDEV_TX_OK;
> +
> +	if (bxcan_tx_busy(priv))
> +		return NETDEV_TX_BUSY;
> +
> +	idx =3D bxcan_get_tx_head(priv);
> +	priv->tx_head++;
> +	if (bxcan_get_tx_free(priv) =3D=3D 0)
> +		netif_stop_queue(ndev);
> +
> +	mb_regs =3D &regs->tx_mb[idx];
> +	if (cf->can_id & CAN_EFF_FLAG)
> +		id =3D BXCAN_TIxR_EXID(cf->can_id & CAN_EFF_MASK) |
> +			BXCAN_TIxR_IDE;
> +	else
> +		id =3D BXCAN_TIxR_STID(cf->can_id & CAN_SFF_MASK);
> +
> +	if (cf->can_id & CAN_RTR_FLAG)
> +		id |=3D BXCAN_TIxR_RTR;
> +
> +	bxcan_rmw(&mb_regs->dlc, BXCAN_TDTxR_DLC_MASK,
> +		  BXCAN_TDTxR_DLC(cf->len));

Is rmw needed here, or does a pure write work, too?

> +	can_put_echo_skb(skb, ndev, idx, 0);
> +
> +	for (i =3D 0, j =3D 0; i < cf->len; i +=3D 4, j++)
> +		writel(*(u32 *)(cf->data + i), &mb_regs->data[j]);
> +
> +	/* Start transmission */
> +	writel(id | BXCAN_TIxR_TXRQ, &mb_regs->id);
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +static const struct net_device_ops bxcan_netdev_ops =3D {
> +	.ndo_open =3D bxcan_open,
> +	.ndo_stop =3D bxcan_close,
> +	.ndo_start_xmit =3D bxcan_start_xmit,
> +	.ndo_change_mtu =3D can_change_mtu,
> +};
> +
> +static void bxcan_rx_pkt(struct net_device *ndev,
> +			 struct bxcan_mb __iomem *mb_regs)
> +{
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	u32 id, dlc;
> +
> +	skb =3D alloc_can_skb(ndev, &cf);
> +	if (!skb) {
> +		stats->rx_dropped++;
> +		return;
> +	}
> +
> +	id =3D readl(&mb_regs->id);
> +	if (id & BXCAN_RIxR_IDE)
> +		cf->can_id =3D (id >> BXCAN_RIxR_EXID_SHIFT) | CAN_EFF_FLAG;
> +	else
> +		cf->can_id =3D (id >> BXCAN_RIxR_STID_SHIFT) & CAN_SFF_MASK;
> +
> +	dlc =3D readl(&mb_regs->dlc) & BXCAN_RDTxR_DLC;
> +	cf->len =3D can_cc_dlc2len(dlc);
> +
> +	if (id & BXCAN_RIxR_RTR) {
> +		cf->can_id |=3D CAN_RTR_FLAG;
> +	} else {
> +		int i, j;
> +
> +		for (i =3D 0, j =3D 0; i < cf->len; i +=3D 4, j++)
> +			*(u32 *)(cf->data + i) =3D readl(&mb_regs->data[j]);
> +
> +		stats->rx_bytes +=3D cf->len;
> +	}
> +
> +	stats->rx_packets++;
> +	netif_receive_skb(skb);
> +}
> +
> +static int bxcan_rx_poll(struct napi_struct *napi, int quota)
> +{
> +	struct net_device *ndev =3D napi->dev;
> +	struct bxcan_priv *priv =3D netdev_priv(ndev);
> +	struct bxcan_regs __iomem *regs =3D priv->regs;
> +	int num_pkts;
> +	u32 rf0r;
> +
> +	for (num_pkts =3D 0; num_pkts < quota; num_pkts++) {
> +		rf0r =3D readl(&regs->rf0r);
> +		if (!(rf0r & BXCAN_RF0R_FMP0))
> +			break;
> +
> +		bxcan_rx_pkt(ndev, &regs->rx_mb[0]);
> +
> +		rf0r |=3D BXCAN_RF0R_RFOM0;
> +		writel(rf0r, &regs->rf0r);
> +	}
> +
> +	if (num_pkts < quota) {
> +		napi_complete_done(napi, num_pkts);
> +		bxcan_rmw(&regs->ier, 0, BXCAN_IER_FMPIE0);
> +	}
> +
> +	return num_pkts;
> +}
> +
> +static int bxcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
> +{
> +	int err;
> +
> +	switch (mode) {
> +	case CAN_MODE_START:
> +		err =3D bxcan_start(ndev);
> +		if (err)
> +			return err;
> +
> +		netif_wake_queue(ndev);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bxcan_disable_clks(struct bxcan_priv *priv)
> +{
> +	if (priv->clk)
> +		clk_disable_unprepare(priv->clk);
> +
> +	bxcan_disable_master_clk(priv->dev->parent);
> +	return 0;
> +}
> +
> +static int bxcan_enable_clks(struct bxcan_priv *priv)
> +{
> +	int err;
> +
> +	err =3D bxcan_enable_master_clk(priv->dev->parent);
> +	if (err)
> +		return err;
> +
> +	if (priv->clk) {
> +		err =3D clk_prepare_enable(priv->clk);

clk_prepare_enable() works on NULL pointer, too.

> +		if (err)
> +			bxcan_disable_master_clk(priv->dev->parent);
> +	}
> +
> +	return err;
> +}
> +
> +static int bxcan_get_berr_counter(const struct net_device *ndev,
> +				  struct can_berr_counter *bec)
> +{
> +	struct bxcan_priv *priv =3D netdev_priv(ndev);
> +	struct bxcan_regs __iomem *regs =3D priv->regs;
> +	u32 esr;
> +	int err;
> +
> +	err =3D bxcan_enable_clks(priv);
> +	if (err)
> +		return err;
> +
> +	esr =3D readl(&regs->esr);
> +	bec->txerr =3D BXCAN_TEC(esr);
> +	bec->rxerr =3D BXCAN_REC(esr);
> +	err =3D bxcan_disable_clks(priv);
> +	return 0;
> +}
> +
> +static int bxcan_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct device *dev =3D &pdev->dev;
> +	struct net_device *ndev;
> +	struct bxcan_priv *priv;
> +	struct clk *clk =3D NULL;
> +	bool master;
> +	u32 offset;
> +	int err, rx_irq, tx_irq, sce_irq;
> +
> +	master =3D of_property_read_bool(np, "st,can-master");
> +	if (!master) {
> +		clk =3D devm_clk_get(dev, NULL);
> +		if (IS_ERR(clk)) {
> +			dev_err(dev, "failed to get clock\n");
> +			return PTR_ERR(clk);
> +		}
> +	}
> +
> +	rx_irq =3D platform_get_irq_byname(pdev, "rx0");
> +	if (rx_irq < 0) {
> +		dev_err(dev, "failed to get rx0 irq\n");
> +		return rx_irq;
> +	}
> +
> +	tx_irq =3D platform_get_irq_byname(pdev, "tx");
> +	if (tx_irq < 0) {
> +		dev_err(dev, "failed to get tx irq\n");
> +		return tx_irq;
> +	}
> +
> +	sce_irq =3D platform_get_irq_byname(pdev, "sce");
> +	if (sce_irq < 0) {
> +		dev_err(dev, "failed to get sce irq\n");
> +		return sce_irq;
> +	}
> +
> +	err =3D of_property_read_u32(np, "reg", &offset);
> +	if (err) {
> +		dev_err(dev, "failed to get reg property\n");
> +		return err;
> +	}
> +
> +	ndev =3D alloc_candev(sizeof(struct bxcan_priv), BXCAN_TX_MB_NUM);
> +	if (!ndev) {
> +		dev_err(dev, "alloc_candev() failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	priv =3D netdev_priv(ndev);
> +	platform_set_drvdata(pdev, ndev);
> +	SET_NETDEV_DEV(ndev, dev);
> +	ndev->netdev_ops =3D &bxcan_netdev_ops;
> +	ndev->irq =3D rx_irq;
> +	ndev->flags |=3D IFF_ECHO;
> +
> +	priv->dev =3D dev;
> +	priv->ndev =3D ndev;
> +	priv->regs =3D bxcan_get_base_addr(dev->parent) + offset;
> +	priv->clk =3D clk;
> +	priv->tx_irq =3D tx_irq;
> +	priv->sce_irq =3D sce_irq;
> +	priv->master =3D master;
> +	priv->can.clock.freq =3D
> +		master ? bxcan_get_master_clk_rate(dev->parent) :
> +		clk_get_rate(clk);
> +	priv->tx_head =3D 0;
> +	priv->tx_tail =3D 0;
> +	priv->can.bittiming_const =3D &bxcan_bittiming_const;
> +	priv->can.do_set_mode =3D bxcan_do_set_mode;
> +	priv->can.do_get_berr_counter =3D bxcan_get_berr_counter;
> +	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
> +		CAN_CTRLMODE_LISTENONLY	| CAN_CTRLMODE_BERR_REPORTING;
> +	netif_napi_add(ndev, &priv->napi, bxcan_rx_poll, BXCAN_NAPI_WEIGHT);
> +
> +	err =3D bxcan_enable_clks(priv);
> +	if (err) {
> +		dev_err(dev, "failed to enable clocks\n");
> +		return err;
> +	}
> +
> +	err =3D register_candev(ndev);
> +	if (err) {
> +		dev_err(dev, "failed to register netdev\n");
> +		goto failed_register;
> +	}
> +
> +	dev_info(dev, "clk: %d Hz, IRQs: %d, %d, %d\n", priv->can.clock.freq,
> +		 tx_irq, rx_irq, sce_irq);
> +	return 0;
> +
> +failed_register:
> +	netif_napi_del(&priv->napi);
> +	free_candev(ndev);
> +	return err;
> +}
> +
> +static int bxcan_remove(struct platform_device *pdev)
> +{
> +	struct net_device *ndev =3D platform_get_drvdata(pdev);
> +	struct bxcan_priv *priv =3D netdev_priv(ndev);
> +
> +	unregister_candev(ndev);
> +	bxcan_disable_clks(priv);
> +	netif_napi_del(&priv->napi);
> +	free_candev(ndev);
> +	return 0;
> +}
> +
> +static int __maybe_unused bxcan_suspend(struct device *dev)
> +{
> +	struct net_device *ndev =3D dev_get_drvdata(dev);
> +	struct bxcan_priv *priv =3D netdev_priv(ndev);
> +
> +	if (!netif_running(ndev))
> +		return 0;
> +
> +	netif_stop_queue(ndev);
> +	netif_device_detach(ndev);
> +
> +	bxcan_enter_sleep_mode(priv);
> +	priv->can.state =3D CAN_STATE_SLEEPING;
> +	bxcan_disable_clks(priv);
> +	return 0;
> +}
> +
> +static int __maybe_unused bxcan_resume(struct device *dev)
> +{
> +	struct net_device *ndev =3D dev_get_drvdata(dev);
> +	struct bxcan_priv *priv =3D netdev_priv(ndev);
> +
> +	if (!netif_running(ndev))
> +		return 0;
> +
> +	bxcan_enable_clks(priv);
> +	bxcan_leave_sleep_mode(priv);
> +	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +
> +	netif_device_attach(ndev);
> +	netif_start_queue(ndev);
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(bxcan_pm_ops, bxcan_suspend, bxcan_resume);
> +
> +static const struct of_device_id bxcan_of_match[] =3D {
> +	{.compatible =3D "st,stm32f4-bxcan"},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, bxcan_of_match);
> +
> +static struct platform_driver bxcan_driver =3D {
> +	.driver =3D {
> +		.name =3D KBUILD_MODNAME,
> +		.pm =3D &bxcan_pm_ops,
> +		.of_match_table =3D bxcan_of_match,
> +	},
> +	.probe =3D bxcan_probe,
> +	.remove =3D bxcan_remove,
> +};
> +
> +module_platform_driver(bxcan_driver);
> +
> +MODULE_AUTHOR("Dario Binacchi <dario.binacchi@amarulasolutions.com>");
> +MODULE_DESCRIPTION("STMicroelectronics Basic Extended CAN controller dri=
ver");
> +MODULE_LICENSE("GPL");
> --=20
> 2.32.0
>=20
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jhjhxecelkgx3kxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMXI4QACgkQrX5LkNig
0112QwgAnW8SYvfq6Da4ddE/ospW1F+u7y4rRrojKs0oZeCiNyIg3LXMv6YN/LBm
3elpSVd8euCvl2on1b52RGNz40vgcA0PL78vGMjRybCbeq+NO1KHRTY+Fq2x0gtu
EVHd8qllO4JOBAodgSbPSfWnkMyOPdkz+DFqBoXlcCsN+vnvCb9qOucSLo1hBx9e
9Yu6RMU7lJZqrJjfXhpwPLDiDdpKZJYI2oH3mgEJaRNXFZ8WrRhvZDquzAmVkqv4
hL/BSpg5jYtWlVyl7iOW2PFZ2buxQckot35m1tShaPf5gQhsB3hgGScUzku52e1n
fzpWurMXwMQ9QQnKtXCvG4p9cy5p8w==
=nECB
-----END PGP SIGNATURE-----

--jhjhxecelkgx3kxs--
