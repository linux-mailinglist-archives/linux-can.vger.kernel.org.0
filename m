Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199B13AFD53
	for <lists+linux-can@lfdr.de>; Tue, 22 Jun 2021 08:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhFVGwp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Jun 2021 02:52:45 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7373 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhFVGwo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Jun 2021 02:52:44 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G8H3t3nV3z71L9;
        Tue, 22 Jun 2021 14:46:18 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 14:50:23 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 14:50:23 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>
CC:     <olteanv@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <edumazet@google.com>, <weiwan@google.com>,
        <cong.wang@bytedance.com>, <ap420073@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <andrii@kernel.org>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <bpf@vger.kernel.org>, <jonas.bonn@netrounds.com>,
        <pabeni@redhat.com>, <mzhivich@akamai.com>, <johunt@akamai.com>,
        <albcamus@gmail.com>, <kehuan.feng@gmail.com>,
        <a.fatoum@pengutronix.de>, <atenart@kernel.org>,
        <alexander.duyck@gmail.com>, <hdanton@sina.com>, <jgross@suse.com>,
        <JKosina@suse.com>, <mkubecek@suse.cz>, <bjorn@kernel.org>,
        <alobakin@pm.me>
Subject: [PATCH net-next v3 2/3] net: sched: implement TCQ_F_CAN_BYPASS for lockless qdisc
Date:   Tue, 22 Jun 2021 14:49:56 +0800
Message-ID: <1624344597-11806-3-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624344597-11806-1-git-send-email-linyunsheng@huawei.com>
References: <1624344597-11806-1-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Currently pfifo_fast has both TCQ_F_CAN_BYPASS and TCQ_F_NOLOCK
flag set, but queue discipline by-pass does not work for lockless
qdisc because skb is always enqueued to qdisc even when the qdisc
is empty, see __dev_xmit_skb().

This patch calls sch_direct_xmit() to transmit the skb directly
to the driver for empty lockless qdisc, which aviod enqueuing
and dequeuing operation.

