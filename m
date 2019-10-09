Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEDDCD1AF8
	for <lists+linux-can@lfdr.de>; Wed,  9 Oct 2019 23:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJIVbj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Oct 2019 17:31:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33263 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJIVbj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Oct 2019 17:31:39 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iIJYX-0002aS-OW; Wed, 09 Oct 2019 23:31:37 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Timo=20Schl=C3=BC=C3=9Fler?= <t.schluessler@krause.de>
Subject: [PATCH v2] can: mcp251x: add GPIO support
Date:   Wed,  9 Oct 2019 23:31:36 +0200
Message-Id: <20191009213136.28776-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0
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

From: Timo Schlüßler <t.schluessler@krause.de>

---
Hello,

for easier reivew send via git-send-email

Marc

 drivers/net/can/spi/mcp251x.c | 208 ++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index bee9f7b8dad6..070da1ff7a18 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -39,6 +39,8 @@
 #include <linux/spi/spi.h>
 #include <linux/uaccess.h>
 #include <linux/regulator/consumer.h>
+#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 
 /* SPI interface instruction set */
 #define INSTRUCTION_WRITE	0x02
@@ -53,6 +55,15 @@
 #define INSTRUCTION_RTS(n)	(0x80 | ((n) & 0x07))
 
 /* MPC251x registers */
+#define BFPCTRL			0x0c
+#  define BFPCTRL_B0BFE		0x04
+#  define BFPCTRL_B1BFE		0x08
+#  define BFPCTRL_B0BFS		0x10
+#  define BFPCTRL_B1BFS		0x20
+#define TXRTSCTRL		0x0d
+#  define TXRTSCTRL_B0RTS	0x08
+#  define TXRTSCTRL_B1RTS	0x10
+#  define TXRTSCTRL_B2RTS	0x20
 #define CANSTAT	      0x0e
 #define CANCTRL	      0x0f
 #  define CANCTRL_REQOP_MASK	    0xe0
@@ -226,6 +237,9 @@ struct mcp251x_priv {
 	struct regulator *power;
 	struct regulator *transceiver;
 	struct clk *clk;
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gpio;
+#endif
 };
 
 #define MCP251X_IS(_model) \
