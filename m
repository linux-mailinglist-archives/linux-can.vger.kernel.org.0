Return-Path: <linux-can+bounces-890-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AC091C854
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 23:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1551C2307B
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FBB13C3CA;
	Fri, 28 Jun 2024 21:41:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5EA82483
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610891; cv=none; b=kIsNRsftLw1+O0TTcjX7jFDSp9GYg2o66cRswDgXMGmp49ynMwpSMNh2SwYdj5KMfIzCz6VtKX9CDplVdxuDY8FES5MBMiY58HNCgdUVPCkAmG9K+hQfRdvRkmlrHXNVmGB8Y56R9fBkSxm7pthrZrKxMvQeX5TXw2HruplqWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610891; c=relaxed/simple;
	bh=4p0i+nUcOPtKqa/Odtx5N11AN8j+P8ZlzdoFUSDJLFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GB+6MT2PC5aB1bL3iRgc08uuqSOtKaJMmVo883BZwImu7WqFC0s/6wi2bGi0HcR2JyRJrjnvMPAojM35AjqSPC2qngd5ggNOF44QtOW4q9lvvTsDATQTmLXwWFCjnbiNMp46u+1Q2AwX0TSni/xAEVOF4JHgKwKo3VrMBrDy+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNJLR-0001ep-Md
	for linux-can@vger.kernel.org; Fri, 28 Jun 2024 23:41:25 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNJLP-005h6Z-D8
	for linux-can@vger.kernel.org; Fri, 28 Jun 2024 23:41:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 13DCC2F60EE
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 21:41:23 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 946D72F6095;
	Fri, 28 Jun 2024 21:41:19 +0000 (UTC)
Received: from [10.11.86.119] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ad5701c5;
	Fri, 28 Jun 2024 21:41:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 28 Jun 2024 23:40:30 +0200
Subject: [PATCH v4 6/9] can: mcp251xfd: rx: prepare to workaround broken RX
 FIFO head index erratum
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240628-mcp251xfd-workaround-erratum-6-v4-6-53586f168524@pengutronix.de>
References: <20240628-mcp251xfd-workaround-erratum-6-v4-0-53586f168524@pengutronix.de>
In-Reply-To: <20240628-mcp251xfd-workaround-erratum-6-v4-0-53586f168524@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8043; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=4p0i+nUcOPtKqa/Odtx5N11AN8j+P8ZlzdoFUSDJLFk=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmfy30EzmA7xwrvcVJpeqrW5HgmLZReeSuV7hLr
 JWGxRHxjOqJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZn8t9AAKCRAoOKI+ei28
 b6nUCACPkNin7/RLzcaDF9QdsaK2ssfkhIsyjGERgB+EI3mphQCVk8cr8TPr5PFlLWNU1HL1QnM
 CgiFnpJhZsi+xqD0J52i+fS2cXh+ooIh/pYllHYnpWJj+4zPfSqYTlfIoa/ABAMtFay+ziHW78n
 nA1UmngKMnEjqILIe9YotR08Qab9W0gFqGYHpsvI1598WoTzBq9YajRAe6f3vL0A9dXHUTW/dDm
 kk0JEAv+wbcRlT0gsNvfc61pXJ6rx18I5GF4jknlMDn9TLLrDGTtUcykTBGUMvyxffoEmzP7B+6
 IUmKV90Giz4HgtkD7PrXxMmKdJnO8oPC4prcy7fKqI5b8qMb
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
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c |  2 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c   | 89 +++++++++++++++-----------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h      | 12 +---
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



