Return-Path: <linux-can+bounces-6987-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNfgFiICq2nDZQEAu9opvQ
	(envelope-from <linux-can+bounces-6987-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 17:34:42 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC0D225067
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 17:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24D563001BD9
	for <lists+linux-can@lfdr.de>; Fri,  6 Mar 2026 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B224C41C0C1;
	Fri,  6 Mar 2026 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="kFmuM90c"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263033AA1A6;
	Fri,  6 Mar 2026 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814607; cv=none; b=nS/kxfd8Lhxq89tBeu/pqMSVjlP6txfUCuVX+hFzoFBAA5j6vAz2K9uxSwZICKJsJW7MX+DNvAQHg5x6zRPXyA3mzSDU0PTC3GkIS0x0nEm5b3CxVk1K6cMAiwz2JSKnibAy143g1L+XuEyJV5p2Y0mNRnDGB/emvEDmKMr3ukQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814607; c=relaxed/simple;
	bh=ec9Q8bC+SzrjWd9DEgqt0ENqCEnKlztjG2W/AgncgE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLNBJjuuozUlITy+y0s1fSGf7svGVgTxxlXTsqr7Ik8TlPgRt58m7OWruGQA2Jv3qUfWUZB+pF3tEdUdPf2a/8yqGycYdvAio1qtNM22oP0XwBGCLAdeV+Mm3t/QMjTIDSP6d6SssEpq6huh8xHplJ6snfKRoSrSmZeAgjyZ5/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=kFmuM90c reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fSBhC5XRzz1Fljl;
	Fri,  6 Mar 2026 17:29:47 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fSBhC3bwBz1DDgW;
	Fri,  6 Mar 2026 17:29:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1772814587;
	bh=+Dw6R2enjEsOg8oLAY+9D/rSw/CY/HhSy4Ay5c2tBbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kFmuM90c4CY6PbYWuNiD1xOlRiU6makX9YAQ+AKggwW3ogMBBQXKqfmNJ0urjuT3p
	 m+IbBZCNL/TSz8S4aOVl+XXJCBbwlePctbudgdnZzygW+4DjxqOd4MorWsbDxh8VfB
	 fXAYXjXDuZO359h8Hr9h6mhzSqKqt7tM/3lN2k/SoOwpPWwRKpKATfSvjrZM+K0YeJ
	 J0OQ7EUTOWFLTsbClEgoX4cueyEVuvmU+XC/jFFoXZ98Lp5aMrQikavq4XAjjHiHOB
	 SkKFbSic4Xu3kx1I2Z/wDJ0h6o1tBTvfRhaNf101swsEnCoitLtY8jZ3RE1Z2pLTTg
	 2D6I3lHOFo5QA==
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
Subject: [PATCH v6 12/15] can: grcan: Add CANFD TX support alongside legacy CAN
Date: Fri,  6 Mar 2026 17:29:31 +0100
Message-ID: <20260306162934.22955-13-arun.muthusamy@gaisler.com>
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
X-Rspamd-Queue-Id: 1BC0D225067
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6987-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.886];
	DKIM_TRACE(0.00)[gaisler.com:~];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:mid,gaisler.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Include CANFD TX support with the legacy CAN support, enabling
support for extended data payloads to provide higher bit rates.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 117 +++++++++++++++++++++++++++++-----------
 1 file changed, 87 insertions(+), 30 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 4c56861e21d7..94af34fbd1fd 100644
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
@@ -434,6 +442,12 @@ grcan_msg_header_at(struct grcan_dma_buffer *dbuf, u32 offset)
 	return (struct grcan_msg_header *)((u8 *)dbuf->buf + offset);
 }
 
+static inline struct grcan_msg_fragment *
+grcan_msg_frag_at(struct grcan_dma_buffer *dbuf, u32 offset)
+{
+	return (struct grcan_msg_fragment *)((u8 *)dbuf->buf + offset);
+}
+
 /* Configuration parameters that can be set via module parameters */
 static struct grcan_device_config grcan_module_config =
 	GRCAN_DEFAULT_DEVICE_CONFIG;
