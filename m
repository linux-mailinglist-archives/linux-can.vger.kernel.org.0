Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05E5274486
	for <lists+linux-can@lfdr.de>; Tue, 22 Sep 2020 16:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgIVOoi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Sep 2020 10:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgIVOoh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Sep 2020 10:44:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B08C0613CF
        for <linux-can@vger.kernel.org>; Tue, 22 Sep 2020 07:44:37 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKjX1-0001FU-Rh; Tue, 22 Sep 2020 16:44:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, michael@walle.cc, qiangqing.zhang@nxp.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 07/20] can: flexcan: flexcan_probe(): make regulator xceiver optional
Date:   Tue, 22 Sep 2020 16:44:16 +0200
Message-Id: <20200922144429.2613631-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922144429.2613631-1-mkl@pengutronix.de>
References: <20200922144429.2613631-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

As the transcevier regulator is optional, this patch switches from
devm_regulator_get() to devm_regulator_get_optional(). This gets rid of "using
dummy regulator" warning message from the regulator core, if no regulator is
available.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 06cddc468739..52b53ff223f4 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1579,11 +1579,13 @@ static int flexcan_probe(struct platform_device *pdev)
 	u8 clk_src = 1;
 	u32 clock_freq = 0;
 
-	reg_xceiver = devm_regulator_get(&pdev->dev, "xceiver");
+	reg_xceiver = devm_regulator_get_optional(&pdev->dev, "xceiver");
 	if (PTR_ERR(reg_xceiver) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
-	else if (IS_ERR(reg_xceiver))
+	else if (PTR_ERR(reg_xceiver) == -ENODEV)
 		reg_xceiver = NULL;
+	else if (IS_ERR(reg_xceiver))
+		return PTR_ERR(reg_xceiver);
 
 	if (pdev->dev.of_node) {
 		of_property_read_u32(pdev->dev.of_node,
-- 
2.28.0

