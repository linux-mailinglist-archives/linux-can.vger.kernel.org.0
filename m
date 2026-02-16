Return-Path: <linux-can+bounces-6571-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COEmDs4ik2kX1wEAu9opvQ
	(envelope-from <linux-can+bounces-6571-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 14:59:42 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 823BB144564
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 14:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53640306FCF0
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 13:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4FA315D5B;
	Mon, 16 Feb 2026 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="ZCE0MW1Y"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF31831328A;
	Mon, 16 Feb 2026 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250044; cv=none; b=mWrF91sepHqVMhfw8yPSae4yXXdoxVPeHTpgR2b1ldu/ydKU+DnWTthGOeV0t6ppKiONn6haqc4y6SE6BmCnz+zUIiOEenBMemvCy3viSvMqvcrSmDriSpPcRclCOAZjtx5sryu00aRnlRxtSvfLrLwB3iunI7oX0fl2FsBfQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250044; c=relaxed/simple;
	bh=eRo33dKNPrW1Rzcrh2RUObWmQwr19UJeHASiH+4hDB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsFlRILaAwKbOg1MbtYjuoO1E+2wTBloNnJJjMuUy84VUExc0ZBsIZ1CN04/JnfrwaH63rftQKDw3VvX7Lf1DznRI/BBRbfMLhyK2GC7fCCkZNI504o6wGGk7ybWojGJLIfVENc6stA6lXm0oEvLCmDX7GLxR8BFFybrfWObYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=ZCE0MW1Y reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fF44c2FQJz1Fbwc;
	Mon, 16 Feb 2026 14:53:52 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fF44c0MGgz1FbwZ;
	Mon, 16 Feb 2026 14:53:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1771250032;
	bh=mIj+Gfc6bwbkhoXJDGZOXj4xv50OW9cInGwc4zKvq4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZCE0MW1YY/QdD9K1RSzG/fUU4Y7SSj5pgdKbGjy9jDzdVblRKtVCcU5DLDincIYlc
	 evl0IenD1hCAE9Yx1GOAQXWWnmS5FEhyY+CMWiJ3HJ/AhsDab/Rsk3Te+dtFZiv3OC
	 kzgJQUlR/NjvDRwXEHNglVT7CXAsAfQm4D9AQoecJUrDzFYmTyKQ+6pqErC8vERMfy
	 G8mhKfH8ZGd2n7VW4ZSBdA9+ptp1Bl3mXrPQwlNpBe77H+C7P4yDODlwVwemFtYMTv
	 NkEQtxEXD8P8D8HwLpQsA91z8lkHFPf87n1fSIwtxbpai0HajfnNr52Ijf7k4ase62
	 mbT6oasln+TSQ==
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
Subject: [PATCH v5 13/16] can: grcan: Add CANFD TX support alongside legacy CAN
Date: Mon, 16 Feb 2026 14:53:41 +0100
Message-ID: <20260216135344.23246-14-arun.muthusamy@gaisler.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6571-lists,linux-can=lfdr.de];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gaisler.com:mid,gaisler.com:email]
X-Rspamd-Queue-Id: 823BB144564
X-Rspamd-Action: no action

