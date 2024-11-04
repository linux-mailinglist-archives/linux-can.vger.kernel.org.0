Return-Path: <linux-can+bounces-1881-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECA29BBE70
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 21:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDFC1B20EE2
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 20:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5923B1D47C8;
	Mon,  4 Nov 2024 20:01:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5634D1D4141
	for <linux-can@vger.kernel.org>; Mon,  4 Nov 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750491; cv=none; b=T6KPpVgUdfD4fDce84vwz3SSb9pqX0+iwNOhRjeKU7JuYou3jl+X9TMNWHcDlowI0VKInJk7+4V8I0f1KP54S2r4pNxvL7PxrHRALRBXMQvjBTKmc3c4kKhY0Ft3/yijmBU5EbFSlYfgCseVN2nyxGJ3fwrk2Kdj+bO1Co+I4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750491; c=relaxed/simple;
	bh=YnqhUsVRyg3UlxWtGIseNrn0TmeUDXq8EcmoB5ijOZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAzKOsDtZQA8xMi0iwV6sYp9wDFQXWDL2Vdz/8VW4PwxOqI8ZPPwghmgfywrNSztpZunIUgBjn7qnXayj9pF9U9Jfy7bM+O3+aR0MATRtvYvMX+zUA6RBUhvYSSq1H+vnKQOliRnvbEDuPH3RAP7M1WHlUp/B86wyuEbex4ogJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t83GR-0001cp-GO
	for linux-can@vger.kernel.org; Mon, 04 Nov 2024 21:01:27 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t83GQ-00226U-16
	for linux-can@vger.kernel.org;
	Mon, 04 Nov 2024 21:01:26 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0B64D367FA9
	for <linux-can@vger.kernel.org>; Mon, 04 Nov 2024 20:01:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id AAABB367F6B;
	Mon, 04 Nov 2024 20:01:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4a511178;
	Mon, 4 Nov 2024 20:01:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 7/8] can: mcp251xfd: mcp251xfd_ring_alloc(): fix coalescing configuration when switching CAN modes
Date: Mon,  4 Nov 2024 20:53:30 +0100
Message-ID: <20241104200120.393312-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104200120.393312-1-mkl@pengutronix.de>
References: <20241104200120.393312-1-mkl@pengutronix.de>
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

Since commit 50ea5449c563 ("can: mcp251xfd: fix ring configuration
when switching from CAN-CC to CAN-FD mode"), the current ring and
coalescing configuration is passed to can_ram_get_layout(). That fixed
the issue when switching between CAN-CC and CAN-FD mode with
configured ring (rx, tx) and/or coalescing parameters (rx-frames-irq,
tx-frames-irq).

However 50ea5449c563 ("can: mcp251xfd: fix ring configuration when
switching from CAN-CC to CAN-FD mode"), introduced a regression when
switching CAN modes with disabled coalescing configuration: Even if
the previous CAN mode has no coalescing configured, the new mode is
configured with active coalescing. This leads to delayed receiving of
CAN-FD frames.

This comes from the fact, that ethtool uses usecs = 0 and max_frames =
1 to disable coalescing, however the driver uses internally
priv->{rx,tx}_obj_num_coalesce_irq = 0 to indicate disabled
coalescing.

Fix the regression by assigning struct ethtool_coalesce
ec->{rx,tx}_max_coalesced_frames_irq = 1 if coalescing is disabled in
the driver as can_ram_get_layout() expects this.

Reported-by: https://github.com/vdh-robothania
Closes: https://github.com/raspberrypi/linux/issues/6407
Fixes: 50ea5449c563 ("can: mcp251xfd: fix ring configuration when switching from CAN-CC to CAN-FD mode")
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241025-mcp251xfd-fix-coalesing-v1-1-9d11416de1df@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index e684991fa391..7209a831f0f2 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -2,7 +2,7 @@
 //
 // mcp251xfd - Microchip MCP251xFD Family CAN controller driver
 //
-// Copyright (c) 2019, 2020, 2021 Pengutronix,
+// Copyright (c) 2019, 2020, 2021, 2024 Pengutronix,
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 // Based on:
@@ -483,9 +483,11 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 		};
 		const struct ethtool_coalesce ec = {
 			.rx_coalesce_usecs_irq = priv->rx_coalesce_usecs_irq,
-			.rx_max_coalesced_frames_irq = priv->rx_obj_num_coalesce_irq,
+			.rx_max_coalesced_frames_irq = priv->rx_obj_num_coalesce_irq == 0 ?
+				1 : priv->rx_obj_num_coalesce_irq,
 			.tx_coalesce_usecs_irq = priv->tx_coalesce_usecs_irq,
-			.tx_max_coalesced_frames_irq = priv->tx_obj_num_coalesce_irq,
+			.tx_max_coalesced_frames_irq = priv->tx_obj_num_coalesce_irq == 0 ?
+				1 : priv->tx_obj_num_coalesce_irq,
 		};
 		struct can_ram_layout layout;
 
-- 
2.45.2



