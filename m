Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C669758EDB
	for <lists+linux-can@lfdr.de>; Wed, 19 Jul 2023 09:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjGSHYf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Jul 2023 03:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGSHYd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Jul 2023 03:24:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A631997
        for <linux-can@vger.kernel.org>; Wed, 19 Jul 2023 00:24:32 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qM1Xy-0002qa-Fk
        for linux-can@vger.kernel.org; Wed, 19 Jul 2023 09:24:30 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4FF811F4C61
        for <linux-can@vger.kernel.org>; Wed, 19 Jul 2023 07:23:52 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9662B1F4C14;
        Wed, 19 Jul 2023 07:23:50 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d626ed38;
        Wed, 19 Jul 2023 07:23:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 4/8] can: xilinx_can: Add support for controller reset
Date:   Wed, 19 Jul 2023 09:23:44 +0200
Message-Id: <20230719072348.525039-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719072348.525039-1-mkl@pengutronix.de>
References: <20230719072348.525039-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Srinivas Neeli <srinivas.neeli@amd.com>

Add support for an optional reset for the CAN controller using the reset
driver. If the CAN node contains the "resets" property, then this logic
will perform CAN controller reset.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Link: https://lore.kernel.org/all/ab7e6503aa3343e39ead03c1797e765be6c50de2.1689164442.git.michal.simek@amd.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 4d3283db3a13..abe58f103043 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -30,6 +30,7 @@
 #include <linux/can/error.h>
 #include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 #define DRIVER_NAME	"xilinx_can"
 
@@ -200,6 +201,7 @@ struct xcan_devtype_data {
  * @can_clk:			Pointer to struct clk
  * @devtype:			Device type specific constants
  * @transceiver:		Optional pointer to associated CAN transceiver
+ * @rstc:			Pointer to reset control
  */
 struct xcan_priv {
 	struct can_priv can;
@@ -218,6 +220,7 @@ struct xcan_priv {
 	struct clk *can_clk;
 	struct xcan_devtype_data devtype;
 	struct phy *transceiver;
+	struct reset_control *rstc;
 };
 
 /* CAN Bittiming constants as per Xilinx CAN specs */
@@ -1799,6 +1802,16 @@ static int xcan_probe(struct platform_device *pdev)
 	priv->can.do_get_berr_counter = xcan_get_berr_counter;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 					CAN_CTRLMODE_BERR_REPORTING;
+	priv->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(priv->rstc)) {
+		dev_err(&pdev->dev, "Cannot get CAN reset.\n");
+		ret = PTR_ERR(priv->rstc);
+		goto err_free;
+	}
+
+	ret = reset_control_reset(priv->rstc);
+	if (ret)
+		goto err_free;
 
 	if (devtype->cantype == XAXI_CANFD) {
 		priv->can.data_bittiming_const =
@@ -1827,7 +1840,7 @@ static int xcan_probe(struct platform_device *pdev)
 	/* Get IRQ for the device */
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto err_free;
+		goto err_reset;
 
 	ndev->irq = ret;
 
@@ -1843,21 +1856,21 @@ static int xcan_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->can_clk)) {
 		ret = dev_err_probe(&pdev->dev, PTR_ERR(priv->can_clk),
 				    "device clock not found\n");
-		goto err_free;
+		goto err_reset;
 	}
 
 	priv->bus_clk = devm_clk_get(&pdev->dev, devtype->bus_clk_name);
 	if (IS_ERR(priv->bus_clk)) {
 		ret = dev_err_probe(&pdev->dev, PTR_ERR(priv->bus_clk),
 				    "bus clock not found\n");
-		goto err_free;
+		goto err_reset;
 	}
 
 	transceiver = devm_phy_optional_get(&pdev->dev, NULL);
 	if (IS_ERR(transceiver)) {
 		ret = PTR_ERR(transceiver);
 		dev_err_probe(&pdev->dev, ret, "failed to get phy\n");
-		goto err_free;
+		goto err_reset;
 	}
 	priv->transceiver = transceiver;
 
@@ -1904,6 +1917,8 @@ static int xcan_probe(struct platform_device *pdev)
 err_disableclks:
 	pm_runtime_put(priv->dev);
 	pm_runtime_disable(&pdev->dev);
+err_reset:
+	reset_control_assert(priv->rstc);
 err_free:
 	free_candev(ndev);
 err:
@@ -1920,9 +1935,11 @@ static int xcan_probe(struct platform_device *pdev)
 static void xcan_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct xcan_priv *priv = netdev_priv(ndev);
 
 	unregister_candev(ndev);
 	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(priv->rstc);
 	free_candev(ndev);
 }
 
-- 
2.40.1


