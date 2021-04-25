Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B66A36A72C
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 14:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhDYMY6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 08:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhDYMY6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Apr 2021 08:24:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2828CC061574
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 05:24:18 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lado8-0004Yl-Lx
        for linux-can@vger.kernel.org; Sun, 25 Apr 2021 14:24:16 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C5E4C6169AA
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 12:24:08 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 3889361696C;
        Sun, 25 Apr 2021 12:24:04 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id fa3e08ea;
        Sun, 25 Apr 2021 12:24:02 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 14/14] can: mcp251xfd: add support for internal PLL
Date:   Sun, 25 Apr 2021 14:24:00 +0200
Message-Id: <20210425122400.3276975-15-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210425122400.3276975-1-mkl@pengutronix.de>
References: <20210425122400.3276975-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The PLL is enabled if the configured clock is less than or equal to 10 times
the max clock frequency.

The device will operate with two different SPI speeds. A slow speed determined
by the clock without the PLL enabled, and a fast speed derived from the
frequency with the PLL enabled.

Link: https://lore.kernel.org/r/20201015124401.2766-3-mas@csselectronics.com
Co-developed-by: Magnus Aagaard Sørensen <mas@csselectronics.com>
Signed-off-by: Magnus Aagaard Sørensen <mas@csselectronics.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 75 ++++++++++++++-----
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  3 +
 2 files changed, 60 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index ab6d4c26d82c..73b168957ffd 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -560,6 +560,8 @@ __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
 		return err;
 	}
 
+	if (mode_req == MCP251XFD_REG_CON_MODE_SLEEP)
+		priv->spi->max_speed_hz = priv->spi_max_speed_hz_slow;
 	if (mode_req == MCP251XFD_REG_CON_MODE_SLEEP || nowait)
 		return 0;
 
@@ -652,8 +654,13 @@ static int mcp251xfd_chip_wake(const struct mcp251xfd_priv *priv)
 	 */
 	osc = FIELD_PREP(MCP251XFD_REG_OSC_CLKODIV_MASK,
 			 MCP251XFD_REG_OSC_CLKODIV_10);
+
+	/* We cannot check for the PLL ready bit (either set or
+	 * unset), as the PLL might be enabled. This can happen if the
+	 * system reboots, while the mcp251xfd stays powered.
+	 */
 	osc_reference = MCP251XFD_REG_OSC_OSCRDY;
