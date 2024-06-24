Return-Path: <linux-can+bounces-857-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9989150B1
	for <lists+linux-can@lfdr.de>; Mon, 24 Jun 2024 16:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06D71C2202F
	for <lists+linux-can@lfdr.de>; Mon, 24 Jun 2024 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DB819DF8D;
	Mon, 24 Jun 2024 14:45:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345E19DF4F
	for <linux-can@vger.kernel.org>; Mon, 24 Jun 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240350; cv=none; b=eDqe4SYCKazHeNusrbKEIHu0ZMfS3jbSAioFdC/VdXQyoVjbqD/Nb1Dn+0yNqixBi+9tcdH3UMDMKo7eTzwljZ3LqCf6E5AXj7qxtnrN6XUYJkPNgwceeDYgMhHRuESx6pZ8YjMtI4EgL+4G4G4oQCFE13u7EFZf3MGFGTLJZa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240350; c=relaxed/simple;
	bh=uTz5TQyNGzR/T4L4Gy01pJ6fiXeFSUx6vtBWFetcPIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vbl2XL2rUKc0YwYBi9hG5Da80k5M6aOPrBbJCIK/oTeEvXxBYYzHD4MDFBWr10aUJMYvcuCV+2Hog2on+gRv9cPWwwEAOHjhNRkYr43M/FCWpGp7vAGm6PIZNO2+O/ZOWrSzjDidIVCOYZEAFEn+UpJzNWgbqM3ep2Ds4ny5MwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sLkx1-0002yS-28
	for linux-can@vger.kernel.org; Mon, 24 Jun 2024 16:45:47 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sLkwy-004fq2-7N
	for linux-can@vger.kernel.org; Mon, 24 Jun 2024 16:45:44 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D85F42F1A81
	for <linux-can@vger.kernel.org>; Mon, 24 Jun 2024 14:45:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 46F7C2F1A0A;
	Mon, 24 Jun 2024 14:45:38 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bd4e50f0;
	Mon, 24 Jun 2024 14:45:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 24 Jun 2024 16:45:10 +0200
Subject: [PATCH v3 6/9] can: mcp251xfd: rx: prepare to workaround broken RX
 FIFO head index erratum
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240624-mcp251xfd-workaround-erratum-6-v3-6-caf7e5f27f60@pengutronix.de>
References: <20240624-mcp251xfd-workaround-erratum-6-v3-0-caf7e5f27f60@pengutronix.de>
In-Reply-To: <20240624-mcp251xfd-workaround-erratum-6-v3-0-caf7e5f27f60@pengutronix.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 =?utf-8?q?Stefan_Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>, 
 kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=7840; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=uTz5TQyNGzR/T4L4Gy01pJ6fiXeFSUx6vtBWFetcPIk=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmeYaK9stu528vZVhKQgwfvSJAORSCA4/G4fmEk
 Ma0xNVuc0uJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZnmGigAKCRAoOKI+ei28
 bxILB/9WvoJCCIA+i5WlPW8QPM4arPnipHQDNRB99cxl3yTJRQ5lvtpI8jqRXfAkvdC9XqaydNF
 UhT7EZfwhKkoF9dZ2Zq7/6FWLBc9qWLQsQO22cdE1l7TQrQZegsTkrCLw7JBlR2wqtV6AceY307
 gtujCyAXDBMa3cwnkyU/GynZvIOuB13D6XHtlzQpH22z1GeKzLTsy6Mkt/qc7xLn+gxEu7ONOb3
 QnUzYdwsYaJ8SpkYvqS2KxsTCD99eKhPMWhGzDD3rGLNY9n5tR2FOLotqAvsuoTk7JVst1znMT4
 Y/Ife0L0Vo1t+R7CG3nHWYmXRTCDoh2JWd4YflnEERcoJ+2Q
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
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
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c |  1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c   | 87 +++++++++++++++-----------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h      | 12 +---
 3 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index bfe4caa0c99d..7cb97ac8ddc5 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -507,6 +507,7 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 		}
 
 		rx_ring->obj_num = rx_obj_num;
+		rx_ring->obj_num_shift_to_u8 = BITS_PER_TYPE(u8) - ilog2(rx_obj_num);
 		rx_ring->obj_size = rx_obj_size;
 		priv->rx[i] = rx_ring;
 	}
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
index 2c2b057b7ac7..a2508e5d7b12 100644
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
@@ -80,29 +71,45 @@ mcp251xfd_check_rx_tail(const struct mcp251xfd_priv *priv,
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
+	len = (chip_head << shift) - (tail << shift);
+	*len_p = len >> shift;
 
-	ring->head = new_head;
-
-	return mcp251xfd_check_rx_tail(priv, ring);
+	return 0;
 }
 
 static void
@@ -208,6 +215,8 @@ mcp251xfd_handle_rxif_ring_uinc(const struct mcp251xfd_priv *priv,
 	if (!len)
 		return 0;
 
+	ring->head += len;
+
 	/* Increment the RX FIFO tail pointer 'len' times in a
 	 * single SPI message.
 	 *
@@ -233,22 +242,22 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
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
@@ -256,9 +265,11 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
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



