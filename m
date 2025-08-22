Return-Path: <linux-can+bounces-4315-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60381B3151F
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 12:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A49AA4678
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279FF2D3ED3;
	Fri, 22 Aug 2025 10:17:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADCF2D3A97;
	Fri, 22 Aug 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857847; cv=none; b=ebexuJ93IxJRotfOesHgUYIPsasc2osV0Yh3vaqAt2bm2wRqOsP0p5d3yovSpGqhw70Lkoj8Z67kkUw8dzisaB4U8fX0rUAXiRWlsRmRCuT8/TszPBRHT+cxXuhCUIo4+ApcGwWes1+gBrvOs0CfRxU/qQNdWanhTbdgQ3+i1hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857847; c=relaxed/simple;
	bh=iOu4cTkwZ83svm6rJqrqwhVvNfm7JSxdOo9WDrcOZyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6BON//fXkLFmLxqCcjs6GEG+fxncrUmVr4PtULB+jup/61hDBrrJbzZWDJPUmMqZWnrU3ldSWq/iM5SuQv/XgHYSb4TqKV8dO6+fq6Gf6XZ0PGviFgRThqfmiez/q08BxEB4wObu5OVTDC938RR0Lk47ErL/Kyjmg8+Avw0fxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79339C4CEF1;
	Fri, 22 Aug 2025 10:17:25 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 05/11] can: rcar_can: Convert to GENMASK()
Date: Fri, 22 Aug 2025 12:17:06 +0200
Message-ID: <3f947f0f91a8857a2cbce74807e42258e9f209ca.1755857536.git.geert+renesas@glider.be>
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

Use the GENMASK() macro instead of open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/net/can/rcar/rcar_can.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index c47ee4e41eb62d9e..7b94224bbc9b36fa 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -114,16 +114,16 @@ static const struct can_bittiming_const rcar_can_bittiming_const = {
 };
 
 /* Control Register bits */
-#define RCAR_CAN_CTLR_BOM	(3 << 11) /* Bus-Off Recovery Mode Bits */
+#define RCAR_CAN_CTLR_BOM	GENMASK(12, 11)	/* Bus-Off Recovery Mode Bits */
 #define RCAR_CAN_CTLR_BOM_ENT	(1 << 11) /* Entry to halt mode */
 					/* at bus-off entry */
 #define RCAR_CAN_CTLR_SLPM	BIT(10)		/* Sleep Mode */
-#define RCAR_CAN_CTLR_CANM	(3 << 8) /* Operating Mode Select Bit */
+#define RCAR_CAN_CTLR_CANM	GENMASK(9, 8)	/* Operating Mode Select Bit */
 #define RCAR_CAN_CTLR_CANM_HALT	(1 << 9)
 #define RCAR_CAN_CTLR_CANM_RESET (1 << 8)
 #define RCAR_CAN_CTLR_CANM_FORCE_RESET (3 << 8)
 #define RCAR_CAN_CTLR_MLM	BIT(3)		/* Message Lost Mode Select */
-#define RCAR_CAN_CTLR_IDFM	(3 << 1) /* ID Format Mode Select Bits */
+#define RCAR_CAN_CTLR_IDFM	GENMASK(2, 1)	/* ID Format Mode Select Bits */
 #define RCAR_CAN_CTLR_IDFM_MIXED (1 << 2) /* Mixed ID mode */
 #define RCAR_CAN_CTLR_MBM	BIT(0)		/* Mailbox Mode select */
 
@@ -139,7 +139,7 @@ static const struct can_bittiming_const rcar_can_bittiming_const = {
 #define RCAR_CAN_RFCR_RFE	BIT(0)		/* Receive FIFO Enable */
 
 /* Transmit FIFO Control Register bits */
-#define RCAR_CAN_TFCR_TFUST	(7 << 1)	/* Transmit FIFO Unsent Message */
+#define RCAR_CAN_TFCR_TFUST	GENMASK(3, 1)	/* Transmit FIFO Unsent Message */
 						/* Number Status Bits */
 #define RCAR_CAN_TFCR_TFUST_SHIFT 1		/* Offset of Transmit FIFO Unsent */
 						/* Message Number Status Bits */
-- 
2.43.0


