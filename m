Return-Path: <linux-can+bounces-888-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 933BA91C84E
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 23:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0932B1F2466B
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007D6133987;
	Fri, 28 Jun 2024 21:41:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B85839E4
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610890; cv=none; b=H05q7m/lmYyof3DmmORd7zEDsiYLAQxVMJa7Jy38IQB5mo/uW8mfxYziuln5drE5kWRkGAdN27rMO+ZleK+mGKZ5TtN87x3ezu8BbGJGviMcwP40PPbGGahlRD64MnlKnlh5d6Hs3nFx51DkWtbJQOQrOuweGAXwf+sm48+Gs/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610890; c=relaxed/simple;
	bh=fR/8Iq+vMHXdFbsqvNuXLwby/+9ZrTHiIzXXqkGy1jY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LW94ojNvunHIoPEksB3JmTD46C46bMIKnIZNjyR+g6Xp704Gaj/OVhBFy4b1XtewokIPdgKaXu865WwtkSmxni4ai8y0w0qHJkw5MdHj42s1BYSuLLTBPAgQZPckwlNYaBy9hkt5Nq33jcjksdXhRh5LjRFlfNFuqWlpUv5c93Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNJLS-0001gg-KR
	for linux-can@vger.kernel.org; Fri, 28 Jun 2024 23:41:26 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNJLQ-005h7l-By
	for linux-can@vger.kernel.org; Fri, 28 Jun 2024 23:41:24 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 08A872F6100
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 21:41:23 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id CCD492F60B3;
	Fri, 28 Jun 2024 21:41:20 +0000 (UTC)
Received: from [10.11.86.119] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a51678be;
	Fri, 28 Jun 2024 21:41:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 28 Jun 2024 23:40:33 +0200
Subject: [PATCH v4 9/9] can: mcp251xfd: tef: update workaround for erratum
 DS80000789E 6 of mcp2518fd
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240628-mcp251xfd-workaround-erratum-6-v4-9-53586f168524@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5274; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=fR/8Iq+vMHXdFbsqvNuXLwby/+9ZrTHiIzXXqkGy1jY=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmfy35nqHfF39u+8mQYnTe4zWE0sr003VU+b2aD
 pXIxZvreIKJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZn8t+QAKCRAoOKI+ei28
 b8tRB/91uCEl5s8ZzFQvLbTaS7ddrFi0WKHBstZjSJ3z+TOzJoU1MEQjwsfPaFoI+qPGHtYvjVt
 RiCdlnz9KzqN0QR2qBG9Ox1ABtHrFfbrwJxBfMcoNZLsJwFka6QU8kycJ16MXVa+3A78PJhH56h
 bxxYTh7DiIRE97/6aXVy9VGo1SXcWotsZxArkC+4lkhB0G9vIjqX5v0LLOr6vSQqlP/ualvwwFP
 BDDi42ztI/Ro4L6FGAMWJqAaxTqF9w9Lbkvulqvd4bxgxQaGEaehF+EMsuN3xoojzZcCyFyDB3e
 nVVqt1h1RzKwvXVRGg8tRIRWJ5IQuBCjbMIpXpQouczmhoL3
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

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
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 71 ++++++++++-----------------
 1 file changed, 27 insertions(+), 44 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index 3d9c348ad868..f732556d233a 100644
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



