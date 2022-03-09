Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD1B4D2D8D
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 11:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiCIK7D (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 05:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiCIK7B (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 05:59:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39A34A910
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 02:58:01 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRu12-0005Qn-3Y
        for linux-can@vger.kernel.org; Wed, 09 Mar 2022 11:58:00 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7922D469D9
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 10:57:58 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id F172D469CF;
        Wed,  9 Mar 2022 10:57:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d53cc7f0;
        Wed, 9 Mar 2022 10:57:54 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 07/13] can: mcp251xfd: ring: add support for runtime configurable RX/TX ring sizes
Date:   Wed,  9 Mar 2022 11:57:47 +0100
Message-Id: <20220309105753.267264-8-mkl@pengutronix.de>
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
 .../net/can/spi/mcp251xfd/mcp251xfd-ethtool.c | 37 +++++++++++-
 .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    | 59 ++++++++++++++-----
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  9 +++
 3 files changed, 88 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ethtool.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ethtool.c
index 4131185eaf5a..8825195fa05f 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ethtool.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ethtool.c
@@ -9,6 +9,7 @@
 #include <linux/ethtool.h>
 
 #include "mcp251xfd.h"
+#include "mcp251xfd-ram.h"
 
 static void
 mcp251xfd_ring_get_ringparam(struct net_device *ndev,
@@ -17,19 +18,51 @@ mcp251xfd_ring_get_ringparam(struct net_device *ndev,
 			     struct netlink_ext_ack *extack)
 {
 	const struct mcp251xfd_priv *priv = netdev_priv(ndev);
+	const bool fd_mode = mcp251xfd_is_fd_mode(priv);
+	struct can_ram_layout layout;
 
-	ring->rx_max_pending = MCP251XFD_RX_OBJ_NUM_MAX;
-	ring->tx_max_pending = MCP251XFD_TX_OBJ_NUM_MAX;
+	can_ram_get_layout(&layout, &mcp251xfd_ram_config, NULL, NULL, fd_mode);
+	ring->rx_max_pending = layout.max_rx;
+	ring->tx_max_pending = layout.max_tx;
 
 	ring->rx_pending = priv->rx_obj_num;
 	ring->tx_pending = priv->tx->obj_num;
 }
 
+static int
+mcp251xfd_ring_set_ringparam(struct net_device *ndev,
+			     struct ethtool_ringparam *ring,
+			     struct kernel_ethtool_ringparam *kernel_ring,
+			     struct netlink_ext_ack *extack)
+{
+	struct mcp251xfd_priv *priv = netdev_priv(ndev);
+	const bool fd_mode = mcp251xfd_is_fd_mode(priv);
+	struct can_ram_layout layout;
+
+	can_ram_get_layout(&layout, &mcp251xfd_ram_config, ring, NULL, fd_mode);
+	if ((layout.cur_rx != priv->rx_obj_num ||
+	     layout.cur_tx != priv->tx->obj_num) &&
+	    netif_running(ndev))
+		return -EBUSY;
+
+	priv->rx_obj_num = layout.cur_rx;
+	priv->tx->obj_num = layout.cur_tx;
+
+	return 0;
+}
+
 static const struct ethtool_ops mcp251xfd_ethtool_ops = {
 	.get_ringparam = mcp251xfd_ring_get_ringparam,
+	.set_ringparam = mcp251xfd_ring_set_ringparam,
 };
 
 void mcp251xfd_ethtool_init(struct mcp251xfd_priv *priv)
 {
+	struct can_ram_layout layout;
+
 	priv->ndev->ethtool_ops = &mcp251xfd_ethtool_ops;
+
+	can_ram_get_layout(&layout, &mcp251xfd_ram_config, NULL, NULL, false);
+	priv->rx_obj_num = layout.default_rx;
+	priv->tx->obj_num = layout.default_tx;
 }
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index bb0e342c2d15..2ff4d4e803b0 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -15,6 +15,7 @@
 #include <asm/unaligned.h>
 
 #include "mcp251xfd.h"
+#include "mcp251xfd-ram.h"
 
 static inline u8
 mcp251xfd_cmd_prepare_write_reg(const struct mcp251xfd_priv *priv,
@@ -285,33 +286,63 @@ void mcp251xfd_ring_free(struct mcp251xfd_priv *priv)
 	}
 }
 
+const struct can_ram_config mcp251xfd_ram_config = {
+	.rx = {
+		.size[CAN_RAM_MODE_CAN] = sizeof(struct mcp251xfd_hw_rx_obj_can),
+		.size[CAN_RAM_MODE_CANFD] = sizeof(struct mcp251xfd_hw_rx_obj_canfd),
+		.min = MCP251XFD_RX_OBJ_NUM_MIN,
+		.max = MCP251XFD_RX_OBJ_NUM_MAX,
+		.def[CAN_RAM_MODE_CAN] = CAN_RAM_NUM_MAX,
+		.def[CAN_RAM_MODE_CANFD] = CAN_RAM_NUM_MAX,
+		.fifo_num = MCP251XFD_FIFO_RX_NUM,
+		.fifo_depth_min = MCP251XFD_RX_FIFO_DEPTH_MIN,
+	},
+	.tx = {
+		.size[CAN_RAM_MODE_CAN] = sizeof(struct mcp251xfd_hw_tef_obj) +
+			sizeof(struct mcp251xfd_hw_tx_obj_can),
+		.size[CAN_RAM_MODE_CANFD] = sizeof(struct mcp251xfd_hw_tef_obj) +
+			sizeof(struct mcp251xfd_hw_tx_obj_canfd),
+		.min = MCP251XFD_TX_OBJ_NUM_MIN,
+		.max = MCP251XFD_TX_OBJ_NUM_MAX,
+		.def[CAN_RAM_MODE_CAN] = MCP251XFD_TX_OBJ_NUM_CAN_DEFAULT,
+		.def[CAN_RAM_MODE_CANFD] = MCP251XFD_TX_OBJ_NUM_CANFD_DEFAULT,
+		.fifo_num = MCP251XFD_FIFO_TX_NUM,
+		.fifo_depth_min = MCP251XFD_TX_FIFO_DEPTH_MIN,
+	},
+	.size = MCP251XFD_RAM_SIZE,
+	.fifo_depth = MCP251XFD_FIFO_DEPTH,
+};
+
 int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 {
-	struct mcp251xfd_tx_ring *tx_ring;
+	const bool fd_mode = mcp251xfd_is_fd_mode(priv);
+	struct mcp251xfd_tx_ring *tx_ring = priv->tx;
 	struct mcp251xfd_rx_ring *rx_ring;
-	u8 tef_obj_size, tx_obj_size, rx_obj_size;
-	u8 tx_obj_num;
+	u8 tx_obj_size, rx_obj_size;
 	u8 rem, i;
 
-	tef_obj_size = sizeof(struct mcp251xfd_hw_tef_obj);
-	if (mcp251xfd_is_fd_mode(priv)) {
-		tx_obj_num = MCP251XFD_TX_OBJ_NUM_CANFD_DEFAULT;
+	/* switching from CAN-2.0 to CAN-FD mode or vice versa */
+	if (fd_mode != test_bit(MCP251XFD_FLAGS_FD_MODE, priv->flags)) {
+		struct can_ram_layout layout;
+
+		can_ram_get_layout(&layout, &mcp251xfd_ram_config, NULL, NULL, fd_mode);
+		priv->rx_obj_num = layout.default_rx;
+		tx_ring->obj_num = layout.default_tx;
+	}
+
+	if (fd_mode) {
 		tx_obj_size = sizeof(struct mcp251xfd_hw_tx_obj_canfd);
 		rx_obj_size = sizeof(struct mcp251xfd_hw_rx_obj_canfd);
+		set_bit(MCP251XFD_FLAGS_FD_MODE, priv->flags);
 	} else {
-		tx_obj_num = MCP251XFD_TX_OBJ_NUM_CAN_DEFAULT;
 		tx_obj_size = sizeof(struct mcp251xfd_hw_tx_obj_can);
 		rx_obj_size = sizeof(struct mcp251xfd_hw_rx_obj_can);
+		clear_bit(MCP251XFD_FLAGS_FD_MODE, priv->flags);
 	}
 
-	priv->rx_obj_num = 0;
-
-	tx_ring = priv->tx;
-	tx_ring->obj_num = tx_obj_num;
 	tx_ring->obj_size = tx_obj_size;
 
-	rem = (MCP251XFD_RAM_SIZE - tx_obj_num *
-	       (tef_obj_size + tx_obj_size)) / rx_obj_size;
+	rem = priv->rx_obj_num;
 	for (i = 0; i < ARRAY_SIZE(priv->rx) && rem; i++) {
 		u8 rx_obj_num;
 
@@ -319,8 +350,6 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 				   MCP251XFD_FIFO_DEPTH);
 		rem -= rx_obj_num;
 
-		priv->rx_obj_num += rx_obj_num;
-
 		rx_ring = kzalloc(sizeof(*rx_ring) + rx_obj_size * rx_obj_num,
 				  GFP_KERNEL);
 		if (!rx_ring) {
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index b1cc8d19438e..c61df2036fdf 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -582,6 +582,12 @@ struct mcp251xfd_devtype_data {
 	u32 quirks;
 };
 
+enum mcp251xfd_flags {
+	MCP251XFD_FLAGS_FD_MODE,
+
+	__MCP251XFD_FLAGS_SIZE__
+};
+
 struct mcp251xfd_priv {
 	struct can_priv can;
 	struct can_rx_offload offload;
@@ -607,6 +613,8 @@ struct mcp251xfd_priv {
 	struct mcp251xfd_rx_ring *rx[MCP251XFD_FIFO_RX_NUM];
 	struct mcp251xfd_tx_ring tx[MCP251XFD_FIFO_TX_NUM];
 
+	DECLARE_BITMAP(flags, __MCP251XFD_FLAGS_SIZE__);
+
 	u8 rx_ring_num;
 	u8 rx_obj_num;
 
@@ -892,6 +900,7 @@ u16 mcp251xfd_crc16_compute2(const void *cmd, size_t cmd_size,
 u16 mcp251xfd_crc16_compute(const void *data, size_t data_size);
 void mcp251xfd_ethtool_init(struct mcp251xfd_priv *priv);
 int mcp251xfd_regmap_init(struct mcp251xfd_priv *priv);
+extern const struct can_ram_config mcp251xfd_ram_config;
 int mcp251xfd_ring_init(struct mcp251xfd_priv *priv);
 void mcp251xfd_ring_free(struct mcp251xfd_priv *priv);
 int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv);
-- 
2.34.1


