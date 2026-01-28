Return-Path: <linux-can+bounces-6354-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL4bMtoiemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6354-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:53:14 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C3CA344D
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 256D9300D0E7
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68043659EE;
	Wed, 28 Jan 2026 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Ik2if4DC"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F336402C;
	Wed, 28 Jan 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611774; cv=none; b=cnr1ZbGc7PuavuwG0WRYdbDCjidzDeKpyP/gsT2kkDo5pbzqHGkv7nxR3N6vLzuZjOZs4MXrvdkYPheX5+Cey7fX9DQqy6PcyU89SmNhLeLCMkioYnEeeLHhFXcNX1AI5yHAEr+xyc89oqB+44BtJhTfgR5JspntZ2hWtAz6c/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611774; c=relaxed/simple;
	bh=+Q2CBHQL6M1OJgngX5kKbP9z7TX9fOIWijblvbTL4iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJMfSoy6n8GbazFpZUHyJNPe+8/GVoLh5r0CmAdIA+q8caQ7nB9EKj3BgxKvW7XBZE4SWDN//HKbMdDOEoXCICAybu/1s0y4GFTUPqzkTQ2oc/UlpovPFQHG8OJ4rUXhUhuCrCAg3rLjn02rttal1fMEtbX6wx9TbD/p0OOKbeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Ik2if4DC reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f1QCY3QHTz1FDY1;
	Wed, 28 Jan 2026 15:49:29 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4f1QCY13Pxz1FDYD;
	Wed, 28 Jan 2026 15:49:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769611769;
	bh=n1jitg9yLGLEHU7Ikk+MP1rDLSfLfCDwECBLI2mLq7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ik2if4DCJ34OkBIrnC7BXV8fhYc0uKYlLocx3ALHEJidbZJjzM2Ege8R7pjYHcAR7
	 HKZE77pfOP3F/946XUqKNQbc2wOm5OXWrbBjz+XfVfl2PB46QH9xFgwKZ28gTD0tPD
	 ABMs9A8i6aaiieTr9oprpm3BXxS2DgZkLj3m/rNwuAR23FYTigTspJtlidjQ2xC51w
	 qSF+h8l1JWG3Wrh26YNCmUp/ORp21CbNhNmvCv2daeLcrYYhn8h7nA29jTBbhQx1TF
	 ep5MXPRX7sNfsmI5Ic3m5625nTCrD2Yo/+t3adNEiq40bSVrVqq8y+x2Cnr+9bmM0e
	 8Gabh/HJ7fd8A==
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
Subject: [PATCH v4 08/15] can: grcan: optimize DMA by 32-bit accesses
Date: Wed, 28 Jan 2026 15:49:14 +0100
Message-ID: <20260128144921.5458-9-arun.muthusamy@gaisler.com>
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
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6354-lists,linux-can=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gaisler.com:mid,gaisler.com:email]
X-Rspamd-Queue-Id: D5C3CA344D
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
index a752aea51d96..29247e9860c9 100644
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
@@ -1217,7 +1214,7 @@ static int grcan_receive(struct net_device *dev, int budget)
 	struct sk_buff *skb;
 	u32 wr, rd, startrd;
 	u32 *slot;
-	u32 i, rtr, eff, j, shift;
+	u32 rtr, eff;
 	int work_done = 0;

 	rd = grcan_read_reg(&regs->rxrd);
@@ -1253,11 +1250,10 @@ static int grcan_receive(struct net_device *dev, int budget)
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
@@ -1396,8 +1392,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	u32 id, txwr, txrd, space, txctrl;
 	int slotindex;
 	u32 *slot;
-	u32 i, rtr, eff, dlc, tmp, err;
-	int j, shift;
+	u32 rtr, eff, dlc, tmp, err;
 	unsigned long flags;
 	u32 oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;

@@ -1450,11 +1445,10 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
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


