Return-Path: <linux-can+bounces-4317-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120EBB314FF
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 12:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5BE6051E9
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6332C08D4;
	Fri, 22 Aug 2025 10:17:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242722D3A97;
	Fri, 22 Aug 2025 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857850; cv=none; b=eVbyiLxDn3+N+d6+BHTN5getEB7vJuBlh2Mr6+3RTfbYqPSrtBIwY8EaKjUt31rkYHs36dlH7q4Mf1MoEZrnq8BCl45kvsTKobNj2OIg45EBAXlEZZKN4OvZzK7wiL9IupYzh7oea5r/9woBHI5IYZuYkPEEaHDZRRsndrweLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857850; c=relaxed/simple;
	bh=xV67ul0j5uDMgxIB4+qh9eXTzcCdvRsO387GL8j1ELE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJGfT0dSHR4Y0DQbhqirupBRc2SbixDSLRa4m9LJDxoZGldaXw/bZvzpf5TjvChxCQtKYuna8ynS776ib2pHP3QunI5iglBTkfCM1FcOpBSSLbRgDJf1MZXcOQ57b4Im6UrT7Uci+mrvvQ5wEnSw0tCkKjadfnN0+qpcKyZHMRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855BDC4CEF1;
	Fri, 22 Aug 2025 10:17:28 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 07/11] can: rcar_can: TFCR bitfield conversion
Date: Fri, 22 Aug 2025 12:17:08 +0200
Message-ID: <a8b1dc6f1249a01af9b691ca59e2e5cc2dba6d44.1755857536.git.geert+renesas@glider.be>
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

Convert CAN Transmit FIFO Control Register field accesses to use the
FIELD_GET() bitfield access macro.

This gets rid of an explicit shift.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/net/can/rcar/rcar_can.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 8b4356fcd7d2fddb..6f28dc9354511120 100644
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