Include CANFD TX support with the legacy CAN support, enabling
support for extended data payloads to provide higher bit rates.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 111 ++++++++++++++++++++++++++++++----------
 1 file changed, 85 insertions(+), 26 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 28fa219e1c3b..ae9f6fd4c8bf 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -196,6 +196,10 @@ struct grcan_registers {
 #define GRCAN_MSG_OFF		0x00000002
 #define GRCAN_MSG_PASS		0x00000001
 
+#define GRCAN_MSG_EID_MASK      GENMASK(28, 0)
+#define GRCAN_MSG_BID_MASK      GENMASK(28, 18)
+#define GRCAN_MSG_DLC_MASK      GENMASK(31, 28)
+
 #define GRCAN_BUFFER_ALIGNMENT		1024
 #define GRCAN_DEFAULT_BUFFER_SIZE	1024
 #define GRCAN_VALID_TR_SIZE_MASK	0x001fffc0
@@ -228,6 +232,9 @@ struct grcan_registers {
 #define GRCANFD_FDBTR_PS2_BIT 5
 #define GRCANFD_FDBTR_SJW_BIT 0
 
+#define GRCAN_TX_BRS  BIT(25)
+#define GRCAN_TX_FDF  BIT(26)
+
 /* Hardware capabilities */
 struct grcan_hwcap {
 	/* CAN-FD capable, indicates GRCANFD IP.
@@ -1222,6 +1229,19 @@ static void grcan_transmit_catch_up(struct net_device *dev)
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
+static int grcan_numbds(int len)
+{
+	if (len <= GRCAN_CLASSIC_DATA_SIZE)
+		return 1;
+
+	return 1 + DIV_ROUND_UP(len - GRCAN_CLASSIC_DATA_SIZE, GRCAN_MSG_SIZE);
+}
+
+static inline union grcan_msg_slot *grcan_tx_msg_slot(struct grcan_dma *dma, u32 off)
+{
+	return (union grcan_msg_slot *)((u8 *)dma->tx.msg_slot + off);
+}
+
 static int grcan_receive(struct net_device *dev, int budget)
 {
 	struct grcan_priv *priv = netdev_priv(dev);
@@ -1404,15 +1424,23 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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
+	union grcan_msg_slot *msg;
+	struct canfd_frame *cfd;
+	struct can_frame *cf;
 	unsigned long flags;
-	u32 oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
+	u32 oneshotmode;
+	int slotindex;
+	u8 *payload;
+	u8 len;
+	int i;
+
+	regs = priv->regs;
+	oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
 
 	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
@@ -1423,6 +1451,18 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		return NETDEV_TX_BUSY;
 
+	cfd = (struct canfd_frame *)skb->data;
+	len = cfd->len;
+	can_id  = cfd->can_id;
+	payload = cfd->data;
+
+	if (can_is_canfd_skb(skb)) {
+		dlc = can_fd_len2dlc(len);
+	} else {
+		cf = (struct can_frame *)skb->data;
+		dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
+	}
+
 	/* Reads of priv->eskbp and shut-downs of the queue needs to
 	 * be atomic towards the updates to priv->eskbp and wake-ups
 	 * of the queue in the interrupt handler.
@@ -1433,7 +1473,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
 
 	slotindex = txwr / GRCAN_MSG_SIZE;
-	slot = (u32 *)((u8 *)dma->tx.msg_slot + txwr);
+	bds = grcan_numbds(len);
 
 	if (unlikely(space == 1))
 		netif_stop_queue(dev);
@@ -1449,24 +1489,44 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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
+	msg = grcan_tx_msg_slot(dma, txwr);
+	memset(msg, 0, sizeof(*msg));
+
+	eff = can_id & CAN_EFF_FLAG;
+	rtr = can_id & CAN_RTR_FLAG;
+	id  = can_id & (eff ? CAN_EFF_MASK : CAN_SFF_MASK);
+
+	tmp = eff ? FIELD_PREP(GRCAN_MSG_EID_MASK, id)
+		  : FIELD_PREP(GRCAN_MSG_BID_MASK, id);
+
+	msg->header.id = (eff ? GRCAN_MSG_IDE : 0) |
+		      (rtr ? GRCAN_MSG_RTR : 0) |
+		      tmp;
 
-	slot[1] = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
-	slot[2] = 0;
-	slot[3] = 0;
-	if (dlc > 0)
-		memcpy(&slot[2], cf->data, sizeof(u32));
-	if (dlc > 4)
-		memcpy(&slot[3], cf->data + 4, sizeof(u32));
+	msg->header.ctrl = FIELD_PREP(GRCAN_MSG_DLC_MASK, dlc);
+
+	if (can_is_canfd_skb(skb)) {
+		msg->header.ctrl |= GRCAN_TX_FDF;
+		if (cfd->flags & CANFD_BRS)
+			msg->header.ctrl |= GRCAN_TX_BRS;
+	}
+
+	copy_len = min_t(u32, len, GRCAN_CLASSIC_DATA_SIZE);
+	memcpy(msg->header.data, payload, copy_len);
+	payload_offset = copy_len;
+
+	txwr = grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size);
+
+	for (i = 1; i < bds; i++) {
+		msg = grcan_tx_msg_slot(dma, txwr);
+
+		memset(msg, 0, sizeof(*msg));
+		copy_len = min_t(u32, (u32)len - payload_offset, (u32)GRCAN_MSG_SIZE);
+		memcpy(msg->frags.data, payload + payload_offset, copy_len);
+		payload_offset += copy_len;
+
+		txwr = grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size);
+	}
 
 	/* Checking that channel has not been disabled. These cases
 	 * should never happen
@@ -1508,8 +1568,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	wmb();
 
 	/* Update write pointer to start transmission */
-	grcan_write_reg(&regs->txwr,
-			grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size));
+	grcan_write_reg(&regs->txwr, txwr);
 
 	return NETDEV_TX_OK;
 }
-- 
2.51.0


