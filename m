Return-Path: <linux-can+bounces-1288-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A76966BF2
	for <lists+linux-can@lfdr.de>; Sat, 31 Aug 2024 00:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEA71F23B4F
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 22:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A551C32EB;
	Fri, 30 Aug 2024 21:59:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC86A1C1ACC
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725055168; cv=none; b=OVE/mh1S/9VW1FJTwo3KNIkf5UAWY2O4MCwIFJS76WUHi0DuVfJep4xFw8S0fUvbPGVxa9Ai2cn0arSEqIWovq2YiveT1KmI6xPb/sPSjuvpcV371lMCfZLNyzBClLHe4H3e7VrOycLns1csBFvQ+DbgNJHo5HfNsRMjSBvOEAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725055168; c=relaxed/simple;
	bh=sUzRt1zcFM1JZj8m28P+zBE84P6voXaJifpueLLxdaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBzFoDj9mMUSjTKe6TaM1bvnjquMaMTOR99R/CS8Zu3SCDL9vPU5fHwkmiFDSDN0BipxMsNZbhI0/cHYWrA/vj23Spye+QzcX1o6ulNMPiAwIBhyd8E7s8LVDc5XCv7FKPOlJXdgp2IlZInRmNK3099WC2+8qB+HeW4Zzsvao/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eM-0004FB-LS
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:59:22 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eK-004FYZ-Ib
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:59:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 41B7332E531
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:59:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 517DA32E4E5;
	Fri, 30 Aug 2024 21:59:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a8d1695a;
	Fri, 30 Aug 2024 21:59:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 10/13] can: mcp251xfd: fix ring configuration when switching from CAN-CC to CAN-FD mode
Date: Fri, 30 Aug 2024 23:53:45 +0200
Message-ID: <20240830215914.1610393-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830215914.1610393-1-mkl@pengutronix.de>
References: <20240830215914.1610393-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

If the ring (rx, tx) and/or coalescing parameters (rx-frames-irq,
tx-frames-irq) have been configured while the interface was in CAN-CC
mode, but the interface is brought up in CAN-FD mode, the ring
parameters might be too big.

Use the default CAN-FD values in this case.

Fixes: 9263c2e92be9 ("can: mcp251xfd: ring: add support for runtime configurable RX/TX ring parameters")
Link: https://lore.kernel.org/all/20240805-mcp251xfd-fix-ringconfig-v1-1-72086f0ca5ee@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ram.c | 11 +++++++++-
 .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    | 20 ++++++++++++++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ram.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ram.c
index 9e8e82cdba46..61b0d6fa52dd 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ram.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ram.c
@@ -97,7 +97,16 @@ void can_ram_get_layout(struct can_ram_layout *layout,
 	if (ring) {
 		u8 num_rx_coalesce = 0, num_tx_coalesce = 0;
 
-		num_rx = can_ram_rounddown_pow_of_two(config, &config->rx, 0, ring->rx_pending);
+		/* If the ring parameters have been configured in
+		 * CAN-CC mode, but and we are in CAN-FD mode now,
+		 * they might be to big. Use the default CAN-FD values
+		 * in this case.
+		 */
+		num_rx = ring->rx_pending;
+		if (num_rx > layout->max_rx)
+			num_rx = layout->default_rx;
+
+		num_rx = can_ram_rounddown_pow_of_two(config, &config->rx, 0, num_rx);
 
 		/* The ethtool doc says:
 		 * To disable coalescing, set usecs = 0 and max_frames = 1.
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index 7bd2bcb5cf87..f72582d4d3e8 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -469,11 +469,25 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 
 	/* switching from CAN-2.0 to CAN-FD mode or vice versa */
 	if (fd_mode != test_bit(MCP251XFD_FLAGS_FD_MODE, priv->flags)) {
+		const struct ethtool_ringparam ring = {
+			.rx_pending = priv->rx_obj_num,
+			.tx_pending = priv->tx->obj_num,
+		};
+		const struct ethtool_coalesce ec = {
+			.rx_coalesce_usecs_irq = priv->rx_coalesce_usecs_irq,
+			.rx_max_coalesced_frames_irq = priv->rx_obj_num_coalesce_irq,
+			.tx_coalesce_usecs_irq = priv->tx_coalesce_usecs_irq,
+			.tx_max_coalesced_frames_irq = priv->tx_obj_num_coalesce_irq,
+		};
 		struct can_ram_layout layout;
 
-		can_ram_get_layout(&layout, &mcp251xfd_ram_config, NULL, NULL, fd_mode);
-		priv->rx_obj_num = layout.default_rx;
-		tx_ring->obj_num = layout.default_tx;
+		can_ram_get_layout(&layout, &mcp251xfd_ram_config, &ring, &ec, fd_mode);
+
+		priv->rx_obj_num = layout.cur_rx;
+		priv->rx_obj_num_coalesce_irq = layout.rx_coalesce;
+
+		tx_ring->obj_num = layout.cur_tx;
+		priv->tx_obj_num_coalesce_irq = layout.tx_coalesce;
 	}
 
 	if (fd_mode) {
-- 
2.45.2



