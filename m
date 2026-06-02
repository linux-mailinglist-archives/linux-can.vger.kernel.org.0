Return-Path: <linux-can+bounces-7734-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9pfuOI5aH2rekwAAu9opvQ
	(envelope-from <linux-can+bounces-7734-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 00:34:54 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C97632797
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 00:34:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FgV5uv9H;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7734-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7734-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F227B30373F0
	for <lists+linux-can@lfdr.de>; Tue,  2 Jun 2026 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A9F3A05F2;
	Tue,  2 Jun 2026 22:34:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB11242925
	for <linux-can@vger.kernel.org>; Tue,  2 Jun 2026 22:34:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439691; cv=none; b=ETpXzUMhHDApev9MfZXz37Up2+N3lgHAtdV4w0B+pFiEn3Q0lsh8d/6dGpOFLgiaIw/2NDHTaDtaKp62FpsF0ZdsSzvC/8lCtjwczU4M1miBfa3O2zV6SzuLX3K78ovGNRemV5FGpHftJrg+l/T6Ck330bBxG4Ma7hNK674GPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439691; c=relaxed/simple;
	bh=ueA9H90jSB0H/m134T00B/UzUQ46sRwiwg7sPqWqLtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJuGxQoVSpN58ysBlZyqzWkAkme8qIave7n+lINI5lAKEvKkn9Ozu3ddZy5BxSiPbhckYvPTvK7edxRdqfgCe/fgWU8jRBe04iYlyQIFhlcq7snMT+KqF/BjCSIC78EEgPDJYAi8fm4ghHLnf5Lc/hO9jxArWNZhvHmXtWOv2NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgV5uv9H; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf125989f2so38795555ad.3
        for <linux-can@vger.kernel.org>; Tue, 02 Jun 2026 15:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780439689; x=1781044489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5hUju9imTXYzBOd81ezd87RiP58NYg2h8oodLJ1hs5E=;
        b=FgV5uv9H5cjGck4wSogSO3aTJJ2LYHvLmFhYUW0vMgogYjweDoS5zXX3ikbBg1Qb2u
         iJguUDzWFeBL7IHp2o9pPipKhP+l8BxW32OoP7SUcFPtBrk198g1IYhv37qq3L35oc/n
         Z3ycCva8QI2HhbO871ih36xOUVkc18TNQx73kYOdhA5Mv8SDltkAK6wA+G375Cijdn45
         halnlKqhuU1nPxScRccDeFE87RCF+G5bBtz66X6K00uOYp2Kz1DXPqhN/TPmMkbH2ZCk
         RpNmA1NPv70t1l7kfAt7qnNzoGuCWorHzgWlB2PLbxxWU1Uz17nNOARrXjZyvaBJNjcv
         dTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780439689; x=1781044489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hUju9imTXYzBOd81ezd87RiP58NYg2h8oodLJ1hs5E=;
        b=EYYNa24EKXE2u/hiVgiBkpyAXS+E95hq23EXWp2jLwXGMggXSh3a17p1Yh8/qe0n+L
         qPBMXMDFdFXPRo5seYaIcFPZNuelYZSu5w4GbKwJRAD7mSz60CjAg2TTe3QBh5iRma7y
         jGzavbrlYMPDGUwQONKbnS50Wm6Ae1w2X7SMmdaT4XDhFRFGbiOpMAG9uvx/xnUmEfAs
         NNfggo0OpikHmTtAm3m9Y6NjFrLr3NoTdDr2UsyrGQTxaobMJa2Sd/PLAPdr7Fx1S6jg
         oGMrdX+NjRHTsj24Qjl5tgH3wz6VnjrAT9GEp8eVjZUvO8bTnd3W+Mf1V0kVFZlxvttl
         Jzyw==
X-Gm-Message-State: AOJu0YyOLiNiMTOulTDub9Hyfrf42lvQafUP84vXf+BA8q0QQuZGQ5wQ
	Lmoj+Tzhet6V2bdKRWFqWTSdKJTplQMyIMmU7w7DtB6BqkEY83aCX8YWFl7/5A==
X-Gm-Gg: Acq92OH/osFTVTZ0sRZi0TbRbnw14+8eB4tz83QZGQx3Bbk+nTJLhqEf98yrNScnC6R
	UEQNk3XIKrNmsx6DnRBWlxbEb2e2hVk9L9fygEs6CJle90c5zDcW+30EFPKTNcdVFUjMRWndlB/
	jFArYY1IFnuJrAXrOkP98WivmgA4ymdm/35ImuJx2T8P9ZRJwwuf5EwgUn0vLgMUUcu1ynAsQrv
	MZFGRB5HbMEi1nV7bRnT7ZYZqBoqCSjIxW3OXtwKCEklnH3/JHqKDKsEjof02YG8CswHU4eENqr
	QuX+mm01vU4/HYY0Xnj09AypnWvbHpOo1Gh+7QFANwG38hPH/g7Ip366Sns91bxA3tqoM+gnYy8
	RULJtHAB+YlHRdTAU5IbP3vyLFrKxI7juScbkyS/2DOSMn4SnpJ7ZYZczYIL1ktvEP/Ka2+D60R
	xemuGusXUmZKP8JXEWvy9xgK5P6Nu1ff9t+SsFNBDSi2N+RZ8qkdhIiO8t3o9pkTaSPqgYhfgqg
	kEbW4Fz8dbc04bHDC866qNPHwhfgmGurA1d9cbGA9FD4Rl+kAnXXQza
X-Received: by 2002:a17:902:f60b:b0:2bd:9803:9308 with SMTP id d9443c01a7336-2c1644b827amr6258335ad.36.1780439689191;
        Tue, 02 Jun 2026 15:34:49 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad138sm2785095ad.82.2026.06.02.15.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:34:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	chleroy@kernel.org,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] can: mscan: replace in_8/out_8 with ioread8/iowrite8