@@ -581,6 +595,8 @@ static int mcp251x_hw_reset(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	/* TODO: What to do with the GPIOs here? Reset last state? */
+
 	/* Wait for oscillator startup timer after reset */
 	mdelay(MCP251X_OST_DELAY_MS);
 
@@ -873,6 +889,183 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_GPIOLIB
+
+#define TX0RTS 0
+#define TX1RTS 1
+#define TX2RTS 2
+#define RX0BF 3
+#define RX1BF 4
+#define NGPIO 5
+
+static const char * mcp251x_gpio_names[] = {
+	"TX0RTS",
+	"TX1RTS",
+	"TX2RTS",
+	"RX0BF",
+	"RX1BF"
+};
+
+static int mcp251x_gpio_request(struct gpio_chip *chip,
+				unsigned int offset)
+{
+	struct mcp251x_priv *priv = gpiochip_get_data(chip);
+	u8 bit = BFPCTRL_B0BFE << (offset - RX0BF);
+
+	if (offset >= NGPIO)
+		return -EINVAL;
+	if (offset <= TX2RTS) // nothing to be done for inputs
+		return 0;
+
+	mutex_lock(&priv->mcp_lock);
+	mcp251x_write_bits(priv->spi, BFPCTRL, bit, bit);
+	mutex_unlock(&priv->mcp_lock);
+
+	return 0;
+}
+
+static void mcp251x_gpio_free(struct gpio_chip *chip,
+			      unsigned int offset)
+{
+	struct mcp251x_priv *priv = gpiochip_get_data(chip);
+	u8 bit = BFPCTRL_B0BFE << (offset - RX0BF);
+
+	if (offset >= NGPIO)
+		return;
+	if (offset <= TX2RTS) // nothing to be done for inputs
+		return;
+
+	mutex_lock(&priv->mcp_lock);
+	mcp251x_write_bits(priv->spi, BFPCTRL, bit, 0);
+	mutex_unlock(&priv->mcp_lock);
+}
+
+static int mcp251x_gpio_get_direction(struct gpio_chip *chip,
+				      unsigned int offset)
+{
+	if (offset <= TX2RTS)
+		return GPIOF_DIR_IN;
+	else if (offset <= RX1BF)
+		return GPIOF_DIR_OUT;
+
+	return -EINVAL;
+}
+
+static int mcp251x_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mcp251x_priv *priv = gpiochip_get_data(chip);
+	u8 reg, mask, val;
+
+	if (offset <= TX2RTS) {
+		reg = TXRTSCTRL;
+		mask = TXRTSCTRL_B0RTS << offset;
+	} else if (offset <= RX1BF) {
+		reg = BFPCTRL;
+		mask = BFPCTRL_B0BFS << (offset - RX0BF);
+	} else
+		return -EINVAL;
+
+	mutex_lock(&priv->mcp_lock);
+	val = mcp251x_read_reg(priv->spi, reg);
+	mutex_unlock(&priv->mcp_lock);
+
+	if (val & mask)
+		return 1;
+	return 0;
+}
+
+static int mcp251x_gpio_get_multiple(struct gpio_chip *chip,
+				     unsigned long *mask, unsigned long *bits)
+{
+	struct mcp251x_priv *priv = gpiochip_get_data(chip);
+	unsigned long retbits = 0;
+
+	mutex_lock(&priv->mcp_lock);
+
+	if (mask[0] & GENMASK(TX2RTS, TX0RTS))
+		retbits |= mcp251x_read_reg(priv->spi, TXRTSCTRL)
+					>> __ffs(TXRTSCTRL_B0RTS);
+	if (mask[0] & GENMASK(RX1BF, RX0BF))
+		retbits |= (mcp251x_read_reg(priv->spi, BFPCTRL)
+					>> (__ffs(BFPCTRL_B0BFS) - RX0BF))
+					& GENMASK(RX1BF, RX0BF);
+
+	mutex_unlock(&priv->mcp_lock);
+
+	bits[0] = retbits;
+	return 0;
+}
+
+static void mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			     int value)
+{
+	struct mcp251x_priv *priv = gpiochip_get_data(chip);
+	u8 mask;
+
+	if (offset < RX0BF)
+		return;
+
+	mask = BFPCTRL_B0BFS << (offset - RX0BF);
+
+	mutex_lock(&priv->mcp_lock);
+	mcp251x_write_bits(priv->spi, BFPCTRL, mask, value ? mask : 0);
+	mutex_unlock(&priv->mcp_lock);
+}
+
+static void mcp251x_gpio_set_multiple(struct gpio_chip *chip,
+				      unsigned long *mask, unsigned long *bits)
+{
+	struct mcp251x_priv *priv = gpiochip_get_data(chip);
+	u8 reg_mask = 0, value = 0;
+	int pin;
+
+	for (pin = RX0BF; pin <= RX1BF; pin++) {
+		if (test_bit(pin, mask)) {
+			u8 mask_val = BFPCTRL_B0BFS << (pin - RX0BF);
+
+			reg_mask |= mask_val;
+			if (test_bit(pin, bits))
+				value |= mask_val;
+		}
+	}
+
+	if (!reg_mask)
+		return;
+
+	mutex_lock(&priv->mcp_lock);
+	mcp251x_write_bits(priv->spi, BFPCTRL, reg_mask, value);
+	mutex_unlock(&priv->mcp_lock);
+}
+
+static int mcp251x_gpio_setup(struct mcp251x_priv *priv)
+{
+	struct gpio_chip *gpio = &priv->gpio;
+
+	/* gpiochip handles TX[0..2]RTS and RX[0..1]BF */
+	gpio->label                = priv->spi->modalias;
+	gpio->parent               = &priv->spi->dev;
+	gpio->owner                = THIS_MODULE;
+	gpio->request              = mcp251x_gpio_request;
+	gpio->free                 = mcp251x_gpio_free;
+	gpio->get_direction        = mcp251x_gpio_get_direction;
+	gpio->get                  = mcp251x_gpio_get;
+	gpio->get_multiple         = mcp251x_gpio_get_multiple;
+	gpio->set                  = mcp251x_gpio_set;
+	gpio->set_multiple         = mcp251x_gpio_set_multiple;
+	gpio->base                 = -1;
+	gpio->ngpio                = NGPIO;
+	gpio->names                = mcp251x_gpio_names;
+	gpio->can_sleep            = 1;
+
+	return gpiochip_add_data(gpio, priv);
+}
+
+static void mcp251x_gpio_remove(struct mcp251x_priv *priv)
+{
+	gpiochip_remove(&priv->gpio);
+}
+#endif // CONFIG_GPIOLIB
+
 static int mcp251x_open(struct net_device *net)
 {
 	struct mcp251x_priv *priv = netdev_priv(net);
@@ -1089,9 +1282,20 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	devm_can_led_init(net);
 
+#ifdef CONFIG_GPIOLIB
+	ret = mcp251x_gpio_setup(priv);
+	if (ret)
+		goto error_gpio;
+#endif
+
 	netdev_info(net, "MCP%x successfully initialized.\n", priv->model);
 	return 0;
 
+#ifdef CONFIG_GPIOLIB
+error_gpio:
+	mcp251x_gpio_remove(priv);
+#endif
+
 error_probe:
 	mcp251x_power_enable(priv->power, 0);
 
@@ -1112,6 +1316,10 @@ static int mcp251x_can_remove(struct spi_device *spi)
 
 	unregister_candev(net);
 
+#ifdef CONFIG_GPIOLIB
+	mcp251x_gpio_remove(priv);
+#endif
+
 	mcp251x_power_enable(priv->power, 0);
 
 	clk_disable_unprepare(priv->clk);
-- 
2.23.0

