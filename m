Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0306E4D2D87
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 11:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiCIK7D (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 05:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiCIK7B (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 05:59:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E5CB641
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 02:58:01 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRu11-0005QQ-ER
        for linux-can@vger.kernel.org; Wed, 09 Mar 2022 11:57:59 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 35F6A469D3
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 10:57:58 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8EEF3469CB;
        Wed,  9 Mar 2022 10:57:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ac45d94c;
        Wed, 9 Mar 2022 10:57:54 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 06/13] can: mcp251xfd: use new defines
Date:   Wed,  9 Mar 2022 11:57:46 +0100
Message-Id: <20220309105753.267264-7-mkl@pengutronix.de>
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
 .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    |  4 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     | 38 +++++++++----------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index 0e78941601bf..bb0e342c2d15 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -295,11 +295,11 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 
 	tef_obj_size = sizeof(struct mcp251xfd_hw_tef_obj);
 	if (mcp251xfd_is_fd_mode(priv)) {
-		tx_obj_num = MCP251XFD_TX_OBJ_NUM_CANFD;
+		tx_obj_num = MCP251XFD_TX_OBJ_NUM_CANFD_DEFAULT;
 		tx_obj_size = sizeof(struct mcp251xfd_hw_tx_obj_canfd);
 		rx_obj_size = sizeof(struct mcp251xfd_hw_rx_obj_canfd);
 	} else {
-		tx_obj_num = MCP251XFD_TX_OBJ_NUM_CAN;
+		tx_obj_num = MCP251XFD_TX_OBJ_NUM_CAN_DEFAULT;
 		tx_obj_size = sizeof(struct mcp251xfd_hw_tx_obj_can);
 		rx_obj_size = sizeof(struct mcp251xfd_hw_rx_obj_can);
 	}
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index bd7a9999b5e3..b1cc8d19438e 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -367,23 +367,6 @@
 #define MCP251XFD_REG_DEVID_ID_MASK GENMASK(7, 4)
 #define MCP251XFD_REG_DEVID_REV_MASK GENMASK(3, 0)
 
-/* number of TX FIFO objects, depending on CAN mode
- *
- * FIFO setup: tef: 8*12 bytes = 96 bytes, tx: 8*16 bytes = 128 bytes
- * FIFO setup: tef: 4*12 bytes = 48 bytes, tx: 4*72 bytes = 288 bytes
- */
-#define MCP251XFD_RX_OBJ_NUM_MAX 32
-#define MCP251XFD_TX_OBJ_NUM_CAN 8
-#define MCP251XFD_TX_OBJ_NUM_CANFD 4
-
-#if MCP251XFD_TX_OBJ_NUM_CAN > MCP251XFD_TX_OBJ_NUM_CANFD
-#define MCP251XFD_TX_OBJ_NUM_MAX MCP251XFD_TX_OBJ_NUM_CAN
-#else
-#define MCP251XFD_TX_OBJ_NUM_MAX MCP251XFD_TX_OBJ_NUM_CANFD
-#endif
-
-#define MCP251XFD_NAPI_WEIGHT 32
-
 /* SPI commands */
 #define MCP251XFD_SPI_INSTRUCTION_RESET 0x0000
 #define MCP251XFD_SPI_INSTRUCTION_WRITE 0x2000
@@ -404,6 +387,9 @@ static_assert(MCP251XFD_TIMESTAMP_WORK_DELAY_SEC <
 #define MCP251XFD_OSC_STAB_TIMEOUT_US (10 * MCP251XFD_OSC_STAB_SLEEP_US)
 #define MCP251XFD_POLL_SLEEP_US (10)
 #define MCP251XFD_POLL_TIMEOUT_US (USEC_PER_MSEC)
+
+/* Misc */
+#define MCP251XFD_NAPI_WEIGHT 32
 #define MCP251XFD_SOFTRESET_RETRIES_MAX 3
 #define MCP251XFD_READ_CRC_RETRIES_MAX 3
 #define MCP251XFD_ECC_CNT_MAX 2
@@ -412,14 +398,24 @@ static_assert(MCP251XFD_TIMESTAMP_WORK_DELAY_SEC <
 
 /* FIFO and Ring */
 #define MCP251XFD_FIFO_TEF_NUM 1U
-#define MCP251XFD_FIFO_RX_NUM_MAX 1U
+#define MCP251XFD_FIFO_RX_NUM 1U
 #define MCP251XFD_FIFO_TX_NUM 1U
 
 #define MCP251XFD_FIFO_DEPTH 32U
 
+#define MCP251XFD_RX_OBJ_NUM_MIN 16U
+#define MCP251XFD_RX_OBJ_NUM_MAX (MCP251XFD_FIFO_RX_NUM * MCP251XFD_FIFO_DEPTH)
+#define MCP251XFD_RX_FIFO_DEPTH_MIN 4U
+
+#define MCP251XFD_TX_OBJ_NUM_MIN 2U
+#define MCP251XFD_TX_OBJ_NUM_MAX 8U
+#define MCP251XFD_TX_OBJ_NUM_CAN_DEFAULT 8U
+#define MCP251XFD_TX_OBJ_NUM_CANFD_DEFAULT 4U
+#define MCP251XFD_TX_FIFO_DEPTH_MIN 2U
+
 static_assert(MCP251XFD_FIFO_TEF_NUM == 1U);
 static_assert(MCP251XFD_FIFO_TEF_NUM == MCP251XFD_FIFO_TX_NUM);
-static_assert(MCP251XFD_FIFO_RX_NUM_MAX <= 4U);
+static_assert(MCP251XFD_FIFO_RX_NUM <= 4U);
 
 /* Silence TX MAB overflow warnings */
 #define MCP251XFD_QUIRK_MAB_NO_WARN BIT(0)
@@ -550,7 +546,7 @@ struct mcp251xfd_rx_ring {
 	u8 obj_size;
 
 	union mcp251xfd_write_reg_buf uinc_buf;
-	struct spi_transfer uinc_xfer[MCP251XFD_RX_OBJ_NUM_MAX];
+	struct spi_transfer uinc_xfer[MCP251XFD_FIFO_DEPTH];
 	struct mcp251xfd_hw_rx_obj_canfd obj[];
 };
 
@@ -608,7 +604,7 @@ struct mcp251xfd_priv {
 	u32 spi_max_speed_hz_slow;
 
 	struct mcp251xfd_tef_ring tef[MCP251XFD_FIFO_TEF_NUM];
-	struct mcp251xfd_rx_ring *rx[MCP251XFD_FIFO_RX_NUM_MAX];
+	struct mcp251xfd_rx_ring *rx[MCP251XFD_FIFO_RX_NUM];
 	struct mcp251xfd_tx_ring tx[MCP251XFD_FIFO_TX_NUM];
 
 	u8 rx_ring_num;
-- 
2.34.1