Date: Tue,  2 Jun 2026 15:34:31 -0700
Message-ID: <20260602223431.17672-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-7734-lists,linux-can=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:chleroy@kernel.org,m:mailhol@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84C97632797

Mechanical conversion of the ppc4xx-specific in_8/out_8 accessors and
the setbits8/clrbits8 macros to the generic ioread8/iowrite8 helpers
for portability.

Add HAS_IOMEM as these functions need it.

Add COMPILE_TEST as a result. This can be built anywhere now.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/can/mscan/Kconfig |   3 +-
 drivers/net/can/mscan/mscan.c | 143 +++++++++++++++++-----------------
 2 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/drivers/net/can/mscan/Kconfig b/drivers/net/can/mscan/Kconfig
index dfe6bd9947bb..ef3a99b3d3db 100644
--- a/drivers/net/can/mscan/Kconfig
+++ b/drivers/net/can/mscan/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config CAN_MSCAN
-	depends on PPC
+	depends on PPC || COMPILE_TEST
+	depends on HAS_IOMEM
 	tristate "Support for Freescale MSCAN based chips"
 	help
 	  The Motorola Scalable Controller Area Network (MSCAN) definition
diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 39c7aa2a0b2f..9038e2f1cc9d 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -52,16 +52,16 @@ static int mscan_set_mode(struct net_device *dev, u8 mode)
 	if (mode != MSCAN_NORMAL_MODE) {
 		if (priv->tx_active) {
 			/* Abort transfers before going to sleep */#
-			out_8(&regs->cantarq, priv->tx_active);
+			iowrite8(priv->tx_active, &regs->cantarq);
 			/* Suppress TX done interrupts */
-			out_8(&regs->cantier, 0);
+			iowrite8(0, &regs->cantier);
 		}
 
-		canctl1 = in_8(&regs->canctl1);
+		canctl1 = ioread8(&regs->canctl1);
 		if ((mode & MSCAN_SLPRQ) && !(canctl1 & MSCAN_SLPAK)) {
-			setbits8(&regs->canctl0, MSCAN_SLPRQ);
+			iowrite8(ioread8(&regs->canctl0) | (MSCAN_SLPRQ), &regs->canctl0);
 			for (i = 0; i < MSCAN_SET_MODE_RETRIES; i++) {
-				if (in_8(&regs->canctl1) & MSCAN_SLPAK)
+				if (ioread8(&regs->canctl1) & MSCAN_SLPAK)
 					break;
 				udelay(100);
 			}
@@ -85,9 +85,9 @@ static int mscan_set_mode(struct net_device *dev, u8 mode)
 		}
 
 		if ((mode & MSCAN_INITRQ) && !(canctl1 & MSCAN_INITAK)) {
-			setbits8(&regs->canctl0, MSCAN_INITRQ);
+			iowrite8(ioread8(&regs->canctl0) | (MSCAN_INITRQ), &regs->canctl0);
 			for (i = 0; i < MSCAN_SET_MODE_RETRIES; i++) {
-				if (in_8(&regs->canctl1) & MSCAN_INITAK)
+				if (ioread8(&regs->canctl1) & MSCAN_INITAK)
 					break;
 			}
 			if (i >= MSCAN_SET_MODE_RETRIES)
@@ -97,14 +97,14 @@ static int mscan_set_mode(struct net_device *dev, u8 mode)
 			priv->can.state = CAN_STATE_STOPPED;
 
 		if (mode & MSCAN_CSWAI)
-			setbits8(&regs->canctl0, MSCAN_CSWAI);
+			iowrite8(ioread8(&regs->canctl0) | (MSCAN_CSWAI), &regs->canctl0);
 
 	} else {
-		canctl1 = in_8(&regs->canctl1);
+		canctl1 = ioread8(&regs->canctl1);
 		if (canctl1 & (MSCAN_SLPAK | MSCAN_INITAK)) {
-			clrbits8(&regs->canctl0, MSCAN_SLPRQ | MSCAN_INITRQ);
+			iowrite8(ioread8(&regs->canctl0) & ~(MSCAN_SLPRQ | MSCAN_INITRQ), &regs->canctl0);
 			for (i = 0; i < MSCAN_SET_MODE_RETRIES; i++) {
-				canctl1 = in_8(&regs->canctl1);
+				canctl1 = ioread8(&regs->canctl1);
 				if (!(canctl1 & (MSCAN_INITAK | MSCAN_SLPAK)))
 					break;
 			}
@@ -124,7 +124,7 @@ static int mscan_start(struct net_device *dev)
 	u8 canrflg;
 	int err;
 
-	out_8(&regs->canrier, 0);
+	iowrite8(0, &regs->canrier);
 
 	INIT_LIST_HEAD(&priv->tx_head);
 	priv->prev_buf_id = 0;
@@ -135,22 +135,22 @@ static int mscan_start(struct net_device *dev)
 
 	if (priv->type == MSCAN_TYPE_MPC5121) {
 		/* Clear pending bus-off condition */
-		if (in_8(&regs->canmisc) & MSCAN_BOHOLD)
-			out_8(&regs->canmisc, MSCAN_BOHOLD);
+		if (ioread8(&regs->canmisc) & MSCAN_BOHOLD)
+			iowrite8(MSCAN_BOHOLD, &regs->canmisc);
 	}
 
 	err = mscan_set_mode(dev, MSCAN_NORMAL_MODE);
 	if (err)
 		return err;
 
-	canrflg = in_8(&regs->canrflg);
+	canrflg = ioread8(&regs->canrflg);
 	priv->shadow_statflg = canrflg & MSCAN_STAT_MSK;
 	priv->can.state = state_map[max(MSCAN_STATE_RX(canrflg),
 				    MSCAN_STATE_TX(canrflg))];
-	out_8(&regs->cantier, 0);
+	iowrite8(0, &regs->cantier);
 
 	/* Enable receive interrupts. */
-	out_8(&regs->canrier, MSCAN_RX_INTS_ENABLE);
+	iowrite8(MSCAN_RX_INTS_ENABLE, &regs->canrier);
 
 	return 0;
 }
@@ -163,11 +163,11 @@ static int mscan_restart(struct net_device *dev)
 		struct mscan_regs __iomem *regs = priv->reg_base;
 
 		priv->can.state = CAN_STATE_ERROR_ACTIVE;
-		WARN(!(in_8(&regs->canmisc) & MSCAN_BOHOLD),
+		WARN(!(ioread8(&regs->canmisc) & MSCAN_BOHOLD),
 		     "bus-off state expected\n");
-		out_8(&regs->canmisc, MSCAN_BOHOLD);
+		iowrite8(MSCAN_BOHOLD, &regs->canmisc);
 		/* Re-enable receive interrupts. */
-		out_8(&regs->canrier, MSCAN_RX_INTS_ENABLE);
+		iowrite8(MSCAN_RX_INTS_ENABLE, &regs->canrier);
 	} else {
 		if (priv->can.state <= CAN_STATE_BUS_OFF)
 			mscan_set_mode(dev, MSCAN_INIT_MODE);
@@ -188,7 +188,7 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
-	out_8(&regs->cantier, 0);
+	iowrite8(0, &regs->cantier);
 
 	i = ~priv->tx_active & MSCAN_TXE;
 	buf_id = ffs(i) - 1;
@@ -216,7 +216,7 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		break;
 	}
 	priv->prev_buf_id = buf_id;
-	out_8(&regs->cantbsel, i);
+	iowrite8(i, &regs->cantbsel);
 
 	rtr = frame->can_id & CAN_RTR_FLAG;
 
@@ -226,7 +226,7 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			 << (MSCAN_EFF_RTR_SHIFT + 1);
 		if (rtr)
 			can_id |= 1 << MSCAN_EFF_RTR_SHIFT;
-		out_be16(&regs->tx.idr3_2, can_id);
+		iowrite16be(can_id, &regs->tx.idr3_2);
 
 		can_id >>= 16;
 		/* EFF_FLAGS are between the IDs :( */
@@ -238,26 +238,26 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (rtr)
 			can_id |= 1 << MSCAN_SFF_RTR_SHIFT;
 	}
-	out_be16(&regs->tx.idr1_0, can_id);
+	iowrite16be(can_id, &regs->tx.idr1_0);
 
 	if (!rtr) {
 		void __iomem *data = &regs->tx.dsr1_0;
 		u16 *payload = (u16 *)frame->data;
 
 		for (i = 0; i < frame->len / 2; i++) {
-			out_be16(data, *payload++);
+			iowrite16be(*payload++, data);
 			data += 2 + _MSCAN_RESERVED_DSR_SIZE;
 		}
 		/* write remaining byte if necessary */
 		if (frame->len & 1)
-			out_8(data, frame->data[frame->len - 1]);
+			iowrite8(frame->data[frame->len - 1], data);
 	}
 
-	out_8(&regs->tx.dlr, frame->len);
-	out_8(&regs->tx.tbpr, priv->cur_pri);
+	iowrite8(frame->len, &regs->tx.dlr);
+	iowrite8(priv->cur_pri, &regs->tx.tbpr);
 
 	/* Start transmission. */
-	out_8(&regs->cantflg, 1 << buf_id);
+	iowrite8(1 << buf_id, &regs->cantflg);
 
 	if (!test_bit(F_TX_PROGRESS, &priv->flags))
 		netif_trans_update(dev);
@@ -268,7 +268,7 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* Enable interrupt. */
 	priv->tx_active |= 1 << buf_id;
-	out_8(&regs->cantier, priv->tx_active);
+	iowrite8(priv->tx_active, &regs->cantier);
 
 	return NETDEV_TX_OK;
 }
