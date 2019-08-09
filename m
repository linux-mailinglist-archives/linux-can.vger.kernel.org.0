Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495038744B
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 10:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405926AbfHIIgG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 04:36:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40375 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405940AbfHIIgF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 04:36:05 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NU-00059C-Is; Fri, 09 Aug 2019 10:36:00 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NO-0004Pq-Nj; Fri, 09 Aug 2019 10:35:54 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 11/21] j1939: j1939_sk_queue_drop_all: set error reason
Date:   Fri,  9 Aug 2019 10:35:43 +0200
Message-Id: <20190809083553.16687-12-o.rempel@pengutronix.de>
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
 net/can/j1939/main.c   | 2 +-
 net/can/j1939/socket.c | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index ac0c22d9b4b2..41908279933c 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -357,8 +357,8 @@ static int j1939_netdev_notify(struct notifier_block *nb,
 		break;
 
 	case NETDEV_DOWN:
-		j1939_sk_netdev_event(ndev, ENETDOWN);
 		j1939_cancel_all_active_sessions(priv);
+		j1939_sk_netdev_event(ndev, ENETDOWN);
 		j1939_ecu_unmap_all(priv);
 		break;
 	}
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 7de4e6decbf3..e4c933aca5d2 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -127,7 +127,7 @@ j1939_session *j1939_sk_get_incomplete_session(struct j1939_sock *jsk)
 	return session;
 }
 
-static void j1939_sk_queue_drop_all(struct j1939_sock *jsk)
+static void j1939_sk_queue_drop_all(struct j1939_sock *jsk, int err)
 {
 	struct j1939_session *session, *tmp;
 
@@ -135,6 +135,7 @@ static void j1939_sk_queue_drop_all(struct j1939_sock *jsk)
 	list_for_each_entry_safe(session, tmp, &jsk->sk_session_queue,
 				 sk_session_queue_entry) {
 		list_del_init(&session->sk_session_queue_entry);
+		session->err = err;
 		j1939_session_put(session);
 	}
 	spin_unlock_bh(&jsk->sk_session_queue_lock);
@@ -555,7 +556,7 @@ static int j1939_sk_release(struct socket *sock)
 
 		if (wait_event_interruptible(jsk->waitq,
 					     !j1939_sock_pending_get(&jsk->sk)))
-			j1939_sk_queue_drop_all(jsk);
+			j1939_sk_queue_drop_all(jsk, ESHUTDOWN);
 
 		ndev = dev_get_by_index(sock_net(sk), jsk->ifindex);
 		priv = j1939_priv_get_by_ndev(ndev);
@@ -995,7 +996,7 @@ static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 				} else {
 					ret = -EBUSY;
 					session->err = ret;
-					j1939_sk_queue_drop_all(jsk);
+					j1939_sk_queue_drop_all(jsk, EBUSY);
 					break;
 				}
 			}
@@ -1113,7 +1114,7 @@ void j1939_sk_netdev_event(struct net_device *ndev, int error_code)
 		if (!sock_flag(&jsk->sk, SOCK_DEAD))
 			jsk->sk.sk_error_report(&jsk->sk);
 
-		j1939_sk_queue_drop_all(jsk);
+		j1939_sk_queue_drop_all(jsk, error_code);
 
 		if (error_code == ENODEV) {
 			j1939_local_ecu_put(priv, jsk->addr.src_name,
-- 
2.20.1

