Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677D33B8AC4
	for <lists+linux-can@lfdr.de>; Thu,  1 Jul 2021 01:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhF3XEN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 30 Jun 2021 19:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhF3XEI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Jun 2021 19:04:08 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D8DC061756;
        Wed, 30 Jun 2021 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1625094096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vKua4BI4NpQFCAXraivAxhYClhd6cuauXrZqrDzLmzk=;
        b=kxus6HqviLqg3Aky0zP/zZcYqjxdTHTqtDc20cC5F5A1y6E4H723kyQNWEd90FC1dE3cPb
        Y/rD7RRm2VHfQAWbA7PEEq/U3iSk19XgaVD3rAYWOEGaHVnuVuPYRIh7trwEm2AXMvg1M0
        6W/O5cBWXOhGDodgBG3mcizULChjs0k=
Received: from dfj.bfc.timesys.com (host-87-4-238-130.retail.telecomitalia.it [87.4.238.130])
        by ziongate (OpenSMTPD) with ESMTPSA id c108d35c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Jun 2021 23:01:36 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     gerg@linux-m68k.org, wg@grandegger.com, mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v4 5/5] can: flexcan: add mcf5441x support
Date:   Thu,  1 Jul 2021 01:00:16 +0200
Message-Id: <20210630230016.4099050-5-angelo@kernel-space.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630230016.4099050-1-angelo@kernel-space.org>
References: <20210630230016.4099050-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add flexcan support for NXP ColdFire mcf5441x family.

This flexcan module is quite similar to imx6 flexcan module, but
with some exceptions:

- 3 separate interrupt sources, MB, BOFF and ERR,
- implements 16 mb only,
- m68k architecture is not supporting devicetrees, so a
  platform data check/case has been added,
- ColdFire is m68k, so big-endian cpu, with a little-endian flexcan
  module.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
Changes for v2:
- re-add platform data handling restarting from 2c0ac9208135
- re-add flexcan_id_table, as from 2c0ac9208135
- usinig irq resources for ERR and BOFF interrupts
- add missing free_irq() for interrupts
- minor syntax fixes
Changes for v3:
- change platform data include name
- add mcf5441x to hw feature flags
- add mb column to hw feature flags
- fix irq free order
- add proper error handlings
- remove unrelated changes
- split quirk in mb_n and irq_n quirks
Changes for v4:
- platform data structure name changed to flexcan_platform_data
- rename irq request error handlers
- move err and boff platform_get_irq
- fix wrong free_irq
---
 drivers/net/can/flexcan.c | 119 +++++++++++++++++++++++++++++++-------
 1 file changed, 99 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 57f3635ad8d7..891baf2c1e22 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -28,6 +28,7 @@
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/can/platform/flexcan.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -208,18 +209,19 @@
 /* FLEXCAN hardware feature flags
  *
  * Below is some version info we got:
- *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err RTR rece-   FD Mode
+ *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err RTR rece-   FD Mode     MB
  *                                Filter? connected?  Passive detection  ption in MB Supported?
- *   MX25  FlexCAN2  03.00.00.00     no        no        no       no        no           no
- *   MX28  FlexCAN2  03.00.04.00    yes       yes        no       no        no           no
- *   MX35  FlexCAN2  03.00.00.00     no        no        no       no        no           no
- *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no        no           no
- *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no       yes           no
- *   MX8QM FlexCAN3  03.00.23.00    yes       yes        no       no       yes          yes
- *   MX8MP FlexCAN3  03.00.17.01    yes       yes        no      yes       yes          yes
- *   VF610 FlexCAN3  ?               no       yes        no      yes       yes?          no
- * LS1021A FlexCAN2  03.00.04.00     no       yes        no       no       yes           no
- * LX2160A FlexCAN3  03.00.23.00     no       yes        no      yes       yes          yes
+ *   MX25   FlexCAN2  03.00.00.00     no        no        no       no        no           no     64
+ *   MX28   FlexCAN2  03.00.04.00    yes       yes        no       no        no           no     64
+ *   MX35   FlexCAN2  03.00.00.00     no        no        no       no        no           no     64
+ *   MX53   FlexCAN2  03.00.00.00    yes        no        no       no        no           no     64
+ *   MX6s   FlexCAN3  10.00.12.00    yes       yes        no       no       yes           no     64
+ *   MX8QM  FlexCAN3  03.00.23.00    yes       yes        no       no       yes          yes     64
+ *   MX8MP  FlexCAN3  03.00.17.01    yes       yes        no      yes       yes          yes     64
+ *   VF610  FlexCAN3  ?               no       yes        no      yes       yes?          no     64
+ * LS1021A  FlexCAN2  03.00.04.00     no       yes        no       no       yes           no     64
+ * LX2160A  FlexCAN3  03.00.23.00     no       yes        no      yes       yes          yes     64
+ * MCF5441X FlexCAN2  ?               no       yes        no       no       yes           no     16
  *
  * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
  */
@@ -246,6 +248,10 @@
 #define FLEXCAN_QUIRK_SUPPORT_ECC BIT(10)
 /* Setup stop mode with SCU firmware to support wakeup */
 #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW BIT(11)
+/* Setup 3 separate interrupts, main, boff and err */
+#define FLEXCAN_QUIRK_NR_IRQ_3 BIT(12)
+/* Setup 16 mailboxes */
+#define FLEXCAN_QUIRK_NR_MB_16 BIT(13)
 
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -363,6 +369,9 @@ struct flexcan_priv {
 	struct regulator *reg_xceiver;
 	struct flexcan_stop_mode stm;
 
+	int irq_boff;
+	int irq_err;
+
 	/* IPC handle when setup stop mode by System Controller firmware(scfw) */
 	struct imx_sc_ipc *sc_ipc_handle;
 
@@ -371,6 +380,11 @@ struct flexcan_priv {
 	void (*write)(u32 val, void __iomem *addr);
 };
 
+static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16,
+};
+
 static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE |
 		FLEXCAN_QUIRK_BROKEN_PERR_STATE |
