Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4752263324
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfGII7Y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56133 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfGII7X (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:23 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085e-TP; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000lL-OG; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 23/34] j1939: j1939_netdev_stop(): use priv instead of ndev
Date:   Tue,  9 Jul 2019 10:58:58 +0200
Message-Id: <20190709085909.1413-23-o.rempel@pengutronix.de>
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

We already have a priv pointer. No need to seek it again.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h | 2 +-
 net/can/j1939/main.c       | 7 +------
 net/can/j1939/socket.c     | 6 +++---
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index d668658ef421..1e470a394fff 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -193,7 +193,7 @@ void j1939_ecu_timer_cancel(struct j1939_ecu *ecu);
 void j1939_ecu_unmap_all(struct j1939_priv *priv);
 
 struct j1939_priv *j1939_netdev_start(struct net *net, struct net_device *ndev);
-void j1939_netdev_stop(struct net_device *ndev);
+void j1939_netdev_stop(struct j1939_priv *priv);
 
 struct j1939_priv *j1939_priv_get_by_ndev(struct net_device *ndev);
 void j1939_priv_put(struct j1939_priv *priv);
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 9a711ddeae0d..315166ef3eb1 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -271,15 +271,10 @@ struct j1939_priv *j1939_netdev_start(struct net *net, struct net_device *ndev)
 	return ERR_PTR(ret);
 }
 
-void j1939_netdev_stop(struct net_device *ndev)
+void j1939_netdev_stop(struct j1939_priv *priv)
 {
-	struct j1939_priv *priv;
-
-	spin_lock(&j1939_netdev_lock);
-	priv = j1939_ndev_to_priv(ndev);
 	kref_put(&priv->rx_kref, __j1939_rx_release);
 	j1939_priv_put(priv);
-	spin_unlock(&j1939_netdev_lock);
 }
 
 int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb)
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 813aab534e91..41684cfd2eb7 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -436,7 +436,7 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	/* get new references */
 	ret = j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa);
 	if (ret) {
-		j1939_netdev_stop(ndev);
+		j1939_netdev_stop(priv);
 		goto out_dev_put;
 	}
 
@@ -563,7 +563,7 @@ static int j1939_sk_release(struct socket *sock)
 				    jsk->addr.sa);
 		j1939_priv_put(priv);
 
-		j1939_netdev_stop(ndev);
+		j1939_netdev_stop(priv);
 		dev_put(ndev);
 	}
 
@@ -1101,7 +1101,7 @@ void j1939_sk_netdev_event(struct net_device *ndev, int error_code)
 			j1939_local_ecu_put(priv, jsk->addr.src_name,
 					    jsk->addr.sa);
 
-			j1939_netdev_stop(ndev);
+			j1939_netdev_stop(priv);
 		}
 		/* do not remove filters here */
 	}
-- 
2.20.1

