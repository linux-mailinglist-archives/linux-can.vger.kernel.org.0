Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D428E4C2631
	for <lists+linux-can@lfdr.de>; Thu, 24 Feb 2022 09:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiBXIaS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Feb 2022 03:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiBXI3q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Feb 2022 03:29:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCEE279905
        for <linux-can@vger.kernel.org>; Thu, 24 Feb 2022 00:29:04 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nN9Ul-0004jx-79
        for linux-can@vger.kernel.org; Thu, 24 Feb 2022 09:29:03 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E3B923C30D
        for <linux-can@vger.kernel.org>; Thu, 24 Feb 2022 08:27:29 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id A39F93C2EC;
        Thu, 24 Feb 2022 08:27:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8330c321;
        Thu, 24 Feb 2022 08:27:28 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 21/36] can: mcp251xfd: mcp251xfd_chip_wait_for_osc_ready(): prepare for PLL support
Date:   Thu, 24 Feb 2022 09:27:11 +0100
Message-Id: <20220224082726.3000007-22-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224082726.3000007-1-mkl@pengutronix.de>
References: <20220224082726.3000007-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The function mcp251xfd_chip_wait_for_osc_ready() polls the Oscillator
Control Register for the oscillator to get ready. By passing the
appropriate parameters (osc_reference and osc_mask) it can also poll
for PLL ready.

This patch adjusts the error message if the Oscillator and/or PLL fail
to get ready.

Link: https://lore.kernel.org/all/20220207131047.282110-9-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 68518e8410dd..f2aac990d285 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -112,6 +112,22 @@ static const char *mcp251xfd_get_mode_str(const u8 mode)
 	return "<unknown>";
 }
 
+static const char *
+mcp251xfd_get_osc_str(const u32 osc, const u32 osc_reference)
+{
+	switch (~osc & osc_reference &
+		(MCP251XFD_REG_OSC_OSCRDY | MCP251XFD_REG_OSC_PLLRDY)) {
+	case MCP251XFD_REG_OSC_PLLRDY:
+		return "PLL";
+	case MCP251XFD_REG_OSC_OSCRDY:
+		return "Oscillator";
+	case MCP251XFD_REG_OSC_PLLRDY | MCP251XFD_REG_OSC_OSCRDY:
+		return "Oscillator/PLL";
+	}
+
+	return "<unknown>";
+}
+
 static inline int mcp251xfd_vdd_enable(const struct mcp251xfd_priv *priv)
 {
 	if (!priv->reg_vdd)
@@ -269,8 +285,9 @@ mcp251xfd_chip_wait_for_osc_ready(const struct mcp251xfd_priv *priv,
 	}
 
 	netdev_err(priv->ndev,
-		   "Timeout waiting for Oscillator Ready (osc=0x%08x, osc_reference=0x%08x)\n",
-		   osc, osc_reference);
+		   "Timeout waiting for %s ready (osc=0x%08x, osc_reference=0x%08x, osc_mask=0x%08x).\n",
+		   mcp251xfd_get_osc_str(osc, osc_reference),
+		   osc, osc_reference, osc_mask);
 
 	return -ETIMEDOUT;
 }
@@ -298,6 +315,10 @@ static int mcp251xfd_chip_clock_enable(const struct mcp251xfd_priv *priv)
 	if (err)
 		return err;
 
+	/* Sometimes the PLL is stuck enabled, the controller never
+	 * sets the OSC Ready bit, and we get an -ETIMEDOUT. Our
+	 * caller takes care of retry.
+	 */
 	return mcp251xfd_chip_wait_for_osc_ready(priv, osc_reference, osc_mask);
 }
 
-- 
2.34.1


