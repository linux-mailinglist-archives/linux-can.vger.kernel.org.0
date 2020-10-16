Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A00290CE7
	for <lists+linux-can@lfdr.de>; Fri, 16 Oct 2020 22:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408571AbgJPUwR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Oct 2020 16:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408456AbgJPUwP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Oct 2020 16:52:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529DCC061755
        for <linux-can@vger.kernel.org>; Fri, 16 Oct 2020 13:52:15 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kTWhx-00084g-Hw; Fri, 16 Oct 2020 22:52:13 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 1/3] can: mcp251xfd: mcp251xfd_chip_wake(): renamed from mcp251xfd_chip_clock_enable()
Date:   Fri, 16 Oct 2020 22:52:09 +0200
Message-Id: <20201016205211.1141590-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016205211.1141590-1-mkl@pengutronix.de>
References: <20201016205211.1141590-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Co-developed-by: Magnus Aagaard Sørensen <mas@csselectronics.com>
Not-Singed-off-by: Magnus Aagaard Sørensen <mas@csselectronics.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index c3f49543ff26..c36f5f14d50c 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -519,13 +519,16 @@ static inline bool mcp251xfd_osc_invalid(u32 reg)
 	return reg == 0x0 || reg == 0xffffffff;
 }
 
-static int mcp251xfd_chip_clock_enable(const struct mcp251xfd_priv *priv)
+static int mcp251xfd_chip_wake(const struct mcp251xfd_priv *priv)
 {
 	u32 osc, osc_reference, osc_mask;
 	int err;
 
-	/* Set Power On Defaults for "Clock Output Divisor" and remove
-	 * "Oscillator Disable" bit.
+	/* For normal sleep on MCP2517FD and MCP2518FD, clearing
+	 * "Oscillator Disable" will wake the chip. For low power mode
+	 * on MCP2518FD, asserting the chip select will wake the
+	 * chip. Writing to the Oscillator register will wake it in
+	 * both cases.
 	 */
 	osc = FIELD_PREP(MCP251XFD_REG_OSC_CLKODIV_MASK,
 			 MCP251XFD_REG_OSC_CLKODIV_10);
@@ -569,10 +572,10 @@ static int mcp251xfd_chip_softreset_do(const struct mcp251xfd_priv *priv)
 	const __be16 cmd = mcp251xfd_cmd_reset();
 	int err;
 
-	/* The Set Mode and SPI Reset command only seems to works if
-	 * the controller is not in Sleep Mode.
+	/* The Set Mode and SPI Reset command only works if the
+	 * controller is not in Sleep Mode.
 	 */
-	err = mcp251xfd_chip_clock_enable(priv);
+	err = mcp251xfd_chip_wake(priv);
 	if (err)
 		return err;
 
-- 
2.28.0

