Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F17387449
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 10:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405697AbfHIIgF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 04:36:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42413 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405641AbfHIIgA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 04:36:00 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NQ-00059N-IV; Fri, 09 Aug 2019 10:35:56 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NO-0004Qi-U4; Fri, 09 Aug 2019 10:35:54 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 17/21] j1939: j1939_sk_netdev_event: use priv directly
Date:   Fri,  9 Aug 2019 10:35:49 +0200
Message-Id: <20190809083553.16687-18-o.rempel@pengutronix.de>
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

there is no need to extract it again.
... and drop the use of it on NETDEV_UNREGISTER, we run
always NETDEV_DOWN before NETDEV_UNREGISTER.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  2 +-
 net/can/j1939/main.c       |  6 +-----
 net/can/j1939/socket.c     | 12 ++----------
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 5e9c1e3a3c5e..d33a5323485f 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -208,7 +208,7 @@ void j1939_priv_put(struct j1939_priv *priv);
 void j1939_priv_get(struct j1939_priv *priv);
 
 /* notify/alert all j1939 sockets bound to ifindex */
-void j1939_sk_netdev_event(struct net_device *ndev, int error_code);
+void j1939_sk_netdev_event_netdown(struct j1939_priv *priv);
 int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk);
 void j1939_tp_init(struct j1939_priv *priv);
 
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 68f1fa08cd5d..3af412e407f5 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -352,13 +352,9 @@ static int j1939_netdev_notify(struct notifier_block *nb,
 		goto notify_put;
 
 	switch (msg) {
-	case NETDEV_UNREGISTER:
-		j1939_sk_netdev_event(ndev, ENODEV);
-		break;
-
 	case NETDEV_DOWN:
 		j1939_cancel_active_session(priv, NULL);
-		j1939_sk_netdev_event(ndev, ENETDOWN);
+		j1939_sk_netdev_event_netdown(priv);
 		j1939_ecu_unmap_all(priv);
 		break;
 	}
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index e208eaa22ef9..28d559493256 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1107,10 +1107,10 @@ static int j1939_sk_sendmsg(struct socket *sock, struct msghdr *msg,
 	return ret;
 }
 
-void j1939_sk_netdev_event(struct net_device *ndev, int error_code)
+void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
 {
-	struct j1939_priv *priv = j1939_priv_get_by_ndev(ndev);
 	struct j1939_sock *jsk;
+	int error_code = ENETDOWN;
 
 	spin_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
@@ -1119,14 +1119,6 @@ void j1939_sk_netdev_event(struct net_device *ndev, int error_code)
 			jsk->sk.sk_error_report(&jsk->sk);
 
 		j1939_sk_queue_drop_all(priv, jsk, error_code);
-
-		if (error_code == ENODEV) {
-			j1939_local_ecu_put(priv, jsk->addr.src_name,
-					    jsk->addr.sa);
-
-			j1939_netdev_stop(priv);
-		}
-		/* do not remove filters here */
 	}
 	spin_unlock_bh(&priv->j1939_socks_lock);
 	j1939_priv_put(priv);
-- 
2.20.1

