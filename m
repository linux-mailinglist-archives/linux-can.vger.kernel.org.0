Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3825E580DCF
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 09:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiGZHds (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 03:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbiGZHdf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 03:33:35 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2E32B620
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 00:29:27 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e11so15589437ljl.4
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 00:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kp4/7dQDCVHPfwCueHUknNsjKwnWOkf7cQ/FltUvyEQ=;
        b=B6E4B5a4Ry7FnvoOSSXp+/kSHzD2oL3BGEGVC1PHnf7FVLO6+07k20MVXYqmx+WmaU
         I0vzX8GWBzb0QVNGnmU2KvFI89kabrQEQ9FUihjDa/rxOturrfLJibMTELDR6fH+N1mq
         pjl8r0Widag3H5S+yi/Dz4ahZK10mdjaXLUqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kp4/7dQDCVHPfwCueHUknNsjKwnWOkf7cQ/FltUvyEQ=;
        b=etERR5eT5TGHse7ymXerMu79MG061y3c6gyM1QSvpkpbUKQn2TKIhnHvzkBTGZDqdE
         7RRgT2xTd/esn2Esh4Pxmt2evhfZb+LEs5fg5elJdeKAEb988YsI24M0zceP0UtRiTpO
         AO9fUzune3lg4lmo7IDgb+nUSEcIpmyFm8RId9p6eICfQTom+GKEqXU0ZTyooopSiqgo
         twmYrl592AR/922Gd1w+BJcRjxzF+Qmzg39sz9fH4jVT17P4Ti8CHeRgu9Jp1oB4IyTD
         ov2lo+1bJhBD+SFM7hghl8UvErumog2R8V+g6VcjhL1B/KdPwoPIAcA+ctWAIQC4hEZF
         eblg==
X-Gm-Message-State: AJIora/UdF+eDGXfLRY6nOMDtx6CMVNRb7Up7Qn6vBa2i4oJQQ5Zb+jf
        3ZfM6TTVhKBVD5t8u9bjK+B7zcB4EaMckRo17wzz4g==
X-Google-Smtp-Source: AGRyM1t3mi+whP90V0jO8hI7urdTR31slp5zsRPgzgL5SKu1ZHUyp05ufYYLZCTKvQ3+JrFAGSlaKuB8jtLKEK9b8mA=
X-Received: by 2002:a05:651c:897:b0:25d:e574:b64 with SMTP id
 d23-20020a05651c089700b0025de5740b64mr5530932ljq.203.1658820565292; Tue, 26
 Jul 2022 00:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr> <20220725133208.432176-11-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220725133208.432176-11-mailhol.vincent@wanadoo.fr>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Tue, 26 Jul 2022 09:29:14 +0200
Message-ID: <CABGWkvoqkETb0H-UWhwPCk1eMwQC2ExfKUXm25Mv4R5g0kjb+Q@mail.gmail.com>
Subject: Re: [PATCH v1 10/24] can: tree-wide: implement ethtool_ops::get_drvinfo()
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Max Staudt <max@enpas.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

On Mon, Jul 25, 2022 at 3:32 PM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> For all CAN drivers, implement the get_drvinfo() function.
>
> After this patch, it is now possible to retrieve basic information by
> doing:
>
> | $ ethtool -i canX
>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/at91_can.c                       | 12 ++++++++++++
>  drivers/net/can/c_can/c_can_main.c               | 12 ++++++++++++
>  drivers/net/can/can327.c                         | 11 +++++++++++
>  drivers/net/can/cc770/cc770.c                    | 12 ++++++++++++
>  drivers/net/can/ctucanfd/ctucanfd_base.c         | 12 ++++++++++++
>  drivers/net/can/flexcan/flexcan-core.c           | 12 ++++++++++++
>  drivers/net/can/grcan.c                          | 12 ++++++++++++
>  drivers/net/can/ifi_canfd/ifi_canfd.c            | 12 ++++++++++++
>  drivers/net/can/janz-ican3.c                     | 12 ++++++++++++
>  drivers/net/can/kvaser_pciefd.c                  | 12 ++++++++++++
>  drivers/net/can/m_can/m_can.c                    | 12 ++++++++++++
>  drivers/net/can/mscan/mscan.c                    |  1 +
>  drivers/net/can/pch_can.c                        | 12 ++++++++++++
>  drivers/net/can/peak_canfd/peak_canfd.c          | 12 ++++++++++++
>  drivers/net/can/rcar/rcar_can.c                  | 12 ++++++++++++
>  drivers/net/can/rcar/rcar_canfd.c                | 12 ++++++++++++
>  drivers/net/can/sja1000/sja1000.c                | 12 ++++++++++++
>  drivers/net/can/slcan/slcan-core.c               | 12 ++++++++++++
>  drivers/net/can/softing/softing_main.c           | 12 ++++++++++++
>  drivers/net/can/spi/hi311x.c                     | 12 ++++++++++++
>  drivers/net/can/spi/mcp251x.c                    | 12 ++++++++++++
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c   | 12 ++++++++++++
>  drivers/net/can/sun4i_can.c                      | 12 ++++++++++++
>  drivers/net/can/ti_hecc.c                        | 12 ++++++++++++
>  drivers/net/can/usb/ems_usb.c                    | 12 ++++++++++++
>  drivers/net/can/usb/esd_usb.c                    | 12 ++++++++++++
>  drivers/net/can/usb/etas_es58x/es58x_core.c      | 12 ++++++++++++
>  drivers/net/can/usb/gs_usb.c                     |  8 ++++++++
>  drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 12 ++++++++++++
>  drivers/net/can/usb/mcba_usb.c                   | 12 ++++++++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c     |  6 ++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h     |  2 ++
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c       |  1 +
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c      |  1 +
>  drivers/net/can/usb/ucan.c                       | 12 ++++++++++++
>  drivers/net/can/usb/usb_8dev.c                   | 12 ++++++++++++
>  drivers/net/can/vcan.c                           | 12 ++++++++++++
>  drivers/net/can/vxcan.c                          | 12 ++++++++++++
>  drivers/net/can/xilinx_can.c                     | 12 ++++++++++++
>  39 files changed, 414 insertions(+)
>
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index 29ed0d3cd171..637d2ca34d08 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/errno.h>
> +#include <linux/ethtool.h>
>  #include <linux/if_arp.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -1152,6 +1153,16 @@ static const struct net_device_ops at91_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void at91_get_drvinfo(struct net_device *netdev,
> +                            struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops at91_ethtool_ops = {
> +       .get_drvinfo = at91_get_drvinfo,
> +};
> +
>  static ssize_t mb0_id_show(struct device *dev,
>                            struct device_attribute *attr, char *buf)
>  {
> @@ -1293,6 +1304,7 @@ static int at91_can_probe(struct platform_device *pdev)
>         }
>
>         dev->netdev_ops = &at91_netdev_ops;
> +       dev->ethtool_ops = &at91_ethtool_ops;
>         dev->irq = irq;
>         dev->flags |= IFF_ECHO;
>
> diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
> index de38d8f7b5f7..fa541a7cb9c1 100644
> --- a/drivers/net/can/c_can/c_can_main.c
> +++ b/drivers/net/can/c_can/c_can_main.c
> @@ -29,6 +29,7 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> +#include <linux/ethtool.h>
>  #include <linux/netdevice.h>
>  #include <linux/if_arp.h>
>  #include <linux/if_ether.h>
> @@ -1353,6 +1354,16 @@ static const struct net_device_ops c_can_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void c_can_get_drvinfo(struct net_device *netdev,
> +                             struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops c_can_ethtool_ops = {
> +       .get_drvinfo = c_can_get_drvinfo,
> +};
> +
>  int register_c_can_dev(struct net_device *dev)
>  {
>         /* Deactivate pins to prevent DRA7 DCAN IP from being
> @@ -1364,6 +1375,7 @@ int register_c_can_dev(struct net_device *dev)
>
>         dev->flags |= IFF_ECHO; /* we support local echo */
>         dev->netdev_ops = &c_can_netdev_ops;
> +       dev->ethtool_ops = &c_can_ethtool_ops;
>         c_can_set_ethtool_ops(dev);
>
>         return register_candev(dev);
> diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
> index bf0cce2dbb40..03c9e8c6990d 100644
> --- a/drivers/net/can/can327.c
> +++ b/drivers/net/can/can327.c
> @@ -848,6 +848,16 @@ static const struct net_device_ops can327_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void can327_get_drvinfo(struct net_device *netdev,
> +                              struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops can327_ethtool_ops = {
> +       .get_drvinfo = can327_get_drvinfo,
> +};
> +
>  static bool can327_is_valid_rx_char(u8 c)
>  {
>         static const bool lut_char_is_valid['z'] = {
> @@ -1032,6 +1042,7 @@ static int can327_ldisc_open(struct tty_struct *tty)
>         /* Configure netdev interface */
>         elm->dev = dev;
>         dev->netdev_ops = &can327_netdev_ops;
> +       dev->ethtool_ops = &can327_ethtool_ops;
>
>         /* Mark ldisc channel as alive */
>         elm->tty = tty;
> diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
> index 797a954bb1a0..1bb30e69cb24 100644
> --- a/drivers/net/can/cc770/cc770.c
> +++ b/drivers/net/can/cc770/cc770.c
> @@ -17,6 +17,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/string.h>
>  #include <linux/errno.h>
> +#include <linux/ethtool.h>
>  #include <linux/netdevice.h>
>  #include <linux/if_arp.h>
>  #include <linux/if_ether.h>
> @@ -836,6 +837,16 @@ static const struct net_device_ops cc770_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void cc770_get_drvinfo(struct net_device *netdev,
> +                             struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops cc770_ethtool_ops = {
> +       .get_drvinfo = cc770_get_drvinfo,
> +};
> +
>  int register_cc770dev(struct net_device *dev)
>  {
>         struct cc770_priv *priv = netdev_priv(dev);
> @@ -846,6 +857,7 @@ int register_cc770dev(struct net_device *dev)
>                 return err;
>
>         dev->netdev_ops = &cc770_netdev_ops;
> +       dev->ethtool_ops = &cc770_ethtool_ops;
>
>         dev->flags |= IFF_ECHO; /* we support local echo */
>
> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
> index 6b281f6eb9b4..fd5fd17c16f2 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> @@ -19,6 +19,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/errno.h>
> +#include <linux/ethtool.h>
>  #include <linux/init.h>
>  #include <linux/bitfield.h>
>  #include <linux/interrupt.h>
> @@ -1301,6 +1302,16 @@ static const struct net_device_ops ctucan_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void ctucan_get_drvinfo(struct net_device *netdev,
> +                              struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops ctucan_ethtool_ops = {
> +       .get_drvinfo = ctucan_get_drvinfo,
> +};
> +
>  int ctucan_suspend(struct device *dev)
>  {
>         struct net_device *ndev = dev_get_drvdata(dev);
> @@ -1377,6 +1388,7 @@ int ctucan_probe_common(struct device *dev, void __iomem *addr, int irq, unsigne
>                 set_drvdata_fnc(dev, ndev);
>         SET_NETDEV_DEV(ndev, dev);
>         ndev->netdev_ops = &ctucan_netdev_ops;
> +       ndev->ethtool_ops = &ctucan_ethtool_ops;
>
>         /* Getting the can_clk info */
>         if (!can_clk_rate) {
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index d060088047f1..61e3483802c6 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -16,6 +16,7 @@
>  #include <linux/can/error.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/ethtool.h>
>  #include <linux/firmware/imx/sci.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -1813,6 +1814,16 @@ static const struct net_device_ops flexcan_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void flexcan_get_drvinfo(struct net_device *netdev,
> +                               struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops flexcan_ethtool_ops = {
> +       .get_drvinfo = flexcan_get_drvinfo,
> +};
> +
>  static int register_flexcandev(struct net_device *dev)
>  {
>         struct flexcan_priv *priv = netdev_priv(dev);
> @@ -2113,6 +2124,7 @@ static int flexcan_probe(struct platform_device *pdev)
>         SET_NETDEV_DEV(dev, &pdev->dev);
>
>         dev->netdev_ops = &flexcan_netdev_ops;
> +       dev->ethtool_ops = &flexcan_ethtool_ops;
>         flexcan_set_ethtool_ops(dev);
>         dev->irq = irq;
>         dev->flags |= IFF_ECHO;
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index 24035a6187c9..ce64f2cbe9c6 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -27,6 +27,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/netdevice.h>
>  #include <linux/delay.h>
> +#include <linux/ethtool.h>
>  #include <linux/io.h>
>  #include <linux/can/dev.h>
>  #include <linux/spinlock.h>
> @@ -1561,6 +1562,16 @@ static const struct net_device_ops grcan_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void grcan_get_drvinfo(struct net_device *netdev,
> +                             struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops grcan_ethtool_ops = {
> +       .get_drvinfo = grcan_get_drvinfo,
> +};
> +
>  static int grcan_setup_netdev(struct platform_device *ofdev,
>                               void __iomem *base,
>                               int irq, u32 ambafreq, bool txbug)
> @@ -1577,6 +1588,7 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
>         dev->irq = irq;
>         dev->flags |= IFF_ECHO;
>         dev->netdev_ops = &grcan_netdev_ops;
> +       dev->ethtool_ops = &grcan_ethtool_ops;
>         dev->sysfs_groups[0] = &sysfs_grcan_group;
>
>         priv = netdev_priv(dev);
> diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
> index 64e3be8b73af..c682401eea3d 100644
> --- a/drivers/net/can/ifi_canfd/ifi_canfd.c
> +++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
> @@ -13,6 +13,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/ethtool.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -925,6 +926,16 @@ static const struct net_device_ops ifi_canfd_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void ifi_canfd_get_drvinfo(struct net_device *netdev,
> +                                 struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops ifi_canfd_ethtool_ops = {
> +       .get_drvinfo = ifi_canfd_get_drvinfo,
> +};
> +
>  static int ifi_canfd_plat_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -962,6 +973,7 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
>         ndev->irq = irq;
>         ndev->flags |= IFF_ECHO;        /* we support local echo */
>         ndev->netdev_ops = &ifi_canfd_netdev_ops;
> +       ndev->ethtool_ops = &ifi_canfd_ethtool_ops;
>
>         priv = netdev_priv(ndev);
>         priv->ndev = ndev;
> diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
> index ccb5c5405224..2534364e8be3 100644
> --- a/drivers/net/can/janz-ican3.c
> +++ b/drivers/net/can/janz-ican3.c
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> +#include <linux/ethtool.h>
>  #include <linux/platform_device.h>
>
>  #include <linux/netdevice.h>
> @@ -1752,6 +1753,16 @@ static const struct net_device_ops ican3_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void ican3_get_drvinfo(struct net_device *netdev,
> +                             struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops ican3_ethtool_ops = {
> +       .get_drvinfo = ican3_get_drvinfo,
> +};
> +
>  /*
>   * Low-level CAN Device
>   */
> @@ -1923,6 +1934,7 @@ static int ican3_probe(struct platform_device *pdev)
>         mod->free_page = DPM_FREE_START;
>
>         ndev->netdev_ops = &ican3_netdev_ops;
> +       ndev->ethtool_ops = &ican3_ethtool_ops;
>         ndev->flags |= IFF_ECHO;
>         SET_NETDEV_DEV(ndev, &pdev->dev);
>
> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
> index dcd2c9d50d5e..f7f7a0287a8d 100644
> --- a/drivers/net/can/kvaser_pciefd.c
> +++ b/drivers/net/can/kvaser_pciefd.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> +#include <linux/ethtool.h>
>  #include <linux/pci.h>
>  #include <linux/can/dev.h>
>  #include <linux/timer.h>
> @@ -923,6 +924,16 @@ static const struct net_device_ops kvaser_pciefd_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void kvaser_pciefd_get_drvinfo(struct net_device *netdev,
> +                                     struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KVASER_PCIEFD_DRV_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops kvaser_pciefd_ethtool_ops = {
> +       .get_drvinfo = kvaser_pciefd_get_drvinfo,
> +};
> +
>  static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
>  {
>         int i;
> @@ -939,6 +950,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
>
>                 can = netdev_priv(netdev);
>                 netdev->netdev_ops = &kvaser_pciefd_netdev_ops;
> +               netdev->ethtool_ops = &kvaser_pciefd_ethtool_ops;
>                 can->reg_base = pcie->reg_base + KVASER_PCIEFD_KCAN0_BASE +
>                                 i * KVASER_PCIEFD_KCAN_BASE_OFFSET;
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 713a4b0edf86..dc55bfd260c9 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -9,6 +9,7 @@
>   */
>
>  #include <linux/bitfield.h>
> +#include <linux/ethtool.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -1829,10 +1830,21 @@ static const struct net_device_ops m_can_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void m_can_get_drvinfo(struct net_device *netdev,
> +                             struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops m_can_ethtool_ops = {
> +       .get_drvinfo = m_can_get_drvinfo,
> +};
> +
>  static int register_m_can_dev(struct net_device *dev)
>  {
>         dev->flags |= IFF_ECHO; /* we support local echo */
>         dev->netdev_ops = &m_can_netdev_ops;
> +       dev->ethtool_ops = &m_can_ethtool_ops;
>
>         return register_candev(dev);
>  }
> diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
> index 78a21ab63601..b1677588a4c8 100644
> --- a/drivers/net/can/mscan/mscan.c
> +++ b/drivers/net/can/mscan/mscan.c
> @@ -676,6 +676,7 @@ struct net_device *alloc_mscandev(void)
>         priv = netdev_priv(dev);
>
>         dev->netdev_ops = &mscan_netdev_ops;
> +       dev->ethtool_ops = &mscan_ethtool_ops;
>
>         dev->flags |= IFF_ECHO; /* we support local echo */
>
> diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
> index 32804fed116c..c51354b4cf0c 100644
> --- a/drivers/net/can/pch_can.c
> +++ b/drivers/net/can/pch_can.c
> @@ -6,6 +6,7 @@
>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> +#include <linux/ethtool.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/sched.h>
> @@ -938,6 +939,16 @@ static const struct net_device_ops pch_can_netdev_ops = {
>         .ndo_change_mtu         = can_change_mtu,
>  };
>
> +static void pch_can_get_drvinfo(struct net_device *netdev,
> +                               struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops pch_can_ethtool_ops = {
> +       .get_drvinfo = pch_can_get_drvinfo,
> +};
> +
>  static void pch_can_remove(struct pci_dev *pdev)
>  {
>         struct net_device *ndev = pci_get_drvdata(pdev);
> @@ -1188,6 +1199,7 @@ static int pch_can_probe(struct pci_dev *pdev,
>         pci_set_drvdata(pdev, ndev);
>         SET_NETDEV_DEV(ndev, &pdev->dev);
>         ndev->netdev_ops = &pch_can_netdev_ops;
> +       ndev->ethtool_ops = &pch_can_ethtool_ops;
>         priv->can.clock.freq = PCH_CAN_CLK; /* Hz */
>
>         netif_napi_add_weight(ndev, &priv->napi, pch_can_poll, PCH_RX_OBJ_END);
> diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
> index afb9adb3d5c2..9b94d5b4be2d 100644
> --- a/drivers/net/can/peak_canfd/peak_canfd.c
> +++ b/drivers/net/can/peak_canfd/peak_canfd.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/can.h>
>  #include <linux/can/dev.h>
> +#include <linux/ethtool.h>
>
>  #include "peak_canfd_user.h"
>
> @@ -749,6 +750,16 @@ static const struct net_device_ops peak_canfd_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void peak_canfd_get_drvinfo(struct net_device *netdev,
> +                                  struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops peak_canfd_ethtool_ops = {
> +       .get_drvinfo = peak_canfd_get_drvinfo,
> +};
> +
>  struct net_device *alloc_peak_canfd_dev(int sizeof_priv, int index,
>                                         int echo_skb_max)
>  {
> @@ -789,6 +800,7 @@ struct net_device *alloc_peak_canfd_dev(int sizeof_priv, int index,
>
>         ndev->flags |= IFF_ECHO;
>         ndev->netdev_ops = &peak_canfd_netdev_ops;
> +       ndev->ethtool_ops = &peak_canfd_ethtool_ops;
>         ndev->dev_id = index;
>
>         return ndev;
> diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
> index d11db2112a4a..aa644bb79da6 100644
> --- a/drivers/net/can/rcar/rcar_can.c
> +++ b/drivers/net/can/rcar/rcar_can.c
> @@ -10,6 +10,7 @@
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
>  #include <linux/errno.h>
> +#include <linux/ethtool.h>
>  #include <linux/netdevice.h>
>  #include <linux/platform_device.h>
>  #include <linux/can/dev.h>
> @@ -630,6 +631,16 @@ static const struct net_device_ops rcar_can_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void rcar_can_get_drvinfo(struct net_device *netdev,
> +                                struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, RCAR_CAN_DRV_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops rcar_can_ethtool_ops = {
> +       .get_drvinfo = rcar_can_get_drvinfo,
> +};
> +
>  static void rcar_can_rx_pkt(struct rcar_can_priv *priv)
>  {
>         struct net_device_stats *stats = &priv->ndev->stats;
> @@ -785,6 +796,7 @@ static int rcar_can_probe(struct platform_device *pdev)
>         }
>
>         ndev->netdev_ops = &rcar_can_netdev_ops;
> +       ndev->ethtool_ops = &rcar_can_ethtool_ops;
>         ndev->irq = irq;
>         ndev->flags |= IFF_ECHO;
>         priv->ndev = ndev;
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index d3e569a02b4d..89cc28985b81 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -27,6 +27,7 @@
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
>  #include <linux/errno.h>
> +#include <linux/ethtool.h>
>  #include <linux/netdevice.h>
>  #include <linux/platform_device.h>
>  #include <linux/can/dev.h>
> @@ -1695,6 +1696,16 @@ static const struct net_device_ops rcar_canfd_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void rcar_canfd_get_drvinfo(struct net_device *netdev,
> +                                  struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, RCANFD_DRV_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops rcar_canfd_ethtool_ops = {
> +       .get_drvinfo = rcar_canfd_get_drvinfo,
> +};
> +
>  static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
>                                     u32 fcan_freq)
>  {
> @@ -1711,6 +1722,7 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
>         priv = netdev_priv(ndev);
>
>         ndev->netdev_ops = &rcar_canfd_netdev_ops;
> +       ndev->ethtool_ops = &rcar_canfd_ethtool_ops;
>         ndev->flags |= IFF_ECHO;
>         priv->ndev = ndev;
>         priv->base = gpriv->base;
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
> index 75a2f9bf8c16..43967790f4c1 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -52,6 +52,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/string.h>
>  #include <linux/errno.h>
> +#include <linux/ethtool.h>
>  #include <linux/netdevice.h>
>  #include <linux/if_arp.h>
>  #include <linux/if_ether.h>
> @@ -654,6 +655,16 @@ static const struct net_device_ops sja1000_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void sja1000_get_drvinfo(struct net_device *netdev,
> +                               struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops sja1000_ethtool_ops = {
> +       .get_drvinfo = sja1000_get_drvinfo,
> +};
> +
>  int register_sja1000dev(struct net_device *dev)
>  {
>         int ret;
> @@ -663,6 +674,7 @@ int register_sja1000dev(struct net_device *dev)
>
>         dev->flags |= IFF_ECHO; /* we support local echo */
>         dev->netdev_ops = &sja1000_netdev_ops;
> +       dev->ethtool_ops = &sja1000_ethtool_ops;
>
>         set_reset_mode(dev);
>         chipset_init(dev);
> diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
> index d1562f9474c9..1b86001c85f8 100644
> --- a/drivers/net/can/slcan/slcan-core.c
> +++ b/drivers/net/can/slcan/slcan-core.c
> @@ -46,6 +46,7 @@
>  #include <linux/string.h>
>  #include <linux/tty.h>
>  #include <linux/errno.h>
> +#include <linux/ethtool.h>
>  #include <linux/netdevice.h>
>  #include <linux/skbuff.h>
>  #include <linux/rtnetlink.h>
> @@ -790,6 +791,16 @@ static const struct net_device_ops slc_netdev_ops = {
>         .ndo_change_mtu         = slcan_change_mtu,
>  };
>
> +static void slcan_get_drvinfo(struct net_device *netdev,
> +                             struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
> +}
> +

Please put the function inside the slcan-ethtool.c.

> +static const struct ethtool_ops slcan_ethtool_ops = {
> +       .get_drvinfo = slcan_get_drvinfo,
> +};
> +

slcan_ethtool_ops is is already defined in slcan-ethtool.c

>  /******************************************
>   *  Routines looking at TTY side.
>   ******************************************/
> @@ -869,6 +880,7 @@ static struct slcan *slc_alloc(void)
>
>         snprintf(dev->name, sizeof(dev->name), DRV_NAME "%d", i);
>         dev->netdev_ops = &slc_netdev_ops;
> +       dev->ethtool_ops = &slcan_ethtool_ops;
>         dev->base_addr  = i;
>         slcan_set_ethtool_ops(dev);

It already sets dev->ethtool_ops.

Thanks and regards,
Dario

>         sl = netdev_priv(dev);
> diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
> index d810fe6915a4..d2ce61562ccc 100644
> --- a/drivers/net/can/softing/softing_main.c
> +++ b/drivers/net/can/softing/softing_main.c
> @@ -5,6 +5,7 @@
>   * - Kurt Van Dijck, EIA Electronics
>   */
>
> +#include <linux/ethtool.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <asm/io.h>
> @@ -612,6 +613,16 @@ static const struct net_device_ops softing_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void softing_get_drvinfo(struct net_device *netdev,
> +                               struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops softing_ethtool_ops = {
> +       .get_drvinfo = softing_get_drvinfo,
> +};
> +
>  static const struct can_bittiming_const softing_btr_const = {
>         .name = DRV_NAME,
>         .tseg1_min = 1,
> @@ -650,6 +661,7 @@ static struct net_device *softing_netdev_create(struct softing *card,
>
>         netdev->flags |= IFF_ECHO;
>         netdev->netdev_ops = &softing_netdev_ops;
> +       netdev->ethtool_ops = &softing_ethtool_ops;
>         priv->can.do_set_mode = softing_candev_set_mode;
>         priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;
>
> diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
> index 167114aae6dd..5e0c0d21aee2 100644
> --- a/drivers/net/can/spi/hi311x.c
> +++ b/drivers/net/can/spi/hi311x.c
> @@ -20,6 +20,7 @@
>  #include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/ethtool.h>
>  #include <linux/freezer.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -802,6 +803,16 @@ static const struct net_device_ops hi3110_netdev_ops = {
>         .ndo_start_xmit = hi3110_hard_start_xmit,
>  };
>
> +static void hi3110_get_drvinfo(struct net_device *netdev,
> +                              struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, DEVICE_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops hi3110_ethtool_ops = {
> +       .get_drvinfo = hi3110_get_drvinfo,
> +};
> +
>  static const struct of_device_id hi3110_of_match[] = {
>         {
>                 .compatible     = "holt,hi3110",
> @@ -856,6 +867,7 @@ static int hi3110_can_probe(struct spi_device *spi)
>                 goto out_free;
>
>         net->netdev_ops = &hi3110_netdev_ops;
> +       net->ethtool_ops = &hi3110_ethtool_ops;
>         net->flags |= IFF_ECHO;
>
>         priv = netdev_priv(net);
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index 666a4505a55a..2e4c03c61b15 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -26,6 +26,7 @@
>  #include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/ethtool.h>
>  #include <linux/freezer.h>
>  #include <linux/gpio.h>
>  #include <linux/gpio/driver.h>
> @@ -1248,6 +1249,16 @@ static const struct net_device_ops mcp251x_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void mcp251x_get_drvinfo(struct net_device *netdev,
> +                               struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, DEVICE_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops mcp251x_ethtool_ops = {
> +       .get_drvinfo = mcp251x_get_drvinfo,
> +};
> +
>  static const struct of_device_id mcp251x_of_match[] = {
>         {
>                 .compatible     = "microchip,mcp2510",
> @@ -1313,6 +1324,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
>                 goto out_free;
>
>         net->netdev_ops = &mcp251x_netdev_ops;
> +       net->ethtool_ops = &mcp251x_ethtool_ops;
>         net->flags |= IFF_ECHO;
>
>         priv = netdev_priv(net);
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index 7fc86ed405c6..d9a7de1927d6 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -16,6 +16,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/device.h>
> +#include <linux/ethtool.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> @@ -1674,6 +1675,16 @@ static const struct net_device_ops mcp251xfd_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void mcp251xfd_get_drvinfo(struct net_device *netdev,
> +                                 struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, DEVICE_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops mcp251xfd_ethtool_ops = {
> +       .get_drvinfo = mcp251xfd_get_drvinfo,
> +};
> +
>  static void
>  mcp251xfd_register_quirks(struct mcp251xfd_priv *priv)
>  {
> @@ -2050,6 +2061,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
>         SET_NETDEV_DEV(ndev, &spi->dev);
>
>         ndev->netdev_ops = &mcp251xfd_netdev_ops;
> +       ndev->ethtool_ops = &mcp251xfd_ethtool_ops;
>         ndev->irq = spi->irq;
>         ndev->flags |= IFF_ECHO;
>
> diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
> index b90dfb429ccd..27ea4e68b516 100644
> --- a/drivers/net/can/sun4i_can.c
> +++ b/drivers/net/can/sun4i_can.c
> @@ -53,6 +53,7 @@
>  #include <linux/can/error.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/ethtool.h>
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> @@ -761,6 +762,16 @@ static const struct net_device_ops sun4ican_netdev_ops = {
>         .ndo_start_xmit = sun4ican_start_xmit,
>  };
>
> +static void sun4ican_get_drvinfo(struct net_device *netdev,
> +                                struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops sun4ican_ethtool_ops = {
> +       .get_drvinfo = sun4ican_get_drvinfo,
> +};
> +
>  static const struct sun4ican_quirks sun4ican_quirks_a10 = {
>         .has_reset = false,
>  };
> @@ -851,6 +862,7 @@ static int sun4ican_probe(struct platform_device *pdev)
>         }
>
>         dev->netdev_ops = &sun4ican_netdev_ops;
> +       dev->ethtool_ops = &sun4ican_ethtool_ops;
>         dev->irq = irq;
>         dev->flags |= IFF_ECHO;
>
> diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
> index afa38771520e..965376453050 100644
> --- a/drivers/net/can/ti_hecc.c
> +++ b/drivers/net/can/ti_hecc.c
> @@ -23,6 +23,7 @@
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
>  #include <linux/errno.h>
> +#include <linux/ethtool.h>
>  #include <linux/netdevice.h>
>  #include <linux/skbuff.h>
>  #include <linux/platform_device.h>
> @@ -841,6 +842,16 @@ static const struct net_device_ops ti_hecc_netdev_ops = {
>         .ndo_change_mtu         = can_change_mtu,
>  };
>
> +static void ti_hecc_get_drvinfo(struct net_device *netdev,
> +                               struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops ti_hecc_ethtool_ops = {
> +       .get_drvinfo = ti_hecc_get_drvinfo,
> +};
> +
>  static const struct of_device_id ti_hecc_dt_ids[] = {
>         {
>                 .compatible = "ti,am3517-hecc",
> @@ -918,6 +929,7 @@ static int ti_hecc_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, ndev);
>         SET_NETDEV_DEV(ndev, &pdev->dev);
>         ndev->netdev_ops = &ti_hecc_netdev_ops;
> +       ndev->ethtool_ops = &ti_hecc_ethtool_ops;
>
>         priv->clk = clk_get(&pdev->dev, "hecc_ck");
>         if (IS_ERR(priv->clk)) {
> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
> index e86a2033db60..ac155f73bedd 100644
> --- a/drivers/net/can/usb/ems_usb.c
> +++ b/drivers/net/can/usb/ems_usb.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright (C) 2004-2009 EMS Dr. Thomas Wuensche
>   */
> +#include <linux/ethtool.h>
>  #include <linux/signal.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -879,6 +880,16 @@ static const struct net_device_ops ems_usb_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void ems_usb_get_drvinfo(struct net_device *netdev,
> +                               struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops ems_usb_ethtool_ops = {
> +       .get_drvinfo = ems_usb_get_drvinfo,
> +};
> +
>  static const struct can_bittiming_const ems_usb_bittiming_const = {
>         .name = KBUILD_MODNAME,
>         .tseg1_min = 1,
> @@ -990,6 +1001,7 @@ static int ems_usb_probe(struct usb_interface *intf,
>         dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;
>
>         netdev->netdev_ops = &ems_usb_netdev_ops;
> +       netdev->ethtool_ops = &ems_usb_ethtool_ops;
>
>         netdev->flags |= IFF_ECHO; /* we support local echo */
>
> diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
> index 7b849bd3cc9c..2367edd49eb7 100644
> --- a/drivers/net/can/usb/esd_usb.c
> +++ b/drivers/net/can/usb/esd_usb.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2010-2012 esd electronic system design gmbh, Matthias Fuchs <socketcan@esd.eu>
>   * Copyright (C) 2022 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
>   */
> +#include <linux/ethtool.h>
>  #include <linux/signal.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -882,6 +883,16 @@ static const struct net_device_ops esd_usb_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void esd_usb_get_drvinfo(struct net_device *netdev,
> +                               struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops esd_usb_ethtool_ops = {
> +       .get_drvinfo = esd_usb_get_drvinfo,
> +};
> +
>  static const struct can_bittiming_const esd_usb2_bittiming_const = {
>         .name = "esd_usb2",
>         .tseg1_min = ESD_USB2_TSEG1_MIN,
> @@ -1015,6 +1026,7 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
>         netdev->flags |= IFF_ECHO; /* we support local echo */
>
>         netdev->netdev_ops = &esd_usb_netdev_ops;
> +       netdev->ethtool_ops = &esd_usb_ethtool_ops;
>
>         SET_NETDEV_DEV(netdev, &intf->dev);
>         netdev->dev_id = index;
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> index 3f51488bd649..0e692c2dc54d 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> @@ -10,6 +10,7 @@
>   * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>   */
>
> +#include <linux/ethtool.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/usb.h>
> @@ -1982,6 +1983,16 @@ static const struct net_device_ops es58x_netdev_ops = {
>         .ndo_start_xmit = es58x_start_xmit
>  };
>
> +static void es58x_get_drvinfo(struct net_device *netdev,
> +                             struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, ES58X_MODULE_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops es58x_ethtool_ops = {
> +       .get_drvinfo = es58x_get_drvinfo,
> +};
> +
>  /**
>   * es58x_set_mode() - Change network device mode.
>   * @netdev: CAN network device.
> @@ -2086,6 +2097,7 @@ static int es58x_init_netdev(struct es58x_device *es58x_dev, int channel_idx)
>         es58x_init_priv(es58x_dev, es58x_priv(netdev), channel_idx);
>
>         netdev->netdev_ops = &es58x_netdev_ops;
> +       netdev->ethtool_ops = &es58x_ethtool_ops;
>         netdev->flags |= IFF_ECHO;      /* We support local echo */
>         netdev->dev_port = channel_idx;
>
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index fd239b523c42..75f5e9c5059a 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -924,6 +924,12 @@ static int gs_usb_set_identify(struct net_device *netdev, bool do_identify)
>         return (rc > 0) ? 0 : rc;
>  }
>
> +static void gs_usb_get_drvinfo(struct net_device *netdev,
> +                              struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +}
> +
>  /* blink LED's for finding the this interface */
>  static int gs_usb_set_phys_id(struct net_device *dev,
>                               enum ethtool_phys_id_state state)
> @@ -945,6 +951,7 @@ static int gs_usb_set_phys_id(struct net_device *dev,
>  }
>
>  static const struct ethtool_ops gs_usb_ethtool_ops = {
> +       .get_drvinfo = gs_usb_get_drvinfo,
>         .set_phys_id = gs_usb_set_phys_id,
>  };
>
> @@ -989,6 +996,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
>         dev = netdev_priv(netdev);
>
>         netdev->netdev_ops = &gs_usb_netdev_ops;
> +       netdev->ethtool_ops = &gs_usb_ethtool_ops;
>
>         netdev->flags |= IFF_ECHO; /* we support full roundtrip echo */
>
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> index a6cff8da5a41..964c0026383e 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> @@ -13,6 +13,7 @@
>
>  #include <linux/completion.h>
>  #include <linux/device.h>
> +#include <linux/ethtool.h>
>  #include <linux/gfp.h>
>  #include <linux/if.h>
>  #include <linux/kernel.h>
> @@ -667,6 +668,16 @@ static const struct net_device_ops kvaser_usb_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void kvaser_usb_get_drvinfo(struct net_device *netdev,
> +                                  struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops kvaser_usb_ethtool_ops = {
> +       .get_drvinfo = kvaser_usb_get_drvinfo,
> +};
> +
>  static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
>  {
>         int i;
> @@ -744,6 +755,7 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
>         netdev->flags |= IFF_ECHO;
>
>         netdev->netdev_ops = &kvaser_usb_netdev_ops;
> +       netdev->ethtool_ops = &kvaser_usb_ethtool_ops;
>
>         SET_NETDEV_DEV(netdev, &dev->intf->dev);
>         netdev->dev_id = channel;
> diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
> index 792ab9da317d..485ec697fc08 100644
> --- a/drivers/net/can/usb/mcba_usb.c
> +++ b/drivers/net/can/usb/mcba_usb.c
> @@ -10,6 +10,7 @@
>  #include <linux/can.h>
>  #include <linux/can/dev.h>
>  #include <linux/can/error.h>
> +#include <linux/ethtool.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
>  #include <linux/signal.h>
> @@ -758,6 +759,16 @@ static const struct net_device_ops mcba_netdev_ops = {
>         .ndo_start_xmit = mcba_usb_start_xmit,
>  };
>
> +static void mcba_get_drvinfo(struct net_device *netdev,
> +                            struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, MCBA_MODULE_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops mcba_ethtool_ops = {
> +       .get_drvinfo = mcba_get_drvinfo,
> +};
> +
>  /* Microchip CANBUS has hardcoded bittiming values by default.
>   * This function sends request via USB to change the speed and align bittiming
>   * values for presentation purposes only
> @@ -836,6 +847,7 @@ static int mcba_usb_probe(struct usb_interface *intf,
>         priv->can.do_set_bittiming = mcba_net_set_bittiming;
>
>         netdev->netdev_ops = &mcba_netdev_ops;
> +       netdev->ethtool_ops = &mcba_ethtool_ops;
>
>         netdev->flags |= IFF_ECHO; /* we support local echo */
>
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index 27b0a72fd885..959448bae3ca 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -782,6 +782,12 @@ static const struct net_device_ops peak_usb_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +void peak_usb_get_drvinfo(struct net_device *netdev,
> +                         struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, PCAN_USB_DRIVER_NAME, sizeof(drvinfo->driver));
> +}
> +
>  /*
>   * create one device which is attached to CAN controller #ctrl_idx of the
>   * usb adapter.
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> index 9c90487b9c92..da1205575379 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> @@ -145,5 +145,7 @@ int peak_usb_netif_rx(struct sk_buff *skb,
>  int peak_usb_netif_rx_64(struct sk_buff *skb, u32 ts_low, u32 ts_high);
>  void peak_usb_async_complete(struct urb *urb);
>  void peak_usb_restart_complete(struct peak_usb_device *dev);
> +void peak_usb_get_drvinfo(struct net_device *netdev,
> +                         struct ethtool_drvinfo *drvinfo);
>
>  #endif
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> index 3d7e0e370505..63122f567380 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -1079,6 +1079,7 @@ static int pcan_usb_fd_set_phys_id(struct net_device *netdev,
>  }
>
>  static const struct ethtool_ops pcan_usb_fd_ethtool_ops = {
> +       .get_drvinfo = peak_usb_get_drvinfo,
>         .set_phys_id = pcan_usb_fd_set_phys_id,
>  };
>
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> index 457887113e75..ea2d4fbceaa4 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> @@ -1021,6 +1021,7 @@ static int pcan_usb_pro_set_phys_id(struct net_device *netdev,
>  }
>
>  static const struct ethtool_ops pcan_usb_pro_ethtool_ops = {
> +       .get_drvinfo = peak_usb_get_drvinfo,
>         .set_phys_id = pcan_usb_pro_set_phys_id,
>  };
>
> diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
> index 5ae0d7c017cc..52263fa286f3 100644
> --- a/drivers/net/can/usb/ucan.c
> +++ b/drivers/net/can/usb/ucan.c
> @@ -28,6 +28,7 @@
>  #include <linux/can.h>
>  #include <linux/can/dev.h>
>  #include <linux/can/error.h>
> +#include <linux/ethtool.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
>  #include <linux/signal.h>
> @@ -1233,6 +1234,16 @@ static const struct net_device_ops ucan_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void ucan_get_drvinfo(struct net_device *netdev,
> +                            struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, UCAN_DRIVER_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops ucan_ethtool_ops = {
> +       .get_drvinfo = ucan_get_drvinfo,
> +};
> +
>  /* Request to set bittiming
>   *
>   * This function generates an USB set bittiming message and transmits
> @@ -1512,6 +1523,7 @@ static int ucan_probe(struct usb_interface *intf,
>         spin_lock_init(&up->context_lock);
>         spin_lock_init(&up->echo_skb_lock);
>         netdev->netdev_ops = &ucan_netdev_ops;
> +       netdev->ethtool_ops = &ucan_ethtool_ops;
>
>         usb_set_intfdata(intf, up);
>         SET_NETDEV_DEV(netdev, &intf->dev);
> diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
> index 6665a66745a7..2a56d7c2fdb6 100644
> --- a/drivers/net/can/usb/usb_8dev.c
> +++ b/drivers/net/can/usb/usb_8dev.c
> @@ -12,6 +12,7 @@
>   * who were very cooperative and answered my questions.
>   */
>
> +#include <linux/ethtool.h>
>  #include <linux/signal.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -870,6 +871,16 @@ static const struct net_device_ops usb_8dev_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void usb_8dev_get_drvinfo(struct net_device *netdev,
> +                                struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops usb_8dev_ethtool_ops = {
> +       .get_drvinfo = usb_8dev_get_drvinfo,
> +};
> +
>  static const struct can_bittiming_const usb_8dev_bittiming_const = {
>         .name = KBUILD_MODNAME,
>         .tseg1_min = 1,
> @@ -927,6 +938,7 @@ static int usb_8dev_probe(struct usb_interface *intf,
>                                       CAN_CTRLMODE_CC_LEN8_DLC;
>
>         netdev->netdev_ops = &usb_8dev_netdev_ops;
> +       netdev->ethtool_ops = &usb_8dev_ethtool_ops;
>
>         netdev->flags |= IFF_ECHO; /* we support local echo */
>
> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
> index a15619d883ec..6827c717af44 100644
> --- a/drivers/net/can/vcan.c
> +++ b/drivers/net/can/vcan.c
> @@ -40,6 +40,7 @@
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <linux/ethtool.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/netdevice.h>
> @@ -146,6 +147,16 @@ static const struct net_device_ops vcan_netdev_ops = {
>         .ndo_change_mtu = vcan_change_mtu,
>  };
>
> +static void vcan_get_drvinfo(struct net_device *netdev,
> +                            struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops vcan_ethtool_ops = {
> +       .get_drvinfo = vcan_get_drvinfo,
> +};
> +
>  static void vcan_setup(struct net_device *dev)
>  {
>         dev->type               = ARPHRD_CAN;
> @@ -161,6 +172,7 @@ static void vcan_setup(struct net_device *dev)
>                 dev->flags |= IFF_ECHO;
>
>         dev->netdev_ops         = &vcan_netdev_ops;
> +       dev->ethtool_ops        = &vcan_ethtool_ops;
>         dev->needs_free_netdev  = true;
>  }
>
> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index 577a80300514..a221c00fe660 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
> @@ -9,6 +9,7 @@
>   * Copyright (c) 2017 Oliver Hartkopp <socketcan@hartkopp.net>
>   */
>
> +#include <linux/ethtool.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/netdevice.h>
> @@ -144,6 +145,16 @@ static const struct net_device_ops vxcan_netdev_ops = {
>         .ndo_change_mtu = vxcan_change_mtu,
>  };
>
> +static void vxcan_get_drvinfo(struct net_device *netdev,
> +                             struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops vxcan_ethtool_ops = {
> +       .get_drvinfo = vxcan_get_drvinfo,
> +};
> +
>  static void vxcan_setup(struct net_device *dev)
>  {
>         struct can_ml_priv *can_ml;
> @@ -155,6 +166,7 @@ static void vxcan_setup(struct net_device *dev)
>         dev->tx_queue_len       = 0;
>         dev->flags              = IFF_NOARP;
>         dev->netdev_ops         = &vxcan_netdev_ops;
> +       dev->ethtool_ops        = &vxcan_ethtool_ops;
>         dev->needs_free_netdev  = true;
>
>         can_ml = netdev_priv(dev) + ALIGN(sizeof(struct vxcan_priv), NETDEV_ALIGN);
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index caa6b4cee63f..b802ddec1965 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -12,6 +12,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/errno.h>
> +#include <linux/ethtool.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -1540,6 +1541,16 @@ static const struct net_device_ops xcan_netdev_ops = {
>         .ndo_change_mtu = can_change_mtu,
>  };
>
> +static void xcan_get_drvinfo(struct net_device *netdev,
> +                            struct ethtool_drvinfo *drvinfo)
> +{
> +       strscpy(drvinfo->driver, DRIVER_NAME, sizeof(drvinfo->driver));
> +}
> +
> +static const struct ethtool_ops xcan_ethtool_ops = {
> +       .get_drvinfo = xcan_get_drvinfo,
> +};
> +
>  /**
>   * xcan_suspend - Suspend method for the driver
>   * @dev:       Address of the device structure
> @@ -1821,6 +1832,7 @@ static int xcan_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, ndev);
>         SET_NETDEV_DEV(ndev, &pdev->dev);
>         ndev->netdev_ops = &xcan_netdev_ops;
> +       ndev->ethtool_ops = &xcan_ethtool_ops;
>
>         /* Getting the CAN can_clk info */
>         priv->can_clk = devm_clk_get(&pdev->dev, "can_clk");
> --
> 2.35.1
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
