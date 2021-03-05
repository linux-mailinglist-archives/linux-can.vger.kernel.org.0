Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3778B32F10A
	for <lists+linux-can@lfdr.de>; Fri,  5 Mar 2021 18:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhCERVu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Mar 2021 12:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhCERVd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Mar 2021 12:21:33 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C29EC061574
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 09:21:33 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id u187so2116148wmg.4
        for <linux-can@vger.kernel.org>; Fri, 05 Mar 2021 09:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bHCAyJyLBlSUijMZ4mDRyVqgepl9qF4sX19Xz/BNfsY=;
        b=Q8wq4BGQtTL3JAx2K5GOhCMuwsnTtx/PttFoAeH0SEOk9UyNpw4FvJGAj7Eo4/sK2y
         yws99nTugMgvowdd3oOMqtb0a7y6HS4RFWyi7Jg5OlB55irlyysGlT4TfYqWQHRZT/ic
         VyCEx0HI4jASjNjkmNgU6Hu/HsOZu9nejHRaGR8PSqKoVXj4QqusNt3+KBiT7IeDT0FP
         absXYjj0wVk+jA87tDFmI1j0bsNMJOS4xWh7qkwA/05QMHW2qcP7OZx7a7qKh4NP5gTJ
         acd/fezTyLqiFInzhB8Pw5Eybz5jQyT+KDQ5XP+qMjxA4S/51KSL9OGHEAdMKJHCwO7P
         YPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHCAyJyLBlSUijMZ4mDRyVqgepl9qF4sX19Xz/BNfsY=;
        b=lDP+WWOV1he+0EXNlBMDvE9/WTav5tgG6BTwV5OG55ie7wtHjRXFZmbvKo8JEcusLu
         gwtWky+ESmSLzqrgPhhqFWc2u0qwx0FLD9lNbO2oS0nsIMSugQJSV2jDnqDX5sdCmoeE
         54SAweutBg3FjDZdvvyHaMd2bxn/1Z3b65+yAQkav7FPKjyWjypAnK+1x/t0ngp09i0A
         spldklpu3zKdiHVvqsRCRjbl4X3ejb8EA9aYvp+PyagXIGgN1ePpY/jHBcRdOPeKaMGT
         aKMD4GOjqKEpkjb0BsMcrEdqkxbMt4kHlP9F9ttOjxvQ56XvvBbzejb5zSAAWcX8yNmH
         odvg==
X-Gm-Message-State: AOAM531fCgatmAwLPcdFNnchWjLR8IyoCJpntkEw4rufnfj2X7huzRmY
        2Lzb5dWYKQg910+grZsyl1GhSlSJ5AVpow==
X-Google-Smtp-Source: ABdhPJxLM3vBwuQ8zwfHr9vcSzJVt3JFfDnLDaiAL1H/jXFvLi5nwOGKzy9/mZacrFt+opA4uooJVg==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr10191379wmo.36.1614964891801;
        Fri, 05 Mar 2021 09:21:31 -0800 (PST)
Received: from localhost.localdomain ([185.69.145.254])
        by smtp.gmail.com with ESMTPSA id c9sm5174926wmb.33.2021.03.05.09.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:21:31 -0800 (PST)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Pankaj Sharma <pankj.sharma@samsung.com>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH 3/3] can: m_can: fix RX path: use rx-offload to ensure skbs are sent from softirq context
Date:   Fri,  5 Mar 2021 17:20:15 +0000
Message-Id: <20210305172015.1506525-4-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305172015.1506525-1-torin@maxiluxsystems.com>
References: <20210305172015.1506525-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

For peripheral devices, m_can sent skbs directly from a threaded irq
instead of from a softirq context. This patch transitions the driver to
use the rx-offload helper, ensuring the skbs are sent from the correct
context, with h/w timestamping to ensure correct ordering.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/m_can.c | 50 ++++++++++++++++++++++++++---------
 drivers/net/can/m_can/m_can.h |  2 ++
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 83a673417e7c..ebdec9c6c0b5 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -467,7 +467,7 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
-	u32 id, fgi, dlc;
+	u32 id, fgi, dlc, timestamp;
 	int i;
 
 	/* calculate the fifo get index for where to read data */
@@ -516,7 +516,9 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	stats->rx_packets++;
 	stats->rx_bytes += cf->len;
 
-	netif_receive_skb(skb);
+	timestamp = ((dlc & RX_BUF_RXTS_MASK) >> RX_BUF_RXTS_SHIFT) << 16;
+
+	can_rx_offload_queue_sorted(&cdev->offload, skb, timestamp);
 }
 
 static int m_can_do_rx_poll(struct net_device *dev, int quota)
