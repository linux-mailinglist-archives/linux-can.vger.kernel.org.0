Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28BB663338
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 11:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfGIJAt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 05:00:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50721 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfGIJAt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 05:00:49 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085Y-HA; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000kA-Hj; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 17/34] j1939: rework j1939_netdev_start() to return priv directly
Date:   Tue,  9 Jul 2019 10:58:52 +0200
Message-Id: <20190709085909.1413-17-o.rempel@pengutronix.de>
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

we have too many priv seeking functions on the bind. Let's reduce some
of them.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  2 +-
 net/can/j1939/main.c       | 24 +++++++++++++-----------
 net/can/j1939/socket.c     |  8 +++++---
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index c9f1b0df4478..052fef9b6985 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -191,7 +191,7 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu);
 void j1939_ecu_timer_cancel(struct j1939_ecu *ecu);
 void j1939_ecu_unmap_all(struct j1939_priv *priv);
 
-int j1939_netdev_start(struct net *net, struct net_device *ndev);
+struct j1939_priv *j1939_netdev_start(struct net *net, struct net_device *ndev);
 void j1939_netdev_stop(struct net_device *ndev);
 
 struct j1939_priv *j1939_priv_get_by_ndev(struct net_device *ndev);
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index fb31eea9d8bc..dee3a1870d76 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -190,18 +190,18 @@ struct j1939_priv *j1939_priv_get_by_ndev(struct net_device *ndev)
 	return priv;
 }
 
-int j1939_netdev_start(struct net *net, struct net_device *ndev)
+struct j1939_priv *j1939_netdev_start(struct net *net, struct net_device *ndev)
 {
-	struct j1939_priv *priv;
+	struct j1939_priv *priv, *priv_new;
 	int ret;
 
 	priv = j1939_priv_get_by_ndev(ndev);
 	if (priv)
-		return 0;
+		return priv;
 
 	priv = j1939_priv_create(ndev);
 	if (!priv)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	j1939_tp_init(priv);
 	spin_lock_init(&priv->j1939_socks_lock);
@@ -214,26 +214,28 @@ int j1939_netdev_start(struct net *net, struct net_device *ndev)
 		goto out_dev_put;
 
 	spin_lock(&j1939_netdev_lock);
-	if (j1939_priv_get_by_ndev_locked(ndev)) {
+	priv_new = j1939_priv_get_by_ndev_locked(ndev);
+	if (priv_new) {
 		/* Someone was faster than us, use their priv and roll
 		 * back our's.
 		 */
 		spin_unlock(&j1939_netdev_lock);
-		goto out_rx_unregister;
+		can_rx_unregister(net, ndev, J1939_CAN_ID, J1939_CAN_MASK,
+				  j1939_can_recv, priv);
+		dev_put(ndev);
+		kfree(priv);
+		return priv_new;
 	}
 	j1939_priv_set(ndev, priv);
 	spin_unlock(&j1939_netdev_lock);
 
-	return 0;
+	return priv;
 
- out_rx_unregister:
-	can_rx_unregister(net, ndev, J1939_CAN_ID, J1939_CAN_MASK,
-			  j1939_can_recv, priv);
  out_dev_put:
 	dev_put(ndev);
 	kfree(priv);
 
-	return ret;
+	return ERR_PTR(ret);
 }
 
 void j1939_netdev_stop(struct net_device *ndev)
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 12db6a32efee..49c2d3601ca0 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -398,12 +398,14 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 			goto out_dev_put;
 		}
 
-		ret = j1939_netdev_start(net, ndev);
-		if (ret < 0)
+		priv = j1939_netdev_start(net, ndev);
+		if (IS_ERR(priv)) {
+			ret = PTR_ERR(priv);
 			goto out_dev_put;
+		}
 
 		jsk->ifindex = addr->can_ifindex;
-		priv = j1939_priv_get_by_ndev(ndev);
+		j1939_priv_get(priv);
 	}
 
 	/* set default transmit pgn */
-- 
2.20.1

