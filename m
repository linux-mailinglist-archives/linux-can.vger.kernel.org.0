Return-Path: <linux-can+bounces-887-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120F991C849
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 23:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 465FBB2311B
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C012D758;
	Fri, 28 Jun 2024 21:41:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5412881741
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610889; cv=none; b=l+gpwRgK/nr8iFofK8tBu4Y7rdwhcUADefk2DBvF06+/zVNWHpVAmm1X6u6YrAMOVKZR2H5GPYZquCT6zMBkGNFDmDzGGYNgAIZJkCiQM0b6cnyR3iynwRaUlXNQTjtw+3fZ5KqtjcUQOn50J38Tr2A3uzjdCjBM9oX3Cx9FYXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610889; c=relaxed/simple;
	bh=y4YMfF2UpMjx5Ir6P7k8Z/XygCqQWFGYcq5Dd8e1Vv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DS7gK2zudOeElF9vCYdLkjSROPQLtE26Vk9qAxl3j1m8U+Vsrej5pLq9FOwoAmonNQFsZK7MTeG+WHDdHSpHZ4DTDwIFiSSTMzJymdSubpDHo65OA8YzRUDZd1yhr7PNLRf3rRe684Uy4oAT78lOECzEL51DmrB9RQmumExSeKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNJLR-0001eh-Il
	for linux-can@vger.kernel.org; Fri, 28 Jun 2024 23:41:25 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNJLP-005h6N-AK
	for linux-can@vger.kernel.org; Fri, 28 Jun 2024 23:41:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E968C2F60EC
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 21:41:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 17B282F608A;
	Fri, 28 Jun 2024 21:41:19 +0000 (UTC)
Received: from [10.11.86.119] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 498db432;
	Fri, 28 Jun 2024 21:41:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 28 Jun 2024 23:40:29 +0200
Subject: [PATCH v4 5/9] can: mcp251xfd: mcp251xfd_handle_rxif_ring_uinc():
 factor out in separate function
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240628-mcp251xfd-workaround-erratum-6-v4-5-53586f168524@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2710; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=y4YMfF2UpMjx5Ir6P7k8Z/XygCqQWFGYcq5Dd8e1Vv4=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmfy3z09kSNKBJI4K068RsfP8Pot9GDV0y5X3MF
 NOADtqoxcuJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZn8t8wAKCRAoOKI+ei28
 b6gmCACZfw36US6V1RKrjEpTqdCQ4Tu+3cZrgFCdik6iUv2gUoQngAYm2pUoiy0pSFa5pj8hh4v
 bSkwFycLmCInTKYn0/Cex1l8u5FdB7w88i4A9BKLv+Ij9DP6YOFhzG/vQDeBp7G1c9kud2gmCro
 5YnUqxgQBm50U+q57c/wyCJ/6mlEK4cfLy6Rmc4ItkT5wlvJv9G6eblPUdvJRuw1m9tfJnz6j8t
 i7GbOKLU7pnKqL5pEfQxSDnxLO57HtinQ79N109MTIBVZI3aclbPZqLWorHpbuuGiRWllr7a9Re
 C71Ag8/W7RZMLoY+xWl2Y9+aDmZGshNOs5GyKWsGNh+rH4Gj
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

This is a preparation patch.

Sending the UINC messages followed by incrementing the tail pointer
will be called in more than one place in upcoming patches, so factor
this out into a separate function.

Also make mcp251xfd_handle_rxif_ring_uinc() safe to be called with a
"len" of 0.

Tested-by: Stefan Althöfer <Stefan.Althoefer@janztec.com>
Tested-by: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c | 48 ++++++++++++++++++----------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
index 6d66b97709b8..2c2b057b7ac7 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
@@ -197,6 +197,37 @@ mcp251xfd_rx_obj_read(const struct mcp251xfd_priv *priv,
 	return err;
 }
 
+static int
+mcp251xfd_handle_rxif_ring_uinc(const struct mcp251xfd_priv *priv,
+				struct mcp251xfd_rx_ring *ring,
+				u8 len)
+{
+	int offset;
+	int err;
+
+	if (!len)
+		return 0;
+
+	/* Increment the RX FIFO tail pointer 'len' times in a
+	 * single SPI message.
+	 *
+	 * Note:
+	 * Calculate offset, so that the SPI transfer ends on
+	 * the last message of the uinc_xfer array, which has
+	 * "cs_change == 0", to properly deactivate the chip
+	 * select.
+	 */
+	offset = ARRAY_SIZE(ring->uinc_xfer) - len;
+	err = spi_sync_transfer(priv->spi,
+				ring->uinc_xfer + offset, len);
+	if (err)
+		return err;
+
+	ring->tail += len;
+
+	return 0;
+}
+
 static int
 mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
 			   struct mcp251xfd_rx_ring *ring)
@@ -210,8 +241,6 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
 		return err;
 
 	while ((len = mcp251xfd_get_rx_linear_len(ring))) {
-		int offset;
-
 		rx_tail = mcp251xfd_get_rx_tail(ring);
 
 		err = mcp251xfd_rx_obj_read(priv, ring, hw_rx_obj,
@@ -227,22 +256,9 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
 				return err;
 		}
 
-		/* Increment the RX FIFO tail pointer 'len' times in a
-		 * single SPI message.
-		 *
-		 * Note:
-		 * Calculate offset, so that the SPI transfer ends on
-		 * the last message of the uinc_xfer array, which has
-		 * "cs_change == 0", to properly deactivate the chip
-		 * select.
-		 */
-		offset = ARRAY_SIZE(ring->uinc_xfer) - len;
-		err = spi_sync_transfer(priv->spi,
-					ring->uinc_xfer + offset, len);
+		err = mcp251xfd_handle_rxif_ring_uinc(priv, ring, len);
 		if (err)
 			return err;
-
-		ring->tail += len;
 	}
 
 	return 0;

-- 
2.43.0



