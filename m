Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0C636A723
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 14:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhDYMY4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 08:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhDYMY4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Apr 2021 08:24:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD13C061756
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 05:24:16 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lado6-0004Vc-Sq
        for linux-can@vger.kernel.org; Sun, 25 Apr 2021 14:24:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8B07161699A
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 12:24:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C4890616950;
        Sun, 25 Apr 2021 12:24:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 98c78460;
        Sun, 25 Apr 2021 12:24:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 06/14] can: mcp251xfd: mcp251xfd_chip_wait_for_osc_ready(): improve chip detection and error handling
Date:   Sun, 25 Apr 2021 14:23:52 +0200
Message-Id: <20210425122400.3276975-7-mkl@pengutronix.de>
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

The function mcp251xfd_chip_wait_for_osc_ready() polls the Oscillator
Control Register for the oscillator to get ready.

This is the first register the driver reads from. Reading implausible
values (all bits set or unset) can be caused by the chip starting up
after power on, waking up after sleep, or by the chip not being preset
at all. Add check for implausible register content
mcp251xfd_reg_invalid() to the regmap_read_poll_timeout() loop.

In case of a regmap_read_poll_timeout() returns a fatal error (and not
a timeout), forward it to the caller.

As mcp251xfd_chip_wait_for_osc_ready() will be called after the probe
function has finished, (currently during ifup), move error message
about failed chip detection from there into the probe function.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index c7c6d07ac175..0b7a4e317890 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -580,22 +580,25 @@ mcp251xfd_chip_wait_for_osc_ready(const struct mcp251xfd_priv *priv,
 	int err;
 
 	err = regmap_read_poll_timeout(priv->map_reg, MCP251XFD_REG_OSC, osc,
+				       !mcp251xfd_reg_invalid(osc) &&
 				       (osc & osc_mask) == osc_reference,
 				       MCP251XFD_OSC_STAB_SLEEP_US,
 				       MCP251XFD_OSC_STAB_TIMEOUT_US);
+	if (err != -ETIMEDOUT)
+		return err;
+
 	if (mcp251xfd_reg_invalid(osc)) {
 		netdev_err(priv->ndev,
-			   "Failed to detect %s (osc=0x%08x).\n",
-			   mcp251xfd_get_model_str(priv), osc);
+			   "Failed to read Oscillator Configuration Register (osc=0x%08x).\n",
+			   osc);
 		return -ENODEV;
-	} else if (err == -ETIMEDOUT) {
-		netdev_err(priv->ndev,
-			   "Timeout waiting for Oscillator Ready (osc=0x%08x, osc_reference=0x%08x)\n",
-			   osc, osc_reference);
-		return -ETIMEDOUT;
 	}
 
-	return 0;
+	netdev_err(priv->ndev,
+		   "Timeout waiting for Oscillator Ready (osc=0x%08x, osc_reference=0x%08x)\n",
+		   osc, osc_reference);
+
+	return -ETIMEDOUT;
 }
 
 static int mcp251xfd_chip_clock_enable(const struct mcp251xfd_priv *priv)
@@ -2995,8 +2998,11 @@ static int mcp251xfd_probe(struct spi_device *spi)
 		goto out_free_candev;
 
 	err = mcp251xfd_register(priv);
-	if (err)
+	if (err) {
+		dev_err_probe(&spi->dev, err, "Failed to detect %s.\n",
+			      mcp251xfd_get_model_str(priv));
 		goto out_free_candev;
+	}
 
 	return 0;
 
-- 
2.30.2


