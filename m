Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D5E28F293
	for <lists+linux-can@lfdr.de>; Thu, 15 Oct 2020 14:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgJOMpB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Oct 2020 08:45:01 -0400
Received: from mailrelay4-2.pub.mailoutpod1-cph3.one.com ([46.30.212.3]:33776
        "EHLO mailrelay4-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726924AbgJOMpA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Oct 2020 08:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csselectronics.com; s=20191106;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=yAUNJUDyl1Ch6YqKAxH2KU+FS5QkYIuyYHtbFsqPcAg=;
        b=0c2tC5bu1qstcIGFx0P2PfdzlqneQg3TN40Ud6kJNnHKtWN4U98CVLxx9oXzIy7YyDDM/zVxrrgzj
         DgMIa4pyHDqJjRc9vIZi1CkMJ06lDHSJrkkXpW0DNMS1dXvcm8+kwsmzdbsO0oUBLYyevFe2EEj9WK
         Od7m6SAeFlE+d5DMJN8HT/dzWY5S6RFg72ERZTkYHfG9nf2hT1mIb1OvLamgT6t5v7ZbvIRugA+Ey1
         OOkSInISGxW7wEXq5pX9gUexkSMGOs8MxBcdMImaqV6p0YkAaZlAMjOYQ6xW6uxqn41z8f5Oi1NTDi
         HX1H5dJNWbUud/4Z8KzRbOUQalbdANQ==
X-HalOne-Cookie: 6b75d09391896f64dd35ced7950cc6b93428e29c
X-HalOne-ID: 3af58ae4-0ee4-11eb-a2b3-d0431ea8bb10
Received: from localhost.localdomain (unknown [5.103.118.41])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 3af58ae4-0ee4-11eb-a2b3-d0431ea8bb10;
        Thu, 15 Oct 2020 12:44:56 +0000 (UTC)
From:   =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>
To:     linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>
Subject: [PATCH 2/2] Enable support for internal PLL in mcp251xfd.
Date:   Thu, 15 Oct 2020 13:44:01 +0100
Message-Id: <20201015124401.2766-3-mas@csselectronics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201015124401.2766-1-mas@csselectronics.com>
References: <20201015124401.2766-1-mas@csselectronics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The PLL is enabled if the configured clock is less than or equal to 10 times the max clock frequency.

The device will operate with two different SPI speeds. A slow speed determined by the clock without the PLL enabled, and a fast speed derived from the frequency with the PLL enabled.
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 89 ++++++++++++++++---
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  3 +
 2 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 3c440f9c8..2436eaed2 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -561,6 +561,49 @@ static int mcp251xfd_chip_wake(const struct mcp251xfd_priv *priv)
 	return 0;
 }
 
