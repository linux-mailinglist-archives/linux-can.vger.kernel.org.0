Return-Path: <linux-can+bounces-3606-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE492ABEDBE
	for <lists+linux-can@lfdr.de>; Wed, 21 May 2025 10:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE034A40FF
	for <lists+linux-can@lfdr.de>; Wed, 21 May 2025 08:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3792D2367CF;
	Wed, 21 May 2025 08:23:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4316E235BE8
	for <linux-can@vger.kernel.org>; Wed, 21 May 2025 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747815785; cv=none; b=nHblASeTrGDcpE+zOC7fErSllP950TaaJ3KZHV7+nPYOyipOxJllYnIFR9gdXEiEHNCa7wMPCtI7GIR+C2Z+ZIObYWQlf/NlBab2dk2fb9mtiBHGnExxF/5bvV7mXv4cqHfkjAMDcYnZctAr+A5uoOxPKglUE7OZ8A3gKLQ0lE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747815785; c=relaxed/simple;
	bh=sh2yLVh9FIpOaNfSaeVxdOYUh8/tnArRgvbUNO7AI5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwjmB7HAThzoLBYnz+4si5obHGWnB55ZomHkLN74y1jBoEBv7vsl4P/wnJ4xozosj4+G8iqkv0W14B38lbbzlIokJV3Qgc12RGqeyNS4K0imWCC4bqg0nK8YrAPF6xVKa6bg05/7tm6coPzXLgQKD+xAS2ysrRmiq9tUUy4zOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uHej2-0003FD-KM
	for linux-can@vger.kernel.org; Wed, 21 May 2025 10:22:56 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uHej2-000XeM-1D
	for linux-can@vger.kernel.org;
	Wed, 21 May 2025 10:22:56 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 11E5B416698
	for <linux-can@vger.kernel.org>; Wed, 21 May 2025 08:22:56 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id DFDA2416680;
	Wed, 21 May 2025 08:22:53 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 92728ea1;
	Wed, 21 May 2025 08:22:52 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Axel Forsman <axfo@kvaser.com>,
	stable@vger.kernel.org,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/4] can: kvaser_pciefd: Fix echo_skb race
Date: Wed, 21 May 2025 10:14:26 +0200
Message-ID: <20250521082239.341080-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521082239.341080-2-mkl@pengutronix.de>
References: <20250521082239.341080-2-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Axel Forsman <axfo@kvaser.com>

The functions kvaser_pciefd_start_xmit() and
kvaser_pciefd_handle_ack_packet() raced to stop/wake TX queues and
get/put echo skbs, as kvaser_pciefd_can->echo_lock was only ever taken
when transmitting and KCAN_TX_NR_PACKETS_CURRENT gets decremented
prior to handling of ACKs. E.g., this caused the following error:

    can_put_echo_skb: BUG! echo_skb 5 is occupied!

Instead, use the synchronization helpers in netdev_queues.h. As those
piggyback on BQL barriers, start updating in-flight packets and bytes
counts as well.

Cc: stable@vger.kernel.org
Signed-off-by: Axel Forsman <axfo@kvaser.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250520114332.8961-3-axfo@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 93 +++++++++++++++++++++------------
 1 file changed, 59 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 9cc9176c2058..a61cbade96d9 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -16,6 +16,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/timer.h>
+#include <net/netdev_queues.h>
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Kvaser AB <support@kvaser.com>");
@@ -410,10 +411,13 @@ struct kvaser_pciefd_can {
 	void __iomem *reg_base;
 	struct can_berr_counter bec;
 	u8 cmd_seq;
+	u8 tx_max_count;
+	u8 tx_idx;
+	u8 ack_idx;
 	int err_rep_cnt;
-	int echo_idx;
+	unsigned int completed_tx_pkts;
+	unsigned int completed_tx_bytes;
 	spinlock_t lock; /* Locks sensitive registers (e.g. MODE) */
-	spinlock_t echo_lock; /* Locks the message echo buffer */
 	struct timer_list bec_poll_timer;
 	struct completion start_comp, flush_comp;
 };
@@ -714,6 +718,9 @@ static int kvaser_pciefd_open(struct net_device *netdev)
 	int ret;
 	struct kvaser_pciefd_can *can = netdev_priv(netdev);
 
+	can->tx_idx = 0;
+	can->ack_idx = 0;
+
 	ret = open_candev(netdev);
 	if (ret)
 		return ret;
@@ -745,21 +752,26 @@ static int kvaser_pciefd_stop(struct net_device *netdev)
 		timer_delete(&can->bec_poll_timer);
 	}
 	can->can.state = CAN_STATE_STOPPED;
+	netdev_reset_queue(netdev);
 	close_candev(netdev);
 
 	return ret;
 }
 
+static unsigned int kvaser_pciefd_tx_avail(const struct kvaser_pciefd_can *can)
+{
+	return can->tx_max_count - (READ_ONCE(can->tx_idx) - READ_ONCE(can->ack_idx));
+}
+
 static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
-					   struct kvaser_pciefd_can *can,
+					   struct can_priv *can, u8 seq,
 					   struct sk_buff *skb)
 {
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 	int packet_size;
-	int seq = can->echo_idx;
 
 	memset(p, 0, sizeof(*p));
-	if (can->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+	if (can->ctrlmode & CAN_CTRLMODE_ONE_SHOT)
 		p->header[1] |= KVASER_PCIEFD_TPACKET_SMS;
 
 	if (cf->can_id & CAN_RTR_FLAG)
@@ -782,7 +794,7 @@ static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
 	} else {
 		p->header[1] |=
 			FIELD_PREP(KVASER_PCIEFD_RPACKET_DLC_MASK,
-				   can_get_cc_dlc((struct can_frame *)cf, can->can.ctrlmode));
+				   can_get_cc_dlc((struct can_frame *)cf, can->ctrlmode));
 	}
 
 	p->header[1] |= FIELD_PREP(KVASER_PCIEFD_PACKET_SEQ_MASK, seq);
