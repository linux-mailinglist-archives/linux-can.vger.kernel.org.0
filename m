Return-Path: <linux-can+bounces-687-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE018D32AA
	for <lists+linux-can@lfdr.de>; Wed, 29 May 2024 11:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DD0283631
	for <lists+linux-can@lfdr.de>; Wed, 29 May 2024 09:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55B4169361;
	Wed, 29 May 2024 09:12:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88216A378
	for <linux-can@vger.kernel.org>; Wed, 29 May 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716973949; cv=none; b=IM1vNH8a3naxIOunebAVfzvVvyVs8nG7FZksgtX5nvkFkdWA4VVjd53pFAzt8i3Y2+BNfqKsR6cANDMZY47fEDYt8RE42nwun4jGzpHt/3xqNVrKNLA2e8WCkHwjZK78QfHQFV+iHWkEmKm5Zhit/XUUs1WQQpJS1PUCHK7XVaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716973949; c=relaxed/simple;
	bh=Aoeyse/5ysEW/UvrhwpMZ2TkXZT/GadS0r8x0ILWLmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b8AvDQvVXsUKJ4XLnked+xCvsAvGNfidlw+FVV9xHJAN8vwRaY4VfRr759OxJBQ8rWPa1mWRxgfLroG5NZBaqP/xOxiRexIjh7l+AthGQVYVvzgNwSDbkd9y8Y2gAjtn0wT7YQ+hS+W391wDnjSbxJZPsSIiqS4uQ8lpN8E09Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:1b01:1838:131c:4de4])
	by andre.telenet-ops.be with bizsmtp
	id UxCJ2C0013VPV9V01xCJnl; Wed, 29 May 2024 11:12:18 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sCFL5-00GF9V-EB;
	Wed, 29 May 2024 11:12:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sCFM1-008w8Z-Qt;
	Wed, 29 May 2024 11:12:17 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] can: rcar_canfd: Simplify clock handling
Date: Wed, 29 May 2024 11:12:13 +0200
Message-Id: <2cf38c10b83c8e5c04d68b17a930b6d9dbf66f40.1716973640.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716973640.git.geert+renesas@glider.be>
References: <cover.1716973640.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main CAN clock is either the internal CANFD clock, or the external
CAN clock.  Hence replace the two-valued enum by a simple boolean flag.
Consolidate all CANFD clock handling inside a single branch.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_canfd.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index b828427187353d6f..474840b58e8f13f1 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -508,12 +508,6 @@
  */
 #define RCANFD_CFFIFO_IDX		0
 
-/* fCAN clock select register settings */
-enum rcar_canfd_fcanclk {
-	RCANFD_CANFDCLK = 0,		/* CANFD clock */
-	RCANFD_EXTCLK,			/* Externally input clock */
-};
-
 struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
@@ -545,8 +539,8 @@ struct rcar_canfd_global {
 	struct platform_device *pdev;	/* Respective platform device */
 	struct clk *clkp;		/* Peripheral clock */
 	struct clk *can_clk;		/* fCAN clock */
-	enum rcar_canfd_fcanclk fcan;	/* CANFD or Ext clock */
 	unsigned long channels_mask;	/* Enabled channels mask */
+	bool extclk;			/* CANFD or Ext clock */
 	bool fdmode;			/* CAN FD or Classical CAN only mode */
 	struct reset_control *rstc1;
 	struct reset_control *rstc2;
@@ -777,7 +771,7 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
 		cfg |= RCANFD_GCFG_CMPOC;
 
 	/* Set External Clock if selected */
-	if (gpriv->fcan != RCANFD_CANFDCLK)
+	if (gpriv->extclk)
 		cfg |= RCANFD_GCFG_DCS;
 
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCFG, cfg);
@@ -1941,16 +1935,12 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 			return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
 					     "cannot get canfd clock\n");
 
-		gpriv->fcan = RCANFD_CANFDCLK;
-
+		/* CANFD clock may be further divided within the IP */
+		fcan_freq = clk_get_rate(gpriv->can_clk) / info->postdiv;
 	} else {
-		gpriv->fcan = RCANFD_EXTCLK;
+		fcan_freq = clk_get_rate(gpriv->can_clk);
+		gpriv->extclk = true;
 	}
-	fcan_freq = clk_get_rate(gpriv->can_clk);
-
-	if (gpriv->fcan == RCANFD_CANFDCLK)
-		/* CANFD clock is further divided by (1/2) within the IP */
-		fcan_freq /= info->postdiv;
 
 	addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(addr)) {
@@ -2060,7 +2050,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gpriv);
 	dev_info(dev, "global operational state (clk %d, fdmode %d)\n",
-		 gpriv->fcan, gpriv->fdmode);
+		 gpriv->extclk, gpriv->fdmode);
 	return 0;
 
 fail_channel:
-- 
2.34.1


