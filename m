Return-Path: <linux-can+bounces-3039-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD33A597A0
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 15:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1BB16D1F2
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48CB1B4140;
	Mon, 10 Mar 2025 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OJxVzHfg";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="U/LwB5VG"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D8199223
	for <linux-can@vger.kernel.org>; Mon, 10 Mar 2025 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617252; cv=pass; b=E8HgaCynOPOz5BfeUQU1lsOtsuMeZ/P/NmVBjiuHxczO+BpLHj6ipQxb3PuuWoKeDPYprps1AqtlaGGTJ6lf96iujRmWjZsP41fdaX60EPYrecxMP1JqS3q2ezVkD7dJQBS6CfZb1xIMJt6I/Emr2hy8sco09pV+aUgqKzl+on8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617252; c=relaxed/simple;
	bh=SU3sYXH/57PV18g6IY6TAxzbDfVk/xMT4GwauBrAwKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UPMcndbq5Omc2Zmu4rhwl3tTy3AqkY2T6/cwlGDwJoG6Kd/W8aF9mg11nBuO+sN33hYY6h7PDmuVxydovwmSc4gA4l+iJJfKsn7S+ppzncM74wmHgRNlctwdca+6sbmvY3TzEKCsPeE9IMNG11a3RkNJZQ+NO0qP5X7THREQ/b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OJxVzHfg; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=U/LwB5VG; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1741617246; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gPg8WgAmhEgVnp3i6eLr9Az6nDUpanF6FTyl/qPKLrmvp9Ttt8WuXXodq34OGVgQa2
    2Cvm1nE2Yy9Rl/GMZYlt34GgXqup9quWjnpujNVqFn0B4v7aOMmozS1uKAXZ1YqR/vSJ
    jugUGCRUCSujlxXC0A6W6IktO0cx0pzie6ilXOdAs3dQVS1ZMJkoHTSHN7JnpzMAM0YW
    okvDTNX5/2INnmS4kF/yy5XqwKyqEuPp52GNE63ic//pGrasm0e3now9U0714jkaoaeM
    WJkHcHI2fHgb/rm1duiDb7GsVlsD6liDiWqLC0Ky+HJxao9fUrh//+f9y+g5s/RmVPkJ
    It0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741617246;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ECh74csraaelB1qXDyMfEnIxMlVBn5iyWtLNaH2mJok=;
    b=hJ2GAoc6ObudfQ+60XRUfZ9W1JQklJYB/b04lkHIlYQTa0lmP4xO7OzRbULcVVLzrL
    zrFZu9byGkGBHi1HudpSS3yYIX3KIsb77MGCKBfw+Ldgs1cHhutxxb8r0Q345o9lDM2s
    wU1qayb5+CxVdE1cQsXUbEv+EFTb7mVJjuhhOUU9Y1e65Bep/7+e8A99v4/z5uh8I4aE
    Q7UU6KgtTzypFmyXhQ049eOLINlu7bUp2aWOsmgUBspearq5fIxobDp7K+pTOdkhXzb0
    ZJaw6f02rNah2s7gQcGUADX1i0B6wm4oyoWwLfVk5Rf5OjGMT5tknnVPv9iTphvVJOIg
    iLVg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741617246;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ECh74csraaelB1qXDyMfEnIxMlVBn5iyWtLNaH2mJok=;
    b=OJxVzHfgTODNOrizMtJSo2l5WwIsdT++OEzT1BxKH5/wnH5b9etc8Hbi12M1lgZ7uw
    ZE4k1m8JoZkPn/tfeGUwgRqhzzpeqImuWneqymbDEFRSz0Fu3ZzhDHXMTeqSuEG1lAF9
    eRsvTFEeKPOpfQrYcQVDdQbERwsJmUcsgXQBKnB9q6wb70Bq3PidlfXJmNJwQoSdPLYf
    8dbjb/Wqpmh1ozGHb8SgU9V4h8/eD4Zkuis/XdOBk5lG4enu5/wE7Js2vVdF2FVX8XiY
    m9yiKCiyC1MlUCkGRBsz8uUbsg7oKfTbX0hbfypFgyTUYA8riFi64tDTiMOERSrEDH+v
    /7eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741617246;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ECh74csraaelB1qXDyMfEnIxMlVBn5iyWtLNaH2mJok=;
    b=U/LwB5VGq7q6fdiqRk8q86QoSfqPmag0KZTWaNdYPcic+cGnauWvu0QchBnJMR+96N
    4eBUhQ1jRjXPMhoZc2Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e512AEY6Uja
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 10 Mar 2025 15:34:06 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com
Subject: [PATCH] can: statistics: use atomic access in hot path
Date: Mon, 10 Mar 2025 15:33:53 +0100
Message-ID: <20250310143353.3242-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

