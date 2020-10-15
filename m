Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116C128F291
	for <lists+linux-can@lfdr.de>; Thu, 15 Oct 2020 14:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgJOMo6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Oct 2020 08:44:58 -0400
Received: from mailrelay4-2.pub.mailoutpod1-cph3.one.com ([46.30.212.3]:33510
        "EHLO mailrelay4-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbgJOMo6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Oct 2020 08:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csselectronics.com; s=20191106;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=MmwV63olqIiWvduf0IOuhKGkzvUu48AzxAxhQCQj4Dk=;
        b=awjD6pxnVXWoyYfQyxTZ3OtTaQMD7XSyu0ojV8nyc4AJIuykjnJJhg3em2hxUQCUbEuPzxjShcFve
         iBUKr5odYOGS1hYJwcN/XqHEqxN/f3w/4vRS70Btu2ez8+ZI5Vc0KeNDTvQ34ZQT8KyAoLi0lNvijH
         3nzVNtuui0uqkO7fhfhl9omcD29icD9cYDKT7C0yBFz6Jc93mnXWF+xmRcgZjLFQ5oIYvl3dexMSCL
         8MJD2loZotN8iozpzpJviiCbReeYXDd1pkAm/eyQcIJQ3K97UIoTnm7qJhJl8RdlgbgRZfSMc59nUT
         NgypraNME450dUC5C4YQ0fcZiQbriug==
X-HalOne-Cookie: 8f127eb5f55c86349f56edaf86259539a56bc899
X-HalOne-ID: 39a5e244-0ee4-11eb-a2b3-d0431ea8bb10
Received: from localhost.localdomain (unknown [5.103.118.41])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 39a5e244-0ee4-11eb-a2b3-d0431ea8bb10;
        Thu, 15 Oct 2020 12:44:54 +0000 (UTC)
From:   =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>
To:     linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>
Subject: [PATCH 1/2] Preparation for support of internal PLL in mcp251xfd.
Date:   Thu, 15 Oct 2020 13:44:00 +0100
Message-Id: <20201015124401.2766-2-mas@csselectronics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201015124401.2766-1-mas@csselectronics.com>
References: <20201015124401.2766-1-mas@csselectronics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Moves all calls which would alter the clock setup, apart from probe, into PM calls.

---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 91 ++++++++++---------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index c3f49543f..3c440f9c8 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -519,25 +519,22 @@ static inline bool mcp251xfd_osc_invalid(u32 reg)
 	return reg == 0x0 || reg == 0xffffffff;
 }
 
-static int mcp251xfd_chip_clock_enable(const struct mcp251xfd_priv *priv)
+static int mcp251xfd_chip_wake(const struct mcp251xfd_priv *priv)
 {
 	u32 osc, osc_reference, osc_mask;
 	int err;
 
-	/* Set Power On Defaults for "Clock Output Divisor" and remove
-	 * "Oscillator Disable" bit.
+	/* For normal sleep in MCP2517FD and MCP2518FD, clearing
+	 * "Oscillator Disable" will wake it. For low power mode in
+	 * MCP2518DF, asserting the chip will wake it. Writing to
+	 * the Oscillator register will wake it in both cases.
 	 */
+
 	osc = FIELD_PREP(MCP251XFD_REG_OSC_CLKODIV_MASK,
 			 MCP251XFD_REG_OSC_CLKODIV_10);
 	osc_reference = MCP251XFD_REG_OSC_OSCRDY;
-	osc_mask = MCP251XFD_REG_OSC_OSCRDY | MCP251XFD_REG_OSC_PLLRDY;
+	osc_mask = MCP251XFD_REG_OSC_OSCRDY;
 
-	/* Note:
-	 *
-	 * If the controller is in Sleep Mode the following write only
-	 * removes the "Oscillator Disable" bit and powers it up. All
-	 * other bits are unaffected.
-	 */
 	err = regmap_write(priv->map_reg, MCP251XFD_REG_OSC, osc);
 	if (err)
 		return err;
@@ -569,13 +566,6 @@ static int mcp251xfd_chip_softreset_do(const struct mcp251xfd_priv *priv)
 	const __be16 cmd = mcp251xfd_cmd_reset();
 	int err;
 
-	/* The Set Mode and SPI Reset command only seems to works if
-	 * the controller is not in Sleep Mode.
-	 */
-	err = mcp251xfd_chip_clock_enable(priv);
-	if (err)
-		return err;
-
 	err = mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_CONFIG);
 	if (err)
 		return err;
