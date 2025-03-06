Return-Path: <linux-can+bounces-3008-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0460A54B1A
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 13:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BF43AFD2C
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F4E1C7017;
	Thu,  6 Mar 2025 12:43:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00130190051;
	Thu,  6 Mar 2025 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265010; cv=none; b=p0KGQ19CzO7euURbWDHbQmNm3t6li2B7LGLpHHELO1j2Pmr3GNW+ckNRIE9EphBLnQLpKKj8kmAvtPkJUrYZUF2akeX++8k5SYVvlCJrNLuvbwKNWn1nOw+hr1SpvDcplBFkZemWnFXAEIHpNDB+3KTAfKN3aRLg0BcIjqoNcZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265010; c=relaxed/simple;
	bh=MwOzccAf4clXEktLBkTrxdkTijU7cbFcl77ecHfSH2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjQmlpjnMn+2Zgkpmh6vpZsTFKd5DYNEgNVNV42OpphlGPextEG2+OyomppqN/8VXk36b57P076r5AOIRjfzc5rH0bE18JQnL1CKfut9iKUImUqejbT7DdzIko/q3ZyjCtvW2tt9Vu+UfHqM03b+CfNZR65JBsHELf454q2QOYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: EJolJ6rJR5SK87a93hZuzA==
X-CSE-MsgGUID: uwDVmV1+THWlYdfWKxWOGg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Mar 2025 21:43:28 +0900
Received: from localhost.localdomain (unknown [10.226.92.10])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5E53D4281B03;
	Thu,  6 Mar 2025 21:43:25 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-can@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 06/11] can: rcar_canfd: Add register mapping table to struct rcar_canfd_hw_info
Date: Thu,  6 Mar 2025 12:42:45 +0000
Message-ID: <20250306124256.93033-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

R-Car Gen3 and Gen4 has some differences in the register offsets. Add a
mapping table to handle these differences.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Added prefix RCANFD_* to enum rcar_canfd_reg_offset_id.
v3:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 48 ++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index f71725da57ce..f7c78b1a2684 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -305,7 +305,7 @@
 #define RCANFD_RMND(y)			(0x00a8 + (0x04 * (y)))
 
 /* RSCFDnCFDRFCCx / RSCFDnRFCCx */
-#define RCANFD_RFCC(gpriv, x)		(reg_gen4(gpriv, 0x00c0, 0x00b8) + (0x04 * (x)))
+#define RCANFD_RFCC(gpriv, x)		((gpriv)->info->regs[RCANFD_RFCC] + (0x04 * (x)))
 /* RSCFDnCFDRFSTSx / RSCFDnRFSTSx */
 #define RCANFD_RFSTS(gpriv, x)		(RCANFD_RFCC(gpriv, x) + 0x20)
 /* RSCFDnCFDRFPCTRx / RSCFDnRFPCTRx */
@@ -315,13 +315,13 @@
 
 /* RSCFDnCFDCFCCx / RSCFDnCFCCx */
 #define RCANFD_CFCC(gpriv, ch, idx) \
-	(reg_gen4(gpriv, 0x0120, 0x0118) + (0x0c * (ch)) + (0x04 * (idx)))
+	((gpriv)->info->regs[RCANFD_CFCC] + (0x0c * (ch)) + (0x04 * (idx)))
 /* RSCFDnCFDCFSTSx / RSCFDnCFSTSx */
 #define RCANFD_CFSTS(gpriv, ch, idx) \
-	(reg_gen4(gpriv, 0x01e0, 0x0178) + (0x0c * (ch)) + (0x04 * (idx)))
+	((gpriv)->info->regs[RCANFD_CFSTS] + (0x0c * (ch)) + (0x04 * (idx)))
 /* RSCFDnCFDCFPCTRx / RSCFDnCFPCTRx */
 #define RCANFD_CFPCTR(gpriv, ch, idx) \
-	(reg_gen4(gpriv, 0x0240, 0x01d8) + (0x0c * (ch)) + (0x04 * (idx)))
+	((gpriv)->info->regs[RCANFD_CFPCTR] + (0x0c * (ch)) + (0x04 * (idx)))
 
 /* RSCFDnCFDFESTS / RSCFDnFESTS */
 #define RCANFD_FESTS			(0x0238)
@@ -437,7 +437,7 @@
 /* CAN FD mode specific register map */
 
 /* RSCFDnCFDCmXXX -> RCANFD_F_XXX(m) */
