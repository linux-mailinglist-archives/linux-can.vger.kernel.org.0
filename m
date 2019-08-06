Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCE998320B
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2019 15:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfHFNAV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Aug 2019 09:00:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59667 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHFNAU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Aug 2019 09:00:20 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1huz37-0002wI-8L; Tue, 06 Aug 2019 14:58:45 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1huz36-0003rW-Ll; Tue, 06 Aug 2019 14:58:44 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 4/6] j1939: notify user space if simple package was transmitted by HW
Date:   Tue,  6 Aug 2019 14:58:38 +0200
Message-Id: <20190806125840.5634-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806125840.5634-1-o.rempel@pengutronix.de>
References: <20190806125840.5634-1-o.rempel@pengutronix.de>
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

So far we was able to notify user space about completed or failed
(E)TP sessions. With this patch we provide the same functionality
for simple (< 9 byte) packages.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  8 +---
 net/can/j1939/main.c       | 11 +++--
 net/can/j1939/socket.c     | 22 ++++++----
 net/can/j1939/transport.c  | 82 ++++++++++++++++++++++++++++++++++----
 4 files changed, 98 insertions(+), 25 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index f68256aa01f2..9dd2fa962769 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -141,17 +141,12 @@ struct j1939_addr {
 
 /* control buffer of the sk_buff */
 struct j1939_sk_buff_cb {
-	/* j1939 clones incoming skb's.
-	 * insock saves the incoming skb->sk
-	 * to determine local generated packets
-	 */
-	struct sock *insock;
-
 	/* Offset in bytes withing one ETP session */
 	u32 offset;
 
 	/* for tx, MSG_SYN will be used to sync on sockets */
 	u32 msg_flags;
+	u32 tskey;
 
 	struct j1939_addr addr;
 
@@ -186,6 +181,7 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 int j1939_tp_recv(struct j1939_priv *priv, struct sk_buff *skb);
 int j1939_ac_fixup(struct j1939_priv *priv, struct sk_buff *skb);
 void j1939_ac_recv(struct j1939_priv *priv, struct sk_buff *skb);
+void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb);
 
 /* network management */
 struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name);
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 639aeb33c19a..97f64ca23796 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -9,6 +9,7 @@
 
 #include <linux/can/can-ml.h>
 #include <linux/can/core.h>
+#include <linux/can/skb.h>
 #include <linux/if_arp.h>
 #include <linux/module.h>
 
@@ -33,7 +34,7 @@ static void j1939_can_recv(struct sk_buff *iskb, void *data)
 {
 	struct j1939_priv *priv = data;
 	struct sk_buff *skb;
-	struct j1939_sk_buff_cb *skcb;
+	struct j1939_sk_buff_cb *skcb, *iskcb;
 	struct can_frame *cf;
 
 	/* create a copy of the skb
@@ -45,6 +46,8 @@ static void j1939_can_recv(struct sk_buff *iskb, void *data)
 	if (!skb)
 		return;
 
+	can_skb_set_owner(skb, iskb->sk);
+
 	/* get a pointer to the header of the skb
 	 * the skb payload (pointer) is moved, so that the next skb_data
 	 * returns the actual payload
@@ -59,8 +62,8 @@ static void j1939_can_recv(struct sk_buff *iskb, void *data)
 	skcb = j1939_skb_to_cb(skb);
 	memset(skcb, 0, sizeof(*skcb));
 
-	/* save incoming socket, without assigning the skb to it */
-	skcb->insock = iskb->sk;
+	iskcb = j1939_skb_to_cb(iskb);
+	skcb->tskey = iskcb->tskey;
 	skcb->priority = (cf->can_id >> 26) & 0x7;
 	skcb->addr.sa = cf->can_id;
 	skcb->addr.pgn = (cf->can_id >> 8) & J1939_PGN_MAX;
@@ -92,6 +95,8 @@ static void j1939_can_recv(struct sk_buff *iskb, void *data)
 	if (j1939_tp_recv(priv, skb))
 		/* this means the transport layer processed the message */
 		goto done;
+
+	j1939_simple_recv(priv, skb);
 	j1939_sk_recv(priv, skb);
  done:
 	kfree_skb(skb);
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 90c4e766e60b..6c81dd0c08db 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -275,10 +275,6 @@ static bool j1939_sk_recv_match_one(struct j1939_sock *jsk,
 	if (!(jsk->state & J1939_SOCK_BOUND))
 		return false;
 
-	if (skcb->insock == &jsk->sk)
-		/* own message */
-		return false;
-
 	if (!j1939_sk_match_dst(jsk, skcb))
 		return false;
 
@@ -294,6 +290,9 @@ static void j1939_sk_recv_one(struct j1939_sock *jsk, struct sk_buff *oskb)
 	struct j1939_sk_buff_cb *skcb;
 	struct sk_buff *skb;
 
+	if (oskb->sk == &jsk->sk)
+		return;
+
 	if (!j1939_sk_recv_match_one(jsk, oskcb))
 		return;
 
@@ -302,9 +301,11 @@ static void j1939_sk_recv_one(struct j1939_sock *jsk, struct sk_buff *oskb)
 		pr_warn("skb clone failed\n");
 		return;
 	}
+	can_skb_set_owner(skb, oskb->sk);
+
 	skcb = j1939_skb_to_cb(skb);
 	skcb->msg_flags &= ~(MSG_DONTROUTE);
-	if (skcb->insock)
+	if (skb->sk)
 		skcb->msg_flags |= MSG_DONTROUTE;
 
 	if (sock_queue_rcv_skb(&jsk->sk, skb) < 0)
@@ -847,14 +848,19 @@ static struct sk_buff *
 j1939_sk_get_timestamping_opt_stats(struct j1939_session *session)
 {
 	struct sk_buff *stats;
+	u32 size;
 
 	stats = alloc_skb(j1939_sk_opt_stats_get_size(), GFP_ATOMIC);
 	if (!stats)
 		return NULL;
 
-	nla_put_u32(stats, J1939_NLA_BYTES_ACKED,
-		    min(session->pkt.tx_acked * 7,
-			session->total_message_size));
+	if (session->skcb.addr.type == J1939_SIMPLE)
+		size = session->total_message_size;
+	else
+		size = min(session->pkt.tx_acked * 7,
+			   session->total_message_size);
+
+	nla_put_u32(stats, J1939_NLA_BYTES_ACKED, size);
 
 	return stats;
 }
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index ab29d4a7d91d..2d1511a64c55 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -505,6 +505,27 @@ j1939_session *j1939_session_get_by_addr_locked(struct j1939_priv *priv,
 	return NULL;
 }
 
+static struct
+j1939_session *j1939_session_get_simple(struct j1939_priv *priv,
+					struct sk_buff *skb)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	struct j1939_session *session;
+
+	lockdep_assert_held(&priv->active_session_list_lock);
+
+	list_for_each_entry(session, &priv->active_session_list,
+			    active_session_list_entry) {
+		j1939_session_get(session);
+		if (session->skcb.addr.type == J1939_SIMPLE &&
+		    session->tskey == skcb->tskey && session->sk == skb->sk)
+			return session;
+		j1939_session_put(session);
+	}
+
+	return NULL;
+}
+
 static struct
 j1939_session *j1939_session_get_by_addr(struct j1939_priv *priv,
 					 struct j1939_addr *addr,
@@ -1024,9 +1045,17 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 
 			skb = skb_clone(se_skb, GFP_ATOMIC);
 			if (skb) {
+				can_skb_set_owner(skb, se_skb->sk);
+
+				j1939_tp_set_rxtimeout(session,
+						       J1939_XTP_ABORT_TIMEOUT_MS);
+
 				ret = j1939_send_one(priv, skb);
-				if (!ret)
-					j1939_session_deactivate_activate_next(session);
+				if (!ret) {
+					j1939_sk_errqueue(session,
+							  J1939_ERRQUEUE_SCHED);
+					j1939_sk_queue_activate_next(session);
+				}
 			} else {
 				ret = -ENOMEM;
 				session->err = ret;
@@ -1059,6 +1088,9 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 			j1939_tp_set_rxtimeout(session,
 					       J1939_XTP_ABORT_TIMEOUT_MS);
 			j1939_session_cancel(session, J1939_XTP_ABORT_OTHER);
+		} else {
+			j1939_session_rxtimer_cancel(session);
+			j1939_session_deactivate_activate_next(session);
 		}
 	} else {
 		session->tx_retry = 0;
@@ -1094,6 +1126,16 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 			     __func__, session);
 
 		j1939_session_deactivate_activate_next(session);