@@ -547,6 +549,7 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
 
 static int m_can_handle_lost_msg(struct net_device *dev)
 {
+	struct m_can_classdev *cdev = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	struct sk_buff *skb;
 	struct can_frame *frame;
@@ -563,7 +566,8 @@ static int m_can_handle_lost_msg(struct net_device *dev)
 	frame->can_id |= CAN_ERR_CRTL;
 	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	netif_receive_skb(skb);
+	can_rx_offload_queue_sorted(&cdev->offload, skb,
+				    m_can_get_timestamp(cdev));
 
 	return 1;
 }
@@ -620,7 +624,8 @@ static int m_can_handle_lec_err(struct net_device *dev,
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->len;
-	netif_receive_skb(skb);
+	can_rx_offload_queue_sorted(&cdev->offload, skb,
+				    m_can_get_timestamp(cdev));
 
 	return 1;
 }
@@ -739,7 +744,8 @@ static int m_can_handle_state_change(struct net_device *dev,
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->len;
-	netif_receive_skb(skb);
+	can_rx_offload_queue_sorted(&cdev->offload, skb,
+				    m_can_get_timestamp(cdev));
 
 	return 1;
 }
@@ -825,7 +831,8 @@ static int m_can_handle_protocol_error(struct net_device *dev, u32 irqstatus)
 		netdev_dbg(dev, "allocation of skb failed\n");
 		return 0;
 	}
-	netif_receive_skb(skb);
+	can_rx_offload_queue_sorted(&cdev->offload, skb,
+				    m_can_get_timestamp(cdev));
 
 	return 1;
 }
@@ -926,6 +933,19 @@ static int m_can_poll(struct napi_struct *napi, int quota)
 	return work_done;
 }
 
+static void m_can_tx_update_stats(struct m_can_classdev *cdev,
+				  unsigned int msg_mark)
+{
+	struct net_device_stats *stats = &cdev->net->stats;
+
+	stats->tx_bytes +=
+		can_rx_offload_get_echo_skb(&cdev->offload,
+					    msg_mark,
+					    m_can_get_timestamp(cdev),
+					    NULL);
+	stats->tx_packets++;
+}
+
 static void m_can_echo_tx_event(struct net_device *dev)
 {
 	u32 txe_count = 0;
@@ -935,7 +955,6 @@ static void m_can_echo_tx_event(struct net_device *dev)
 	unsigned int msg_mark;
 
 	struct m_can_classdev *cdev = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
 
 	/* read tx event fifo status */
 	m_can_txefs = m_can_read(cdev, M_CAN_TXEFS);
@@ -958,8 +977,7 @@ static void m_can_echo_tx_event(struct net_device *dev)
 						(fgi << TXEFA_EFAI_SHIFT)));
 
 		/* update stats */
-		stats->tx_bytes += can_get_echo_skb(dev, msg_mark, NULL);
-		stats->tx_packets++;
+		m_can_tx_update_stats(cdev, msg_mark);
 	}
 }
 
@@ -967,7 +985,6 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct m_can_classdev *cdev = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
 	u32 ir;
 
 	if (pm_runtime_suspended(cdev->dev))
@@ -1000,8 +1017,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	if (cdev->version == 30) {
 		if (ir & IR_TC) {
 			/* Transmission Complete Interrupt*/
-			stats->tx_bytes += can_get_echo_skb(dev, 0, NULL);
-			stats->tx_packets++;
+			m_can_tx_update_stats(cdev, 0);
 			can_led_event(dev, CAN_LED_EVENT_TX);
 			netif_wake_queue(dev);
 		}
@@ -1463,6 +1479,7 @@ static int m_can_close(struct net_device *dev)
 		cdev->tx_wq = NULL;
 	}
 
+	can_rx_offload_disable(&cdev->offload);
 	close_candev(dev);
 	can_led_event(dev, CAN_LED_EVENT_STOP);
 
@@ -1661,6 +1678,8 @@ static int m_can_open(struct net_device *dev)
 		goto exit_disable_clks;
 	}
 
+	can_rx_offload_enable(&cdev->offload);
+
 	/* register interrupt handler */
 	if (cdev->is_peripheral) {
 		cdev->tx_skb = NULL;
@@ -1702,6 +1721,7 @@ static int m_can_open(struct net_device *dev)
 	if (cdev->is_peripheral)
 		destroy_workqueue(cdev->tx_wq);
 out_wq_fail:
+	can_rx_offload_disable(&cdev->offload);
 	close_candev(dev);
 exit_disable_clks:
 	m_can_clk_stop(cdev);
@@ -1855,6 +1875,11 @@ int m_can_class_register(struct m_can_classdev *cdev)
 			return ret;
 	}
 
+	ret = can_rx_offload_add_manual(cdev->net, &cdev->offload,
+					M_CAN_NAPI_WEIGHT);
+	if (ret)
+		goto clk_disable;
+
 	ret = m_can_dev_setup(cdev);
 	if (ret)
 		goto clk_disable;
@@ -1885,6 +1910,7 @@ EXPORT_SYMBOL_GPL(m_can_class_register);
 
 void m_can_class_unregister(struct m_can_classdev *cdev)
 {
+	can_rx_offload_del(&cdev->offload);
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

