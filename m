Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFC04D73BD
	for <lists+linux-can@lfdr.de>; Sun, 13 Mar 2022 09:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiCMIiA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Mar 2022 04:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiCMIh4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Mar 2022 04:37:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7021AC289
        for <linux-can@vger.kernel.org>; Sun, 13 Mar 2022 00:36:48 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nTJiZ-00077V-6H
        for linux-can@vger.kernel.org; Sun, 13 Mar 2022 09:36:47 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B17A449AC5
        for <linux-can@vger.kernel.org>; Sun, 13 Mar 2022 08:36:41 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5C7F449AA3;
        Sun, 13 Mar 2022 08:36:41 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e389f780;
        Sun, 13 Mar 2022 08:36:41 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 10/12] can: mcp251xfd: add TX IRQ coalesce support
Date:   Sun, 13 Mar 2022 09:36:38 +0100
Message-Id: <20220313083640.501791-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313083640.501791-1-mkl@pengutronix.de>
References: <20220313083640.501791-1-mkl@pengutronix.de>
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

This patch adds TX IRQ coalescing support to the driver.

The implemented algorithm is similar to the RX IRQ coalescing support
added in the previous patch.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    | 68 +++++++++++++++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c |  6 ++
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  8 +++
 3 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index f12a7aa8af14..3037ad3dd46b 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -71,6 +71,17 @@ mcp251xfd_ring_init_tef(struct mcp251xfd_priv *priv, u16 *base)
 	/* TEF- and TX-FIFO have same number of objects */
 	*base = mcp251xfd_get_tef_obj_addr(priv->tx->obj_num);
 
+	/* FIFO IRQ enable */
+	addr = MCP251XFD_REG_TEFCON;
+	val = MCP251XFD_REG_TEFCON_TEFOVIE | MCP251XFD_REG_TEFCON_TEFNEIE;
+
+	len = mcp251xfd_cmd_prepare_write_reg(priv, &tef_ring->irq_enable_buf,
+					      addr, val, val);
+	tef_ring->irq_enable_xfer.tx_buf = &tef_ring->irq_enable_buf;
+	tef_ring->irq_enable_xfer.len = len;
+	spi_message_init_with_transfers(&tef_ring->irq_enable_msg,
+					&tef_ring->irq_enable_xfer, 1);
+
 	/* FIFO increment TEF tail pointer */
 	addr = MCP251XFD_REG_TEFCON;
 	val = MCP251XFD_REG_TEFCON_UINC;
@@ -94,6 +105,18 @@ mcp251xfd_ring_init_tef(struct mcp251xfd_priv *priv, u16 *base)
 	 * message.
 	 */
 	xfer->cs_change = 0;
+
+	if (priv->tx_coalesce_usecs_irq || priv->tx_obj_num_coalesce_irq) {
+		val = MCP251XFD_REG_TEFCON_UINC |
+			MCP251XFD_REG_TEFCON_TEFOVIE |
+			MCP251XFD_REG_TEFCON_TEFHIE;
+
+		len = mcp251xfd_cmd_prepare_write_reg(priv,
+						      &tef_ring->uinc_irq_disable_buf,
+						      addr, val, val);
+		xfer->tx_buf = &tef_ring->uinc_irq_disable_buf;
+		xfer->len = len;
+	}
 }
 
 static void
@@ -282,11 +305,29 @@ int mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 	 */
 	priv->regs_status.rxif = BIT(priv->rx[0]->fifo_nr);
 
