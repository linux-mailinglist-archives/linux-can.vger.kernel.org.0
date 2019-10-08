Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53761CF451
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbfJHHwb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 03:52:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52505 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbfJHHwb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2019 03:52:31 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iHkII-0005p5-AE; Tue, 08 Oct 2019 09:52:30 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 2/4] can: rx-offload: can_rx_offload_receive_skb(): add new function
Date:   Tue,  8 Oct 2019 09:52:24 +0200
Message-Id: <20191008075226.12544-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008075226.12544-1-mkl@pengutronix.de>
References: <20191008075226.12544-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

The CAN rx-offload provides a mechanism to rapidly read CAN msgs from
the CAN chip, and queue them before the NAPI will process them in a
softirq.

The current CAN rx-offload only supports a callback that reads the CAN
frame from the chip with its only parameter being a mailbox index.

This commit provides a netif_receive_skb() alike function
"can_rx_offload_receive_skb()" that uses the CAN rx-offload queueing
directly without a callback.

This makes transition easier, especially when more context info is
required which makes the callback method harder.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rx-offload.c   | 17 +++++++++++++++++
 include/linux/can/rx-offload.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index e90f11e79ab4..138b8b8e3700 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -270,6 +270,23 @@ int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_queue_tail);
 
+int can_rx_offload_receive_skb(struct can_rx_offload *offload,
+			       struct sk_buff *skb)
+{
+	struct net_device_stats *stats = &offload->dev->stats;
+	int err;
+
+	err = can_rx_offload_queue_tail(offload, skb);
+	if (err) {
+		kfree_skb(skb);
+		stats->rx_errors++;
+		stats->rx_fifo_errors++;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_receive_skb);
+
 static int can_rx_offload_init_queue(struct net_device *dev,
 				     struct can_rx_offload *offload,
 				     unsigned int weight)
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index cdeb8834382d..c32423318717 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -47,6 +47,8 @@ unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
 					 unsigned int idx, u32 timestamp);
 int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 			      struct sk_buff *skb);
+int can_rx_offload_receive_skb(struct can_rx_offload *offload,
+			       struct sk_buff *skb);
 void can_rx_offload_del(struct can_rx_offload *offload);
 void can_rx_offload_enable(struct can_rx_offload *offload);
 
-- 
2.23.0

