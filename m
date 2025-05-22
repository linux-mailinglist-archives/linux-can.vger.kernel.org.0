Return-Path: <linux-can+bounces-3654-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8542AC0771
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 10:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6F2171FDA
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381F728980B;
	Thu, 22 May 2025 08:41:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1314288C9F
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903308; cv=none; b=Grs5mUWR+7YOX+gCh5stVDrciPT8JZO575qg9H9Ex2t7W2rNv9cBzDaQRm4yH+USWiIbwTVADQlt3BHsQ09iyjk8lg4yS/Xcp1Bb9aAN7CREDJTg1KIixSafs2krteW6llbRMvgYRjNQA5NTBWjM6mz+sWO4pXpQf06R2LvlHMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903308; c=relaxed/simple;
	bh=mR/CbT2B690NHbeQPbbrOg/YCnQueZckcxbmNI/0cNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiXIcb3jlEcbwKqHdG3Syw0y2Sp97HLvAJglu6A9ugmNSnIF5pNwwWBGJKyhRQUkJK5iSc3MxJpIzsGfaxt4DNxO4ur7rzw2JapfIPjyop8eZGnNFSrxNgpMIbCBttW4bqleOOk7IHLGYiCT50R7yZokuLSTPwcvZnqyLVOJP+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Um-0006Gr-31
	for linux-can@vger.kernel.org; Thu, 22 May 2025 10:41:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Ui-000hpp-1w
	for linux-can@vger.kernel.org;
	Thu, 22 May 2025 10:41:40 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 4610F41735E
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 10BAE417318;
	Thu, 22 May 2025 08:41:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9787ac62;
	Thu, 22 May 2025 08:41:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 17/22] can: rcar_canfd: Add external_clk variable to struct rcar_canfd_hw_info
Date: Thu, 22 May 2025 10:36:45 +0200
Message-ID: <20250522084128.501049-18-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522084128.501049-1-mkl@pengutronix.de>
References: <20250522084128.501049-1-mkl@pengutronix.de>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

All existing SoCs support an external clock, but RZ/G3E has only internal
clocks. Add external_clk variable to struct rcar_canfd_hw_info to handle
this difference.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-18-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 67f7b5f6376c..0bf0e88dfe25 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -541,6 +541,7 @@ struct rcar_canfd_hw_info {
 	unsigned multi_channel_irqs:1;	/* Has multiple channel irqs */
 	unsigned ch_interface_mode:1;	/* Has channel interface mode */
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
+	unsigned external_clk:1;	/* Has external clock */
 };
 
 /* Channel priv data */
@@ -690,6 +691,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.shared_global_irqs = 1,
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
+	.external_clk = 1,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -705,6 +707,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.shared_global_irqs = 1,
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
+	.external_clk = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -720,6 +723,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.multi_channel_irqs = 1,
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
+	.external_clk = 1,
 };
 
 /* Helper functions */
@@ -2048,7 +2052,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		fcan_freq = clk_get_rate(gpriv->can_clk) / info->postdiv;
 	} else {
 		fcan_freq = clk_get_rate(gpriv->can_clk);
-		gpriv->extclk = true;
+		gpriv->extclk = gpriv->info->external_clk;
 	}
 
 	addr = devm_platform_ioremap_resource(pdev, 0);
-- 
2.47.2



