Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 805219FAD7
	for <lists+linux-can@lfdr.de>; Wed, 28 Aug 2019 08:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfH1Gwd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Aug 2019 02:52:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45275 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfH1Gwb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Aug 2019 02:52:31 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i2roj-0002oO-Kh; Wed, 28 Aug 2019 08:52:29 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH 06/21] can: af_can: give variable holding the CAN per device receive lists a sensible name
Date:   Wed, 28 Aug 2019 08:52:11 +0200
Message-Id: <20190828065226.23604-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190828065226.23604-1-mkl@pengutronix.de>
References: <20190828065226.23604-1-mkl@pengutronix.de>
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

This patch gives the variables holding the CAN receive filter lists a
better name by renaming them from "d" to "dev_rcv_lists".

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 89 ++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 45 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 62b3f2d68287..0d51c06a88ac 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -358,7 +358,7 @@ static unsigned int effhash(canid_t can_id)
  *  Reduced can_id to have a preprocessed filter compare value.
  */
 static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
-					struct can_dev_rcv_lists *d)
+					struct can_dev_rcv_lists *dev_rcv_lists)
 {
 	canid_t inv = *can_id & CAN_INV_FILTER; /* save flag before masking */
 
@@ -366,7 +366,7 @@ static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
 	if (*mask & CAN_ERR_FLAG) {
 		/* clear CAN_ERR_FLAG in filter entry */
 		*mask &= CAN_ERR_MASK;
-		return &d->rx[RX_ERR];
+		return &dev_rcv_lists->rx[RX_ERR];
 	}
 
 	/* with cleared CAN_ERR_FLAG we have a simple mask/value filterpair */
@@ -382,26 +382,26 @@ static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
 
 	/* inverse can_id/can_mask filter */
 	if (inv)
-		return &d->rx[RX_INV];
+		return &dev_rcv_lists->rx[RX_INV];
 
 	/* mask == 0 => no condition testing at receive time */
 	if (!(*mask))
-		return &d->rx[RX_ALL];
+		return &dev_rcv_lists->rx[RX_ALL];
 
 	/* extra filterlists for the subscription of a single non-RTR can_id */
 	if (((*mask & CAN_EFF_RTR_FLAGS) == CAN_EFF_RTR_FLAGS) &&
 	    !(*can_id & CAN_RTR_FLAG)) {
 		if (*can_id & CAN_EFF_FLAG) {
 			if (*mask == (CAN_EFF_MASK | CAN_EFF_RTR_FLAGS))
-				return &d->rx_eff[effhash(*can_id)];
+				return &dev_rcv_lists->rx_eff[effhash(*can_id)];
 		} else {
 			if (*mask == (CAN_SFF_MASK | CAN_EFF_RTR_FLAGS))
-				return &d->rx_sff[*can_id];
+				return &dev_rcv_lists->rx_sff[*can_id];
 		}
 	}
 
 	/* default: filter via can_id/can_mask */
-	return &d->rx[RX_FIL];
+	return &dev_rcv_lists->rx[RX_FIL];
 }
 
 /**
@@ -440,7 +440,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 {
 	struct receiver *r;
 	struct hlist_head *rl;
-	struct can_dev_rcv_lists *d;
+	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 	int err = 0;
 
@@ -458,9 +458,9 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 
 	spin_lock(&net->can.rcvlists_lock);
 
-	d = find_dev_rcv_lists(net, dev);
-	if (d) {
-		rl = find_rcv_list(&can_id, &mask, d);
+	dev_rcv_lists = find_dev_rcv_lists(net, dev);
+	if (dev_rcv_lists) {
+		rl = find_rcv_list(&can_id, &mask, dev_rcv_lists);
 
 		r->can_id  = can_id;
 		r->mask    = mask;
@@ -471,7 +471,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 		r->sk      = sk;
 
 		hlist_add_head_rcu(&r->list, rl);
-		d->entries++;
+		dev_rcv_lists->entries++;
 
 		rcv_lists_stats->rcv_entries++;
 		if (rcv_lists_stats->rcv_entries_max < rcv_lists_stats->rcv_entries)
@@ -516,7 +516,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	struct receiver *r = NULL;
 	struct hlist_head *rl;
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
-	struct can_dev_rcv_lists *d;
+	struct can_dev_rcv_lists *dev_rcv_lists;
 
 	if (dev && dev->type != ARPHRD_CAN)
 		return;
@@ -526,20 +526,19 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 
 	spin_lock(&net->can.rcvlists_lock);
 
-	d = find_dev_rcv_lists(net, dev);
-	if (!d) {
+	dev_rcv_lists = find_dev_rcv_lists(net, dev);
+	if (!dev_rcv_lists) {
 		pr_err("BUG: receive list not found for dev %s, id %03X, mask %03X\n",
 		       DNAME(dev), can_id, mask);
 		goto out;
 	}
 
-	rl = find_rcv_list(&can_id, &mask, d);
+	rl = find_rcv_list(&can_id, &mask, dev_rcv_lists);
 
 	/* Search the receiver list for the item to delete.  This should
 	 * exist, since no receiver may be unregistered that hasn't
 	 * been registered before.
 	 */
-
 	hlist_for_each_entry_rcu(r, rl, list) {
 		if (r->can_id == can_id && r->mask == mask &&
 		    r->func == func && r->data == data)
@@ -557,14 +556,14 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	}
 
 	hlist_del_rcu(&r->list);
-	d->entries--;
+	dev_rcv_lists->entries--;
 
 	if (rcv_lists_stats->rcv_entries > 0)
 		rcv_lists_stats->rcv_entries--;
 
 	/* remove device structure requested by NETDEV_UNREGISTER */
