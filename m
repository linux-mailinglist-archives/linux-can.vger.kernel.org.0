Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619812B8DF9
	for <lists+linux-can@lfdr.de>; Thu, 19 Nov 2020 09:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgKSIw7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Nov 2020 03:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgKSIw7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Nov 2020 03:52:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3DFC0613D4
        for <linux-can@vger.kernel.org>; Thu, 19 Nov 2020 00:52:58 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kffgW-0004Tk-DY; Thu, 19 Nov 2020 09:52:56 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>, kernel@pengutronix.de,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/5] can: flexcan: factor out enabling and disabling of interrupts into separate function
Date:   Thu, 19 Nov 2020 09:52:47 +0100
Message-Id: <20201119085251.2949181-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119085251.2949181-1-mkl@pengutronix.de>
References: <20201119085251.2949181-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The upcoming patches are going to move the enabling and disabling of the
interrupts. Introduce convenience functions to make these patches simpler.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 41 ++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 06e03ab6f43a..56af58c4179b 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1383,6 +1383,31 @@ static void flexcan_ram_init(struct net_device *dev)
 	priv->write(reg_ctrl2, &regs->ctrl2);
 }
 
+static void flexcan_chip_interrupts_enable(const struct net_device *dev)
+{
+	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	u64 reg_imask;
+
+	disable_irq(dev->irq);
+	priv->write(priv->reg_ctrl_default, &regs->ctrl);
+	reg_imask = priv->rx_mask | priv->tx_mask;
+	priv->write(upper_32_bits(reg_imask), &regs->imask2);
+	priv->write(lower_32_bits(reg_imask), &regs->imask1);
+	enable_irq(dev->irq);
+}
+
+static void flexcan_chip_interrupts_disable(const struct net_device *dev)
+{
+	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+
+	priv->write(0, &regs->imask2);
+	priv->write(0, &regs->imask1);
+	priv->write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
+		    &regs->ctrl);
+}
+
 /* flexcan_chip_start
  *
  * this functions is entered with clocks enabled
@@ -1393,7 +1418,6 @@ static int flexcan_chip_start(struct net_device *dev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg_mcr, reg_ctrl, reg_ctrl2, reg_mecr;
-	u64 reg_imask;
 	int err, i;
 	struct flexcan_mb __iomem *mb;
 
@@ -1611,13 +1635,7 @@ static int flexcan_chip_start(struct net_device *dev)
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
-	/* enable interrupts atomically */
-	disable_irq(dev->irq);
-	priv->write(priv->reg_ctrl_default, &regs->ctrl);
-	reg_imask = priv->rx_mask | priv->tx_mask;
-	priv->write(upper_32_bits(reg_imask), &regs->imask2);
-	priv->write(lower_32_bits(reg_imask), &regs->imask1);
-	enable_irq(dev->irq);
+	flexcan_chip_interrupts_enable(dev);
 
 	/* print chip status */
 	netdev_dbg(dev, "%s: reading mcr=0x%08x ctrl=0x%08x\n", __func__,
@@ -1637,7 +1655,6 @@ static int flexcan_chip_start(struct net_device *dev)
 static int __flexcan_chip_stop(struct net_device *dev, bool disable_on_error)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
-	struct flexcan_regs __iomem *regs = priv->regs;
 	int err;
 
 	/* freeze + disable module */
@@ -1648,11 +1665,7 @@ static int __flexcan_chip_stop(struct net_device *dev, bool disable_on_error)
 	if (err && !disable_on_error)
 		goto out_chip_unfreeze;
 
-	/* Disable all interrupts */
-	priv->write(0, &regs->imask2);
-	priv->write(0, &regs->imask1);
-	priv->write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
-		    &regs->ctrl);
+	flexcan_chip_interrupts_disable(dev);
 
 	priv->can.state = CAN_STATE_STOPPED;
 
-- 
2.29.2

