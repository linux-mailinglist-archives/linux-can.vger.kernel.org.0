Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04501D417B
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2019 15:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfJKNis (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 11 Oct 2019 09:38:48 -0400
Received: from mx.krause.de ([88.79.216.98]:37429 "EHLO mx.krause.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbfJKNis (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 11 Oct 2019 09:38:48 -0400
Received: from [172.20.10.125] (port=46355 helo=mail.horstmanngroup.de)
        by mx.krause.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <t.schluessler@krause.de>)
        id 1iIv7z-0002zV-1A; Fri, 11 Oct 2019 15:38:43 +0200
Received: from HG-SRV-053.HG.local (172.20.10.125) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 11 Oct
 2019 15:38:42 +0200
Received: from kb-ctp-power.localdomain (172.20.35.17) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 11 Oct 2019 15:38:42 +0200
X-CTCH-RefID: str=0001.0A0C0201.5DA085E3.0038,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   =?UTF-8?q?Timo=20Schl=C3=BC=C3=9Fler?= <schluessler@krause.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     =?UTF-8?q?Timo=20Schl=C3=BC=C3=9Fler?= <schluessler@krause.de>
Subject: [PATCH v3 2/3] can: mcp251x: Only reset hardware as required
Date:   Fri, 11 Oct 2019 15:38:20 +0200
Message-ID: <1570801101-27864-2-git-send-email-schluessler@krause.de>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1570801101-27864-1-git-send-email-schluessler@krause.de>
References: <1570801101-27864-1-git-send-email-schluessler@krause.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This prevents unwanted glitches on the outputs when changing the link
state of the can interface or when resuming from suspend. Only if the
device is powered off during suspend it needs to be resetted as required
by the specs.

Signed-off-by: Timo Schlüßler <schluessler@krause.de>
---
 drivers/net/can/spi/mcp251x.c | 66 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 6f359df..8d65b73 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -320,6 +320,18 @@ static void mcp251x_write_reg(struct spi_device *spi, u8 reg, u8 val)
 	mcp251x_spi_trans(spi, 3);
 }
 
+static void mcp251x_write_2regs(struct spi_device *spi, u8 reg, u8 v1, u8 v2)
+{
+	struct mcp251x_priv *priv = spi_get_drvdata(spi);
+
+	priv->spi_tx_buf[0] = INSTRUCTION_WRITE;
+	priv->spi_tx_buf[1] = reg;
+	priv->spi_tx_buf[2] = v1;
+	priv->spi_tx_buf[3] = v2;
+
+	mcp251x_spi_trans(spi, 4);
+}
+
 static void mcp251x_write_bits(struct spi_device *spi, u8 reg,
 			       u8 mask, u8 val)
 {
@@ -456,6 +468,39 @@ static void mcp251x_hw_sleep(struct spi_device *spi)
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
@@ -645,8 +690,7 @@ static int mcp251x_stop(struct net_device *net)
 	mutex_lock(&priv->mcp_lock);
 
 	/* Disable and clear pending interrupts */
-	mcp251x_write_reg(spi, CANINTE, 0x00);
-	mcp251x_write_reg(spi, CANINTF, 0x00);
+	mcp251x_write_2regs(spi, CANINTE, 0x00, 0x00);
 
 	mcp251x_write_reg(spi, TXBCTRL(0), 0);
 	mcp251x_clean(net);
@@ -714,8 +758,12 @@ static void mcp251x_restart_work_handler(struct work_struct *ws)
 
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
@@ -910,7 +958,7 @@ static int mcp251x_open(struct net_device *net)
 	INIT_WORK(&priv->tx_work, mcp251x_tx_work_handler);
 	INIT_WORK(&priv->restart_work, mcp251x_restart_work_handler);
 
-	ret = mcp251x_hw_reset(spi);
+	ret = mcp251x_hw_wake(spi);
 	if (ret)
 		goto out_free_wq;
 	ret = mcp251x_setup(net, spi);
@@ -1152,13 +1200,13 @@ static int __maybe_unused mcp251x_can_resume(struct device *dev)
 
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
2.7.2

