Return-Path: <linux-can+bounces-6989-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBlxID0Cq2nDZQEAu9opvQ
	(envelope-from <linux-can+bounces-6989-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 17:35:09 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D802250F6
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 17:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E800E30AD67F
	for <lists+linux-can@lfdr.de>; Fri,  6 Mar 2026 16:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413324219E4;
	Fri,  6 Mar 2026 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="dzvAOqM8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5B3EDADC;
	Fri,  6 Mar 2026 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814609; cv=none; b=Sm9a9VbUb3KdwlD36coWSpTY30coVdi23f8ge4aDqOPeI/NEtvs+t8gdn45UEHUnea7q0HrvBSPLMJ7jBN8K+c0SSnXCNDX/tveiDNnvD8g9UtcqmIgr4rdjRkO+AQBsnek5UrX1oh5C2hJyJSzFxyc4BHvyhfMF8j90lRokzT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814609; c=relaxed/simple;
	bh=WX4iliFH8rfFSUeWBkDCpuXCMfyaJLwZIYpivfuVBr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAexSdLBM7GUhCyEHl7s7WBZEOe4dkUpU3pailBqTAOT05R25LN6ZTlI53OD9pfX3yOgaV8UxyYrW53j+nFqmlaAgRlVOVh/j6H/bOfX3GYG3zp2hOwhbQQ/m1S+QsOHorUuxJX5mfAKbF8fr3LhjlCX6s9sByzn+oteZ3qrkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=dzvAOqM8 reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fSBhD1bSkz1Fljp;
	Fri,  6 Mar 2026 17:29:48 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fSBhC6vLBz1Fljm;
	Fri,  6 Mar 2026 17:29:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1772814588;
	bh=SCH4E58TYURvvthpUcjs5e27F0JdgS5Nv2Q29b4pMq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dzvAOqM84qdbgYz9JS8l4OX1z08HEDI0zhWrzw0sFa4KwTKOfM6Fu9fI1elh2wyCt
	 WVefHty8bQiMYtO1wjcHKquiOI/0PwsdWsltnBRY9ovEm3pdl6CsRQIEl+uTjTi4we
	 TfEioaLp+sELrm0r4PfpmDlUg/Dm5SAQNgTTKpxj57p40cs2rrIQGQdmAgyWkSdy9P
	 p/rmx7QzzCeb1KNCbOx0frhxv/+ohu+il68KQpBVdUumYAyUGEhbseDMG83aDU5Bl8
	 yErpT22r5at3BCRH/pyn2TVtkUlmvAc7a1MZv59SEKg/1XvYXotI8nBm/OGybKxVAV
	 2GR4CH7CtOk1A==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v6 14/15] can: grcan: Update echo skb handling to match variable length CANFD frame
Date: Fri,  6 Mar 2026 17:29:33 +0100
Message-ID: <20260306162934.22955-15-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306162934.22955-1-arun.muthusamy@gaisler.com>
References: <20260306162934.22955-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38D802250F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6989-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.877];
	DKIM_TRACE(0.00)[gaisler.com:~];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:mid,gaisler.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Refactor echo socket buffer management by introducing dedicated indices
for current and next echo slots.

- Introduce "echo_skb_idx" to keep track of the current packet index in
  the echo buffer, and "next_echo_idx" for the next available slot.
- Adjust memory allocation for echo skb to calculate the number of slots
  based on slot size.
- Enhance logic in catch_up_echo_skb() to correctly process and free echo
  skbs.
- Initialize "next_echo_idx" in grcan_set_mode() to ensure proper starting
  conditions when the device enters proper modes.
