Return-Path: <linux-can+bounces-3072-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8C0A6120A
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E811B62F6E
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 13:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13FC1F4722;
	Fri, 14 Mar 2025 13:09:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1261FE470
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957760; cv=none; b=CYRy0xocI+5lF5G6+OfBNsg/wZaeJfETxzyCfaNf+ehBnmaSMdKcsODsEG07Pm4j4ImHzOhw33ftgpj2Oaye8MsdsLV5hiqvbb/n2AUBHhhY3nmKJdhPBOLBM8autFd4vKfPN4+dsIJen2mHEyZvQwZ7mtl4VyP+iRr5SKaBIuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957760; c=relaxed/simple;
	bh=KimHpzC1wj7/b2yX4CJkec46k0I9JznTp2gZtkDvXck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0Y3qurnWxvAvqCqIAoKdgDZ0zN9FdXMlGpGhrl/h09X2Ge7oCvyGgEahgcPygKTIBK9gHIdbKTtm23jSvvtELwdh86Sw6+hBrXQoqIIuJuDHMpHqwrOy6aPEMNZ8pT4mFFHMEPM+CEgQEoGnfrcQY4BBz+/nZVEHHkbvtoPWm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt4mr-0007KI-6M
	for linux-can@vger.kernel.org; Fri, 14 Mar 2025 14:09:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt4mq-005ho9-0x
	for linux-can@vger.kernel.org;
	Fri, 14 Mar 2025 14:09:16 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id EF5623DBB70
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 13:09:15 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0EB1C3DBB4D;
	Fri, 14 Mar 2025 13:09:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a16014f1;
	Fri, 14 Mar 2025 13:09:12 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/6] can: statistics: use atomic access in hot path
Date: Fri, 14 Mar 2025 14:04:01 +0100
Message-ID: <20250314130909.2890541-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250314130909.2890541-1-mkl@pengutronix.de>
References: <20250314130909.2890541-1-mkl@pengutronix.de>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

In can_send() and can_receive() CAN messages and CAN filter matches are
counted to be visible in the CAN procfs files.

KCSAN detected a data race within can_send() when two CAN frames have
been generated by a timer event writing to the same CAN netdevice at the
same time. Use atomic operations to access the statistics in the hot path
to fix the KCSAN complaint.

Reported-by: syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67cd717d.050a0220.e1a89.0006.GAE@google.com
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250310143353.3242-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 12 ++++++------
 net/can/af_can.h | 12 ++++++------
 net/can/proc.c   | 46 +++++++++++++++++++++++++++-------------------
 3 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 01f3fbb3b67d..65230e81fa08 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -287,8 +287,8 @@ int can_send(struct sk_buff *skb, int loop)
 		netif_rx(newskb);
 
 	/* update statistics */
-	pkg_stats->tx_frames++;
-	pkg_stats->tx_frames_delta++;
+	atomic_long_inc(&pkg_stats->tx_frames);
+	atomic_long_inc(&pkg_stats->tx_frames_delta);
 
 	return 0;
 
@@ -647,8 +647,8 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	int matches;
 
 	/* update statistics */
-	pkg_stats->rx_frames++;
-	pkg_stats->rx_frames_delta++;
+	atomic_long_inc(&pkg_stats->rx_frames);
+	atomic_long_inc(&pkg_stats->rx_frames_delta);
 
 	/* create non-zero unique skb identifier together with *skb */
 	while (!(can_skb_prv(skb)->skbcnt))
