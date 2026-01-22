Return-Path: <linux-can+bounces-6267-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJZRBewhcmmPdQAAu9opvQ
	(envelope-from <linux-can+bounces-6267-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 14:11:08 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B03A46716A
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 14:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB6C3708101
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE47844CF42;
	Thu, 22 Jan 2026 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="ovn6rWOr"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333943634A;
	Thu, 22 Jan 2026 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083863; cv=none; b=NZU3n4Kj9gqNMtggKXZry7nxPctShVSdBmYoXlAOXqrsG/+w1xS6HG0k+84a6y2PSHuKADdNXdQ0E93GnZ+/K3mq8e9Ti8r3CWZGyK2yBsNmSW7o/xzSYxkZDyb+gKzZobogdwjcLM1Sj6Ekkl53USsv+B3PmJY51Oe9it2OC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083863; c=relaxed/simple;
	bh=XhfqXG/GA5qfp1zS4RrMnh9Rpl6PePJ2REwVKnmb4Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0JPTDr1oWSc8Vyhw91GYRUPdltpmvfPKHhhCl3FILWBZpatcpQ1+nUCW3ezX7rOF+5v1hz9kkmTdwrIyIRHd2+YnBsNZGzXWv5d1WsKMUOb1oSJAMX5zp0e3eg0oZSZKoAMbdsjDXVyXkVtMThIAUR4qxVBn1nSuMqGo6N5Kks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=ovn6rWOr reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dxfzG2ty2z1FDXl;
	Thu, 22 Jan 2026 13:10:50 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dxfzG0kCXz1DHbf;
	Thu, 22 Jan 2026 13:10:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769083850;
	bh=eUp2qOvFQCwqoiY/xIcrHbhbjUDJgP1zcgG5WtjOJIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ovn6rWOrCI0S+/MUkCxLbgGIc1v8g6r6UCa5cbJf7LZIms7pqtFx379v3sj5Dl1gQ
	 qcQrxe3k4i1FSEagU5ytJp1zeS5V6VxKiktp5+M4b42cmBW0p+ffN5r3jl5HPl0AMc
	 FNYpX6car+ekQp+fbVnp6+Ax8YSRBdA7bOl4CsbMgv8Ti4YlDOUMVuN12xGfw6L0Va
	 x8OJkHwNpA3kNM0/Dq9VYMmndGSb5S95Fz5t114Gkc6VsfBwwinmcjFqfOFyJOEm4a
	 cU2wsIr0GdsVaWBlOBrgZrHz+aTY9da5DElntif2WPyoAMt9gfh9g/bhOzEWlzkI+H
	 SlHcpiZ1lXAWw==
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
Subject: [PATCH v3 13/15] can: grcan: Add CANFD TX support alongside legacy CAN
Date: Thu, 22 Jan 2026 13:10:36 +0100
Message-ID: <20260122121038.7910-14-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : No valid SPF,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6267-lists,linux-can=lfdr.de];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,gaisler.com:mid,gaisler.com:email]
X-Rspamd-Queue-Id: B03A46716A
X-Rspamd-Action: no action

Include CANFD TX support with the legacy CAN support, enabling
support for extended data payloads to provide higher bit rates.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 102 +++++++++++++++++++++++++++++-----------
 1 file changed, 74 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 9fc18064fab1..508ad5320cff 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -174,6 +174,7 @@ struct grcan_registers {
 #define GRCAN_IRQ_DEFAULT (GRCAN_IRQ_RX | GRCAN_IRQ_TX | GRCAN_IRQ_ERRORS)
 
 #define GRCAN_MSG_SIZE		16
+#define GRCAN_CLASSIC_DATA_SIZE 8
 
 #define GRCAN_MSG_IDE		0x80000000
 #define GRCAN_MSG_RTR		0x40000000
@@ -195,6 +196,10 @@ struct grcan_registers {
 #define GRCAN_MSG_OFF		0x00000002
 #define GRCAN_MSG_PASS		0x00000001
 
+#define GRCAN_MSG_EID_MASK      GENMASK(28, 0)
+#define GRCAN_MSG_BID_MASK      GENMASK(28, 18)
+#define GRCAN_MSG_DLC_MASK      GENMASK(31, 28)
+
 #define GRCAN_BUFFER_ALIGNMENT		1024
 #define GRCAN_DEFAULT_BUFFER_SIZE	1024
 #define GRCAN_VALID_TR_SIZE_MASK	0x001fffc0
@@ -227,6 +232,9 @@ struct grcan_registers {
 #define GRCANFD_FDBTR_PS2_BIT 5
 #define GRCANFD_FDBTR_SJW_BIT 0
 
+#define GRCAN_TX_BRS  BIT(25)
+#define GRCAN_TX_FDF  BIT(26)
+
 /* Hardware capabilities */
 struct grcan_hwcap {
 	/* CAN-FD capable, indicates GRCANFD IP.
@@ -1218,6 +1226,13 @@ static void grcan_transmit_catch_up(struct net_device *dev)
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
@@ -1400,15 +1415,22 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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
@@ -1419,6 +1441,18 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		return NETDEV_TX_BUSY;
 
+	cfd = (struct canfd_frame *)skb->data;
+	len     = cfd->len;
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
@@ -1427,9 +1461,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 
 	txwr = grcan_read_reg(&regs->txwr);
 	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
-
-	slotindex = txwr / GRCAN_MSG_SIZE;
-	slot = dma->tx.buf + txwr;
+	bds = grcan_numbds(len);
 
 	if (unlikely(space == 1))
 		netif_stop_queue(dev);
@@ -1445,24 +1477,39 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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
+				tmp = FIELD_PREP(GRCAN_MSG_EID_MASK, id);
+			else
+				tmp = FIELD_PREP(GRCAN_MSG_BID_MASK, id);
+			slot[0] = (eff ? GRCAN_MSG_IDE : 0) | (rtr ? GRCAN_MSG_RTR : 0) | tmp;
+			slot[1] = FIELD_PREP(GRCAN_MSG_DLC_MASK, dlc);
+			if (can_is_canfd_skb(skb)) {
+				slot[1] |= GRCAN_TX_FDF;
+				if (cfd->flags & CANFD_BRS)
+					slot[1] |= GRCAN_TX_BRS;
+			}
 
-	slot[1] = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
-	slot[2] = 0;
-	slot[3] = 0;
-	if (dlc > 0)
-		memcpy(&slot[2], cf->data, sizeof(u32));
-	if (dlc > 4)
-		memcpy(&slot[3], cf->data + 4, sizeof(u32));
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
+	}
 
 	/* Checking that channel has not been disabled. These cases
 	 * should never happen
@@ -1504,8 +1551,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	wmb();
 
 	/* Update write pointer to start transmission */
-	grcan_write_reg(&regs->txwr,
-			grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size));
+	grcan_write_reg(&regs->txwr, txwr);
 
 	return NETDEV_TX_OK;
 }
-- 
2.51.0