-	netdev_dbg(priv->ndev,
-		   "FIFO setup: TEF:         0x%03x: %2d*%zu bytes = %4zu bytes\n",
-		   mcp251xfd_get_tef_obj_addr(0),
-		   priv->tx->obj_num, sizeof(struct mcp251xfd_hw_tef_obj),
-		   priv->tx->obj_num * sizeof(struct mcp251xfd_hw_tef_obj));
+	if (priv->tx_obj_num_coalesce_irq) {
+		netdev_dbg(priv->ndev,
+			   "FIFO setup: TEF:         0x%03x: %2d*%zu bytes = %4zu bytes (coalesce)\n",
+			   mcp251xfd_get_tef_obj_addr(0),
+			   priv->tx_obj_num_coalesce_irq,
+			   sizeof(struct mcp251xfd_hw_tef_obj),
+			   priv->tx_obj_num_coalesce_irq *
+			   sizeof(struct mcp251xfd_hw_tef_obj));
+
+		netdev_dbg(priv->ndev,
+			   "                         0x%03x: %2d*%zu bytes = %4zu bytes\n",
+			   mcp251xfd_get_tef_obj_addr(priv->tx_obj_num_coalesce_irq),
+			   priv->tx->obj_num - priv->tx_obj_num_coalesce_irq,
+			   sizeof(struct mcp251xfd_hw_tef_obj),
+			   (priv->tx->obj_num - priv->tx_obj_num_coalesce_irq) *
+			   sizeof(struct mcp251xfd_hw_tef_obj));
+	} else {
+		netdev_dbg(priv->ndev,
+			   "FIFO setup: TEF:         0x%03x: %2d*%zu bytes = %4zu bytes\n",
+			   mcp251xfd_get_tef_obj_addr(0),
+			   priv->tx->obj_num, sizeof(struct mcp251xfd_hw_tef_obj),
+			   priv->tx->obj_num * sizeof(struct mcp251xfd_hw_tef_obj));
+	}
 
 	mcp251xfd_for_each_rx_ring(priv, rx_ring, i) {
 		if (rx_ring->nr == 0 && priv->rx_obj_num_coalesce_irq) {
@@ -364,6 +405,20 @@ static enum hrtimer_restart mcp251xfd_rx_irq_timer(struct hrtimer *t)
 	return HRTIMER_NORESTART;
 }
 
+static enum hrtimer_restart mcp251xfd_tx_irq_timer(struct hrtimer *t)
+{
+	struct mcp251xfd_priv *priv = container_of(t, struct mcp251xfd_priv,
+						   tx_irq_timer);
+	struct mcp251xfd_tef_ring *ring = priv->tef;
+
+	if (test_bit(MCP251XFD_FLAGS_DOWN, priv->flags))
+		return HRTIMER_NORESTART;
+
+	spi_async(priv->spi, &ring->irq_enable_msg);
+
+	return HRTIMER_NORESTART;
+}
+
 const struct can_ram_config mcp251xfd_ram_config = {
 	.rx = {
 		.size[CAN_RAM_MODE_CAN] = sizeof(struct mcp251xfd_hw_rx_obj_can),
@@ -449,5 +504,8 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 	hrtimer_init(&priv->rx_irq_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	priv->rx_irq_timer.function = mcp251xfd_rx_irq_timer;
 
+	hrtimer_init(&priv->tx_irq_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	priv->tx_irq_timer.function = mcp251xfd_tx_irq_timer;
+
 	return 0;
 }
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index 406166005b99..237617b0c125 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -256,5 +256,11 @@ int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 		netif_wake_queue(priv->ndev);
 	}
 
+	if (priv->tx_coalesce_usecs_irq)
+		hrtimer_start(&priv->tx_irq_timer,
+			      ns_to_ktime(priv->tx_coalesce_usecs_irq *
+					  NSEC_PER_USEC),
+			      HRTIMER_MODE_REL);
+
 	return 0;
 }
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 8d912bacd2f1..ee2c93ddc5ed 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -518,7 +518,12 @@ struct mcp251xfd_tef_ring {
 	/* u8 obj_num equals tx_ring->obj_num */
 	/* u8 obj_size equals sizeof(struct mcp251xfd_hw_tef_obj) */
 
+	union mcp251xfd_write_reg_buf irq_enable_buf;
+	struct spi_transfer irq_enable_xfer;
+	struct spi_message irq_enable_msg;
+
 	union mcp251xfd_write_reg_buf uinc_buf;
+	union mcp251xfd_write_reg_buf uinc_irq_disable_buf;
 	struct spi_transfer uinc_xfer[MCP251XFD_TX_OBJ_NUM_MAX];
 };
 
@@ -625,9 +630,12 @@ struct mcp251xfd_priv {
 	u8 rx_ring_num;
 	u8 rx_obj_num;
 	u8 rx_obj_num_coalesce_irq;
+	u8 tx_obj_num_coalesce_irq;
 
 	u32 rx_coalesce_usecs_irq;
+	u32 tx_coalesce_usecs_irq;
 	struct hrtimer rx_irq_timer;
+	struct hrtimer tx_irq_timer;
 
 	struct mcp251xfd_ecc ecc;
 	struct mcp251xfd_regs_status regs_status;
-- 
2.35.1


