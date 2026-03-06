Return-Path: <linux-can+bounces-6991-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNcEA0QDq2nDZQEAu9opvQ
	(envelope-from <linux-can+bounces-6991-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 17:39:32 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF4A225412
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 17:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62D5531A7AD0
	for <lists+linux-can@lfdr.de>; Fri,  6 Mar 2026 16:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B2E426D0E;
	Fri,  6 Mar 2026 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="akVFI84U"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8B93E95B0;
	Fri,  6 Mar 2026 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814614; cv=none; b=Nkvls5Oqdmw+8mqpCZ6A0bGKxYrnGDyQ9ZTB7Fvo5qvcSfVFYpbOwlqj+g0WQQ3beDasuaBPe5hEhdFKQ0zqr9QTbRKe6wRBqmfVPI/k9mGuxhZJDLL5cr2ll2hAtkrbQPwx//x071qP+l6Arh3dy/oOCKGzAjVen9E0uGTQcVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814614; c=relaxed/simple;
	bh=40O6WxzzWA+JBIi1GLuYIywzZsPzqJ13r/levFHuB84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HF6rdHZT5wYlZOFSRAv/V8FjPHXanXcFsImOdczoGKoXFW0bEZGUjvT/8bA8pupwK73SYwhnALZNhT3zLzuu/CY1yGMNuK5R1scmoPTFnD/GYNID3ua16vSIaepEAzNjNq5WP1oNW/l6e8H6rnRd4C5XB3IlU8IC8bAK1x5hTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=akVFI84U reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fSBhC3pS2z1Fg8H;
	Fri,  6 Mar 2026 17:29:47 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fSBhC25h2z1DDTQ;
	Fri,  6 Mar 2026 17:29:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1772814587;
	bh=GAJVvOQ/6Tk3aH1n5JHBwlQ4JF3J7rjYi4rRc0KzJtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=akVFI84UeIhSdlCSuXccvbDYMU5LQBmWdRyK5v3LjKGOxIRw3iiz505uRcCdor6Mw
	 dAjbCPk4TPCFRx2KlnWtRHVpaVZCbUl6nqUKMRJtuErVefX/6/RBylWAEoy0TU4N6b
	 smH3XIMFeEP4EpW9Prs6TC/2ekPpGmrLm/JjrETdh48bJouBowop3jHMEbSHM65rtm
	 lp5dIJQHhdZQoPifL5fp/ugTeZmzF0KcGe3j7y/WQFH8GHcUlbX6kUmLXNPOLDePGf
	 5GZWzcCYh7djf1aV0cWFbrBEtRa90BH1yHL3YI8I2D47DS1AITCc7OpZasE4ow1VPe
	 AkmDoaVSmTprw==
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
Subject: [PATCH v6 11/15] can: grcan: Refactor GRCAN DMA buffer to use structured memory layout
Date: Fri,  6 Mar 2026 17:29:30 +0100
Message-ID: <20260306162934.22955-12-arun.muthusamy@gaisler.com>
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
X-Rspamd-Queue-Id: 7BF4A225412
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6991-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.888];
	DKIM_TRACE(0.00)[gaisler.com:~];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gaisler.com:mid,gaisler.com:email]
X-Rspamd-Action: no action

- Introduce a structured layout to represent hardware memory using
struct grcan_msg_header and struct grcan_msg_fragment.
- Updated the GRCAN receive and transmit functions to utilize this new structured approach.
- Implemented helper functions grcan_msg_header_at for accessing header structures within DMA buffers.
- Replaced array and bitwise operations with memcpy for copying between CAN frames and header structures.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 80 +++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index b51b4235b1e7..4c56861e21d7 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -195,9 +195,6 @@ struct grcan_registers {
 #define GRCAN_MSG_OFF		0x00000002
 #define GRCAN_MSG_PASS		0x00000001
 
-#define GRCAN_MSG_DATA_SLOT_INDEX(i) (2 + (i) / 4)
-#define GRCAN_MSG_DATA_SHIFT(i) ((3 - (i) % 4) * 8)
-
 #define GRCAN_BUFFER_ALIGNMENT		1024
 #define GRCAN_DEFAULT_BUFFER_SIZE	1024
 #define GRCAN_VALID_TR_SIZE_MASK	0x001fffc0
@@ -242,9 +239,23 @@ struct grcan_hwcap {
 	bool fd;
 };
 
+struct grcan_msg_header {
+	u32 id;
+	u32 ctrl;
+	u8 data[CAN_MAX_DLEN];
+} __packed;
+
+struct grcan_msg_fragment {
+	u8 data[GRCAN_MSG_SIZE];
+} __packed;
+
 struct grcan_dma_buffer {
 	size_t size;
 	void *buf;
+	union {
+		struct grcan_msg_header *header;
+		struct grcan_msg_fragment *frag;
+	};
 	dma_addr_t handle;
 };
 
@@ -417,6 +428,12 @@ static inline u32 grcan_txspace(size_t txsize, u32 txwr, u32 eskbp)
 	return slots - used;
 }
 
