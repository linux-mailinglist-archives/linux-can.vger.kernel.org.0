Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C072D3431F7
	for <lists+linux-can@lfdr.de>; Sun, 21 Mar 2021 11:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhCUKl7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 21 Mar 2021 06:41:59 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:31940 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229835AbhCUKl5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 21 Mar 2021 06:41:57 -0400
Received: from tomoyo.flets-east.jp ([153.202.107.157])
        by mwinf5d70 with ME
        id iyh52400H3PnFJp03yhu9Q; Sun, 21 Mar 2021 11:41:56 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Mar 2021 11:41:56 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v14 4/4] can: etas_es58x: add es58x_netdev_queue_set_dql_min_limit()
Date:   Sun, 21 Mar 2021 19:41:03 +0900
Message-Id: <20210321104103.213308-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210321104103.213308-1-mailhol.vincent@wanadoo.fr>
References: <20210321104103.213308-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The size of a classical CAN frame is roughly 16 bytes, way less than
an USB packet (varies between devices but often between 64 and 512
bytes).

This es58x_netdev_queue_set_dql_min_limit() forces to do a bulk send
up to a threshold given by dql_min_limit in order to prevent sending
many small USB packets even when small burst occurs (BQL algorithm is
not able to immediately adjust dql.min_limit value).

Doing so increases the throughput with a minimum impact on the
latency: the time lost to stuff several frame in a single USB packet
is negligible compared to the gain of not having to send several USB
packets.

Co-developed-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Signed-off-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Note: Contrary to previous version, the dql_min_limit field is not
guarded any more by #ifdef CONFIG_BQL: removing that field would
create a hole, so there is no gain to do so. If CONFIG_BQL is indeed
deactivated the field will just be unused.
---
 drivers/net/can/usb/etas_es58x/es581_4.c    |  2 ++
 drivers/net/can/usb/etas_es58x/es58x_core.c |  5 ++++
 drivers/net/can/usb/etas_es58x/es58x_core.h | 27 +++++++++++++++++++++
 drivers/net/can/usb/etas_es58x/es58x_fd.c   |  2 ++
 4 files changed, 36 insertions(+)

diff --git a/drivers/net/can/usb/etas_es58x/es581_4.c b/drivers/net/can/usb/etas_es58x/es581_4.c
index a4b21dfd1bff..6b39d0cad7bb 100644
--- a/drivers/net/can/usb/etas_es58x/es581_4.c
+++ b/drivers/net/can/usb/etas_es58x/es581_4.c
@@ -481,6 +481,8 @@ const struct es58x_parameters es581_4_param = {
 	 * unclear.
 	 */
 	.fifo_mask = 63, /* echo_skb_max = 64 */
+	/* Empirical value. */
+	.dql_min_limit = CAN_FRAME_LEN_MAX * 50,
 	.tx_bulk_max = ES581_4_TX_BULK_MAX,
 	.urb_cmd_header_len = ES581_4_URB_CMD_HEADER_LEN,
 	.rx_urb_max = ES58X_RX_URBS_MAX,
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 7b9b993c0b5b..b07b9f085687 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -461,6 +461,8 @@ static void es58x_can_flush_echo_skb(struct net_device *netdev)
 	priv->tx_tail = 0;
 	priv->tx_head = 0;
 	netdev_reset_queue(netdev);
+	es58x_netdev_queue_set_dql_min_limit(netdev_get_tx_queue(netdev, 0),
+					     priv->es58x_dev->param->dql_min_limit);
 }
 
 /**
@@ -2148,6 +2150,9 @@ static int es58x_init_netdev(struct es58x_device *es58x_dev, int channel_idx)
 	netdev_dbg(netdev, "%s: Registered channel %s\n",
 		   es58x_dev->udev->product, netdev->name);
 
+	es58x_netdev_queue_set_dql_min_limit(netdev_get_tx_queue(netdev, 0),
+					     es58x_dev->param->dql_min_limit);
+
 	return ret;
 }
 
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.h b/drivers/net/can/usb/etas_es58x/es58x_core.h
index f0cf88a96816..086c17693f9a 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.h
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.h
@@ -276,6 +276,15 @@ struct es58x_priv {
  *	not exceed the maximum size of the device internal TX FIFO
  *	length. This parameter is used to control the network queue
  *	wake/stop logic.
+ * @dql_min_limit: Dynamic Queue Limits (DQL) absolute minimum limit
+ *	of bytes allowed to be queued on this network device transmit
+ *	queue. Used by the Byte Queue Limits (BQL) to determine how
+ *	frequently the xmit_more flag will be set to true in
+ *	es58x_start_xmit(). Set this value higher to optimize for
+ *	throughput but be aware that it might have a negative impact
+ *	on the latency! This value can also be set dynamically. Please
+ *	refer to Documentation/ABI/testing/sysfs-class-net-queues for
+ *	more details.
  * @tx_bulk_max: Maximum number of TX messages that can be sent in one
  *	single URB packet.
  * @urb_cmd_header_len: Length of the URB command header.
@@ -294,6 +303,7 @@ struct es58x_parameters {
 	u16 tx_urb_cmd_max_len;
 	u16 rx_urb_cmd_max_len;
 	u16 fifo_mask;
+	u16 dql_min_limit;
 	u8 tx_bulk_max;
 	u8 urb_cmd_header_len;
 	u8 rx_urb_max;
@@ -643,6 +653,23 @@ static inline enum es58x_flag es58x_get_flags(const struct sk_buff *skb)
 	return es58x_flags;
 }
 
+/**
+ * es58x_netdev_queue_set_dql_min_limit - set dql minimum limit
+ * @q: pointer to transmit queue
+ * @min_limit: dql minimum limit
+ *
+ * Forces xmit_more() to return true until the minimum threshold
+ * defined by @min_limit is reached (or until the tx queue is
+ * empty).
+ */
+static inline void es58x_netdev_queue_set_dql_min_limit(struct netdev_queue *q,
+							unsigned int min_limit)
+{
+#ifdef CONFIG_BQL
+	q->dql.min_limit = min_limit;
+#endif
+}
+
 int es58x_can_get_echo_skb(struct net_device *netdev, u32 packet_idx,
 			   u64 *tstamps, unsigned int pkts);
 int es58x_tx_ack_msg(struct net_device *netdev, u16 tx_free_entries,
diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
index a4e0867c9d4c..578a01580488 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
@@ -557,6 +557,8 @@ const struct es58x_parameters es58x_fd_param = {
 	 * maximum, so no impact on performance was measured.
 	 */
 	.fifo_mask = 255, /* echo_skb_max = 256 */
+	/* Empirical value. */
+	.dql_min_limit = CAN_FRAME_LEN_MAX * 15,
 	.tx_bulk_max = ES58X_FD_TX_BULK_MAX,
 	.urb_cmd_header_len = ES58X_FD_URB_CMD_HEADER_LEN,
 	.rx_urb_max = ES58X_RX_URBS_MAX,
-- 
2.26.2

