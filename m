Return-Path: <linux-can+bounces-6988-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN3lDDUCq2msZQEAu9opvQ
	(envelope-from <linux-can+bounces-6988-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 17:35:01 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 359E822508F
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 17:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B0FC30AB0E3
	for <lists+linux-can@lfdr.de>; Fri,  6 Mar 2026 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E364C421890;
	Fri,  6 Mar 2026 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="gU/KTf2A"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696BB3ED5A0;
	Fri,  6 Mar 2026 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814609; cv=none; b=R5xoBgdR0m89i2oIz1FHxKKRgAyKE2B9hQcHHAcy3WxfjWD+fp5Pt/HuMcf6DuVtbXdNifYRsYQsh7liAXG+9iDUrSXn8elZSkIYxFi2Q1Hu+XEYfyU7X27mzmQwMjbHXLU1o+zG/IjAqHm+QH/win7O2VNv2MxJlspEJzZwIEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814609; c=relaxed/simple;
	bh=Sqyrt/nDjXpX4UtO/J4ydRp8egTd0J6OjaYBQ9XVgAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmUZhLxRcgyMBpgT1iP6Xwrat1snqFjSCirT80OkXLn9Y9KLjfZkUalqq0dm7D6u1C8mphiDFnxO+J8aoyn0kzvC+JdJW4hti+D8uDqPa5jZ7faQNTdE8wwzm38cDLu4eoOF3cuBeHw9FyxlOS47IYjMqc4ggG81e66HGM972J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=gU/KTf2A reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fSBhC74r5z1Fljn;
	Fri,  6 Mar 2026 17:29:47 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fSBhC5CNCz1Fljf;
	Fri,  6 Mar 2026 17:29:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1772814587;
	bh=wG1Xz3PFJ5zaeS/mHFd20/KLBCZNWCnlzL13w0Ig5cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gU/KTf2AGfKoNu5aeQgEUerNRC/qGJNxGhYKI9sw4OJELOFi+u8uePKLPe7RV3237
	 ME172g17Vb/gB8/TuoDfKBYKfbdbs4dPsQ4Q68reJ/J1YPVgMUKq1pygctgCISeWPA
	 RIzpH6bICImoLBaGeX9YYOYPPXbguXsB7GbbgtXhT7GplLMMiDMb1fxNRIpIXy3STh
	 6HL6OX6xkt7T/4Bbm7JvwJsu/ldrphXwcPoKOdVOEGDr4Rm+biNh6p7mUjrpVOqFPA
	 qLuNTR4Db3b4KUQLTcGS6Ael+Fa9l+/YN3UIgIg6Xokp6hbPUnF4muWZGsntez2HOo
	 rfG/2XA54TlcQ==
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
Subject: [PATCH v6 13/15] can: grcan: Add CANFD RX support alongside legacy CAN
Date: Fri,  6 Mar 2026 17:29:32 +0100
Message-ID: <20260306162934.22955-14-arun.muthusamy@gaisler.com>
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
X-Rspamd-Queue-Id: 359E822508F
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
	TAGGED_FROM(0.00)[bounces-6988-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.880];
	DKIM_TRACE(0.00)[gaisler.com:~];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:mid,gaisler.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Include CANFD RX support with the legacy CAN support, enabling
support for extended data payloads to provide higher bit rates.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 72 +++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 25 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 94af34fbd1fd..514a065cab5f 100644
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
@@ -1251,17 +1254,21 @@ static int grcan_numbds(int len)
 
 static int grcan_receive(struct net_device *dev, int budget)
 {
+	struct net_device_stats *stats = &dev->stats;
 	struct grcan_priv *priv = netdev_priv(dev);
-	struct grcan_registers __iomem *regs = priv->regs;
+	struct grcan_registers __iomem *regs;
 	struct grcan_dma *dma = &priv->dma;
-	struct net_device_stats *stats = &dev->stats;
+	u32 bds, copy_len, payload_offset;
+	struct grcan_msg_fragment *frag;
 	struct grcan_msg_header *hdr;
-	struct can_frame *cf;
+	u32 wr, rd, dlc, startrd;
+	struct canfd_frame *cf;
+	int i, work_done = 0;
 	struct sk_buff *skb;
-	u32 wr, rd, startrd;
 	u32 rtr, eff;
-	int work_done = 0;
+	u8 *data;
 
+	regs = priv->regs;
 	rd = grcan_read_reg(&regs->rxrd);
 	startrd = rd;
 	for (work_done = 0; work_done < budget; work_done++) {
@@ -1270,47 +1277,62 @@ static int grcan_receive(struct net_device *dev, int budget)
 		if (rd == wr)
 			break;
 
-		/* Take care of packet */
-		skb = alloc_can_skb(dev, &cf);
-		if (skb == NULL) {
-			netdev_err(dev,
-				   "dropping frame: skb allocation failed\n");
+		hdr = grcan_msg_header_at(&dma->rx, rd);
+		if (hdr->ctrl & GRCAN_RX_FDF)
+			skb = alloc_canfd_skb(dev, &cf);
+		else
+			skb = alloc_can_skb(dev, (struct can_frame **)&cf);
+
+		if (unlikely(!skb)) {
+			netdev_err(dev, "dropping frame: skb allocation failed\n");
 			stats->rx_dropped++;
 			continue;
 		}
 
-		hdr = grcan_msg_header_at(&dma->rx, rd);
+		dlc = FIELD_GET(GRCAN_MSG_DLC_MASK, hdr->ctrl);
+		if (hdr->ctrl & GRCAN_RX_FDF)
+			cf->len = can_fd_dlc2len(dlc);
+		else
+			cf->len = can_cc_dlc2len(dlc);
+
+		bds = grcan_numbds(cf->len);
+		payload_offset = 0;
+		data = cf->data;
 
 		eff = hdr->id & GRCAN_MSG_IDE;
 		rtr = hdr->id & GRCAN_MSG_RTR;
 
 		if (eff) {
-			cf->can_id = ((hdr->id & GRCAN_MSG_EID)
-				      >> GRCAN_MSG_EID_BIT);
+			cf->can_id = FIELD_GET(GRCAN_MSG_EID_MASK, hdr->id);
 			cf->can_id |= CAN_EFF_FLAG;
 		} else {
-			cf->can_id = ((hdr->id & GRCAN_MSG_BID)
-				      >> GRCAN_MSG_BID_BIT);
+			cf->can_id = FIELD_GET(GRCAN_MSG_BID_MASK, hdr->id);
 		}
-
-		cf->len = can_cc_dlc2len((hdr->ctrl & GRCAN_MSG_DLC)
-					 >> GRCAN_MSG_DLC_BIT);
-
 		if (rtr) {
 			cf->can_id |= CAN_RTR_FLAG;
+			rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
 		} else {
-			if (cf->len > 0)
-				memcpy(cf->data, hdr->data,
-				       min_t(u32, cf->len, CAN_MAX_DLEN));
+			copy_len = min_t(u32, cf->len, CAN_MAX_DLEN);
+			memcpy(data, hdr->data, copy_len);
+			payload_offset += copy_len;
+
+			rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
 
+			for (i = 1; i < bds; i++) {
+				frag = grcan_msg_frag_at(&dma->rx, rd);
+
+				copy_len = min_t(u32, (u32)cf->len - payload_offset,
+						 (u32)GRCAN_MSG_SIZE);
+				memcpy(data + payload_offset, frag->data, copy_len);
+				payload_offset += copy_len;
+
+				rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
+			}
 			stats->rx_bytes += cf->len;
 		}
 
 		stats->rx_packets++;
-
 		netif_receive_skb(skb);
-
-		rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
 	}
 
 	/* Make sure everything is read before allowing hardware to
-- 
2.51.0


