Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB54B9D59
	for <lists+linux-can@lfdr.de>; Thu, 17 Feb 2022 11:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbiBQKiw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Feb 2022 05:38:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbiBQKir (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 05:38:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BA6284D17
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 02:38:32 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nKeBD-0003cO-1Q
        for linux-can@vger.kernel.org; Thu, 17 Feb 2022 11:38:31 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 83420362BF
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 10:38:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 216A73629C;
        Thu, 17 Feb 2022 10:38:28 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c86ba71c;
        Thu, 17 Feb 2022 10:38:27 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 2/8] can: mcp251xfd: mcp251xfd_ring_init(): split ring_init into separate functions
Date:   Thu, 17 Feb 2022 11:38:20 +0100
Message-Id: <20220217103826.2299157-3-mkl@pengutronix.de>
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

This patch splits the initialization of the TEF, TX and RX FIFO in the
mcp251xfd_ring_init() function into separate functions. This is a
preparation patch to move the RX FIFO in front of the TX FIFO.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    | 100 +++++++++++-------
 1 file changed, 62 insertions(+), 38 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index 6e394ac0bc5e..b9300554543e 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -52,6 +52,45 @@ mcp251xfd_cmd_prepare_write_reg(const struct mcp251xfd_priv *priv,
 	return len;
 }
 
+static void mcp251xfd_ring_init_tef(struct mcp251xfd_priv *priv)
+{
+	struct mcp251xfd_tef_ring *tef_ring;
+	struct spi_transfer *xfer;
+	u32 val;
+	u16 addr;
+	u8 len;
+	int i;
+
+	/* TEF */
+	tef_ring = priv->tef;
+	tef_ring->head = 0;
+	tef_ring->tail = 0;
+
+	/* FIFO increment TEF tail pointer */
+	addr = MCP251XFD_REG_TEFCON;
+	val = MCP251XFD_REG_TEFCON_UINC;
+	len = mcp251xfd_cmd_prepare_write_reg(priv, &tef_ring->uinc_buf,
+					      addr, val, val);
+
+	for (i = 0; i < ARRAY_SIZE(tef_ring->uinc_xfer); i++) {
+		xfer = &tef_ring->uinc_xfer[i];
+		xfer->tx_buf = &tef_ring->uinc_buf;
+		xfer->len = len;
+		xfer->cs_change = 1;
+		xfer->cs_change_delay.value = 0;
+		xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+	}
+
+	/* "cs_change == 1" on the last transfer results in an active
+	 * chip select after the complete SPI message. This causes the
+	 * controller to interpret the next register access as
+	 * data. Set "cs_change" of the last transfer to "0" to
+	 * properly deactivate the chip select at the end of the
+	 * message.
+	 */
+	xfer->cs_change = 0;
+}
+
 static void
 mcp251xfd_tx_ring_init_tx_obj(const struct mcp251xfd_priv *priv,
 			      const struct mcp251xfd_tx_ring *ring,
@@ -88,50 +127,15 @@ mcp251xfd_tx_ring_init_tx_obj(const struct mcp251xfd_priv *priv,
 					ARRAY_SIZE(tx_obj->xfer));
 }
 
-void mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
+static void mcp251xfd_ring_init_tx(struct mcp251xfd_priv *priv)
 {
-	struct mcp251xfd_tef_ring *tef_ring;
 	struct mcp251xfd_tx_ring *tx_ring;
-	struct mcp251xfd_rx_ring *rx_ring, *prev_rx_ring = NULL;
 	struct mcp251xfd_tx_obj *tx_obj;
-	struct spi_transfer *xfer;
 	u32 val;
 	u16 addr;
 	u8 len;
-	int i, j;
-
-	netdev_reset_queue(priv->ndev);
-
-	/* TEF */
-	tef_ring = priv->tef;
-	tef_ring->head = 0;
-	tef_ring->tail = 0;
-
-	/* FIFO increment TEF tail pointer */
-	addr = MCP251XFD_REG_TEFCON;
-	val = MCP251XFD_REG_TEFCON_UINC;
-	len = mcp251xfd_cmd_prepare_write_reg(priv, &tef_ring->uinc_buf,
-					      addr, val, val);
-
-	for (j = 0; j < ARRAY_SIZE(tef_ring->uinc_xfer); j++) {
-		xfer = &tef_ring->uinc_xfer[j];
-		xfer->tx_buf = &tef_ring->uinc_buf;
-		xfer->len = len;
-		xfer->cs_change = 1;
-		xfer->cs_change_delay.value = 0;
-		xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
-	}
-
-	/* "cs_change == 1" on the last transfer results in an active
-	 * chip select after the complete SPI message. This causes the
-	 * controller to interpret the next register access as
-	 * data. Set "cs_change" of the last transfer to "0" to
-	 * properly deactivate the chip select at the end of the
-	 * message.
-	 */
-	xfer->cs_change = 0;
+	int i;
 
-	/* TX */
 	tx_ring = priv->tx;
 	tx_ring->head = 0;
 	tx_ring->tail = 0;
@@ -147,8 +151,19 @@ void mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 
 	mcp251xfd_for_each_tx_obj(tx_ring, tx_obj, i)
 		mcp251xfd_tx_ring_init_tx_obj(priv, tx_ring, tx_obj, len, i);
+}
+
+static void mcp251xfd_ring_init_rx(struct mcp251xfd_priv *priv)
+{
+	struct mcp251xfd_rx_ring *rx_ring, *prev_rx_ring = NULL;
+	struct mcp251xfd_tx_ring *tx_ring;
+	struct spi_transfer *xfer;
+	u32 val;
+	u16 addr;
+	u8 len;
+	int i, j;
 
-	/* RX */
+	tx_ring = priv->tx;
 	mcp251xfd_for_each_rx_ring(priv, rx_ring, i) {
 		rx_ring->head = 0;
 		rx_ring->tail = 0;
@@ -192,6 +207,15 @@ void mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 	}
 }
 
+void mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
+{
+	netdev_reset_queue(priv->ndev);
+
+	mcp251xfd_ring_init_tef(priv);
+	mcp251xfd_ring_init_tx(priv);
+	mcp251xfd_ring_init_rx(priv);
+}
+
 void mcp251xfd_ring_free(struct mcp251xfd_priv *priv)
 {
 	int i;
-- 
2.34.1


