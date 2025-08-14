Return-Path: <linux-can+bounces-4241-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFBBB264E4
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 14:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4753A7A7957
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 12:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285FC2FC86B;
	Thu, 14 Aug 2025 12:02:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDE52EBBAC;
	Thu, 14 Aug 2025 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172954; cv=none; b=bQpPunl9JB/WTgNkHMCBXwgGpi2EtHux4mL58p2lrWy9zHeARSt9vIjbUOxEk1jrgRa0zaiBGCAS2ccElwRR2MqRbu5E8Xr6NKK7grFuyyOVzVclLLm/0IVUBfJ9Np1debj2UWfVZ8MxbILzNrTP7XPGoNvK2EukIKx5yjf9lQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172954; c=relaxed/simple;
	bh=iRhd2H1KSmoIbNxxgnPvdVKF7js/9FWzl00CSZu/k0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUgCDrwfocMeBJ3oBlgSy1ozdc2PqUitobXQCXhrpSetCbmXkeA/mvdDRLNYfBOl4kBoNmIJc3BpEw40x3qe4AxJZwV+JS7teKcBX3l8FsYUtyKr71WNjJZ3t44PBSIPaJOWuXF9y87C55kKqHvifFoGy8XHDmGpb4S9VvMrffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E2FC4CEEF;
	Thu, 14 Aug 2025 12:02:32 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 9/9] can: rcar_can: Mailbox bitfield conversion
Date: Thu, 14 Aug 2025 14:02:07 +0200
Message-ID: <fc5f681a2d8011a6fa8e128da213b479bcdf88cc.1755172404.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755172404.git.geert+renesas@glider.be>
References: <cover.1755172404.git.geert+renesas@glider.be>
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
 drivers/net/can/rcar/rcar_can.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index e4ad18f3be9bcf72..9ef4dacd49fdc944 100644
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
@@ -600,9 +601,10 @@ static netdev_tx_t rcar_can_start_xmit(struct sk_buff *skb,
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
@@ -657,9 +659,9 @@ static void rcar_can_rx_pkt(struct rcar_can_priv *priv)
 
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