@@ -1227,6 +1241,14 @@ static void grcan_transmit_catch_up(struct net_device *dev)
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
 static int grcan_receive(struct net_device *dev, int budget)
 {
 	struct grcan_priv *priv = netdev_priv(dev);
@@ -1413,15 +1435,24 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
 	struct grcan_priv *priv = netdev_priv(dev);
-	struct grcan_registers __iomem *regs = priv->regs;
+	struct grcan_registers __iomem *regs;
+	u32 eff, rtr, dlc, tmp, err, can_id;
 	struct grcan_dma *dma = &priv->dma;
-	struct can_frame *cf = (struct can_frame *)skb->data;
-	struct grcan_msg_header *hdr;
+	u32 bds, copy_len, payload_offset;
 	u32 id, txwr, txrd, space, txctrl;
-	int slotindex;
-	u32 rtr, eff, dlc, tmp, err;
+	struct grcan_msg_fragment *frag;
+	struct grcan_msg_header *hdr;
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
@@ -1432,6 +1463,18 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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
@@ -1442,40 +1485,55 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
 
 	slotindex = txwr / GRCAN_MSG_SIZE;
+	bds = grcan_numbds(len);
 
-	if (unlikely(space == 1))
+	if (unlikely(space < bds)) {
 		netif_stop_queue(dev);
+		spin_unlock_irqrestore(&priv->lock, flags);
+		return NETDEV_TX_BUSY;
+	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 	/* End of critical section*/
 
-	/* This should never happen. If circular buffer is full, the
-	 * netif_stop_queue should have been stopped already.
-	 */
-	if (unlikely(!space)) {
-		netdev_err(dev, "No buffer space, but queue is non-stopped.\n");
-		return NETDEV_TX_BUSY;
-	}
-
 	hdr = grcan_msg_header_at(&dma->tx, txwr);
 	memset(hdr, 0, sizeof(*hdr));
 
-	/* Convert and write CAN message to DMA buffer */
-	eff = cf->can_id & CAN_EFF_FLAG;
-	rtr = cf->can_id & CAN_RTR_FLAG;
-	id = cf->can_id & (eff ? CAN_EFF_MASK : CAN_SFF_MASK);
-	dlc = cf->len;
-	if (eff)
-		tmp = (id << GRCAN_MSG_EID_BIT) & GRCAN_MSG_EID;
-	else
-		tmp = (id << GRCAN_MSG_BID_BIT) & GRCAN_MSG_BID;
+	eff = can_id & CAN_EFF_FLAG;
+	rtr = can_id & CAN_RTR_FLAG;
+	id  = can_id & (eff ? CAN_EFF_MASK : CAN_SFF_MASK);
+
+	tmp = eff ? FIELD_PREP(GRCAN_MSG_EID_MASK, id)
+		  : FIELD_PREP(GRCAN_MSG_BID_MASK, id);
+
+	hdr->id = (eff ? GRCAN_MSG_IDE : 0) |
+		  (rtr ? GRCAN_MSG_RTR : 0) |
+		  tmp;
 
-	hdr->id = (eff ? GRCAN_MSG_IDE : 0) | (rtr ? GRCAN_MSG_RTR : 0) | tmp;
+	hdr->ctrl = FIELD_PREP(GRCAN_MSG_DLC_MASK, dlc);
+
+	if (can_is_canfd_skb(skb)) {
+		hdr->ctrl |= GRCAN_TX_FDF;
+		if (cfd->flags & CANFD_BRS)
+			hdr->ctrl |= GRCAN_TX_BRS;
+	}
 
-	hdr->ctrl = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
+	copy_len = min_t(u32, len, CAN_MAX_DLEN);
+	memcpy(hdr->data, payload, copy_len);
+	payload_offset = copy_len;
 
-	if (dlc > 0)
-		memcpy(hdr->data, cf->data, min_t(u32, cf->len, CAN_MAX_DLEN));
+	txwr = grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size);
+
+	for (i = 1; i < bds; i++) {
+		frag = grcan_msg_frag_at(&dma->tx, txwr);
+
+		memset(frag, 0, sizeof(*frag));
+		copy_len = min_t(u32, (u32)len - payload_offset, (u32)GRCAN_MSG_SIZE);
+		memcpy(frag->data, payload + payload_offset, copy_len);
+		payload_offset += copy_len;
+
+		txwr = grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size);
+	}
 
 	/* Checking that channel has not been disabled. These cases
 	 * should never happen
@@ -1517,8 +1575,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	wmb();
 
 	/* Update write pointer to start transmission */
-	grcan_write_reg(&regs->txwr,
-			grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size));
+	grcan_write_reg(&regs->txwr, txwr);
 
 	return NETDEV_TX_OK;
 }
-- 
2.51.0


