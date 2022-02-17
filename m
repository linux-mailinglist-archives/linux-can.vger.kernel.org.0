Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225804B9D55
	for <lists+linux-can@lfdr.de>; Thu, 17 Feb 2022 11:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiBQKiv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Feb 2022 05:38:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiBQKir (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 05:38:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319B7284D1C
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 02:38:33 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nKeBD-0003cP-DM
        for linux-can@vger.kernel.org; Thu, 17 Feb 2022 11:38:31 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8F857362C3
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 10:38:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 6EF79362B6;
        Thu, 17 Feb 2022 10:38:28 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ad10009f;
        Thu, 17 Feb 2022 10:38:27 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 8/8] can: mcp251xfd: mcp251xfd_priv: introduce macros specifying the number of supported TEF/RX/TX rings
Date:   Thu, 17 Feb 2022 11:38:26 +0100
Message-Id: <20220217103826.2299157-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217103826.2299157-1-mkl@pengutronix.de>
References: <20220217103826.2299157-1-mkl@pengutronix.de>
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

This patch introduces macros to define the number of supported TEF, RX
and TX rings. As well as some assertions as sanity checks.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index f359dd0aa458..87cc13d455c1 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -2,7 +2,7 @@
  *
  * mcp251xfd - Microchip MCP251xFD Family CAN controller driver
  *
- * Copyright (c) 2019, 2020 Pengutronix,
+ * Copyright (c) 2019, 2020, 2021 Pengutronix,
  *               Marc Kleine-Budde <kernel@pengutronix.de>
  * Copyright (c) 2019 Martin Sperl <kernel@martin.sperl.org>
  */
@@ -410,6 +410,15 @@ static_assert(MCP251XFD_TIMESTAMP_WORK_DELAY_SEC <
 #define MCP251XFD_SANITIZE_SPI 1
 #define MCP251XFD_SANITIZE_CAN 1
 
+/* FIFO and Ring */
+#define MCP251XFD_FIFO_TEF_NUM 1U
+#define MCP251XFD_FIFO_RX_NUM_MAX 1U
+#define MCP251XFD_FIFO_TX_NUM 1U
+
+static_assert(MCP251XFD_FIFO_TEF_NUM == 1U);
+static_assert(MCP251XFD_FIFO_TEF_NUM == MCP251XFD_FIFO_TX_NUM);
+static_assert(MCP251XFD_FIFO_RX_NUM_MAX <= 4U);
+
 /* Silence TX MAB overflow warnings */
 #define MCP251XFD_QUIRK_MAB_NO_WARN BIT(0)
 /* Use CRC to access registers */
@@ -596,9 +605,9 @@ struct mcp251xfd_priv {
 	u32 spi_max_speed_hz_fast;
 	u32 spi_max_speed_hz_slow;
 
-	struct mcp251xfd_tef_ring tef[1];
-	struct mcp251xfd_rx_ring *rx[1];
-	struct mcp251xfd_tx_ring tx[1];
+	struct mcp251xfd_tef_ring tef[MCP251XFD_FIFO_TEF_NUM];
+	struct mcp251xfd_rx_ring *rx[MCP251XFD_FIFO_RX_NUM_MAX];
+	struct mcp251xfd_tx_ring tx[MCP251XFD_FIFO_TX_NUM];
 
 	u8 rx_ring_num;
 
-- 
2.34.1


