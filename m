Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7856F05AE
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2019 20:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390928AbfKETIq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Nov 2019 14:08:46 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37155 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390929AbfKETIq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Nov 2019 14:08:46 -0500
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iS4C4-0001dw-3x; Tue, 05 Nov 2019 20:08:44 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     =?UTF-8?q?Timo=20Schl=C3=BC=C3=9Fler?= <schluessler@krause.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 4/4] can: mcp251x: add GPIO support
Date:   Tue,  5 Nov 2019 20:08:40 +0100
Message-Id: <20191105190840.20410-5-mkl@pengutronix.de>
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

The mcp251x variants feature 3 general purpose digital inputs and 2
outputs. With this patch they are accessible through the gpio framework.

Signed-off-by: Timo Schlüßler <schluessler@krause.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 251 ++++++++++++++++++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index a0695d6b5df2..b73a289c7d8b 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -41,6 +41,7 @@
  */
 
 #include <linux/can/core.h>
+#include <linux/bitfield.h>
 #include <linux/can/dev.h>
 #include <linux/can/led.h>
 #include <linux/can/platform/mcp251x.h>
@@ -62,6 +63,8 @@
 #include <linux/spi/spi.h>
 #include <linux/uaccess.h>
 #include <linux/regulator/consumer.h>
+#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 
 /* SPI interface instruction set */
 #define INSTRUCTION_WRITE	0x02
@@ -77,6 +80,30 @@
 
 
 /* MPC251x registers */
+#define BFPCTRL			0x0c
+#  define BFPCTRL_B0BFM		BIT(0)
+#  define BFPCTRL_B1BFM		BIT(1)
+#  define BFPCTRL_BFM(n)	(BFPCTRL_B0BFM << (n))
+#  define BFPCTRL_BFM_MASK	GENMASK(1, 0)
+#  define BFPCTRL_B0BFE		BIT(2)
+#  define BFPCTRL_B1BFE		BIT(3)
+#  define BFPCTRL_BFE(n)	(BFPCTRL_B0BFE << (n))
+#  define BFPCTRL_BFE_MASK	GENMASK(3, 2)
+#  define BFPCTRL_B0BFS		BIT(4)
+#  define BFPCTRL_B1BFS		BIT(5)
+#  define BFPCTRL_BFS(n)	(BFPCTRL_B0BFS << (n))
+#  define BFPCTRL_BFS_MASK	GENMASK(5, 4)
+#define TXRTSCTRL		0x0d
+#  define TXRTSCTRL_B0RTSM	BIT(0)
+#  define TXRTSCTRL_B1RTSM	BIT(1)
+#  define TXRTSCTRL_B2RTSM	BIT(2)
+#  define TXRTSCTRL_RTSM(n)	(TXRTSCTRL_B0RTSM << (n))
+#  define TXRTSCTRL_RTSM_MASK	GENMASK(2, 0)
+#  define TXRTSCTRL_B0RTS	BIT(3)
+#  define TXRTSCTRL_B1RTS	BIT(4)
+#  define TXRTSCTRL_B2RTS	BIT(5)
+#  define TXRTSCTRL_RTS(n)	(TXRTSCTRL_B0RTS << (n))
+#  define TXRTSCTRL_RTS_MASK	GENMASK(5, 3)
 #define CANSTAT	      0x0e
 #define CANCTRL	      0x0f
 #  define CANCTRL_REQOP_MASK	    0xe0
@@ -257,6 +284,10 @@ struct mcp251x_priv {
 	struct regulator *power;
 	struct regulator *transceiver;
 	struct clk *clk;
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gpio;
+	u8 reg_bfpctrl;
+#endif
 };
 
 #define MCP251X_IS(_model) \
@@ -387,6 +418,216 @@ static void mcp251x_write_bits(struct spi_device *spi, u8 reg,
 	mcp251x_spi_trans(spi, 4);
 }
 