-	osc_mask = MCP251XFD_REG_OSC_OSCRDY | MCP251XFD_REG_OSC_PLLRDY;
+	osc_mask = MCP251XFD_REG_OSC_OSCRDY;
 
 	/* If the controller is in Sleep Mode the following write only
 	 * removes the "Oscillator Disable" bit and powers it up. All
@@ -763,6 +770,11 @@ static int mcp251xfd_chip_clock_init(const struct mcp251xfd_priv *priv)
 	osc_reference = MCP251XFD_REG_OSC_OSCRDY;
 	osc_mask = MCP251XFD_REG_OSC_OSCRDY | MCP251XFD_REG_OSC_PLLRDY;
 
+	if (priv->pll_enable) {
+		osc |= MCP251XFD_REG_OSC_PLLEN;
+		osc_reference |= MCP251XFD_REG_OSC_PLLRDY;
+	}
+
 	err = regmap_write(priv->map_reg, MCP251XFD_REG_OSC, osc);
 	if (err)
 		return err;
@@ -771,6 +783,8 @@ static int mcp251xfd_chip_clock_init(const struct mcp251xfd_priv *priv)
 	if (err)
 		return err;
 
+	priv->spi->max_speed_hz = priv->spi_max_speed_hz_fast;
+
 	return 0;
 }
 
@@ -2730,8 +2744,9 @@ static int mcp251xfd_register_check_rx_int(struct mcp251xfd_priv *priv)
 }
 
 static int
-mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv,
-			      u32 *dev_id, u32 *effective_speed_hz)
+mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
+			      u32 *effective_speed_hz_slow,
+			      u32 *effective_speed_hz_fast)
 {
 	struct mcp251xfd_map_buf_nocrc *buf_rx;
 	struct mcp251xfd_map_buf_nocrc *buf_tx;
@@ -2750,16 +2765,20 @@ mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv,
 
 	xfer[0].tx_buf = buf_tx;
 	xfer[0].len = sizeof(buf_tx->cmd);
+	xfer[0].speed_hz = priv->spi_max_speed_hz_slow;
 	xfer[1].rx_buf = buf_rx->data;
 	xfer[1].len = sizeof(dev_id);
+	xfer[1].speed_hz = priv->spi_max_speed_hz_fast;
 
 	mcp251xfd_spi_cmd_read_nocrc(&buf_tx->cmd, MCP251XFD_REG_DEVID);
+
 	err = spi_sync_transfer(priv->spi, xfer, ARRAY_SIZE(xfer));
 	if (err)
 		goto out_kfree_buf_tx;
 
 	*dev_id = be32_to_cpup((__be32 *)buf_rx->data);
-	*effective_speed_hz = xfer->effective_speed_hz;
+	*effective_speed_hz_slow = xfer[0].effective_speed_hz;
+	*effective_speed_hz_fast = xfer[1].effective_speed_hz;
 
  out_kfree_buf_tx:
 	kfree(buf_tx);
@@ -2775,34 +2794,45 @@ mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv,
 static int
 mcp251xfd_register_done(const struct mcp251xfd_priv *priv)
 {
-	u32 dev_id, effective_speed_hz;
+	u32 dev_id, effective_speed_hz_slow, effective_speed_hz_fast;
+	unsigned long clk_rate;
 	int err;
 
 	err = mcp251xfd_register_get_dev_id(priv, &dev_id,
-					    &effective_speed_hz);
+					    &effective_speed_hz_slow,
+					    &effective_speed_hz_fast);
 	if (err)
 		return err;
 
+	clk_rate = clk_get_rate(priv->clk);
+
 	netdev_info(priv->ndev,
-		    "%s rev%lu.%lu (%cRX_INT %cMAB_NO_WARN %cCRC_REG %cCRC_RX %cCRC_TX %cECC %cHD c:%u.%02uMHz m:%u.%02uMHz r:%u.%02uMHz e:%u.%02uMHz) successfully initialized.\n",
+		    "%s rev%lu.%lu (%cRX_INT %cPLL %cMAB_NO_WARN %cCRC_REG %cCRC_RX %cCRC_TX %cECC %cHD o:%lu.%02luMHz c:%u.%02uMHz m:%u.%02uMHz rs:%u.%02uMHz es:%u.%02uMHz rf:%u.%02uMHz ef:%u.%02uMHz) successfully initialized.\n",
 		    mcp251xfd_get_model_str(priv),
 		    FIELD_GET(MCP251XFD_REG_DEVID_ID_MASK, dev_id),
 		    FIELD_GET(MCP251XFD_REG_DEVID_REV_MASK, dev_id),
 		    priv->rx_int ? '+' : '-',
+		    priv->pll_enable ? '+' : '-',
 		    MCP251XFD_QUIRK_ACTIVE(MAB_NO_WARN),
 		    MCP251XFD_QUIRK_ACTIVE(CRC_REG),
 		    MCP251XFD_QUIRK_ACTIVE(CRC_RX),
 		    MCP251XFD_QUIRK_ACTIVE(CRC_TX),
 		    MCP251XFD_QUIRK_ACTIVE(ECC),
 		    MCP251XFD_QUIRK_ACTIVE(HALF_DUPLEX),
+		    clk_rate / 1000000,
+		    clk_rate % 1000000 / 1000 / 10,
 		    priv->can.clock.freq / 1000000,
 		    priv->can.clock.freq % 1000000 / 1000 / 10,
 		    priv->spi_max_speed_hz_orig / 1000000,
 		    priv->spi_max_speed_hz_orig % 1000000 / 1000 / 10,
-		    priv->spi->max_speed_hz / 1000000,
-		    priv->spi->max_speed_hz % 1000000 / 1000 / 10,
-		    effective_speed_hz / 1000000,
-		    effective_speed_hz % 1000000 / 1000 / 10);
+		    priv->spi_max_speed_hz_slow / 1000000,
+		    priv->spi_max_speed_hz_slow % 1000000 / 1000 / 10,
+		    effective_speed_hz_slow / 1000000,
+		    effective_speed_hz_slow % 1000000 / 1000 / 10,
+		    priv->spi_max_speed_hz_fast / 1000000,
+		    priv->spi_max_speed_hz_fast % 1000000 / 1000 / 10,
+		    effective_speed_hz_fast / 1000000,
+		    effective_speed_hz_fast % 1000000 / 1000 / 10);
 
 	return 0;
 }
@@ -2927,6 +2957,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	struct gpio_desc *rx_int;
 	struct regulator *reg_vdd, *reg_xceiver;
 	struct clk *clk;
+	bool pll_enable = false;
 	u32 freq;
 	int err;
 
@@ -2969,12 +3000,8 @@ static int mcp251xfd_probe(struct spi_device *spi)
 		return -ERANGE;
 	}
 
-	if (freq <= MCP251XFD_SYSCLOCK_HZ_MAX / MCP251XFD_OSC_PLL_MULTIPLIER) {
-		dev_err(&spi->dev,
-			"Oscillator frequency (%u Hz) is too low and PLL is not supported.\n",
-			freq);
-		return -ERANGE;
-	}
+	if (freq <= MCP251XFD_SYSCLOCK_HZ_MAX / MCP251XFD_OSC_PLL_MULTIPLIER)
+		pll_enable = true;
 
 	ndev = alloc_candev(sizeof(struct mcp251xfd_priv),
 			    MCP251XFD_TX_OBJ_NUM_MAX);
@@ -2990,6 +3017,8 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv = netdev_priv(ndev);
 	spi_set_drvdata(spi, priv);
 	priv->can.clock.freq = freq;
+	if (pll_enable)
+		priv->can.clock.freq *= MCP251XFD_OSC_PLL_MULTIPLIER;
 	priv->can.do_set_mode = mcp251xfd_set_mode;
 	priv->can.do_get_berr_counter = mcp251xfd_get_berr_counter;
 	priv->can.bittiming_const = &mcp251xfd_bittiming_const;
@@ -3002,6 +3031,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->spi = spi;
 	priv->rx_int = rx_int;
 	priv->clk = clk;
+	priv->pll_enable = pll_enable;
 	priv->reg_vdd = reg_vdd;
 	priv->reg_xceiver = reg_xceiver;
 
@@ -3039,7 +3069,16 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	 *
 	 */
 	priv->spi_max_speed_hz_orig = spi->max_speed_hz;
