Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EAE4D2D89
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 11:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiCIK7F (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 05:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiCIK7C (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 05:59:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F7D5C662
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 02:58:03 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRu14-0005Te-8h
        for linux-can@vger.kernel.org; Wed, 09 Mar 2022 11:58:02 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 2C845469F7
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 10:58:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 89EF6469EC;
        Wed,  9 Mar 2022 10:57:59 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 334f8759;
        Wed, 9 Mar 2022 10:57:55 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 11/13] can: mcp251xfd: add TX coalesce ethtool support
Date:   Wed,  9 Mar 2022 11:57:51 +0100
Message-Id: <20220309105753.267264-12-mkl@pengutronix.de>
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
 .../net/can/spi/mcp251xfd/mcp251xfd-ethtool.c | 23 ++++++++++++++++---
 .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    |  1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  1 +
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ethtool.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ethtool.c
index 6e49cf3411a2..6c7a57f16cc6 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ethtool.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ethtool.c
@@ -58,7 +58,7 @@ static int mcp251xfd_ring_get_coalesce(struct net_device *ndev,
 				       struct netlink_ext_ack *ext_ack)
 {
 	struct mcp251xfd_priv *priv = netdev_priv(ndev);
-	u32 rx_max_frames;
+	u32 rx_max_frames, tx_max_frames;
 
 	/* The ethtool doc says:
 	 * To disable coalescing, set usecs = 0 and max_frames = 1.
@@ -71,6 +71,14 @@ static int mcp251xfd_ring_get_coalesce(struct net_device *ndev,
 	ec->rx_max_coalesced_frames_irq = rx_max_frames;
 	ec->rx_coalesce_usecs_irq = priv->rx_coalesce_usecs_irq;
 
+	if (priv->tx_obj_num_coalesce_irq == 0)
+		tx_max_frames = 1;
+	else
+		tx_max_frames = priv->tx_obj_num_coalesce_irq;
+
+	ec->tx_max_coalesced_frames_irq = tx_max_frames;
+	ec->tx_coalesce_usecs_irq = priv->tx_coalesce_usecs_irq;
+
 	return 0;
 }
 
@@ -90,21 +98,28 @@ static int mcp251xfd_ring_set_coalesce(struct net_device *ndev,
 	can_ram_get_layout(&layout, &mcp251xfd_ram_config, &ring, ec, fd_mode);
 
 	if ((layout.rx_coalesce != priv->rx_obj_num_coalesce_irq ||
-	     ec->rx_coalesce_usecs_irq != priv->rx_coalesce_usecs_irq) &&
+	     ec->rx_coalesce_usecs_irq != priv->rx_coalesce_usecs_irq ||
+	     layout.tx_coalesce != priv->tx_obj_num_coalesce_irq ||
+	     ec->tx_coalesce_usecs_irq != priv->tx_coalesce_usecs_irq) &&
 	    netif_running(ndev))
 		return -EBUSY;
 
 	priv->rx_obj_num = layout.cur_rx;
 	priv->rx_obj_num_coalesce_irq = layout.rx_coalesce;
 	priv->rx_coalesce_usecs_irq = ec->rx_coalesce_usecs_irq;
+
 	priv->tx->obj_num = layout.cur_tx;
+	priv->tx_obj_num_coalesce_irq = layout.tx_coalesce;
+	priv->tx_coalesce_usecs_irq = ec->tx_coalesce_usecs_irq;
 
 	return 0;
 }
 
 static const struct ethtool_ops mcp251xfd_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
-		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ,
+		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
+		ETHTOOL_COALESCE_TX_USECS_IRQ |
+		ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
 	.get_ringparam = mcp251xfd_ring_get_ringparam,
 	.set_ringparam = mcp251xfd_ring_set_ringparam,
 	.get_coalesce = mcp251xfd_ring_get_coalesce,
@@ -122,5 +137,7 @@ void mcp251xfd_ethtool_init(struct mcp251xfd_priv *priv)
 	priv->tx->obj_num = layout.default_tx;
 
 	priv->rx_obj_num_coalesce_irq = 0;
+	priv->tx_obj_num_coalesce_irq = 0;
 	priv->rx_coalesce_usecs_irq = 0;
+	priv->tx_coalesce_usecs_irq = 0;
 }
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index 3037ad3dd46b..bf3f0f150199 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -442,6 +442,7 @@ const struct can_ram_config mcp251xfd_ram_config = {
 		.def[CAN_RAM_MODE_CANFD] = MCP251XFD_TX_OBJ_NUM_CANFD_DEFAULT,
 		.fifo_num = MCP251XFD_FIFO_TX_NUM,
 		.fifo_depth_min = MCP251XFD_TX_FIFO_DEPTH_MIN,
+		.fifo_depth_coalesce_min = MCP251XFD_TX_FIFO_DEPTH_COALESCE_MIN,
 	},
 	.size = MCP251XFD_RAM_SIZE,
 	.fifo_depth = MCP251XFD_FIFO_DEPTH,
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index ee2c93ddc5ed..c6cb8c3391b3 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -413,6 +413,7 @@ static_assert(MCP251XFD_TIMESTAMP_WORK_DELAY_SEC <
 #define MCP251XFD_TX_OBJ_NUM_CAN_DEFAULT 8U
 #define MCP251XFD_TX_OBJ_NUM_CANFD_DEFAULT 4U
 #define MCP251XFD_TX_FIFO_DEPTH_MIN 2U
+#define MCP251XFD_TX_FIFO_DEPTH_COALESCE_MIN 2U
 
 static_assert(MCP251XFD_FIFO_TEF_NUM == 1U);
 static_assert(MCP251XFD_FIFO_TEF_NUM == MCP251XFD_FIFO_TX_NUM);
-- 
2.34.1