@@ -291,10 +291,10 @@ static void mscan_get_rx_frame(struct net_device *dev, struct can_frame *frame)
 	u32 can_id;
 	int i;
 
-	can_id = in_be16(&regs->rx.idr1_0);
+	can_id = ioread16be(&regs->rx.idr1_0);
 	if (can_id & (1 << 3)) {
 		frame->can_id = CAN_EFF_FLAG;
-		can_id = ((can_id << 16) | in_be16(&regs->rx.idr3_2));
+		can_id = ((can_id << 16) | ioread16be(&regs->rx.idr3_2));
 		can_id = ((can_id & 0xffe00000) |
 			  ((can_id & 0x7ffff) << 2)) >> 2;
 	} else {
@@ -306,22 +306,22 @@ static void mscan_get_rx_frame(struct net_device *dev, struct can_frame *frame)
 	if (can_id & 1)
 		frame->can_id |= CAN_RTR_FLAG;
 
-	frame->len = can_cc_dlc2len(in_8(&regs->rx.dlr) & 0xf);
+	frame->len = can_cc_dlc2len(ioread8(&regs->rx.dlr) & 0xf);
 
 	if (!(frame->can_id & CAN_RTR_FLAG)) {
 		void __iomem *data = &regs->rx.dsr1_0;
 		u16 *payload = (u16 *)frame->data;
 
 		for (i = 0; i < frame->len / 2; i++) {
-			*payload++ = in_be16(data);
+			*payload++ = ioread16be(data);
 			data += 2 + _MSCAN_RESERVED_DSR_SIZE;
 		}
 		/* read remaining byte if necessary */
 		if (frame->len & 1)
-			frame->data[frame->len - 1] = in_8(data);
+			frame->data[frame->len - 1] = ioread8(data);
 	}
 
-	out_8(&regs->canrflg, MSCAN_RXF);
+	iowrite8(MSCAN_RXF, &regs->canrflg);
 }
 
 static void mscan_get_err_frame(struct net_device *dev, struct can_frame *frame,
@@ -357,17 +357,16 @@ static void mscan_get_err_frame(struct net_device *dev, struct can_frame *frame,
 			 * a light-weight stop (we are in irq-context).
 			 */
 			if (priv->type != MSCAN_TYPE_MPC5121) {
-				out_8(&regs->cantier, 0);
-				out_8(&regs->canrier, 0);
-				setbits8(&regs->canctl0,
-					 MSCAN_SLPRQ | MSCAN_INITRQ);
+				iowrite8(0, &regs->cantier);
+				iowrite8(0, &regs->canrier);
+			iowrite8(ioread8(&regs->canctl0) | (MSCAN_SLPRQ | MSCAN_INITRQ), &regs->canctl0);
 			}
 			can_bus_off(dev);
 		}
 	}
 	priv->shadow_statflg = canrflg & MSCAN_STAT_MSK;
 	frame->len = CAN_ERR_DLC;
