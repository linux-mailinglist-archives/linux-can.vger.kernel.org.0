Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2FBCA8087
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 12:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfIDKoM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 06:44:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39525 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbfIDKoL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 06:44:11 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i5Sll-0003XS-U0; Wed, 04 Sep 2019 12:44:10 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 10/21] can: af_can: give variable holding the CAN receiver and the receiver list a sensible name
Date:   Wed,  4 Sep 2019 12:43:54 +0200
Message-Id: <20190904104405.21675-11-mkl@pengutronix.de>
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

This patch gives the variables holding the CAN receiver and the receiver
list a better name by renaming them from "r to "rcv" and "rl" to
"recv_list".

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 101 +++++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 51 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index a5bb364cbf61..36c7b4311936 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -438,8 +438,8 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 		    canid_t mask, void (*func)(struct sk_buff *, void *),
 		    void *data, char *ident, struct sock *sk)
 {
-	struct receiver *r;
-	struct hlist_head *rl;
+	struct receiver *rcv;
+	struct hlist_head *rcv_list;
 	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 	int err = 0;
@@ -452,32 +452,32 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	if (dev && !net_eq(net, dev_net(dev)))
 		return -ENODEV;
 
-	r = kmem_cache_alloc(rcv_cache, GFP_KERNEL);
-	if (!r)
+	rcv = kmem_cache_alloc(rcv_cache, GFP_KERNEL);
+	if (!rcv)
 		return -ENOMEM;
 
 	spin_lock(&net->can.rcvlists_lock);
 
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
 	if (dev_rcv_lists) {
-		rl = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
+		rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
-		r->can_id  = can_id;
-		r->mask    = mask;
-		r->matches = 0;
-		r->func    = func;
-		r->data    = data;
-		r->ident   = ident;
-		r->sk      = sk;
+		rcv->can_id = can_id;
+		rcv->mask = mask;
+		rcv->matches = 0;
+		rcv->func = func;
+		rcv->data = data;
+		rcv->ident = ident;
+		rcv->sk = sk;
 
-		hlist_add_head_rcu(&r->list, rl);
+		hlist_add_head_rcu(&rcv->list, rcv_list);
 		dev_rcv_lists->entries++;
 
 		rcv_lists_stats->rcv_entries++;
 		if (rcv_lists_stats->rcv_entries_max < rcv_lists_stats->rcv_entries)
 			rcv_lists_stats->rcv_entries_max = rcv_lists_stats->rcv_entries;
 	} else {
-		kmem_cache_free(rcv_cache, r);
+		kmem_cache_free(rcv_cache, rcv);
 		err = -ENODEV;
 	}
 
@@ -490,10 +490,10 @@ EXPORT_SYMBOL(can_rx_register);
 /* can_rx_delete_receiver - rcu callback for single receiver entry removal */
 static void can_rx_delete_receiver(struct rcu_head *rp)
 {
-	struct receiver *r = container_of(rp, struct receiver, rcu);
-	struct sock *sk = r->sk;
+	struct receiver *rcv = container_of(rp, struct receiver, rcu);
+	struct sock *sk = rcv->sk;
 
-	kmem_cache_free(rcv_cache, r);
+	kmem_cache_free(rcv_cache, rcv);
 	if (sk)
 		sock_put(sk);
 }
@@ -513,8 +513,8 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 		       canid_t mask, void (*func)(struct sk_buff *, void *),
 		       void *data)
 {
-	struct receiver *r = NULL;
-	struct hlist_head *rl;
+	struct receiver *rcv = NULL;
+	struct hlist_head *rcv_list;
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 	struct can_dev_rcv_lists *dev_rcv_lists;
 
@@ -533,29 +533,28 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 		goto out;
 	}
 
-	rl = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
+	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
 	/* Search the receiver list for the item to delete.  This should
 	 * exist, since no receiver may be unregistered that hasn't
 	 * been registered before.
 	 */