As qdisc->empty is not reliable to indicate a empty qdisc because
there is a time window between enqueuing and setting qdisc->empty.
So we use the MISSED state added in commit a90c57f2cedd ("net:
sched: fix packet stuck problem for lockless qdisc"), which
indicate there is lock contention, suggesting that it is better
not to do the qdisc bypass in order to avoid packet out of order
problem.

In order to make MISSED state reliable to indicate a empty qdisc,
we need to ensure that testing and clearing of MISSED state is
within the protection of qdisc->seqlock, only setting MISSED state
can be done without the protection of qdisc->seqlock. A MISSED
state testing is added without the protection of qdisc->seqlock to
aviod doing unnecessary spin_trylock() for contention case.

As the enqueuing is not within the protection of qdisc->seqlock,
there is still a potential data race as mentioned by Jakub [1]:

      thread1               thread2             thread3
qdisc_run_begin() # true
                        qdisc_run_begin(q)
                             set(MISSED)
pfifo_fast_dequeue
  clear(MISSED)
  # recheck the queue
qdisc_run_end()
                            enqueue skb1
                                             qdisc empty # true
                                          qdisc_run_begin() # true
                                          sch_direct_xmit() # skb2
                         qdisc_run_begin()
                            set(MISSED)

When above happens, skb1 enqueued by thread2 is transmited after
skb2 is transmited by thread3 because MISSED state setting and
enqueuing is not under the qdisc->seqlock. If qdisc bypass is
disabled, skb1 has better chance to be transmited quicker than
skb2.

This patch does not take care of the above data race, because we
view this as similar as below:
Even at the same time CPU1 and CPU2 write the skb to two socket
which both heading to the same qdisc, there is no guarantee that
which skb will hit the qdisc first, because there is a lot of
factor like interrupt/softirq/cache miss/scheduling afffecting
that.

There are below cases that need special handling:
1. When MISSED state is cleared before another round of dequeuing
   in pfifo_fast_dequeue(), and __qdisc_run() might not be able to
   dequeue all skb in one round and call __netif_schedule(), which
   might result in a non-empty qdisc without MISSED set. In order
   to avoid this, the MISSED state is set for lockless qdisc and
   __netif_schedule() will be called at the end of qdisc_run_end.

2. The MISSED state also need to be set for lockless qdisc instead
   of calling __netif_schedule() directly when requeuing a skb for
   a similar reason.

3. For netdev queue stopped case, the MISSED case need clearing
   while the netdev queue is stopped, otherwise there may be
   unnecessary __netif_schedule() calling. So a new DRAINING state
   is added to indicate this case, which also indicate a non-empty
   qdisc.

4. As there is already netif_xmit_frozen_or_stopped() checking in
   dequeue_skb() and sch_direct_xmit(), which are both within the
   protection of qdisc->seqlock, but the same checking in
   __dev_xmit_skb() is without the protection, which might cause
   empty indication of a lockless qdisc to be not reliable. So
   remove the checking in __dev_xmit_skb(), and the checking in
   the protection of qdisc->seqlock seems enough to avoid the cpu
   consumption problem for netdev queue stopped case.

1. https://lkml.org/lkml/2021/5/29/215

Acked-by: Jakub Kicinski <kuba@kernel.org>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # flexcan
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
V2: Adjust the comment and commit log according to discussion
    in V1.
V1: Add nolock_qdisc_is_empty() and do the qdisc empty checking
    without the protection of qdisc->seqlock to aviod doing
    unnecessary spin_trylock() for contention case.
RFC v4: Use STATE_MISSED and STATE_DRAINING to indicate non-empty
        qdisc.
---
 include/net/sch_generic.h | 16 +++++++++++++---
 net/core/dev.c            | 27 +++++++++++++++++++++++++--
 net/sched/sch_generic.c   | 20 ++++++++++++++++----
 3 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 3ed6bcc..177f240 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -37,8 +37,15 @@ enum qdisc_state_t {
 	__QDISC_STATE_SCHED,
 	__QDISC_STATE_DEACTIVATED,
 	__QDISC_STATE_MISSED,
+	__QDISC_STATE_DRAINING,
 };
 
+#define QDISC_STATE_MISSED	BIT(__QDISC_STATE_MISSED)
+#define QDISC_STATE_DRAINING	BIT(__QDISC_STATE_DRAINING)
+
+#define QDISC_STATE_NON_EMPTY	(QDISC_STATE_MISSED | \
+					QDISC_STATE_DRAINING)
+
 struct qdisc_size_table {
 	struct rcu_head		rcu;
 	struct list_head	list;
@@ -145,6 +152,11 @@ static inline bool qdisc_is_running(struct Qdisc *qdisc)
 	return (raw_read_seqcount(&qdisc->running) & 1) ? true : false;
 }
 
+static inline bool nolock_qdisc_is_empty(const struct Qdisc *qdisc)
+{
+	return !(READ_ONCE(qdisc->state) & QDISC_STATE_NON_EMPTY);
+}
+
 static inline bool qdisc_is_percpu_stats(const struct Qdisc *q)
 {
 	return q->flags & TCQ_F_CPUSTATS;
@@ -206,10 +218,8 @@ static inline void qdisc_run_end(struct Qdisc *qdisc)
 		spin_unlock(&qdisc->seqlock);
 
 		if (unlikely(test_bit(__QDISC_STATE_MISSED,
-				      &qdisc->state))) {
-			clear_bit(__QDISC_STATE_MISSED, &qdisc->state);
+				      &qdisc->state)))
 			__netif_schedule(qdisc);
