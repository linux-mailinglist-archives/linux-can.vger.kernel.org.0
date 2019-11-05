Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE1F05AC
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2019 20:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390926AbfKETIq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Nov 2019 14:08:46 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45049 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390928AbfKETIp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Nov 2019 14:08:45 -0500
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iS4C3-0001dw-TK; Tue, 05 Nov 2019 20:08:43 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     =?UTF-8?q?Timo=20Schl=C3=BC=C3=9Fler?= <schluessler@krause.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 3/4] can: mcp251x: only reset hardware as required
Date:   Tue,  5 Nov 2019 20:08:39 +0100
Message-Id: <20191105190840.20410-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191105190840.20410-1-mkl@pengutronix.de>
References: <20191105190840.20410-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Timo Schlüßler <schluessler@krause.de>

This prevents unwanted glitches on the outputs when changing the link
state of the can interface or when resuming from suspend. Only if the
device is powered off during suspend it needs to be resetted as required
by the specs.

Signed-off-by: Timo Schlüßler <schluessler@krause.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 51 ++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index d1240aeaa12c..a0695d6b5df2 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -510,6 +510,39 @@ static void mcp251x_hw_sleep(struct spi_device *spi)
 	mcp251x_write_reg(spi, CANCTRL, CANCTRL_REQOP_SLEEP);
 }
 
+/* May only be called when device is sleeping! */
+static int mcp251x_hw_wake(struct spi_device *spi)
+{
+	unsigned long timeout;
+
+	/* Force wakeup interrupt to wake device, but don't execute IST */
+	disable_irq(spi->irq);
+	mcp251x_write_2regs(spi, CANINTE, CANINTE_WAKIE, CANINTF_WAKIF);
+
+	/* Wait for oscillator startup timer after wake up */
+	mdelay(MCP251X_OST_DELAY_MS);
+
+	/* Put device into config mode */
+	mcp251x_write_reg(spi, CANCTRL, CANCTRL_REQOP_CONF);
+
+	/* Wait for the device to enter config mode */
+	timeout = jiffies + HZ;
+	while ((mcp251x_read_reg(spi, CANSTAT) & CANCTRL_REQOP_MASK) !=
+			CANCTRL_REQOP_CONF) {
+		schedule();
+		if (time_after(jiffies, timeout)) {
+			dev_err(&spi->dev, "MCP251x didn't enter in config mode\n");
+			return -EBUSY;
+		}
+	}
+
+	/* Disable and clear pending interrupts */
+	mcp251x_write_2regs(spi, CANINTE, 0x00, 0x00);
+	enable_irq(spi->irq);
+
+	return 0;
+}
+
 static netdev_tx_t mcp251x_hard_start_xmit(struct sk_buff *skb,
 					   struct net_device *net)
 {
@@ -759,8 +792,12 @@ static void mcp251x_restart_work_handler(struct work_struct *ws)
 
 	mutex_lock(&priv->mcp_lock);
 	if (priv->after_suspend) {
-		mcp251x_hw_reset(spi);
-		mcp251x_setup(net, spi);
+		if (priv->after_suspend & AFTER_SUSPEND_POWER) {
+			mcp251x_hw_reset(spi);
+			mcp251x_setup(net, spi);
+		} else {
+			mcp251x_hw_wake(spi);
+		}
 		priv->force_quit = 0;
 		if (priv->after_suspend & AFTER_SUSPEND_RESTART) {
 			mcp251x_set_normal_mode(spi);
@@ -953,7 +990,7 @@ static int mcp251x_open(struct net_device *net)
 	INIT_WORK(&priv->tx_work, mcp251x_tx_work_handler);
 	INIT_WORK(&priv->restart_work, mcp251x_restart_work_handler);
 
-	ret = mcp251x_hw_reset(spi);
+	ret = mcp251x_hw_wake(spi);
 	if (ret)
 		goto out_free_wq;
 	ret = mcp251x_setup(net, spi);
@@ -1229,13 +1266,13 @@ static int __maybe_unused mcp251x_can_resume(struct device *dev)
 
 	if (priv->after_suspend & AFTER_SUSPEND_POWER)
 		mcp251x_power_enable(priv->power, 1);
-
-	if (priv->after_suspend & AFTER_SUSPEND_UP) {
+	if (priv->after_suspend & AFTER_SUSPEND_UP)
 		mcp251x_power_enable(priv->transceiver, 1);
+
+	if (priv->after_suspend & (AFTER_SUSPEND_POWER | AFTER_SUSPEND_UP))
 		queue_work(priv->wq, &priv->restart_work);
-	} else {
+	else
 		priv->after_suspend = 0;
-	}
 
 	priv->force_quit = 0;
 	enable_irq(spi->irq);
-- 
2.24.0.rc1

