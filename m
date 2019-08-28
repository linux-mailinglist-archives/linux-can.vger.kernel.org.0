Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 123B59FAD6
	for <lists+linux-can@lfdr.de>; Wed, 28 Aug 2019 08:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfH1Gwd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Aug 2019 02:52:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46713 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfH1Gwa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Aug 2019 02:52:30 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i2roi-0002oO-Qu; Wed, 28 Aug 2019 08:52:28 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH 04/21] can: proc: give variables holding CAN statistics a sensible name
Date:   Wed, 28 Aug 2019 08:52:09 +0200
Message-Id: <20190828065226.23604-5-mkl@pengutronix.de>
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

This patch rename the variables holding the CAN statistics (can_stats
and can_pstats) to pkg_stats and rcv_lists_stats which reflect better
their meaning.

The conversion is done with:

	sed -i \
		-e "s/can_stats\([^_]\)/pkg_stats\1/g" \
		-e "s/can_pstats/rcv_lists_stats/g" \
		net/can/proc.c

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/proc.c | 116 ++++++++++++++++++++++++-------------------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/net/can/proc.c b/net/can/proc.c
index 30d8da4cef5d..8390243f34c6 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -78,21 +78,21 @@ static const char rx_list_name[][8] = {
 
 static void can_init_stats(struct net *net)
 {
-	struct can_pkg_stats *can_stats = net->can.pkg_stats;
-	struct can_rcv_lists_stats *can_pstats = net->can.rcv_lists_stats;
+	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
+	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 	/*
 	 * This memset function is called from a timer context (when
 	 * can_stattimer is active which is the default) OR in a process
 	 * context (reading the proc_fs when can_stattimer is disabled).
 	 */
-	memset(can_stats, 0, sizeof(struct can_pkg_stats));
-	can_stats->jiffies_init = jiffies;
+	memset(pkg_stats, 0, sizeof(struct can_pkg_stats));
+	pkg_stats->jiffies_init = jiffies;
 
-	can_pstats->stats_reset++;
+	rcv_lists_stats->stats_reset++;
 
 	if (user_reset) {
 		user_reset = 0;
-		can_pstats->user_reset++;
+		rcv_lists_stats->user_reset++;
 	}
 }
 
@@ -119,7 +119,7 @@ static unsigned long calc_rate(unsigned long oldjif, unsigned long newjif,
 void can_stat_update(struct timer_list *t)
 {
 	struct net *net = from_timer(net, t, can.can_stattimer);
-	struct can_pkg_stats *can_stats = net->can.pkg_stats;
+	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
 	unsigned long j = jiffies; /* snapshot */
 
 	/* restart counting in timer context on user request */
@@ -127,54 +127,54 @@ void can_stat_update(struct timer_list *t)
 		can_init_stats(net);
 
 	/* restart counting on jiffies overflow */
-	if (j < can_stats->jiffies_init)
+	if (j < pkg_stats->jiffies_init)
 		can_init_stats(net);
 
 	/* prevent overflow in calc_rate() */
-	if (can_stats->rx_frames > (ULONG_MAX / HZ))
+	if (pkg_stats->rx_frames > (ULONG_MAX / HZ))
 		can_init_stats(net);
 
 	/* prevent overflow in calc_rate() */
-	if (can_stats->tx_frames > (ULONG_MAX / HZ))
+	if (pkg_stats->tx_frames > (ULONG_MAX / HZ))
 		can_init_stats(net);
 
 	/* matches overflow - very improbable */
-	if (can_stats->matches > (ULONG_MAX / 100))
+	if (pkg_stats->matches > (ULONG_MAX / 100))
 		can_init_stats(net);
 
 	/* calc total values */
-	if (can_stats->rx_frames)
-		can_stats->total_rx_match_ratio = (can_stats->matches * 100) /
-			can_stats->rx_frames;
+	if (pkg_stats->rx_frames)
+		pkg_stats->total_rx_match_ratio = (pkg_stats->matches * 100) /
+			pkg_stats->rx_frames;
 
-	can_stats->total_tx_rate = calc_rate(can_stats->jiffies_init, j,
-					    can_stats->tx_frames);
-	can_stats->total_rx_rate = calc_rate(can_stats->jiffies_init, j,
-					    can_stats->rx_frames);
+	pkg_stats->total_tx_rate = calc_rate(pkg_stats->jiffies_init, j,
+					    pkg_stats->tx_frames);
+	pkg_stats->total_rx_rate = calc_rate(pkg_stats->jiffies_init, j,
+					    pkg_stats->rx_frames);
 
 	/* calc current values */
-	if (can_stats->rx_frames_delta)
-		can_stats->current_rx_match_ratio =
-			(can_stats->matches_delta * 100) /
-			can_stats->rx_frames_delta;
+	if (pkg_stats->rx_frames_delta)
+		pkg_stats->current_rx_match_ratio =
+			(pkg_stats->matches_delta * 100) /
+			pkg_stats->rx_frames_delta;
 
-	can_stats->current_tx_rate = calc_rate(0, HZ, can_stats->tx_frames_delta);
-	can_stats->current_rx_rate = calc_rate(0, HZ, can_stats->rx_frames_delta);
+	pkg_stats->current_tx_rate = calc_rate(0, HZ, pkg_stats->tx_frames_delta);
+	pkg_stats->current_rx_rate = calc_rate(0, HZ, pkg_stats->rx_frames_delta);
 
 	/* check / update maximum values */
-	if (can_stats->max_tx_rate < can_stats->current_tx_rate)
-		can_stats->max_tx_rate = can_stats->current_tx_rate;
+	if (pkg_stats->max_tx_rate < pkg_stats->current_tx_rate)
+		pkg_stats->max_tx_rate = pkg_stats->current_tx_rate;
 
-	if (can_stats->max_rx_rate < can_stats->current_rx_rate)
-		can_stats->max_rx_rate = can_stats->current_rx_rate;
+	if (pkg_stats->max_rx_rate < pkg_stats->current_rx_rate)
+		pkg_stats->max_rx_rate = pkg_stats->current_rx_rate;
 
-	if (can_stats->max_rx_match_ratio < can_stats->current_rx_match_ratio)
-		can_stats->max_rx_match_ratio = can_stats->current_rx_match_ratio;
+	if (pkg_stats->max_rx_match_ratio < pkg_stats->current_rx_match_ratio)
+		pkg_stats->max_rx_match_ratio = pkg_stats->current_rx_match_ratio;
 
 	/* clear values for 'current rate' calculation */
-	can_stats->tx_frames_delta = 0;
-	can_stats->rx_frames_delta = 0;
-	can_stats->matches_delta   = 0;
+	pkg_stats->tx_frames_delta = 0;
+	pkg_stats->rx_frames_delta = 0;
+	pkg_stats->matches_delta   = 0;
 
 	/* restart timer (one second) */
 	mod_timer(&net->can.can_stattimer, round_jiffies(jiffies + HZ));
@@ -212,60 +212,60 @@ static void can_print_recv_banner(struct seq_file *m)
 static int can_stats_proc_show(struct seq_file *m, void *v)
 {
 	struct net *net = m->private;
-	struct can_pkg_stats *can_stats = net->can.pkg_stats;
-	struct can_rcv_lists_stats *can_pstats = net->can.rcv_lists_stats;
+	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
+	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 
 	seq_putc(m, '\n');
-	seq_printf(m, " %8ld transmitted frames (TXF)\n", can_stats->tx_frames);
-	seq_printf(m, " %8ld received frames (RXF)\n", can_stats->rx_frames);
-	seq_printf(m, " %8ld matched frames (RXMF)\n", can_stats->matches);
+	seq_printf(m, " %8ld transmitted frames (TXF)\n", pkg_stats->tx_frames);
+	seq_printf(m, " %8ld received frames (RXF)\n", pkg_stats->rx_frames);
+	seq_printf(m, " %8ld matched frames (RXMF)\n", pkg_stats->matches);
 
 	seq_putc(m, '\n');
 
 	if (net->can.can_stattimer.function == can_stat_update) {
 		seq_printf(m, " %8ld %% total match ratio (RXMR)\n",
-				can_stats->total_rx_match_ratio);
+				pkg_stats->total_rx_match_ratio);
 
 		seq_printf(m, " %8ld frames/s total tx rate (TXR)\n",
-				can_stats->total_tx_rate);
+				pkg_stats->total_tx_rate);
 		seq_printf(m, " %8ld frames/s total rx rate (RXR)\n",
-				can_stats->total_rx_rate);
+				pkg_stats->total_rx_rate);
 
 		seq_putc(m, '\n');
 
 		seq_printf(m, " %8ld %% current match ratio (CRXMR)\n",
-				can_stats->current_rx_match_ratio);
+				pkg_stats->current_rx_match_ratio);
 
 		seq_printf(m, " %8ld frames/s current tx rate (CTXR)\n",
-				can_stats->current_tx_rate);
+				pkg_stats->current_tx_rate);
 		seq_printf(m, " %8ld frames/s current rx rate (CRXR)\n",
-				can_stats->current_rx_rate);
+				pkg_stats->current_rx_rate);
 
 		seq_putc(m, '\n');
 
 		seq_printf(m, " %8ld %% max match ratio (MRXMR)\n",
-				can_stats->max_rx_match_ratio);
+				pkg_stats->max_rx_match_ratio);
 
 		seq_printf(m, " %8ld frames/s max tx rate (MTXR)\n",
-				can_stats->max_tx_rate);
+				pkg_stats->max_tx_rate);
 		seq_printf(m, " %8ld frames/s max rx rate (MRXR)\n",
-				can_stats->max_rx_rate);
+				pkg_stats->max_rx_rate);
 
 		seq_putc(m, '\n');
 	}
 
 	seq_printf(m, " %8ld current receive list entries (CRCV)\n",
-			can_pstats->rcv_entries);
+			rcv_lists_stats->rcv_entries);
 	seq_printf(m, " %8ld maximum receive list entries (MRCV)\n",
-			can_pstats->rcv_entries_max);
+			rcv_lists_stats->rcv_entries_max);
 
