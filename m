Return-Path: <linux-can+bounces-4319-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD8FB31504
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 12:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740FC605314
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 10:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1F72D77EF;
	Fri, 22 Aug 2025 10:17:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A65291C3F;
	Fri, 22 Aug 2025 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857853; cv=none; b=d5AIBuojhHR34BlTc8BZIEyzp3Q+jaAqR/cYKGYY40F6RxeJ1/XN4KDxnH7/jJ8udXB03WnBk4lSUGEdLoL6YgupgZ0t0Kv1dlgysZUK2ek7CGWJaR00hJ02PFh53WXqTwZiqEkv/CfxYEz09WEVs62+PS29oammSFWi4wrlX0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857853; c=relaxed/simple;
	bh=EvAAiythl30eWGANv4iNqbZvKJ4sgQ9n3JEaquJjaz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbIu80XR4SyxIjT0UEyBg0oZT6hRNuHzHaA73AsFfuG4kGumoXpDfwAwdJNaN4cxNgIntCtA002vakKTCDjltj14E4CU7R517hFI/XhHRW+8DKmcFx8LPuft0p/GRfKgUMwEAtooa9Y1NIVcMcLWtpctNVApcn1LkpDKmYsM13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950CAC4CEED;
	Fri, 22 Aug 2025 10:17:31 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 09/11] can: rcar_can: Mailbox bitfield conversion
Date: Fri, 22 Aug 2025 12:17:10 +0200
Message-ID: <c75c7d6ed5929c4becf7c9178cec04a0731e8ab1.1755857536.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755857536.git.geert+renesas@glider.be>
References: <cover.1755857536.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert CAN Mailbox Register field accesses to use the FIELD_PREP() and
FIELD_GET() bitfield access macro.

This gets rid of explicit shifts, and keeps a clear separation between
hardware register layouts and offical CAN definitions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/net/can/rcar/rcar_can.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 4c5c1f0446913d37..de1829477659757c 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -160,7 +160,8 @@ static const struct can_bittiming_const rcar_can_bittiming_const = {
 /* Mailbox and Mask Registers bits */
 #define RCAR_CAN_IDE		BIT(31)		/* ID Extension */
 #define RCAR_CAN_RTR		BIT(30)		/* Remote Transmission Request */
-#define RCAR_CAN_SID_SHIFT	18
+#define RCAR_CAN_SID		GENMASK(28, 18)	/* Standard ID */
+#define RCAR_CAN_EID		GENMASK(28, 0)	/* Extended ID */
 
 /* Mailbox Interrupt Enable Register 1 bits */
 #define RCAR_CAN_MIER1_RXFIE	BIT(28)		/* Receive  FIFO Interrupt Enable */
@@ -599,9 +600,10 @@ static netdev_tx_t rcar_can_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 
 	if (cf->can_id & CAN_EFF_FLAG)	/* Extended frame format */
-		data = (cf->can_id & CAN_EFF_MASK) | RCAR_CAN_IDE;
+		data = FIELD_PREP(RCAR_CAN_EID, cf->can_id & CAN_EFF_MASK) |
+		       RCAR_CAN_IDE;
 	else				/* Standard frame format */
-		data = (cf->can_id & CAN_SFF_MASK) << RCAR_CAN_SID_SHIFT;
+		data = FIELD_PREP(RCAR_CAN_SID, cf->can_id & CAN_SFF_MASK);
 
 	if (cf->can_id & CAN_RTR_FLAG) { /* Remote transmission request */
 		data |= RCAR_CAN_RTR;
@@ -656,9 +658,9 @@ static void rcar_can_rx_pkt(struct rcar_can_priv *priv)
 
 	data = readl(&priv->regs->mb[RCAR_CAN_RX_FIFO_MBX].id);
 	if (data & RCAR_CAN_IDE)
-		cf->can_id = (data & CAN_EFF_MASK) | CAN_EFF_FLAG;
+		cf->can_id = FIELD_GET(RCAR_CAN_EID, data) | CAN_EFF_FLAG;
 	else
-		cf->can_id = (data >> RCAR_CAN_SID_SHIFT) & CAN_SFF_MASK;
+		cf->can_id = FIELD_GET(RCAR_CAN_SID, data);
 
 	dlc = readb(&priv->regs->mb[RCAR_CAN_RX_FIFO_MBX].dlc);
 	cf->len = can_cc_dlc2len(dlc);
-- 
2.43.0


