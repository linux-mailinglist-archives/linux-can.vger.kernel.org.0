Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6622536A727
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 14:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhDYMY5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 08:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhDYMY4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Apr 2021 08:24:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3116CC06175F
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 05:24:17 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lado7-0004XH-Er
        for linux-can@vger.kernel.org; Sun, 25 Apr 2021 14:24:15 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 434F561699E
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 12:24:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9BB9761694C;
        Sun, 25 Apr 2021 12:24:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ba64731e;
        Sun, 25 Apr 2021 12:24:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 05/14] can: mcp251xfd: mcp251xfd_chip_wait_for_osc_ready(): factor out into separate function
Date:   Sun, 25 Apr 2021 14:23:51 +0200
Message-Id: <20210425122400.3276975-6-mkl@pengutronix.de>
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

This patch factors out mcp251xfd_chip_wait_for_osc_ready() into a
separate function, it will be used in several places in the next
patches.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 45 +++++++++++--------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 45850521000c..c7c6d07ac175 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -572,6 +572,32 @@ mcp251xfd_chip_set_mode_nowait(const struct mcp251xfd_priv *priv,
 	return __mcp251xfd_chip_set_mode(priv, mode_req, true);
 }
 
+static int
+mcp251xfd_chip_wait_for_osc_ready(const struct mcp251xfd_priv *priv,
+				  u32 osc_reference, u32 osc_mask)
+{
+	u32 osc;
+	int err;
+
+	err = regmap_read_poll_timeout(priv->map_reg, MCP251XFD_REG_OSC, osc,
+				       (osc & osc_mask) == osc_reference,
+				       MCP251XFD_OSC_STAB_SLEEP_US,
+				       MCP251XFD_OSC_STAB_TIMEOUT_US);
+	if (mcp251xfd_reg_invalid(osc)) {
+		netdev_err(priv->ndev,
+			   "Failed to detect %s (osc=0x%08x).\n",
+			   mcp251xfd_get_model_str(priv), osc);
+		return -ENODEV;
+	} else if (err == -ETIMEDOUT) {
+		netdev_err(priv->ndev,
+			   "Timeout waiting for Oscillator Ready (osc=0x%08x, osc_reference=0x%08x)\n",
+			   osc, osc_reference);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int mcp251xfd_chip_clock_enable(const struct mcp251xfd_priv *priv)
 {
 	u32 osc, osc_reference, osc_mask;
@@ -595,24 +621,7 @@ static int mcp251xfd_chip_clock_enable(const struct mcp251xfd_priv *priv)
 	if (err)
 		return err;
 
-	/* Wait for "Oscillator Ready" bit */
-	err = regmap_read_poll_timeout(priv->map_reg, MCP251XFD_REG_OSC, osc,
-				       (osc & osc_mask) == osc_reference,
-				       MCP251XFD_OSC_STAB_SLEEP_US,
-				       MCP251XFD_OSC_STAB_TIMEOUT_US);
-	if (mcp251xfd_reg_invalid(osc)) {
-		netdev_err(priv->ndev,
-			   "Failed to detect %s (osc=0x%08x).\n",
-			   mcp251xfd_get_model_str(priv), osc);
-		return -ENODEV;
-	} else if (err == -ETIMEDOUT) {
-		netdev_err(priv->ndev,
-			   "Timeout waiting for Oscillator Ready (osc=0x%08x, osc_reference=0x%08x)\n",
-			   osc, osc_reference);
-		return -ETIMEDOUT;
-	}
-
-	return err;
+	return mcp251xfd_chip_wait_for_osc_ready(priv, osc_reference, osc_mask);
 }
 
 static int mcp251xfd_chip_softreset_do(const struct mcp251xfd_priv *priv)
-- 
2.30.2


