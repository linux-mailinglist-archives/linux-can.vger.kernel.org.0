Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA099A807F
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 12:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfIDKoL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 06:44:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48183 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbfIDKoL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 06:44:11 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i5Slj-0003XS-2x; Wed, 04 Sep 2019 12:44:07 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 02/21] can: netns: give members of struct netns_can holding the statistics a sensible name
Date:   Wed,  4 Sep 2019 12:43:46 +0200
Message-Id: <20190904104405.21675-3-mkl@pengutronix.de>
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

This patch gives the members of the struct netns_can that are holding
the statistics a sensible name, by renaming struct netns_can::can_stats
into struct netns_can::pkg_stats and struct netns_can::can_pstats into
struct netns_can::rcv_lists_stats.

The conversion is done with:

	sed -i \
		-e "s:\(struct[^*]*\*\)can_stats;.*:\1pkg_stats;:" \
		-e "s:\(struct[^*]*\*\)can_pstats;.*:\1rcv_lists_stats;:" \
		-e "s/can\.can_stats/can.pkg_stats/g" \
		-e "s/can\.can_pstats/can.rcv_lists_stats/g" \
		net/can/*.[ch] \
		include/net/netns/can.h

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/net/netns/can.h |  4 ++--
 net/can/af_can.c        | 32 ++++++++++++++++----------------
 net/can/proc.c          | 14 +++++++-------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/net/netns/can.h b/include/net/netns/can.h
index f2e5646e36f2..f684dea0a83e 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -31,8 +31,8 @@ struct netns_can {
 	struct can_dev_rcv_lists *can_rx_alldev_list;
 	spinlock_t can_rcvlists_lock;
 	struct timer_list can_stattimer;/* timer for statistics update */
