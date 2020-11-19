Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E57E2B8FEE
	for <lists+linux-can@lfdr.de>; Thu, 19 Nov 2020 11:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgKSKJX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Nov 2020 05:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgKSKJW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Nov 2020 05:09:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E87CC061A49
        for <linux-can@vger.kernel.org>; Thu, 19 Nov 2020 02:09:21 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kfgsR-00063P-G6; Thu, 19 Nov 2020 11:09:19 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>, kernel@pengutronix.de,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next v2 4/5] can: flexcan: flexcan_open(): completely initialize controller before requesting IRQ
Date:   Thu, 19 Nov 2020 11:09:16 +0100
Message-Id: <20201119100917.3013281-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119100917.3013281-1-mkl@pengutronix.de>
References: <20201119100917.3013281-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch changes the order in which the flexcan controller is brought up
during flexcan_open(). It makes sure that the chip is completely initialized
before the IRQs are requested and finally enabled.

Link: https://lore.kernel.org/r/20201119085251.2949181-5-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index cbce8a3d090c..0fb768dee99f 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1747,32 +1747,33 @@ static int flexcan_open(struct net_device *dev)
 	if (err)
 		goto out_close;
 
-	err = request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
+	err = flexcan_rx_offload_setup(dev);
 	if (err)
 		goto out_transceiver_disable;
 
-	err = flexcan_rx_offload_setup(dev);
+	err = flexcan_chip_start(dev);
 	if (err)
-		goto out_free_irq;
+		goto out_can_rx_offload_del;
 
-	/* start chip and queuing */
-	err = flexcan_chip_start(dev);
+	can_rx_offload_enable(&priv->offload);
+
+	err = request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
 	if (err)
-		goto out_offload_del;
+		goto out_can_rx_offload_disable;
 
 	flexcan_chip_interrupts_enable(dev);
 
 	can_led_event(dev, CAN_LED_EVENT_OPEN);
 
-	can_rx_offload_enable(&priv->offload);
 	netif_start_queue(dev);
 
 	return 0;
 
- out_offload_del:
+ out_can_rx_offload_disable:
+	can_rx_offload_disable(&priv->offload);
+	flexcan_chip_stop(dev);
+ out_can_rx_offload_del:
 	can_rx_offload_del(&priv->offload);
- out_free_irq:
-	free_irq(dev->irq, dev);
  out_transceiver_disable:
 	flexcan_transceiver_disable(priv);
  out_close:
-- 
2.29.2

