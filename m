Return-Path: <linux-can+bounces-4318-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EEFB31503
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 12:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CBC605288
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 10:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DC32D027F;
	Fri, 22 Aug 2025 10:17:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774112C21DA;
	Fri, 22 Aug 2025 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857851; cv=none; b=sZM2rJ18ODDgVD06juIOUf1KPdrctvnyMDKsGKF8Nwdrp/oyTeap9izNI+Z1o9p+zOrtCBeP11Nudf2DSJlIVH681/nrEzdst06ib1Hzmtugicz+j3US56JwwGUnCwurG+wLSfeZLsH9UviwX7+slz6xTv4kj0zJbSrTcYYkYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857851; c=relaxed/simple;
	bh=yFtXoZG+t8CZvUeZev3M2tncy9uEoOS5+8OWJRLZ4zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfWsmPtVQ/ixIFsg6Mut4Ac3Dapa4py3QjpWZEjbpysjOcQJ2LPJZ21aoWj6Y/EZpzvMCc2BaSv9f3/26iRny+FRfh61iHR60+s+RkFM4KSQEgc+eoTgRhPAzCa1hfzaPu/UQteJhG+GQGdKhVMaQRCSRgRwfpY/8IivY2KXv04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119F8C4CEED;
	Fri, 22 Aug 2025 10:17:29 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 08/11] can: rcar_can: BCR bitfield conversion
Date: Fri, 22 Aug 2025 12:17:09 +0200
Message-ID: <01cfaedba2be22515ba8700893ea7f113df959c0.1755857536.git.geert+renesas@glider.be>
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

Convert CAN Bit Configuration Register field accesses to use the
FIELD_PREP() bitfield access macro.  While at it, fix the misspelling of
BRP.

This gets rid of custom function-like field preparation macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/net/can/rcar/rcar_can.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 6f28dc9354511120..4c5c1f0446913d37 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -152,10 +152,10 @@ static const struct can_bittiming_const rcar_can_bittiming_const = {
 #define RCAR_CAN_N_RX_MKREGS2	8
 
 /* Bit Configuration Register settings */
-#define RCAR_CAN_BCR_TSEG1(x)	(((x) & 0x0f) << 20)
-#define RCAR_CAN_BCR_BPR(x)	(((x) & 0x3ff) << 8)
-#define RCAR_CAN_BCR_SJW(x)	(((x) & 0x3) << 4)
-#define RCAR_CAN_BCR_TSEG2(x)	((x) & 0x07)
+#define RCAR_CAN_BCR_TSEG1	GENMASK(23, 20)
+#define RCAR_CAN_BCR_BRP	GENMASK(17, 8)
+#define RCAR_CAN_BCR_SJW	GENMASK(5, 4)
+#define RCAR_CAN_BCR_TSEG2	GENMASK(2, 0)
 
 /* Mailbox and Mask Registers bits */
 #define RCAR_CAN_IDE		BIT(31)		/* ID Extension */
@@ -428,9 +428,10 @@ static void rcar_can_set_bittiming(struct net_device *ndev)
 	struct can_bittiming *bt = &priv->can.bittiming;
 	u32 bcr;
 
-	bcr = RCAR_CAN_BCR_TSEG1(bt->phase_seg1 + bt->prop_seg - 1) |
-	      RCAR_CAN_BCR_BPR(bt->brp - 1) | RCAR_CAN_BCR_SJW(bt->sjw - 1) |
-	      RCAR_CAN_BCR_TSEG2(bt->phase_seg2 - 1);
+	bcr = FIELD_PREP(RCAR_CAN_BCR_TSEG1, bt->phase_seg1 + bt->prop_seg - 1) |
+	      FIELD_PREP(RCAR_CAN_BCR_BRP, bt->brp - 1) |
+	      FIELD_PREP(RCAR_CAN_BCR_SJW, bt->sjw - 1) |
+	      FIELD_PREP(RCAR_CAN_BCR_TSEG2, bt->phase_seg2 - 1);
 	/* Don't overwrite CLKR with 32-bit BCR access; CLKR has 8-bit access.
 	 * All the registers are big-endian but they get byte-swapped on 32-bit
 	 * read/write (but not on 8-bit, contrary to the manuals)...
-- 
2.43.0