-#define RCANFD_F_DCFG(gpriv, m)		(reg_gen4(gpriv, 0x1400, 0x0500) + (0x20 * (m)))
+#define RCANFD_F_DCFG(gpriv, m)		((gpriv)->info->regs[RCANFD_F_DCFG] + (0x20 * (m)))
 #define RCANFD_F_CFDCFG(m)		(0x0504 + (0x20 * (m)))
 #define RCANFD_F_CFDCTR(m)		(0x0508 + (0x20 * (m)))
 #define RCANFD_F_CFDSTS(m)		(0x050c + (0x20 * (m)))
@@ -453,7 +453,7 @@
 #define RCANFD_F_RMDF(q, b)		(0x200c + (0x04 * (b)) + (0x20 * (q)))
 
 /* RSCFDnCFDRFXXx -> RCANFD_F_RFXX(x) */
-#define RCANFD_F_RFOFFSET(gpriv)	reg_gen4(gpriv, 0x6000, 0x3000)
+#define RCANFD_F_RFOFFSET(gpriv)	((gpriv)->info->regs[RCANFD_RFOFFSET])
 #define RCANFD_F_RFID(gpriv, x)		(RCANFD_F_RFOFFSET(gpriv) + (0x80 * (x)))
 #define RCANFD_F_RFPTR(gpriv, x)	(RCANFD_F_RFOFFSET(gpriv) + 0x04 + (0x80 * (x)))
 #define RCANFD_F_RFFDSTS(gpriv, x)	(RCANFD_F_RFOFFSET(gpriv) + 0x08 + (0x80 * (x)))
@@ -461,7 +461,7 @@
 	(RCANFD_F_RFOFFSET(gpriv) + 0x0c + (0x80 * (x)) + (0x04 * (df)))
 
 /* RSCFDnCFDCFXXk -> RCANFD_F_CFXX(ch, k) */
-#define RCANFD_F_CFOFFSET(gpriv)	reg_gen4(gpriv, 0x6400, 0x3400)
+#define RCANFD_F_CFOFFSET(gpriv)	((gpriv)->info->regs[RCANFD_CFOFFSET])
 
 #define RCANFD_F_CFID(gpriv, ch, idx) \
 	(RCANFD_F_CFOFFSET(gpriv) + (0x180 * (ch)) + (0x80 * (idx)))
@@ -508,9 +508,20 @@
  */
 #define RCANFD_CFFIFO_IDX		0
 
+enum rcar_canfd_reg_offset_id {
+	RCANFD_RFCC,		/* RX FIFO Configuration/Control Register */
+	RCANFD_CFCC,		/* Common FIFO Configuration/Control Register */
+	RCANFD_CFSTS,		/* Common FIFO Status Register */
+	RCANFD_CFPCTR,		/* Common FIFO Pointer Control Register */
+	RCANFD_F_DCFG,		/* Global FD Configuration Register */
+	RCANFD_RFOFFSET,	/* Receive FIFO buffer access ID register */
+	RCANFD_CFOFFSET,	/* Transmit/receive FIFO buffer access ID register */
+};
+
 struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
+	const u16 *regs;
 	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
@@ -588,13 +599,35 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 	.brp_inc = 1,
 };
 
+static const u16 rcar_gen3_regs[] = {
+	[RCANFD_RFCC] = 0x00b8,
+	[RCANFD_CFCC] = 0x0118,
+	[RCANFD_CFSTS] = 0x0178,
+	[RCANFD_CFPCTR] = 0x01d8,
+	[RCANFD_F_DCFG] = 0x0500,
+	[RCANFD_RFOFFSET] = 0x3000,
+	[RCANFD_CFOFFSET] = 0x3400,
+};
+
+static const u16 rcar_gen4_regs[] = {
+	[RCANFD_RFCC] = 0x00c0,
+	[RCANFD_CFCC] = 0x0120,
+	[RCANFD_CFSTS] = 0x01e0,
+	[RCANFD_CFPCTR] = 0x0240,
+	[RCANFD_F_DCFG] = 0x1400,
+	[RCANFD_RFOFFSET] = 0x6000,
+	[RCANFD_CFOFFSET] = 0x6400,
+};
+
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
+	.regs = rcar_gen3_regs,
 	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
+	.regs = rcar_gen4_regs,
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -603,6 +636,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
+	.regs = rcar_gen3_regs,
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
-- 
2.43.0


