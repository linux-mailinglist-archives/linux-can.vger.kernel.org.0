Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C92D363319
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfGII7S (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45205 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfGII7S (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:18 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085a-N5; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000kZ-K6; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 19/34] j1939: socket: add j1939_jsk_add/del functions
Date:   Tue,  9 Jul 2019 10:58:54 +0200
Message-Id: <20190709085909.1413-19-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709085909.1413-1-o.rempel@pengutronix.de>
References: <20190709085909.1413-1-o.rempel@pengutronix.de>
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

and start to use them

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/socket.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index a94e36d54c2d..c78b41b55d21 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -69,6 +69,24 @@ void j1939_sock_pending_del(struct sock *sk)
 		wake_up(&jsk->waitq);	/* no pending SKB's */
 }
 
+static void j1939_jsk_add(struct j1939_priv *priv, struct j1939_sock *jsk)
+{
+	jsk->state |= J1939_SOCK_BOUND;
+
+	spin_lock_bh(&priv->j1939_socks_lock);
+	list_add_tail(&jsk->list, &priv->j1939_socks);
+	spin_unlock_bh(&priv->j1939_socks_lock);
+}
+
+static void j1939_jsk_del(struct j1939_priv *priv, struct j1939_sock *jsk)
+{
+	spin_lock_bh(&priv->j1939_socks_lock);
+	list_del_init(&jsk->list);
+	spin_unlock_bh(&priv->j1939_socks_lock);
+
+	jsk->state &= ~J1939_SOCK_BOUND;
+}
+
 static bool j1939_sk_queue_session(struct j1939_session *session)
 {
 	struct j1939_sock *jsk = j1939_sk(session->sk);
@@ -421,13 +439,8 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		goto out_dev_put;
 	}
 
-	if (!(jsk->state & J1939_SOCK_BOUND)) {
-		spin_lock_bh(&priv->j1939_socks_lock);
-		list_add_tail(&jsk->list, &priv->j1939_socks);
-		spin_unlock_bh(&priv->j1939_socks_lock);
-
-		jsk->state |= J1939_SOCK_BOUND;
-	}
+	if (!(jsk->state & J1939_SOCK_BOUND))
+		j1939_jsk_add(priv, jsk);
 
  out_dev_put: /* fallthrough */
 	dev_put(ndev);
@@ -544,9 +557,7 @@ static int j1939_sk_release(struct socket *sock)
 		ndev = dev_get_by_index(sock_net(sk), jsk->ifindex);
 		priv = j1939_priv_get_by_ndev(ndev);
 
-		spin_lock_bh(&priv->j1939_socks_lock);
-		list_del_init(&jsk->list);
-		spin_unlock_bh(&priv->j1939_socks_lock);
+		j1939_jsk_del(priv, jsk);
 
 		j1939_local_ecu_put(priv, jsk->addr.src_name,
 				    jsk->addr.sa);
-- 
2.20.1