@@ -797,22 +809,24 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 					    struct net_device *netdev)
 {
 	struct kvaser_pciefd_can *can = netdev_priv(netdev);
-	unsigned long irq_flags;
 	struct kvaser_pciefd_tx_packet packet;
+	unsigned int seq = can->tx_idx & (can->can.echo_skb_max - 1);
+	unsigned int frame_len;
 	int nr_words;
-	u8 count;
 
 	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
+	if (!netif_subqueue_maybe_stop(netdev, 0, kvaser_pciefd_tx_avail(can), 1, 1))
+		return NETDEV_TX_BUSY;
 
-	nr_words = kvaser_pciefd_prepare_tx_packet(&packet, can, skb);
+	nr_words = kvaser_pciefd_prepare_tx_packet(&packet, &can->can, seq, skb);
 
-	spin_lock_irqsave(&can->echo_lock, irq_flags);
 	/* Prepare and save echo skb in internal slot */
-	can_put_echo_skb(skb, netdev, can->echo_idx, 0);
-
-	/* Move echo index to the next slot */
-	can->echo_idx = (can->echo_idx + 1) % can->can.echo_skb_max;
+	WRITE_ONCE(can->can.echo_skb[seq], NULL);
+	frame_len = can_skb_get_frame_len(skb);
+	can_put_echo_skb(skb, netdev, seq, frame_len);
+	netdev_sent_queue(netdev, frame_len);
+	WRITE_ONCE(can->tx_idx, can->tx_idx + 1);
 
 	/* Write header to fifo */
 	iowrite32(packet.header[0],
@@ -836,14 +850,7 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 			     KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
 	}
 
-	count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
-			  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
-	/* No room for a new message, stop the queue until at least one
-	 * successful transmit
-	 */
-	if (count >= can->can.echo_skb_max || can->can.echo_skb[can->echo_idx])
-		netif_stop_queue(netdev);
-	spin_unlock_irqrestore(&can->echo_lock, irq_flags);
+	netif_subqueue_maybe_stop(netdev, 0, kvaser_pciefd_tx_avail(can), 1, 1);
 
 	return NETDEV_TX_OK;
 }
@@ -970,6 +977,8 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->kv_pcie = pcie;
 		can->cmd_seq = 0;
 		can->err_rep_cnt = 0;
+		can->completed_tx_pkts = 0;
+		can->completed_tx_bytes = 0;
 		can->bec.txerr = 0;
 		can->bec.rxerr = 0;
 
@@ -983,11 +992,10 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		tx_nr_packets_max =
 			FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_MASK,
 				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
+		can->tx_max_count = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
 
 		can->can.clock.freq = pcie->freq;
-		can->can.echo_skb_max = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
-		can->echo_idx = 0;
-		spin_lock_init(&can->echo_lock);
+		can->can.echo_skb_max = roundup_pow_of_two(can->tx_max_count);
 		spin_lock_init(&can->lock);
 
 		can->can.bittiming_const = &kvaser_pciefd_bittiming_const;
@@ -1510,19 +1518,21 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
 		netdev_dbg(can->can.dev, "Packet was flushed\n");
 	} else {
 		int echo_idx = FIELD_GET(KVASER_PCIEFD_PACKET_SEQ_MASK, p->header[0]);
-		int len;
-		u8 count;
+		unsigned int len, frame_len = 0;
 		struct sk_buff *skb;
 
+		if (echo_idx != (can->ack_idx & (can->can.echo_skb_max - 1)))
+			return 0;
 		skb = can->can.echo_skb[echo_idx];
-		if (skb)
-			kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
-		len = can_get_echo_skb(can->can.dev, echo_idx, NULL);
-		count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
-				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
+		if (!skb)
+			return 0;
+		kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
+		len = can_get_echo_skb(can->can.dev, echo_idx, &frame_len);
 
-		if (count < can->can.echo_skb_max && netif_queue_stopped(can->can.dev))
-			netif_wake_queue(can->can.dev);
+		/* Pairs with barrier in kvaser_pciefd_start_xmit() */
+		smp_store_release(&can->ack_idx, can->ack_idx + 1);
+		can->completed_tx_pkts++;
+		can->completed_tx_bytes += frame_len;
 
 		if (!one_shot_fail) {
 			can->can.dev->stats.tx_bytes += len;
@@ -1638,11 +1648,26 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 {
 	int pos = 0;
 	int res = 0;
+	unsigned int i;
 
 	do {
 		res = kvaser_pciefd_read_packet(pcie, &pos, dma_buf);
 	} while (!res && pos > 0 && pos < KVASER_PCIEFD_DMA_SIZE);
 
+	/* Report ACKs in this buffer to BQL en masse for correct periods */
+	for (i = 0; i < pcie->nr_channels; ++i) {
+		struct kvaser_pciefd_can *can = pcie->can[i];
+
+		if (!can->completed_tx_pkts)
+			continue;
+		netif_subqueue_completed_wake(can->can.dev, 0,
+					      can->completed_tx_pkts,
+					      can->completed_tx_bytes,
+					      kvaser_pciefd_tx_avail(can), 1);
+		can->completed_tx_pkts = 0;
+		can->completed_tx_bytes = 0;
+	}
+
 	return res;
 }
 
-- 
2.47.2