-	out_8(&regs->canrflg, MSCAN_ERR_IF);
+	iowrite8(MSCAN_ERR_IF, &regs->canrflg);
 }
 
 static int mscan_rx_poll(struct napi_struct *napi, int quota)
@@ -382,7 +381,7 @@ static int mscan_rx_poll(struct napi_struct *napi, int quota)
 	u8 canrflg;
 
 	while (work_done < quota) {
-		canrflg = in_8(&regs->canrflg);
+		canrflg = ioread8(&regs->canrflg);
 		if (!(canrflg & (MSCAN_RXF | MSCAN_ERR_IF)))
 			break;
 
@@ -391,7 +390,7 @@ static int mscan_rx_poll(struct napi_struct *napi, int quota)
 			if (printk_ratelimit())
 				netdev_notice(dev, "packet dropped\n");
 			stats->rx_dropped++;
-			out_8(&regs->canrflg, canrflg);
+			iowrite8(canrflg, &regs->canrflg);
 			continue;
 		}
 
@@ -412,7 +411,7 @@ static int mscan_rx_poll(struct napi_struct *napi, int quota)
 		if (likely(napi_complete_done(&priv->napi, work_done))) {
 			clear_bit(F_RX_PROGRESS, &priv->flags);
 			if (priv->can.state < CAN_STATE_BUS_OFF)
-				out_8(&regs->canrier, priv->shadow_canrier);
+				iowrite8(priv->shadow_canrier, &regs->canrier);
 		}
 	}
 	return work_done;
