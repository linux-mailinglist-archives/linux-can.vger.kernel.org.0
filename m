Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11D048561F
	for <lists+linux-can@lfdr.de>; Wed,  5 Jan 2022 16:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241633AbiAEPni (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jan 2022 10:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241644AbiAEPne (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jan 2022 10:43:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F29C03400A
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 07:43:11 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n58RR-0002z1-Uf
        for linux-can@vger.kernel.org; Wed, 05 Jan 2022 16:43:10 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 513126D1CCD
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 15:43:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 395746D1C9E;
        Wed,  5 Jan 2022 15:43:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7a567df4;
        Wed, 5 Jan 2022 15:43:02 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 13/13] can: mcp251xfd: introduce and make use of mcp251xfd_is_fd_mode()
Date:   Wed,  5 Jan 2022 16:43:00 +0100
Message-Id: <20220105154300.1258636-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105154300.1258636-1-mkl@pengutronix.de>
References: <20220105154300.1258636-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch replaces the open coded check, if the chip's FIFOs are
configured for CAN-FD mode, by the newly introduced function
mcp251xfd_is_fd_mode().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-chip-fifo.c | 4 ++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c      | 3 +--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h           | 6 ++++++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-chip-fifo.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-chip-fifo.c
index ce94dd744a93..2f9a623d381d 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-chip-fifo.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-chip-fifo.c
@@ -34,7 +34,7 @@ mcp251xfd_chip_rx_fifo_init_one(const struct mcp251xfd_priv *priv,
 		MCP251XFD_REG_FIFOCON_RXOVIE |
 		MCP251XFD_REG_FIFOCON_TFNRFNIE;
 
-	if (priv->can.ctrlmode & (CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_FD))
+	if (mcp251xfd_is_fd_mode(priv))
 		fifo_con |= FIELD_PREP(MCP251XFD_REG_FIFOCON_PLSIZE_MASK,
 				       MCP251XFD_REG_FIFOCON_PLSIZE_64);
 	else
@@ -84,7 +84,7 @@ int mcp251xfd_chip_fifo_init(const struct mcp251xfd_priv *priv)
 		MCP251XFD_REG_FIFOCON_TXEN |
 		MCP251XFD_REG_FIFOCON_TXATIE;
 
-	if (priv->can.ctrlmode & (CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_FD))
+	if (mcp251xfd_is_fd_mode(priv))
 		val |= FIELD_PREP(MCP251XFD_REG_FIFOCON_PLSIZE_MASK,
 				  MCP251XFD_REG_FIFOCON_PLSIZE_64);
 	else
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index ffb3691c4ba7..92f9e9b01289 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -209,8 +209,7 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 	int ram_free, i;
 
 	tef_obj_size = sizeof(struct mcp251xfd_hw_tef_obj);
-	/* listen-only mode works like FD mode */
-	if (priv->can.ctrlmode & (CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_FD)) {
+	if (mcp251xfd_is_fd_mode(priv)) {
 		tx_obj_num = MCP251XFD_TX_OBJ_NUM_CANFD;
 		tx_obj_size = sizeof(struct mcp251xfd_hw_tx_obj_canfd);
 		rx_obj_size = sizeof(struct mcp251xfd_hw_rx_obj_canfd);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 597786a85621..f551c900803e 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -626,6 +626,12 @@ MCP251XFD_IS(2517);
 MCP251XFD_IS(2518);
 MCP251XFD_IS(251X);
 
+static inline bool mcp251xfd_is_fd_mode(const struct mcp251xfd_priv *priv)
+{
+	/* listen-only mode works like FD mode */
+	return priv->can.ctrlmode & (CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_FD);
+}
+
 static inline u8 mcp251xfd_first_byte_set(u32 mask)
 {
 	return (mask & 0x0000ffff) ?
-- 
2.34.1


