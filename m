Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108FE330C6F
	for <lists+linux-can@lfdr.de>; Mon,  8 Mar 2021 12:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhCHLcB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 Mar 2021 06:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhCHLbt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 Mar 2021 06:31:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A11C06174A
        for <linux-can@vger.kernel.org>; Mon,  8 Mar 2021 03:31:48 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJE71-0005Kj-I9
        for linux-can@vger.kernel.org; Mon, 08 Mar 2021 12:31:47 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 9B57F5F0A81
        for <linux-can@vger.kernel.org>; Mon,  8 Mar 2021 11:31:46 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 3CB9B5F0A7D;
        Mon,  8 Mar 2021 11:31:46 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 472ccb29;
        Mon, 8 Mar 2021 11:31:45 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3] can: m_can: fix periph RX path: use rx-offload to ensure skbs are sent from softirq context
Date:   Mon,  8 Mar 2021 12:31:44 +0100
Message-Id: <20210308113144.3058817-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Torin Cooper-Bennun <torin@maxiluxsystems.com>

For peripheral devices, m_can sent skbs directly from a threaded irq
instead of from a softirq context, breaking the tcan4x5x peripheral
driver completely. This patch transitions the driver to use the
rx-offload helper for peripherals, ensuring the skbs are sent from the
correct context, with h/w timestamping to ensure correct ordering.

Link: https://lore.kernel.org/r/20210308102427.63916-4-torin@maxiluxsystems.com
Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
[mkl: m_can_class_register(): update error handling]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

for completeness here the v3 of Torin's patch.

changes since v2:
- fixed commenting style
- add some missing variable initialization
- m_can_class_register(): update error handling

regards,
Marc

 drivers/net/can/m_can/m_can.c | 121 +++++++++++++++++++++++++++++-----
 drivers/net/can/m_can/m_can.h |   2 +
 2 files changed, 107 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 98f7c6514937..7bd67928d78f 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -457,6 +457,21 @@ static void m_can_clean(struct net_device *net)
 	}
 }
 
+/* For peripherals, pass skb to rx-offload, which will push skb from
+ * napi. For non-peripherals, RX is done in napi already, so push
+ * directly. timestamp is used to ensure good skb ordering in
+ * rx-offload and is ignored for non-peripherals.
+*/
+static void m_can_receive_skb(struct m_can_classdev *cdev,
+			      struct sk_buff *skb,
+			      u32 timestamp)
+{
+	if (cdev->is_peripheral)
+		can_rx_offload_queue_sorted(&cdev->offload, skb, timestamp);
+	else
+		netif_receive_skb(skb);
+}
+
 static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 {
 	struct net_device_stats *stats = &dev->stats;
@@ -464,6 +479,7 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
 	u32 id, fgi, dlc;
+	u32 timestamp = 0;
 	int i;
 
 	/* calculate the fifo get index for where to read data */
@@ -512,7 +528,9 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	stats->rx_packets++;
 	stats->rx_bytes += cf->len;
 
-	netif_receive_skb(skb);
+	timestamp = FIELD_GET(RX_BUF_RXTS_MASK, dlc);
+
+	m_can_receive_skb(cdev, skb, timestamp);
 }
 
 static int m_can_do_rx_poll(struct net_device *dev, int quota)
@@ -546,9 +564,11 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
 
 static int m_can_handle_lost_msg(struct net_device *dev)
 {
+	struct m_can_classdev *cdev = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	struct sk_buff *skb;
 	struct can_frame *frame;
+	u32 timestamp = 0;
 
 	netdev_err(dev, "msg lost in rxf0\n");
 
@@ -562,7 +582,10 @@ static int m_can_handle_lost_msg(struct net_device *dev)
 	frame->can_id |= CAN_ERR_CRTL;
 	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	netif_receive_skb(skb);
+	if (cdev->is_peripheral)
+		timestamp = m_can_get_timestamp(cdev);
+
+	m_can_receive_skb(cdev, skb, timestamp);
 
 	return 1;
 }
