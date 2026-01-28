Return-Path: <linux-can+bounces-6362-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDxOA3kkemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6362-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 16:00:09 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87096A36A2
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 16:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B29F130939D5
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422E5367F48;
	Wed, 28 Jan 2026 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="ShTdkZu7"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5165D364EB7;
	Wed, 28 Jan 2026 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611777; cv=none; b=Yx7oADtnFq/kO2wOT19JX3QjcJwX+LAzt5v+KK2HBNSqyOX9t121H8Em50eosWTISZXyA87sVgGo3JYHY6/XOmoF5BtbpApLIWdOSx1Wk7uACJwge64WuH+BXZ7GGK0FYT88MGl2RrBpq66LfiRfC0YC+g+hYROSrW8BnA5XS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611777; c=relaxed/simple;
	bh=F6mmkBeE4aOPMU0lOY0fasf1dzzHl5Jx4qKtzKvLMnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KurAY+1FhL/llfcycGmgtEC+0TrKk1LU7/ryGxMVjz2R3l3MOQ5qzC8RcPxLifr3UZhzXPBHSKC/Tv2f2oeeq6+Bo36LteunSSZs5yu/PyT3Nv1ghCn2pCb4EcZH7l4rg2PRmFsIlEzHwPVSY2HWnsiK+T/7gIFjngJQp2kZTGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=ShTdkZu7 reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f1QCb4w20z1FDXm;
	Wed, 28 Jan 2026 15:49:31 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4f1QCb2V1Hz1FQVR;
	Wed, 28 Jan 2026 15:49:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769611771;
	bh=5z1T/3tk6laeWF5sjShkZPMdQKbinFCwx3rclkgUEAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ShTdkZu752CuXsOk8RAdGchL4uO0WwUJxi47lzHrYkPYlXXZ4964sjELzjypIFK3B
	 P2mYvzi+HnHOQwtT69e3z3Gvo6mDGxz9lXJmqx1pI8ox3nndF6VhtzI7MUURQpH6oS
	 tGuEXLkLtWHUqADMdizeKlHI1BMnDk0TriWTbo75CVp4RRe/qG5wCW1xAa96LasSw5
	 lFGOKJVkOpo6HeO6YDID0HSoykNgwyeVXnxzA/dEto9X0Vb7yYkN9ihStIax1ozbRX
	 X53DJ9/yD7gpceJi64dCD985KFRjD/usD46iuAb5p44XeHR9o89JWGZqoL5ndg3Pls
	 J72nIj3x+lL2A==
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
Subject: [PATCH v4 13/15] can: grcan: Add CANFD RX support alongside legacy CAN
Date: Wed, 28 Jan 2026 15:49:19 +0100
Message-ID: <20260128144921.5458-14-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128144921.5458-1-arun.muthusamy@gaisler.com>
References: <20260128144921.5458-1-arun.muthusamy@gaisler.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6362-lists,linux-can=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.997];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gaisler.com:mid,gaisler.com:email]
X-Rspamd-Queue-Id: 87096A36A2
X-Rspamd-Action: no action

Include CANFD RX support with the legacy CAN support, enabling
support for extended data payloads to provide higher bit rates.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 98 +++++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 33 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index da0b5c129aae..d838fb0698f4 100644
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
@@ -1225,18 +1228,22 @@ static int grcan_numbds(int len)

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
@@ -1244,43 +1251,68 @@ static int grcan_receive(struct net_device *dev, int budget)
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


