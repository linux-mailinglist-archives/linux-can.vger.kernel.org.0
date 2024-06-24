Return-Path: <linux-can+bounces-859-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E64F89150BB
	for <lists+linux-can@lfdr.de>; Mon, 24 Jun 2024 16:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0091C22253
	for <lists+linux-can@lfdr.de>; Mon, 24 Jun 2024 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80C319E7E9;
	Mon, 24 Jun 2024 14:45:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3119DF73
	for <linux-can@vger.kernel.org>; Mon, 24 Jun 2024 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240352; cv=none; b=dhFXCVFpSldRaR4jox7pPbMTDPVbc5lxNW8kmNJvGzidY1MWv9wxLWodfk/m9buBfwlzD9osAdtcccAR9dL4uIgnaQczmwLzmKnp+2tSyl3BF3EpAUhVPRaNkhPqcC4EfkvXHgxUCb2ZayMCm9kPqypTbAMXzX6CX83fBFxBGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240352; c=relaxed/simple;
	bh=XkgIm9CNVMttt5e02l333bDwh/1vl8h+CDgTUESZPQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AML3eQiflQTCxsGTa6BH/O2hc/YBuPhve1v9hpchQgz8CZaQZ231zhv8jjYqLGbsOUYw8FuiW7RZw3nyykqq1PzPEnYKGfkWcBmGgKDk4xrdwVcIk1+VHhaddKbsrapNtayJD6M1+Ew2hPoyBeWC10zSNQPPqwnWKyL6cbTX+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sLkx1-0002yW-I8
	for linux-can@vger.kernel.org; Mon, 24 Jun 2024 16:45:47 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sLkwy-004fq6-98
	for linux-can@vger.kernel.org; Mon, 24 Jun 2024 16:45:44 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E800E2F1A83
	for <linux-can@vger.kernel.org>; Mon, 24 Jun 2024 14:45:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 57A8A2F1A0D;
	Mon, 24 Jun 2024 14:45:38 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b1518dcb;
	Mon, 24 Jun 2024 14:45:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 24 Jun 2024 16:45:11 +0200
Subject: [PATCH v3 7/9] can: mcp251xfd: rx: add workaround for erratum
 DS80000789E 6 of mcp2518fd
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240624-mcp251xfd-workaround-erratum-6-v3-7-caf7e5f27f60@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5269; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=XkgIm9CNVMttt5e02l333bDwh/1vl8h+CDgTUESZPQc=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmeYaMlB6lkdELKw+98jpUco3pjDxZDS8Y/K27z
 j7NHQelDkiJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZnmGjAAKCRAoOKI+ei28
 bzV+B/43FaICOeKdvuzS52su9+L7DAeEJjB5ybyGx/nna0ynQ6wyixHf1JfFvZZRcB9D/QBU/wy
 /E4RjKO1RPM36K1KjjRxZWe1ckHyiTTjSXLjv0ABEyqYFZEnhalcUGUbKVgMh8svvSWMbkBj7G7
 i5XNDfoBMCdvv2qFB7oHH0/iwqwGOtpXjvBlE38nfejrje2IDyVlOBe1wkJ6EcJMWW2EiWFKfFE
 UsQmFo3xrUnQFwJTEcUpuxwv+0tDw7IyGSxsuWJra59S+XkJEgNoDB3IG/soxzhC3f2+p2USW0/
 /Ayo+BQQY5n+BtO2/DYqA+ay7IEGAVMkQ8BX1tDhKq9QJt3/
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

This patch tries to works around erratum DS80000789E 6 of the
mcp2518fd, the other variants of the chip family (mcp2517fd and
mcp251863) are probably also affected.

In the bad case, the driver reads a too large head index. In the
original code, the driver always trusted the read value, which caused
old, already processed CAN frames or new, incompletely written CAN
frames to be (re-)processed.

To work around this issue, keep a per FIFO timestamp [1] of the last
valid received CAN frame and compare against the timestamp of every
received CAN frame. If an old CAN frame is detected, abort the
iteration and mark the number of valid CAN frames as processed in the
chip by incrementing the FIFO's tail index.

Further tests showed that this workaround can recognize old CAN
frames, but a small time window remains in which partially written CAN
frames [2] are not recognized but then processed. These CAN frames
have the correct data and time stamps, but the DLC has not yet been
updated.