@@ -574,6 +597,7 @@ static int m_can_handle_lec_err(struct net_device *dev,
 	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
+	u32 timestamp = 0;
 
 	cdev->can.can_stats.bus_error++;
 	stats->rx_errors++;
@@ -619,7 +643,11 @@ static int m_can_handle_lec_err(struct net_device *dev,
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->len;
-	netif_receive_skb(skb);
+
+	if (cdev->is_peripheral)
+		timestamp = m_can_get_timestamp(cdev);
+
+	m_can_receive_skb(cdev, skb, timestamp);
 
 	return 1;
 }
@@ -677,6 +705,7 @@ static int m_can_handle_state_change(struct net_device *dev,
 	struct sk_buff *skb;
 	struct can_berr_counter bec;
 	unsigned int ecr;
+	u32 timestamp = 0;
 
 	switch (new_state) {
 	case CAN_STATE_ERROR_WARNING:
@@ -738,7 +767,11 @@ static int m_can_handle_state_change(struct net_device *dev,
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->len;
-	netif_receive_skb(skb);
+
+	if (cdev->is_peripheral)
+		timestamp = m_can_get_timestamp(cdev);
+
+	m_can_receive_skb(cdev, skb, timestamp);
 
 	return 1;
 }
@@ -803,6 +836,7 @@ static int m_can_handle_protocol_error(struct net_device *dev, u32 irqstatus)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	struct can_frame *cf;
 	struct sk_buff *skb;
+	u32 timestamp = 0;
 
 	/* propagate the error condition to the CAN stack */
 	skb = alloc_can_err_skb(dev, &cf);
@@ -824,7 +858,11 @@ static int m_can_handle_protocol_error(struct net_device *dev, u32 irqstatus)
 		netdev_dbg(dev, "allocation of skb failed\n");
 		return 0;
 	}
-	netif_receive_skb(skb);
+
+	if (cdev->is_peripheral)
+		timestamp = m_can_get_timestamp(cdev);
+
+	m_can_receive_skb(cdev, skb, timestamp);
 
 	return 1;
 }
@@ -925,6 +963,29 @@ static int m_can_poll(struct napi_struct *napi, int quota)
 	return work_done;
 }
 
+/* Echo tx skb and update net stats. Peripherals use rx-offload for
+ * echo. timestamp is used for peripherals to ensure correct ordering
+ * by rx-offload, and is ignored for non-peripherals.
+*/
+static void m_can_tx_update_stats(struct m_can_classdev *cdev,
+				  unsigned int msg_mark,
+				  u32 timestamp)
+{
+	struct net_device *dev = cdev->net;
+	struct net_device_stats *stats = &dev->stats;
+
+	if (cdev->is_peripheral)
+		stats->tx_bytes +=
+			can_rx_offload_get_echo_skb(&cdev->offload,
+						    msg_mark,
+						    timestamp,
+						    NULL);
+	else
+		stats->tx_bytes += can_get_echo_skb(dev, msg_mark, NULL);
+
+	stats->tx_packets++;
+}
+
 static void m_can_echo_tx_event(struct net_device *dev)
 {
 	u32 txe_count = 0;
@@ -934,7 +995,6 @@ static void m_can_echo_tx_event(struct net_device *dev)
 	unsigned int msg_mark;
 
 	struct m_can_classdev *cdev = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
 
 	/* read tx event fifo status */
 	m_can_txefs = m_can_read(cdev, M_CAN_TXEFS);
@@ -944,21 +1004,23 @@ static void m_can_echo_tx_event(struct net_device *dev)
 
 	/* Get and process all sent elements */
 	for (i = 0; i < txe_count; i++) {
+		u32 txe, timestamp = 0;
+
 		/* retrieve get index */
 		fgi = (m_can_read(cdev, M_CAN_TXEFS) & TXEFS_EFGI_MASK) >>
 			TXEFS_EFGI_SHIFT;
 
-		/* get message marker */
-		msg_mark = (m_can_txe_fifo_read(cdev, fgi, 4) &
-			    TX_EVENT_MM_MASK) >> TX_EVENT_MM_SHIFT;
+		/* get message marker, timestamp */
+		txe = m_can_txe_fifo_read(cdev, fgi, 4);
+		msg_mark = (txe & TX_EVENT_MM_MASK) >> TX_EVENT_MM_SHIFT;
+		timestamp = FIELD_GET(TX_EVENT_TXTS_MASK, txe);
 
 		/* ack txe element */
 		m_can_write(cdev, M_CAN_TXEFA, (TXEFA_EFAI_MASK &
 						(fgi << TXEFA_EFAI_SHIFT)));
 
 		/* update stats */
-		stats->tx_bytes += can_get_echo_skb(dev, msg_mark, NULL);
-		stats->tx_packets++;
+		m_can_tx_update_stats(cdev, msg_mark, timestamp);
 	}
 }
 
