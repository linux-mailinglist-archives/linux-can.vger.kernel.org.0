Return-Path: <linux-can+bounces-3747-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ACBACADA4
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 13:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF5E164E88
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 11:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC571F4E3B;
	Mon,  2 Jun 2025 11:54:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B2E14F70;
	Mon,  2 Jun 2025 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865291; cv=none; b=DI24xpGUT4vNCnOmFHfPoaWWp7k3MjUD6pmpiVLkZa59bhB1dUn8D/j/jIpCHsfPIh9tF7/H19ZtZXVvNGUooYNgP4ZxHIHS0VfCQSpJNa2kSbXgCzwDjnt59pKe+eQeIXrDhaKkcKtji4OjUMUuxfj4XrIy2JnwFJWqOEgc0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865291; c=relaxed/simple;
	bh=Q+NJx5M3lXiOHDP9YkTSMeSNTtdv2DWCMoJrNP5aujY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiWl7COLIOa4STyFZ8Vx/RRqYkYcPZ7WyXFUzbxNYv/+4R7PPBEVMMXhRmq4nDILCMG4XHmTfn9koq8VOOxdgtSJ8RaqH5GQA+Du9mDyQYK6Zy4pTLQ+FbJh2R44vpFMkjkzAVvlPgp6sM2NoDNBsqRiwx8pBnk7kY1BUUsjE88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7A2C4CEEB;
	Mon,  2 Jun 2025 11:54:49 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6/9] can: rcar_canfd: Repurpose f_dcfg base for other registers
Date: Mon,  2 Jun 2025 13:54:25 +0200
Message-ID: <f9c114fcf8cc8eaae150a3ce95dd3224cf247f6b.1748863848.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748863848.git.geert+renesas@glider.be>
References: <cover.1748863848.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reuse the existing Channel Data Bitrate Configuration Register offset
member in the register configuration as the base offset for all related
channel-specific registers.
Rename the member and update the (incorrect) comment to reflect this.

This fixes the addresses of all other (currently unused)
channel-specific registers on R-Car Gen4 and RZ/G3E, and allows us to
replace RCANFD_GEN4_FDCFG() by the more generic RCANFD_F_CFDCFG().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_canfd.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 0cad3c198e58e494..7a9a88fa5fb1a521 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -425,18 +425,16 @@
 #define RCANFD_C_RPGACC(r)		(0x1900 + (0x04 * (r)))
 
 /* R-Car Gen4 Classical and CAN FD mode specific register map */
-#define RCANFD_GEN4_FDCFG(m)		(0x1404 + (0x20 * (m)))
-
 #define RCANFD_GEN4_GAFL_OFFSET		(0x1800)
 
 /* CAN FD mode specific register map */
 
 /* RSCFDnCFDCmXXX -> RCANFD_F_XXX(m) */
-#define RCANFD_F_DCFG(gpriv, m)		((gpriv)->info->regs->f_dcfg + (0x20 * (m)))
-#define RCANFD_F_CFDCFG(m)		(0x0504 + (0x20 * (m)))
-#define RCANFD_F_CFDCTR(m)		(0x0508 + (0x20 * (m)))
-#define RCANFD_F_CFDSTS(m)		(0x050c + (0x20 * (m)))
-#define RCANFD_F_CFDCRC(m)		(0x0510 + (0x20 * (m)))
+#define RCANFD_F_DCFG(gpriv, m)		((gpriv)->info->regs->coffset + 0x00 + (0x20 * (m)))
+#define RCANFD_F_CFDCFG(gpriv, m)	((gpriv)->info->regs->coffset + 0x04 + (0x20 * (m)))
+#define RCANFD_F_CFDCTR(gpriv, m)	((gpriv)->info->regs->coffset + 0x08 + (0x20 * (m)))
+#define RCANFD_F_CFDSTS(gpriv, m)	((gpriv)->info->regs->coffset + 0x0c + (0x20 * (m)))
+#define RCANFD_F_CFDCRC(gpriv, m)	((gpriv)->info->regs->coffset + 0x10 + (0x20 * (m)))
 
 /* RSCFDnCFDGAFLXXXj offset */
 #define RCANFD_F_GAFL_OFFSET		(0x1000)
@@ -510,7 +508,7 @@ struct rcar_canfd_regs {
 	u16 cfcc;	/* Common FIFO Configuration/Control Register */
 	u16 cfsts;	/* Common FIFO Status Register */
 	u16 cfpctr;	/* Common FIFO Pointer Control Register */
-	u16 f_dcfg;	/* Global FD Configuration Register */
+	u16 coffset;	/* Channel Data Bitrate Configuration Register */
 	u16 rfoffset;	/* Receive FIFO buffer access ID register */
 	u16 cfoffset;	/* Transmit/receive FIFO buffer access ID register */
 };
@@ -641,7 +639,7 @@ static const struct rcar_canfd_regs rcar_gen3_regs = {
 	.cfcc = 0x0118,
 	.cfsts = 0x0178,
 	.cfpctr = 0x01d8,
-	.f_dcfg = 0x0500,
+	.coffset = 0x0500,
 	.rfoffset = 0x3000,
 	.cfoffset = 0x3400,
 };
@@ -651,7 +649,7 @@ static const struct rcar_canfd_regs rcar_gen4_regs = {
 	.cfcc = 0x0120,
 	.cfsts = 0x01e0,
 	.cfpctr = 0x0240,
-	.f_dcfg = 0x1400,
+	.coffset = 0x1400,
 	.rfoffset = 0x6000,
 	.cfoffset = 0x6400,
 };
@@ -827,8 +825,8 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 
 		for_each_set_bit(ch, &gpriv->channels_mask,
 				 gpriv->info->max_channels)
-			rcar_canfd_set_bit(gpriv->base, RCANFD_GEN4_FDCFG(ch),
-					   val);
+			rcar_canfd_set_bit(gpriv->base,
+					   RCANFD_F_CFDCFG(gpriv, ch), val);
 	} else {
 		if (gpriv->fdmode)
 			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
-- 
2.43.0