[1] As the raw timestamp overflows every 107 seconds (at the usual
    clock rate of 40 MHz) convert it to nanoseconds with the
    timecounter framework and use this to detect stale CAN frames.

Link: https://lore.kernel.org/all/BL3PR11MB64844C1C95CA3BDADAE4D8CCFBC99@BL3PR11MB6484.namprd11.prod.outlook.com [2]
Reported-by: Stefan Althöfer <Stefan.Althoefer@janztec.com>
Closes: https://lore.kernel.org/all/FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
Tested-by: Stefan Althöfer <Stefan.Althoefer@janztec.com>
Tested-by: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c |  1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c   | 32 +++++++++++++++++++++++---
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h      |  3 +++
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index 7cb97ac8ddc5..de2322667a8d 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -206,6 +206,7 @@ mcp251xfd_ring_init_rx(struct mcp251xfd_priv *priv, u16 *base, u8 *fifo_nr)
 	int i, j;
 
 	mcp251xfd_for_each_rx_ring(priv, rx_ring, i) {
+		rx_ring->last_valid = timecounter_read(&priv->tc);
 		rx_ring->head = 0;
 		rx_ring->tail = 0;
 		rx_ring->base = *base;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
index a2508e5d7b12..bfdf0b6725fb 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
@@ -155,8 +155,6 @@ mcp251xfd_hw_rx_obj_to_skb(const struct mcp251xfd_priv *priv,
 
 	if (!(hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_RTR))
 		memcpy(cfd->data, hw_rx_obj->data, cfd->len);
-
-	mcp251xfd_skb_set_timestamp_raw(priv, skb, hw_rx_obj->ts);
 }
 
 static int
@@ -167,8 +165,26 @@ mcp251xfd_handle_rxif_one(struct mcp251xfd_priv *priv,
 	struct net_device_stats *stats = &priv->ndev->stats;
 	struct sk_buff *skb;
 	struct canfd_frame *cfd;
+	u64 timestamp;
 	int err;
 
+	/* According to mcp2518fd erratum DS80000789E 6. the FIFOCI
+	 * bits of a FIFOSTA register, here the RX FIFO head index
+	 * might be corrupted and we might process past the RX FIFO's
+	 * head into old CAN frames.
+	 *
+	 * Compare the timestamp of currently processed CAN frame with
+	 * last valid frame received. Abort with -EBADMSG if an old
+	 * CAN frame is detected.
+	 */
+	timestamp = timecounter_cyc2time(&priv->tc, hw_rx_obj->ts);
+	if (timestamp <= ring->last_valid) {
+		stats->rx_fifo_errors++;
+
+		return -EBADMSG;
+	}
+	ring->last_valid = timestamp;
+
 	if (hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_FDF)
 		skb = alloc_canfd_skb(priv->ndev, &cfd);
 	else
@@ -179,6 +195,7 @@ mcp251xfd_handle_rxif_one(struct mcp251xfd_priv *priv,
 		return 0;
 	}
 
+	mcp251xfd_skb_set_timestamp(skb, timestamp);
 	mcp251xfd_hw_rx_obj_to_skb(priv, hw_rx_obj, skb);
 	err = can_rx_offload_queue_timestamp(&priv->offload, skb, hw_rx_obj->ts);
 	if (err)
@@ -261,7 +278,16 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
 			err = mcp251xfd_handle_rxif_one(priv, ring,
 							(void *)hw_rx_obj +
 							i * ring->obj_size);
-			if (err)
+
+			/* -EBADMSG means we're affected by mcp2518fd
+			 * erratum DS80000789E 6., i.e. the timestamp
+			 * in the RX object is older that the last
+			 * valid received CAN frame. Don't process any
+			 * further and mark processed frames as good.
+			 */
+			if (err == -EBADMSG)
+				return mcp251xfd_handle_rxif_ring_uinc(priv, ring, i);
+			else if (err)
 				return err;
 		}
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 453a2b193c75..d32ece3d7aee 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -552,6 +552,9 @@ struct mcp251xfd_rx_ring {
 	unsigned int head;
 	unsigned int tail;
 
+	/* timestamp of the last valid received CAN frame */
+	u64 last_valid;
+
 	u16 base;
 	u8 nr;
 	u8 fifo_nr;

-- 
2.43.0