-	if (can_pstats->stats_reset)
+	if (rcv_lists_stats->stats_reset)
 		seq_printf(m, "\n %8ld statistic resets (STR)\n",
-				can_pstats->stats_reset);
+				rcv_lists_stats->stats_reset);
 
-	if (can_pstats->user_reset)
+	if (rcv_lists_stats->user_reset)
 		seq_printf(m, " %8ld user statistic resets (USTR)\n",
-				can_pstats->user_reset);
+				rcv_lists_stats->user_reset);
 
 	seq_putc(m, '\n');
 	return 0;
@@ -274,20 +274,20 @@ static int can_stats_proc_show(struct seq_file *m, void *v)
 static int can_reset_stats_proc_show(struct seq_file *m, void *v)
 {
 	struct net *net = m->private;
-	struct can_rcv_lists_stats *can_pstats = net->can.rcv_lists_stats;
-	struct can_pkg_stats *can_stats = net->can.pkg_stats;
+	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
+	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
 
 	user_reset = 1;
 
 	if (net->can.can_stattimer.function == can_stat_update) {
 		seq_printf(m, "Scheduled statistic reset #%ld.\n",
-				can_pstats->stats_reset + 1);
+				rcv_lists_stats->stats_reset + 1);
 	} else {
-		if (can_stats->jiffies_init != jiffies)
+		if (pkg_stats->jiffies_init != jiffies)
 			can_init_stats(net);
 
 		seq_printf(m, "Performed statistic reset #%ld.\n",
-				can_pstats->stats_reset);
+				rcv_lists_stats->stats_reset);
 	}
 	return 0;
 }
-- 
2.23.0.rc1

