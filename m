Return-Path: <linux-can+bounces-3867-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7AFAE0274
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 12:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4EB5A0D87
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 10:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDE52206AC;
	Thu, 19 Jun 2025 10:15:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5ED21C173;
	Thu, 19 Jun 2025 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328105; cv=none; b=jPd6sxfzg0RumWakaaXeOgUL7AuZJb/7JvfUD/QKlYWcJ319/hTqvkhfM/FOiff//VLqjsE6LO3QdetuydbrbWEVRT46CEa27hoCOS3ELs735edTnELN47UfesK76BoHjJgG4mTKkXRe3UABOO4qZn1hpNM0P/gz9zwykigyGT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328105; c=relaxed/simple;
	bh=pT6hB6Nrq5owCQZtZEHrrIUhVt0S7k4iIMEs8q7KV4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOIx+M4BZ7qeS6B79C+vNqT+6E5roNQ2Xi3STXX1iURr0ldY9CQwcVgA8/D9ljy2Z97kA9Z6YCbyOK4w3OfagOQnrHQAhD0tB9qnikhlvmN9tHwyQ0zDvBlwuLt2wiSN2p44fF3YuKztudhyjJlwSZrwCteELb2/V51SLie5FcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A90C4CEEA;
	Thu, 19 Jun 2025 10:15:02 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] can: rcar_canfd: Describe channel-specific FD registers using C struct
Date: Thu, 19 Jun 2025 12:13:17 +0200
Message-ID: <292b75b3bc8dd95f805f0223f606737071c8cf86.1750327217.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcar_canfd_f_*() inline functions to obtain channel-specific CAN-FD
register offsets really describe a memory layout.  Hence replace them by
a C structure, to simplify the code, and reduce kernel size.

This also gets rid of warnings about unused rcar_canfd_f_*() inline
functions, which are reported by recent versions of clang.

Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/20250618183827.5bebca8f@kernel.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Fast-tracked because of the clang warnings.

Changes compared to Vincent's original suggestion
(https://lore.kernel.org/420d37b1-5648-4209-8d6f-1ac9d780eea2@wanadoo.fr):
  - Move rcar_canfd_f to the old RCANFD_F_*() location,
  - Update RSCFDnCFDCmXXX comment.
  - Rename struct rcar_canfd_f to struct rcar_canfd_f,
  - Rename cbase to fcbase,
  - Drop static_assert(),
  - Drop unused car_canfd_*_reg() functions.
  - Drop simple wrappers around {read,write}l(),
---
 drivers/net/can/rcar/rcar_canfd.c | 64 +++++++++++++------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 3dcc977affe89df1..8a9f288187e0e8b6 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -439,6 +439,16 @@
 
 /* CAN FD mode specific register map */
 
+/* RSCFDnCFDCmXXX -> gpriv->fcbase[m].xxx */
+struct rcar_canfd_f_c {
+	u32 dcfg;
+	u32 cfdcfg;
+	u32 cfdctr;
+	u32 cfdsts;
+	u32 cfdcrc;
+	u32 pad[3];
+};
+
 /* RSCFDnCFDGAFLXXXj offset */
 #define RCANFD_F_GAFL_OFFSET		(0x1000)
 
@@ -564,6 +574,7 @@ struct rcar_canfd_channel {
 struct rcar_canfd_global {
 	struct rcar_canfd_channel *ch[RCANFD_NUM_CHANNELS];
 	void __iomem *base;		/* Register base address */
+	struct rcar_canfd_f_c __iomem *fcbase;
 	struct platform_device *pdev;	/* Respective platform device */
 	struct clk *clkp;		/* Peripheral clock */
 	struct clk *can_clk;		/* fCAN clock */
@@ -803,6 +814,16 @@ static void rcar_canfd_update_bit(void __iomem *base, u32 reg,
 	rcar_canfd_update(mask, val, base + reg);
 }
 
+static void rcar_canfd_set_bit_reg(void __iomem *addr, u32 val)
+{
+	rcar_canfd_update(val, val, addr);
+}
+
+static void rcar_canfd_update_bit_reg(void __iomem *addr, u32 mask, u32 val)
+{
+	rcar_canfd_update(mask, val, addr);
+}
+
 static void rcar_canfd_get_data(struct rcar_canfd_channel *priv,
 				struct canfd_frame *cf, u32 off)
 {
@@ -825,37 +846,6 @@ static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
 		rcar_canfd_write(priv->base, off + i * sizeof(u32), data[i]);
 }
 
-/* RSCFDnCFDCmXXX -> rcar_canfd_f_xxx(gpriv, ch) */
-static inline unsigned int rcar_canfd_f_dcfg(struct rcar_canfd_global *gpriv,
-					     unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x00 + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdcfg(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x04 + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdctr(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x08 + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdsts(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x0c + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdcrc(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x10 + 0x20 * ch;
-}
-
 static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 {
 	u32 i;
@@ -883,8 +873,7 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 
 		for_each_set_bit(ch, &gpriv->channels_mask,
 				 gpriv->info->max_channels)
-			rcar_canfd_set_bit(gpriv->base,
-					   rcar_canfd_f_cfdcfg(gpriv, ch), val);
+			rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg, val);
 	} else {
 		if (gpriv->fdmode)
 			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
@@ -1533,7 +1522,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
 	       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
-	rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
+	writel(cfg, &gpriv->fcbase[ch].dcfg);
 
 	/* Transceiver Delay Compensation */
 	if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO) {
@@ -1546,8 +1535,8 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		tdco = min(tdc->tdcv + tdc->tdco, tdc_const->tdco_max) - 1;
 	}
 
-	rcar_canfd_update_bit(gpriv->base, rcar_canfd_f_cfdcfg(gpriv, ch), mask,
-			      tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
+	rcar_canfd_update_bit_reg(&gpriv->fcbase[ch].cfdcfg, mask,
+				  tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
 }
 
 static int rcar_canfd_start(struct net_device *ndev)
@@ -1861,7 +1850,7 @@ static int rcar_canfd_rx_poll(struct napi_struct *napi, int quota)
 static unsigned int rcar_canfd_get_tdcr(struct rcar_canfd_global *gpriv,
 					unsigned int ch)
 {
-	u32 sts = rcar_canfd_read(gpriv->base, rcar_canfd_f_cfdsts(gpriv, ch));
+	u32 sts = readl(&gpriv->fcbase[ch].cfdsts);
 	u32 tdcr = FIELD_GET(RCANFD_FDSTS_TDCR, sts);
 
 	return tdcr & (gpriv->info->tdc_const->tdcv_max - 1);
@@ -2170,6 +2159,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		goto fail_dev;
 	}
 	gpriv->base = addr;
+	gpriv->fcbase = addr + gpriv->info->regs->coffset;
 
 	/* Request IRQ that's common for both channels */
 	if (info->shared_global_irqs) {
-- 
2.43.0


