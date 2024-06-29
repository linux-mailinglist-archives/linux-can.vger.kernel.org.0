Return-Path: <linux-can+bounces-904-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B195891CC77
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 13:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D3F1F2219E
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 11:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9811F59148;
	Sat, 29 Jun 2024 11:40:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79DB4D9FB
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719661227; cv=none; b=MngUnDEcU6k8a3OB/RqsP/Bfx68v2XfoK2Mb5dSjEini7Xvxfj3781ArvaEC4mrujpyWi48ntTq2+CTLza7v1g72jTEQLvytC2P4KVTQF+Bj/UOCxavh24RUVMh0oC/R/70hfxpbFNFI75c1z2x7skt79tVQ8Iq3fh27Y7N9yZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719661227; c=relaxed/simple;
	bh=g9DYHA9n/mS/01ocSc8ZuYgyvsNrXlDHFOkXI35SmPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApfcHlNJVG67XpEEjUsVBgkZ33uZp05EIll+NZpo7EJ7FR2dCgL35/yxVPxwOvHMOesYvVLSiVzrmfJJR4ezMHZOY0xPrpC4dUOtVwgGpG7zeLKDGR2rCms/Be3sJd48gads2SHOVLew9VqPHl6yGLTXZi7F7+S39+/EvUt7CuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRK-00034v-FG
	for linux-can@vger.kernel.org; Sat, 29 Jun 2024 13:40:22 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRJ-005pXl-JY
	for linux-can@vger.kernel.org; Sat, 29 Jun 2024 13:40:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3E8E32F6455
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 11:40:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5BEDB2F642F;
	Sat, 29 Jun 2024 11:40:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a8328be3;
	Sat, 29 Jun 2024 11:40:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/14] can: rcar_canfd: Simplify clock handling
Date: Sat, 29 Jun 2024 13:36:15 +0200
Message-ID: <20240629114017.1080160-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240629114017.1080160-1-mkl@pengutronix.de>
References: <20240629114017.1080160-1-mkl@pengutronix.de>
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

The main CAN clock is either the internal CANFD clock, or the external
CAN clock.  Hence replace the two-valued enum by a simple boolean flag.
Consolidate all CANFD clock handling inside a single branch.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/2cf38c10b83c8e5c04d68b17a930b6d9dbf66f40.1716973640.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index b82842718735..474840b58e8f 100644
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

base-commit: 94833addfaba89d12e5dbd82e350a692c00648ab
-- 
2.43.0



