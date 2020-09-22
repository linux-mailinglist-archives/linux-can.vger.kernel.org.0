Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD23327448A
	for <lists+linux-can@lfdr.de>; Tue, 22 Sep 2020 16:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIVOok (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Sep 2020 10:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgIVOoj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Sep 2020 10:44:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90552C061755
        for <linux-can@vger.kernel.org>; Tue, 22 Sep 2020 07:44:39 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKjX2-0001FU-U1; Tue, 22 Sep 2020 16:44:37 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, michael@walle.cc, qiangqing.zhang@nxp.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 10/20] can: flexcan: flexcan_chip_stop(): add error handling and propagate error value
Date:   Tue, 22 Sep 2020 16:44:19 +0200
Message-Id: <20200922144429.2613631-11-mkl@pengutronix.de>
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

From: Joakim Zhang <qiangqing.zhang@nxp.com>

This patch implements error handling and propagates the error value of
flexcan_chip_stop(). This function will be called from flexcan_suspend()
in an upcoming patch in some SoCs which support LPSR mode.

Add a new function flexcan_chip_stop_disable_on_error() that tries to
disable the chip even in case of errors.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 52d73115c7fd..4be73ce7518e 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1292,18 +1292,23 @@ static int flexcan_chip_start(struct net_device *dev)
 	return err;
 }
 
-/* flexcan_chip_stop
+/* __flexcan_chip_stop
  *
- * this functions is entered with clocks enabled
+ * this function is entered with clocks enabled
  */
-static void flexcan_chip_stop(struct net_device *dev)
+static int __flexcan_chip_stop(struct net_device *dev, bool disable_on_error)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
+	int err;
 
 	/* freeze + disable module */
-	flexcan_chip_freeze(priv);
-	flexcan_chip_disable(priv);
+	err = flexcan_chip_freeze(priv);
+	if (err && !disable_on_error)
+		return err;
+	err = flexcan_chip_disable(priv);
+	if (err && !disable_on_error)
+		goto out_chip_unfreeze;
 
 	/* Disable all interrupts */
 	priv->write(0, &regs->imask2);
@@ -1313,6 +1318,23 @@ static void flexcan_chip_stop(struct net_device *dev)
 
 	flexcan_transceiver_disable(priv);
 	priv->can.state = CAN_STATE_STOPPED;
+
+	return 0;
+
+ out_chip_unfreeze:
+	flexcan_chip_unfreeze(priv);
+
+	return err;
+}
+
+static inline int flexcan_chip_stop_disable_on_error(struct net_device *dev)
+{
+	return __flexcan_chip_stop(dev, true);
+}
+
+static inline int flexcan_chip_stop(struct net_device *dev)
+{
+	return __flexcan_chip_stop(dev, false);
 }
 
 static int flexcan_open(struct net_device *dev)
@@ -1394,7 +1416,7 @@ static int flexcan_close(struct net_device *dev)
 
 	netif_stop_queue(dev);
 	can_rx_offload_disable(&priv->offload);
-	flexcan_chip_stop(dev);
+	flexcan_chip_stop_disable_on_error(dev);
 
 	can_rx_offload_del(&priv->offload);
 	free_irq(dev->irq, dev);
-- 
2.28.0