+
+	} else if (session->skcb.addr.type == J1939_SIMPLE) {
+		netdev_alert(priv->ndev, "%s: 0x%p: Timeout. Failed to send simple message.\n",
+			     __func__, session);
+
+		/* The message is probably stuck in the CAN controller and can
+		 * be send as soon as CAN bus is in working state again.
+		 */
+		session->err = -ENETUNREACH;
+		j1939_session_deactivate(session);
 	} else {
 		netdev_alert(priv->ndev, "%s: 0x%p: rx timeout, send abort\n",
 			     __func__, session);
@@ -1388,14 +1430,15 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 int j1939_session_activate(struct j1939_session *session)
 {
 	struct j1939_priv *priv = session->priv;
-	struct j1939_session *active;
+	struct j1939_session *active = NULL;
 	int ret = 0;
 
 	j1939_session_list_lock(priv);
-	active = j1939_session_get_by_addr_locked(priv,
-						  &priv->active_session_list,
-						  &session->skcb.addr, false,
-						  session->transmission);
+	if (session->skcb.addr.type != J1939_SIMPLE)
+		active = j1939_session_get_by_addr_locked(priv,
+							  &priv->active_session_list,
+							  &session->skcb.addr, false,
+						          session->transmission);
 	if (active) {
 		j1939_session_put(active);
 		ret = -EAGAIN;
@@ -1796,7 +1839,8 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 		/* set the end-packet for broadcast */
 		session->pkt.last = session->pkt.total;
 
-	session->tskey = session->sk->sk_tskey++;
+	skcb->tskey = session->sk->sk_tskey++;
+	session->tskey = skcb->tskey;
 
 	return session;
 }
@@ -1910,6 +1954,28 @@ int j1939_tp_recv(struct j1939_priv *priv, struct sk_buff *skb)
 	return 1; /* "I processed the message" */
 }
 
+void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb)
+{
+	struct j1939_session *session;
+
+	if (!skb->sk)
+		return;
+
+	j1939_session_list_lock(priv);
+	session = j1939_session_get_simple(priv, skb);
+	j1939_session_list_unlock(priv);
+	if (!session) {
+		netdev_warn(priv->ndev, "%s: Received already invalidated message\n", __func__);
+		return;
+	}
+
+	j1939_session_timers_cancel(session);
+	j1939_session_deactivate(session);
+	j1939_session_put(session);
+
+	return;
+}
+
 int j1939_tp_rmdev_notifier(struct j1939_priv *priv)
 {
 	struct j1939_session *session, *saved;
-- 
2.20.1

