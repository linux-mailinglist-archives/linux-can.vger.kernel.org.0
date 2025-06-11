Return-Path: <linux-can+bounces-3816-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE83FAD5ABA
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 17:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C3D3A7422
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35BB1D79A5;
	Wed, 11 Jun 2025 15:38:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8D1ABEA5;
	Wed, 11 Jun 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656282; cv=none; b=isaGw+BOsmerE/sNraj64KQEmsD5XPe+hoBqY8QGVlYj1KPdxNiGDRg91soyiC2L1VZUw4GB449X60kPxikmmBOUX/7ACTl2+F8gGAO61yCSOiJ2na+u+aLazBcbKVbmuw2UYqLx07bk2L/yhbPV5+KHYKNwY3uffxkND45ZcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656282; c=relaxed/simple;
	bh=Oi0cZ1GcrhhVEn7qKVeECRc2sbPzZyILqO8LTiO4f4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtq0JuXXJsSirRJkbZ3VUtoQGzzpteP2rYa9DWaDSGv3TeFeGVKmaHXTGbyS8vTK08gDlQrkHhwvUQyXaTFnNcAtX1nHEUQ27RcO1Axx4vrBELN3KzPqBK6z5ydLYRNXiXoA/pUwAPClUrXtYF+Bz8Elo/jSitLVcRGkN2lEopE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C87C4CEEA;
	Wed, 11 Jun 2025 15:38:00 +0000 (UTC)
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
Subject: [PATCH v2 06/10] can: rcar_canfd: Repurpose f_dcfg base for other registers
Date: Wed, 11 Jun 2025 17:37:35 +0200
Message-ID: <75c8197c849fc9e360a75d4fa55bc01c1d850433.1749655315.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749655315.git.geert+renesas@glider.be>
References: <cover.1749655315.git.geert+renesas@glider.be>
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
Replace the function-like channel-specific register offset macros by
inline functions.

This fixes the offsets of all other (currently unused) channel-specific
registers on R-Car Gen4 and RZ/G3E, and allows us to replace
RCANFD_GEN4_FDCFG() by the more generic rcar_canfd_f_cfdcfg().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
v2:
  - Add Reviewed-by.
  - Replace function-like macros by inline functions,
  - s/addresses/offsets/.
---
 drivers/net/can/rcar/rcar_canfd.c | 52 ++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index dded509793bb93ec..8baf8a928da757f2 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -425,19 +425,10 @@
 #define RCANFD_C_RPGACC(r)		(0x1900 + (0x04 * (r)))
 
 /* R-Car Gen4 Classical and CAN FD mode specific register map */
-#define RCANFD_GEN4_FDCFG(m)		(0x1404 + (0x20 * (m)))
-
 #define RCANFD_GEN4_GAFL_OFFSET		(0x1800)
 
 /* CAN FD mode specific register map */
 
-/* RSCFDnCFDCmXXX -> RCANFD_F_XXX(m) */
-#define RCANFD_F_DCFG(gpriv, m)		((gpriv)->info->regs->f_dcfg + (0x20 * (m)))
-#define RCANFD_F_CFDCFG(m)		(0x0504 + (0x20 * (m)))
-#define RCANFD_F_CFDCTR(m)		(0x0508 + (0x20 * (m)))
-#define RCANFD_F_CFDSTS(m)		(0x050c + (0x20 * (m)))
-#define RCANFD_F_CFDCRC(m)		(0x0510 + (0x20 * (m)))
-
 /* RSCFDnCFDGAFLXXXj offset */
 #define RCANFD_F_GAFL_OFFSET		(0x1000)
 
@@ -510,7 +501,7 @@ struct rcar_canfd_regs {
 	u16 cfcc;	/* Common FIFO Configuration/Control Register */
 	u16 cfsts;	/* Common FIFO Status Register */
 	u16 cfpctr;	/* Common FIFO Pointer Control Register */
-	u16 f_dcfg;	/* Global FD Configuration Register */
+	u16 coffset;	/* Channel Data Bitrate Configuration Register */
 	u16 rfoffset;	/* Receive FIFO buffer access ID register */
 	u16 cfoffset;	/* Transmit/receive FIFO buffer access ID register */
 };
@@ -641,7 +632,7 @@ static const struct rcar_canfd_regs rcar_gen3_regs = {
 	.cfcc = 0x0118,
 	.cfsts = 0x0178,
 	.cfpctr = 0x01d8,
-	.f_dcfg = 0x0500,
+	.coffset = 0x0500,
 	.rfoffset = 0x3000,
 	.cfoffset = 0x3400,
 };
@@ -651,7 +642,7 @@ static const struct rcar_canfd_regs rcar_gen4_regs = {
 	.cfcc = 0x0120,
 	.cfsts = 0x01e0,
 	.cfpctr = 0x0240,
-	.f_dcfg = 0x1400,
+	.coffset = 0x1400,
 	.rfoffset = 0x6000,
 	.cfoffset = 0x6400,
 };
@@ -800,6 +791,37 @@ static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
 		rcar_canfd_write(priv->base, off + i * sizeof(u32), data[i]);
 }
 
+/* RSCFDnCFDCmXXX -> rcar_canfd_f_xxx(gpriv, ch) */
+static inline unsigned int rcar_canfd_f_dcfg(struct rcar_canfd_global *gpriv,
+					     unsigned int ch)
+{
+	return gpriv->info->regs->coffset + 0x00 + 0x20 * ch;
+}
+
+static inline unsigned int rcar_canfd_f_cfdcfg(struct rcar_canfd_global *gpriv,
+					       unsigned int ch)
+{
+	return gpriv->info->regs->coffset + 0x04 + 0x20 * ch;
+}
+
+static inline unsigned int rcar_canfd_f_cfdctr(struct rcar_canfd_global *gpriv,
+					       unsigned int ch)
+{
+	return gpriv->info->regs->coffset + 0x08 + 0x20 * ch;
+}
+
+static inline unsigned int rcar_canfd_f_cfdsts(struct rcar_canfd_global *gpriv,
+					       unsigned int ch)
+{
+	return gpriv->info->regs->coffset + 0x0c + 0x20 * ch;
+}
+
+static inline unsigned int rcar_canfd_f_cfdcrc(struct rcar_canfd_global *gpriv,
+					       unsigned int ch)
+{
+	return gpriv->info->regs->coffset + 0x10 + 0x20 * ch;
+}
+
 static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 {
 	u32 i;
@@ -827,8 +849,8 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 
 		for_each_set_bit(ch, &gpriv->channels_mask,
 				 gpriv->info->max_channels)
-			rcar_canfd_set_bit(gpriv->base, RCANFD_GEN4_FDCFG(ch),
-					   val);
+			rcar_canfd_set_bit(gpriv->base,
+					   rcar_canfd_f_cfdcfg(gpriv, ch), val);
 	} else {
 		if (gpriv->fdmode)
 			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
@@ -1468,7 +1490,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
 		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
-		rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
+		rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
 	} else {
 		/* Classical CAN only mode */
 		if (gpriv->info->shared_can_regs) {
-- 
2.43.0


