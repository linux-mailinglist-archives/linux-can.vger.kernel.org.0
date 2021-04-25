Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AC036A725
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 14:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhDYMY4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 08:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhDYMY4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Apr 2021 08:24:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FCCC06175F
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 05:24:16 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lado7-0004Wf-50
        for linux-can@vger.kernel.org; Sun, 25 Apr 2021 14:24:15 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 904FA61699C
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 12:24:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1F907616956;
        Sun, 25 Apr 2021 12:24:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9e2cb4b1;
        Sun, 25 Apr 2021 12:24:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 08/14] can: mcp251xfd: mcp251xfd_chip_softreset_check(): wait for OSC ready before accessing chip
Date:   Sun, 25 Apr 2021 14:23:54 +0200
Message-Id: <20210425122400.3276975-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210425122400.3276975-1-mkl@pengutronix.de>
References: <20210425122400.3276975-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch changes the order of reading the Mode and Oscillator Ready
bits.

Instead of reading the Mode of the chip directly after reset, first
wait for the oscillator to get ready and the chip to fully start up.
Read the Mode after this.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 29 ++++++++-----------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 2579b5aa1710..4d5384a9eb34 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -670,34 +670,29 @@ static int mcp251xfd_chip_softreset_do(const struct mcp251xfd_priv *priv)
 
 static int mcp251xfd_chip_softreset_check(const struct mcp251xfd_priv *priv)
 {
-	u32 osc, osc_reference;
+	u32 osc_reference, osc_mask;
 	u8 mode;
 	int err;
 
-	err = mcp251xfd_chip_get_mode(priv, &mode);
-	if (err)
-		return err;
-
-	if (mode != MCP251XFD_REG_CON_MODE_CONFIG) {
-		netdev_info(priv->ndev,
-			    "Controller not in Config Mode after reset, but in %s Mode (%u).\n",
-			    mcp251xfd_get_mode_str(mode), mode);
-		return -ETIMEDOUT;
-	}
-
+	/* Check for reset defaults of OSC reg.
+	 * This will take care of stabilization period.
+	 */
 	osc_reference = MCP251XFD_REG_OSC_OSCRDY |
 		FIELD_PREP(MCP251XFD_REG_OSC_CLKODIV_MASK,
 			   MCP251XFD_REG_OSC_CLKODIV_10);
+	osc_mask = osc_reference | MCP251XFD_REG_OSC_PLLRDY;
+	err = mcp251xfd_chip_wait_for_osc_ready(priv, osc_reference, osc_mask);
+	if (err)
+		return err;
 
-	/* check reset defaults of OSC reg */
-	err = regmap_read(priv->map_reg, MCP251XFD_REG_OSC, &osc);
+	err = mcp251xfd_chip_get_mode(priv, &mode);
 	if (err)
 		return err;
 
-	if (osc != osc_reference) {
+	if (mode != MCP251XFD_REG_CON_MODE_CONFIG) {
 		netdev_info(priv->ndev,
-			    "Controller failed to reset. osc=0x%08x, reference value=0x%08x.\n",
-			    osc, osc_reference);
+			    "Controller not in Config Mode after reset, but in %s Mode (%u).\n",
+			    mcp251xfd_get_mode_str(mode), mode);
 		return -ETIMEDOUT;
 	}
 
-- 
2.30.2


