Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D32DA8086
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 12:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfIDKoM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 06:44:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58613 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbfIDKoL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 06:44:11 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i5Slk-0003XS-6P; Wed, 04 Sep 2019 12:44:08 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 05/21] can: netns: remove "can_" prefix from members struct netns_can
Date:   Wed,  4 Sep 2019 12:43:49 +0200
Message-Id: <20190904104405.21675-6-mkl@pengutronix.de>
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

This patch improves the code reability by removing the redundant "can_"
prefix from the members of struct netns_can (as the struct netns_can itself
is the member "can" of the struct net.)

The conversion is done with:

	sed -i \
		-e "s/struct can_dev_rcv_lists \*can_rx_alldev_list;/struct can_dev_rcv_lists *rx_alldev_list;/" \
		-e "s/spinlock_t can_rcvlists_lock;/spinlock_t rcvlists_lock;/" \
		-e "s/struct timer_list can_stattimer;/struct timer_list stattimer; /" \
		-e "s/can\.can_rx_alldev_list/can.rx_alldev_list/g" \
		-e "s/can\.can_rcvlists_lock/can.rcvlists_lock/g" \
		-e "s/can\.can_stattimer/can.stattimer/g" \
		include/net/netns/can.h \
		net/can/*.[ch]

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/net/netns/can.h |  6 +++---
 net/can/af_can.c        | 34 +++++++++++++++++-----------------
 net/can/proc.c          | 14 +++++++-------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/net/netns/can.h b/include/net/netns/can.h
index f684dea0a83e..b6ab7d1530d7 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -28,9 +28,9 @@ struct netns_can {
 #endif
 
 	/* receive filters subscribed for 'all' CAN devices */
-	struct can_dev_rcv_lists *can_rx_alldev_list;
-	spinlock_t can_rcvlists_lock;
-	struct timer_list can_stattimer;/* timer for statistics update */
+	struct can_dev_rcv_lists *rx_alldev_list;
+	spinlock_t rcvlists_lock;
+	struct timer_list stattimer; /* timer for statistics update */
 	struct can_pkg_stats *pkg_stats;
 	struct can_rcv_lists_stats *rcv_lists_stats;
 
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 0eadded4a5aa..62b3f2d68287 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -302,7 +302,7 @@ static struct can_dev_rcv_lists *find_dev_rcv_lists(struct net *net,
 						    struct net_device *dev)
 {
 	if (!dev)
-		return net->can.can_rx_alldev_list;
+		return net->can.rx_alldev_list;
 	else
 		return (struct can_dev_rcv_lists *)dev->ml_priv;
 }
@@ -456,7 +456,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	if (!r)
 		return -ENOMEM;
 
-	spin_lock(&net->can.can_rcvlists_lock);
+	spin_lock(&net->can.rcvlists_lock);
 
 	d = find_dev_rcv_lists(net, dev);
 	if (d) {
@@ -481,7 +481,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 		err = -ENODEV;
 	}
 
-	spin_unlock(&net->can.can_rcvlists_lock);
+	spin_unlock(&net->can.rcvlists_lock);
 
 	return err;
 }
@@ -524,7 +524,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	if (dev && !net_eq(net, dev_net(dev)))
 		return;
 
-	spin_lock(&net->can.can_rcvlists_lock);
+	spin_lock(&net->can.rcvlists_lock);
 
 	d = find_dev_rcv_lists(net, dev);
 	if (!d) {
@@ -569,7 +569,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	}
 
  out:
-	spin_unlock(&net->can.can_rcvlists_lock);
+	spin_unlock(&net->can.rcvlists_lock);
 
 	/* schedule the receiver item for deletion */
 	if (r) {
@@ -669,7 +669,7 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	rcu_read_lock();
 
 	/* deliver the packet to sockets listening on all devices */
-	matches = can_rcv_filter(net->can.can_rx_alldev_list, skb);
+	matches = can_rcv_filter(net->can.rx_alldev_list, skb);
 
 	/* find receive list for this device */
 	d = find_dev_rcv_lists(net, dev);
@@ -807,7 +807,7 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 		break;
 
 	case NETDEV_UNREGISTER:
-		spin_lock(&dev_net(dev)->can.can_rcvlists_lock);
+		spin_lock(&dev_net(dev)->can.rcvlists_lock);
 
 		d = dev->ml_priv;
 		if (d) {
@@ -822,7 +822,7 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 			       dev->name);
 		}
 
-		spin_unlock(&dev_net(dev)->can.can_rcvlists_lock);
+		spin_unlock(&dev_net(dev)->can.rcvlists_lock);
 
 		break;
 	}