@@ -966,7 +1028,6 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct m_can_classdev *cdev = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
 	u32 ir;
 
 	if (pm_runtime_suspended(cdev->dev))
@@ -999,8 +1060,12 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	if (cdev->version == 30) {
 		if (ir & IR_TC) {
 			/* Transmission Complete Interrupt*/
-			stats->tx_bytes += can_get_echo_skb(dev, 0, NULL);
-			stats->tx_packets++;
+			u32 timestamp = 0;
+
+			if (cdev->is_peripheral)
+				timestamp = m_can_get_timestamp(cdev);
+			m_can_tx_update_stats(cdev, 0, timestamp);
+
 			can_led_event(dev, CAN_LED_EVENT_TX);
 			netif_wake_queue(dev);
 		}
@@ -1461,6 +1526,9 @@ static int m_can_close(struct net_device *dev)
 		cdev->tx_wq = NULL;
 	}
 
+	if (cdev->is_peripheral)
+		can_rx_offload_disable(&cdev->offload);
+
 	close_candev(dev);
 	can_led_event(dev, CAN_LED_EVENT_STOP);
 
@@ -1659,6 +1727,9 @@ static int m_can_open(struct net_device *dev)
 		goto exit_disable_clks;
 	}
 
+	if (cdev->is_peripheral)
+		can_rx_offload_enable(&cdev->offload);
+
 	/* register interrupt handler */
 	if (cdev->is_peripheral) {
 		cdev->tx_skb = NULL;
@@ -1700,6 +1771,8 @@ static int m_can_open(struct net_device *dev)
 	if (cdev->is_peripheral)
 		destroy_workqueue(cdev->tx_wq);
 out_wq_fail:
+	if (cdev->is_peripheral)
+		can_rx_offload_disable(&cdev->offload);
 	close_candev(dev);
 exit_disable_clks:
 	m_can_clk_stop(cdev);
@@ -1848,15 +1921,22 @@ int m_can_class_register(struct m_can_classdev *cdev)
 			return ret;
 	}
 
+	if (cdev->is_peripheral) {
+		ret = can_rx_offload_add_manual(cdev->net, &cdev->offload,
+						M_CAN_NAPI_WEIGHT);
+		if (ret)
+			goto clk_disable;
+	}
+
 	ret = m_can_dev_setup(cdev);
 	if (ret)
-		goto clk_disable;
+		goto rx_offload_del;
 
 	ret = register_m_can_dev(cdev->net);
 	if (ret) {
 		dev_err(cdev->dev, "registering %s failed (err=%d)\n",
 			cdev->net->name, ret);
-		goto clk_disable;
+		goto rx_offload_del;
 	}
 
 	devm_can_led_init(cdev->net);
@@ -1869,6 +1949,13 @@ int m_can_class_register(struct m_can_classdev *cdev)
 	/* Probe finished
 	 * Stop clocks. They will be reactivated once the M_CAN device is opened
 	 */
+	m_can_clk_stop(cdev);
+
+	return 0;
+
+rx_offload_del:
+	if (cdev->is_peripheral)
+		can_rx_offload_del(&cdev->offload);
 clk_disable:
 	m_can_clk_stop(cdev);
 
@@ -1878,6 +1965,8 @@ EXPORT_SYMBOL_GPL(m_can_class_register);
 
 void m_can_class_unregister(struct m_can_classdev *cdev)
 {
+	if (cdev->is_peripheral)
+		can_rx_offload_del(&cdev->offload);
 	unregister_candev(cdev->net);
 }
 EXPORT_SYMBOL_GPL(m_can_class_unregister);
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 3fda84cef351..ace071c3e58c 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -8,6 +8,7 @@
 
 #include <linux/can/core.h>
 #include <linux/can/led.h>
+#include <linux/can/rx-offload.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
@@ -71,6 +72,7 @@ struct m_can_ops {
 
 struct m_can_classdev {
 	struct can_priv can;
+	struct can_rx_offload offload;
 	struct napi_struct napi;
 	struct net_device *net;
 	struct device *dev;
-- 
2.30.1