+static int mcp251xfd_chip_setup_clock(const struct mcp251xfd_priv *priv)
+{
+	u32 osc, osc_reference, osc_mask;
+	int err;
+
+	if (priv->pll_enabled == false) {
+		return 0;
+	}
+
+	err = regmap_read(priv->map_reg, MCP251XFD_REG_OSC, &osc);
+	if (err)
+		return err;
+
+	osc |= MCP251XFD_REG_OSC_PLLEN;
+	osc_reference = MCP251XFD_REG_OSC_OSCRDY | MCP251XFD_REG_OSC_PLLRDY;
+	osc_mask = MCP251XFD_REG_OSC_OSCRDY | MCP251XFD_REG_OSC_PLLRDY;
+
+	err = regmap_write(priv->map_reg, MCP251XFD_REG_OSC, osc);
+	if (err)
+		return err;
+
+	/* Wait for "Oscillator Ready" and "PLL Ready" bit */
+	err = regmap_read_poll_timeout(priv->map_reg, MCP251XFD_REG_OSC, osc,
+				       (osc & osc_mask) == osc_reference,
+				       MCP251XFD_OSC_STAB_SLEEP_US,
+				       MCP251XFD_OSC_STAB_TIMEOUT_US);
+	if (mcp251xfd_osc_invalid(osc)) {
+		netdev_err(priv->ndev,
+			   "Failed to detect %s (osc=0x%08x).\n",
+			   mcp251xfd_get_model_str(priv), osc);
+		return -ENODEV;
+	} else if (err == -ETIMEDOUT) {
+		netdev_err(priv->ndev,
+			   "Timeout waiting for Oscillator Ready (osc=0x%08x, osc_reference=0x%08x)\n",
+			   osc, osc_reference);
+		return -ETIMEDOUT;
+	} else if (err) {
+		return err;
+	}
+
+	return 0;
+}
+
 static int mcp251xfd_chip_softreset_do(const struct mcp251xfd_priv *priv)
 {
 	const __be16 cmd = mcp251xfd_cmd_reset();
@@ -2568,11 +2611,12 @@ mcp251xfd_register_done(const struct mcp251xfd_priv *priv)
 		return err;
 
 	netdev_info(priv->ndev,
-		    "%s rev%lu.%lu (%cRX_INT %cMAB_NO_WARN %cCRC_REG %cCRC_RX %cCRC_TX %cECC %cHD c:%u.%02uMHz m:%u.%02uMHz r:%u.%02uMHz e:%u.%02uMHz) successfully initialized.\n",
+		    "%s rev%lu.%lu (%cRX_INT %cPLL %cMAB_NO_WARN %cCRC_REG %cCRC_RX %cCRC_TX %cECC %cHD c:%u.%02uMHz m:%u.%02uMHz rs:%u.%02uMHz rf:%u.%02uMHz e:%u.%02uMHz) successfully initialized.\n",
 		    mcp251xfd_get_model_str(priv),
 		    FIELD_GET(MCP251XFD_REG_DEVID_ID_MASK, dev_id),
 		    FIELD_GET(MCP251XFD_REG_DEVID_REV_MASK, dev_id),
 		    priv->rx_int ? '+' : '-',
+		    priv->pll_enabled ? '+' : '-',
 		    MCP251XFD_QUIRK_ACTIVE(MAB_NO_WARN),
 		    MCP251XFD_QUIRK_ACTIVE(CRC_REG),
 		    MCP251XFD_QUIRK_ACTIVE(CRC_RX),
@@ -2583,8 +2627,10 @@ mcp251xfd_register_done(const struct mcp251xfd_priv *priv)
 		    priv->can.clock.freq % 1000000 / 1000 / 10,
 		    priv->spi_max_speed_hz_orig / 1000000,
 		    priv->spi_max_speed_hz_orig % 1000000 / 1000 / 10,
-		    priv->spi->max_speed_hz / 1000000,
-		    priv->spi->max_speed_hz % 1000000 / 1000 / 10,
+		    priv->spi_max_speed_hz_slow / 1000000,
+		    priv->spi_max_speed_hz_slow % 1000000 / 1000 / 10,
+		    priv->spi_max_speed_hz_fast / 1000000,
+		    priv->spi_max_speed_hz_fast % 1000000 / 1000 / 10,
 		    effective_speed_hz / 1000000,
 		    effective_speed_hz % 1000000 / 1000 / 10);
 
@@ -2614,6 +2660,12 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
 	if (err)
 		goto out_chip_set_mode_sleep;
 
+	err = mcp251xfd_chip_setup_clock(priv);
+	if (err)
+		return err;
+
+	priv->spi->max_speed_hz = priv->spi_max_speed_hz_fast;
+
 	err = mcp251xfd_register_chip_detect(priv);
 	if (err)
 		goto out_chip_set_mode_sleep;
@@ -2706,6 +2758,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	struct clk *clk;
 	u32 freq;
 	int err;
+	bool pll_enabled = false;
 
 	rx_int = devm_gpiod_get_optional(&spi->dev, "microchip,rx-int",
 					 GPIOD_IN);
@@ -2747,10 +2800,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	}
 
 	if (freq <= MCP251XFD_SYSCLOCK_HZ_MAX / MCP251XFD_OSC_PLL_MULTIPLIER) {
-		dev_err(&spi->dev,
-			"Oscillator frequency (%u Hz) is too low and PLL is not supported.\n",
-			freq);
-		return -ERANGE;
+		pll_enabled = true;
 	}
 
 	ndev = alloc_candev(sizeof(struct mcp251xfd_priv),
@@ -2766,7 +2816,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 
 	priv = netdev_priv(ndev);
 	spi_set_drvdata(spi, priv);
-	priv->can.clock.freq = freq;
+	priv->can.clock.freq = pll_enabled ? freq * MCP251XFD_OSC_PLL_MULTIPLIER : freq;
 	priv->can.do_set_mode = mcp251xfd_set_mode;
 	priv->can.do_get_berr_counter = mcp251xfd_get_berr_counter;
 	priv->can.bittiming_const = &mcp251xfd_bittiming_const;
@@ -2778,6 +2828,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->spi = spi;
 	priv->rx_int = rx_int;
 	priv->clk = clk;
+	priv->pll_enabled = pll_enabled;
 	priv->reg_vdd = reg_vdd;
 	priv->reg_xceiver = reg_xceiver;
 
@@ -2817,7 +2868,15 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	 *
 	 */
 	priv->spi_max_speed_hz_orig = spi->max_speed_hz;
-	spi->max_speed_hz = min(spi->max_speed_hz, freq / 2 / 1000 * 850);
+
+	priv->spi_max_speed_hz_slow = min(spi->max_speed_hz, freq / 2 / 1000 * 850);
+	if (priv->pll_enabled == true) {
+		priv->spi_max_speed_hz_fast = min(spi->max_speed_hz, freq * MCP251XFD_OSC_PLL_MULTIPLIER / 2 / 1000 * 850);
+	} else {
+		priv->spi_max_speed_hz_fast = priv->spi_max_speed_hz_slow;
+	}
+
+	spi->max_speed_hz = priv->spi_max_speed_hz_slow;
 	spi->bits_per_word = 8;
 	spi->rt = true;
 	err = spi_setup(spi);
@@ -2866,6 +2925,8 @@ static int __maybe_unused mcp251xfd_runtime_suspend(struct device *device)
 	int err;
 	const struct mcp251xfd_priv *priv = dev_get_drvdata(device);
 
+	priv->spi->max_speed_hz = priv->spi_max_speed_hz_slow;
+
 	/* Activate Low Power Mode on Oscillator Disable. This only
 	 * works on the MCP2518FD. The MCP2517FD will go into normal
 	 * Sleep Mode instead.
@@ -2887,7 +2948,7 @@ static int __maybe_unused mcp251xfd_runtime_suspend(struct device *device)
 	if (err)
 		return err;
 
-	return err;
+	return 0;
 }
 
 static int __maybe_unused mcp251xfd_runtime_resume(struct device *device)
@@ -2907,7 +2968,13 @@ static int __maybe_unused mcp251xfd_runtime_resume(struct device *device)
 	if (err)
 		return err;
 
-	return err;
+	err = mcp251xfd_chip_setup_clock(priv);
+	if (err)
+		return err;
+
+	priv->spi->max_speed_hz = priv->spi_max_speed_hz_fast;
+
+	return 0;
 }
 
 static const struct dev_pm_ops mcp251xfd_pm_ops = {
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index fa1246e39..fc1a3ba5a 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -579,6 +579,8 @@ struct mcp251xfd_priv {
 
 	struct spi_device *spi;
 	u32 spi_max_speed_hz_orig;
+	u32 spi_max_speed_hz_fast;
+	u32 spi_max_speed_hz_slow;
 
 	struct mcp251xfd_tef_ring tef;
 	struct mcp251xfd_tx_ring tx[1];
@@ -591,6 +593,7 @@ struct mcp251xfd_priv {
 
 	struct gpio_desc *rx_int;
 	struct clk *clk;
+	bool pll_enabled;
 	struct regulator *reg_vdd;
 	struct regulator *reg_xceiver;
 
-- 
2.20.1

