Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B88C72798A
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfEWJl4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55421 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbfEWJl4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:56 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEN-0001G2-3r; Thu, 23 May 2019 11:41:47 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-00044e-G1; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 09/17] j1939: split j1939_tp_send
Date:   Thu, 23 May 2019 11:41:31 +0200
Message-Id: <20190523094139.15517-10-o.rempel@pengutronix.de>
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

so we have more control over session insertion/activation.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  3 ++-
 net/can/j1939/socket.c     |  7 +++++++
 net/can/j1939/transport.c  | 24 +-----------------------
 3 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 4fb31d9d609e..58bf1eaca6ec 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -65,7 +65,6 @@ struct j1939_priv {
 	/* protects both tp_session lists below*/
 	spinlock_t tp_session_list_lock;
 	struct list_head tp_sessionq;
-	wait_queue_head_t tp_wait;
 	unsigned int tp_max_packet_size;
 
 	struct list_head j1939_socks;
@@ -293,6 +292,8 @@ void j1939_session_skb_queue(struct j1939_session *session,
 struct j1939_session *j1939_session_get_by_skcb(struct j1939_priv *priv,
 						struct j1939_sk_buff_cb *skcb,
 						bool reverse);
+int j1939_session_insert(struct j1939_session *session);
+void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec);
 
 #define J1939_MAX_TP_PACKET_SIZE (7 * 0xff)
 #define J1939_MAX_ETP_PACKET_SIZE (7 * 0x00ffffff)
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 5e97988cc59f..41480980dfdb 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -853,6 +853,13 @@ static int j1939_sk_send_multi(struct j1939_priv *priv,  struct sock *sk,
 					ret = PTR_ERR(session);
 					goto kfree_skb;
 				}
+
+				if (!j1939_session_insert(session)) {
+					j1939_tp_schedule_txtimer(session, 0);
+				} else {
+					ret = session->err = -EBUSY;
+					break;
+				}
 			}
 		} else {
 			j1939_session_skb_queue(session, skb);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 1052658091dd..93df0c0c8ce2 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -240,13 +240,10 @@ void j1939_session_get(struct j1939_session *session)
 /* session completion functions */
 static void __j1939_session_drop(struct j1939_session *session)
 {
-	struct j1939_priv *priv = session->priv;
-
 	if (!session->transmission)
 		return;
 
 	j1939_sock_pending_del(session->sk);
-	wake_up_all(&priv->tp_wait);
 }
 
 static void j1939_session_destroy(struct j1939_session *session)
@@ -637,8 +634,7 @@ static int j1939_xtp_tx_abort(struct j1939_priv *priv,
 	return j1939_xtp_do_tx_ctl(priv, re_skcb, swap_src_dst, pgn, dat);
 }
 
-static inline void j1939_tp_schedule_txtimer(struct j1939_session *session,
-					     int msec)
+void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
 {
 	j1939_session_get(session);
 	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
@@ -1469,27 +1465,10 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 		/* set the end-packet for broadcast */
 		session->pkt.last = session->pkt.total;
 
-	/* insert into queue, but avoid collision with pending session */
-	if (session->skcb.msg_flags & MSG_DONTWAIT)
-		ret = j1939_session_insert(session);
-	else
-		ret = wait_event_interruptible(priv->tp_wait,
-					       j1939_session_insert(session) ==
-					       0);
-	if (ret < 0)
-		goto failed;
-
 	session->tskey = session->sk->sk_tskey++;
 	session->skcb.msg_flags |= MSG_DONTWAIT;
-	/* transmission started */
-	j1939_tp_schedule_txtimer(session, 0);
 
 	return session;
-
- failed:
-	j1939_session_timers_cancel(session);
-	j1939_session_put(session);
-	return ERR_PTR(ret);
 }
 
 static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
@@ -1638,6 +1617,5 @@ void j1939_tp_init(struct j1939_priv *priv)
 {
 	spin_lock_init(&priv->tp_session_list_lock);
 	INIT_LIST_HEAD(&priv->tp_sessionq);
-	init_waitqueue_head(&priv->tp_wait);
 	priv->tp_max_packet_size = J1939_MAX_ETP_PACKET_SIZE;
 }
-- 
2.20.1

