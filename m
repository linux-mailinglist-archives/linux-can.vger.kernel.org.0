Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E67484F35
	for <lists+linux-can@lfdr.de>; Wed,  5 Jan 2022 09:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiAEIWY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jan 2022 03:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiAEIWW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jan 2022 03:22:22 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F2EC061761
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 00:22:21 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u22so64667174lju.7
        for <linux-can@vger.kernel.org>; Wed, 05 Jan 2022 00:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9nTJqjlcR0ctXYr50vd3NazlR23QH3czPb6sqlThlo=;
        b=mahJQfoOL3/jEEglm3CwHXDGpfekaBssIe9WpqyJEICEzZhDpQkuapjH8GScFb9QVO
         drd8YKFVjJg3Wcvg/CdEcwo8PUJSGlrllCPMKU82E4PuoT5Nl/sQbpyRRjIdbDbDoFmW
         JvtDtNEBnbTv5JYpblaS5LlsLxdO1odio9ShU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9nTJqjlcR0ctXYr50vd3NazlR23QH3czPb6sqlThlo=;
        b=4fMymjOjVtkPgDGjELWl4c7MujLel7jz8DQ8vWsXvYj9XhYAnymATyoX6dHwq1E+un
         24zM0yhcakAcOD1W+dDZRC9HSVLwDVzZLjqx3LjARm/HTm4RKMCJZJOaTynHYqnNKht4
         fV3Xv4vpejPYiLzY5x5lY1V3Hr9N4NsMcr7Hfw0Or7YTiW4KScbKnE3EnsfqqOsnPSON
         B85EkaBdhwguZYCI5PPIGTQYhqZ63mALcfhFVsspXxUPuPgY3iaqay3EOS7ac3AorbPc
         hFC2OS10uJWCl5X1guWvSKeeThxqVnmZmZI6fRJQZJX6clebvamt0rkNDY/fhFwGrZit
         ae8w==
X-Gm-Message-State: AOAM532XSA+OYSjNTAvF7Otb1oCPKGT5himtWqBkqDyAG3KXCmUki5J4
        DZE44mvngCWKBk7ie3BiYhaospbwhg1xTTcinQLezw==
X-Google-Smtp-Source: ABdhPJzB0QZPoHB1UOYjhSDtHC0F0+viSByk/SYrWSqXIeBq3uUmIcSVuxOn+8YZ8fd3lebqd5NVQvB+Bpnhsc40t54=
X-Received: by 2002:a2e:8688:: with SMTP id l8mr43582831lji.203.1641370939837;
 Wed, 05 Jan 2022 00:22:19 -0800 (PST)
MIME-Version: 1.0
References: <20220104154133.848784-1-mkl@pengutronix.de> <20220104154133.848784-4-mkl@pengutronix.de>
In-Reply-To: <20220104154133.848784-4-mkl@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Wed, 5 Jan 2022 09:22:09 +0100
Message-ID: <CABGWkvrH2DGx2e9a0jAJycQPCW67vZiOstjt-SK=LcpS0kyd5Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] can: flexcan: add ethtool support to change
 rx-fifo setting during runtime
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,
reply all and in plain-text,