-	hlist_for_each_entry_rcu(r, rl, list) {
-		if (r->can_id == can_id && r->mask == mask &&
-		    r->func == func && r->data == data)
+	hlist_for_each_entry_rcu(rcv, rcv_list, list) {
+		if (rcv->can_id == can_id && rcv->mask == mask &&
+		    rcv->func == func && rcv->data == data)
 			break;
 	}
 
 	/* Check for bugs in CAN protocol implementations using af_can.c:
-	 * 'r' will be NULL if no matching list item was found for removal.
+	 * 'rcv' will be NULL if no matching list item was found for removal.
 	 */
-
-	if (!r) {
+	if (!rcv) {
 		WARN(1, "BUG: receive list entry not found for dev %s, id %03X, mask %03X\n",
 		     DNAME(dev), can_id, mask);
 		goto out;
 	}
 
-	hlist_del_rcu(&r->list);
+	hlist_del_rcu(&rcv->list);
 	dev_rcv_lists->entries--;
 
 	if (rcv_lists_stats->rcv_entries > 0)
@@ -571,23 +570,23 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	spin_unlock(&net->can.rcvlists_lock);
 
 	/* schedule the receiver item for deletion */
-	if (r) {
-		if (r->sk)
-			sock_hold(r->sk);
-		call_rcu(&r->rcu, can_rx_delete_receiver);
+	if (rcv) {
+		if (rcv->sk)
+			sock_hold(rcv->sk);
+		call_rcu(&rcv->rcu, can_rx_delete_receiver);
 	}
 }
 EXPORT_SYMBOL(can_rx_unregister);
 
-static inline void deliver(struct sk_buff *skb, struct receiver *r)
+static inline void deliver(struct sk_buff *skb, struct receiver *rcv)
 {
-	r->func(skb, r->data);
-	r->matches++;
+	rcv->func(skb, rcv->data);
+	rcv->matches++;
 }
 
 static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buff *skb)
 {
-	struct receiver *r;
+	struct receiver *rcv;
 	int matches = 0;
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	canid_t can_id = cf->can_id;
@@ -597,9 +596,9 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
 
 	if (can_id & CAN_ERR_FLAG) {
 		/* check for error message frame entries only */
-		hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_ERR], list) {
-			if (can_id & r->mask) {
-				deliver(skb, r);
+		hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx[RX_ERR], list) {
+			if (can_id & rcv->mask) {
+				deliver(skb, rcv);
 				matches++;
 			}
 		}
@@ -607,23 +606,23 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
 	}
 
 	/* check for unfiltered entries */
-	hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_ALL], list) {
-		deliver(skb, r);
+	hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx[RX_ALL], list) {
+		deliver(skb, rcv);
 		matches++;
 	}
 
 	/* check for can_id/mask entries */
-	hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_FIL], list) {
-		if ((can_id & r->mask) == r->can_id) {
-			deliver(skb, r);
+	hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx[RX_FIL], list) {
+		if ((can_id & rcv->mask) == rcv->can_id) {
+			deliver(skb, rcv);
 			matches++;
 		}
 	}
 
 	/* check for inverted can_id/mask entries */
-	hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_INV], list) {
-		if ((can_id & r->mask) != r->can_id) {
-			deliver(skb, r);
+	hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx[RX_INV], list) {
+		if ((can_id & rcv->mask) != rcv->can_id) {
+			deliver(skb, rcv);
 			matches++;
 		}
 	}
@@ -633,16 +632,16 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
 		return matches;
 
 	if (can_id & CAN_EFF_FLAG) {
-		hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx_eff[effhash(can_id)], list) {
-			if (r->can_id == can_id) {
-				deliver(skb, r);
+		hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx_eff[effhash(can_id)], list) {
+			if (rcv->can_id == can_id) {
+				deliver(skb, rcv);
 				matches++;
 			}
 		}
 	} else {
 		can_id &= CAN_SFF_MASK;
-		hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx_sff[can_id], list) {
-			deliver(skb, r);
+		hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx_sff[can_id], list) {
+			deliver(skb, rcv);
 			matches++;
 		}
 	}
-- 
2.23.0.rc1

