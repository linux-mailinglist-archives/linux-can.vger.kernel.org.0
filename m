Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183716736CC
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 12:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjASL24 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 06:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjASL2w (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 06:28:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A199F6F8AA
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 03:28:49 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pIT68-0003tD-2T
        for linux-can@vger.kernel.org; Thu, 19 Jan 2023 12:28:48 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id ED2B915D1AE
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 11:28:45 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7E95315D18F;
        Thu, 19 Jan 2023 11:28:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ec391b21;
        Thu, 19 Jan 2023 11:28:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        =?UTF-8?q?Stefan=20Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 4/5] can: mcp251xfd: rx: prepare to workaround broken RX FIFO head index erratum
Date:   Thu, 19 Jan 2023 12:28:41 +0100
Message-Id: <20230119112842.500709-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119112842.500709-1-mkl@pengutronix.de>
References: <20230119112842.500709-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is a preparation patch to work around an erratum.

When handling the RX interrupt, the driver iterates over all pending
FIFOs (which are implemented as ring buffers in hardware) and reads
the FIFO header index from the RX FIFO STA register of the chip.

With the help of Thomas, we found out that the chip has a time window
after receiving a CAN frame where the content of the RX FIFO STA
register is not read correctly. In the bad case, we observed too large
head indices. In the original code, the driver always trusted the read
value, which caused old CAN frames that were already processed to be
reprocessed.

Instead of reading and trusting the head index, read the head index
and calculate the number of CAN frames that were supposedly received -
replace mcp251xfd_rx_ring_update() with mcp251xfd_get_rx_len().

The mcp251xfd_handle_rxif_ring() function reads the received CAN
frames from the chip, iterates over them and pushes them into the
network stack. Prepare that the iteration can be stopped if an old CAN
frame is detected. The actual code to detect old frames and abort will
be added in the next patch.

Link: https://lore.kernel.org/all/FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
Reported-by: Stefan Althöfer <Stefan.Althoefer@janztec.com>
Tested-by: Stefan Althöfer <Stefan.Althoefer@janztec.com>
Tested-by: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    |  1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c  | 77 +++++++++++++------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     | 12 +--
 3 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index bf3f0f150199..591ca0686df4 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -497,6 +497,7 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 		}
 
 		rx_ring->obj_num = rx_obj_num;
+		rx_ring->obj_num_shift_to_u8 = BITS_PER_BYTE - ilog2(rx_obj_num);
 		rx_ring->obj_size = rx_obj_size;
 		priv->rx[i] = rx_ring;
 	}
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
index 2c2b057b7ac7..5c6cf2a3e2c2 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
@@ -2,7 +2,7 @@
 //
 // mcp251xfd - Microchip MCP251xFD Family CAN controller driver
 //
-// Copyright (c) 2019, 2020, 2021 Pengutronix,
+// Copyright (c) 2019, 2020, 2021, 2023 Pengutronix,
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 // Based on:
@@ -79,32 +79,59 @@ mcp251xfd_check_rx_tail(const struct mcp251xfd_priv *priv,
 	return 0;
 }
 
+static inline bool mcp251xfd_rx_fifo_sta_empty(u32 fifo_sta)
+{
+	return !(fifo_sta & MCP251XFD_REG_FIFOSTA_TFNRFNIF);
+}
+
+static inline bool mcp251xfd_rx_fifo_sta_full(u32 fifo_sta)
+{
+	return fifo_sta & MCP251XFD_REG_FIFOSTA_TFERFFIF;
+}
+
 static int