On Tue, Jan 4, 2022 at 4:41 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> This patch adds a private flag to the flexcan driver to switch the
> "rx-fifo" setting on and off.
>
> "rx-fifo" on  - the RX FIFO with a depth of 6 CAN frames is used for RX
> "rx-fifo" off - the mailboxes are used for RX, the number of mailboxes
>                 depends on the actual flexcan IP core revision and
>                 if CAN-FD mode is active or not.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Co-developed-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/flexcan/Makefile          |   1 +
>  drivers/net/can/flexcan/flexcan-core.c    |  96 +-----------------
>  drivers/net/can/flexcan/flexcan-ethtool.c |  81 ++++++++++++++++
>  drivers/net/can/flexcan/flexcan.h         | 113 ++++++++++++++++++++++
>  4 files changed, 198 insertions(+), 93 deletions(-)
>  create mode 100644 drivers/net/can/flexcan/flexcan-ethtool.c
>  create mode 100644 drivers/net/can/flexcan/flexcan.h
>
> diff --git a/drivers/net/can/flexcan/Makefile b/drivers/net/can/flexcan/Makefile
> index 25dd1d12b866..89d5695c902e 100644
> --- a/drivers/net/can/flexcan/Makefile
> +++ b/drivers/net/can/flexcan/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_CAN_FLEXCAN) += flexcan.o
>
>  flexcan-objs :=
>  flexcan-objs += flexcan-core.o
> +flexcan-objs += flexcan-ethtool.o
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index 26bf0a0a72f1..ae7c838ff76c 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -15,7 +15,6 @@
>  #include <linux/can/dev.h>
>  #include <linux/can/error.h>
>  #include <linux/can/led.h>
> -#include <linux/can/rx-offload.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/firmware/imx/sci.h>
> @@ -33,6 +32,8 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>
> +#include "flexcan.h"
> +
>  #define DRV_NAME                       "flexcan"
>
>  /* 8 for RX fifo and 2 error handling */
> @@ -206,53 +207,6 @@
>
>  #define FLEXCAN_TIMEOUT_US             (250)
>
> -/* FLEXCAN hardware feature flags
> - *
> - * Below is some version info we got:
> - *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err RTR rece-   FD Mode     MB
> - *                                Filter? connected?  Passive detection  ption in MB Supported?
> - * MCF5441X FlexCAN2  ?               no       yes        no       no       yes           no     16
> - *    MX25  FlexCAN2  03.00.00.00     no        no        no       no        no           no     64
> - *    MX28  FlexCAN2  03.00.04.00    yes       yes        no       no        no           no     64
> - *    MX35  FlexCAN2  03.00.00.00     no        no        no       no        no           no     64
> - *    MX53  FlexCAN2  03.00.00.00    yes        no        no       no        no           no     64
> - *    MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no       yes           no     64
> - *    MX8QM FlexCAN3  03.00.23.00    yes       yes        no       no       yes          yes     64
> - *    MX8MP FlexCAN3  03.00.17.01    yes       yes        no      yes       yes          yes     64
> - *    VF610 FlexCAN3  ?               no       yes        no      yes       yes?          no     64
> - *  LS1021A FlexCAN2  03.00.04.00     no       yes        no       no       yes           no     64
> - *  LX2160A FlexCAN3  03.00.23.00     no       yes        no      yes       yes          yes     64
> - *
> - * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
> - */
> -
> -/* [TR]WRN_INT not connected */
> -#define FLEXCAN_QUIRK_BROKEN_WERR_STATE BIT(1)
> - /* Disable RX FIFO Global mask */
> -#define FLEXCAN_QUIRK_DISABLE_RXFG BIT(2)
> -/* Enable EACEN and RRS bit in ctrl2 */
> -#define FLEXCAN_QUIRK_ENABLE_EACEN_RRS  BIT(3)
> -/* Disable non-correctable errors interrupt and freeze mode */
> -#define FLEXCAN_QUIRK_DISABLE_MECR BIT(4)
> -/* Use timestamp based offloading */
> -#define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP BIT(5)
> -/* No interrupt for error passive */
> -#define FLEXCAN_QUIRK_BROKEN_PERR_STATE BIT(6)
> -/* default to BE register access */
> -#define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN BIT(7)
> -/* Setup stop mode with GPR to support wakeup */
> -#define FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR BIT(8)
> -/* Support CAN-FD mode */
> -#define FLEXCAN_QUIRK_SUPPORT_FD BIT(9)
> -/* support memory detection and correction */
> -#define FLEXCAN_QUIRK_SUPPORT_ECC BIT(10)
> -/* Setup stop mode with SCU firmware to support wakeup */
> -#define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW BIT(11)
> -/* Setup 3 separate interrupts, main, boff and err */
> -#define FLEXCAN_QUIRK_NR_IRQ_3 BIT(12)
> -/* Setup 16 mailboxes */
> -#define FLEXCAN_QUIRK_NR_MB_16 BIT(13)
> -
>  /* Structure of the message buffer */
>  struct flexcan_mb {
>         u32 can_ctrl;
> @@ -339,51 +293,6 @@ struct flexcan_regs {
>
>  static_assert(sizeof(struct flexcan_regs) ==  0x4 * 18 + 0xfb8);
>
> -struct flexcan_devtype_data {
> -       u32 quirks;             /* quirks needed for different IP cores */
> -};
> -
> -struct flexcan_stop_mode {
> -       struct regmap *gpr;
> -       u8 req_gpr;
> -       u8 req_bit;
> -};
> -
> -struct flexcan_priv {
> -       struct can_priv can;
> -       struct can_rx_offload offload;
> -       struct device *dev;
> -
> -       struct flexcan_regs __iomem *regs;
> -       struct flexcan_mb __iomem *tx_mb;
> -       struct flexcan_mb __iomem *tx_mb_reserved;
> -       u8 tx_mb_idx;
> -       u8 mb_count;
> -       u8 mb_size;
> -       u8 clk_src;     /* clock source of CAN Protocol Engine */
> -       u8 scu_idx;
> -
> -       u64 rx_mask;
> -       u64 tx_mask;
> -       u32 reg_ctrl_default;
> -
> -       struct clk *clk_ipg;
> -       struct clk *clk_per;
> -       struct flexcan_devtype_data devtype_data;
> -       struct regulator *reg_xceiver;
> -       struct flexcan_stop_mode stm;
> -
> -       int irq_boff;
> -       int irq_err;
> -
> -       /* IPC handle when setup stop mode by System Controller firmware(scfw) */
> -       struct imx_sc_ipc *sc_ipc_handle;
> -
> -       /* Read and Write APIs */
> -       u32 (*read)(void __iomem *addr);
> -       void (*write)(u32 val, void __iomem *addr);
> -};
> -
>  static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
>         .quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
>                 FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16,
> @@ -2177,6 +2086,7 @@ static int flexcan_probe(struct platform_device *pdev)
>         SET_NETDEV_DEV(dev, &pdev->dev);
>
>         dev->netdev_ops = &flexcan_netdev_ops;
> +       flexcan_set_ethtool_ops(dev);
>         dev->irq = irq;
>         dev->flags |= IFF_ECHO;
>
> diff --git a/drivers/net/can/flexcan/flexcan-ethtool.c b/drivers/net/can/flexcan/flexcan-ethtool.c
> new file mode 100644
> index 000000000000..cfa0cce1d0cf
> --- /dev/null
> +++ b/drivers/net/can/flexcan/flexcan-ethtool.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) 2022 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
> + * Copyright (c) 2022 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
> + *
> + */
> +
> +#include <linux/ethtool.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/netdevice.h>
> +#include <linux/can/dev.h>
> +
> +#include "flexcan.h"
> +
> +static const char flexcan_priv_flags_strings[][ETH_GSTRING_LEN] = {
> +#define FLEXCAN_PRIV_FLAGS_RX_FIFO BIT(0)
> +       "rx-fifo",
> +};
> +
> +static void
> +flexcan_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
> +{
> +       switch (stringset) {
> +       case ETH_SS_PRIV_FLAGS:
> +               memcpy(data, flexcan_priv_flags_strings,
> +                      sizeof(flexcan_priv_flags_strings));
> +       }
> +}
> +
> +static int flexcan_get_sset_count(struct net_device *netdev, int sset)
> +{
> +       switch (sset) {
> +       case ETH_SS_PRIV_FLAGS:
> +               return ARRAY_SIZE(flexcan_priv_flags_strings);
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +}
> +
> +static u32 flexcan_get_priv_flags(struct net_device *ndev)
> +{
> +       const struct flexcan_priv *priv = netdev_priv(ndev);
> +       const u32 quirks = priv->devtype_data.quirks;
> +       u32 priv_flags;

u32 priv_flags = 0;

regards,
Dario

> +
> +       if (!(quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP))
> +               priv_flags |= FLEXCAN_PRIV_FLAGS_RX_FIFO;
> +
> +       return priv_flags;
> +}
> +
> +static int flexcan_set_priv_flags(struct net_device *ndev, u32 priv_flags)
> +{
> +       struct flexcan_priv *priv = netdev_priv(ndev);
> +       u32 quirks = priv->devtype_data.quirks;
> +
> +       quirks &= ~FLEXCAN_QUIRK_USE_OFF_TIMESTAMP;
> +       if (!(priv_flags & FLEXCAN_PRIV_FLAGS_RX_FIFO))
> +               quirks |= FLEXCAN_QUIRK_USE_OFF_TIMESTAMP;
> +
> +       if (quirks != priv->devtype_data.quirks &&
> +           netif_running(ndev)) {
> +               return -EBUSY;
> +       }
> +
> +       priv->devtype_data.quirks = quirks;
> +
> +       return 0;
> +}
> +
> +static const struct ethtool_ops flexcan_ethtool_ops = {
> +       .get_sset_count = flexcan_get_sset_count,
> +       .get_strings = flexcan_get_strings,
> +       .get_priv_flags = flexcan_get_priv_flags,
> +       .set_priv_flags = flexcan_set_priv_flags,
> +};
> +
> +void flexcan_set_ethtool_ops(struct net_device *netdev)
> +{
> +       netdev->ethtool_ops = &flexcan_ethtool_ops;
> +}
> diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
> new file mode 100644
> index 000000000000..e64b9f6c1041
> --- /dev/null
> +++ b/drivers/net/can/flexcan/flexcan.h
> @@ -0,0 +1,113 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + * flexcan.c - FLEXCAN CAN controller driver
> + *
> + * Copyright (c) 2005-2006 Varma Electronics Oy
> + * Copyright (c) 2009 Sascha Hauer, Pengutronix
> + * Copyright (c) 2010-2017 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
> + * Copyright (c) 2014 David Jander, Protonic Holland
> + * Copyright (C) 2022 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
> + *
> + * Based on code originally by Andrey Volkov <avolkov@varma-el.com>
> + *
> + */
> +
> +#ifndef _FLEXCAN_H
> +#define _FLEXCAN_H
> +
> +#include <linux/can/rx-offload.h>
> +
> +/* FLEXCAN hardware feature flags
> + *
> + * Below is some version info we got:
> + *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err RTR rece-   FD Mode     MB
> + *                                Filter? connected?  Passive detection  ption in MB Supported?
> + * MCF5441X FlexCAN2  ?               no       yes        no       no       yes           no     16
> + *    MX25  FlexCAN2  03.00.00.00     no        no        no       no        no           no     64
> + *    MX28  FlexCAN2  03.00.04.00    yes       yes        no       no        no           no     64
> + *    MX35  FlexCAN2  03.00.00.00     no        no        no       no        no           no     64
> + *    MX53  FlexCAN2  03.00.00.00    yes        no        no       no        no           no     64
> + *    MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no       yes           no     64
> + *    MX8QM FlexCAN3  03.00.23.00    yes       yes        no       no       yes          yes     64
> + *    MX8MP FlexCAN3  03.00.17.01    yes       yes        no      yes       yes          yes     64
> + *    VF610 FlexCAN3  ?               no       yes        no      yes       yes?          no     64
> + *  LS1021A FlexCAN2  03.00.04.00     no       yes        no       no       yes           no     64
> + *  LX2160A FlexCAN3  03.00.23.00     no       yes        no      yes       yes          yes     64
> + *
> + * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
> + */
> +
> +/* [TR]WRN_INT not connected */
> +#define FLEXCAN_QUIRK_BROKEN_WERR_STATE BIT(1)
> + /* Disable RX FIFO Global mask */
> +#define FLEXCAN_QUIRK_DISABLE_RXFG BIT(2)
> +/* Enable EACEN and RRS bit in ctrl2 */
> +#define FLEXCAN_QUIRK_ENABLE_EACEN_RRS  BIT(3)
> +/* Disable non-correctable errors interrupt and freeze mode */
> +#define FLEXCAN_QUIRK_DISABLE_MECR BIT(4)
> +/* Use timestamp based offloading */
> +#define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP BIT(5)
> +/* No interrupt for error passive */
> +#define FLEXCAN_QUIRK_BROKEN_PERR_STATE BIT(6)
> +/* default to BE register access */
> +#define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN BIT(7)
> +/* Setup stop mode with GPR to support wakeup */
> +#define FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR BIT(8)
> +/* Support CAN-FD mode */
> +#define FLEXCAN_QUIRK_SUPPORT_FD BIT(9)
> +/* support memory detection and correction */
> +#define FLEXCAN_QUIRK_SUPPORT_ECC BIT(10)
> +/* Setup stop mode with SCU firmware to support wakeup */
> +#define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW BIT(11)
> +/* Setup 3 separate interrupts, main, boff and err */
> +#define FLEXCAN_QUIRK_NR_IRQ_3 BIT(12)
> +/* Setup 16 mailboxes */
> +#define FLEXCAN_QUIRK_NR_MB_16 BIT(13)
> +
> +struct flexcan_devtype_data {
> +       u32 quirks;             /* quirks needed for different IP cores */
> +};
> +
> +struct flexcan_stop_mode {
> +       struct regmap *gpr;
> +       u8 req_gpr;
> +       u8 req_bit;
> +};
> +
> +struct flexcan_priv {
> +       struct can_priv can;
> +       struct can_rx_offload offload;
> +       struct device *dev;
> +
> +       struct flexcan_regs __iomem *regs;
> +       struct flexcan_mb __iomem *tx_mb;
> +       struct flexcan_mb __iomem *tx_mb_reserved;
> +       u8 tx_mb_idx;
> +       u8 mb_count;
> +       u8 mb_size;
> +       u8 clk_src;     /* clock source of CAN Protocol Engine */
> +       u8 scu_idx;
> +
> +       u64 rx_mask;
> +       u64 tx_mask;
> +       u32 reg_ctrl_default;
> +
> +       struct clk *clk_ipg;
> +       struct clk *clk_per;
> +       struct flexcan_devtype_data devtype_data;
> +       struct regulator *reg_xceiver;
> +       struct flexcan_stop_mode stm;
> +
> +       int irq_boff;
> +       int irq_err;
> +
> +       /* IPC handle when setup stop mode by System Controller firmware(scfw) */
> +       struct imx_sc_ipc *sc_ipc_handle;
> +
> +       /* Read and Write APIs */
> +       u32 (*read)(void __iomem *addr);
> +       void (*write)(u32 val, void __iomem *addr);
> +};
> +
> +void flexcan_set_ethtool_ops(struct net_device *dev);
> +
> +#endif /* _FLEXCAN_H */
> --
> 2.34.1
>
>


-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
