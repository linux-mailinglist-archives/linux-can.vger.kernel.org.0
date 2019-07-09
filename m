Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3AD963327
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfGII7X (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47879 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfGII7X (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:23 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085d-Vv; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000lB-ND; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 22/34] j1939: use separate refcounting for sockets
Date:   Tue,  9 Jul 2019 10:58:57 +0200
Message-Id: <20190709085909.1413-22-o.rempel@pengutronix.de>
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

We should call can_rx_unregister() and clear ECU cache before destroying
priv.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  1 +
 net/can/j1939/main.c       | 49 ++++++++++++++++++++++++++++++++------
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 052fef9b6985..d668658ef421 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -75,6 +75,7 @@ struct j1939_priv {
 
 	struct list_head j1939_socks;
 	spinlock_t j1939_socks_lock;
+	struct kref rx_kref;
 };
 
 void j1939_ecu_put(struct j1939_ecu *ecu);
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 0382199ceb2d..9a711ddeae0d 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -115,6 +115,7 @@ static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
 	INIT_LIST_HEAD(&priv->ecus);
 	priv->ndev = ndev;
 	kref_init(&priv->kref);
+	kref_init(&priv->rx_kref);
 	dev_hold(ndev);
 	netdev_dbg(priv->ndev, "j1939_priv_create: 0x%p\n", priv);
 
@@ -134,9 +135,6 @@ static void __j1939_priv_release(struct kref *kref)
 	struct j1939_priv *priv = container_of(kref, struct j1939_priv, kref);
 	struct net_device *ndev = priv->ndev;
 
-	can_rx_unregister(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
-			  j1939_can_recv, priv);
-
 	/* unlink from netdev */
 	j1939_priv_set(ndev, NULL);
 	netdev_dbg(priv->ndev, "__j1939_priv_release: 0x%p\n", priv);
@@ -155,6 +153,41 @@ void j1939_priv_get(struct j1939_priv *priv)
 	kref_get(&priv->kref);
 }
 
+static int j1939_can_rx_register(struct j1939_priv *priv)
+{
+	struct net_device *ndev = priv->ndev;
+	int ret;
+
+	j1939_priv_get(priv);
+	ret = can_rx_register(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
+			      j1939_can_recv, priv, "j1939", NULL);
+	if (ret < 0) {
+		j1939_priv_put(priv);
+		return ret;
+	}
+
+	return 0;
+}
+
+void j1939_can_rx_unregister(struct j1939_priv *priv)
+{
+	struct net_device *ndev = priv->ndev;
+
+	can_rx_unregister(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
+			  j1939_can_recv, priv);
+
+	j1939_priv_put(priv);
+}
+
+static void __j1939_rx_release(struct kref *kref)
+{
+	struct j1939_priv *priv = container_of(kref, struct j1939_priv,
+					       rx_kref);
+
+	j1939_can_rx_unregister(priv);
+	j1939_ecu_unmap_all(priv);
+}
+
 /* get pointer to priv without increasing ref counter */
 static inline struct j1939_priv *j1939_ndev_to_priv(struct net_device *ndev)
 {
@@ -196,8 +229,10 @@ struct j1939_priv *j1939_netdev_start(struct net *net, struct net_device *ndev)
 	int ret;
 
 	priv = j1939_priv_get_by_ndev(ndev);
-	if (priv)
+	if (priv) {
+		kref_get(&priv->rx_kref);
 		return priv;
+	}
 
 	priv = j1939_priv_create(ndev);
 	if (!priv)
@@ -207,7 +242,6 @@ struct j1939_priv *j1939_netdev_start(struct net *net, struct net_device *ndev)
 	spin_lock_init(&priv->j1939_socks_lock);
 	INIT_LIST_HEAD(&priv->j1939_socks);
 
-	/* add CAN handler */
 	spin_lock(&j1939_netdev_lock);
 	priv_new = j1939_priv_get_by_ndev_locked(ndev);
 	if (priv_new) {
@@ -217,13 +251,13 @@ struct j1939_priv *j1939_netdev_start(struct net *net, struct net_device *ndev)
 		spin_unlock(&j1939_netdev_lock);
 		dev_put(ndev);
 		kfree(priv);
+		kref_get(&priv_new->rx_kref);
 		return priv_new;
 	}
 	j1939_priv_set(ndev, priv);
 	spin_unlock(&j1939_netdev_lock);
 
-	ret = can_rx_register(net, ndev, J1939_CAN_ID, J1939_CAN_MASK,
-			      j1939_can_recv, priv, "j1939", NULL);
+	ret = j1939_can_rx_register(priv);
 	if (ret < 0)
 		goto out_priv_put;
 
@@ -243,6 +277,7 @@ void j1939_netdev_stop(struct net_device *ndev)
 
 	spin_lock(&j1939_netdev_lock);
 	priv = j1939_ndev_to_priv(ndev);
+	kref_put(&priv->rx_kref, __j1939_rx_release);
 	j1939_priv_put(priv);
 	spin_unlock(&j1939_netdev_lock);
 }
-- 
2.20.1