@@ -652,20 +642,6 @@ static int mcp251xfd_chip_softreset(const struct mcp251xfd_priv *priv)
 
 static int mcp251xfd_chip_clock_init(const struct mcp251xfd_priv *priv)
 {
-	u32 osc;
-	int err;
-
-	/* Activate Low Power Mode on Oscillator Disable. This only
-	 * works on the MCP2518FD. The MCP2517FD will go into normal
-	 * Sleep Mode instead.
-	 */
-	osc = MCP251XFD_REG_OSC_LPMEN |
-		FIELD_PREP(MCP251XFD_REG_OSC_CLKODIV_MASK,
-			   MCP251XFD_REG_OSC_CLKODIV_10);
-	err = regmap_write(priv->map_reg, MCP251XFD_REG_OSC, osc);
-	if (err)
-		return err;
-
 	/* Set Time Base Counter Prescaler to 1.
 	 *
 	 * This means an overflow of the 32 bit Time Base Counter
@@ -1020,17 +996,13 @@ static int mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
 
 	mcp251xfd_chip_interrupts_disable(priv);
 	mcp251xfd_chip_rx_int_disable(priv);
-	return mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_SLEEP);
+	return mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_CONFIG);
 }
 
 static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 {
 	int err;
 
-	err = mcp251xfd_chip_softreset(priv);
-	if (err)
-		goto out_chip_stop;
-
 	err = mcp251xfd_chip_clock_init(priv);
 	if (err)
 		goto out_chip_stop;
@@ -2660,12 +2632,9 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
 
 	/* Put controller into sleep mode and let pm_runtime_put()
 	 * disable the clocks and vdd. If CONFIG_PM is not enabled,
-	 * the clocks and vdd will stay powered.
+	 * the clocks and vdd will stay powered, and the chip will
+	 * not enter sleep.
 	 */
-	err = mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_SLEEP);
-	if (err)
-		goto out_unregister_candev;
-
 	pm_runtime_put(ndev->dev.parent);
 
 	return 0;
@@ -2893,16 +2862,52 @@ static int mcp251xfd_remove(struct spi_device *spi)
 
 static int __maybe_unused mcp251xfd_runtime_suspend(struct device *device)
 {
+	u32 osc;
+	int err;
 	const struct mcp251xfd_priv *priv = dev_get_drvdata(device);
 
-	return mcp251xfd_clks_and_vdd_disable(priv);
+	/* Activate Low Power Mode on Oscillator Disable. This only
+	 * works on the MCP2518FD. The MCP2517FD will go into normal
+	 * Sleep Mode instead.
+	 */
+	err = regmap_read(priv->map_reg, MCP251XFD_REG_OSC, &osc);
+	if (err)
+		return err;
+
+	osc |= MCP251XFD_REG_OSC_LPMEN;
+	err = regmap_write(priv->map_reg, MCP251XFD_REG_OSC, osc);
+	if (err)
+		return err;
+
+	err = mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_SLEEP);
+	if (err)
+		return err;
+
+	err = mcp251xfd_clks_and_vdd_disable(priv);
+	if (err)
+		return err;
+
+	return err;
 }
 
 static int __maybe_unused mcp251xfd_runtime_resume(struct device *device)
 {
+	int err;
 	const struct mcp251xfd_priv *priv = dev_get_drvdata(device);
 
-	return mcp251xfd_clks_and_vdd_enable(priv);
+	err = mcp251xfd_clks_and_vdd_enable(priv);
+	if (err)
+		return err;
+
+	err = mcp251xfd_chip_wake(priv);
+	if (err)
+		return err;
+
+	err = mcp251xfd_chip_softreset(priv);
+	if (err)
+		return err;
+
+	return err;
 }
 
 static const struct dev_pm_ops mcp251xfd_pm_ops = {
-- 
2.20.1

