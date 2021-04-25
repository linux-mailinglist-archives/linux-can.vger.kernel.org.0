Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EFD36A72A
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 14:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhDYMY6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 08:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhDYMY5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Apr 2021 08:24:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52708C061761
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 05:24:17 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lado7-0004Xj-Ol
        for linux-can@vger.kernel.org; Sun, 25 Apr 2021 14:24:15 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id BF9916169A5
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 12:24:07 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9EAE8616962;
        Sun, 25 Apr 2021 12:24:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2394e523;
        Sun, 25 Apr 2021 12:24:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 11/14] can: mcp251xfd: __mcp251xfd_chip_set_mode(): prepare for PLL support: improve error handling and diagnostics
Date:   Sun, 25 Apr 2021 14:23:57 +0200
Message-Id: <20210425122400.3276975-12-mkl@pengutronix.de>
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

This patch prepares the __mcp251xfd_chip_set_mode() function for PLL
support by adding more error checks and diagnostics.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 39 ++++++++++++++-----
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 734581541d6d..d90bf995e223 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -544,34 +544,55 @@ static int
 __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
 			  const u8 mode_req, bool nowait)
 {
-	u32 con, con_reqop;
+	u32 con = 0, con_reqop, osc = 0;
+	u8 mode;
 	int err;
 
 	con_reqop = FIELD_PREP(MCP251XFD_REG_CON_REQOP_MASK, mode_req);
 	err = regmap_update_bits(priv->map_reg, MCP251XFD_REG_CON,
 				 MCP251XFD_REG_CON_REQOP_MASK, con_reqop);
-	if (err)
+	if (err == -EBADMSG) {
+		netdev_err(priv->ndev,
+			   "Failed to set Requested Operation Mode.\n");
+
+		return -ENODEV;
+	} else if (err) {
 		return err;
+	}
 
 	if (mode_req == MCP251XFD_REG_CON_MODE_SLEEP || nowait)
 		return 0;
 
 	err = regmap_read_poll_timeout(priv->map_reg, MCP251XFD_REG_CON, con,
+				       !mcp251xfd_reg_invalid(con) &&
 				       FIELD_GET(MCP251XFD_REG_CON_OPMOD_MASK,
 						 con) == mode_req,
 				       MCP251XFD_POLL_SLEEP_US,
 				       MCP251XFD_POLL_TIMEOUT_US);
-	if (err) {
-		u8 mode = FIELD_GET(MCP251XFD_REG_CON_OPMOD_MASK, con);
+	if (err != -ETIMEDOUT && err != -EBADMSG)
+		return err;
+
+	/* Ignore return value.
+	 * Print below error messages, even if this fails.
+	 */
+	regmap_read(priv->map_reg, MCP251XFD_REG_OSC, &osc);
 
+	if (mcp251xfd_reg_invalid(con)) {
 		netdev_err(priv->ndev,
-			   "Controller failed to enter mode %s Mode (%u) and stays in %s Mode (%u).\n",
-			   mcp251xfd_get_mode_str(mode_req), mode_req,
-			   mcp251xfd_get_mode_str(mode), mode);
-		return err;
+			   "Failed to read CAN Control Register (con=0x%08x, osc=0x%08x).\n",
+			   con, osc);
+
+		return -ENODEV;
 	}
 
-	return 0;
+	mode = FIELD_GET(MCP251XFD_REG_CON_OPMOD_MASK, con);
+	netdev_err(priv->ndev,
+		   "Controller failed to enter mode %s Mode (%u) and stays in %s Mode (%u) (con=0x%08x, osc=0x%08x).\n",
+		   mcp251xfd_get_mode_str(mode_req), mode_req,
+		   mcp251xfd_get_mode_str(mode), mode,
+		   con, osc);
+
+	return -ETIMEDOUT;
 }
 
 static inline int
-- 
2.30.2


