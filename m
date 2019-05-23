Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3422798B
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfEWJl5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43571 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730298AbfEWJl4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:56 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEN-0001G9-64; Thu, 23 May 2019 11:41:47 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-00045g-Lq; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 16/17] j1939: rename tp_sessionq to active_session_list
Date:   Thu, 23 May 2019 11:41:38 +0200
Message-Id: <20190523094139.15517-17-o.rempel@pengutronix.de>
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
 net/can/j1939/j1939-priv.h | 14 ++++++++++----
 net/can/j1939/transport.c  | 39 +++++++++++++++-----------------------
 2 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index de034dab0bc6..29cfe9d7f9ae 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -62,9 +62,15 @@ struct j1939_priv {
 
 	struct kref kref;
 
-	/* protects both tp_session lists below*/
-	spinlock_t tp_session_list_lock;
-	struct list_head tp_sessionq;
+	/* List of active sessions to prevent start of conflicting one.
+	 *
+	 * Do not start two sessions of same type, addresses and direction.
+	 */
+	struct list_head active_session_list;
+
+	/* protects active_session_list */
+	spinlock_t active_session_list_lock;
+
 	unsigned int tp_max_packet_size;
 
 	struct list_head j1939_socks;
@@ -207,7 +213,7 @@ enum j1939_session_state {
 
 struct j1939_session {
 	struct j1939_priv *priv;
-	struct list_head list;
+	struct list_head active_session_list_entry;
 	struct list_head jsk_fifo;
 	struct kref kref;
 	spinlock_t lock;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index ade2937f57cf..c7d80ac13f20 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -212,24 +212,12 @@ static inline void j1939_fix_cb(struct j1939_sk_buff_cb *skcb)
 
 static inline void j1939_session_list_lock(struct j1939_priv *priv)
 {
-	spin_lock_bh(&priv->tp_session_list_lock);
+	spin_lock_bh(&priv->active_session_list_lock);
 }
 
 static inline void j1939_session_list_unlock(struct j1939_priv *priv)
 {
-	spin_unlock_bh(&priv->tp_session_list_lock);
-}
-
-static void j1939_session_list_add(struct j1939_session *session)
-{
-	struct j1939_priv *priv = session->priv;
-
-	list_add_tail(&session->list, &priv->tp_sessionq);
-}
-
-static void j1939_session_list_del(struct j1939_session *session)
-{
-	list_del_init(&session->list);
+	spin_unlock_bh(&priv->active_session_list_lock);
 }
 
 void j1939_session_get(struct j1939_session *session)
@@ -489,9 +477,9 @@ j1939_session *j1939_session_get_by_skcb_locked(struct j1939_priv *priv,
 {
 	struct j1939_session *session;
 
-	lockdep_assert_held(&priv->tp_session_list_lock);
+	lockdep_assert_held(&priv->active_session_list_lock);
 
-	list_for_each_entry(session, root, list) {
+	list_for_each_entry(session, root, active_session_list_entry) {
 		j1939_session_get(session);
 		if (j1939_session_match(session, skcb, reverse))
 			return session;
@@ -508,7 +496,8 @@ struct j1939_session *j1939_session_get_by_skcb(struct j1939_priv *priv,
 	struct j1939_session *session;
 
 	j1939_session_list_lock(priv);
-	session = j1939_session_get_by_skcb_locked(priv, &priv->tp_sessionq,
+	session = j1939_session_get_by_skcb_locked(priv,
+						   &priv->active_session_list,
 						   skcb, reverse);
 	j1939_session_list_unlock(priv);
 
@@ -845,7 +834,7 @@ bool j1939_session_deactivate(struct j1939_session *session)
 	if (session->state == J1939_SESSION_ACTIVE) {
 		active = true;
 
-		j1939_session_list_del(session);
+		list_del_init(&session->active_session_list_entry);
 		session->state = J1939_SESSION_DONE;
 		j1939_session_put(session);
 
@@ -1103,7 +1092,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	session = kzalloc(sizeof(*session), gfp_any());
 	if (!session)
 		return NULL;
-	INIT_LIST_HEAD(&session->list);
+	INIT_LIST_HEAD(&session->active_session_list_entry);
 	INIT_LIST_HEAD(&session->jsk_fifo);
 	spin_lock_init(&session->lock);
 	kref_init(&session->kref);
@@ -1170,14 +1159,15 @@ int j1939_session_activate(struct j1939_session *session)
 	int ret = 0;
 
 	j1939_session_list_lock(priv);
-	pending = j1939_session_get_by_skcb_locked(priv, &priv->tp_sessionq,
+	pending = j1939_session_get_by_skcb_locked(priv, &priv->active_session_list,
 						   &session->skcb, false);
 	if (pending) {
 		j1939_session_put(pending);
 		ret = -EAGAIN;
 	} else {
 		WARN_ON_ONCE(session->state != J1939_SESSION_NEW);
-		j1939_session_list_add(session);
+		list_add_tail(&session->active_session_list_entry,
+			      &priv->active_session_list);
 		j1939_session_get(session);
 		session->state = J1939_SESSION_ACTIVE;
 	}
@@ -1630,7 +1620,8 @@ int j1939_tp_rmdev_notifier(struct j1939_priv *priv)
 
 	j1939_session_list_lock(priv);
 	list_for_each_entry_safe(session, saved,
-				 &priv->tp_sessionq, list) {
+				 &priv->active_session_list,
+				 active_session_list_entry) {
 		j1939_session_timers_cancel(session);
 		j1939_session_deactivate_activate_next(session);
 	}
@@ -1640,7 +1631,7 @@ int j1939_tp_rmdev_notifier(struct j1939_priv *priv)
 
 void j1939_tp_init(struct j1939_priv *priv)
 {
-	spin_lock_init(&priv->tp_session_list_lock);
-	INIT_LIST_HEAD(&priv->tp_sessionq);
+	spin_lock_init(&priv->active_session_list_lock);
+	INIT_LIST_HEAD(&priv->active_session_list);
 	priv->tp_max_packet_size = J1939_MAX_ETP_PACKET_SIZE;
 }
-- 
2.20.1

