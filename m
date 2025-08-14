Return-Path: <linux-can+bounces-4239-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4EBB264E8
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 14:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1DFA03C78
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 12:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51C52727FC;
	Thu, 14 Aug 2025 12:02:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54C212575;
	Thu, 14 Aug 2025 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172950; cv=none; b=mW2P7LjraW4vw6KEVc+xbj54wF8NbCyzyoKePoWYjlaCZKPgT825vJ3eBuRGkm9wOCMouqX3OjaQVyLrDROBp5IRTBAKHkeNHCe+7MlnnOlg2XzdPOWfBlWeCbrDISIxyui6JV8nTMtDotY4hx2QGOXyC3XMC9OicfBFeEIOveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172950; c=relaxed/simple;
	bh=VzSrbx+DutY8RPbA+NXEl9BmwtSLEly1xzuBnsHbijo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dtp9GjYHSOrZdn+qhv2K4pPX994Xd+IjS8Zq5mqzdcLftjcsuXX+H/xROJUfBQPqNViSeKjBNIwJgxlhWYxLpiD7z/c86/cb0XRuJmTlUXrh0G5xEsEUS8zJes5tsf6HhGGg6zgC040R3skyU/xtyyM2iprW0KcoicmAORMQItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34599C4CEEF;
	Thu, 14 Aug 2025 12:02:29 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 7/9] can: rcar_can: TFCR bitfield conversion
Date: Thu, 14 Aug 2025 14:02:05 +0200
Message-ID: <58d40f953be70d2e5e2ff8c203e6e93996ed9553.1755172404.git.geert+renesas@glider.be>
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

Convert CAN Transmit FIFO Control Register field accesses to use the
FIELD_GET() bitfield access macro.

This gets rid of an explicit shift.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_can.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index b7b5f4cd3c3afd20..37b96e25e229f37c 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -145,8 +145,6 @@ static const struct can_bittiming_const rcar_can_bittiming_const = {
 /* Transmit FIFO Control Register bits */
 #define RCAR_CAN_TFCR_TFUST	GENMASK(3, 1)	/* Transmit FIFO Unsent Message */
 						/* Number Status Bits */
-#define RCAR_CAN_TFCR_TFUST_SHIFT 1		/* Offset of Transmit FIFO Unsent */
-						/* Message Number Status Bits */
 #define RCAR_CAN_TFCR_TFE	BIT(0)		/* Transmit FIFO Enable */
 
 #define RCAR_CAN_N_RX_MKREGS1	2		/* Number of mask registers */
@@ -377,10 +375,9 @@ static void rcar_can_tx_done(struct net_device *ndev)
 	u8 isr;
 
 	while (1) {
-		u8 unsent = readb(&priv->regs->tfcr);
+		u8 unsent = FIELD_GET(RCAR_CAN_TFCR_TFUST,
+			    readb(&priv->regs->tfcr));
 
-		unsent = (unsent & RCAR_CAN_TFCR_TFUST) >>
-			  RCAR_CAN_TFCR_TFUST_SHIFT;
 		if (priv->tx_head - priv->tx_tail <= unsent)
 			break;
 		stats->tx_packets++;
-- 
2.43.0