- Improve memory and index handling in grcan_start_xmit() and
  added a check to stop the network queue when necessary.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 53 ++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 514a065cab5f..9204fcb93b2d 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -312,6 +312,15 @@ struct grcan_priv {
 
 	struct sk_buff **echo_skb;	/* We allocate this on our own */
 
+	/*
+	 * Since the CAN FD frame has a variable length, this variable is used
+	 * to keep track of the index of the CAN echo skb (socket buffer) frame.
+	 */
+	u32 echo_skb_idx;
+
+	/* Next echo skb free slot index */
+	u32 next_echo_idx;
+
 	/* The echo skb pointer, pointing into echo_skb and indicating which
 	 * frames can be echoed back. See the "Notes on the tx cyclic buffer
 	 * handling"-comment for grcan_start_xmit for more details.
@@ -593,7 +602,7 @@ static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
 	struct grcan_registers __iomem *regs = priv->regs;
 	struct grcan_dma *dma = &priv->dma;
 	struct net_device_stats *stats = &dev->stats;
-	int i, work_done;
+	int work_done;
 
 	/* Updates to priv->eskbp and wake-ups of the queue needs to
 	 * be atomic towards the reads of priv->eskbp and shut-downs
@@ -604,19 +613,22 @@ static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
 	for (work_done = 0; work_done < budget || budget < 0; work_done++) {
 		if (priv->eskbp == txrd)
 			break;
-		i = priv->eskbp / GRCAN_MSG_SIZE;
-		if (echo) {
-			/* Normal echo of messages */
-			stats->tx_packets++;
-			stats->tx_bytes += can_get_echo_skb(dev, i, NULL);
-		} else {
-			/* For cleanup of untransmitted messages */
-			can_free_echo_skb(dev, i, NULL);
-		}
 
 		priv->eskbp = grcan_ring_add(priv->eskbp, GRCAN_MSG_SIZE,
 					     dma->tx.size);
 		txrd = grcan_read_reg(&regs->txrd);
+
+		/* Grab the packet once the packet is send or free untransmitted packet */
+		if (priv->eskbp == txrd) {
+			if (echo) {
+				/* Normal echo of messages */
+				stats->tx_packets++;
+				stats->tx_bytes += can_get_echo_skb(dev, priv->echo_skb_idx, NULL);
+			} else {
+				/* For cleanup of untransmitted messages */
+				can_free_echo_skb(dev, priv->echo_skb_idx, NULL);
+			}
+		}
 	}
 	return work_done;
 }
@@ -1124,6 +1136,7 @@ static int grcan_set_mode(struct net_device *dev, enum can_mode mode)
 			if (!(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
 				netif_wake_queue(dev);
 		}
+		priv->next_echo_idx = 0;
 		spin_unlock_irqrestore(&priv->lock, flags);
 		return err;
 	}
@@ -1135,6 +1148,7 @@ static int grcan_open(struct net_device *dev)
 	struct grcan_priv *priv = netdev_priv(dev);
 	struct grcan_dma *dma = &priv->dma;
 	unsigned long flags;
+	u32 nr_echo_slots;
 	int err;
 
 	/* Allocate memory */
@@ -1145,13 +1159,15 @@ static int grcan_open(struct net_device *dev)
 		return err;
 	}
 
-	priv->echo_skb = kcalloc(dma->tx.size, sizeof(*priv->echo_skb),
+	nr_echo_slots = dma->tx.size / GRCAN_MSG_SIZE;
+
+	priv->echo_skb = kcalloc(nr_echo_slots, sizeof(*priv->echo_skb),
 				 GFP_KERNEL);
 	if (!priv->echo_skb) {
 		err = -ENOMEM;
 		goto exit_free_dma_buffers;
 	}
-	priv->can.echo_skb_max = dma->tx.size;
+	priv->can.echo_skb_max = nr_echo_slots;
 	priv->can.echo_skb = priv->echo_skb;
 
 	/* Get can device up */
@@ -1468,7 +1484,6 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	struct can_frame *cf;
 	unsigned long flags;
 	u32 oneshotmode;
-	int slotindex;
 	u8 *payload;
 	u8 len;
 	int i;
@@ -1505,11 +1520,9 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 
 	txwr = grcan_read_reg(&regs->txwr);
 	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
-
-	slotindex = txwr / GRCAN_MSG_SIZE;
 	bds = grcan_numbds(len);
 
-	if (unlikely(space < bds)) {
+	if (unlikely(space < bds || priv->can.echo_skb[priv->echo_skb_idx])) {
 		netif_stop_queue(dev);
 		spin_unlock_irqrestore(&priv->lock, flags);
 		return NETDEV_TX_BUSY;
@@ -1589,7 +1602,13 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	 * can_put_echo_skb would be an error unless other measures are
 	 * taken.
 	 */
-	can_put_echo_skb(skb, dev, slotindex, 0);
+
+	priv->echo_skb_idx = priv->next_echo_idx;
+
+	can_put_echo_skb(skb, dev, priv->next_echo_idx, 0);
+
+	/* Move to the next index in the echo skb buffer */
+	priv->next_echo_idx = (priv->next_echo_idx + 1) % priv->can.echo_skb_max;
 
 	/* Make sure everything is written before allowing hardware to
 	 * read from the memory
-- 
2.51.0


