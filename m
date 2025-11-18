Return-Path: <linux-can+bounces-5486-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BD3C68836
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 10:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 551424F3182
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 09:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E5032B984;
	Tue, 18 Nov 2025 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="fZ6PWCz6"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DADA3002D0;
	Tue, 18 Nov 2025 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457704; cv=none; b=OpacY4ltQHldToS59wRAYREPKb5Cf/GFbY3+p+DN3n4EU2Gpx9+RzyqJf5CjfL+UACffUxratlqsJwv1fRY59hFo/ENrJ9lxeodQumn/qU+sViib6TR+NttOWnvXAsWQU0BfMfdY1wDqW+PPpCXnFHbtH1YDxLDM3ucMJ0J6aEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457704; c=relaxed/simple;
	bh=eYJDVvzMxd54Z6ewy3W7588Nnt5sWQmA67ybVJy6Miw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rn//xuVYQ9w/VYAH+akARL2dfghA7wwnxHS8/oXBnMwPSJL5eJWsHScX7CpOzgpGeUZSZH3tt8TqEjRJxp38bi4ELLh0cIuWaqSIAHuIdLNzYw5ojcrXvF1CQo/CF4CWOjgnrJyIIODJM+Hy1faC9LMpJT17palznigua6TdQRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=fZ6PWCz6 reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4d9fJ43nynz1DQs2;
	Tue, 18 Nov 2025 10:21:40 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4d9fJ36qpDz1DHWH;
	Tue, 18 Nov 2025 10:21:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1763457700;
	bh=onHjwDINwmfoLhPqJh9wE9PG6GD3/mlPECyMzfMSbN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fZ6PWCz6nmJGjdeNS4QuH/Uc4yjAVyiviYnXTPoXamtkcX1KuRg9UGw7z5nQs7Drb
	 cq34IScgqYn9hwVtfMalsuzD8KCG+43zFsg8nEc1YWAK5jqmBHYfUYbhknV087xena
	 Py9akGuYeLGERX+dXBNArp0y8kh7LzmtHqJS1e/FstCKyixCn2vuI0hDFDQpRAl1js
	 pA1kdWxkOv0gYB/llIaeCxBswuoGEL4hPHjWYvLW6UUI+uFLJ9cUKdRC13v3o5q7ul
	 H3dNySGAC3tsQpXndNOUGD+hpLFsIeVQ4Ta9K+1H3SfOum7JJM2ncetCs1oyzFOWfG
	 8ElOyCtW8ptrA==
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
Subject: [PATCH 10/10] can: grcan: Add CANFD support alongside legacy CAN
Date: Tue, 18 Nov 2025 10:21:15 +0100
Message-ID: <20251118092115.3455-11-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include CANFD support with the legacy CAN support, enabling
support for extended data payloads up to 64 bytes, higher bit rates,
handle canecho frames.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 240 ++++++++++++++++++++++++++++------------
 1 file changed, 167 insertions(+), 73 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 8753bff4f917..ff7ab979d2c9 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -44,6 +44,8 @@

 #define GRCAN_RESERVE_SIZE(slot1, slot2) (((slot2) - (slot1)) / 4 - 1)