+static inline struct grcan_msg_header *
+grcan_msg_header_at(struct grcan_dma_buffer *dbuf, u32 offset)
+{
+	return (struct grcan_msg_header *)((u8 *)dbuf->buf + offset);
+}
+
 /* Configuration parameters that can be set via module parameters */
 static struct grcan_device_config grcan_module_config =
 	GRCAN_DEFAULT_DEVICE_CONFIG;
@@ -1216,11 +1233,11 @@ static int grcan_receive(struct net_device *dev, int budget)
 	struct grcan_registers __iomem *regs = priv->regs;
 	struct grcan_dma *dma = &priv->dma;
 	struct net_device_stats *stats = &dev->stats;
+	struct grcan_msg_header *hdr;
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	u32 wr, rd, startrd;
-	u32 *slot;
-	u32 i, rtr, eff, j, shift;
+	u32 rtr, eff;
 	int work_done = 0;
 
 	rd = grcan_read_reg(&regs->rxrd);
@@ -1240,30 +1257,33 @@ static int grcan_receive(struct net_device *dev, int budget)
 			continue;
 		}
 
-		slot = dma->rx.buf + rd;
-		eff = slot[0] & GRCAN_MSG_IDE;
-		rtr = slot[0] & GRCAN_MSG_RTR;
+		hdr = grcan_msg_header_at(&dma->rx, rd);
+
+		eff = hdr->id & GRCAN_MSG_IDE;
+		rtr = hdr->id & GRCAN_MSG_RTR;
+
 		if (eff) {
-			cf->can_id = ((slot[0] & GRCAN_MSG_EID)
+			cf->can_id = ((hdr->id & GRCAN_MSG_EID)
 				      >> GRCAN_MSG_EID_BIT);
 			cf->can_id |= CAN_EFF_FLAG;
 		} else {
-			cf->can_id = ((slot[0] & GRCAN_MSG_BID)
+			cf->can_id = ((hdr->id & GRCAN_MSG_BID)
 				      >> GRCAN_MSG_BID_BIT);
 		}
-		cf->len = can_cc_dlc2len((slot[1] & GRCAN_MSG_DLC)
-					  >> GRCAN_MSG_DLC_BIT);
+
+		cf->len = can_cc_dlc2len((hdr->ctrl & GRCAN_MSG_DLC)
+					 >> GRCAN_MSG_DLC_BIT);
+
 		if (rtr) {
 			cf->can_id |= CAN_RTR_FLAG;
 		} else {
-			for (i = 0; i < cf->len; i++) {
-				j = GRCAN_MSG_DATA_SLOT_INDEX(i);
-				shift = GRCAN_MSG_DATA_SHIFT(i);
-				cf->data[i] = (u8)(slot[j] >> shift);
-			}
+			if (cf->len > 0)
+				memcpy(cf->data, hdr->data,
+				       min_t(u32, cf->len, CAN_MAX_DLEN));
 
 			stats->rx_bytes += cf->len;
 		}
+
 		stats->rx_packets++;
 
 		netif_receive_skb(skb);
@@ -1396,11 +1416,10 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	struct grcan_registers __iomem *regs = priv->regs;
 	struct grcan_dma *dma = &priv->dma;
 	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct grcan_msg_header *hdr;
 	u32 id, txwr, txrd, space, txctrl;
 	int slotindex;
-	u32 *slot;
-	u32 i, rtr, eff, dlc, tmp, err;
-	int j, shift;
+	u32 rtr, eff, dlc, tmp, err;
 	unsigned long flags;
 	u32 oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
 
@@ -1423,7 +1442,6 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
 
 	slotindex = txwr / GRCAN_MSG_SIZE;
-	slot = dma->tx.buf + txwr;
 
 	if (unlikely(space == 1))
 		netif_stop_queue(dev);
@@ -1439,6 +1457,9 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_BUSY;
 	}
 
+	hdr = grcan_msg_header_at(&dma->tx, txwr);
+	memset(hdr, 0, sizeof(*hdr));
+
 	/* Convert and write CAN message to DMA buffer */
 	eff = cf->can_id & CAN_EFF_FLAG;
 	rtr = cf->can_id & CAN_RTR_FLAG;
@@ -1448,16 +1469,13 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 		tmp = (id << GRCAN_MSG_EID_BIT) & GRCAN_MSG_EID;
 	else
 		tmp = (id << GRCAN_MSG_BID_BIT) & GRCAN_MSG_BID;
-	slot[0] = (eff ? GRCAN_MSG_IDE : 0) | (rtr ? GRCAN_MSG_RTR : 0) | tmp;
-
-	slot[1] = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
-	slot[2] = 0;
-	slot[3] = 0;
-	for (i = 0; i < dlc; i++) {
-		j = GRCAN_MSG_DATA_SLOT_INDEX(i);
-		shift = GRCAN_MSG_DATA_SHIFT(i);
-		slot[j] |= cf->data[i] << shift;
-	}
+
+	hdr->id = (eff ? GRCAN_MSG_IDE : 0) | (rtr ? GRCAN_MSG_RTR : 0) | tmp;
+
+	hdr->ctrl = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
+
+	if (dlc > 0)
+		memcpy(hdr->data, cf->data, min_t(u32, cf->len, CAN_MAX_DLEN));
 
 	/* Checking that channel has not been disabled. These cases
 	 * should never happen
-- 
2.51.0