@@ -637,13 +651,17 @@ static int flexcan_clks_enable(const struct flexcan_priv *priv)
 {
 	int err;
 
-	err = clk_prepare_enable(priv->clk_ipg);
-	if (err)
-		return err;
+	if (priv->clk_ipg) {
+		err = clk_prepare_enable(priv->clk_ipg);
+		if (err)
+			return err;
+	}
 
-	err = clk_prepare_enable(priv->clk_per);
-	if (err)
-		clk_disable_unprepare(priv->clk_ipg);
+	if (priv->clk_per) {
+		err = clk_prepare_enable(priv->clk_per);
+		if (err)
+			clk_disable_unprepare(priv->clk_ipg);
+	}
 
 	return err;
 }
@@ -1401,8 +1419,12 @@ static int flexcan_rx_offload_setup(struct net_device *dev)
 		priv->mb_size = sizeof(struct flexcan_mb) + CANFD_MAX_DLEN;
 	else
 		priv->mb_size = sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
-	priv->mb_count = (sizeof(priv->regs->mb[0]) / priv->mb_size) +
-			 (sizeof(priv->regs->mb[1]) / priv->mb_size);
+
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_NR_MB_16)
+		priv->mb_count = FLEXCAN_MCF5411X_MB_CNT_MCF;
+	else
+		priv->mb_count = (sizeof(priv->regs->mb[0]) / priv->mb_size) +
+				 (sizeof(priv->regs->mb[1]) / priv->mb_size);
 
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
 		priv->tx_mb_reserved =
@@ -1774,6 +1796,18 @@ static int flexcan_open(struct net_device *dev)
 	if (err)
 		goto out_can_rx_offload_disable;
 
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		err = request_irq(priv->irq_boff,
+				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+		if (err)
+			goto out_free_irq;
+
+		err = request_irq(priv->irq_err,
+				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+		if (err)
+			goto out_free_irq_boff;
+	}
+
 	flexcan_chip_interrupts_enable(dev);
 
 	can_led_event(dev, CAN_LED_EVENT_OPEN);
@@ -1782,6 +1816,10 @@ static int flexcan_open(struct net_device *dev)
 
 	return 0;
 
+ out_free_irq_boff:
+	free_irq(priv->irq_boff, dev);
+ out_free_irq:
+	free_irq(dev->irq, dev);
  out_can_rx_offload_disable:
 	can_rx_offload_disable(&priv->offload);
 	flexcan_chip_stop(dev);
@@ -1803,6 +1841,12 @@ static int flexcan_close(struct net_device *dev)
 
 	netif_stop_queue(dev);
 	flexcan_chip_interrupts_disable(dev);
+
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		free_irq(priv->irq_err, dev);
+		free_irq(priv->irq_boff, dev);
+	}
+
 	free_irq(dev->irq, dev);
 	can_rx_offload_disable(&priv->offload);
 	flexcan_chip_stop_disable_on_error(dev);
@@ -2039,14 +2083,26 @@ static const struct of_device_id flexcan_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
 
+static const struct platform_device_id flexcan_id_table[] = {
+	{
+		.name = "flexcan-mcf5441x",
+		.driver_data = (kernel_ulong_t)&fsl_mcf5441x_devtype_data,
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(platform, flexcan_id_table);
+
 static int flexcan_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id;
 	const struct flexcan_devtype_data *devtype_data;
 	struct net_device *dev;
 	struct flexcan_priv *priv;
 	struct regulator *reg_xceiver;
 	struct clk *clk_ipg = NULL, *clk_per = NULL;
 	struct flexcan_regs __iomem *regs;
+	struct flexcan_platform_data *pdata;
 	int err, irq;
 	u8 clk_src = 1;
 	u32 clock_freq = 0;
@@ -2064,6 +2120,12 @@ static int flexcan_probe(struct platform_device *pdev)
 				     "clock-frequency", &clock_freq);
 		of_property_read_u8(pdev->dev.of_node,
 				    "fsl,clk-source", &clk_src);
+	} else {
+		pdata = dev_get_platdata(&pdev->dev);
+		if (pdata) {
+			clock_freq = pdata->clock_frequency;
+			clk_src = pdata->clk_src;
+		}
 	}
 
 	if (!clock_freq) {
@@ -2089,7 +2151,14 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	devtype_data = of_device_get_match_data(&pdev->dev);
+	of_id = of_match_device(flexcan_of_match, &pdev->dev);
+	if (of_id)
+		devtype_data = of_id->data;
+	else if (platform_get_device_id(pdev)->driver_data)
+		devtype_data = (struct flexcan_devtype_data *)
+			platform_get_device_id(pdev)->driver_data;
+	else
+		return -ENODEV;
 
 	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
 	    !(devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)) {
@@ -2133,6 +2202,15 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->devtype_data = devtype_data;
 	priv->reg_xceiver = reg_xceiver;
 
+	if (devtype_data->quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		priv->irq_boff = platform_get_irq(pdev, 1);
+		if (priv->irq_boff <= 0)
+			return -ENODEV;
+		priv->irq_err = platform_get_irq(pdev, 2);
+		if (priv->irq_err <= 0)
+			return -ENODEV;
+	}
+
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_FD_NON_ISO;
@@ -2322,6 +2400,7 @@ static struct platform_driver flexcan_driver = {
 	},
 	.probe = flexcan_probe,
 	.remove = flexcan_remove,
+	.id_table = flexcan_id_table,
 };
 
 module_platform_driver(flexcan_driver);
-- 
2.31.1

