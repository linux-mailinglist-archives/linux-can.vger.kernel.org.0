Return-Path: <linux-can+bounces-911-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0989791CC87
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 13:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7221F2264E
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 11:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361AF77107;
	Sat, 29 Jun 2024 11:40:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CE56F31D
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719661231; cv=none; b=XpSNRs8WAMTIjT8ss/2RErJNxc3H0ARHHyqHl7HJh4zKLbrL8igNHxGe0/rLRS3ITJqXrcZYQGD7jA7cxUtiEs+57t7h3LH3d/MYI+IZgB8bk3aHOWg8fUaIzCad/0JXR5A5k9prf+/ONnWOiZ57QXPMbj/Ep1nFMT1vBI3hpfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719661231; c=relaxed/simple;
	bh=GdolyffCGAWVE7No9w2Q31ADroO++13ZD5yK0m6Gjwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShumlNLKHlFd1x4jw+f+1oh6INT7ukqcspQazBK3NA/LkPsNl1zxHJpTmmPXo+uVHKfKUkc/mSIwOqtGLo8YzcN78yzczfiW8LqRLt9kU5fNdrC/vpNYmU2JS30a8xh47jDmbbwwXfRwSnIsWX+4JHQvsJ23ArXJzzwustf0smk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRO-00039H-Jw
	for linux-can@vger.kernel.org; Sat, 29 Jun 2024 13:40:26 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRM-005pbX-2A
	for linux-can@vger.kernel.org; Sat, 29 Jun 2024 13:40:24 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id AE2752F64A1
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 11:40:23 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C50BA2F6465;
	Sat, 29 Jun 2024 11:40:21 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 664b7f90;
	Sat, 29 Jun 2024 11:40:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	=?UTF-8?q?Stefan=20Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>,
	Thomas Kopp <thomas.kopp@microchip.com>
Subject: [PATCH net-next 11/14] can: mcp251xfd: rx: prepare to workaround broken RX FIFO head index erratum
Date: Sat, 29 Jun 2024 13:36:25 +0200
Message-ID: <20240629114017.1080160-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240629114017.1080160-1-mkl@pengutronix.de>
References: <20240629114017.1080160-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

This is a preparatory patch to work around erratum DS80000789E 6 of
the mcp2518fd, the other variants of the chip family (mcp2517fd and
mcp251863) are probably also affected.

When handling the RX interrupt, the driver iterates over all pending
FIFOs (which are implemented as ring buffers in hardware) and reads
the FIFO header index from the RX FIFO STA register of the chip.

In the bad case, the driver reads a too large head index. In the
original code, the driver always trusted the read value, which caused
old CAN frames that were already processed, or new, incompletely
written CAN frames to be (re-)processed.

Instead of reading and trusting the head index, read the head index
and calculate the number of CAN frames that were supposedly received -
replace mcp251xfd_rx_ring_update() with mcp251xfd_get_rx_len().

The mcp251xfd_handle_rxif_ring() function reads the received CAN
frames from the chip, iterates over them and pushes them into the
network stack. Prepare that the iteration can be stopped if an old CAN
frame is detected. The actual code to detect old or incomplete frames
and abort will be added in the next patch.

Link: https://lore.kernel.org/all/BL3PR11MB64844C1C95CA3BDADAE4D8CCFBC99@BL3PR11MB6484.namprd11.prod.outlook.com
Reported-by: Stefan Althöfer <Stefan.Althoefer@janztec.com>
Closes: https://lore.kernel.org/all/FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
Tested-by: Stefan Althöfer <Stefan.Althoefer@janztec.com>
Tested-by: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    |  2 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c  | 89 +++++++++++--------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     | 12 +--
 3 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index bfe4caa0c99d..b308a375e26e 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -507,6 +507,8 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 		}
 
 		rx_ring->obj_num = rx_obj_num;
+		rx_ring->obj_num_shift_to_u8 = BITS_PER_TYPE(rx_ring->obj_num_shift_to_u8) -
+			ilog2(rx_obj_num);
 		rx_ring->obj_size = rx_obj_size;
 		priv->rx[i] = rx_ring;
 	}
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
index 2c2b057b7ac7..a79e6c661ecc 100644
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
@@ -16,23 +16,14 @@
 
 #include "mcp251xfd.h"
 
