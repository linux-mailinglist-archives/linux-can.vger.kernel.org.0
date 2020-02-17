Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF6161705
	for <lists+linux-can@lfdr.de>; Mon, 17 Feb 2020 17:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgBQQKm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Feb 2020 11:10:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:5521 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgBQQKm (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 17 Feb 2020 11:10:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 08:10:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,453,1574150400"; 
   d="scan'208";a="239109401"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 17 Feb 2020 08:10:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6FE0F73; Mon, 17 Feb 2020 18:10:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] can: mcp251x: Use readx_poll_timeout() helper
Date:   Mon, 17 Feb 2020 18:10:38 +0200
Message-Id: <20200217161038.25009-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

We may use special helper macro to poll IO till condition or timeout occurs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/can/spi/mcp251x.c | 62 +++++++++++++++++------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 5009ff294941..5f6fa1cf506a 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -29,6 +29,7 @@
 #include <linux/freezer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -345,6 +346,13 @@ static void mcp251x_write_bits(struct spi_device *spi, u8 reg,
 	mcp251x_spi_trans(spi, 4);
 }
 
+static u8 mcp251x_read_stat(struct spi_device *spi)
+{
+	return mcp251x_read_reg(spi, CANSTAT) & CANCTRL_REQOP_MASK;
+}
+#define mcp251x_read_stat_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(mcp251x_read_stat, addr, val, cond, delay_us, timeout_us)
+
 static void mcp251x_hw_tx_frame(struct spi_device *spi, u8 *buf,
 				int len, int tx_buf_idx)
 {
@@ -471,7 +479,8 @@ static void mcp251x_hw_sleep(struct spi_device *spi)
 /* May only be called when device is sleeping! */
 static int mcp251x_hw_wake(struct spi_device *spi)
 {
-	unsigned long timeout;
+	u8 value;
+	int ret;
 
 	/* Force wakeup interrupt to wake device, but don't execute IST */
 	disable_irq(spi->irq);
@@ -484,14 +493,12 @@ static int mcp251x_hw_wake(struct spi_device *spi)
 	mcp251x_write_reg(spi, CANCTRL, CANCTRL_REQOP_CONF);
 
 	/* Wait for the device to enter config mode */
-	timeout = jiffies + HZ;
-	while ((mcp251x_read_reg(spi, CANSTAT) & CANCTRL_REQOP_MASK) !=
-			CANCTRL_REQOP_CONF) {
-		schedule();
-		if (time_after(jiffies, timeout)) {
-			dev_err(&spi->dev, "MCP251x didn't enter in config mode\n");
-			return -EBUSY;
-		}
+	ret = mcp251x_read_stat_poll_timeout(spi, value, value == CANCTRL_REQOP_CONF,
+					     MCP251X_OST_DELAY_MS * 1000,
+					     USEC_PER_SEC);
+	if (ret) {
+		dev_err(&spi->dev, "MCP251x didn't enter in config mode\n");
+		return ret;
 	}
 
 	/* Disable and clear pending interrupts */
@@ -546,7 +553,8 @@ static int mcp251x_do_set_mode(struct net_device *net, enum can_mode mode)
 static int mcp251x_set_normal_mode(struct spi_device *spi)
 {
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
-	unsigned long timeout;
+	u8 value;
+	int ret;
 
 	/* Enable interrupts */
 	mcp251x_write_reg(spi, CANINTE,
@@ -564,13 +572,12 @@ static int mcp251x_set_normal_mode(struct spi_device *spi)
 		mcp251x_write_reg(spi, CANCTRL, CANCTRL_REQOP_NORMAL);
 
 		/* Wait for the device to enter normal mode */
-		timeout = jiffies + HZ;
-		while (mcp251x_read_reg(spi, CANSTAT) & CANCTRL_REQOP_MASK) {
-			schedule();
-			if (time_after(jiffies, timeout)) {
-				dev_err(&spi->dev, "MCP251x didn't enter in normal mode\n");
-				return -EBUSY;
-			}
+		ret = mcp251x_read_stat_poll_timeout(spi, value, value == 0,
+						     MCP251X_OST_DELAY_MS * 1000,
+						     USEC_PER_SEC);
+		if (ret) {
+			dev_err(&spi->dev, "MCP251x didn't enter in normal mode\n");
+			return ret;
 		}
 	}
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
@@ -614,7 +621,7 @@ static int mcp251x_setup(struct net_device *net, struct spi_device *spi)
 static int mcp251x_hw_reset(struct spi_device *spi)
 {
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
-	unsigned long timeout;
+	u8 value;
 	int ret;
 
 	/* Wait for oscillator startup timer after power up */
@@ -629,19 +636,12 @@ static int mcp251x_hw_reset(struct spi_device *spi)
 	mdelay(MCP251X_OST_DELAY_MS);
 
 	/* Wait for reset to finish */
-	timeout = jiffies + HZ;
-	while ((mcp251x_read_reg(spi, CANSTAT) & CANCTRL_REQOP_MASK) !=
-	       CANCTRL_REQOP_CONF) {
-		usleep_range(MCP251X_OST_DELAY_MS * 1000,
-			     MCP251X_OST_DELAY_MS * 1000 * 2);
-
-		if (time_after(jiffies, timeout)) {
-			dev_err(&spi->dev,
-				"MCP251x didn't enter in conf mode after reset\n");
-			return -EBUSY;
-		}
-	}
-	return 0;
+	ret = mcp251x_read_stat_poll_timeout(spi, value, value == CANCTRL_REQOP_CONF,
+					     MCP251X_OST_DELAY_MS * 1000,
+					     USEC_PER_SEC);
+	if (ret)
+		dev_err(&spi->dev, "MCP251x didn't enter in conf mode after reset\n");
+	return ret;
 }
 
 static int mcp251x_hw_probe(struct spi_device *spi)
-- 
2.25.0

