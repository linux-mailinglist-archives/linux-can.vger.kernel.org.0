Return-Path: <linux-can+bounces-4316-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBE6B314FE
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 12:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CC660515F
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F75C2D4805;
	Fri, 22 Aug 2025 10:17:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428572D47F5;
	Fri, 22 Aug 2025 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857848; cv=none; b=kaO/ihRclW/KXDjEJ7Ex8WKHFn4imK0eZ8CNeklGVEfuPNhsbRqVUHJb45iA8RohGd8MfznnZmHwmjTvkcAPZfi4pxXRdDXcgirqpersp9w7SV/iFE3ZPCXlnpg7AqwCztQ6pxUo+y4h8xfeNKqy29f3X4MhpjKLhKwAPuQi+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857848; c=relaxed/simple;
	bh=EPfavzpcf6p8FzUwYhR8Q0iLy8NFB6TqGHKiLThCxLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lftXZjwTt5BQqJD7cfKAnvywcCdIZ007yAdIZINT8o1N3fnwf3LDbqSM1My92yU5vM/7eby+azL93BCqDYChAMtEc49/zZWFZVpfQwuPfeRRpaPnGmjpQ3dfDKEE00kZyx01CRDgtBI1jFzo9Va4laK1a1lpIqx0HhwTQjCyXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F52C4CEED;
	Fri, 22 Aug 2025 10:17:26 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 06/11] can: rcar_can: CTLR bitfield conversion
Date: Fri, 22 Aug 2025 12:17:07 +0200
Message-ID: <077640e31949dc3c9d128a08ade94c9e9cd25672.1755857536.git.geert+renesas@glider.be>
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

Convert CAN Control Register field accesses to use the FIELD_PREP()
bitfield access macro.  Add a few more comments and definitions while at
it.

