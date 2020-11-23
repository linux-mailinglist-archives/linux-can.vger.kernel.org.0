Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5105D2C03F0
	for <lists+linux-can@lfdr.de>; Mon, 23 Nov 2020 12:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgKWLQi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 23 Nov 2020 06:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgKWLQh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 23 Nov 2020 06:16:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E8EC0613CF
        for <linux-can@vger.kernel.org>; Mon, 23 Nov 2020 03:16:37 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kh9pi-0006oB-V6; Mon, 23 Nov 2020 12:16:35 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Ursula Maplehurst <ursula@kangatronix.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 2/2] can: mcp251xfd: rx-path: reduce number of SPI core requests to set UINC bit
Date:   Mon, 23 Nov 2020 12:16:31 +0100
Message-Id: <20201123111631.3816024-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123111631.3816024-1-mkl@pengutronix.de>
References: <20201123111631.3816024-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Ursula Maplehurst <ursula@kangatronix.co.uk>

Reduce the number of separate SPI core requests when setting the UINC bit in
the RX FIFO, and instead batch them up into a single SPI core request.

Link: https://github.com/marckleinebudde/linux/issues/4
Signed-off-by: Ursula Maplehurst <ursula@kangatronix.co.uk>
Co-developed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 49 ++++++++++++++++---
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  2 +
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index aab972ad10dd..4d3f87083efc 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -332,7 +332,7 @@ static void mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 	u32 val;
 	u16 addr;
 	u8 len;
-	int i;
+	int i, j;
 
 	/* TEF */
 	priv->tef.head = 0;
@@ -370,6 +370,23 @@ static void mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 				prev_rx_ring->obj_num;
 
 		prev_rx_ring = rx_ring;
+
+		/* FIFO increment RX tail pointer */
+		addr = MCP251XFD_REG_FIFOCON(rx_ring->fifo_nr);
+		val = MCP251XFD_REG_FIFOCON_UINC;
+		len = mcp251xfd_cmd_prepare_write_reg(priv, &rx_ring->uinc_buf,
+						      addr, val, val);
+
+		for (j = 0; j < ARRAY_SIZE(rx_ring->uinc_xfer); j++) {
+			struct spi_transfer *xfer;
+
+			xfer = &rx_ring->uinc_xfer[j];
+			xfer->tx_buf = &rx_ring->uinc_buf;
+			xfer->len = len;
+			xfer->cs_change = 1;
+			xfer->cs_change_delay.value = 0;
+			xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+		}
 	}
 }
 
@@ -1440,13 +1457,7 @@ mcp251xfd_handle_rxif_one(struct mcp251xfd_priv *priv,
 	if (err)
 		stats->rx_fifo_errors++;
 
-	ring->tail++;
-
-	/* finally increment the RX pointer */
-	return regmap_update_bits(priv->map_reg,
-				  MCP251XFD_REG_FIFOCON(ring->fifo_nr),
-				  GENMASK(15, 8),
-				  MCP251XFD_REG_FIFOCON_UINC);
+	return 0;
 }
 
 static inline int
@@ -1470,6 +1481,7 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
 			   struct mcp251xfd_rx_ring *ring)
 {
 	struct mcp251xfd_hw_rx_obj_canfd *hw_rx_obj = ring->obj;
+	struct spi_transfer *last_xfer;
 	u8 rx_tail, len;
 	int err, i;
 
@@ -1492,6 +1504,27 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
 			if (err)
 				return err;
 		}
+
+		/* Increment the RX FIFO tail pointer 'len' times in a
+		 * single SPI transfer.
+		 */
+		ring->tail += len;
+
+		/* Note:
+		 *
+		 * "cs_change == 1" on the last transfer results in an
+		 * active chip select after the transfer. This causes
+		 * the controller to interpret the next register
+		 * access as data. Temporary set "cs_change" of the
+		 * last transfer to "0" to properly deactivate the
+		 * chip select at the end of the transfer.
+		 */
+		last_xfer = &ring->uinc_xfer[len - 1];
+		last_xfer->cs_change = 0;
+		err = spi_sync_transfer(priv->spi, ring->uinc_xfer, len);
+		last_xfer->cs_change = 1;
+		if (err)
+			return err;
 	}
 
 	return 0;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index c20c97d01072..97dc182e2b42 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -528,6 +528,8 @@ struct mcp251xfd_rx_ring {
 	u8 obj_num;
 	u8 obj_size;
 
+	union mcp251xfd_write_reg_buf uinc_buf;
+	struct spi_transfer uinc_xfer[MCP251XFD_RX_OBJ_NUM_MAX];
 	struct mcp251xfd_hw_rx_obj_canfd obj[];
 };
 
-- 
2.29.2

