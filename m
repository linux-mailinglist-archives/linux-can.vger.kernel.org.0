Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC68C756BD3
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 20:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGQSXR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 14:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjGQSWu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 14:22:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC96818B
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 11:22:35 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLSri-0001Zd-Bw
        for linux-can@vger.kernel.org; Mon, 17 Jul 2023 20:22:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 335281F39E7
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 18:22:33 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 39D371F39B9;
        Mon, 17 Jul 2023 18:22:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 08bbeeb2;
        Mon, 17 Jul 2023 18:22:30 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Judith Mendez <jm@ti.com>,
        Hiago De Franco <hiago.franco@toradex.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 2/8] can: m_can: Add hrtimer to generate software interrupt
Date:   Mon, 17 Jul 2023 20:22:23 +0200
Message-Id: <20230717182229.250565-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717182229.250565-1-mkl@pengutronix.de>
References: <20230717182229.250565-1-mkl@pengutronix.de>
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

From: Judith Mendez <jm@ti.com>

Introduce timer polling method to MCAN since some SoCs may not
have M_CAN interrupt routed to A53 Linux and do not have
interrupt property in device tree M_CAN node.

On AM62x SoC, MCANs on MCU domain do not have hardware interrupt
routed to A53 Linux, instead they will use timer polling method.

Add an hrtimer to MCAN class device. Each MCAN will have its own
hrtimer instantiated if there is no hardware interrupt found in
device tree M_CAN node. The timer will generate a software
interrupt every 1 ms. In hrtimer callback, we check if there is
a transaction pending by reading a register, then process by
calling the isr if there is.

Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Toradex Verdin AM62
Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Judith Mendez <jm@ti.com>
Link: https://lore.kernel.org/all/20230707204714.62964-3-jm@ti.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c          | 32 +++++++++++++++++++++++++-
 drivers/net/can/m_can/m_can.h          |  3 +++
 drivers/net/can/m_can/m_can_platform.c | 21 +++++++++++++----
 3 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c5af92bcc9c9..13fd84b2e2dd 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -11,6 +11,7 @@
 #include <linux/bitfield.h>
 #include <linux/can/dev.h>
 #include <linux/ethtool.h>
+#include <linux/hrtimer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -308,6 +309,9 @@ enum m_can_reg {
 #define TX_EVENT_MM_MASK	GENMASK(31, 24)
 #define TX_EVENT_TXTS_MASK	GENMASK(15, 0)
 
+/* Hrtimer polling interval */
+#define HRTIMER_POLL_INTERVAL_MS		1
+
 /* The ID and DLC registers are adjacent in M_CAN FIFO memory,
  * and we can save a (potentially slow) bus round trip by combining
  * reads and writes to them.
@@ -1414,6 +1418,12 @@ static int m_can_start(struct net_device *dev)
 
 	m_can_enable_all_interrupts(cdev);
 
+	if (!dev->irq) {
+		dev_dbg(cdev->dev, "Start hrtimer\n");
+		hrtimer_start(&cdev->hrtimer, ms_to_ktime(HRTIMER_POLL_INTERVAL_MS),
+			      HRTIMER_MODE_REL_PINNED);
+	}
+
 	return 0;
 }
 
@@ -1568,6 +1578,11 @@ static void m_can_stop(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 
+	if (!dev->irq) {
+		dev_dbg(cdev->dev, "Stop hrtimer\n");
+		hrtimer_cancel(&cdev->hrtimer);
+	}
+
 	/* disable all interrupts */
 	m_can_disable_all_interrupts(cdev);
 
@@ -1793,6 +1808,18 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
+{
+	struct m_can_classdev *cdev = container_of(timer, struct
+						   m_can_classdev, hrtimer);
+
+	m_can_isr(0, cdev->net);
+
+	hrtimer_forward_now(timer, ms_to_ktime(HRTIMER_POLL_INTERVAL_MS));
+
+	return HRTIMER_RESTART;
+}
+
 static int m_can_open(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
@@ -1831,7 +1858,7 @@ static int m_can_open(struct net_device *dev)
 		err = request_threaded_irq(dev->irq, NULL, m_can_isr,
 					   IRQF_ONESHOT,
 					   dev->name, dev);
-	} else {
+	} else if (dev->irq) {
 		err = request_irq(dev->irq, m_can_isr, IRQF_SHARED, dev->name,
 				  dev);
 	}
@@ -2027,6 +2054,9 @@ int m_can_class_register(struct m_can_classdev *cdev)
 			goto clk_disable;
 	}
 
+	if (!cdev->net->irq)
+		cdev->hrtimer.function = &hrtimer_callback;
+
 	ret = m_can_dev_setup(cdev);
 	if (ret)
 		goto rx_offload_del;
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index a839dc71dc9b..2ac18ac867a4 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/freezer.h>
+#include <linux/hrtimer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -93,6 +94,8 @@ struct m_can_classdev {
 	int is_peripheral;
 
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
+
+	struct hrtimer hrtimer;
 };
 
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 94dc82644113..cdb28d6a092c 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -5,6 +5,7 @@
 //
 // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
 
+#include <linux/hrtimer.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
@@ -82,7 +83,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	void __iomem *addr;
 	void __iomem *mram_addr;
 	struct phy *transceiver;
-	int irq, ret = 0;
+	int irq = 0, ret = 0;
 
 	mcan_class = m_can_class_allocate_dev(&pdev->dev,
 					      sizeof(struct m_can_plat_priv));
@@ -96,12 +97,24 @@ static int m_can_plat_probe(struct platform_device *pdev)
 		goto probe_fail;
 
 	addr = devm_platform_ioremap_resource_byname(pdev, "m_can");
-	irq = platform_get_irq_byname(pdev, "int0");
-	if (IS_ERR(addr) || irq < 0) {
-		ret = -EINVAL;
+	if (IS_ERR(addr)) {
+		ret = PTR_ERR(addr);
 		goto probe_fail;
 	}
 
+	if (device_property_present(mcan_class->dev, "interrupts") ||
+	    device_property_present(mcan_class->dev, "interrupt-names")) {
+		irq = platform_get_irq_byname(pdev, "int0");
+		if (irq < 0) {
+			ret = irq;
+			goto probe_fail;
+		}
+	} else {
+		dev_dbg(mcan_class->dev, "Polling enabled, initialize hrtimer");
+		hrtimer_init(&mcan_class->hrtimer, CLOCK_MONOTONIC,
+			     HRTIMER_MODE_REL_PINNED);
+	}
+
 	/* message ram could be shared */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
 	if (!res) {
-- 
2.40.1


