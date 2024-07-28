Return-Path: <linux-can+bounces-1023-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B2793E315
	for <lists+linux-can@lfdr.de>; Sun, 28 Jul 2024 03:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C763E1C212B6
	for <lists+linux-can@lfdr.de>; Sun, 28 Jul 2024 01:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A391A0710;
	Sun, 28 Jul 2024 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOqX9yGn"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453921A070A;
	Sun, 28 Jul 2024 00:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128145; cv=none; b=ljI5AqmqC0YbRfMVhFRYwMdDJWvxR2BrvTwXgPgAmCzeZ0rkKCW+iX+KL+IT/ARTFlbrLV3bsEuITLMSXZ74aNmTyPCI8eKLcUVd+FHP7sRYBynwqQQYz9T0DdK0TiIJp4R1QVxqWFirzfBKeBdtcSISlZykDvvxUYrM1TjAy2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128145; c=relaxed/simple;
	bh=jAPbD+tDdAEkxrjW3ugyTUD4yrD+HqPFygSPY3+5zxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqR4XdqjOdr4rGpvjWzgNn8BJy0+iBf9iNi9r69a/4yomnTSZEKCIHAHhv1M8wITZVs5Whj5gBBZwWtDejgbdalnpVhScaj7PbEIbdQqHObnGme7dqXCBu1KM9mnoMRZHj0oFpuADSR5BS5I8N4hSr2LN7jG7PSqACYkUHNnScU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOqX9yGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239D6C4AF07;
	Sun, 28 Jul 2024 00:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128144;
	bh=jAPbD+tDdAEkxrjW3ugyTUD4yrD+HqPFygSPY3+5zxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XOqX9yGnHFi3gq51b88h8ceM6iFQjRxzSZYARvxEG/NQZft4CWh8Lza06mgmCPkkc
	 ZyziVN3Z8AfS7PgwrDKsZ9h0Z6yiSEe/WQJnmg4PrlfZNq48OXS8vzP5v+iUFTraY4
	 mq43sV9hHPsps2R/kusAVC5CA5YnuRXkb8WN6WXa9SnQXiZPCn8qg63/PXSuNZ5PdD
	 bycKWy6FJNnzcELxaZicSJFQLr7jkrUFgK+IFiswPcdFpXtZI216IWnCKZ2c8OTqe7
	 r1o7wUgIxQ7YIa1U2JtpCdkJLShk/VASBly/o5hy+ggs3NvaEHFBwJXSuG95WXz82E
	 C7SuQJDdwWz/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	=?UTF-8?q?Stefan=20Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Sasha Levin <sashal@kernel.org>,
	manivannan.sadhasivam@linaro.org,
	mailhol.vincent@wanadoo.fr,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/11] can: mcp251xfd: tef: update workaround for erratum DS80000789E 6 of mcp2518fd
Date: Sat, 27 Jul 2024 20:55:15 -0400
Message-ID: <20240728005522.1731999-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005522.1731999-1-sashal@kernel.org>
References: <20240728005522.1731999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 3a0a88fcbaf9e027ecca3fe8775be9700b4d6460 ]

This patch updates the workaround for a problem similar to erratum
DS80000789E 6 of the mcp2518fd, the other variants of the chip
family (mcp2517fd and mcp251863) are probably also affected.

Erratum DS80000789E 6 says "reading of the FIFOCI bits in the FIFOSTA
register for an RX FIFO may be corrupted". However observation shows
that this problem is not limited to RX FIFOs but also effects the TEF
FIFO.

In the bad case, the driver reads a too large head index. As the FIFO
is implemented as a ring buffer, this results in re-handling old CAN
transmit complete events.

Every transmit complete event contains with a sequence number that
equals to the sequence number of the corresponding TX request. This
way old TX complete events can be detected.

If the original driver detects a non matching sequence number, it
prints an info message and tries again later. As wrong sequence
numbers can be explained by the erratum DS80000789E 6, demote the info
message to debug level, streamline the code and update the comments.

Keep the behavior: If an old CAN TX complete event is detected, abort
the iteration and mark the number of valid CAN TX complete events as
processed in the chip by incrementing the FIFO's tail index.

Cc: Stefan Althöfer <Stefan.Althoefer@janztec.com>
Cc: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 71 +++++++------------
 1 file changed, 27 insertions(+), 44 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index b33192964cf7d..902eb767426d1 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -60,56 +60,39 @@ static int mcp251xfd_check_tef_tail(const struct mcp251xfd_priv *priv)
 	return 0;
 }
 
