Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFE273998D
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 10:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjFVI1b (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 04:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjFVI1V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 04:27:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BACC1FD2
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 01:27:07 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qCFej-0002RF-22
        for linux-can@vger.kernel.org; Thu, 22 Jun 2023 10:27:05 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 82C841DF35F
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:27:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 08B7E1DF33A;
        Thu, 22 Jun 2023 08:27:01 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id de0ac061;
        Thu, 22 Jun 2023 08:27:00 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marcel Hellwig <git@cookiesoft.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/33] can: dev: add transceiver capabilities to xilinx_can
Date:   Thu, 22 Jun 2023 10:26:27 +0200
Message-Id: <20230622082658.571150-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622082658.571150-1-mkl@pengutronix.de>
References: <20230622082658.571150-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Marcel Hellwig <git@cookiesoft.de>

Currently the xilinx_can driver does not support adding a phy like the
"ti,tcan1043" to its devicetree.

This code makes it possible to add such phy, so that the kernel makes
sure that the PHY is in operational state, when the link is set to an
"up" state.

Signed-off-by: Marcel Hellwig <git@cookiesoft.de>
Link: https://lore.kernel.org/r/20230417085204.179268-1-git@cookiesoft.de
[mkl: call phy_power_off() after pm_runtime_put()]
[mkl: remove error message for phy_power_on() failure]
[mkl: update kernel-doc for struct xcan_priv]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 797c69a0314d..4d3283db3a13 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
+#include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
 
 #define DRIVER_NAME	"xilinx_can"
@@ -198,6 +199,7 @@ struct xcan_devtype_data {
  * @bus_clk:			Pointer to struct clk
  * @can_clk:			Pointer to struct clk
  * @devtype:			Device type specific constants
+ * @transceiver:		Optional pointer to associated CAN transceiver
  */
 struct xcan_priv {
 	struct can_priv can;
@@ -215,6 +217,7 @@ struct xcan_priv {
 	struct clk *bus_clk;
 	struct clk *can_clk;
 	struct xcan_devtype_data devtype;
+	struct phy *transceiver;
 };
 
 /* CAN Bittiming constants as per Xilinx CAN specs */
@@ -1419,6 +1422,10 @@ static int xcan_open(struct net_device *ndev)
 	struct xcan_priv *priv = netdev_priv(ndev);
 	int ret;
 
+	ret = phy_power_on(priv->transceiver);
+	if (ret)
+		return ret;
+
 	ret = pm_runtime_get_sync(priv->dev);
 	if (ret < 0) {
 		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
@@ -1462,6 +1469,7 @@ static int xcan_open(struct net_device *ndev)
 	free_irq(ndev->irq, ndev);
 err:
 	pm_runtime_put(priv->dev);
+	phy_power_off(priv->transceiver);
 
 	return ret;
 }
@@ -1483,6 +1491,7 @@ static int xcan_close(struct net_device *ndev)
 	close_candev(ndev);
 
 	pm_runtime_put(priv->dev);
+	phy_power_off(priv->transceiver);
 
 	return 0;
 }
@@ -1713,6 +1722,7 @@ static int xcan_probe(struct platform_device *pdev)
 {
 	struct net_device *ndev;
 	struct xcan_priv *priv;
+	struct phy *transceiver;
 	const struct of_device_id *of_id;
 	const struct xcan_devtype_data *devtype = &xcan_axi_data;
 	void __iomem *addr;
@@ -1843,6 +1853,14 @@ static int xcan_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	transceiver = devm_phy_optional_get(&pdev->dev, NULL);
+	if (IS_ERR(transceiver)) {
+		ret = PTR_ERR(transceiver);
+		dev_err_probe(&pdev->dev, ret, "failed to get phy\n");
+		goto err_free;
+	}
+	priv->transceiver = transceiver;
+
 	priv->write_reg = xcan_write_reg_le;
 	priv->read_reg = xcan_read_reg_le;
 
@@ -1869,6 +1887,7 @@ static int xcan_probe(struct platform_device *pdev)
 		goto err_disableclks;
 	}
 
+	of_can_transceiver(ndev);
 	pm_runtime_put(&pdev->dev);
 
 	if (priv->devtype.flags & XCAN_FLAG_CANFD_2) {
-- 
2.40.1