-	struct can_pkg_stats *can_stats;	/* packet statistics */
-	struct can_rcv_lists_stats *can_pstats;	/* receive list statistics */
+	struct can_pkg_stats *pkg_stats;
+	struct can_rcv_lists_stats *rcv_lists_stats;
 
 	/* CAN GW per-net gateway jobs */
 	struct hlist_head cgw_list;
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 0da9e6a573c5..079b00b5e365 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -198,7 +198,7 @@ int can_send(struct sk_buff *skb, int loop)
 {
 	struct sk_buff *newskb = NULL;
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
-	struct can_pkg_stats *can_stats = dev_net(skb->dev)->can.can_stats;
+	struct can_pkg_stats *can_stats = dev_net(skb->dev)->can.pkg_stats;
 	int err = -EINVAL;
 
 	if (skb->len == CAN_MTU) {
@@ -441,7 +441,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	struct receiver *r;
 	struct hlist_head *rl;
 	struct can_dev_rcv_lists *d;
-	struct can_rcv_lists_stats *can_pstats = net->can.can_pstats;
+	struct can_rcv_lists_stats *can_pstats = net->can.rcv_lists_stats;
 	int err = 0;
 
 	/* insert new receiver  (dev,canid,mask) -> (func,data) */
@@ -515,7 +515,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 {
 	struct receiver *r = NULL;
 	struct hlist_head *rl;
-	struct can_rcv_lists_stats *can_pstats = net->can.can_pstats;
+	struct can_rcv_lists_stats *can_pstats = net->can.rcv_lists_stats;
 	struct can_dev_rcv_lists *d;
 
 	if (dev && dev->type != ARPHRD_CAN)
@@ -655,7 +655,7 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
 	struct can_dev_rcv_lists *d;
 	struct net *net = dev_net(dev);
-	struct can_pkg_stats *can_stats = net->can.can_stats;
+	struct can_pkg_stats *can_stats = net->can.pkg_stats;
 	int matches;
 
 	/* update statistics */
@@ -837,12 +837,12 @@ static int can_pernet_init(struct net *net)
 		kzalloc(sizeof(*net->can.can_rx_alldev_list), GFP_KERNEL);
 	if (!net->can.can_rx_alldev_list)
 		goto out;
-	net->can.can_stats = kzalloc(sizeof(*net->can.can_stats), GFP_KERNEL);
-	if (!net->can.can_stats)
-		goto out_free_alldev_list;
-	net->can.can_pstats = kzalloc(sizeof(*net->can.can_pstats), GFP_KERNEL);
-	if (!net->can.can_pstats)
-		goto out_free_can_stats;
+	net->can.pkg_stats = kzalloc(sizeof(*net->can.pkg_stats), GFP_KERNEL);
+	if (!net->can.pkg_stats)
+		goto out_free_rx_alldev_list;
+	net->can.rcv_lists_stats = kzalloc(sizeof(*net->can.rcv_lists_stats), GFP_KERNEL);
+	if (!net->can.rcv_lists_stats)
+		goto out_free_pkg_stats;
 
 	if (IS_ENABLED(CONFIG_PROC_FS)) {
 		/* the statistics are updated every second (timer triggered) */
@@ -852,15 +852,15 @@ static int can_pernet_init(struct net *net)
 			mod_timer(&net->can.can_stattimer,
 				  round_jiffies(jiffies + HZ));
 		}
-		net->can.can_stats->jiffies_init = jiffies;
+		net->can.pkg_stats->jiffies_init = jiffies;
 		can_init_proc(net);
 	}
 
 	return 0;
 
- out_free_can_stats:
-	kfree(net->can.can_stats);
- out_free_alldev_list:
+ out_free_pkg_stats:
+	kfree(net->can.pkg_stats);
+ out_free_rx_alldev_list:
 	kfree(net->can.can_rx_alldev_list);
  out:
 	return -ENOMEM;
@@ -890,8 +890,8 @@ static void can_pernet_exit(struct net *net)
 	rcu_read_unlock();
 
 	kfree(net->can.can_rx_alldev_list);
-	kfree(net->can.can_stats);
-	kfree(net->can.can_pstats);
+	kfree(net->can.pkg_stats);
+	kfree(net->can.rcv_lists_stats);
 }
 
 /* af_can module init/exit functions */
diff --git a/net/can/proc.c b/net/can/proc.c
index d05e8c8b420d..30d8da4cef5d 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -78,8 +78,8 @@ static const char rx_list_name[][8] = {
 
 static void can_init_stats(struct net *net)
 {
-	struct can_pkg_stats *can_stats = net->can.can_stats;
-	struct can_rcv_lists_stats *can_pstats = net->can.can_pstats;
+	struct can_pkg_stats *can_stats = net->can.pkg_stats;
+	struct can_rcv_lists_stats *can_pstats = net->can.rcv_lists_stats;
 	/*
 	 * This memset function is called from a timer context (when
 	 * can_stattimer is active which is the default) OR in a process
@@ -119,7 +119,7 @@ static unsigned long calc_rate(unsigned long oldjif, unsigned long newjif,
 void can_stat_update(struct timer_list *t)
 {
 	struct net *net = from_timer(net, t, can.can_stattimer);
-	struct can_pkg_stats *can_stats = net->can.can_stats;
+	struct can_pkg_stats *can_stats = net->can.pkg_stats;
 	unsigned long j = jiffies; /* snapshot */
 
 	/* restart counting in timer context on user request */
@@ -212,8 +212,8 @@ static void can_print_recv_banner(struct seq_file *m)
 static int can_stats_proc_show(struct seq_file *m, void *v)
 {
 	struct net *net = m->private;
-	struct can_pkg_stats *can_stats = net->can.can_stats;
-	struct can_rcv_lists_stats *can_pstats = net->can.can_pstats;
+	struct can_pkg_stats *can_stats = net->can.pkg_stats;
+	struct can_rcv_lists_stats *can_pstats = net->can.rcv_lists_stats;
 
 	seq_putc(m, '\n');
 	seq_printf(m, " %8ld transmitted frames (TXF)\n", can_stats->tx_frames);
@@ -274,8 +274,8 @@ static int can_stats_proc_show(struct seq_file *m, void *v)
 static int can_reset_stats_proc_show(struct seq_file *m, void *v)
 {
 	struct net *net = m->private;
-	struct can_rcv_lists_stats *can_pstats = net->can.can_pstats;
-	struct can_pkg_stats *can_stats = net->can.can_stats;
+	struct can_rcv_lists_stats *can_pstats = net->can.rcv_lists_stats;
+	struct can_pkg_stats *can_stats = net->can.pkg_stats;
 
 	user_reset = 1;
 
-- 
2.23.0.rc1

