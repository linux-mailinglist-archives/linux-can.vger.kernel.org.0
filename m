Return-Path: <linux-can+bounces-5482-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E3AC6880B
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 10:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00D643599EC
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 09:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D38A31D723;
	Tue, 18 Nov 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="GiNlf4TR"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0DA314B6B;
	Tue, 18 Nov 2025 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457698; cv=none; b=BEmsZD/yrFoCTsh7mouPtHDd+ZyHn4rASqM1d3Cjmqw/4RN+SDeckzXbWJu5S+y8jWO48LgQZCh0F0AgM2LmXWoZt8GlxpT7i3EoNqLFeVsG4L/+/DNmFacXbfU0IF80HXsepui7NXyszLKD6vvKOKCKq5tu13tG4jI1cwkJ6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457698; c=relaxed/simple;
	bh=b7Zq0GOWaEmdeMJ9RtteCRyHH7sDdecofUJoMlLfKN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuD3KJHxgp8tnt71aUJvH9DA4Kej8u0fIsxaGrM3JHMxcD2aLOBP191ooOQmcWyVxEqaSfAD0TVaHmQx3cNVARNF+j5Wr8biYurliu1GfT9/t5/VZGUWBPwtIw60VyIDt6nAKuTaueEHB16kWYebJ2KhRC3JX1oOVB5ecg9RKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=GiNlf4TR reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4d9fHy32Blz1DDSP;
	Tue, 18 Nov 2025 10:21:34 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4d9fHx6qYsz1DHc4;
	Tue, 18 Nov 2025 10:21:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1763457694;
	bh=hK2CbkQEFxq+gefU1nAN+6Xp4sCe8yQEfMXpw3izA78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GiNlf4TRRQv7sWPgRm/OjrvptcCRAY5HRBIFAc+Brga+lp64+bIA2hc7/PeUtyyv+
	 2spqiRHVes0qEGn4vkm7oZ0K2BY0Fzag2/HZj3WF39BgjVPkNn/rmlcjwiNE+BiQAa
	 MlXM0JRzx4Rxvtu7HAcVKmZYG9InP4dXijgmAc9XC5n+Nl+e++QKxXlavJCKxp/nTk
	 Lvd8WpnT4tu5ZD/6lSrYhrJuRTCFdxdNtVTK6HaX8GME7g49p3ZgzbSIeHzBlaySg4
	 o7K4F+a0nuqL3Hz4XErqZxkQaoRibRA9zNTBn4gJW/WGCuCyeHNdemFxRdrOyCHnJ4
	 eQ7tchYyqB9TA==
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
Subject: [PATCH 06/10] can: grcan: optimize DMA by 32-bit accesses
Date: Tue, 18 Nov 2025 10:21:11 +0100
Message-ID: <20251118092115.3455-7-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Hellstrom <daniel@gaisler.com>

Optimizes DMA transfers in the GRCAN driver by reorganizing
data handling to use 32-bit accesses instead of individual
byte accesses.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 drivers/net/can/grcan.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index b9b0dd7d53f6..e367581faa57 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1287,7 +1287,7 @@ static int grcan_receive(struct net_device *dev, int budget)
 	struct sk_buff *skb;
 	u32 wr, rd, startrd;
 	u32 *slot;
-	u32 i, rtr, eff, j, shift;
+	u32 rtr, eff;
 	int work_done = 0;

 	rd = grcan_read_reg(&regs->rxrd);
@@ -1323,10 +1323,10 @@ static int grcan_receive(struct net_device *dev, int budget)
 		if (rtr) {
 			cf->can_id |= CAN_RTR_FLAG;
 		} else {
-			for (i = 0; i < cf->len; i++) {
-				j = GRCAN_MSG_DATA_SLOT_INDEX(i);
-				shift = GRCAN_MSG_DATA_SHIFT(i);
-				cf->data[i] = (u8)(slot[j] >> shift);
+			if (cf->can_dlc > 0) {
+				*(u32 *)(cf->data) = slot[2];
+				if (cf->can_dlc > 4)
+					*(u32 *)(cf->data + 4) = slot[3];
 			}

 			stats->rx_bytes += cf->len;
@@ -1466,8 +1466,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	u32 id, txwr, txrd, space, txctrl;
 	int slotindex;
 	u32 *slot;
-	u32 i, rtr, eff, dlc, tmp, err;
-	int j, shift;
+	u32 rtr, eff, dlc, tmp, err;
 	unsigned long flags;
 	u32 oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;

@@ -1520,10 +1519,10 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	slot[1] = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
 	slot[2] = 0;
 	slot[3] = 0;
-	for (i = 0; i < dlc; i++) {
-		j = GRCAN_MSG_DATA_SLOT_INDEX(i);
-		shift = GRCAN_MSG_DATA_SHIFT(i);
-		slot[j] |= cf->data[i] << shift;
+	if (dlc > 0) {
+		slot[2] = *(u32 *)(cf->data); /* data aligned 64-bit */
+		if (dlc > 4)
+			slot[3] = *(u32 *)(cf->data + 4);
 	}

 	/* Checking that channel has not been disabled. These cases
--
2.51.0