+#ifdef CONFIG_GPIOLIB
+enum {
+	MCP251X_GPIO_TX0RTS = 0,		/* inputs */
+	MCP251X_GPIO_TX1RTS,
+	MCP251X_GPIO_TX2RTS,
+	MCP251X_GPIO_RX0BF,			/* outputs */
+	MCP251X_GPIO_RX1BF,
+};
+
+#define MCP251X_GPIO_INPUT_MASK \
+	GENMASK(MCP251X_GPIO_TX2RTS, MCP251X_GPIO_TX0RTS)
+#define MCP251X_GPIO_OUTPUT_MASK \
+	GENMASK(MCP251X_GPIO_RX1BF, MCP251X_GPIO_RX0BF)
+
+static const char * const mcp251x_gpio_names[] = {
+	[MCP251X_GPIO_TX0RTS] = "TX0RTS",	/* inputs */
+	[MCP251X_GPIO_TX1RTS] = "TX1RTS",
+	[MCP251X_GPIO_TX2RTS] = "TX2RTS",
+	[MCP251X_GPIO_RX0BF] = "RX0BF",		/* outputs */
+	[MCP251X_GPIO_RX1BF] = "RX1BF",
+};
+
+static inline bool mcp251x_gpio_is_input(unsigned int offset)
+{
+	return offset <= MCP251X_GPIO_TX2RTS;
+}
+
+static int mcp251x_gpio_request(struct gpio_chip *chip,
+				unsigned int offset)
+{
+	struct mcp251x_priv *priv = gpiochip_get_data(chip);
+	u8 val;
+
+	/* nothing to be done for inputs */
+	if (mcp251x_gpio_is_input(offset))
+		return 0;
+
+	val = BFPCTRL_BFE(offset - MCP251X_GPIO_RX0BF);
+
+	mutex_lock(&priv->mcp_lock);
+	mcp251x_write_bits(priv->spi, BFPCTRL, val, val);
+	mutex_unlock(&priv->mcp_lock);
+
+	priv->reg_bfpctrl |= val;
+
+	return 0;
+}
+
+static void mcp251x_gpio_free(struct gpio_chip *chip,
+			      unsigned int offset)
+{
+	struct mcp251x_priv *priv = gpiochip_get_data(chip);
+	u8 val;
+
+	/* nothing to be done for inputs */
+	if (mcp251x_gpio_is_input(offset))
+		return;
+
+	val = BFPCTRL_BFE(offset - MCP251X_GPIO_RX0BF);
+
+	mutex_lock(&priv->mcp_lock);
+	mcp251x_write_bits(priv->spi, BFPCTRL, val, 0);
+	mutex_unlock(&priv->mcp_lock);
+
+	priv->reg_bfpctrl &= ~val;
+}
+
+static int mcp251x_gpio_get_direction(struct gpio_chip *chip,
+				      unsigned int offset)
+{
+	if (mcp251x_gpio_is_input(offset))
+		return GPIOF_DIR_IN;
+
+	return GPIOF_DIR_OUT;
+}
+
+static int mcp251x_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mcp251x_priv *priv = gpiochip_get_data(chip);
+	u8 reg, mask, val;
+
+	if (mcp251x_gpio_is_input(offset)) {
+		reg = TXRTSCTRL;
+		mask = TXRTSCTRL_RTS(offset);
+	} else {
+		reg = BFPCTRL;
+		mask = BFPCTRL_BFS(offset - MCP251X_GPIO_RX0BF);
+	}
+
+	mutex_lock(&priv->mcp_lock);
+	val = mcp251x_read_reg(priv->spi, reg);
+	mutex_unlock(&priv->mcp_lock);
+
+	return !!(val & mask);
+}
+
+static int mcp251x_gpio_get_multiple(struct gpio_chip *chip,
+				     unsigned long *maskp, unsigned long *bitsp)
+{
+	struct mcp251x_priv *priv = gpiochip_get_data(chip);
+	unsigned long bits = 0;
+	u8 val;
+
+	mutex_lock(&priv->mcp_lock);
+	if (maskp[0] & MCP251X_GPIO_INPUT_MASK) {
+		val = mcp251x_read_reg(priv->spi, TXRTSCTRL);
+		val = FIELD_GET(TXRTSCTRL_RTS_MASK, val);
+		bits |= FIELD_PREP(MCP251X_GPIO_INPUT_MASK, val);
+	}
+	if (maskp[0] & MCP251X_GPIO_OUTPUT_MASK) {
+		val = mcp251x_read_reg(priv->spi, BFPCTRL);
+		val = FIELD_GET(BFPCTRL_BFS_MASK, val);
+		bits |= FIELD_PREP(MCP251X_GPIO_OUTPUT_MASK, val);
+	}
+	mutex_unlock(&priv->mcp_lock);
+
+	bitsp[0] = bits;
+	return 0;
+}
+
+static void mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			     int value)
+{
+	struct mcp251x_priv *priv = gpiochip_get_data(chip);
+	u8 mask, val;
+
+	mask = BFPCTRL_BFS(offset - MCP251X_GPIO_RX0BF);
+	val = value ? mask : 0;
+
+	mutex_lock(&priv->mcp_lock);
+	mcp251x_write_bits(priv->spi, BFPCTRL, mask, val);
+	mutex_unlock(&priv->mcp_lock);
+
+	priv->reg_bfpctrl &= ~mask;
+	priv->reg_bfpctrl |= val;
+}
+
+static void
+mcp251x_gpio_set_multiple(struct gpio_chip *chip,
+			  unsigned long *maskp, unsigned long *bitsp)
+{
+	struct mcp251x_priv *priv = gpiochip_get_data(chip);
+	u8 mask, val;
+
+	mask = FIELD_GET(MCP251X_GPIO_OUTPUT_MASK, maskp[0]);
+	mask = FIELD_PREP(BFPCTRL_BFS_MASK, mask);
+
+	val = FIELD_GET(MCP251X_GPIO_OUTPUT_MASK, bitsp[0]);
+	val = FIELD_PREP(BFPCTRL_BFS_MASK, val);
+
+	if (!mask)
+		return;
+
+	mutex_lock(&priv->mcp_lock);
+	mcp251x_write_bits(priv->spi, BFPCTRL, mask, val);
+	mutex_unlock(&priv->mcp_lock);
+
+	priv->reg_bfpctrl &= ~mask;
+	priv->reg_bfpctrl |= val;
+}
+
+static void mcp251x_gpio_restore(struct spi_device *spi)
+{
+	struct mcp251x_priv *priv = spi_get_drvdata(spi);
+
+	mcp251x_write_reg(spi, BFPCTRL, priv->reg_bfpctrl);
+}
+
+static int mcp251x_gpio_setup(struct mcp251x_priv *priv)
+{
+	struct gpio_chip *gpio = &priv->gpio;
+
+	/* gpiochip handles TX[0..2]RTS and RX[0..1]BF */
+	gpio->label = priv->spi->modalias;
+	gpio->parent = &priv->spi->dev;
+	gpio->owner = THIS_MODULE;
+	gpio->request = mcp251x_gpio_request;
+	gpio->free = mcp251x_gpio_free;
+	gpio->get_direction = mcp251x_gpio_get_direction;
+	gpio->get = mcp251x_gpio_get;
+	gpio->get_multiple = mcp251x_gpio_get_multiple;
+	gpio->set = mcp251x_gpio_set;
+	gpio->set_multiple = mcp251x_gpio_set_multiple;
+	gpio->base = -1;
+	gpio->ngpio = ARRAY_SIZE(mcp251x_gpio_names);
+	gpio->names = mcp251x_gpio_names;
+	gpio->can_sleep = true;
+
+	return gpiochip_add_data(gpio, priv);
+}
+
+static void mcp251x_gpio_remove(struct mcp251x_priv *priv)
+{
+	gpiochip_remove(&priv->gpio);
+}
+#else
+static inline void mcp251x_gpio_restore(struct spi_device *spi)
+{
+}
+
+static inline int mcp251x_gpio_setup(struct mcp251x_priv *priv)
+{
+	return 0;
+}
+
+static inline void mcp251x_gpio_remove(struct mcp251x_priv *priv)
+{
+}
+#endif
+
 static void mcp251x_hw_tx_frame(struct spi_device *spi, u8 *buf,
 				int len, int tx_buf_idx)
 {
@@ -795,6 +1036,7 @@ static void mcp251x_restart_work_handler(struct work_struct *ws)
 		if (priv->after_suspend & AFTER_SUSPEND_POWER) {
 			mcp251x_hw_reset(spi);
 			mcp251x_setup(net, spi);
+			mcp251x_gpio_restore(spi);
 		} else {
 			mcp251x_hw_wake(spi);
 		}
@@ -1195,9 +1437,16 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	devm_can_led_init(net);
 
+	ret = mcp251x_gpio_setup(priv);
+	if (ret)
+		goto error_gpio;
+
 	netdev_info(net, "MCP%x successfully initialized.\n", priv->model);
 	return 0;
 
+error_gpio:
+	mcp251x_gpio_remove(priv);
+
 error_probe:
 	mcp251x_power_enable(priv->power, 0);
 
@@ -1219,6 +1468,8 @@ static int mcp251x_can_remove(struct spi_device *spi)
 
 	unregister_candev(net);
 
+	mcp251x_gpio_remove(priv);
+
 	mcp251x_power_enable(priv->power, 0);
 
 	if (!IS_ERR(priv->clk))
-- 
2.24.0.rc1

