Return-Path: <linux-can+bounces-6262-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDB2OUkdcmmPdQAAu9opvQ
	(envelope-from <linux-can+bounces-6262-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 13:51:21 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C107366DE9
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 13:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A31F960C669
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 12:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D2744A707;
	Thu, 22 Jan 2026 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="d3OSD8Tq"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC9E426EB4;
	Thu, 22 Jan 2026 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083861; cv=none; b=Vq9bt1Y6Ajjk2kRAcXw2jDwhqNOe8pBWtL2NqNH4ma0PTJ+aHVwDnEHflCdbrLsIoS9bm6E/6lldWh2MMTTdPD/W/ZQPzl1k1B3eS1XUjQaSRU+8W93wSvi0aRuUYsx7I4BC56xIDmPEshLNWoxmjNejKRS30ujoI9UbCPUHU/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083861; c=relaxed/simple;
	bh=r7bUfIsAYLSfpdmydyK3ggHQ+jGjEjFE1oj7Od7EfV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vc0Tj7Q5JQFzgPZRaMz4PnAp/wjlc7z9HUdrXuZKYc9y8oaj9Tg1Dg18TlRInf+98piOh3eA2O9iXaGhceuNkNqHDz2jh6sP2C/bCDqKjrS+3kDeodyXJxopD8NMH11Ua+jiQqU0kxnLTKEhwpFipknxuqM1i/DN8/VLthrkEDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=d3OSD8Tq reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dxfzD43b2z1FlXt;
	Thu, 22 Jan 2026 13:10:48 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dxfzC6yrmz1FgdJ;
	Thu, 22 Jan 2026 13:10:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769083848;
	bh=WNL2SDl32TrWWln0AQnf0KAmAYNyqjJmTlfmTjZRvt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d3OSD8TqbuBaVlW2uMrcFidr1T6O2ddGNKOyTro/EExYvbsKSK7ijV/PAFe3UTweH
	 KrlYCt/nHAVCdQswRoR5tDt6HS1XdzQMaMzNiz1mVz4KGksAhn1Ic8ha861PXvyGNf
	 hjJIEHE62BCBcvvXsWlMgzLgSKEsmTdr81qOYepIOZdBQ4zrqFytq0qwl+yb3Eg4ik
	 R2M7azaDrTwNkre/A5a36R0hZ+TtFvWNU/fbhxqp8AucNYNK2qOecZ3wsQp99huoLq
	 U6W6r1s62/1PjSP9TtXEJ09ySIb+Ar/4lDlxS9LuxX4hyHc0yA2ymBoH4PGRxYzoqn
	 ajV9B3c0sSF3A==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Daniel Hellstrom <daniel@gaisler.com>,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v3 08/15] can: grcan: optimize DMA by 32-bit accesses
Date: Thu, 22 Jan 2026 13:10:31 +0100
Message-ID: <20260122121038.7910-9-arun.muthusamy@gaisler.com>
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
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : No valid SPF,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6262-lists,linux-can=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,gaisler.com:mid,gaisler.com:email]
X-Rspamd-Queue-Id: C107366DE9
X-Rspamd-Action: no action

From: Daniel Hellstrom <daniel@gaisler.com>

Optimizes DMA transfers in the GRCAN driver by reorganizing
data handling to use 32-bit accesses instead of individual
byte accesses.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 5d09f61a153c..e2415529db45 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -194,9 +194,6 @@ struct grcan_registers {
 #define GRCAN_MSG_OFF		0x00000002
 #define GRCAN_MSG_PASS		0x00000001
 
-#define GRCAN_MSG_DATA_SLOT_INDEX(i) (2 + (i) / 4)
-#define GRCAN_MSG_DATA_SHIFT(i) ((3 - (i) % 4) * 8)
-
 #define GRCAN_BUFFER_ALIGNMENT		1024
 #define GRCAN_DEFAULT_BUFFER_SIZE	1024
 #define GRCAN_VALID_TR_SIZE_MASK	0x001fffc0
@@ -1218,7 +1215,7 @@ static int grcan_receive(struct net_device *dev, int budget)
 	struct sk_buff *skb;
 	u32 wr, rd, startrd;
 	u32 *slot;
-	u32 i, rtr, eff, j, shift;
+	u32 rtr, eff;
 	int work_done = 0;
 
 	rd = grcan_read_reg(&regs->rxrd);
@@ -1254,11 +1251,10 @@ static int grcan_receive(struct net_device *dev, int budget)
 		if (rtr) {
 			cf->can_id |= CAN_RTR_FLAG;
 		} else {
-			for (i = 0; i < cf->len; i++) {
-				j = GRCAN_MSG_DATA_SLOT_INDEX(i);
-				shift = GRCAN_MSG_DATA_SHIFT(i);
-				cf->data[i] = (u8)(slot[j] >> shift);
-			}
+			if (cf->can_dlc > 0)
+				memcpy(cf->data, &slot[2], sizeof(u32));
+			if (cf->can_dlc > 4)
+				memcpy(cf->data + 4, &slot[3], sizeof(u32));
 
 			stats->rx_bytes += cf->len;
 		}
@@ -1397,8 +1393,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	u32 id, txwr, txrd, space, txctrl;
 	int slotindex;
 	u32 *slot;
-	u32 i, rtr, eff, dlc, tmp, err;
-	int j, shift;
+	u32 rtr, eff, dlc, tmp, err;
 	unsigned long flags;
 	u32 oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
 
@@ -1451,11 +1446,10 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	slot[1] = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
 	slot[2] = 0;
 	slot[3] = 0;
-	for (i = 0; i < dlc; i++) {
-		j = GRCAN_MSG_DATA_SLOT_INDEX(i);
-		shift = GRCAN_MSG_DATA_SHIFT(i);
-		slot[j] |= cf->data[i] << shift;
-	}
+	if (dlc > 0)
+		memcpy(&slot[2], cf->data, sizeof(u32));
+	if (dlc > 4)
+		memcpy(&slot[3], cf->data + 4, sizeof(u32));
 
 	/* Checking that channel has not been disabled. These cases
 	 * should never happen
-- 
2.51.0


