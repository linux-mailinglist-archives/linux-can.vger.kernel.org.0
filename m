Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8FF27989
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfEWJlz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40225 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730298AbfEWJlz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:55 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEN-0001G7-3K; Thu, 23 May 2019 11:41:47 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-00045O-KB; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 14/17] j1939: implement session queue
Date:   Thu, 23 May 2019 11:41:36 +0200
Message-Id: <20190523094139.15517-15-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523094139.15517-1-o.rempel@pengutronix.de>
References: <20190523094139.15517-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  11 ++-
 net/can/j1939/socket.c     | 168 +++++++++++++++++++++++++++----------
 net/can/j1939/transport.c  |  46 ++++++++--
 3 files changed, 167 insertions(+), 58 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 08de30e87779..b53e2ddd317e 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -168,6 +168,7 @@ void j1939_sk_send_multi_abort(struct j1939_priv *priv, struct sock *sk,
 			       int err);
 void j1939_sk_errqueue(struct j1939_session *session,
 		       enum j1939_sk_errqueue_type type);
+void j1939_sk_queue_activate_next(struct j1939_session *session);
 
 /* stack entries */
 struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
@@ -207,6 +208,7 @@ enum j1939_session_state {
 struct j1939_session {
 	struct j1939_priv *priv;
 	struct list_head list;
+	struct list_head jsk_fifo;
 	struct kref kref;
 	spinlock_t lock;
 	struct sock *sk;
@@ -229,6 +231,8 @@ struct j1939_session {
 	bool transmission;
 	bool extd;
 	unsigned int total_message_size; /* Total message size, number of bytes */
+	unsigned int total_queued_size; /* Total number of bytes queue from socket
+					   to the session */
 	int err;
 	u32 tskey;
 	enum j1939_session_state state;
@@ -273,9 +277,6 @@ struct j1939_sock {
 	int nfilters;
 	pgn_t pgn_rx_filter;
 
-	size_t etp_tx_complete_size;
-	size_t etp_tx_done_size;
-
 	/* j1939 may emit equal PGN (!= equal CAN-id's) out of order
 	 * when transport protocol comes in.
 	 * To allow emitting in order, keep a 'pending' nr. of packets
@@ -299,8 +300,10 @@ void j1939_session_skb_queue(struct j1939_session *session,
 struct j1939_session *j1939_session_get_by_skcb(struct j1939_priv *priv,
 						struct j1939_sk_buff_cb *skcb,
 						bool reverse);
-int j1939_session_insert(struct j1939_session *session);
+int j1939_session_activate(struct j1939_session *session);
+bool j1939_session_deactivate(struct j1939_session *session);
 void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec);
+void j1939_session_timers_cancel(struct j1939_session *session);
 
 #define J1939_MAX_TP_PACKET_SIZE (7 * 0xff)
 #define J1939_MAX_ETP_PACKET_SIZE (7 * 0x00ffffff)
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 41480980dfdb..0aa6582f36c3 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -69,6 +69,103 @@ void j1939_sock_pending_del(struct sock *sk)
 		wake_up(&jsk->waitq);	/* no pending SKB's */
 }
 
+static bool j1939_sk_queue_session(struct j1939_session *session)
+{
+	struct j1939_sock *jsk = j1939_sk(session->sk);
+	bool empty;
+
+	spin_lock_bh(&jsk->session_fifo_lock);
+	empty = list_empty(&jsk->session_fifo);
+	j1939_session_get(session);
+	list_add_tail(&session->jsk_fifo, &jsk->session_fifo);
+	spin_unlock_bh(&jsk->session_fifo_lock);
+	j1939_sock_pending_add(&jsk->sk);
+
+	return empty;
+}
+
+static struct
+j1939_session *j1939_sk_get_incomplete_session(struct j1939_sock *jsk)
+{
+	struct j1939_session *session = NULL;
+
+	spin_lock_bh(&jsk->session_fifo_lock);
+	if (!list_empty(&jsk->session_fifo)) {
+		session = list_last_entry(&jsk->session_fifo,
+					  struct j1939_session, jsk_fifo);
+		if (session->total_queued_size == session->total_message_size)
+			session = NULL;
+		else
+			j1939_session_get(session);
+	}
+	spin_unlock_bh(&jsk->session_fifo_lock);
+
+	return session;
+}
+
+static void j1939_sk_queue_drop_all(struct j1939_sock *jsk)
+{
+	struct j1939_session *session, *tmp;
+
+	spin_lock_bh(&jsk->session_fifo_lock);
+	list_for_each_entry_safe_reverse(session, tmp, &jsk->session_fifo,
+					 jsk_fifo) {
+		list_del_init(&session->jsk_fifo);
+		j1939_session_timers_cancel(session);
+		j1939_session_deactivate(session);
+		j1939_session_put(session);
+	}
+	spin_unlock_bh(&jsk->session_fifo_lock);
+}
+
+void j1939_sk_queue_activate_next_locked(struct j1939_session *session)
+{
+	struct j1939_sock *jsk;
+	struct j1939_session *cur, *next = NULL;
+	int err;
+
+	if (!session->sk)
+		return;
+
+	jsk = j1939_sk(session->sk);
+	lockdep_assert_held(&jsk->session_fifo_lock);
+
+	err = session->err;
+
+	cur = list_first_entry_or_null(&jsk->session_fifo,
+					struct j1939_session, jsk_fifo);
+	if (cur == session) {
+		list_del_init(&session->jsk_fifo);
+		j1939_session_put(session);
+		next = list_first_entry_or_null(&jsk->session_fifo,
+						struct j1939_session, jsk_fifo);
+		if (next) {
+			/* Give receiver some time (arbitrary chosen) to recover */
+			int time_ms = 0;
+
+			if (err)
+				time_ms = 10 + prandom_u32_max(16);
+
+			WARN_ON_ONCE(j1939_session_activate(next));
+			j1939_tp_schedule_txtimer(next, time_ms);
+		}
+	}
+}
+
+void j1939_sk_queue_activate_next(struct j1939_session *session)
+{
+	struct j1939_sock *jsk;
+
+	if (!session->sk)
+		return;
+
+	jsk = j1939_sk(session->sk);
+
+	spin_lock_bh(&jsk->session_fifo_lock);
+	j1939_sk_queue_activate_next_locked(session);
+	spin_unlock_bh(&jsk->session_fifo_lock);
+}
+
 static bool j1939_sk_match_dst(struct j1939_sock *jsk,
 			       const struct j1939_sk_buff_cb *skcb)
 {
@@ -204,8 +301,8 @@ static int j1939_sk_init(struct sock *sk)
 	jsk->addr.pgn = J1939_NO_PGN;
 	jsk->pgn_rx_filter = J1939_NO_PGN;
 	atomic_set(&jsk->skb_pending, 0);
-	jsk->etp_tx_complete_size = 0;
-	jsk->etp_tx_done_size = 0;
+	spin_lock_init(&jsk->session_fifo_lock);
+	INIT_LIST_HEAD(&jsk->session_fifo);
 
 	return 0;
 }
@@ -406,8 +503,9 @@ static int j1939_sk_release(struct socket *sock)
 		struct j1939_priv *priv;
 		struct net_device *ndev;
 
-		wait_event_interruptible(jsk->waitq,
-					 j1939_sock_pending_get(&jsk->sk) == 0);
+		if (wait_event_interruptible(jsk->waitq,
+					 j1939_sock_pending_get(&jsk->sk) == 0))
+			j1939_sk_queue_drop_all(jsk);
 
 		ndev = dev_get_by_index(sock_net(sk), jsk->ifindex);
 		priv = j1939_priv_get_by_ndev(ndev);
@@ -794,15 +892,14 @@ static int j1939_sk_send_multi(struct j1939_priv *priv,  struct sock *sk,
 
 {
 	struct j1939_sock *jsk = j1939_sk(sk);
-	struct j1939_session *session = NULL;
+	struct j1939_session *session = j1939_sk_get_incomplete_session(jsk);
 	struct sk_buff *skb;
 	size_t segment_size, todo_size;
 	int ret = 0;
 
-	if (!jsk->etp_tx_done_size) {
-		j1939_sock_pending_add(&jsk->sk);
-		jsk->etp_tx_complete_size = size;
-	} else if (jsk->etp_tx_complete_size != jsk->etp_tx_done_size + size) {
+	if (session &&
+	    session->total_message_size != session->total_queued_size + size) {
+		j1939_session_put(session);
 		return -EIO;
 	}
 
@@ -821,52 +918,34 @@ static int j1939_sk_send_multi(struct j1939_priv *priv,  struct sock *sk,
 			break;
 
 		skcb = j1939_skb_to_cb(skb);
-		skcb->offset = jsk->etp_tx_done_size;
 
 		if (!session) {
-			if (jsk->etp_tx_done_size) {
-				if (jsk->etp_tx_complete_size >
-				    J1939_MAX_TP_PACKET_SIZE)
-					skcb->addr.type = J1939_ETP;
-				else
-					skcb->addr.type = J1939_TP;
-
-				session = j1939_session_get_by_skcb(priv, skcb,
-								    false);
-				if (IS_ERR(session)) {
-					ret = PTR_ERR(session);
-					goto kfree_skb;
-				} else if (!session) {
-					ret = -ENOENT;
-					goto kfree_skb;
-				}
-
-				j1939_session_skb_queue(session, skb);
-			} else {
-				/* create new session with
-				 * etp_tx_complete_size and attach skb
-				 * segment
-				 */
-				session = j1939_tp_send(priv, skb,
-							jsk->etp_tx_complete_size);
-				if (IS_ERR(session)) {
-					ret = PTR_ERR(session);
-					goto kfree_skb;
-				}
-
-				if (!j1939_session_insert(session)) {
+			/* at this point the size should be full size of the
+			 * session */
+			skcb->offset = 0;
+			session = j1939_tp_send(priv, skb, size);
+			if (IS_ERR(session)) {
+				ret = PTR_ERR(session);
+				goto kfree_skb;
+			}
+			if (j1939_sk_queue_session(session)) {
+				/* try to activate session if we a fist in the
+				 * queue */
+				if (!j1939_session_activate(session)) {
 					j1939_tp_schedule_txtimer(session, 0);
 				} else {
 					ret = session->err = -EBUSY;
+					j1939_sk_queue_drop_all(jsk);
 					break;
 				}
 			}
 		} else {
+			skcb->offset = session->total_queued_size;
 			j1939_session_skb_queue(session, skb);
 		}
 
 		todo_size -= segment_size;
-		jsk->etp_tx_done_size += segment_size;
+		session->total_queued_size += segment_size;
 	}
 
 	switch (ret) {
@@ -876,7 +955,6 @@ static int j1939_sk_send_multi(struct j1939_priv *priv,  struct sock *sk,
 				    "no error found and not completely queued?! %zu\n",
 				    todo_size);
 		ret = size;
-		jsk->etp_tx_done_size = 0;
 		break;
 	case -ERESTARTSYS:
 		ret = -EINTR;
@@ -886,8 +964,7 @@ static int j1939_sk_send_multi(struct j1939_priv *priv,  struct sock *sk,
 			ret = size - todo_size;
 		break;
 	default: /* ERROR */
-		/* skb session queue will be purged if we are the last user */
-		jsk->etp_tx_done_size = 0;
+		break;
 	}
 
 	if (session)
@@ -897,7 +974,6 @@ static int j1939_sk_send_multi(struct j1939_priv *priv,  struct sock *sk,
 
  kfree_skb:
 	kfree_skb(skb);
-	jsk->etp_tx_done_size = 0;
 	return ret;
 }
 
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index e2343978f695..16d42752f8f0 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -248,14 +248,11 @@ static void __j1939_session_drop(struct j1939_session *session)
 
 static void j1939_session_destroy(struct j1939_session *session)
 {
-
 	if (session->err)
 		j1939_sk_errqueue(session, J1939_ERRQUEUE_ABORT);
 	else
 		j1939_sk_errqueue(session, J1939_ERRQUEUE_ACK);
-	j1939_session_list_lock(session->priv);
-	j1939_session_list_del(session);
-	j1939_session_list_unlock(session->priv);
+
 	skb_queue_purge(&session->skb_queue);
 	__j1939_session_drop(session);
 	j1939_priv_put(session->priv);
@@ -287,7 +284,7 @@ static void j1939_session_rxtimer_cancel(struct j1939_session *session)
 		j1939_session_put(session);
 }
 
-static void j1939_session_timers_cancel(struct j1939_session *session)
+void j1939_session_timers_cancel(struct j1939_session *session)
 {
 	j1939_session_txtimer_cancel(session);
 	j1939_session_rxtimer_cancel(session);
@@ -840,6 +837,30 @@ static int j1939_tp_txnext(struct j1939_session *session)
 	return ret;
 }
 
+bool j1939_session_deactivate(struct j1939_session *session)
+{
+	bool active = false;
+
+	j1939_session_list_lock(session->priv);
+	if (session->state == J1939_SESSION_ACTIVE) {
+		active = true;
+
+		j1939_session_list_del(session);
+		session->state = J1939_SESSION_DONE;
+		j1939_session_put(session);
+
+	}
+	j1939_session_list_unlock(session->priv);
+
+	return active;
+}
+
+static void j1939_session_deactivate_activate_next(struct j1939_session *session)
+{
+	if (j1939_session_deactivate(session))
+		j1939_sk_queue_activate_next(session);
+}
+
 static void j1939_session_cancel(struct j1939_session *session,
 				 enum j1939_xtp_abort err)
 {
@@ -868,9 +889,12 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		struct j1939_priv *priv = session->priv;
 		struct sk_buff *se_skb = j1939_session_skb_find(session);
 
-		if (se_skb)
+		if (se_skb) {
 			ret = j1939_send_one(priv,
 					     skb_clone(se_skb, GFP_ATOMIC));
+			if (!ret)
+				j1939_session_deactivate_activate_next(session);
+		}
 	} else {
 		ret = j1939_tp_txnext(session);
 	}
@@ -892,6 +916,8 @@ static void j1939_session_completed(struct j1939_session *session)
 
 	/* distribute among j1939 receivers */
 	j1939_sk_recv(session->priv, se_skb);
+
+	j1939_session_deactivate_activate_next(session);
 }
 
 static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
@@ -963,6 +989,7 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 	if (session->sk)
 		j1939_sk_send_multi_abort(priv, session->sk,
 					  session->err);
+	j1939_session_deactivate_activate_next(session);
 
 	j1939_session_put(session);
 }
@@ -1077,6 +1104,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	if (!session)
 		return NULL;
 	INIT_LIST_HEAD(&session->list);
+	INIT_LIST_HEAD(&session->jsk_fifo);
 	spin_lock_init(&session->lock);
 	kref_init(&session->kref);
 
@@ -1135,7 +1163,7 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	return session;
 }
 
-static int j1939_session_insert(struct j1939_session *session)
+int j1939_session_activate(struct j1939_session *session)
 {
 	struct j1939_priv *priv = session->priv;
 	struct j1939_session *pending;
@@ -1150,6 +1178,7 @@ static int j1939_session_insert(struct j1939_session *session)
 	} else {
 		WARN_ON_ONCE(session->state != J1939_SESSION_NEW);
 		j1939_session_list_add(session);
+		j1939_session_get(session);
 		session->state = J1939_SESSION_ACTIVE;
 	}
 	j1939_session_list_unlock(priv);
@@ -1221,7 +1250,7 @@ j1939_session *j1939_xtp_rx_rts_new(struct j1939_priv *priv,
 	session->pkt.done = 0;
 	session->pkt.tx = 0;
 
-	WARN_ON_ONCE(j1939_session_insert(session));
+	WARN_ON_ONCE(j1939_session_activate(session));
 
 	return session;
 }
@@ -1603,6 +1632,7 @@ int j1939_tp_rmdev_notifier(struct j1939_priv *priv)
 	list_for_each_entry_safe(session, saved,
 				 &priv->tp_sessionq, list) {
 		j1939_session_timers_cancel(session);
+		j1939_session_deactivate_activate_next(session);
 	}
 	j1939_session_list_unlock(priv);
 	return NOTIFY_DONE;
-- 
2.20.1

