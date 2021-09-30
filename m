Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF1A41D6B3
	for <lists+linux-can@lfdr.de>; Thu, 30 Sep 2021 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349555AbhI3Jsf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 30 Sep 2021 05:48:35 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:26446 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349498AbhI3Jse (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 30 Sep 2021 05:48:34 -0400
Received: from Focal.peak-system.com (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id DB4D65FFB1;
        Thu, 30 Sep 2021 11:46:17 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can: peak_usb: CANFD: store 64-bits hw timestamps
Date:   Thu, 30 Sep 2021 11:46:03 +0200
Message-Id: <20210930094603.23134-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch allows to use the whole 64-bit timestamps received from the
CAN-FD device (expressed in µs) rather than only its low part, in the
hwtstamp structure of the skb transferred to the network layer, when a
CAN/CANFD frame has been received.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 11 +++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  1 +
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  9 ++++++---
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index e8f43ed90b72..4bb6b9d53df4 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -205,6 +205,17 @@ int peak_usb_netif_rx(struct sk_buff *skb,
 	return netif_rx(skb);
 }
 
+/* post received skb with native 64-bit hw timestamp */
+int peak_usb_netif_rx_64(struct sk_buff *skb, u32 ts_low, u32 ts_high)
+{
+	struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
+	u64 ns_ts = (((u64)ts_high << 32) + ts_low) * NSEC_PER_USEC;
+
+	hwts->hwtstamp = ns_to_ktime(ns_ts);
+
+	return netif_rx(skb);
+}
+
 /*
  * callback for bulk Rx urb
  */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index b00a4811bf61..daa19f57e742 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -143,6 +143,7 @@ void peak_usb_set_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
 void peak_usb_get_ts_time(struct peak_time_ref *time_ref, u32 ts, ktime_t *tv);
 int peak_usb_netif_rx(struct sk_buff *skb,
 		      struct peak_time_ref *time_ref, u32 ts_low);
+int peak_usb_netif_rx_64(struct sk_buff *skb, u32 ts_low, u32 ts_high);
 void peak_usb_async_complete(struct urb *urb);
 void peak_usb_restart_complete(struct peak_usb_device *dev);
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 09029a3bad1a..6bd12549f101 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -515,7 +515,8 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
 	netdev->stats.rx_packets++;
 	netdev->stats.rx_bytes += cfd->len;
 
-	peak_usb_netif_rx(skb, &usb_if->time_ref, le32_to_cpu(rm->ts_low));
+	peak_usb_netif_rx_64(skb, le32_to_cpu(rm->ts_low),
+			     le32_to_cpu(rm->ts_high));
 
 	return 0;
 }
@@ -579,7 +580,8 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
 	netdev->stats.rx_packets++;
 	netdev->stats.rx_bytes += cf->len;
 
-	peak_usb_netif_rx(skb, &usb_if->time_ref, le32_to_cpu(sm->ts_low));
+	peak_usb_netif_rx_64(skb, le32_to_cpu(sm->ts_low),
+			     le32_to_cpu(sm->ts_high));
 
 	return 0;
 }
@@ -629,7 +631,8 @@ static int pcan_usb_fd_decode_overrun(struct pcan_usb_fd_if *usb_if,
 	cf->can_id |= CAN_ERR_CRTL;
 	cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
 
-	peak_usb_netif_rx(skb, &usb_if->time_ref, le32_to_cpu(ov->ts_low));
+	peak_usb_netif_rx_64(skb, le32_to_cpu(ov->ts_low),
+			     le32_to_cpu(ov->ts_high));
 
 	netdev->stats.rx_over_errors++;
 	netdev->stats.rx_errors++;
-- 
2.25.1

