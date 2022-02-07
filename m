Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C867A4ABFDF
	for <lists+linux-can@lfdr.de>; Mon,  7 Feb 2022 14:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiBGNrp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Feb 2022 08:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385483AbiBGNLZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Feb 2022 08:11:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A307C0401EE
        for <linux-can@vger.kernel.org>; Mon,  7 Feb 2022 05:10:56 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nH3nC-0003lJ-F0
        for linux-can@vger.kernel.org; Mon, 07 Feb 2022 14:10:54 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 9B8BC2D7C3
        for <linux-can@vger.kernel.org>; Mon,  7 Feb 2022 13:10:49 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 667042D7B3;
        Mon,  7 Feb 2022 13:10:49 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c4bad318;
        Mon, 7 Feb 2022 13:10:48 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>
Subject: [PATCH 11/15] can: mcp251xfd: mcp251xfd_chip_wake(): renamed from mcp251xfd_chip_clock_enable()
Date:   Mon,  7 Feb 2022 14:10:43 +0100
Message-Id: <20220207131047.282110-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207131047.282110-1-mkl@pengutronix.de>
References: <20220207131047.282110-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This patch renames mcp251xfd_chip_clock_enable() into mcp251xfd_chip_wake() as
this function actually wakes the chip. Additionally the documentation is
adopted.

Co-developed-by: Magnus Aagaard Sørensen <mas@csselectronics.com>
Signed-off-by: Magnus Aagaard Sørensen <mas@csselectronics.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index bc10ca1e7384..154e6c376670 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -292,22 +292,23 @@ mcp251xfd_chip_wait_for_osc_ready(const struct mcp251xfd_priv *priv,
 	return -ETIMEDOUT;
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
 	osc_reference = MCP251XFD_REG_OSC_OSCRDY;
 	osc_mask = MCP251XFD_REG_OSC_OSCRDY | MCP251XFD_REG_OSC_PLLRDY;
 
-	/* Note:
-	 *
-	 * If the controller is in Sleep Mode the following write only
+	/* If the controller is in Sleep Mode the following write only
 	 * removes the "Oscillator Disable" bit and powers it up. All
 	 * other bits are unaffected.
 	 */
@@ -332,10 +333,10 @@ static int mcp251xfd_chip_softreset_do(const struct mcp251xfd_priv *priv)
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
2.34.1


