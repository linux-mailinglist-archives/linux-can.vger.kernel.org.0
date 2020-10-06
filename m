Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843E9285342
	for <lists+linux-can@lfdr.de>; Tue,  6 Oct 2020 22:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgJFUh6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Oct 2020 16:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgJFUh6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Oct 2020 16:37:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CAEC061755
        for <linux-can@vger.kernel.org>; Tue,  6 Oct 2020 13:37:58 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kPtie-0002n3-BK; Tue, 06 Oct 2020 22:37:56 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 14/17] can: flexcan: remove ack_grp and ack_bit handling from driver
Date:   Tue,  6 Oct 2020 22:37:45 +0200
Message-Id: <20201006203748.1750156-15-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006203748.1750156-1-mkl@pengutronix.de>
References: <20201006203748.1750156-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since commit:

    048e3a34a2e7 can: flexcan: poll MCR_LPM_ACK instead of GPR ACK for stop mode acknowledgment

the driver polls the IP core's internal bit MCR[LPM_ACK] as stop mode
acknowledge and not the acknowledgment on chip level.

This means the 4th and 5th value of the property "fsl,stop-mode" isn't used
anymore. This patch removes the used "ack_gpr" and "ack_bit" from the driver.

Fixes: 048e3a34a2e7 ("can: flexcan: poll MCR_LPM_ACK instead of GPR ACK for stop mode acknowledgment")
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index fbdd9a8c9374..4d594e977497 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -333,8 +333,6 @@ struct flexcan_stop_mode {
 	struct regmap *gpr;
 	u8 req_gpr;
 	u8 req_bit;
-	u8 ack_gpr;
-	u8 ack_bit;
 };
 
 struct flexcan_priv {
@@ -1847,14 +1845,14 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 	struct device_node *gpr_np;
 	struct flexcan_priv *priv;
 	phandle phandle;
-	u32 out_val[5];
+	u32 out_val[3];
 	int ret;
 
 	if (!np)
 		return -EINVAL;
 
 	/* stop mode property format is:
-	 * <&gpr req_gpr req_bit ack_gpr ack_bit>.
+	 * <&gpr req_gpr>.
 	 */
 	ret = of_property_read_u32_array(np, "fsl,stop-mode", out_val,
 					 ARRAY_SIZE(out_val));
@@ -1880,13 +1878,10 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 
 	priv->stm.req_gpr = out_val[1];
 	priv->stm.req_bit = out_val[2];
-	priv->stm.ack_gpr = out_val[3];
-	priv->stm.ack_bit = out_val[4];
 
 	dev_dbg(&pdev->dev,
-		"gpr %s req_gpr=0x02%x req_bit=%u ack_gpr=0x02%x ack_bit=%u\n",
-		gpr_np->full_name, priv->stm.req_gpr, priv->stm.req_bit,
-		priv->stm.ack_gpr, priv->stm.ack_bit);
+		"gpr %s req_gpr=0x02%x req_bit=%u\n",
+		gpr_np->full_name, priv->stm.req_gpr, priv->stm.req_bit);
 
 	device_set_wakeup_capable(&pdev->dev, true);
 
-- 
2.28.0

