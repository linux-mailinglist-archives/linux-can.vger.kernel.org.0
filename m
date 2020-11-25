Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2E72C4279
	for <lists+linux-can@lfdr.de>; Wed, 25 Nov 2020 15:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgKYOx7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Nov 2020 09:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbgKYOx7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Nov 2020 09:53:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD711C061A4F
        for <linux-can@vger.kernel.org>; Wed, 25 Nov 2020 06:53:58 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1khwBB-0004BD-DF
        for linux-can@vger.kernel.org; Wed, 25 Nov 2020 15:53:57 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B483B59B929
        for <linux-can@vger.kernel.org>; Wed, 25 Nov 2020 14:53:56 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id DA5C159B91E;
        Wed, 25 Nov 2020 14:53:54 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9d8744a6;
        Wed, 25 Nov 2020 14:53:53 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 3/3] can: mcp251xfd: tef-path: reduce number of SPI core requests to set UINC bit
Date:   Wed, 25 Nov 2020 15:52:22 +0100
Message-Id: <20201125145221.22241-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125145221.22241-1-mkl@pengutronix.de>
References: <20201125145221.22241-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Reduce the number of separate SPI core requests when setting the UINC bit in
the TEF FIFO, and instead batch them up into a single SPI core request.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 62 +++++++++++++++----
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  3 +
 2 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 4e7260571ba9..9aae5f5fcd01 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -340,6 +340,23 @@ static void mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 	tef_ring->head = 0;
 	tef_ring->tail = 0;
 
+	/* FIFO increment TEF tail pointer */
+	addr = MCP251XFD_REG_TEFCON;
+	val = MCP251XFD_REG_TEFCON_UINC;
+	len = mcp251xfd_cmd_prepare_write_reg(priv, &tef_ring->uinc_buf,
+					      addr, val, val);
+
+	for (j = 0; j < ARRAY_SIZE(tef_ring->uinc_xfer); j++) {
+		struct spi_transfer *xfer;
+
+		xfer = &tef_ring->uinc_xfer[j];
+		xfer->tx_buf = &tef_ring->uinc_buf;
+		xfer->len = len;
+		xfer->cs_change = 1;
+		xfer->cs_change_delay.value = 0;
+		xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+	}
+
 	/* TX */
 	tx_ring = priv->tx;
 	tx_ring->head = 0;
@@ -1231,10 +1248,8 @@ static int
 mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 			   const struct mcp251xfd_hw_tef_obj *hw_tef_obj)
 {
-	struct mcp251xfd_tx_ring *tx_ring = priv->tx;
 	struct net_device_stats *stats = &priv->ndev->stats;
 	u32 seq, seq_masked, tef_tail_masked;
-	int err;
 
 	seq = FIELD_GET(MCP251XFD_OBJ_FLAGS_SEQ_MCP2518FD_MASK,
 			hw_tef_obj->flags);
@@ -1255,18 +1270,9 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 					    mcp251xfd_get_tef_tail(priv),
 					    hw_tef_obj->ts);
 	stats->tx_packets++;
-
-	/* finally increment the TEF pointer */
-	err = regmap_update_bits(priv->map_reg, MCP251XFD_REG_TEFCON,
-				 GENMASK(15, 8),
-				 MCP251XFD_REG_TEFCON_UINC);
-	if (err)
-		return err;
-
 	priv->tef->tail++;
-	tx_ring->tail++;
 
-	return mcp251xfd_check_tef_tail(priv);
+	return 0;
 }
 
 static int mcp251xfd_tef_ring_update(struct mcp251xfd_priv *priv)
@@ -1353,6 +1359,38 @@ static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 	}
 
  out_netif_wake_queue:
+	len = i;	/* number of handled goods TEFs */
+	if (len) {
+		struct mcp251xfd_tef_ring *ring = priv->tef;
+		struct mcp251xfd_tx_ring *tx_ring = priv->tx;
+		struct spi_transfer *last_xfer;
+
+		/* Increment the TEF FIFO tail pointer 'len' times in
+		 * a single SPI message.
+		 */
+		tx_ring->tail += len;
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
+
+		err = mcp251xfd_check_tef_tail(priv);
+		if (err)
+			return err;
+	}
+
 	mcp251xfd_ecc_tefif_successful(priv);
 
 	if (mcp251xfd_get_tx_free(priv->tx)) {
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 299dbf72e24b..cb6398c2a560 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -504,6 +504,9 @@ struct mcp251xfd_tef_ring {
 
 	/* u8 obj_num equals tx_ring->obj_num */
 	/* u8 obj_size equals sizeof(struct mcp251xfd_hw_tef_obj) */
+
+	union mcp251xfd_write_reg_buf uinc_buf;
+	struct spi_transfer uinc_xfer[MCP251XFD_TX_OBJ_NUM_MAX];
 };
 
 struct mcp251xfd_tx_ring {
-- 
2.29.2


