Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6084F87447
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 10:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405785AbfHIIgE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 04:36:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58481 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405697AbfHIIgB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 04:36:01 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NQ-000597-Hv; Fri, 09 Aug 2019 10:35:56 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NO-0004PG-Jo; Fri, 09 Aug 2019 10:35:54 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 07/21] j1939: cancel all active sessions on net down
Date:   Fri,  9 Aug 2019 10:35:39 +0200
Message-Id: <20190809083553.16687-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809083553.16687-1-o.rempel@pengutronix.de>
References: <20190809083553.16687-1-o.rempel@pengutronix.de>
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
 net/can/j1939/j1939-priv.h |  2 +-
 net/can/j1939/main.c       |  2 +-
 net/can/j1939/socket.c     |  2 ++
 net/can/j1939/transport.c  | 20 ++++++++++++++++----
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index d04f8c2d3658..416419890a37 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -208,7 +208,7 @@ void j1939_priv_get(struct j1939_priv *priv);
 
 /* notify/alert all j1939 sockets bound to ifindex */
 void j1939_sk_netdev_event(struct net_device *ndev, int error_code);
-int j1939_tp_rmdev_notifier(struct j1939_priv *priv);
+int j1939_cancel_all_active_sessions(struct j1939_priv *priv);
 void j1939_tp_init(struct j1939_priv *priv);
 
 /* decrement pending skb for a j1939 socket */
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 67b0b16fc4ad..ac0c22d9b4b2 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -353,12 +353,12 @@ static int j1939_netdev_notify(struct notifier_block *nb,
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
-		j1939_tp_rmdev_notifier(priv);
 		j1939_sk_netdev_event(ndev, ENODEV);
 		break;
 
 	case NETDEV_DOWN:
 		j1939_sk_netdev_event(ndev, ENETDOWN);
+		j1939_cancel_all_active_sessions(priv);
 		j1939_ecu_unmap_all(priv);
 		break;
 	}
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index da93afee1d0a..e599286f4c28 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1110,6 +1110,8 @@ void j1939_sk_netdev_event(struct net_device *ndev, int error_code)
 		if (!sock_flag(&jsk->sk, SOCK_DEAD))
 			jsk->sk.sk_error_report(&jsk->sk);
 
+		j1939_sk_queue_drop_all(jsk);
+
 		if (error_code == ENODEV) {
 			j1939_local_ecu_put(priv, jsk->addr.src_name,
 					    jsk->addr.sa);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index eebbe898d127..0373d64dffbf 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1007,11 +1007,12 @@ static int j1939_simple_txnext(struct j1939_session *session)
 	return 0;
 }
 
-bool j1939_session_deactivate(struct j1939_session *session)
+bool j1939_session_deactivate_locked(struct j1939_session *session)
 {
 	bool active = false;
 
-	j1939_session_list_lock(session->priv);
+	lockdep_assert_held(&session->priv->active_session_list_lock);
+
 	if (session->state >= J1939_SESSION_ACTIVE &&
 	    session->state < J1939_SESSION_ACTIVE_MAX) {
 		active = true;
@@ -1020,6 +1021,16 @@ bool j1939_session_deactivate(struct j1939_session *session)
 		session->state = J1939_SESSION_DONE;
 		j1939_session_put(session);
 	}
+
+	return active;
+}
+
+bool j1939_session_deactivate(struct j1939_session *session)
+{
+	bool active;
+
+	j1939_session_list_lock(session->priv);
+	active = j1939_session_deactivate_locked(session);
 	j1939_session_list_unlock(session->priv);
 
 	return active;
@@ -1972,7 +1983,7 @@ void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb)
 	j1939_session_put(session);
 }
 
-int j1939_tp_rmdev_notifier(struct j1939_priv *priv)
+int j1939_cancel_all_active_sessions(struct j1939_priv *priv)
 {
 	struct j1939_session *session, *saved;
 
@@ -1981,7 +1992,8 @@ int j1939_tp_rmdev_notifier(struct j1939_priv *priv)
 				 &priv->active_session_list,
 				 active_session_list_entry) {
 		j1939_session_timers_cancel(session);
-		j1939_session_deactivate_activate_next(session);
+		session->err = ESHUTDOWN;
+		j1939_session_deactivate_locked(session);
 	}
 	j1939_session_list_unlock(priv);
 	return NOTIFY_DONE;
-- 
2.20.1

