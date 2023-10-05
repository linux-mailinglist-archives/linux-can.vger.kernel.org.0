Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF377BAB01
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 21:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjJET6l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 15:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjJET6a (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 15:58:30 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647D9106
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 12:58:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUL-0004rQ-6o
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:25 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUG-00BLMV-W0
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B701F230063
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 19:58:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 19EB922FFC3;
        Thu,  5 Oct 2023 19:58:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c37ac2b1;
        Thu, 5 Oct 2023 19:58:14 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 26/37] can: at91_can: add CAN transceiver support
Date:   Thu,  5 Oct 2023 21:58:01 +0200
Message-Id: <20231005195812.549776-27-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231005195812.549776-1-mkl@pengutronix.de>
References: <20231005195812.549776-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add support for Linux-PHY based CAN transceivers.

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-16-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index bfe414581fa1..94e9740c80de 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/rtnetlink.h>
 #include <linux/skbuff.h>
@@ -150,6 +151,7 @@ struct at91_devtype_data {
 struct at91_priv {
 	struct can_priv can;		/* must be the first member! */
 	struct napi_struct napi;
+	struct phy *transceiver;
 
 	void __iomem *reg_base;
 
@@ -1118,20 +1120,24 @@ static int at91_open(struct net_device *dev)
 	struct at91_priv *priv = netdev_priv(dev);
 	int err;
 
-	err = clk_prepare_enable(priv->clk);
+	err = phy_power_on(priv->transceiver);
 	if (err)
 		return err;
 
 	/* check or determine and set bittime */
 	err = open_candev(dev);
 	if (err)
-		goto out;
+		goto out_phy_power_off;
+
+	err = clk_prepare_enable(priv->clk);
+	if (err)
+		goto out_close_candev;
 
 	/* register interrupt handler */
 	err = request_irq(dev->irq, at91_irq, IRQF_SHARED,
 			  dev->name, dev);
 	if (err)
-		goto out_close;
+		goto out_clock_disable_unprepare;
 
 	/* start chip and queuing */
 	at91_chip_start(dev);
@@ -1140,10 +1146,12 @@ static int at91_open(struct net_device *dev)
 
 	return 0;
 
- out_close:
-	close_candev(dev);
- out:
+ out_clock_disable_unprepare:
 	clk_disable_unprepare(priv->clk);
+ out_close_candev:
+	close_candev(dev);
+ out_phy_power_off:
+	phy_power_off(priv->transceiver);
 
 	return err;
 }
@@ -1160,6 +1168,7 @@ static int at91_close(struct net_device *dev)
 
 	free_irq(dev->irq, dev);
 	clk_disable_unprepare(priv->clk);
+	phy_power_off(priv->transceiver);
 
 	close_candev(dev);
 
@@ -1284,6 +1293,7 @@ static const struct at91_devtype_data *at91_can_get_driver_data(struct platform_
 static int at91_can_probe(struct platform_device *pdev)
 {
 	const struct at91_devtype_data *devtype_data;
+	struct phy *transceiver;
 	struct net_device *dev;
 	struct at91_priv *priv;
 	struct resource *res;
@@ -1332,6 +1342,13 @@ static int at91_can_probe(struct platform_device *pdev)
 		goto exit_iounmap;
 	}
 
+	transceiver = devm_phy_optional_get(&pdev->dev, NULL);
+	if (IS_ERR(transceiver)) {
+		err = PTR_ERR(transceiver);
+		dev_err_probe(&pdev->dev, err, "failed to get phy\n");
+		goto exit_iounmap;
+	}
+
 	dev->netdev_ops	= &at91_netdev_ops;
 	dev->ethtool_ops = &at91_ethtool_ops;
 	dev->irq = irq;
@@ -1352,6 +1369,9 @@ static int at91_can_probe(struct platform_device *pdev)
 
 	netif_napi_add_weight(dev, &priv->napi, at91_poll, get_mb_rx_num(priv));
 
+	if (transceiver)
+		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
+
 	if (at91_is_sam9263(priv))
 		dev->sysfs_groups[0] = &at91_sysfs_attr_group;
 
-- 
2.40.1