-	spi->max_speed_hz = min(spi->max_speed_hz, freq / 2 / 1000 * 850);
+	priv->spi_max_speed_hz_slow = min(spi->max_speed_hz,
+					  freq / 2 / 1000 * 850);
+	if (priv->pll_enable)
+		priv->spi_max_speed_hz_fast = min(spi->max_speed_hz,
+						  freq *
+						  MCP251XFD_OSC_PLL_MULTIPLIER /
+						  2 / 1000 * 850);
+	else
+		priv->spi_max_speed_hz_fast = priv->spi_max_speed_hz_slow;
+	spi->max_speed_hz = priv->spi_max_speed_hz_slow;
 	spi->bits_per_word = 8;
 	spi->rt = true;
 	err = spi_setup(spi);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 1002f3902ad2..9fd147b0a788 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -591,6 +591,8 @@ struct mcp251xfd_priv {
 
 	struct spi_device *spi;
 	u32 spi_max_speed_hz_orig;
+	u32 spi_max_speed_hz_fast;
+	u32 spi_max_speed_hz_slow;
 
 	struct mcp251xfd_tef_ring tef[1];
 	struct mcp251xfd_tx_ring tx[1];
@@ -607,6 +609,7 @@ struct mcp251xfd_priv {
 
 	struct gpio_desc *rx_int;
 	struct clk *clk;
+	bool pll_enable;
 	struct regulator *reg_vdd;
 	struct regulator *reg_xceiver;
 
-- 
2.30.2


