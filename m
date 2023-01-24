Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27418679D71
	for <lists+linux-can@lfdr.de>; Tue, 24 Jan 2023 16:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjAXP1j (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 24 Jan 2023 10:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjAXP1i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 24 Jan 2023 10:27:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63CD26597
        for <linux-can@vger.kernel.org>; Tue, 24 Jan 2023 07:27:34 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pKLCv-0006uT-4P
        for linux-can@vger.kernel.org; Tue, 24 Jan 2023 16:27:33 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7C0F6162AE4
        for <linux-can@vger.kernel.org>; Tue, 24 Jan 2023 15:27:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1C80D162AD3;
        Tue, 24 Jan 2023 15:27:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id da22fd2a;
        Tue, 24 Jan 2023 15:27:30 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        =?UTF-8?q?Stefan=20Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v1 1/2] can: mcp251xfd: tef: prepare to workaround broken RX FIFO tail index erratum
Date:   Tue, 24 Jan 2023 16:27:28 +0100
Message-Id: <20230124152729.814840-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124152729.814840-1-mkl@pengutronix.de>
References: <20230124152729.814840-1-mkl@pengutronix.de>
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

Cc: Stefan Althöfer <Stefan.Althoefer@janztec.com>
Cc: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    |  1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 50 +++++++++++++------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     | 13 ++---
 3 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index f69d5fc8c9af..8ae9a3091dac 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -476,6 +476,7 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 		clear_bit(MCP251XFD_FLAGS_FD_MODE, priv->flags);
 	}
 
+	tx_ring->obj_num_shift_to_u8 = BITS_PER_BYTE - ilog2(tx_ring->obj_num);
 	tx_ring->obj_size = tx_obj_size;
 
 	rem = priv->rx_obj_num;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index 0c89e4f33976..e0c5ac943d8b 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -120,28 +120,49 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 	return 0;
 }
 
-static int mcp251xfd_tef_ring_update(struct mcp251xfd_priv *priv)
+static inline bool mcp251xfd_tx_fifo_sta_full(u32 fifo_sta)
+{
+	return !(fifo_sta & MCP251XFD_REG_FIFOSTA_TFNRFNIF);
+}
+
+static int
+mcp251xfd_get_tef_len(struct mcp251xfd_priv *priv, u8 *len_p)
 {
 	const struct mcp251xfd_tx_ring *tx_ring = priv->tx;
-	unsigned int new_head;
-	u8 chip_tx_tail;
+	u8 chip_tx_tail, tail, shift, len;
+	u32 fifo_sta;
 	int err;
 
-	err = mcp251xfd_tx_tail_get_from_chip(priv, &chip_tx_tail);
+	err = regmap_read(priv->map_reg,
+			  MCP251XFD_REG_FIFOSTA(priv->tx->fifo_nr),
+			  &fifo_sta);
 	if (err)
 		return err;
 
+	if (mcp251xfd_tx_fifo_sta_full(fifo_sta)) {
+		*len_p = tx_ring->obj_num;
+		return 0;
+	}
+	
 	/* chip_tx_tail, is the next TX-Object send by the HW.
-	 * The new TEF head must be >= the old head, ...
+	 * The new TEF head must be >= the old head.
 	 */
-	new_head = round_down(priv->tef->head, tx_ring->obj_num) + chip_tx_tail;
-	if (new_head <= priv->tef->head)
-		new_head += tx_ring->obj_num;
+	chip_tx_tail = FIELD_GET(MCP251XFD_REG_FIFOSTA_FIFOCI_MASK, fifo_sta);
 
-	/* ... but it cannot exceed the TX head. */
-	priv->tef->head = min(new_head, tx_ring->head);
+	err =  mcp251xfd_check_tef_tail(priv);
+	if (err)
+		return err;
+	tail = mcp251xfd_get_tef_tail(priv);
+
+	/* First shift to full u8. The subtraction works on singed
+	 * values, that keeps the difference steady around the u8
+	 * overflow. The right shift acts on len, which is an u8.
+	 */
+	shift = tx_ring->obj_num_shift_to_u8;
+	len = (chip_tx_tail << shift) - (tail << shift);
+	*len_p = len >> shift;
 
-	return mcp251xfd_check_tef_tail(priv);
+	return 0;
 }
 
 static inline int
@@ -182,13 +203,12 @@ int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 	u8 tef_tail, len, l;
 	int err, i;
 
-	err = mcp251xfd_tef_ring_update(priv);
+	err = mcp251xfd_get_tef_len(priv, &len);
 	if (err)
 		return err;
 
 	tef_tail = mcp251xfd_get_tef_tail(priv);
-	len = mcp251xfd_get_tef_len(priv);
-	l = mcp251xfd_get_tef_linear_len(priv);
+	l = mcp251xfd_get_tef_linear_len(priv, len);
 	err = mcp251xfd_tef_obj_read(priv, hw_tef_obj, tef_tail, l);
 	if (err)
 		return err;
@@ -223,6 +243,8 @@ int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 		struct mcp251xfd_tx_ring *tx_ring = priv->tx;
 		int offset;
 
+		ring->head += len;
+
 		/* Increment the TEF FIFO tail pointer 'len' times in
 		 * a single SPI message.
 		 *
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 6008d38810e9..66d1fcf82bfd 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -518,6 +518,7 @@ struct mcp251xfd_tef_ring {
 
 	/* u8 obj_num equals tx_ring->obj_num */
 	/* u8 obj_size equals sizeof(struct mcp251xfd_hw_tef_obj) */
+	/* u8 obj_num_shift_to_u8 equals tx_ring->obj_num_shift_to_u8 */
 
 	union mcp251xfd_write_reg_buf irq_enable_buf;
 	struct spi_transfer irq_enable_xfer;
@@ -536,6 +537,7 @@ struct mcp251xfd_tx_ring {
 	u8 nr;
 	u8 fifo_nr;
 	u8 obj_num;
+	u8 obj_num_shift_to_u8;
 	u8 obj_size;
 
 	struct mcp251xfd_tx_obj obj[MCP251XFD_TX_OBJ_NUM_MAX];
@@ -859,17 +861,8 @@ static inline u8 mcp251xfd_get_tef_tail(const struct mcp251xfd_priv *priv)
 	return priv->tef->tail & (priv->tx->obj_num - 1);
 }
 
-static inline u8 mcp251xfd_get_tef_len(const struct mcp251xfd_priv *priv)
-{
-	return priv->tef->head - priv->tef->tail;
-}
-
-static inline u8 mcp251xfd_get_tef_linear_len(const struct mcp251xfd_priv *priv)
+static inline u8 mcp251xfd_get_tef_linear_len(const struct mcp251xfd_priv *priv, u8 len)
 {
-	u8 len;
-
-	len = mcp251xfd_get_tef_len(priv);
-
 	return min_t(u8, len, priv->tx->obj_num - mcp251xfd_get_tef_tail(priv));
 }
 
-- 
2.39.0