+#define CHECK_SLOT_FDF(slot) ((slot) & GRCAN_RX_FDF)
+
 struct grcan_registers {
 	u32 conf;	/* 0x00 */
 	u32 stat;	/* 0x04 */
@@ -181,8 +183,11 @@ struct grcan_registers {
 			  | GRCAN_IRQ_TXAHBERR | GRCAN_IRQ_RXAHBERR	\
 			  | GRCAN_IRQ_TXLOSS)
 #define GRCAN_IRQ_DEFAULT (GRCAN_IRQ_RX | GRCAN_IRQ_TX | GRCAN_IRQ_ERRORS)
+#define GRCAN_CTRL_MODES (CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT)
+#define GRCAN_CTRL_MODES_FD (CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_FD)

 #define GRCAN_MSG_SIZE		16
+#define GRCAN_CLASSIC_DATA_SIZE 8

 #define GRCAN_MSG_IDE		0x80000000
 #define GRCAN_MSG_RTR		0x40000000
@@ -264,6 +269,12 @@ struct grcan_registers {
 #define GRCANFD_FDBTR_PS2_BIT 5
 #define GRCANFD_FDBTR_SJW_BIT 0

+#define GRCAN_TX_BRS  BIT(25)
+#define GRCAN_TX_FDF  BIT(26)
+
+#define GRCAN_RX_BRS  BIT(25)
+#define GRCAN_RX_FDF  BIT(26)
+
 /* Hardware capabilities */
 struct grcan_hwcap {
 	/* CAN-FD capable, indicates GRCANFD IP.
@@ -326,6 +337,13 @@ struct grcan_priv {

 	struct sk_buff **echo_skb;	/* We allocate this on our own */

+	/*
+	 * Since the CAN FD frame has a variable length, this variable is used
+	 * to keep track of the index of the CAN echo skb (socket buffer) frame.
+	 * It's important for ensuring that we correctly manage the echo skb.
+	 */
+	u32 echo_skb_idx;
+
 	/* The echo skb pointer, pointing into echo_skb and indicating which
 	 * frames can be echoed back. See the "Notes on the tx cyclic buffer
 	 * handling"-comment for grcan_start_xmit for more details.
@@ -637,7 +655,7 @@ static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
 	struct grcan_registers __iomem *regs = priv->regs;
 	struct grcan_dma *dma = &priv->dma;
 	struct net_device_stats *stats = &dev->stats;
-	int i, work_done;
+	int work_done;

 	/* Updates to priv->eskbp and wake-ups of the queue needs to
 	 * be atomic towards the reads of priv->eskbp and shut-downs
@@ -648,19 +666,22 @@ static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
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
+		/* Grab the packet once the  packet is send or free untransmitted packet*/
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
@@ -1174,6 +1195,7 @@ static int grcan_set_mode(struct net_device *dev, enum can_mode mode)
 			if (!(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
 				netif_wake_queue(dev);
 		}
+		priv->echo_skb_idx = 0;
 		spin_unlock_irqrestore(&priv->lock, flags);
 		return err;
 	}
@@ -1223,7 +1245,6 @@ static int grcan_open(struct net_device *dev)
 		netif_start_queue(dev);
 	priv->resetting = false;
 	priv->closing = false;
-
 	spin_unlock_irqrestore(&priv->lock, flags);

 	return 0;
@@ -1294,20 +1315,29 @@ static void grcan_transmit_catch_up(struct net_device *dev)
 	spin_unlock_irqrestore(&priv->lock, flags);
 }

+static int grcan_numbds(int len)
+{
+	if (len <= GRCAN_CLASSIC_DATA_SIZE)
+		return 1;
+	return 1 + ((len - GRCAN_CLASSIC_DATA_SIZE + GRCAN_MSG_SIZE) / GRCAN_MSG_SIZE);
+}
+
 static int grcan_receive(struct net_device *dev, int budget)
 {
 	struct grcan_priv *priv = netdev_priv(dev);
 	struct grcan_registers __iomem *regs = priv->regs;
 	struct grcan_dma *dma = &priv->dma;
 	struct net_device_stats *stats = &dev->stats;
-	struct can_frame *cf;
+	struct canfd_frame *cf;
 	struct sk_buff *skb;
-	u32 wr, rd, startrd;
+	u32 wr, rd, dlc, startrd;
 	u32 *slot;
 	u32 rtr, eff;
-	int work_done = 0;
+	u8 *data;
+	int i, bds, payload_offset, copy_len, work_done = 0;

 	rd = grcan_read_reg(&regs->rxrd);
+
 	startrd = rd;
 	for (work_done = 0; work_done < budget; work_done++) {
 		/* Check for packet to receive */
@@ -1315,44 +1345,70 @@ static int grcan_receive(struct net_device *dev, int budget)
 		if (rd == wr)
 			break;

-		/* Take care of packet */
-		skb = alloc_can_skb(dev, &cf);
-		if (skb == NULL) {
+		slot = dma->rx.buf + rd;
+
+		if (CHECK_SLOT_FDF(slot[1]))
+			skb = alloc_canfd_skb(dev, &cf);
+		else
+			skb = alloc_can_skb(priv->dev, (struct can_frame **)&cf);
+
+		if (unlikely(!skb)) {
 			netdev_err(dev,
 				   "dropping frame: skb allocation failed\n");
 			stats->rx_dropped++;
 			continue;
 		}

-		slot = dma->rx.buf + rd;
-		eff = slot[0] & GRCAN_MSG_IDE;
-		rtr = slot[0] & GRCAN_MSG_RTR;
-		if (eff) {
-			cf->can_id = ((slot[0] & GRCAN_MSG_EID)
-				      >> GRCAN_MSG_EID_BIT);
-			cf->can_id |= CAN_EFF_FLAG;
-		} else {
-			cf->can_id = ((slot[0] & GRCAN_MSG_BID)
-				      >> GRCAN_MSG_BID_BIT);
-		}
-		cf->len = can_cc_dlc2len((slot[1] & GRCAN_MSG_DLC)
-					  >> GRCAN_MSG_DLC_BIT);
-		if (rtr) {
-			cf->can_id |= CAN_RTR_FLAG;
-		} else {
-			if (cf->can_dlc > 0) {
-				*(u32 *)(cf->data) = slot[2];
-				if (cf->can_dlc > 4)
-					*(u32 *)(cf->data + 4) = slot[3];
+		dlc = (slot[1] & GRCAN_MSG_DLC) >> GRCAN_MSG_DLC_BIT;
+		if (CHECK_SLOT_FDF(slot[1]))
+			cf->len = can_fd_dlc2len(dlc);
+		else
+			cf->len = can_cc_dlc2len(dlc);
+
+		bds = grcan_numbds(cf->len);
+		payload_offset = 0;
+		data = cf->data;
+
+		for (i = 0; i < bds; i++) {
+			slot = dma->rx.buf + rd;
+
+			if (i == 0) {
+				eff = slot[0] & GRCAN_MSG_IDE;
+				rtr = slot[0] & GRCAN_MSG_RTR;
+				if (eff) {
+					cf->can_id = ((slot[0] & GRCAN_MSG_EID)
+						      >> GRCAN_MSG_EID_BIT);
+					cf->can_id |= CAN_EFF_FLAG;
+				} else {
+					cf->can_id = ((slot[0] & GRCAN_MSG_BID)
+						      >> GRCAN_MSG_BID_BIT);
+				}
+				if (rtr)
+					cf->can_id |= CAN_RTR_FLAG;
+
+				dlc = (slot[1] & GRCAN_MSG_DLC) >> GRCAN_MSG_DLC_BIT;
+				if (CHECK_SLOT_FDF(slot[1]))
+					cf->len = can_fd_dlc2len(dlc);
+				else
+					cf->len = can_cc_dlc2len(dlc);
+
+				copy_len = min(cf->len, GRCAN_CLASSIC_DATA_SIZE);
+				memcpy(data, &slot[2], copy_len);
+				payload_offset += copy_len;
+			} else {
+				copy_len =  min(cf->len - payload_offset, GRCAN_MSG_SIZE);
+				memcpy(data + payload_offset, slot, copy_len);
+				payload_offset += copy_len;
 			}
-
-			stats->rx_bytes += cf->len;
+			rd += GRCAN_MSG_SIZE;
+			if (rd >= dma->tx.size)
+				rd -= dma->tx.size;
 		}
-		stats->rx_packets++;

+		/* Update statistics and read pointer */
+		stats->rx_packets++;
+		stats->rx_bytes += cf->len;
 		netif_receive_skb(skb);
-
-		rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
 	}

 	/* Make sure everything is read before allowing hardware to
@@ -1479,12 +1535,15 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	struct grcan_priv *priv = netdev_priv(dev);
 	struct grcan_registers __iomem *regs = priv->regs;
 	struct grcan_dma *dma = &priv->dma;
-	struct can_frame *cf = (struct can_frame *)skb->data;
-	u32 id, txwr, txrd, space, txctrl;
-	int slotindex;
-	u32 *slot;
-	u32 rtr, eff, dlc, tmp, err;
+	struct can_frame *cf;
+	struct canfd_frame *cfd;
+	int i, bds, copy_len, payload_offset;
 	unsigned long flags;
+	u8 *payload;
+	u8 len;
+	u32 *slot;
+	u32 eff, rtr, dlc, tmp, err, can_id;
+	u32 id, txwr, txrd, space, txctrl;
 	u32 oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;

 	if (can_dev_dropped_skb(dev, skb))
@@ -1496,6 +1555,20 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		return NETDEV_TX_BUSY;

+	if (can_is_canfd_skb(skb)) {
+		cfd = (struct canfd_frame *)skb->data;
+		len = cfd->len;
+		dlc = can_fd_len2dlc(cfd->len);
+		can_id = cfd->can_id;
+		payload = cfd->data;
+	} else {
+		cf = (struct can_frame *)skb->data;
+		len = cf->len;
+		dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
+		can_id = cf->can_id;
+		payload = cf->data;
+	}
+
 	/* Reads of priv->eskbp and shut-downs of the queue needs to
 	 * be atomic towards the updates to priv->eskbp and wake-ups
 	 * of the queue in the interrupt handler.
@@ -1504,9 +1577,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,

 	txwr = grcan_read_reg(&regs->txwr);
 	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
-
-	slotindex = txwr / GRCAN_MSG_SIZE;
-	slot = dma->tx.buf + txwr;
+	bds = grcan_numbds(len);

 	if (unlikely(space == 1))
 		netif_stop_queue(dev);
@@ -1522,24 +1593,38 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_BUSY;
 	}

-	/* Convert and write CAN message to DMA buffer */
-	eff = cf->can_id & CAN_EFF_FLAG;
-	rtr = cf->can_id & CAN_RTR_FLAG;
-	id = cf->can_id & (eff ? CAN_EFF_MASK : CAN_SFF_MASK);
-	dlc = cf->len;
-	if (eff)
-		tmp = (id << GRCAN_MSG_EID_BIT) & GRCAN_MSG_EID;
-	else
-		tmp = (id << GRCAN_MSG_BID_BIT) & GRCAN_MSG_BID;
-	slot[0] = (eff ? GRCAN_MSG_IDE : 0) | (rtr ? GRCAN_MSG_RTR : 0) | tmp;
-
-	slot[1] = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
-	slot[2] = 0;
-	slot[3] = 0;
-	if (dlc > 0) {
-		slot[2] = *(u32 *)(cf->data); /* data aligned 64-bit */
-		if (dlc > 4)
-			slot[3] = *(u32 *)(cf->data + 4);
+	payload_offset = 0;
+	for (i = 0; i < bds; i++) {
+		slot = dma->tx.buf + txwr;
+		memset(slot, 0, GRCAN_MSG_SIZE);
+
+		if (i == 0) {
+			eff = can_id & CAN_EFF_FLAG;
+			rtr = can_id & CAN_RTR_FLAG;
+			id = can_id & (eff ? CAN_EFF_MASK : CAN_SFF_MASK);
+			if (eff)
+				tmp = (id << GRCAN_MSG_EID_BIT) & GRCAN_MSG_EID;
+			else
+				tmp = (id << GRCAN_MSG_BID_BIT) & GRCAN_MSG_BID;
+			slot[0] = (eff ? GRCAN_MSG_IDE : 0) | (rtr ? GRCAN_MSG_RTR : 0) | tmp;
+			slot[1] = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
+			if (can_is_canfd_skb(skb)) {
+				slot[1] |= GRCAN_TX_FDF;
+				if (cfd->flags & CANFD_BRS)
+					slot[1] |= GRCAN_TX_BRS;
+			}
+
+			copy_len = min(len, 8);
+			memcpy(&slot[2], payload, copy_len);
+			payload_offset += copy_len;
+		} else {
+			copy_len =  min(len - payload_offset, GRCAN_MSG_SIZE);
+			memcpy(slot, payload + payload_offset, copy_len);
+			payload_offset += copy_len;
+		}
+		txwr += GRCAN_MSG_SIZE;
+		if (txwr >= dma->tx.size)
+			txwr -= dma->tx.size;
 	}

 	/* Checking that channel has not been disabled. These cases
@@ -1574,7 +1659,14 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	 * can_put_echo_skb would be an error unless other measures are
 	 * taken.
 	 */
-	can_put_echo_skb(skb, dev, slotindex, 0);
+
+	can_put_echo_skb(skb, dev, priv->echo_skb_idx, 0);
+
+	/* Move to the next index in the echo skb buffer */
+	priv->echo_skb_idx = (priv->echo_skb_idx + 1) % priv->can.echo_skb_max;
+
+	if (priv->can.echo_skb[priv->echo_skb_idx])
+		netif_stop_queue(dev);

 	/* Make sure everything is written before allowing hardware to
 	 * read from the memory
@@ -1582,8 +1674,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	wmb();

 	/* Update write pointer to start transmission */
-	grcan_write_reg(&regs->txwr,
-			grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size));
+	grcan_write_reg(&regs->txwr, txwr);

 	return NETDEV_TX_OK;
 }
@@ -1734,12 +1825,15 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
 	priv->ofdev_dev = &ofdev->dev;
 	priv->regs = base;
 	priv->can.bittiming_const = hwcap->bt_const;
+	priv->can.fd.data_bittiming_const = hwcap->bt_const;
 	priv->can.do_set_bittiming = hwcap->set_bittiming;
 	priv->can.do_set_mode = grcan_set_mode;
 	priv->can.do_get_berr_counter = grcan_get_berr_counter;
 	priv->can.clock.freq = ambafreq;
-	priv->can.ctrlmode_supported =
-		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
+	if (hwcap->fd)
+		priv->can.ctrlmode_supported = GRCAN_CTRL_MODES_FD;
+	else
+		priv->can.ctrlmode_supported = GRCAN_CTRL_MODES;
 	priv->need_txbug_workaround = txbug;
 	priv->hwcap = hwcap;

--
2.51.0


