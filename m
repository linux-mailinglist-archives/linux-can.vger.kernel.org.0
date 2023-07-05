Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918AF748E6B
	for <lists+linux-can@lfdr.de>; Wed,  5 Jul 2023 21:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjGETy1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jul 2023 15:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjGETyZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jul 2023 15:54:25 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68481995;
        Wed,  5 Jul 2023 12:54:23 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 365Jrv7U087599;
        Wed, 5 Jul 2023 14:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1688586837;
        bh=evrF2IiSxJrhpilW908NGED4y7rNLummtuMgyrajd3Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BIAtMCAGY1opPaxYXpQoNNSmU98cz3NXveMFGiy8ovltmXIbz24oYjJG5Vh0MTs3Y
         gtxo4ndXSgP7/8Q3rTrL6iAp5i2vUMmAA5QpveoSnpMxWzzrc18mqaPKbtX3NzYWnJ
         6VEJPnec9h452FrmcbwDJLlX9Y99JqIwIO+vLphg=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 365Jrv96063749
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Jul 2023 14:53:57 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jul 2023 14:53:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jul 2023 14:53:56 -0500
Received: from uda0498204.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 365JrueU041658;
        Wed, 5 Jul 2023 14:53:56 -0500
From:   Judith Mendez <jm@ti.com>
To:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Schuyler Patton <spatton@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH 2/2] can: m_can: Add hrtimer to generate software interrupt
Date:   Wed, 5 Jul 2023 14:53:56 -0500
Message-ID: <20230705195356.866774-3-jm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705195356.866774-1-jm@ti.com>
References: <20230705195356.866774-1-jm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

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
---
Changelog:
v9:
- Change add MS to HRTIMER_POLL_INTERVAL
- Change syntax from "= 0" to "!"
v8:
- Cancel hrtimer after interrupts in m_can_stop
- Move assignment of hrtimer_callback to m_can_class_register()
- Initialize irq = 0 if polling mode is used
- Add reson for polling mode in commit msg
- Remove unrelated change
- Remove polling flag
v7:
- Clean up m_can_platform.c if/else section after removing poll-interval
- Remove poll-interval from patch description
v6:
- Move hrtimer stop/start function calls to m_can_open and m_can_close to
support power suspend/resume
v5:
- Change dev_dbg to dev_info if hardware interrupt exists and polling
is enabled
v4:
- No changes
v3:
- Create a define for 1 ms polling interval
- Change plarform_get_irq to optional to not print error msg
v2:
- Add functionality to check for 'poll-interval' property in MCAN node 
- Add 'polling' flag in driver to check if device is using polling method
- Check for timer polling and hardware interrupt cases, default to
hardware interrupt method
- Change ns_to_ktime() to ms_to_ktime()
---
 drivers/net/can/m_can/m_can.c          | 32 +++++++++++++++++++++++++-
 drivers/net/can/m_can/m_can.h          |  3 +++
 drivers/net/can/m_can/m_can_platform.c | 23 +++++++++++++++---
 3 files changed, 54 insertions(+), 4 deletions(-)

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
index 94dc82644113..76d11ce38220 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -5,6 +5,7 @@
 //
 // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
 
+#include <linux/hrtimer.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
@@ -96,12 +97,28 @@ static int m_can_plat_probe(struct platform_device *pdev)
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
+		if (irq == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto probe_fail;
+		}
+		if (irq < 0) {
+			ret = -EINVAL;
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
2.34.1