@@ -669,8 +669,8 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	consume_skb(skb);
 
 	if (matches > 0) {
-		pkg_stats->matches++;
-		pkg_stats->matches_delta++;
+		atomic_long_inc(&pkg_stats->matches);
+		atomic_long_inc(&pkg_stats->matches_delta);
 	}
 }
 
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 7c2d9161e224..22f3352c77fe 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -66,9 +66,9 @@ struct receiver {
 struct can_pkg_stats {
 	unsigned long jiffies_init;
 
-	unsigned long rx_frames;
-	unsigned long tx_frames;
-	unsigned long matches;
+	atomic_long_t rx_frames;
+	atomic_long_t tx_frames;
+	atomic_long_t matches;
 
 	unsigned long total_rx_rate;
 	unsigned long total_tx_rate;
@@ -82,9 +82,9 @@ struct can_pkg_stats {
 	unsigned long max_tx_rate;
 	unsigned long max_rx_match_ratio;
 
-	unsigned long rx_frames_delta;
-	unsigned long tx_frames_delta;
-	unsigned long matches_delta;
+	atomic_long_t rx_frames_delta;
+	atomic_long_t tx_frames_delta;
+	atomic_long_t matches_delta;
 };
 
 /* persistent statistics */
diff --git a/net/can/proc.c b/net/can/proc.c
index bbce97825f13..25fdf060e30d 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -118,6 +118,13 @@ void can_stat_update(struct timer_list *t)
 	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
 	unsigned long j = jiffies; /* snapshot */
 
+	long rx_frames = atomic_long_read(&pkg_stats->rx_frames);
+	long tx_frames = atomic_long_read(&pkg_stats->tx_frames);
+	long matches = atomic_long_read(&pkg_stats->matches);
+	long rx_frames_delta = atomic_long_read(&pkg_stats->rx_frames_delta);
+	long tx_frames_delta = atomic_long_read(&pkg_stats->tx_frames_delta);
+	long matches_delta = atomic_long_read(&pkg_stats->matches_delta);
+
 	/* restart counting in timer context on user request */
 	if (user_reset)
 		can_init_stats(net);
@@ -127,35 +134,33 @@ void can_stat_update(struct timer_list *t)
 		can_init_stats(net);
 
 	/* prevent overflow in calc_rate() */
-	if (pkg_stats->rx_frames > (ULONG_MAX / HZ))
+	if (rx_frames > (LONG_MAX / HZ))
 		can_init_stats(net);
 
 	/* prevent overflow in calc_rate() */
-	if (pkg_stats->tx_frames > (ULONG_MAX / HZ))
+	if (tx_frames > (LONG_MAX / HZ))
 		can_init_stats(net);
 
 	/* matches overflow - very improbable */
-	if (pkg_stats->matches > (ULONG_MAX / 100))
+	if (matches > (LONG_MAX / 100))
 		can_init_stats(net);
 
 	/* calc total values */
-	if (pkg_stats->rx_frames)
-		pkg_stats->total_rx_match_ratio = (pkg_stats->matches * 100) /
-			pkg_stats->rx_frames;
+	if (rx_frames)
+		pkg_stats->total_rx_match_ratio = (matches * 100) / rx_frames;
 
 	pkg_stats->total_tx_rate = calc_rate(pkg_stats->jiffies_init, j,
-					    pkg_stats->tx_frames);
+					    tx_frames);
 	pkg_stats->total_rx_rate = calc_rate(pkg_stats->jiffies_init, j,
-					    pkg_stats->rx_frames);
+					    rx_frames);
 
 	/* calc current values */
-	if (pkg_stats->rx_frames_delta)
+	if (rx_frames_delta)
 		pkg_stats->current_rx_match_ratio =
-			(pkg_stats->matches_delta * 100) /
-			pkg_stats->rx_frames_delta;
+			(matches_delta * 100) /	rx_frames_delta;
 
-	pkg_stats->current_tx_rate = calc_rate(0, HZ, pkg_stats->tx_frames_delta);
-	pkg_stats->current_rx_rate = calc_rate(0, HZ, pkg_stats->rx_frames_delta);
+	pkg_stats->current_tx_rate = calc_rate(0, HZ, tx_frames_delta);
+	pkg_stats->current_rx_rate = calc_rate(0, HZ, rx_frames_delta);
 
 	/* check / update maximum values */
 	if (pkg_stats->max_tx_rate < pkg_stats->current_tx_rate)
@@ -168,9 +173,9 @@ void can_stat_update(struct timer_list *t)
 		pkg_stats->max_rx_match_ratio = pkg_stats->current_rx_match_ratio;
 
 	/* clear values for 'current rate' calculation */
-	pkg_stats->tx_frames_delta = 0;
-	pkg_stats->rx_frames_delta = 0;
-	pkg_stats->matches_delta   = 0;
+	atomic_long_set(&pkg_stats->tx_frames_delta, 0);
+	atomic_long_set(&pkg_stats->rx_frames_delta, 0);
+	atomic_long_set(&pkg_stats->matches_delta, 0);
 
 	/* restart timer (one second) */
 	mod_timer(&net->can.stattimer, round_jiffies(jiffies + HZ));
@@ -214,9 +219,12 @@ static int can_stats_proc_show(struct seq_file *m, void *v)
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 
 	seq_putc(m, '\n');
-	seq_printf(m, " %8ld transmitted frames (TXF)\n", pkg_stats->tx_frames);
-	seq_printf(m, " %8ld received frames (RXF)\n", pkg_stats->rx_frames);
-	seq_printf(m, " %8ld matched frames (RXMF)\n", pkg_stats->matches);
+	seq_printf(m, " %8ld transmitted frames (TXF)\n",
+		   atomic_long_read(&pkg_stats->tx_frames));
+	seq_printf(m, " %8ld received frames (RXF)\n",
+		   atomic_long_read(&pkg_stats->rx_frames));
+	seq_printf(m, " %8ld matched frames (RXMF)\n",
+		   atomic_long_read(&pkg_stats->matches));
 
 	seq_putc(m, '\n');
 
-- 
2.47.2



