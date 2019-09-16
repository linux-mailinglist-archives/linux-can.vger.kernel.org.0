Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2247AB3C50
	for <lists+linux-can@lfdr.de>; Mon, 16 Sep 2019 16:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfIPOP7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Sep 2019 10:15:59 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:33911 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfIPOP7 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 16 Sep 2019 10:15:59 -0400
Received: from linux-dev.peak.localnet (unknown [185.109.201.203])
        (Authenticated sender: stephane.grosjean)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 90F9CB005A8;
        Mon, 16 Sep 2019 16:15:54 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can/peak_pciefd: provide hw timestamps in rx skbs
Date:   Mon, 16 Sep 2019 16:15:44 +0200
Message-Id: <20190916141544.6591-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PEAK-System's CAN FD interfaces based on an IP core provide a timestamp for
each CAN and STATUS message received. This patch transfers these received
timestamps (clocked in microseconds) to hardware timestamps (clocked in
nanoseconds) in the corresponding skbs raised to the network layer.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/peak_canfd/peak_canfd.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 6b0c6a99fc8d..f0b276ed64e4 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -232,6 +232,17 @@ static int pucan_setup_rx_barrier(struct peak_canfd_priv *priv)
 	return pucan_write_cmd(priv);
 }
 
+static int pucan_netif_rx(struct sk_buff *skb, __le32 ts_low, __le32 ts_high)
+{
+	struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
+	u64 ts_us = ((u64)(le32_to_cpu(ts_high)) << 32) + le32_to_cpu(ts_low);
+
+	/* IP core timestamps are µs. */
+	hwts->hwtstamp = ns_to_ktime(ts_us * NSEC_PER_USEC);
+
+	return netif_rx(skb);
+}
+
 /* handle the reception of one CAN frame */
 static int pucan_handle_can_rx(struct peak_canfd_priv *priv,
 			       struct pucan_rx_msg *msg)
@@ -299,7 +310,7 @@ static int pucan_handle_can_rx(struct peak_canfd_priv *priv,
 	stats->rx_bytes += cf->len;
 	stats->rx_packets++;
 
-	netif_rx(skb);
+	pucan_netif_rx(skb, msg->ts_low, msg->ts_high);
 
 	return 0;
 }
@@ -393,7 +404,7 @@ static int pucan_handle_status(struct peak_canfd_priv *priv,
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
-	netif_rx(skb);
+	pucan_netif_rx(skb, msg->ts_low, msg->ts_high);
 
 	return 0;
 }
-- 
2.20.1