@@ -832,10 +832,10 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 
 static int can_pernet_init(struct net *net)
 {
-	spin_lock_init(&net->can.can_rcvlists_lock);
-	net->can.can_rx_alldev_list =
-		kzalloc(sizeof(*net->can.can_rx_alldev_list), GFP_KERNEL);
-	if (!net->can.can_rx_alldev_list)
+	spin_lock_init(&net->can.rcvlists_lock);
+	net->can.rx_alldev_list =
+		kzalloc(sizeof(*net->can.rx_alldev_list), GFP_KERNEL);
+	if (!net->can.rx_alldev_list)
 		goto out;
 	net->can.pkg_stats = kzalloc(sizeof(*net->can.pkg_stats), GFP_KERNEL);
 	if (!net->can.pkg_stats)
@@ -847,9 +847,9 @@ static int can_pernet_init(struct net *net)
 	if (IS_ENABLED(CONFIG_PROC_FS)) {
 		/* the statistics are updated every second (timer triggered) */
 		if (stats_timer) {
-			timer_setup(&net->can.can_stattimer, can_stat_update,
+			timer_setup(&net->can.stattimer, can_stat_update,
 				    0);
-			mod_timer(&net->can.can_stattimer,
+			mod_timer(&net->can.stattimer,
 				  round_jiffies(jiffies + HZ));
 		}
 		net->can.pkg_stats->jiffies_init = jiffies;
@@ -861,7 +861,7 @@ static int can_pernet_init(struct net *net)
  out_free_pkg_stats:
 	kfree(net->can.pkg_stats);
  out_free_rx_alldev_list:
-	kfree(net->can.can_rx_alldev_list);
+	kfree(net->can.rx_alldev_list);
  out:
 	return -ENOMEM;
 }
@@ -873,7 +873,7 @@ static void can_pernet_exit(struct net *net)
 	if (IS_ENABLED(CONFIG_PROC_FS)) {
 		can_remove_proc(net);
 		if (stats_timer)
-			del_timer_sync(&net->can.can_stattimer);
+			del_timer_sync(&net->can.stattimer);
 	}
 
 	/* remove created dev_rcv_lists from still registered CAN devices */
@@ -889,7 +889,7 @@ static void can_pernet_exit(struct net *net)
 	}
 	rcu_read_unlock();
 
-	kfree(net->can.can_rx_alldev_list);
+	kfree(net->can.rx_alldev_list);
 	kfree(net->can.pkg_stats);
 	kfree(net->can.rcv_lists_stats);
 }
diff --git a/net/can/proc.c b/net/can/proc.c
index 8390243f34c6..6561d74a1012 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -118,7 +118,7 @@ static unsigned long calc_rate(unsigned long oldjif, unsigned long newjif,
 
 void can_stat_update(struct timer_list *t)
 {
-	struct net *net = from_timer(net, t, can.can_stattimer);
+	struct net *net = from_timer(net, t, can.stattimer);
 	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
 	unsigned long j = jiffies; /* snapshot */
 
@@ -177,7 +177,7 @@ void can_stat_update(struct timer_list *t)
 	pkg_stats->matches_delta   = 0;
 
 	/* restart timer (one second) */
-	mod_timer(&net->can.can_stattimer, round_jiffies(jiffies + HZ));
+	mod_timer(&net->can.stattimer, round_jiffies(jiffies + HZ));
 }
 
 /*
@@ -222,7 +222,7 @@ static int can_stats_proc_show(struct seq_file *m, void *v)
 
 	seq_putc(m, '\n');
 
-	if (net->can.can_stattimer.function == can_stat_update) {
+	if (net->can.stattimer.function == can_stat_update) {
 		seq_printf(m, " %8ld %% total match ratio (RXMR)\n",
 				pkg_stats->total_rx_match_ratio);
 
@@ -279,7 +279,7 @@ static int can_reset_stats_proc_show(struct seq_file *m, void *v)
 
 	user_reset = 1;
 
-	if (net->can.can_stattimer.function == can_stat_update) {
+	if (net->can.stattimer.function == can_stat_update) {
 		seq_printf(m, "Scheduled statistic reset #%ld.\n",
 				rcv_lists_stats->stats_reset + 1);
 	} else {
@@ -323,7 +323,7 @@ static int can_rcvlist_proc_show(struct seq_file *m, void *v)
 	rcu_read_lock();
 
 	/* receive list for 'all' CAN devices (dev == NULL) */
-	d = net->can.can_rx_alldev_list;
+	d = net->can.rx_alldev_list;
 	can_rcvlist_proc_show_one(m, idx, NULL, d);
 
 	/* receive list for registered CAN devices */
@@ -375,7 +375,7 @@ static int can_rcvlist_sff_proc_show(struct seq_file *m, void *v)
 	rcu_read_lock();
 
 	/* sff receive list for 'all' CAN devices (dev == NULL) */
-	d = net->can.can_rx_alldev_list;
+	d = net->can.rx_alldev_list;
 	can_rcvlist_proc_show_array(m, NULL, d->rx_sff, ARRAY_SIZE(d->rx_sff));
 
 	/* sff receive list for registered CAN devices */
@@ -405,7 +405,7 @@ static int can_rcvlist_eff_proc_show(struct seq_file *m, void *v)
 	rcu_read_lock();
 
 	/* eff receive list for 'all' CAN devices (dev == NULL) */
-	d = net->can.can_rx_alldev_list;
+	d = net->can.rx_alldev_list;
 	can_rcvlist_proc_show_array(m, NULL, d->rx_eff, ARRAY_SIZE(d->rx_eff));
 
 	/* eff receive list for registered CAN devices */
-- 
2.23.0.rc1