-mcp251xfd_rx_ring_update(const struct mcp251xfd_priv *priv,
-			 struct mcp251xfd_rx_ring *ring)
+mcp251xfd_get_rx_len(struct mcp251xfd_priv *priv,
+		     struct mcp251xfd_rx_ring *ring,
+		     u8 *len_p)
 {
-	u32 new_head;
-	u8 chip_rx_head;
-	bool fifo_empty;
+	u8 head, tail, shift, len;
+	u32 fifo_sta;
 	int err;
 
-	err = mcp251xfd_rx_head_get_from_chip(priv, ring, &chip_rx_head,
-					      &fifo_empty);
-	if (err || fifo_empty)
+	err = regmap_read(priv->map_reg, MCP251XFD_REG_FIFOSTA(ring->fifo_nr),
+			  &fifo_sta);
+	if (err)
 		return err;
 
-	/* chip_rx_head, is the next RX-Object filled by the HW.
-	 * The new RX head must be >= the old head.
-	 */
-	new_head = round_down(ring->head, ring->obj_num) + chip_rx_head;
-	if (new_head <= ring->head)
-		new_head += ring->obj_num;
+	if (mcp251xfd_rx_fifo_sta_empty(fifo_sta)) {
+		*len_p = 0;
+		return 0;
+	}
 
-	ring->head = new_head;
+	if (mcp251xfd_rx_fifo_sta_full(fifo_sta)) {
+		*len_p = ring->obj_num;
+		return 0;
+	}
+
+	head = FIELD_GET(MCP251XFD_REG_FIFOSTA_FIFOCI_MASK, fifo_sta);
+
+	err =  mcp251xfd_check_rx_tail(priv, ring);
+	if (err)
+		return err;
+	tail = mcp251xfd_get_rx_tail(ring);
 
-	return mcp251xfd_check_rx_tail(priv, ring);
+	/* First shift to full u8. The subtraction works on singed
+	 * values, that keeps the difference steady around the u8
+	 * overflow. The right shift acts on len, which is an u8.
+	 */
+	shift = ring->obj_num_shift_to_u8;
+	len = (head << shift) - (tail << shift);
+	*len_p = len >> shift;
+
+	return 0;
 }
 
+
 static void
 mcp251xfd_hw_rx_obj_to_skb(const struct mcp251xfd_priv *priv,
 			   const struct mcp251xfd_hw_rx_obj_canfd *hw_rx_obj,
@@ -208,6 +235,8 @@ mcp251xfd_handle_rxif_ring_uinc(const struct mcp251xfd_priv *priv,
 	if (!len)
 		return 0;
 
+	ring->head += len;
+
 	/* Increment the RX FIFO tail pointer 'len' times in a
 	 * single SPI message.
 	 *
@@ -233,22 +262,22 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
 			   struct mcp251xfd_rx_ring *ring)
 {
 	struct mcp251xfd_hw_rx_obj_canfd *hw_rx_obj = ring->obj;
-	u8 rx_tail, len;
+	u8 rx_tail, len, l;
 	int err, i;
 
-	err = mcp251xfd_rx_ring_update(priv, ring);
+	err = mcp251xfd_get_rx_len(priv, ring, &len);
 	if (err)
 		return err;
 
-	while ((len = mcp251xfd_get_rx_linear_len(ring))) {
+	while ((l = mcp251xfd_get_rx_linear_len(ring, len))) {
 		rx_tail = mcp251xfd_get_rx_tail(ring);
 
 		err = mcp251xfd_rx_obj_read(priv, ring, hw_rx_obj,
-					    rx_tail, len);
+					    rx_tail, l);
 		if (err)
 			return err;
 
-		for (i = 0; i < len; i++) {
+		for (i = 0; i < l; i++) {
 			err = mcp251xfd_handle_rxif_one(priv, ring,
 							(void *)hw_rx_obj +
 							i * ring->obj_size);
@@ -256,9 +285,11 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
 				return err;
 		}
 
-		err = mcp251xfd_handle_rxif_ring_uinc(priv, ring, len);
+		err = mcp251xfd_handle_rxif_ring_uinc(priv, ring, l);
 		if (err)
 			return err;
+
+		len -= l;
 	}
 
 	return 0;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 3c410c543dc8..91cbc2451c8b 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -550,6 +550,7 @@ struct mcp251xfd_rx_ring {
 	u8 nr;
 	u8 fifo_nr;
 	u8 obj_num;
+	u8 obj_num_shift_to_u8;
 	u8 obj_size;
 
 	union mcp251xfd_write_reg_buf irq_enable_buf;
@@ -908,18 +909,9 @@ static inline u8 mcp251xfd_get_rx_tail(const struct mcp251xfd_rx_ring *ring)
 	return ring->tail & (ring->obj_num - 1);
 }
 
-static inline u8 mcp251xfd_get_rx_len(const struct mcp251xfd_rx_ring *ring)
-{
-	return ring->head - ring->tail;
-}
-
 static inline u8
-mcp251xfd_get_rx_linear_len(const struct mcp251xfd_rx_ring *ring)
+mcp251xfd_get_rx_linear_len(const struct mcp251xfd_rx_ring *ring, u8 len)
 {
-	u8 len;
-
-	len = mcp251xfd_get_rx_len(ring);
-
 	return min_t(u8, len, ring->obj_num - mcp251xfd_get_rx_tail(ring));
 }
 
-- 
2.39.0