-		}
 	} else {
 		write_seqcount_end(&qdisc->running);
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index 50531a2..991d09b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3852,10 +3852,33 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	qdisc_calculate_pkt_len(skb, q);
 
 	if (q->flags & TCQ_F_NOLOCK) {
+		if (q->flags & TCQ_F_CAN_BYPASS && nolock_qdisc_is_empty(q) &&
+		    qdisc_run_begin(q)) {
+			/* Retest nolock_qdisc_is_empty() within the protection
+			 * of q->seqlock to protect from racing with requeuing.
+			 */
+			if (unlikely(!nolock_qdisc_is_empty(q))) {
+				rc = q->enqueue(skb, q, &to_free) &
+					NET_XMIT_MASK;
+				__qdisc_run(q);
+				qdisc_run_end(q);
+
+				goto no_lock_out;
+			}
+
+			qdisc_bstats_cpu_update(q, skb);
+			if (sch_direct_xmit(skb, q, dev, txq, NULL, true) &&
+			    !nolock_qdisc_is_empty(q))
+				__qdisc_run(q);
+
+			qdisc_run_end(q);
+			return NET_XMIT_SUCCESS;
+		}
+
 		rc = q->enqueue(skb, q, &to_free) & NET_XMIT_MASK;
-		if (likely(!netif_xmit_frozen_or_stopped(txq)))
-			qdisc_run(q);
+		qdisc_run(q);
 
+no_lock_out:
 		if (unlikely(to_free))
 			kfree_skb_list(to_free);
 		return rc;
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index e9c0afc8..9984ccc 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -52,6 +52,8 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q,
 	 */
 	if (!netif_xmit_frozen_or_stopped(txq))
 		set_bit(__QDISC_STATE_MISSED, &q->state);
+	else
+		set_bit(__QDISC_STATE_DRAINING, &q->state);
 }
 
 /* Main transmission queue. */
@@ -164,9 +166,13 @@ static inline void dev_requeue_skb(struct sk_buff *skb, struct Qdisc *q)
 
 		skb = next;
 	}
-	if (lock)
+
+	if (lock) {
 		spin_unlock(lock);
-	__netif_schedule(q);
+		set_bit(__QDISC_STATE_MISSED, &q->state);
+	} else {
+		__netif_schedule(q);
+	}
 }
 
 static void try_bulk_dequeue_skb(struct Qdisc *q,
@@ -409,7 +415,11 @@ void __qdisc_run(struct Qdisc *q)
 	while (qdisc_restart(q, &packets)) {
 		quota -= packets;
 		if (quota <= 0) {
-			__netif_schedule(q);
+			if (q->flags & TCQ_F_NOLOCK)
+				set_bit(__QDISC_STATE_MISSED, &q->state);
+			else
+				__netif_schedule(q);
+
 			break;
 		}
 	}
@@ -698,13 +708,14 @@ static struct sk_buff *pfifo_fast_dequeue(struct Qdisc *qdisc)
 	if (likely(skb)) {
 		qdisc_update_stats_at_dequeue(qdisc, skb);
 	} else if (need_retry &&
-		   test_bit(__QDISC_STATE_MISSED, &qdisc->state)) {
+		   READ_ONCE(qdisc->state) & QDISC_STATE_NON_EMPTY) {
 		/* Delay clearing the STATE_MISSED here to reduce
 		 * the overhead of the second spin_trylock() in
 		 * qdisc_run_begin() and __netif_schedule() calling
 		 * in qdisc_run_end().
 		 */
 		clear_bit(__QDISC_STATE_MISSED, &qdisc->state);
+		clear_bit(__QDISC_STATE_DRAINING, &qdisc->state);
 
 		/* Make sure dequeuing happens after clearing
 		 * STATE_MISSED.
@@ -1222,6 +1233,7 @@ static void dev_reset_queue(struct net_device *dev,
 	spin_unlock_bh(qdisc_lock(qdisc));
 	if (nolock) {
 		clear_bit(__QDISC_STATE_MISSED, &qdisc->state);
+		clear_bit(__QDISC_STATE_DRAINING, &qdisc->state);
 		spin_unlock_bh(&qdisc->seqlock);
 	}
 }
-- 
2.7.4

