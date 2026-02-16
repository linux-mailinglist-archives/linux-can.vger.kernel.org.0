Return-Path: <linux-can+bounces-6568-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKD7FEgik2kX1wEAu9opvQ
	(envelope-from <linux-can+bounces-6568-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 14:57:28 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C881444B6
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 14:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C74553053099
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DCC313537;
	Mon, 16 Feb 2026 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="ZXeMzk9x"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F43115AF;
	Mon, 16 Feb 2026 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250042; cv=none; b=Uu1rLWq9eLClwLoe5TpudjL2T9zdoKYRJDH0w6Wp2+WFYFJ7A4hKz+XaVyLRAi9VK3slNreMsq7VATv6s9Le/+LQu42MYiL+/sVT5SJ6kwqb9LGnW4+/VfO19INJeRvxQc2LH0fpQGAXwcvKCc2uE+qZDtx8zvtjdNHvDXBmwVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250042; c=relaxed/simple;
	bh=jRLYy6cpSbsB/zdM8fl7k/GXvW61206WfuUgIl0DkJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdXxlS8dhTJIrvk+RyTi6J8+BcCw/OFr+wOw3/F1/1sr8TLZ1/DAU+mDGTZvjvzYtLd43c39YUJmO/47JpGW4fdgsqn/Z1W3powdMurjULoRmWdGSKPSJjRvVl/tba+DVeXRxswt8lU76ykYrc8vsaLqsfWRKRibBWYc+4e+wSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=ZXeMzk9x reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fF44c0Y2xz1Fbwf;
	Mon, 16 Feb 2026 14:53:52 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fF44b5gxWz1FbwT;
	Mon, 16 Feb 2026 14:53:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1771250031;
	bh=3CEg7uF6i0KbM3OcGQ67hVqNfMc35wMZO2CX3hOxMQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZXeMzk9xT+UPmFV7irusn2SNF30LI2cYtOUz0FMV3RGYTtYp0XoeAAY7YeXPv4EpH
	 GFA5UAdKM1DJSpohrJJsGirej6CexB6/P5o+XL+mBD0h15i4lCjaak6XXU4qntLFnV
	 ST1iLHYRsZYAaHejs2stHoi6i0aBQ7Q74Ci2xPt7J3hLFrmlASb0Z87CfYLoTI9j4e
	 mYsow8s56yzUfPJcshbWcxEh5G6s1FjRKJkckaq0UCWcJ7fqghE5vpXRPr9dee51rf
	 7w2xlR5XPVbG1pKCEbNunhJXSl9vBbgsGqNrEq9XlNNUSTFGw8axh1AQRDIgVinLro
	 u1DGd2ZziEBcA==
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
Subject: [PATCH v5 12/16] can: grcan: Refactor GRCAN DMA buffer to use structured memory layout
Date: Mon, 16 Feb 2026 14:53:40 +0100
Message-ID: <20260216135344.23246-13-arun.muthusamy@gaisler.com>
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
	TAGGED_FROM(0.00)[bounces-6568-lists,linux-can=lfdr.de];
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
X-Rspamd-Queue-Id: B5C881444B6
X-Rspamd-Action: no action

 Introduce a structured layout that accurately represents the hardware memory by using struct grcan_msg_slot.
 This structure encapsulates the message parameters, including id, dlc, and data.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 3104946071dd..28fa219e1c3b 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -174,6 +174,7 @@ struct grcan_registers {
 #define GRCAN_IRQ_DEFAULT (GRCAN_IRQ_RX | GRCAN_IRQ_TX | GRCAN_IRQ_ERRORS)
 
 #define GRCAN_MSG_SIZE		16
+#define GRCAN_CLASSIC_DATA_SIZE 8
 
 #define GRCAN_MSG_IDE		0x80000000
 #define GRCAN_MSG_RTR		0x40000000
@@ -239,9 +240,23 @@ struct grcan_hwcap {
 	bool fd;
 };
 
+union grcan_msg_slot {
+	/*  First slot: header + 8 bytes payload */
+	struct {
+		u32 id;
+		u32 ctrl;
+		u8  data[GRCAN_CLASSIC_DATA_SIZE];
+	} __packed header;
+
+	/* Continuation slot: payload only */
+	struct {
+		u8 data[GRCAN_MSG_SIZE];
+	} __packed frags;
+} __packed;
+
 struct grcan_dma_buffer {
 	size_t size;
-	void *buf;
+	union grcan_msg_slot *msg_slot;
 	dma_addr_t handle;
 };
 
@@ -1019,8 +1034,8 @@ static int grcan_allocate_dma_buffers(struct net_device *dev,
 	small->handle = large->handle + lsize;
 	shift = large->handle - dma->base_handle;
 
-	large->buf = dma->base_buf + shift;
-	small->buf = large->buf + lsize;
+	large->msg_slot = (union grcan_msg_slot *)((u8 *)dma->base_buf + shift);
+	small->msg_slot = (union grcan_msg_slot *)((u8 *)large->msg_slot + lsize);
 
 	return 0;
 }
@@ -1237,7 +1252,7 @@ static int grcan_receive(struct net_device *dev, int budget)
 			continue;
 		}
 
-		slot = dma->rx.buf + rd;
+		slot = (u32 *)((u8 *)dma->rx.msg_slot + rd);
 		eff = slot[0] & GRCAN_MSG_IDE;
 		rtr = slot[0] & GRCAN_MSG_RTR;
 		if (eff) {
@@ -1418,7 +1433,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
 
 	slotindex = txwr / GRCAN_MSG_SIZE;
-	slot = dma->tx.buf + txwr;
+	slot = (u32 *)((u8 *)dma->tx.msg_slot + txwr);
 
 	if (unlikely(space == 1))
 		netif_stop_queue(dev);
-- 
2.51.0


