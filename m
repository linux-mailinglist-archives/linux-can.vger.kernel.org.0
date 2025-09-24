Return-Path: <linux-can+bounces-4920-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1CCB98CAB
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A481819C76BA
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5DB2857F0;
	Wed, 24 Sep 2025 08:21:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458F22820D7
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702105; cv=none; b=hs6m0iR8kR/pKJaSLIund43z2NBytvdEA8ElscYbr7onMifqN27JEs4h51pHn9EfiOB1bB9jCsFhriIQXopK4LHJ8pLaYjYXl/qobSf/ww94KDPqSAHgv+Ks6lXeXnIqwh6M3jbzAM+IecQwYvgN9vQ1HLNlnZqtIrYZP21cRno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702105; c=relaxed/simple;
	bh=a//sQLZz51Y+M3k7aHkH7nytzMli7QEPQmBRLgdfCi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cy6UqYIHvAZvNdqGHb+e75e5MRtbUf/RSKxKXgZ+gMmh483xA2OMkgiGcu/qUcnzvN6nH40PrvsoJWvX/nqxaAEnq25Nh5J/q4PsWeMw39xqdRZtZhV/aAuQnKb6zFIq/b80TJiMs0lrjasSXSX0MdFxuDiNC3P6QWcCarZniEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kke-0001El-7u; Wed, 24 Sep 2025 10:21:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-000Dw3-0A;
	Wed, 24 Sep 2025 10:21:23 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7EDEA478884;
	Wed, 24 Sep 2025 08:21:08 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 16/48] can: rcar_can: BCR bitfield conversion
Date: Wed, 24 Sep 2025 10:06:33 +0200
Message-ID: <20250924082104.595459-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

Convert CAN Bit Configuration Register field accesses to use the
FIELD_PREP() bitfield access macro.  While at it, fix the misspelling of
BRP.

This gets rid of custom function-like field preparation macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/01cfaedba2be22515ba8700893ea7f113df959c0.1755857536.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 6f28dc935451..4c5c1f044691 100644
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
2.51.0


