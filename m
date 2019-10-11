Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F45D417C
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2019 15:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfJKNis (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 11 Oct 2019 09:38:48 -0400
Received: from mx.krause.de ([88.79.216.98]:37431 "EHLO mx.krause.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbfJKNis (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 11 Oct 2019 09:38:48 -0400
Received: from [172.20.10.125] (port=46355 helo=mail.horstmanngroup.de)
        by mx.krause.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <t.schluessler@krause.de>)
        id 1iIv7z-0002zV-2E; Fri, 11 Oct 2019 15:38:43 +0200
Received: from HG-SRV-053.HG.local (172.20.10.125) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 11 Oct
 2019 15:38:43 +0200
Received: from kb-ctp-power.localdomain (172.20.35.17) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 11 Oct 2019 15:38:43 +0200
X-CTCH-RefID: str=0001.0A0C0201.5DA085E3.008F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   =?UTF-8?q?Timo=20Schl=C3=BC=C3=9Fler?= <schluessler@krause.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     =?UTF-8?q?Timo=20Schl=C3=BC=C3=9Fler?= <schluessler@krause.de>
Subject: [PATCH v3 3/3] can: mcp251x: Add GPIO support
Date:   Fri, 11 Oct 2019 15:38:21 +0200
Message-ID: <1570801101-27864-3-git-send-email-schluessler@krause.de>
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

The mcp251x variants feature 3 general purpose digital inputs and 2
outputs. With this patch they are accessible through the gpio framework.

Signed-off-by: Timo Schlüßler <schluessler@krause.de>
---
 drivers/net/can/spi/mcp251x.c | 232 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 8d65b73..fb50392 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -38,6 +38,8 @@
 #include <linux/spi/spi.h>
 #include <linux/uaccess.h>
 #include <linux/regulator/consumer.h>
+#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 
 /* SPI interface instruction set */
 #define INSTRUCTION_WRITE	0x02
@@ -52,6 +54,15 @@
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
@@ -225,6 +236,10 @@ struct mcp251x_priv {
 	struct regulator *power;
 	struct regulator *transceiver;
 	struct clk *clk;
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gpio;
+	u8 reg_bfpctrl;
+#endif
 };
 
 #define MCP251X_IS(_model) \
@@ -236,6 +251,10 @@ static inline int mcp251x_is_##_model(struct spi_device *spi) \
 
 MCP251X_IS(2510);
 
+#ifdef CONFIG_GPIOLIB
+static void mcp251x_gpio_restore(struct spi_device *spi);
+#endif
+
 static void mcp251x_clean(struct net_device *net)
 {
 	struct mcp251x_priv *priv = netdev_priv(net);
@@ -761,6 +780,9 @@ static void mcp251x_restart_work_handler(struct work_struct *ws)
 		if (priv->after_suspend & AFTER_SUSPEND_POWER) {
 			mcp251x_hw_reset(spi);
 			mcp251x_setup(net, spi);
+#ifdef CONFIG_GPIOLIB
+			mcp251x_gpio_restore(spi);
+#endif
 		} else {
 			mcp251x_hw_wake(spi);
 		}
@@ -918,6 +940,201 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
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
+static const char * const mcp251x_gpio_names[] = {
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
+	priv->reg_bfpctrl = priv->reg_bfpctrl | bit;
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
+
+	priv->reg_bfpctrl = priv->reg_bfpctrl & ~bit;
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
+	} else {
+		return -EINVAL;
+	}
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
+	u8 mask, content;
+
+	if (offset < RX0BF)
+		return;
+
+	mask = BFPCTRL_B0BFS << (offset - RX0BF);
+	content = value ? mask : 0;
+
+	mutex_lock(&priv->mcp_lock);
+	mcp251x_write_bits(priv->spi, BFPCTRL, mask, content);
+	mutex_unlock(&priv->mcp_lock);
+
+	priv->reg_bfpctrl = (priv->reg_bfpctrl & ~mask) | content;
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
+
+	priv->reg_bfpctrl = (priv->reg_bfpctrl & ~reg_mask) | value;
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
+
+#endif // CONFIG_GPIOLIB
+
 static int mcp251x_open(struct net_device *net)
 {
 	struct mcp251x_priv *priv = netdev_priv(net);
@@ -1134,9 +1351,20 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
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
 
@@ -1157,6 +1385,10 @@ static int mcp251x_can_remove(struct spi_device *spi)
 
 	unregister_candev(net);
 
+#ifdef CONFIG_GPIOLIB
+	mcp251x_gpio_remove(priv);
+#endif
+
 	mcp251x_power_enable(priv->power, 0);
 
 	clk_disable_unprepare(priv->clk);
-- 
2.7.2

