Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63334D2D8C
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 11:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiCIK7C (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 05:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiCIK67 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 05:58:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF99170925
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 02:58:00 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRu11-0005PE-3f
        for linux-can@vger.kernel.org; Wed, 09 Mar 2022 11:57:59 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 9A0CD469CD
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 10:57:57 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 3482C469C4;
        Wed,  9 Mar 2022 10:57:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a6ea02ba;
        Wed, 9 Mar 2022 10:57:54 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 05/13] can: mcp251xfd: ring: prepare support for runtime configurable RX/TX ring sizes
Date:   Wed,  9 Mar 2022 11:57:45 +0100
Message-Id: <20220309105753.267264-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309105753.267264-1-mkl@pengutronix.de>
References: <20220309105753.267264-1-mkl@pengutronix.de>
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

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    | 26 ++++++++-----------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  2 ++
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index e540c97b4160..0e78941601bf 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -289,9 +289,9 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 {
 	struct mcp251xfd_tx_ring *tx_ring;
 	struct mcp251xfd_rx_ring *rx_ring;
-	int tef_obj_size, tx_obj_size, rx_obj_size;
-	int tx_obj_num;
-	int ram_free, i;
+	u8 tef_obj_size, tx_obj_size, rx_obj_size;
+	u8 tx_obj_num;
+	u8 rem, i;
 
 	tef_obj_size = sizeof(struct mcp251xfd_hw_tef_obj);
 	if (mcp251xfd_is_fd_mode(priv)) {
@@ -310,17 +310,14 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 	tx_ring->obj_num = tx_obj_num;
 	tx_ring->obj_size = tx_obj_size;
 
-	ram_free = MCP251XFD_RAM_SIZE - tx_obj_num *
-		(tef_obj_size + tx_obj_size);
+	rem = (MCP251XFD_RAM_SIZE - tx_obj_num *
+	       (tef_obj_size + tx_obj_size)) / rx_obj_size;
+	for (i = 0; i < ARRAY_SIZE(priv->rx) && rem; i++) {
+		u8 rx_obj_num;
 
-	for (i = 0;
-	     i < ARRAY_SIZE(priv->rx) && ram_free >= rx_obj_size;
-	     i++) {
-		int rx_obj_num;
-
-		rx_obj_num = ram_free / rx_obj_size;
-		rx_obj_num = min(1 << (fls(rx_obj_num) - 1),
-				 MCP251XFD_RX_OBJ_NUM_MAX);
+		rx_obj_num = min_t(u8, rounddown_pow_of_two(rem),
+				   MCP251XFD_FIFO_DEPTH);
+		rem -= rx_obj_num;
 
 		priv->rx_obj_num += rx_obj_num;
 
@@ -330,11 +327,10 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 			mcp251xfd_ring_free(priv);
 			return -ENOMEM;
 		}
+
 		rx_ring->obj_num = rx_obj_num;
 		rx_ring->obj_size = rx_obj_size;
 		priv->rx[i] = rx_ring;
-
-		ram_free -= rx_ring->obj_num * rx_ring->obj_size;
 	}
 	priv->rx_ring_num = i;
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 5c7a672464b1..bd7a9999b5e3 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -415,6 +415,8 @@ static_assert(MCP251XFD_TIMESTAMP_WORK_DELAY_SEC <
 #define MCP251XFD_FIFO_RX_NUM_MAX 1U
 #define MCP251XFD_FIFO_TX_NUM 1U
 
+#define MCP251XFD_FIFO_DEPTH 32U
+
 static_assert(MCP251XFD_FIFO_TEF_NUM == 1U);
 static_assert(MCP251XFD_FIFO_TEF_NUM == MCP251XFD_FIFO_TX_NUM);
 static_assert(MCP251XFD_FIFO_RX_NUM_MAX <= 4U);
-- 
2.34.1