@@ -427,8 +426,8 @@ static irqreturn_t mscan_isr(int irq, void *dev_id)
 	u8 cantier, cantflg, canrflg;
 	irqreturn_t ret = IRQ_NONE;
 
-	cantier = in_8(&regs->cantier) & MSCAN_TXE;
-	cantflg = in_8(&regs->cantflg) & cantier;
+	cantier = ioread8(&regs->cantier) & MSCAN_TXE;
+	cantflg = ioread8(&regs->cantflg) & cantier;
 
 	if (cantier && cantflg) {
 		struct list_head *tmp, *pos;
@@ -441,7 +440,7 @@ static irqreturn_t mscan_isr(int irq, void *dev_id)
 			if (!(cantflg & mask))
 				continue;
 
-			out_8(&regs->cantbsel, mask);
+			iowrite8(mask, &regs->cantbsel);
 			stats->tx_bytes += can_get_echo_skb(dev, entry->id,
 							    NULL);
 			stats->tx_packets++;
@@ -460,16 +459,16 @@ static irqreturn_t mscan_isr(int irq, void *dev_id)
 		if (!test_bit(F_TX_WAIT_ALL, &priv->flags))
 			netif_wake_queue(dev);
 
-		out_8(&regs->cantier, priv->tx_active);
+		iowrite8(priv->tx_active, &regs->cantier);
 		ret = IRQ_HANDLED;
 	}
 