-static inline int
-mcp251xfd_rx_head_get_from_chip(const struct mcp251xfd_priv *priv,
-				const struct mcp251xfd_rx_ring *ring,
-				u8 *rx_head, bool *fifo_empty)
+static inline bool mcp251xfd_rx_fifo_sta_empty(const u32 fifo_sta)
 {
-	u32 fifo_sta;
-	int err;
+	return !(fifo_sta & MCP251XFD_REG_FIFOSTA_TFNRFNIF);
+}
 
-	err = regmap_read(priv->map_reg, MCP251XFD_REG_FIFOSTA(ring->fifo_nr),
-			  &fifo_sta);
-	if (err)
-		return err;
-
-	*rx_head = FIELD_GET(MCP251XFD_REG_FIFOSTA_FIFOCI_MASK, fifo_sta);
-	*fifo_empty = !(fifo_sta & MCP251XFD_REG_FIFOSTA_TFNRFNIF);
-
-	return 0;
+static inline bool mcp251xfd_rx_fifo_sta_full(const u32 fifo_sta)
+{
+	return fifo_sta & MCP251XFD_REG_FIFOSTA_TFERFFIF;
 }
 
 static inline int
@@ -80,29 +71,49 @@ mcp251xfd_check_rx_tail(const struct mcp251xfd_priv *priv,
 }
 
 static int
-mcp251xfd_rx_ring_update(const struct mcp251xfd_priv *priv,
-			 struct mcp251xfd_rx_ring *ring)
+mcp251xfd_get_rx_len(const struct mcp251xfd_priv *priv,
+		     const struct mcp251xfd_rx_ring *ring,
+		     u8 *len_p)
 {
-	u32 new_head;
-	u8 chip_rx_head;
-	bool fifo_empty;
+	const u8 shift = ring->obj_num_shift_to_u8;
+	u8 chip_head, tail, len;
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
+	if (mcp251xfd_rx_fifo_sta_empty(fifo_sta)) {
+		*len_p = 0;
+		return 0;
+	}
+
+	if (mcp251xfd_rx_fifo_sta_full(fifo_sta)) {
+		*len_p = ring->obj_num;
+		return 0;
+	}
+
+	chip_head = FIELD_GET(MCP251XFD_REG_FIFOSTA_FIFOCI_MASK, fifo_sta);
+
+	err =  mcp251xfd_check_rx_tail(priv, ring);
+	if (err)
+		return err;
+	tail = mcp251xfd_get_rx_tail(ring);
+
+	/* First shift to full u8. The subtraction works on signed
+	 * values, that keeps the difference steady around the u8
+	 * overflow. The right shift acts on len, which is an u8.
 	 */
-	new_head = round_down(ring->head, ring->obj_num) + chip_rx_head;
-	if (new_head <= ring->head)
-		new_head += ring->obj_num;
+	BUILD_BUG_ON(sizeof(ring->obj_num) != sizeof(chip_head));
+	BUILD_BUG_ON(sizeof(ring->obj_num) != sizeof(tail));
+	BUILD_BUG_ON(sizeof(ring->obj_num) != sizeof(len));
 
-	ring->head = new_head;
+	len = (chip_head << shift) - (tail << shift);
+	*len_p = len >> shift;
 
-	return mcp251xfd_check_rx_tail(priv, ring);
+	return 0;
 }
 
 static void
@@ -208,6 +219,8 @@ mcp251xfd_handle_rxif_ring_uinc(const struct mcp251xfd_priv *priv,
 	if (!len)
 		return 0;
 
+	ring->head += len;
+
 	/* Increment the RX FIFO tail pointer 'len' times in a
 	 * single SPI message.
 	 *
@@ -233,22 +246,22 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
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
@@ -256,9 +269,11 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
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
index 4d31689d73c8..453a2b193c75 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -556,6 +556,7 @@ struct mcp251xfd_rx_ring {
 	u8 nr;
 	u8 fifo_nr;
 	u8 obj_num;
+	u8 obj_num_shift_to_u8;
 	u8 obj_size;
 
 	union mcp251xfd_write_reg_buf irq_enable_buf;
@@ -931,18 +932,9 @@ static inline u8 mcp251xfd_get_rx_tail(const struct mcp251xfd_rx_ring *ring)
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
2.43.0



