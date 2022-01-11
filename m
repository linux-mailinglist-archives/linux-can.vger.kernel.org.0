Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C89748A448
	for <lists+linux-can@lfdr.de>; Tue, 11 Jan 2022 01:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbiAKAXS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Jan 2022 19:23:18 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:46217 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbiAKAXS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Jan 2022 19:23:18 -0500
Received: from localhost.localdomain ([81.154.153.55]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.99]) with ESMTPSA (Nemesis) id
 1MhlXE-1mTMP51jWa-00dplJ; Tue, 11 Jan 2022 01:23:15 +0100
From:   Phil Greenland <phil@quantulum.co.uk>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, Phil Greenland <phil@quantulum.co.uk>
Subject: [PATCH 1/3] can: mcp251xfd: automatic transceiver standby control
Date:   Tue, 11 Jan 2022 00:21:09 +0000
Message-Id: <20220111002109.927308-2-phil@quantulum.co.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220111002109.927308-1-phil@quantulum.co.uk>
References: <20220111002109.927308-1-phil@quantulum.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yHn1rJG2/+rmuCY4aovaL8fy5We8/yj/b+7dUvcv8bEq637wJzU
 ce9cH5kyKgvFvP0Hgw7gMs8P264KBpJ/S5tdKHGfVhsTeXz1IVdiH7SCtQZQ8OVWSU2Y24D
 pYZigW500waBDdTirrf2TxS75PhjpzXnybpbLTpBO68uQmlKd0qg5DKSy8YatD8MAcXjYa0
 KYUeUL8xs9FhXhyTgBcng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EP6WG2ayCYA=:qrtVj1zSTPJrMjfmJPg5Zv
 cMdnKrLuvVOMnaVQG77/oSry6V1rbUh2mEhDf9gzw7VXXd7+LrGg2aKKi76S+PbuUBpOX80gZ
 9wVIvKPBPp1XZYhU33w2JJgqUjdHR5xkuF72UONz8xMS6rly8pfZPRp/h92jm332hN80+p17h
 cuK59KKpxMZd+F5lFn3X85GzdWxt3QzbgnrVo774RKU9csviloeJtVU4LN3m3Iutbl8pVaygq
 maTTeK0A5QXxOUNaWU4p+BcQddAKk+mbHgEDTx7b0T4FBwayq8SKtWT0B4zxFuPCV9p7PfVTB
 uAHfsNJI2RwFQoqtJp6yy+ZqoK1PyVHk3HFvUH8HgHr5sb13ANmC89jwYABku5KX6gK3Ucsta
 5GBBe0hIJT4d8aF1/wBnviBOOVOWtV4Nt7WFL/ml0lPggPY+sgX1P/G0netBfsx+Qut//99Gk
 W9HBJFxYvwuTrgtLgyLVw2kglVQGewaSuXZXjvAcz0rCaLCQFX0sZfUMXG5VhOP2DdHzxItqT
 m+1sGLo5jHDbgmQRTUPEeHmwDYirsgHKe0AAVFAuIPnhTKn9SZJ/wv/DqJSQLsGxlS+3Z9Z1A
 yto15gK3eZ3/CXf1BBGxYvBdBxKaBgzwzig8EpGMVUJDbT38OpebepI4JUxUNTv21kjU4HXoj
 V5XcilaPDhT7VQnaShW/9ex89tQyY0A2Hnt/BRFBeN+KFBqWR3RPXufRsg6pyTy3530o=
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Added a device tree option xceiver_standby, which if present will cause GPIO to be placed in GPIO mode, with automatic transceiver control enabled.

Added a flag to the summary message printed following successful initialisation, to help debug it being enabled.

Have checked with a logic analyser that GPIO0 transitions from high to low as expected when the interface is brought up, and low to high when taken down.

I've renamed mcp251xfd_chip_rx_int_disable to mcp251xfd_chip_configure_gpio trying to reflect its new role, considering that it doesn't just manage the rx interrupt anymore. Perhaps separate functions updating the bits independently might be better?

Signed-off-by: Phil Greenland <phil@quantulum.co.uk>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 56 ++++++++++---------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  2 +
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index e16dc482f..9ee2c69c5 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -801,40 +801,37 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 	return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);
 }
 
-static int mcp251xfd_chip_rx_int_enable(const struct mcp251xfd_priv *priv)
+static int mcp251xfd_chip_configure_gpio(const struct mcp251xfd_priv *priv,
+					 bool rx_int_enable)
 {
-	u32 val;
-
-	if (!priv->rx_int)
-		return 0;
+	u32 val = 0;
 
 	/* Configure GPIOs:
-	 * - PIN0: GPIO Input
-	 * - PIN1: GPIO Input/RX Interrupt
+	 * - PIN0: GPIO Input/Transceiver standby (if enabled)
+	 * - PIN1: GPIO Input/RX Interrupt (if enabled)
 	 *
 	 * PIN1 must be Input, otherwise there is a glitch on the
 	 * rx-INT line. It happens between setting the PIN as output
 	 * (in the first byte of the SPI transfer) and configuring the
 	 * PIN as interrupt (in the last byte of the SPI transfer).
 	 */
-	val = MCP251XFD_REG_IOCON_PM0 | MCP251XFD_REG_IOCON_TRIS1 |
-		MCP251XFD_REG_IOCON_TRIS0;
-	return regmap_write(priv->map_reg, MCP251XFD_REG_IOCON, val);
-}
+	if (priv->xceiver_standby) {
+		/* Transceiver control enabled, place in GPIO mode with auto transceiver standby */
+		val |= MCP251XFD_REG_IOCON_PM0 | MCP251XFD_REG_IOCON_XSTBYEN;
+	} else {
+		/* Transceiver control disabled, place in GPIO mode and tristate */
+		val |= MCP251XFD_REG_IOCON_PM0 | MCP251XFD_REG_IOCON_TRIS0;
+	}
 
