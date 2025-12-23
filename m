Return-Path: <linux-can+bounces-5918-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B95CD9064
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 12:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F5B9303F4EC
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 11:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C719033375D;
	Tue, 23 Dec 2025 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Y1A4HSA8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B133032B;
	Tue, 23 Dec 2025 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487405; cv=none; b=qMid6I7SQHQTTp+3p7XRLyaaDavjE7kR5/2We6vY3cvWaOJl/R3E26ZpoTgwD2jOSSmnpkhE4U8jVHvJ5LOAjFNXHqircWWEsmRF9ydGk6kdHukpcZjY7zZ/M0HxNaZsERAOcLHppcWoNEA/c5GI1liGIYQqke6QGWioOD469kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487405; c=relaxed/simple;
	bh=/eSD0fWDuJQDOKikETIUwaOMJrxCMmsDIJQUWMN4CwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qi+BvOG8GpMxJLNPfP0tkebiQOhn/8lbwe2kU39yhNs4ES2MJ3hS6zXD8569oCb3nOc8YseeOrvydKFcnRSmEz4TGkX3D9kYEfOZVx93V6KT7rOGatEUi+6UJpim5zUGrFh2OqpfmELDvJR6MP/jM/2k2L/MBVl7Vr/mvco7Pxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Y1A4HSA8 reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dbBlG01cwz1DDXN;
	Tue, 23 Dec 2025 11:56:26 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dbBlF5668z1DDXR;
	Tue, 23 Dec 2025 11:56:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1766487385;
	bh=W3B36A+Y/wmuxcjCq70rhgRHtHcHn7zkEw3a3S4BArU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y1A4HSA80CdyGQWY0N2jF8/x14hQTeZvygDvnJL2hPxvx4CKeJT3nzhC3J2MwbmBU
	 IizyyzSHZZgky1SZVQTIQWup27gjXdBJqtH5sVqUpJFW930HmuQa7Xzzo4bHGd+FAd
	 2rIB+p6n5MYSYrJNUzJtihFjeRYXt06H/ZKEb71zq0WrldOcdSmLsJbVjujW6hbM+S
	 ZWh60F5rFeO/xUiJylO+2uMUfrpE/FoFmwmP9oiKD1lNQiiPowcb6AIOBZ5Qc/lxXd
	 z4tcr8TMr+UjRy0CrUDul+EAj76qdX09BR7Rj/+mFwoaGh8gfrX/IdAeXkwh0a1Ix+
	 7mjBRNqThYp/w==
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
Subject: [PATCH v2 10/10] can: grcan: Add CANFD support alongside legacy CAN
Date: Tue, 23 Dec 2025 11:56:04 +0100
Message-ID: <20251223105604.12675-11-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
References: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
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
 drivers/net/can/grcan.c | 259 +++++++++++++++++++++++++++-------------
 1 file changed, 177 insertions(+), 82 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index bf1c503d575d..3d5b4c7e58bc 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -174,6 +174,7 @@ struct grcan_registers {
 #define GRCAN_IRQ_DEFAULT (GRCAN_IRQ_RX | GRCAN_IRQ_TX | GRCAN_IRQ_ERRORS)
 
 #define GRCAN_MSG_SIZE		16
+#define GRCAN_CLASSIC_DATA_SIZE 8
 
 #define GRCAN_MSG_IDE		0x80000000
 #define GRCAN_MSG_RTR		0x40000000
@@ -230,6 +231,12 @@ struct grcan_registers {
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
@@ -290,6 +297,13 @@ struct grcan_priv {
 
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
@@ -570,7 +584,7 @@ static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
 	struct grcan_registers __iomem *regs = priv->regs;
 	struct grcan_dma *dma = &priv->dma;
 	struct net_device_stats *stats = &dev->stats;
-	int i, work_done;
+	int work_done;
 
 	/* Updates to priv->eskbp and wake-ups of the queue needs to
 	 * be atomic towards the reads of priv->eskbp and shut-downs
@@ -581,19 +595,22 @@ static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
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
@@ -676,10 +693,8 @@ static void grcan_err(struct net_device *dev, u32 sources, u32 status)
 	    (status & GRCAN_STAT_ERRCTR_RELATED)) {
 		enum can_state state = priv->can.state;
 		enum can_state oldstate = state;
-		u32 txerr = (status & GRCAN_STAT_TXERRCNT)
-			>> GRCAN_STAT_TXERRCNT_BIT;
-		u32 rxerr = (status & GRCAN_STAT_RXERRCNT)
-			>> GRCAN_STAT_RXERRCNT_BIT;
+		u32 txerr = (status & GRCAN_STAT_TXERRCNT) >> GRCAN_STAT_TXERRCNT_BIT;
+		u32 rxerr = (status & GRCAN_STAT_RXERRCNT) >> GRCAN_STAT_RXERRCNT_BIT;
 
 		/* Figure out current state */
 		if (status & GRCAN_STAT_OFF) {
@@ -1101,6 +1116,7 @@ static int grcan_set_mode(struct net_device *dev, enum can_mode mode)
 			if (!(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
 				netif_wake_queue(dev);
 		}
+		priv->echo_skb_idx = 0;
 		spin_unlock_irqrestore(&priv->lock, flags);
 		return err;
 	}
@@ -1150,7 +1166,6 @@ static int grcan_open(struct net_device *dev)
 		netif_start_queue(dev);
 	priv->resetting = false;
 	priv->closing = false;
-
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -1221,20 +1236,31 @@ static void grcan_transmit_catch_up(struct net_device *dev)
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
+	struct net_device_stats *stats = &dev->stats;
 	struct grcan_priv *priv = netdev_priv(dev);
-	struct grcan_registers __iomem *regs = priv->regs;
+	struct grcan_registers __iomem *regs;
 	struct grcan_dma *dma = &priv->dma;
-	struct net_device_stats *stats = &dev->stats;
-	struct can_frame *cf;
+	u32 bds, copy_len, payload_offset;
+	u32 wr, rd, dlc, startrd;
+	struct canfd_frame *cf;
+	int i, work_done = 0;
 	struct sk_buff *skb;
-	u32 wr, rd, startrd;
-	u32 *slot;
 	u32 rtr, eff;
-	int work_done = 0;
+	u32 *slot;
+	u8 *data;
 
+	regs = priv->regs;
 	rd = grcan_read_reg(&regs->rxrd);
+
 	startrd = rd;
 	for (work_done = 0; work_done < budget; work_done++) {
 		/* Check for packet to receive */
@@ -1242,44 +1268,70 @@ static int grcan_receive(struct net_device *dev, int budget)
 		if (rd == wr)
 			break;
 
-		/* Take care of packet */
-		skb = alloc_can_skb(dev, &cf);
-		if (skb == NULL) {
+		slot = dma->rx.buf + rd;
+
+		if (slot[1] & GRCAN_RX_FDF)
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
-				memcpy(cf->data, &slot[2], sizeof(u32));
-				if (cf->can_dlc > 4)
-					memcpy(cf->data + 4, &slot[3], sizeof(u32));
+		dlc = (slot[1] & GRCAN_MSG_DLC) >> GRCAN_MSG_DLC_BIT;
+		if (slot[1] & GRCAN_RX_FDF)
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
+						>> GRCAN_MSG_EID_BIT);
+					cf->can_id |= CAN_EFF_FLAG;
+				} else {
+					cf->can_id = ((slot[0] & GRCAN_MSG_BID)
+						>> GRCAN_MSG_BID_BIT);
+				}
+				if (rtr)
+					cf->can_id |= CAN_RTR_FLAG;
+
+				dlc = (slot[1] & GRCAN_MSG_DLC) >> GRCAN_MSG_DLC_BIT;
+				if (slot[1] & GRCAN_RX_FDF)
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
@@ -1404,15 +1456,22 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
 	struct grcan_priv *priv = netdev_priv(dev);
-	struct grcan_registers __iomem *regs = priv->regs;
+	struct grcan_registers __iomem *regs;
+	u32 eff, rtr, dlc, tmp, err, can_id;
 	struct grcan_dma *dma = &priv->dma;
-	struct can_frame *cf = (struct can_frame *)skb->data;
+	u32 bds, copy_len, payload_offset;
 	u32 id, txwr, txrd, space, txctrl;
-	int slotindex;
-	u32 *slot;
-	u32 rtr, eff, dlc, tmp, err;
+	struct canfd_frame *cfd;
+	struct can_frame *cf;
 	unsigned long flags;
-	u32 oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
+	u32 oneshotmode;
+	u8 *payload;
+	u32 *slot;
+	u8 len;
+	int i;
+
+	regs = priv->regs;
+	oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
 
 	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
@@ -1423,6 +1482,20 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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
@@ -1431,9 +1504,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 
 	txwr = grcan_read_reg(&regs->txwr);
 	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
-
-	slotindex = txwr / GRCAN_MSG_SIZE;
-	slot = dma->tx.buf + txwr;
+	bds = grcan_numbds(len);
 
 	if (unlikely(space == 1))
 		netif_stop_queue(dev);
@@ -1449,25 +1520,38 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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
-		memcpy(&slot[2], cf->data, sizeof(u32));
-		slot[2] = *(u32 *)(cf->data);
-		if (dlc > 4)
-			memcpy(&slot[3], cf->data + 4, sizeof(u32));
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
@@ -1502,7 +1586,14 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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
@@ -1510,8 +1601,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	wmb();
 
 	/* Update write pointer to start transmission */
-	grcan_write_reg(&regs->txwr,
-			grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size));
+	grcan_write_reg(&regs->txwr, txwr);
 
 	return NETDEV_TX_OK;
 }
@@ -1662,11 +1752,16 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
 	priv->ofdev_dev = &ofdev->dev;
 	priv->regs = base;
 	priv->can.bittiming_const = hwcap->bt_const;
+	priv->can.fd.data_bittiming_const = hwcap->bt_const;
 	priv->can.do_set_mode = grcan_set_mode;
 	priv->can.do_get_berr_counter = grcan_get_berr_counter;
 	priv->can.clock.freq = ambafreq;
-	priv->can.ctrlmode_supported =
-		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
+	if (hwcap->fd)
+		priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_FD;
+	else
+		priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+			CAN_CTRLMODE_ONE_SHOT;
 	priv->need_txbug_workaround = txbug;
 	priv->hwcap = hwcap;
 
-- 
2.51.0