-	if (d->remove_on_zero_entries && !d->entries) {
-		kfree(d);
+	if (dev_rcv_lists->remove_on_zero_entries && !dev_rcv_lists->entries) {
+		kfree(dev_rcv_lists);
 		dev->ml_priv = NULL;
 	}
 
@@ -586,19 +585,19 @@ static inline void deliver(struct sk_buff *skb, struct receiver *r)
 	r->matches++;
 }
 
-static int can_rcv_filter(struct can_dev_rcv_lists *d, struct sk_buff *skb)
+static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buff *skb)
 {
 	struct receiver *r;
 	int matches = 0;
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	canid_t can_id = cf->can_id;
 
-	if (d->entries == 0)
+	if (dev_rcv_lists->entries == 0)
 		return 0;
 
 	if (can_id & CAN_ERR_FLAG) {
 		/* check for error message frame entries only */
-		hlist_for_each_entry_rcu(r, &d->rx[RX_ERR], list) {
+		hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_ERR], list) {
 			if (can_id & r->mask) {
 				deliver(skb, r);
 				matches++;
@@ -608,13 +607,13 @@ static int can_rcv_filter(struct can_dev_rcv_lists *d, struct sk_buff *skb)
 	}
 
 	/* check for unfiltered entries */
-	hlist_for_each_entry_rcu(r, &d->rx[RX_ALL], list) {
+	hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_ALL], list) {
 		deliver(skb, r);
 		matches++;
 	}
 
 	/* check for can_id/mask entries */
-	hlist_for_each_entry_rcu(r, &d->rx[RX_FIL], list) {
+	hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_FIL], list) {
 		if ((can_id & r->mask) == r->can_id) {
 			deliver(skb, r);
 			matches++;
@@ -622,7 +621,7 @@ static int can_rcv_filter(struct can_dev_rcv_lists *d, struct sk_buff *skb)
 	}
 
 	/* check for inverted can_id/mask entries */
-	hlist_for_each_entry_rcu(r, &d->rx[RX_INV], list) {
+	hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_INV], list) {
 		if ((can_id & r->mask) != r->can_id) {
 			deliver(skb, r);
 			matches++;
@@ -634,7 +633,7 @@ static int can_rcv_filter(struct can_dev_rcv_lists *d, struct sk_buff *skb)
 		return matches;
 
 	if (can_id & CAN_EFF_FLAG) {
-		hlist_for_each_entry_rcu(r, &d->rx_eff[effhash(can_id)], list) {
+		hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx_eff[effhash(can_id)], list) {
 			if (r->can_id == can_id) {
 				deliver(skb, r);
 				matches++;
@@ -642,7 +641,7 @@ static int can_rcv_filter(struct can_dev_rcv_lists *d, struct sk_buff *skb)
 		}
 	} else {
 		can_id &= CAN_SFF_MASK;
-		hlist_for_each_entry_rcu(r, &d->rx_sff[can_id], list) {
+		hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx_sff[can_id], list) {
 			deliver(skb, r);
 			matches++;
 		}
@@ -653,7 +652,7 @@ static int can_rcv_filter(struct can_dev_rcv_lists *d, struct sk_buff *skb)
 
 static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
-	struct can_dev_rcv_lists *d;
+	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct net *net = dev_net(dev);
 	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
 	int matches;
@@ -672,9 +671,9 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	matches = can_rcv_filter(net->can.rx_alldev_list, skb);
 
 	/* find receive list for this device */
-	d = find_dev_rcv_lists(net, dev);
-	if (d)
-		matches += can_rcv_filter(d, skb);
+	dev_rcv_lists = find_dev_rcv_lists(net, dev);
+	if (dev_rcv_lists)
+		matches += can_rcv_filter(dev_rcv_lists, skb);
 
 	rcu_read_unlock();
 
@@ -789,7 +788,7 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 			void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	struct can_dev_rcv_lists *d;
+	struct can_dev_rcv_lists *dev_rcv_lists;
 
 	if (dev->type != ARPHRD_CAN)
 		return NOTIFY_DONE;
@@ -798,23 +797,23 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 	case NETDEV_REGISTER:
 
 		/* create new dev_rcv_lists for this device */
-		d = kzalloc(sizeof(*d), GFP_KERNEL);
-		if (!d)
+		dev_rcv_lists = kzalloc(sizeof(*dev_rcv_lists), GFP_KERNEL);
+		if (!dev_rcv_lists)
 			return NOTIFY_DONE;
 		BUG_ON(dev->ml_priv);
-		dev->ml_priv = d;
+		dev->ml_priv = dev_rcv_lists;
 
 		break;
 
 	case NETDEV_UNREGISTER:
 		spin_lock(&dev_net(dev)->can.rcvlists_lock);
 
-		d = dev->ml_priv;
-		if (d) {
-			if (d->entries) {
-				d->remove_on_zero_entries = 1;
-			} else {
-				kfree(d);
+		dev_rcv_lists = dev->ml_priv;
+		if (dev_rcv_lists) {
+			if (dev_rcv_lists->entries)
+				dev_rcv_lists->remove_on_zero_entries = 1;
+			else {
+				kfree(dev_rcv_lists);
 				dev->ml_priv = NULL;
 			}
 		} else {
@@ -880,10 +879,10 @@ static void can_pernet_exit(struct net *net)
 	rcu_read_lock();
 	for_each_netdev_rcu(net, dev) {
 		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
-			struct can_dev_rcv_lists *d = dev->ml_priv;
+			struct can_dev_rcv_lists *dev_rcv_lists = dev->ml_priv;
 
-			BUG_ON(d->entries);
-			kfree(d);
+			BUG_ON(dev_rcv_lists->entries);
+			kfree(dev_rcv_lists);
 			dev->ml_priv = NULL;
 		}
 	}
-- 
2.23.0.rc1

