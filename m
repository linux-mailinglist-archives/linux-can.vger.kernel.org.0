Return-Path: <linux-can+bounces-6572-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Jt8A7Ihk2lJ1wEAu9opvQ
	(envelope-from <linux-can+bounces-6572-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 14:54:58 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B681443D6
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 14:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD4B53012507
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9113161A0;
	Mon, 16 Feb 2026 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="QSBhIzc8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B531352A;
	Mon, 16 Feb 2026 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250044; cv=none; b=rmSRAVi8ecB3+uZRGJIn9nYD623H/wwaOKYxun9+vI2NJmZi5jvvKlwk6gdrpzSPWXyhw/mTtx4igvr857gMT4lPHtRe114cKlQQ84s5LscuBHii9V5CRe3r7xhzHPhhH1UQYbs1663Lkalb9vI74MFrv+/9rq+3oT/rONu2AYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250044; c=relaxed/simple;
	bh=ENUF8LMffyNJA2t5gNftVFGB/j2V20hOXd3R8Iv1v4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXH26poL/XflT2+k4ujFXGqvdvz3VX1X1eVLCHZRTk50yYcFI8EHg/fo8frE85RNZz4oV+xjscLH1KOYOk5vz+uJ8mJsbAcJcUcX00r5WwFuWKYToF92CJXq/jugGTDk3x10isIuhS3qowniwrmlDqi9t/c8iFLfBMpN46P3O9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=QSBhIzc8 reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fF44c5tfBz1Fbwd;
	Mon, 16 Feb 2026 14:53:52 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fF44c3qllz1Fbwh;
	Mon, 16 Feb 2026 14:53:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1771250032;
	bh=BAwgA5B2Fkxxn4aVdYR5mOLyDs1iukIf1f2W8NScSDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QSBhIzc8FKYuQQqNJQXK+vzqxsXTkug0ozCObojgKO3sv57ruOfs80x1syddEUpbp
	 DEaKQlC+ktGl4nqqQw765uwLf6mJRc8hTXFWZApOLBIrBYRycevaTOn7GGCqvq1pkp
	 w3tiU19+L8og0EUDQOSwhUij1jPCW6mDFKKR38zejLjJISxED0UZ/XKv44ykhJ2ztq
	 IG6mdBcWknpj6S3dEwiGNIhjHym+qSdgATXo9J9OblzO5JFDWT7RxtgQO6ouOZYHnl
	 2OQgKMD1Kzm0NbtF30eHW0W9CZ3rDFJrwlCDUM+u1oF6U1KuiMlIEFHresLAkWDx5F
	 s3Jw+sgwWqmPQ==
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
Subject: [PATCH v5 15/16] can: grcan: Update echo skb handling to match variable length CANFD frame
Date: Mon, 16 Feb 2026 14:53:43 +0100
Message-ID: <20260216135344.23246-16-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
References: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6572-lists,linux-can=lfdr.de];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gaisler.com:mid,gaisler.com:email]
X-Rspamd-Queue-Id: B0B681443D6
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
 drivers/net/can/grcan.c | 56 ++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index e54214f6112d..72bdea6d27cd 100644
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
@@ -581,7 +590,7 @@ static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
 	struct grcan_registers __iomem *regs = priv->regs;
 	struct grcan_dma *dma = &priv->dma;
 	struct net_device_stats *stats = &dev->stats;
-	int i, work_done;
+	int work_done;
 
 	/* Updates to priv->eskbp and wake-ups of the queue needs to
 	 * be atomic towards the reads of priv->eskbp and shut-downs
@@ -592,19 +601,22 @@ static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
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
@@ -1112,6 +1124,7 @@ static int grcan_set_mode(struct net_device *dev, enum can_mode mode)
 			if (!(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
 				netif_wake_queue(dev);
 		}
+		priv->next_echo_idx = 0;
 		spin_unlock_irqrestore(&priv->lock, flags);
 		return err;
 	}
@@ -1123,6 +1136,7 @@ static int grcan_open(struct net_device *dev)
 	struct grcan_priv *priv = netdev_priv(dev);
 	struct grcan_dma *dma = &priv->dma;
 	unsigned long flags;
+	u32 nr_echo_slots;
 	int err;
 
 	/* Allocate memory */
@@ -1133,13 +1147,15 @@ static int grcan_open(struct net_device *dev)
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
@@ -1463,7 +1479,6 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	struct can_frame *cf;
 	unsigned long flags;
 	u32 oneshotmode;
-	int slotindex;
 	u8 *payload;
 	u8 len;
 	int i;
@@ -1500,12 +1515,13 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 
 	txwr = grcan_read_reg(&regs->txwr);
 	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
-
-	slotindex = txwr / GRCAN_MSG_SIZE;
 	bds = grcan_numbds(len);
 
-	if (unlikely(space == 1))
+	if (unlikely(space < bds || priv->can.echo_skb[priv->echo_skb_idx])) {
 		netif_stop_queue(dev);
+		spin_unlock_irqrestore(&priv->lock, flags);
+		return NETDEV_TX_BUSY;
+	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 	/* End of critical section*/
@@ -1589,7 +1605,13 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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


