Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E328D567EEB
	for <lists+linux-can@lfdr.de>; Wed,  6 Jul 2022 08:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiGFGsk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 6 Jul 2022 02:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiGFGsj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 6 Jul 2022 02:48:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665E214028
        for <linux-can@vger.kernel.org>; Tue,  5 Jul 2022 23:48:38 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o8ypw-0007u6-Rs
        for linux-can@vger.kernel.org; Wed, 06 Jul 2022 08:48:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5272AA93ED
        for <linux-can@vger.kernel.org>; Wed,  6 Jul 2022 06:48:36 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2C2FAA93E9;
        Wed,  6 Jul 2022 06:48:36 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 51ded9d7;
        Wed, 6 Jul 2022 06:48:36 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: mcp251xfd: fix detection of mcp251863
Date:   Wed,  6 Jul 2022 08:48:35 +0200
Message-Id: <20220706064835.1848864-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
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

In commit c6f2a617a0a8 ("can: mcp251xfd: add support for mcp251863")
support for the mcp251863 was added. However it was not taken into
account that the auto detection of the chip model cannot distinguish
between mcp2518fd and mcp251863 and would lead to a warning message if
the firmware specifies a mcp251863.

Fix auto detection: If a mcp2518fd compatible chip is found, keep the
mcp251863 if specified by firmware, use mcp2518fd instead.

Fixes: c6f2a617a0a8 ("can: mcp251xfd: add support for mcp251863")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 9b47b07162fe..bc6518504fd4 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1690,8 +1690,8 @@ static int mcp251xfd_register_chip_detect(struct mcp251xfd_priv *priv)
 	u32 osc;
 	int err;
 
-	/* The OSC_LPMEN is only supported on MCP2518FD, so use it to
-	 * autodetect the model.
+	/* The OSC_LPMEN is only supported on MCP2518FD and MCP251863,
+	 * so use it to autodetect the model.
 	 */
 	err = regmap_update_bits(priv->map_reg, MCP251XFD_REG_OSC,
 				 MCP251XFD_REG_OSC_LPMEN,
@@ -1703,10 +1703,18 @@ static int mcp251xfd_register_chip_detect(struct mcp251xfd_priv *priv)
 	if (err)
 		return err;
 
-	if (osc & MCP251XFD_REG_OSC_LPMEN)
-		devtype_data = &mcp251xfd_devtype_data_mcp2518fd;
-	else
+	if (osc & MCP251XFD_REG_OSC_LPMEN) {
+		/* We cannot distinguish between MCP2518FD and
+		 * MCP251863. If firmware specifies MCP251863, keep
+		 * it, otherwise set to MCP2518FD.
+		 */
+		if (mcp251xfd_is_251863(priv))
+			devtype_data = &mcp251xfd_devtype_data_mcp251863;
+		else
+			devtype_data = &mcp251xfd_devtype_data_mcp2518fd;
+	} else {
 		devtype_data = &mcp251xfd_devtype_data_mcp2517fd;
+	}
 
 	if (!mcp251xfd_is_251XFD(priv) &&
 	    priv->devtype_data.model != devtype_data->model) {
-- 
2.35.1