-static int
-mcp251xfd_handle_tefif_recover(const struct mcp251xfd_priv *priv, const u32 seq)
-{
-	const struct mcp251xfd_tx_ring *tx_ring = priv->tx;
-	u32 tef_sta;
-	int err;
-
-	err = regmap_read(priv->map_reg, MCP251XFD_REG_TEFSTA, &tef_sta);
-	if (err)
-		return err;
-
-	if (tef_sta & MCP251XFD_REG_TEFSTA_TEFOVIF) {
-		netdev_err(priv->ndev,
-			   "Transmit Event FIFO buffer overflow.\n");
-		return -ENOBUFS;
-	}
-
-	netdev_info(priv->ndev,
-		    "Transmit Event FIFO buffer %s. (seq=0x%08x, tef_tail=0x%08x, tef_head=0x%08x, tx_head=0x%08x).\n",
-		    tef_sta & MCP251XFD_REG_TEFSTA_TEFFIF ?
-		    "full" : tef_sta & MCP251XFD_REG_TEFSTA_TEFNEIF ?
-		    "not empty" : "empty",
-		    seq, priv->tef->tail, priv->tef->head, tx_ring->head);
-
-	/* The Sequence Number in the TEF doesn't match our tef_tail. */
-	return -EAGAIN;
-}
-
 static int
 mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 			   const struct mcp251xfd_hw_tef_obj *hw_tef_obj,
 			   unsigned int *frame_len_ptr)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
+	u32 seq, tef_tail_masked, tef_tail;
 	struct sk_buff *skb;
-	u32 seq, seq_masked, tef_tail_masked, tef_tail;
 
-	seq = FIELD_GET(MCP251XFD_OBJ_FLAGS_SEQ_MCP2518FD_MASK,
+	 /* Use the MCP2517FD mask on the MCP2518FD, too. We only
+	  * compare 7 bits, this is enough to detect old TEF objects.
+	  */
+	seq = FIELD_GET(MCP251XFD_OBJ_FLAGS_SEQ_MCP2517FD_MASK,
 			hw_tef_obj->flags);
-
-	/* Use the MCP2517FD mask on the MCP2518FD, too. We only
-	 * compare 7 bits, this should be enough to detect
-	 * net-yet-completed, i.e. old TEF objects.
-	 */
-	seq_masked = seq &
-		field_mask(MCP251XFD_OBJ_FLAGS_SEQ_MCP2517FD_MASK);
 	tef_tail_masked = priv->tef->tail &
 		field_mask(MCP251XFD_OBJ_FLAGS_SEQ_MCP2517FD_MASK);
-	if (seq_masked != tef_tail_masked)
-		return mcp251xfd_handle_tefif_recover(priv, seq);
+
+	/* According to mcp2518fd erratum DS80000789E 6. the FIFOCI
+	 * bits of a FIFOSTA register, here the TX FIFO tail index
+	 * might be corrupted and we might process past the TEF FIFO's
+	 * head into old CAN frames.
+	 *
+	 * Compare the sequence number of the currently processed CAN
+	 * frame with the expected sequence number. Abort with
+	 * -EBADMSG if an old CAN frame is detected.
+	 */
+	if (seq != tef_tail_masked) {
+		netdev_dbg(priv->ndev, "%s: chip=0x%02x ring=0x%02x\n", __func__,
+			   seq, tef_tail_masked);
+		stats->tx_fifo_errors++;
+
+		return -EBADMSG;
+	}
 
 	tef_tail = mcp251xfd_get_tef_tail(priv);
 	skb = priv->can.echo_skb[tef_tail];
@@ -223,12 +206,12 @@ int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 		unsigned int frame_len = 0;
 
 		err = mcp251xfd_handle_tefif_one(priv, &hw_tef_obj[i], &frame_len);
-		/* -EAGAIN means the Sequence Number in the TEF
-		 * doesn't match our tef_tail. This can happen if we
-		 * read the TEF objects too early. Leave loop let the
-		 * interrupt handler call us again.
+		/* -EBADMSG means we're affected by mcp2518fd erratum
+		 * DS80000789E 6., i.e. the Sequence Number in the TEF
+		 * doesn't match our tef_tail. Don't process any
+		 * further and mark processed frames as good.
 		 */
-		if (err == -EAGAIN)
+		if (err == -EBADMSG)
 			goto out_netif_wake_queue;
 		if (err)
 			return err;
-- 
2.43.0


