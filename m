Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DCC330B1D
	for <lists+linux-can@lfdr.de>; Mon,  8 Mar 2021 11:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCHK32 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 Mar 2021 05:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhCHK3E (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 Mar 2021 05:29:04 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ED3C06174A
        for <linux-can@vger.kernel.org>; Mon,  8 Mar 2021 02:29:04 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d15so10862049wrv.5
        for <linux-can@vger.kernel.org>; Mon, 08 Mar 2021 02:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUw4fQPnj7PXSqtahwFYsfqJDUemBz+uvlCOqBgv8yk=;
        b=nADuvJByJAWFScPbnFMPVg+Sk/+RhuFpQr/dM6pDXXbpXBrl/7hhzzQj589erMF2BO
         62r5U41Iqoyy8ChZjUYuIc05gRWLj70+LolW2QzkKbeaD0Kgec0zkW9jDIy/GCvzcD6F
         ETRUMpAnllixcvX3Wr3KcmFVXAUFM2k9TizKTmsQFucTxrJx8taKxXfEUea7Z74j9ONk
         C5luxr9887omtiOJDSrtYpH2JKuitb78duvv3isAO/fDyMThDhHbjDy7ZJf+pU4aA5CB
         FDxFoKHvDiE4WU0l/0XyE3igCs8UPqGn5Z01JTZC5C/RWLo3NQDcGrIa+UF17GkrifFF
         BFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUw4fQPnj7PXSqtahwFYsfqJDUemBz+uvlCOqBgv8yk=;
        b=CNnxMFHkrzqpozs7I/bvVA18juBZtvnnzIDsvweB8cZXM+flUPeMfuZ4XT3ssooVcc
         kU5W5jRDA1XDBZ0BsKM4d21BImBNXLAFDpnzY3UVj48/ub85yT8lkguBQwfz96dtZzAX
         J5Hz01F9ASmOcEUxf6aXHf/7kOeTlAoieT3itGxPzASno9g6gChk4SgEdnFNFYRryFhf
         OjsQdcWhbycpCI5EpQVvZDR/NdVK9tOW1oXWk2c5T/+w9b8cNAva+p00QHGVN4RGtgEd
         kUdgtBMfWXbWssf02lkgvb4nHRnXmZ8g+WEhN837EQfBZTAEZfwoVBy0YLsy72lHggU4
         +AEQ==
X-Gm-Message-State: AOAM532BwZK8J7PB4mGvRpIaz/bfE/ye5tJMMp/ycOxvSESxb/EYZDyT
        LQ8ZBZARlWtf/+ujK2A5O8LeeV94u+baRYOY
X-Google-Smtp-Source: ABdhPJxKcPLjqIlGnVL8Km4zzghp9TCFK3K0tpdciQuU8d9n/XhnMUJCJkmdMSuOi116HAi9YxICGQ==
X-Received: by 2002:adf:fcc9:: with SMTP id f9mr22058889wrs.420.1615199342908;
        Mon, 08 Mar 2021 02:29:02 -0800 (PST)
Received: from localhost.localdomain (92.41.6.207.threembb.co.uk. [92.41.6.207])
        by smtp.gmail.com with ESMTPSA id i17sm6416455wrp.77.2021.03.08.02.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 02:29:02 -0800 (PST)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Pankaj Sharma <pankj.sharma@samsung.com>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH v2 3/3] can: m_can: fix periph RX path: use rx-offload to ensure skbs are sent from softirq context
Date:   Mon,  8 Mar 2021 10:24:28 +0000
Message-Id: <20210308102427.63916-4-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308102427.63916-1-torin@maxiluxsystems.com>
References: <20210308102427.63916-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

For peripheral devices, m_can sent skbs directly from a threaded irq
instead of from a softirq context, breaking the tcan4x5x peripheral
driver completely. This patch transitions the driver to use the
rx-offload helper for peripherals, ensuring the skbs are sent from the
correct context, with h/w timestamping to ensure correct ordering.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/m_can.c | 109 +++++++++++++++++++++++++++++-----
 drivers/net/can/m_can/m_can.h |   2 +
 2 files changed, 97 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e61b7e186d80..80519b5cec31 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -457,6 +457,20 @@ static void m_can_clean(struct net_device *net)
 	}
 }
 
+/* For peripherals, pass skb to rx-offload, which will push skb from napi. For
+ * non-peripherals, RX is done in napi already, so push directly. timestamp is
+ * used to ensure good skb ordering in rx-offload and is ignored
+ * for non-peripherals */
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
@@ -464,6 +478,7 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
 	u32 id, fgi, dlc;
+	u32 timestamp = 0;
 	int i;
 
 	/* calculate the fifo get index for where to read data */
@@ -512,7 +527,9 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	stats->rx_packets++;
 	stats->rx_bytes += cf->len;
 
