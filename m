Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B94A807D
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 12:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfIDKoK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 06:44:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48367 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfIDKoJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 06:44:09 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i5Sli-0003XS-Os; Wed, 04 Sep 2019 12:44:06 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 01/21] can: netns: give structs holding the CAN statistics a sensible name
Date:   Wed,  4 Sep 2019 12:43:45 +0200
Message-Id: <20190904104405.21675-2-mkl@pengutronix.de>
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

This patch renames both "struct s_stats" and "struct s_pstats", to
"struct can_pkg_stats" and "struct can_rcv_lists_stats" to better
reflect their meaning and improve code readability.

The conversion is done with:

	sed -i \
		-e "s/struct s_stats/struct can_pkg_stats/g" \
		-e "s/struct s_pstats/struct can_rcv_lists_stats/g" \
		net/can/*.[ch] \
		include/net/netns/can.h

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/net/netns/can.h |  8 ++++----
 net/can/af_can.c        |  8 ++++----
 net/can/af_can.h        |  4 ++--
 net/can/proc.c          | 16 ++++++++--------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/net/netns/can.h b/include/net/netns/can.h
index ca9bd9fba5b5..f2e5646e36f2 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -9,8 +9,8 @@
 #include <linux/spinlock.h>
 
 struct can_dev_rcv_lists;
-struct s_stats;
-struct s_pstats;
+struct can_pkg_stats;
+struct can_rcv_lists_stats;
 
 struct netns_can {
 #if IS_ENABLED(CONFIG_PROC_FS)
@@ -31,8 +31,8 @@ struct netns_can {
 	struct can_dev_rcv_lists *can_rx_alldev_list;
 	spinlock_t can_rcvlists_lock;
 	struct timer_list can_stattimer;/* timer for statistics update */
-	struct s_stats *can_stats;	/* packet statistics */
-	struct s_pstats *can_pstats;	/* receive list statistics */
+	struct can_pkg_stats *can_stats;	/* packet statistics */
+	struct can_rcv_lists_stats *can_pstats;	/* receive list statistics */
 
 	/* CAN GW per-net gateway jobs */
 	struct hlist_head cgw_list;
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 9a9a51847c7c..0da9e6a573c5 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -198,7 +198,7 @@ int can_send(struct sk_buff *skb, int loop)
 {
 	struct sk_buff *newskb = NULL;
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
-	struct s_stats *can_stats = dev_net(skb->dev)->can.can_stats;
+	struct can_pkg_stats *can_stats = dev_net(skb->dev)->can.can_stats;
 	int err = -EINVAL;
 
 	if (skb->len == CAN_MTU) {
@@ -441,7 +441,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	struct receiver *r;
 	struct hlist_head *rl;
 	struct can_dev_rcv_lists *d;
-	struct s_pstats *can_pstats = net->can.can_pstats;
+	struct can_rcv_lists_stats *can_pstats = net->can.can_pstats;
 	int err = 0;
 
 	/* insert new receiver  (dev,canid,mask) -> (func,data) */
@@ -515,7 +515,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 {
 	struct receiver *r = NULL;
 	struct hlist_head *rl;
-	struct s_pstats *can_pstats = net->can.can_pstats;
+	struct can_rcv_lists_stats *can_pstats = net->can.can_pstats;
 	struct can_dev_rcv_lists *d;
 
 	if (dev && dev->type != ARPHRD_CAN)
@@ -655,7 +655,7 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
 	struct can_dev_rcv_lists *d;
 	struct net *net = dev_net(dev);
-	struct s_stats *can_stats = net->can.can_stats;
+	struct can_pkg_stats *can_stats = net->can.can_stats;
 	int matches;
 
 	/* update statistics */
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 9cdb79083623..25d22e534506 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -78,7 +78,7 @@ struct can_dev_rcv_lists {
 /* statistic structures */
 
 /* can be reset e.g. by can_init_stats() */
-struct s_stats {
+struct can_pkg_stats {
 	unsigned long jiffies_init;
 
 	unsigned long rx_frames;
@@ -103,7 +103,7 @@ struct s_stats {
 };
 
 /* persistent statistics */
-struct s_pstats {
+struct can_rcv_lists_stats {
 	unsigned long stats_reset;
 	unsigned long user_reset;
 	unsigned long rcv_entries;
diff --git a/net/can/proc.c b/net/can/proc.c
index edb822c31902..d05e8c8b420d 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -78,14 +78,14 @@ static const char rx_list_name[][8] = {
 
 static void can_init_stats(struct net *net)
 {
-	struct s_stats *can_stats = net->can.can_stats;
-	struct s_pstats *can_pstats = net->can.can_pstats;
+	struct can_pkg_stats *can_stats = net->can.can_stats;
+	struct can_rcv_lists_stats *can_pstats = net->can.can_pstats;
 	/*
 	 * This memset function is called from a timer context (when
 	 * can_stattimer is active which is the default) OR in a process
 	 * context (reading the proc_fs when can_stattimer is disabled).
 	 */
-	memset(can_stats, 0, sizeof(struct s_stats));
+	memset(can_stats, 0, sizeof(struct can_pkg_stats));
 	can_stats->jiffies_init = jiffies;
 
 	can_pstats->stats_reset++;
@@ -119,7 +119,7 @@ static unsigned long calc_rate(unsigned long oldjif, unsigned long newjif,
 void can_stat_update(struct timer_list *t)
 {
 	struct net *net = from_timer(net, t, can.can_stattimer);
-	struct s_stats *can_stats = net->can.can_stats;
+	struct can_pkg_stats *can_stats = net->can.can_stats;
 	unsigned long j = jiffies; /* snapshot */
 
 	/* restart counting in timer context on user request */
@@ -212,8 +212,8 @@ static void can_print_recv_banner(struct seq_file *m)
 static int can_stats_proc_show(struct seq_file *m, void *v)
 {
 	struct net *net = m->private;
-	struct s_stats *can_stats = net->can.can_stats;
-	struct s_pstats *can_pstats = net->can.can_pstats;
+	struct can_pkg_stats *can_stats = net->can.can_stats;
+	struct can_rcv_lists_stats *can_pstats = net->can.can_pstats;
 
 	seq_putc(m, '\n');
 	seq_printf(m, " %8ld transmitted frames (TXF)\n", can_stats->tx_frames);
@@ -274,8 +274,8 @@ static int can_stats_proc_show(struct seq_file *m, void *v)
 static int can_reset_stats_proc_show(struct seq_file *m, void *v)
 {
 	struct net *net = m->private;
-	struct s_pstats *can_pstats = net->can.can_pstats;
-	struct s_stats *can_stats = net->can.can_stats;
+	struct can_rcv_lists_stats *can_pstats = net->can.can_pstats;
+	struct can_pkg_stats *can_stats = net->can.can_stats;
 
 	user_reset = 1;
 
-- 
2.23.0.rc1

