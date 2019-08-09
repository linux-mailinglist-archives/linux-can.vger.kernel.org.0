Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3271B8744F
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 10:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405765AbfHIIgH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 04:36:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43371 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405965AbfHIIgF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 04:36:05 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NU-00059D-Ip; Fri, 09 Aug 2019 10:36:00 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NO-0004Pz-Oo; Fri, 09 Aug 2019 10:35:54 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 12/21] j1939: add more debug info
Date:   Fri,  9 Aug 2019 10:35:44 +0200
Message-Id: <20190809083553.16687-13-o.rempel@pengutronix.de>
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
 net/can/j1939/socket.c    | 16 +++++++++-------
 net/can/j1939/transport.c |  1 +
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index e4c933aca5d2..9308e08d6ba9 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -127,10 +127,12 @@ j1939_session *j1939_sk_get_incomplete_session(struct j1939_sock *jsk)
 	return session;
 }
 
-static void j1939_sk_queue_drop_all(struct j1939_sock *jsk, int err)
+static void j1939_sk_queue_drop_all(struct j1939_priv *priv,
+				    struct j1939_sock *jsk, int err)
 {
 	struct j1939_session *session, *tmp;
 
+	netdev_dbg(priv->ndev, "%s: err: %i\n", __func__, err);
 	spin_lock_bh(&jsk->sk_session_queue_lock);
 	list_for_each_entry_safe(session, tmp, &jsk->sk_session_queue,
 				 sk_session_queue_entry) {
@@ -554,13 +556,13 @@ static int j1939_sk_release(struct socket *sock)
 		struct j1939_priv *priv;
 		struct net_device *ndev;
 
-		if (wait_event_interruptible(jsk->waitq,
-					     !j1939_sock_pending_get(&jsk->sk)))
-			j1939_sk_queue_drop_all(jsk, ESHUTDOWN);
-
 		ndev = dev_get_by_index(sock_net(sk), jsk->ifindex);
 		priv = j1939_priv_get_by_ndev(ndev);
 
+		if (wait_event_interruptible(jsk->waitq,
+					     !j1939_sock_pending_get(&jsk->sk)))
+			j1939_sk_queue_drop_all(priv, jsk, ESHUTDOWN);
+
 		j1939_jsk_del(priv, jsk);
 
 		j1939_local_ecu_put(priv, jsk->addr.src_name,
@@ -996,7 +998,7 @@ static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 				} else {
 					ret = -EBUSY;
 					session->err = ret;
-					j1939_sk_queue_drop_all(jsk, EBUSY);
+					j1939_sk_queue_drop_all(priv, jsk, EBUSY);
 					break;
 				}
 			}
@@ -1114,7 +1116,7 @@ void j1939_sk_netdev_event(struct net_device *ndev, int error_code)
 		if (!sock_flag(&jsk->sk, SOCK_DEAD))
 			jsk->sk.sk_error_report(&jsk->sk);
 
-		j1939_sk_queue_drop_all(jsk, error_code);
+		j1939_sk_queue_drop_all(priv, jsk, error_code);
 
 		if (error_code == ENODEV) {
 			j1939_local_ecu_put(priv, jsk->addr.src_name,
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 0373d64dffbf..e8b638e87dca 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1987,6 +1987,7 @@ int j1939_cancel_all_active_sessions(struct j1939_priv *priv)
 {
 	struct j1939_session *session, *saved;
 
+	netdev_dbg(priv->ndev, "%s\n", __func__);
 	j1939_session_list_lock(priv);
 	list_for_each_entry_safe(session, saved,
 				 &priv->active_session_list,
-- 
2.20.1