-	canrflg = in_8(&regs->canrflg);
+	canrflg = ioread8(&regs->canrflg);
 	if ((canrflg & ~MSCAN_STAT_MSK) &&
 	    !test_and_set_bit(F_RX_PROGRESS, &priv->flags)) {
 		if (canrflg & ~MSCAN_STAT_MSK) {
-			priv->shadow_canrier = in_8(&regs->canrier);
-			out_8(&regs->canrier, 0);
+			priv->shadow_canrier = ioread8(&regs->canrier);
+			iowrite8(0, &regs->canrier);
 			napi_schedule(&priv->napi);
 			ret = IRQ_HANDLED;
 		} else {
@@ -513,8 +512,8 @@ static int mscan_do_set_bittiming(struct net_device *dev)
 
 	netdev_info(dev, "setting BTR0=0x%02x BTR1=0x%02x\n", btr0, btr1);
 
-	out_8(&regs->canbtr0, btr0);
-	out_8(&regs->canbtr1, btr1);
+	iowrite8(btr0, &regs->canbtr0);
+	iowrite8(btr1, &regs->canbtr1);
 
 	return 0;
 }
@@ -525,8 +524,8 @@ static int mscan_get_berr_counter(const struct net_device *dev,
 	struct mscan_priv *priv = netdev_priv(dev);
 	struct mscan_regs __iomem *regs = priv->reg_base;
 
-	bec->txerr = in_8(&regs->cantxerr);
-	bec->rxerr = in_8(&regs->canrxerr);
+	bec->txerr = ioread8(&regs->cantxerr);
+	bec->rxerr = ioread8(&regs->canrxerr);
 
 	return 0;
 }
@@ -558,9 +557,9 @@ static int mscan_open(struct net_device *dev)
 	}
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
-		setbits8(&regs->canctl1, MSCAN_LISTEN);
+		iowrite8(ioread8(&regs->canctl1) | (MSCAN_LISTEN), &regs->canctl1);
 	else
-		clrbits8(&regs->canctl1, MSCAN_LISTEN);
+		iowrite8(ioread8(&regs->canctl1) & ~(MSCAN_LISTEN), &regs->canctl1);
 
 	ret = mscan_start(dev);
 	if (ret)
@@ -591,8 +590,8 @@ static int mscan_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	napi_disable(&priv->napi);
 
-	out_8(&regs->cantier, 0);
-	out_8(&regs->canrier, 0);
+	iowrite8(0, &regs->cantier);
+	iowrite8(0, &regs->canrier);
 	mscan_set_mode(dev, MSCAN_INIT_MODE);
 	close_candev(dev);
 	free_irq(dev->irq, dev);
@@ -619,7 +618,7 @@ int register_mscandev(struct net_device *dev, int mscan_clksrc)
 	struct mscan_regs __iomem *regs = priv->reg_base;
 	u8 ctl1;
 
-	ctl1 = in_8(&regs->canctl1);
+	ctl1 = ioread8(&regs->canctl1);
 	if (mscan_clksrc)
 		ctl1 |= MSCAN_CLKSRC;
 	else
@@ -631,21 +630,21 @@ int register_mscandev(struct net_device *dev, int mscan_clksrc)
 	}
 
 	ctl1 |= MSCAN_CANE;
-	out_8(&regs->canctl1, ctl1);
+	iowrite8(ctl1, &regs->canctl1);
 	udelay(100);
 
 	/* acceptance mask/acceptance code (accept everything) */
-	out_be16(&regs->canidar1_0, 0);
-	out_be16(&regs->canidar3_2, 0);
-	out_be16(&regs->canidar5_4, 0);
-	out_be16(&regs->canidar7_6, 0);
-
-	out_be16(&regs->canidmr1_0, 0xffff);
-	out_be16(&regs->canidmr3_2, 0xffff);
-	out_be16(&regs->canidmr5_4, 0xffff);
-	out_be16(&regs->canidmr7_6, 0xffff);
+	iowrite16be(0, &regs->canidar1_0);
+	iowrite16be(0, &regs->canidar3_2);
+	iowrite16be(0, &regs->canidar5_4);
+	iowrite16be(0, &regs->canidar7_6);
+
+	iowrite16be(0xffff, &regs->canidmr1_0);
+	iowrite16be(0xffff, &regs->canidmr3_2);
+	iowrite16be(0xffff, &regs->canidmr5_4);
+	iowrite16be(0xffff, &regs->canidmr7_6);
 	/* Two 32 bit Acceptance Filters */
-	out_8(&regs->canidac, MSCAN_AF_32BIT);
+	iowrite8(MSCAN_AF_32BIT, &regs->canidac);
 
 	mscan_set_mode(dev, MSCAN_INIT_MODE);
 
@@ -657,7 +656,7 @@ void unregister_mscandev(struct net_device *dev)
 	struct mscan_priv *priv = netdev_priv(dev);
 	struct mscan_regs __iomem *regs = priv->reg_base;
 	mscan_set_mode(dev, MSCAN_INIT_MODE);
-	clrbits8(&regs->canctl1, MSCAN_CANE);
+	iowrite8(ioread8(&regs->canctl1) & ~(MSCAN_CANE), &regs->canctl1);
 	unregister_candev(dev);
 }
 
-- 
2.54.0


