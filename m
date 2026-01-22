Return-Path: <linux-can+bounces-6268-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEHrMBcbcmnrbwAAu9opvQ
	(envelope-from <linux-can+bounces-6268-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 13:41:59 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1529A66C4B
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 13:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4341F5EC26D
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 12:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D617241C2EA;
	Thu, 22 Jan 2026 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="N9pQKyt7"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5D42980B;
	Thu, 22 Jan 2026 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083863; cv=none; b=imKunIrSH6ml5zmpCnYgvwnV+cfhOOkwz/qtVDtxYqPPXdiSRKSDoKy2qj/fIjmTvUWonjDrkzRwaAGNNrkG6OkfcamI62Ij8OlZS7vwP/UCXm15gPjOGh1SLxsyfTR8U3KjB8WBy0DNCzvQI8tyZvUqE6o6eCNus2XlAC/Kh8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083863; c=relaxed/simple;
	bh=PPk0WF5n99PlZvu7ZVeG5vXsJf7I/nzmRYtNPqeY/+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUa4P5H7jj3TYJ/VU7n3F6sQmOzhM8lSY3mR6R3P5xVVTWksv0vhSyawFOZtNB7kXfS4EzZBzRo5Of7if4CpLkl5HCT5z0n0yM5irEr7zjRLTvTbzVEuOVDJwTGf6yf/uN35Y1x7iO8lteExbKm5B8o/a0+CUrX+Ok5wKgRWWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=N9pQKyt7 reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dxfzG50J3z1Fgd9;
	Thu, 22 Jan 2026 13:10:50 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dxfzG2XpPz1DDC3;
	Thu, 22 Jan 2026 13:10:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769083850;
	bh=cQecUzHZA3Ag9x7xgx5LRp21VuGFauFPBsaAtimBgwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N9pQKyt7wLTqxqges2RLYWUnpR2+5BG6NICOmjaBUjnKqatz+VMuj0REeDafSJJ5h
	 xPcqQapUPjmNtrHrmoSznjVBBhCTCpn8KtkYuHC2x8yDvUAqZwQ+eiBwQEazj9yuiO
	 5YqY1QS6GoyVnxInF0QolPQU0k7mewZs0pF7wXBhsStsD5VeseuOdm/kYcpoET/op8
	 qwfx8vq5xuKdSy7axBM0UO208hwnmGMTCmKh3ZKo2oauJrDnTxjfjGTNuDlzlmoZqs
	 T1Y4qva7jrs2IY+THg2W9dbUoHWQRf6SEDtTKruaNwVQQj7Xe7HAtxwjcWMS6dZK5j
	 BuDAvN3P+5K4w==
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
Subject: [PATCH v3 14/15] can: grcan: Add CANFD RX support alongside legacy CAN
Date: Thu, 22 Jan 2026 13:10:37 +0100
Message-ID: <20260122121038.7910-15-arun.muthusamy@gaisler.com>
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
	TAGGED_FROM(0.00)[bounces-6268-lists,linux-can=lfdr.de];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:mid,gaisler.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 1529A66C4B
X-Rspamd-Action: no action

Include CANFD RX support with the legacy CAN support, enabling
support for extended data payloads to provide higher bit rates.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 98 +++++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 33 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 508ad5320cff..39afb12c50d0 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -235,6 +235,9 @@ struct grcan_registers {
 #define GRCAN_TX_BRS  BIT(25)
 #define GRCAN_TX_FDF  BIT(26)
 
+#define GRCAN_RX_BRS  BIT(25)
+#define GRCAN_RX_FDF  BIT(26)
+
 /* Hardware capabilities */
 struct grcan_hwcap {
 	/* CAN-FD capable, indicates GRCANFD IP.
@@ -1235,18 +1238,22 @@ static int grcan_numbds(int len)
 
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
@@ -1254,43 +1261,68 @@ static int grcan_receive(struct net_device *dev, int budget)
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
+		dlc = FIELD_GET(GRCAN_MSG_DLC_MASK, slot[1]);
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
+					cf->can_id = FIELD_GET(GRCAN_MSG_EID_MASK, slot[0]);
+					cf->can_id |= CAN_EFF_FLAG;
+				} else {
+					cf->can_id = FIELD_GET(GRCAN_MSG_BID_MASK, slot[0]);
+				}
+				if (rtr)
+					cf->can_id |= CAN_RTR_FLAG;
+
+				dlc = FIELD_GET(GRCAN_MSG_DLC_MASK, slot[1]);
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
+			}
+			rd += GRCAN_MSG_SIZE;
+			if (rd >= dma->rx.size)
+				rd -= dma->rx.size;
 		}
-		cf->len = can_cc_dlc2len((slot[1] & GRCAN_MSG_DLC)
-					  >> GRCAN_MSG_DLC_BIT);
-		if (rtr) {
-			cf->can_id |= CAN_RTR_FLAG;
-		} else {
-			if (cf->can_dlc > 0)
-				memcpy(cf->data, &slot[2], sizeof(u32));
-			if (cf->can_dlc > 4)
-				memcpy(cf->data + 4, &slot[3], sizeof(u32));
 
-			stats->rx_bytes += cf->len;
-		}
+		/* Update statistics and read pointer */
 		stats->rx_packets++;
-
+		stats->rx_bytes += cf->len;
 		netif_receive_skb(skb);
-
-		rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
 	}
 
 	/* Make sure everything is read before allowing hardware to
-- 
2.51.0


