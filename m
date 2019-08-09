Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE22D8744A
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 10:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405934AbfHIIgF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 04:36:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50847 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405926AbfHIIgF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 04:36:05 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NU-00059P-Mt; Fri, 09 Aug 2019 10:36:00 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NO-0004R0-W4; Fri, 09 Aug 2019 10:35:54 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 19/21] j1939: store priv in jsk
Date:   Fri,  9 Aug 2019 10:35:51 +0200
Message-Id: <20190809083553.16687-20-o.rempel@pengutronix.de>
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

Getting priv from ndev by ifindex is not safe. If ifindex was changed or
removed, we wont be able to clean up properly our resources.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  2 +-
 net/can/j1939/socket.c     | 60 ++++++++++++++------------------------
 2 files changed, 23 insertions(+), 39 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index d33a5323485f..8fb41fa289ba 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -203,7 +203,6 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv);
 struct j1939_priv *j1939_netdev_start(struct net_device *ndev);
 void j1939_netdev_stop(struct j1939_priv *priv);
 
-struct j1939_priv *j1939_priv_get_by_ndev(struct net_device *ndev);
 void j1939_priv_put(struct j1939_priv *priv);
 void j1939_priv_get(struct j1939_priv *priv);
 
@@ -286,6 +285,7 @@ struct j1939_session {
 };
 
 struct j1939_sock {
+	struct j1939_priv *priv;
 	struct sock sk; /* must be first to skip with memset */
 	struct list_head list;
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 28d559493256..e6a77badcf73 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -77,6 +77,8 @@ void j1939_sock_pending_del(struct sock *sk)
 static void j1939_jsk_add(struct j1939_priv *priv, struct j1939_sock *jsk)
 {
 	jsk->state |= J1939_SOCK_BOUND;
+	j1939_priv_get(priv);
+	jsk->priv = priv;
 
 	spin_lock_bh(&priv->j1939_socks_lock);
 	list_add_tail(&jsk->list, &priv->j1939_socks);
@@ -89,6 +91,8 @@ static void j1939_jsk_del(struct j1939_priv *priv, struct j1939_sock *jsk)
 	list_del_init(&jsk->list);
 	spin_unlock_bh(&priv->j1939_socks_lock);
 
+	jsk->priv = NULL;
+	j1939_priv_put(priv);
 	jsk->state &= ~J1939_SOCK_BOUND;
 }
 
@@ -385,10 +389,9 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
 	struct j1939_sock *jsk = j1939_sk(sock->sk);
+	struct j1939_priv *priv = jsk->priv;
 	struct sock *sk = sock->sk;
 	struct net *net = sock_net(sk);
-	struct net_device *ndev;
-	struct j1939_priv *priv;
 	int ret = 0;
 
 	ret = j1939_sk_sanity_check(addr, len);
@@ -397,12 +400,6 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 
 	lock_sock(sock->sk);
 
-	ndev = dev_get_by_index(net, addr->can_ifindex);
-	if (!ndev) {
-		ret = -ENODEV;
-		goto out_release_sock;
-	}
-
 	/* Already bound to an interface? */
 	if (jsk->state & J1939_SOCK_BOUND) {
 		/* A re-bind() to a different interface is not
@@ -410,24 +407,32 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		 */
 		if (jsk->ifindex != addr->can_ifindex) {
 			ret = -EINVAL;
-			goto out_dev_put;
+			goto out_release_sock;
 		}
 
 		/* drop old references */
-		priv = j1939_priv_get_by_ndev(ndev);
 		j1939_jsk_del(priv, jsk);
 		j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
-		j1939_priv_put(priv);
 	} else {
+		struct net_device *ndev;
+
+		ndev = dev_get_by_index(net, addr->can_ifindex);
+		if (!ndev) {
+			ret = -ENODEV;
+			goto out_release_sock;
+		}
+
 		if (ndev->type != ARPHRD_CAN) {
+			dev_put(ndev);
 			ret = -ENODEV;
-			goto out_dev_put;
+			goto out_release_sock;
 		}
 
 		priv = j1939_netdev_start(ndev);
+		dev_put(ndev);
 		if (IS_ERR(priv)) {
 			ret = PTR_ERR(priv);
-			goto out_dev_put;
+			goto out_release_sock;
 		}
 
 		jsk->ifindex = addr->can_ifindex;
@@ -443,14 +448,12 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	ret = j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa);
 	if (ret) {
 		j1939_netdev_stop(priv);
-		goto out_dev_put;
+		goto out_release_sock;
 	}
 
 	j1939_jsk_add(priv, jsk);
 
- out_dev_put: /* fallthrough */
-	dev_put(ndev);
- out_release_sock:
+ out_release_sock: /* fallthrough */
 	release_sock(sock->sk);
 
 	return ret;
@@ -553,11 +556,7 @@ static int j1939_sk_release(struct socket *sock)
 	lock_sock(sk);
 
 	if (jsk->state & J1939_SOCK_BOUND) {
-		struct j1939_priv *priv;
-		struct net_device *ndev;
-
-		ndev = dev_get_by_index(sock_net(sk), jsk->ifindex);
-		priv = j1939_priv_get_by_ndev(ndev);
+		struct j1939_priv *priv = jsk->priv;
 
 		if (wait_event_interruptible(jsk->waitq,
 					     !j1939_sock_pending_get(&jsk->sk))) {
@@ -569,10 +568,8 @@ static int j1939_sk_release(struct socket *sock)
 
 		j1939_local_ecu_put(priv, jsk->addr.src_name,
 				    jsk->addr.sa);
-		j1939_priv_put(priv);
 
 		j1939_netdev_stop(priv);
-		dev_put(ndev);
 	}
 
 	sock_orphan(sk);
@@ -1047,8 +1044,7 @@ static int j1939_sk_sendmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct j1939_sock *jsk = j1939_sk(sk);
-	struct j1939_priv *priv;
-	struct net_device *ndev;
+	struct j1939_priv *priv = jsk->priv;
 	int ifindex;
 	int ret;
 
@@ -1091,19 +1087,8 @@ static int j1939_sk_sendmsg(struct socket *sock, struct msghdr *msg,
 			return -EACCES;
 	}
 
-	ndev = dev_get_by_index(sock_net(sk), ifindex);
-	if (!ndev)
-		return -ENXIO;
-
-	priv = j1939_priv_get_by_ndev(ndev);
-	if (!priv)
-		return -EINVAL;
-
 	ret = j1939_sk_send_loop(priv, sk, msg, size);
 
-	j1939_priv_put(priv);
-
-	dev_put(ndev);
 	return ret;
 }
 
@@ -1121,7 +1106,6 @@ void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
 		j1939_sk_queue_drop_all(priv, jsk, error_code);
 	}
 	spin_unlock_bh(&priv->j1939_socks_lock);
-	j1939_priv_put(priv);
 }
 
 static const struct proto_ops j1939_ops = {
-- 
2.20.1