This gets rid of explicit (and sometimes confusing) shifts.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/net/can/rcar/rcar_can.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 7b94224bbc9b36fa..8b4356fcd7d2fddb 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2013 Renesas Solutions Corp.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -115,16 +116,19 @@ static const struct can_bittiming_const rcar_can_bittiming_const = {
 
 /* Control Register bits */
 #define RCAR_CAN_CTLR_BOM	GENMASK(12, 11)	/* Bus-Off Recovery Mode Bits */
-#define RCAR_CAN_CTLR_BOM_ENT	(1 << 11) /* Entry to halt mode */
-					/* at bus-off entry */
+#define RCAR_CAN_CTLR_BOM_ENT		1	/* Entry to halt mode */
+						/* at bus-off entry */
 #define RCAR_CAN_CTLR_SLPM	BIT(10)		/* Sleep Mode */
 #define RCAR_CAN_CTLR_CANM	GENMASK(9, 8)	/* Operating Mode Select Bit */
-#define RCAR_CAN_CTLR_CANM_HALT	(1 << 9)
-#define RCAR_CAN_CTLR_CANM_RESET (1 << 8)
-#define RCAR_CAN_CTLR_CANM_FORCE_RESET (3 << 8)
+#define RCAR_CAN_CTLR_CANM_OPER		0	/* Operation Mode */
+#define RCAR_CAN_CTLR_CANM_RESET	1	/* Reset Mode */
+#define RCAR_CAN_CTLR_CANM_HALT		2	/* Halt Mode */
+#define RCAR_CAN_CTLR_CANM_FORCE_RESET	3	/* Reset Mode (forcible) */
 #define RCAR_CAN_CTLR_MLM	BIT(3)		/* Message Lost Mode Select */
 #define RCAR_CAN_CTLR_IDFM	GENMASK(2, 1)	/* ID Format Mode Select Bits */
-#define RCAR_CAN_CTLR_IDFM_MIXED (1 << 2) /* Mixed ID mode */
+#define RCAR_CAN_CTLR_IDFM_STD		0	/* Standard ID mode */
+#define RCAR_CAN_CTLR_IDFM_EXT		1	/* Extended ID mode */
+#define RCAR_CAN_CTLR_IDFM_MIXED	2	/* Mixed ID mode */
 #define RCAR_CAN_CTLR_MBM	BIT(0)		/* Mailbox Mode select */
 
 /* Status Register bits */
@@ -453,16 +457,17 @@ static void rcar_can_start(struct net_device *ndev)
 	ctlr &= ~RCAR_CAN_CTLR_SLPM;
 	writew(ctlr, &priv->regs->ctlr);
 	/* Go to reset mode */
-	ctlr |= RCAR_CAN_CTLR_CANM_FORCE_RESET;
+	ctlr |= FIELD_PREP(RCAR_CAN_CTLR_CANM, RCAR_CAN_CTLR_CANM_FORCE_RESET);
 	writew(ctlr, &priv->regs->ctlr);
 	for (i = 0; i < MAX_STR_READS; i++) {
 		if (readw(&priv->regs->str) & RCAR_CAN_STR_RSTST)
 			break;
 	}
 	rcar_can_set_bittiming(ndev);
-	ctlr |= RCAR_CAN_CTLR_IDFM_MIXED; /* Select mixed ID mode */
-	ctlr |= RCAR_CAN_CTLR_BOM_ENT;	/* Entry to halt mode automatically */
-					/* at bus-off */
+	/* Select mixed ID mode */
+	ctlr |= FIELD_PREP(RCAR_CAN_CTLR_IDFM, RCAR_CAN_CTLR_IDFM_MIXED);
+	/* Entry to halt mode automatically at bus-off */
+	ctlr |= FIELD_PREP(RCAR_CAN_CTLR_BOM, RCAR_CAN_CTLR_BOM_ENT);
 	ctlr |= RCAR_CAN_CTLR_MBM;	/* Select FIFO mailbox mode */
 	ctlr |= RCAR_CAN_CTLR_MLM;	/* Overrun mode */
 	writew(ctlr, &priv->regs->ctlr);
@@ -492,7 +497,9 @@ static void rcar_can_start(struct net_device *ndev)
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	/* Go to operation mode */
-	writew(ctlr & ~RCAR_CAN_CTLR_CANM, &priv->regs->ctlr);
+	ctlr &= ~RCAR_CAN_CTLR_CANM;
+	ctlr |= FIELD_PREP(RCAR_CAN_CTLR_CANM, RCAR_CAN_CTLR_CANM_OPER);
+	writew(ctlr, &priv->regs->ctlr);
 	for (i = 0; i < MAX_STR_READS; i++) {
 		if (!(readw(&priv->regs->str) & RCAR_CAN_STR_RSTST))
 			break;
@@ -553,7 +560,7 @@ static void rcar_can_stop(struct net_device *ndev)
 
 	/* Go to (force) reset mode */
 	ctlr = readw(&priv->regs->ctlr);
-	ctlr |= RCAR_CAN_CTLR_CANM_FORCE_RESET;
+	ctlr |= FIELD_PREP(RCAR_CAN_CTLR_CANM, RCAR_CAN_CTLR_CANM_FORCE_RESET);
 	writew(ctlr, &priv->regs->ctlr);
 	for (i = 0; i < MAX_STR_READS; i++) {
 		if (readw(&priv->regs->str) & RCAR_CAN_STR_RSTST)
@@ -847,7 +854,7 @@ static int rcar_can_suspend(struct device *dev)
 	netif_device_detach(ndev);
 
 	ctlr = readw(&priv->regs->ctlr);
-	ctlr |= RCAR_CAN_CTLR_CANM_HALT;
+	ctlr |= FIELD_PREP(RCAR_CAN_CTLR_CANM, RCAR_CAN_CTLR_CANM_HALT);
 	writew(ctlr, &priv->regs->ctlr);
 	ctlr |= RCAR_CAN_CTLR_SLPM;
 	writew(ctlr, &priv->regs->ctlr);
-- 
2.43.0