-	netif_receive_skb(skb);
+	timestamp = FIELD_GET(RX_BUF_RXTS_MASK, dlc);
+
+	m_can_receive_skb(cdev, skb, timestamp);
 }
 
 static int m_can_do_rx_poll(struct net_device *dev, int quota)
@@ -546,9 +563,11 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
 
 static int m_can_handle_lost_msg(struct net_device *dev)
 {
+	struct m_can_classdev *cdev = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	struct sk_buff *skb;
 	struct can_frame *frame;
+	u32 timestamp = 0;
 
 	netdev_err(dev, "msg lost in rxf0\n");
 
@@ -562,7 +581,10 @@ static int m_can_handle_lost_msg(struct net_device *dev)
 	frame->can_id |= CAN_ERR_CRTL;
 	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	netif_receive_skb(skb);
+	if (cdev->is_peripheral)
+		timestamp = m_can_get_timestamp(cdev);
+
+	m_can_receive_skb(cdev, skb, timestamp);
 
 	return 1;
 }
@@ -574,6 +596,7 @@ static int m_can_handle_lec_err(struct net_device *dev,
 	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
+	u32 timestamp = 0;
 
 	cdev->can.can_stats.bus_error++;
 	stats->rx_errors++;
@@ -619,7 +642,11 @@ static int m_can_handle_lec_err(struct net_device *dev,
 
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
@@ -677,6 +704,7 @@ static int m_can_handle_state_change(struct net_device *dev,
 	struct sk_buff *skb;
 	struct can_berr_counter bec;
 	unsigned int ecr;
+	u32 timestamp;
 
 	switch (new_state) {
 	case CAN_STATE_ERROR_WARNING:
@@ -738,7 +766,11 @@ static int m_can_handle_state_change(struct net_device *dev,
 
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
@@ -803,6 +835,7 @@ static int m_can_handle_protocol_error(struct net_device *dev, u32 irqstatus)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	struct can_frame *cf;
 	struct sk_buff *skb;
+	u32 timestamp;
 
 	/* propagate the error condition to the CAN stack */
 	skb = alloc_can_err_skb(dev, &cf);
@@ -824,7 +857,11 @@ static int m_can_handle_protocol_error(struct net_device *dev, u32 irqstatus)
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
@@ -925,6 +962,28 @@ static int m_can_poll(struct napi_struct *napi, int quota)
 	return work_done;
 }
 
+/* Echo tx skb and update net stats. Peripherals use rx-offload for echo.
+ * timestamp is used for peripherals to ensure correct ordering by rx-offload,
+ * and is ignored for non-peripherals */
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
@@ -934,7 +993,6 @@ static void m_can_echo_tx_event(struct net_device *dev)
 	unsigned int msg_mark;
 
 	struct m_can_classdev *cdev = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
 
 	/* read tx event fifo status */
 	m_can_txefs = m_can_read(cdev, M_CAN_TXEFS);
@@ -944,21 +1002,24 @@ static void m_can_echo_tx_event(struct net_device *dev)
 
 	/* Get and process all sent elements */
 	for (i = 0; i < txe_count; i++) {
+		u32 txe;
+		u32 timestamp;
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
 
@@ -966,7 +1027,6 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct m_can_classdev *cdev = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
 	u32 ir;
 
 	if (pm_runtime_suspended(cdev->dev))
@@ -999,8 +1059,12 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
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
@@ -1461,6 +1525,9 @@ static int m_can_close(struct net_device *dev)
 		cdev->tx_wq = NULL;
 	}
 
+	if (cdev->is_peripheral)
+		can_rx_offload_disable(&cdev->offload);
+
 	close_candev(dev);
 	can_led_event(dev, CAN_LED_EVENT_STOP);
 
@@ -1659,6 +1726,9 @@ static int m_can_open(struct net_device *dev)
 		goto exit_disable_clks;
 	}
 
+	if (cdev->is_peripheral)
+		can_rx_offload_enable(&cdev->offload);
+
 	/* register interrupt handler */
 	if (cdev->is_peripheral) {
 		cdev->tx_skb = NULL;
@@ -1700,6 +1770,8 @@ static int m_can_open(struct net_device *dev)
 	if (cdev->is_peripheral)
 		destroy_workqueue(cdev->tx_wq);
 out_wq_fail:
+	if (cdev->is_peripheral)
+		can_rx_offload_disable(&cdev->offload);
 	close_candev(dev);
 exit_disable_clks:
 	m_can_clk_stop(cdev);
@@ -1853,6 +1925,13 @@ int m_can_class_register(struct m_can_classdev *cdev)
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
 		goto clk_disable;
@@ -1883,6 +1962,8 @@ EXPORT_SYMBOL_GPL(m_can_class_register);
 
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

