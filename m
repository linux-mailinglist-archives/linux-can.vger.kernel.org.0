Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCD627982
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfEWJlw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33445 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbfEWJlr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:47 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEI-0001GA-Ps; Thu, 23 May 2019 11:41:42 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-00045q-Mi; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 17/17] j1939: rename jsk_fifo to sk_session_queue_entry
Date:   Thu, 23 May 2019 11:41:39 +0200
Message-Id: <20190523094139.15517-18-o.rempel@pengutronix.de>
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
 net/can/j1939/j1939-priv.h |  6 ++---
 net/can/j1939/socket.c     | 51 ++++++++++++++++++++------------------
 net/can/j1939/transport.c  |  2 +-
 3 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 29cfe9d7f9ae..21bee33fdbf4 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -214,7 +214,7 @@ enum j1939_session_state {
 struct j1939_session {
 	struct j1939_priv *priv;
 	struct list_head active_session_list_entry;
-	struct list_head jsk_fifo;
+	struct list_head sk_session_queue_entry;
 	struct kref kref;
 	spinlock_t lock;
 	struct sock *sk;
@@ -290,8 +290,8 @@ struct j1939_sock {
 	atomic_t skb_pending;
 	wait_queue_head_t waitq;
 
-	spinlock_t session_fifo_lock;
-	struct list_head session_fifo;
+	spinlock_t sk_session_queue_lock;
+	struct list_head sk_session_queue;
 };
 
 static inline struct j1939_sock *j1939_sk(const struct sock *sk)
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 80ef2329c921..f7ade3c9a5af 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -74,11 +74,11 @@ static bool j1939_sk_queue_session(struct j1939_session *session)
 	struct j1939_sock *jsk = j1939_sk(session->sk);
 	bool empty;
 
-	spin_lock_bh(&jsk->session_fifo_lock);
-	empty = list_empty(&jsk->session_fifo);
+	spin_lock_bh(&jsk->sk_session_queue_lock);
+	empty = list_empty(&jsk->sk_session_queue);
 	j1939_session_get(session);
-	list_add_tail(&session->jsk_fifo, &jsk->session_fifo);
-	spin_unlock_bh(&jsk->session_fifo_lock);
+	list_add_tail(&session->sk_session_queue_entry, &jsk->sk_session_queue);
+	spin_unlock_bh(&jsk->sk_session_queue_lock);
 	j1939_sock_pending_add(&jsk->sk);
 
 	return empty;
@@ -89,16 +89,17 @@ j1939_session *j1939_sk_get_incomplete_session(struct j1939_sock *jsk)
 {
 	struct j1939_session *session = NULL;
 
-	spin_lock_bh(&jsk->session_fifo_lock);
-	if (!list_empty(&jsk->session_fifo)) {
-		session = list_last_entry(&jsk->session_fifo,
-					  struct j1939_session, jsk_fifo);
+	spin_lock_bh(&jsk->sk_session_queue_lock);
+	if (!list_empty(&jsk->sk_session_queue)) {
+		session = list_last_entry(&jsk->sk_session_queue,
+					  struct j1939_session,
+					  sk_session_queue_entry);
 		if (session->total_queued_size == session->total_message_size)
 			session = NULL;
 		else
 			j1939_session_get(session);
 	}
-	spin_unlock_bh(&jsk->session_fifo_lock);
+	spin_unlock_bh(&jsk->sk_session_queue_lock);
 
 	return session;
 }
@@ -107,15 +108,15 @@ static void j1939_sk_queue_drop_all(struct j1939_sock *jsk)
 {
 	struct j1939_session *session, *tmp;
 
-	spin_lock_bh(&jsk->session_fifo_lock);
-	list_for_each_entry_safe_reverse(session, tmp, &jsk->session_fifo,
-					 jsk_fifo) {
-		list_del_init(&session->jsk_fifo);
+	spin_lock_bh(&jsk->sk_session_queue_lock);
+	list_for_each_entry_safe_reverse(session, tmp, &jsk->sk_session_queue,
+					 sk_session_queue_entry) {
+		list_del_init(&session->sk_session_queue_entry);
 		j1939_session_timers_cancel(session);
 		j1939_session_deactivate(session);
 		j1939_session_put(session);
 	}
-	spin_unlock_bh(&jsk->session_fifo_lock);
+	spin_unlock_bh(&jsk->sk_session_queue_lock);
 }
 
 void j1939_sk_queue_activate_next_locked(struct j1939_session *session)
@@ -128,17 +129,19 @@ void j1939_sk_queue_activate_next_locked(struct j1939_session *session)
 		return;
 
 	jsk = j1939_sk(session->sk);
-	lockdep_assert_held(&jsk->session_fifo_lock);
+	lockdep_assert_held(&jsk->sk_session_queue_lock);
 
 	err = session->err;
 
-	cur = list_first_entry_or_null(&jsk->session_fifo,
-					struct j1939_session, jsk_fifo);
+	cur = list_first_entry_or_null(&jsk->sk_session_queue,
+					struct j1939_session,
+					sk_session_queue_entry);
 	if (cur == session) {
-		list_del_init(&session->jsk_fifo);
+		list_del_init(&session->sk_session_queue_entry);
 		j1939_session_put(session);
-		next = list_first_entry_or_null(&jsk->session_fifo,
-						struct j1939_session, jsk_fifo);
+		next = list_first_entry_or_null(&jsk->sk_session_queue,
+						struct j1939_session,
+						sk_session_queue_entry);
 		if (next) {
 			/* Give receiver some time (arbitrary chosen) to recover */
 			int time_ms = 0;
@@ -161,9 +164,9 @@ void j1939_sk_queue_activate_next(struct j1939_session *session)
 
 	jsk = j1939_sk(session->sk);
 
-	spin_lock_bh(&jsk->session_fifo_lock);
+	spin_lock_bh(&jsk->sk_session_queue_lock);
 	j1939_sk_queue_activate_next_locked(session);
-	spin_unlock_bh(&jsk->session_fifo_lock);
+	spin_unlock_bh(&jsk->sk_session_queue_lock);
 }
 
 static bool j1939_sk_match_dst(struct j1939_sock *jsk,
@@ -301,8 +304,8 @@ static int j1939_sk_init(struct sock *sk)
 	jsk->addr.pgn = J1939_NO_PGN;
 	jsk->pgn_rx_filter = J1939_NO_PGN;
 	atomic_set(&jsk->skb_pending, 0);
-	spin_lock_init(&jsk->session_fifo_lock);
-	INIT_LIST_HEAD(&jsk->session_fifo);
+	spin_lock_init(&jsk->sk_session_queue_lock);
+	INIT_LIST_HEAD(&jsk->sk_session_queue);
 
 	return 0;
 }
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index c7d80ac13f20..88fe995a9716 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1093,7 +1093,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	if (!session)
 		return NULL;
 	INIT_LIST_HEAD(&session->active_session_list_entry);
-	INIT_LIST_HEAD(&session->jsk_fifo);
+	INIT_LIST_HEAD(&session->sk_session_queue_entry);
 	spin_lock_init(&session->lock);
 	kref_init(&session->kref);
 
-- 
2.20.1