-static int mcp251xfd_chip_rx_int_disable(const struct mcp251xfd_priv *priv)
-{
-	u32 val;
+	if (priv->rx_int && rx_int_enable) {
+		/* INT1 enabled, tristate GPIO1 (overridden by INT enable) */
+		val |= MCP251XFD_REG_IOCON_TRIS1;
 
-	if (!priv->rx_int)
-		return 0;
+	} else {
+		/* INT1 disabled, place in GPIO mode and tristate */
+		val |= MCP251XFD_REG_IOCON_PM1 | MCP251XFD_REG_IOCON_TRIS1;
+	}
 
-	/* Configure GPIOs:
-	 * - PIN0: GPIO Input
-	 * - PIN1: GPIO Input
-	 */
-	val = MCP251XFD_REG_IOCON_PM1 | MCP251XFD_REG_IOCON_PM0 |
-		MCP251XFD_REG_IOCON_TRIS1 | MCP251XFD_REG_IOCON_TRIS0;
 	return regmap_write(priv->map_reg, MCP251XFD_REG_IOCON, val);
 }
 
@@ -1070,7 +1067,7 @@ static int mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
 	priv->can.state = state;
 
 	mcp251xfd_chip_interrupts_disable(priv);
-	mcp251xfd_chip_rx_int_disable(priv);
+	mcp251xfd_chip_configure_gpio(priv, false);
 	return mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_SLEEP);
 }
 
@@ -1090,7 +1087,8 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 	if (err)
 		goto out_chip_stop;
 
-	err = mcp251xfd_chip_rx_int_enable(priv);
+	/* enable rx interrupt */
+	err = mcp251xfd_chip_configure_gpio(priv, true);
 	if (err)
 		goto out_chip_stop;
 
@@ -2645,7 +2643,8 @@ static int mcp251xfd_register_check_rx_int(struct mcp251xfd_priv *priv)
 	if (!priv->rx_int)
 		return 0;
 
-	err = mcp251xfd_chip_rx_int_enable(priv);
+	/* enable rx interrupt */
+	err = mcp251xfd_chip_configure_gpio(priv, true);
 	if (err)
 		return err;
 
@@ -2654,7 +2653,8 @@ static int mcp251xfd_register_check_rx_int(struct mcp251xfd_priv *priv)
 	 */
 	rx_pending = gpiod_get_value_cansleep(priv->rx_int);
 
-	err = mcp251xfd_chip_rx_int_disable(priv);
+	/* disable rx interrupt */
+	err = mcp251xfd_chip_configure_gpio(priv, false);
 	if (err)
 		return err;
 
@@ -2724,11 +2724,12 @@ mcp251xfd_register_done(const struct mcp251xfd_priv *priv)
 		return err;
 
 	netdev_info(priv->ndev,
-		    "%s rev%lu.%lu (%cRX_INT %cMAB_NO_WARN %cCRC_REG %cCRC_RX %cCRC_TX %cECC %cHD c:%u.%02uMHz m:%u.%02uMHz r:%u.%02uMHz e:%u.%02uMHz) successfully initialized.\n",
+		    "%s rev%lu.%lu (%cRX_INT %cXCVR_STBY %cMAB_NO_WARN %cCRC_REG %cCRC_RX %cCRC_TX %cECC %cHD c:%u.%02uMHz m:%u.%02uMHz r:%u.%02uMHz e:%u.%02uMHz) successfully initialized.\n",
 		    mcp251xfd_get_model_str(priv),
 		    FIELD_GET(MCP251XFD_REG_DEVID_ID_MASK, dev_id),
 		    FIELD_GET(MCP251XFD_REG_DEVID_REV_MASK, dev_id),
 		    priv->rx_int ? '+' : '-',
+			priv->xceiver_standby ? '+' : '-',
 		    MCP251XFD_QUIRK_ACTIVE(MAB_NO_WARN),
 		    MCP251XFD_QUIRK_ACTIVE(CRC_REG),
 		    MCP251XFD_QUIRK_ACTIVE(CRC_RX),
@@ -2948,6 +2949,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->clk = clk;
 	priv->reg_vdd = reg_vdd;
 	priv->reg_xceiver = reg_xceiver;
+	priv->xceiver_standby = device_property_read_bool(&spi->dev, "xceiver_standby");
 
 	match = device_get_match_data(&spi->dev);
 	if (match)
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 0f322daba..ad658faa2 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -612,6 +612,8 @@ struct mcp251xfd_priv {
 
 	struct mcp251xfd_devtype_data devtype_data;
 	struct can_berr_counter bec;
+
+	bool xceiver_standby;
 };
 
 #define MCP251XFD_IS(_model) \
-- 
2.25.1

