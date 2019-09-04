Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76575A8084
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 12:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfIDKoL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 06:44:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59277 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfIDKoK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 06:44:10 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i5Slj-0003XS-DR; Wed, 04 Sep 2019 12:44:07 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 03/21] can: af_can: give variables holding CAN statistics a sensible name
Date:   Wed,  4 Sep 2019 12:43:47 +0200
Message-Id: <20190904104405.21675-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190904104405.21675-1-mkl@pengutronix.de>
References: <20190904104405.21675-1-mkl@pengutronix.de>
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

This patch rename the variables holding the CAN statistics (can_stats
and can_pstats) to pkg_stats and rcv_lists_stats which reflect better
their meaning.

The conversion is done with:

	sed -i \
		-e "s/can_stats\([^_]\)/pkg_stats\1/g" \
		-e "s/can_pstats/rcv_lists_stats/g" \
		net/can/af_can.c

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 079b00b5e365..0eadded4a5aa 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -198,7 +198,7 @@ int can_send(struct sk_buff *skb, int loop)
 {
 	struct sk_buff *newskb = NULL;
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
-	struct can_pkg_stats *can_stats = dev_net(skb->dev)->can.pkg_stats;
+	struct can_pkg_stats *pkg_stats = dev_net(skb->dev)->can.pkg_stats;
 	int err = -EINVAL;
 
 	if (skb->len == CAN_MTU) {
@@ -285,8 +285,8 @@ int can_send(struct sk_buff *skb, int loop)
 		netif_rx_ni(newskb);
 
 	/* update statistics */
-	can_stats->tx_frames++;
-	can_stats->tx_frames_delta++;
+	pkg_stats->tx_frames++;
+	pkg_stats->tx_frames_delta++;
 
 	return 0;
 
@@ -441,7 +441,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	struct receiver *r;
 	struct hlist_head *rl;
 	struct can_dev_rcv_lists *d;
-	struct can_rcv_lists_stats *can_pstats = net->can.rcv_lists_stats;
+	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 	int err = 0;
 
 	/* insert new receiver  (dev,canid,mask) -> (func,data) */
@@ -473,9 +473,9 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 		hlist_add_head_rcu(&r->list, rl);
 		d->entries++;
 
-		can_pstats->rcv_entries++;
-		if (can_pstats->rcv_entries_max < can_pstats->rcv_entries)
-			can_pstats->rcv_entries_max = can_pstats->rcv_entries;
+		rcv_lists_stats->rcv_entries++;
+		if (rcv_lists_stats->rcv_entries_max < rcv_lists_stats->rcv_entries)
+			rcv_lists_stats->rcv_entries_max = rcv_lists_stats->rcv_entries;
 	} else {
 		kmem_cache_free(rcv_cache, r);
 		err = -ENODEV;
@@ -515,7 +515,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 {
 	struct receiver *r = NULL;
 	struct hlist_head *rl;
-	struct can_rcv_lists_stats *can_pstats = net->can.rcv_lists_stats;
+	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 	struct can_dev_rcv_lists *d;
 
 	if (dev && dev->type != ARPHRD_CAN)
@@ -559,8 +559,8 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	hlist_del_rcu(&r->list);
 	d->entries--;
 
-	if (can_pstats->rcv_entries > 0)
-		can_pstats->rcv_entries--;
+	if (rcv_lists_stats->rcv_entries > 0)
+		rcv_lists_stats->rcv_entries--;
 
 	/* remove device structure requested by NETDEV_UNREGISTER */
 	if (d->remove_on_zero_entries && !d->entries) {
@@ -655,12 +655,12 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
 	struct can_dev_rcv_lists *d;
 	struct net *net = dev_net(dev);
-	struct can_pkg_stats *can_stats = net->can.pkg_stats;
+	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
 	int matches;
 
 	/* update statistics */
-	can_stats->rx_frames++;
-	can_stats->rx_frames_delta++;
+	pkg_stats->rx_frames++;
+	pkg_stats->rx_frames_delta++;
 
 	/* create non-zero unique skb identifier together with *skb */
 	while (!(can_skb_prv(skb)->skbcnt))
@@ -682,8 +682,8 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	consume_skb(skb);
 
 	if (matches > 0) {
-		can_stats->matches++;
-		can_stats->matches_delta++;
+		pkg_stats->matches++;
+		pkg_stats->matches_delta++;
 	}
 }
 
-- 
2.23.0.rc1