In can_send() and can_receive() CAN messages and CAN filter matches are
counted to be visible in the CAN procfs files.

KCSAN detected a data race within can_send() when two CAN frames have
been generated by a timer event writing to the same CAN netdevice at the
same time. Use atomic operations to access the statistics in the hot path
to fix the KCSAN complaint.

Reported-by: syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/af_can.c | 12 ++++++------
 net/can/af_can.h | 12 ++++++------
 net/can/proc.c   | 46 +++++++++++++++++++++++++++-------------------
 3 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 01f3fbb3b67d..65230e81fa08 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -285,12 +285,12 @@ int can_send(struct sk_buff *skb, int loop)
 
 	if (newskb)
 		netif_rx(newskb);
 
 	/* update statistics */
-	pkg_stats->tx_frames++;
-	pkg_stats->tx_frames_delta++;
+	atomic_long_inc(&pkg_stats->tx_frames);
+	atomic_long_inc(&pkg_stats->tx_frames_delta);
 
 	return 0;
 
 inval_skb:
 	kfree_skb(skb);
@@ -645,12 +645,12 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	struct net *net = dev_net(dev);
 	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
 	int matches;
 
 	/* update statistics */
-	pkg_stats->rx_frames++;
-	pkg_stats->rx_frames_delta++;
+	atomic_long_inc(&pkg_stats->rx_frames);
+	atomic_long_inc(&pkg_stats->rx_frames_delta);
 
 	/* create non-zero unique skb identifier together with *skb */
 	while (!(can_skb_prv(skb)->skbcnt))
 		can_skb_prv(skb)->skbcnt = atomic_inc_return(&skbcounter);
 
@@ -667,12 +667,12 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 
 	/* consume the skbuff allocated by the netdevice driver */
 	consume_skb(skb);
 
 	if (matches > 0) {
-		pkg_stats->matches++;
-		pkg_stats->matches_delta++;
+		atomic_long_inc(&pkg_stats->matches);
+		atomic_long_inc(&pkg_stats->matches_delta);
 	}
 }
 
 static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		   struct packet_type *pt, struct net_device *orig_dev)
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 7c2d9161e224..22f3352c77fe 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -64,13 +64,13 @@ struct receiver {
 
 /* can be reset e.g. by can_init_stats() */
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
 	unsigned long total_rx_match_ratio;
 
@@ -80,13 +80,13 @@ struct can_pkg_stats {
 
 	unsigned long max_rx_rate;
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
 struct can_rcv_lists_stats {
 	unsigned long stats_reset;
diff --git a/net/can/proc.c b/net/can/proc.c
index bbce97825f13..25fdf060e30d 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -116,48 +116,53 @@ void can_stat_update(struct timer_list *t)
 {
 	struct net *net = from_timer(net, t, can.stattimer);
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
 
 	/* restart counting on jiffies overflow */
 	if (j < pkg_stats->jiffies_init)
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
 		pkg_stats->max_tx_rate = pkg_stats->current_tx_rate;
 
@@ -166,13 +171,13 @@ void can_stat_update(struct timer_list *t)
 
 	if (pkg_stats->max_rx_match_ratio < pkg_stats->current_rx_match_ratio)
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
 }
 
@@ -212,13 +217,16 @@ static int can_stats_proc_show(struct seq_file *m, void *v)
 	struct net *net = m->private;
 	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
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
 
 	if (net->can.stattimer.function == can_stat_update) {
 		seq_printf(m, " %8ld %% total match ratio (RXMR)\n",
-- 
2.47.2


