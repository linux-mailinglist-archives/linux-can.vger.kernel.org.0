Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F6C63334
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfGII7e (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39125 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfGII7d (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:33 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hkly1-00085S-1L; Tue, 09 Jul 2019 10:59:17 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000do-Ae; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 11/34] j1939: add j1939_priv_get_by_ndev_locked
Date:   Tue,  9 Jul 2019 10:58:46 +0200
Message-Id: <20190709085909.1413-11-o.rempel@pengutronix.de>
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

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/main.c | 63 +++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 33530d450856..8481c46c6b08 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -156,14 +156,47 @@ void j1939_priv_get(struct j1939_priv *priv)
 	kref_get(&priv->kref);
 }
 
+/* get pointer to priv without increasing ref counter */
+static inline struct j1939_priv *j1939_ndev_to_priv(struct net_device *ndev)
+{
+	struct can_ml_priv *can_ml_priv = ndev->ml_priv;
+
+	return can_ml_priv->j1939_priv;
+}
+
+static struct j1939_priv *j1939_priv_get_by_ndev_locked(struct net_device *ndev)
+{
+	struct j1939_priv *priv;
+
+	lockdep_assert_held(&j1939_netdev_lock);
+
+	if (ndev->type != ARPHRD_CAN)
+		return NULL;
+
+	priv = j1939_ndev_to_priv(ndev);
+	if (priv)
+		j1939_priv_get(priv);
+
+	return priv;
+}
+
+struct j1939_priv *j1939_priv_get_by_ndev(struct net_device *ndev)
+{
+	struct j1939_priv *priv;
+
+	spin_lock_bh(&j1939_netdev_lock);
+	priv = j1939_priv_get_by_ndev_locked(ndev);
+	spin_unlock_bh(&j1939_netdev_lock);
+
+	return priv;
+}
+
 int j1939_netdev_start(struct net *net, struct net_device *ndev)
 {
 	struct j1939_priv *priv;
 	int ret;
 
-	spin_lock(&j1939_netdev_lock);
 	priv = j1939_priv_get_by_ndev(ndev);
-	spin_unlock(&j1939_netdev_lock);
 	if (priv)
 		return 0;
 
@@ -182,7 +215,7 @@ int j1939_netdev_start(struct net *net, struct net_device *ndev)
 		goto out_dev_put;
 
 	spin_lock(&j1939_netdev_lock);
-	if (j1939_priv_get_by_ndev(ndev)) {
+	if (j1939_priv_get_by_ndev_locked(ndev)) {
 		/* Someone was faster than us, use their priv and roll
 		 * back our's.
 		 */
@@ -204,14 +237,6 @@ int j1939_netdev_start(struct net *net, struct net_device *ndev)
 	return ret;
 }
 
-/* get pointer to priv without increasing ref counter */
-static inline struct j1939_priv *j1939_ndev_to_priv(struct net_device *ndev)
-{
-	struct can_ml_priv *can_ml_priv = ndev->ml_priv;
-
-	return can_ml_priv->j1939_priv;
-}
-
 void j1939_netdev_stop(struct net_device *ndev)
 {
 	struct j1939_priv *priv;
@@ -222,20 +247,6 @@ void j1939_netdev_stop(struct net_device *ndev)
 	spin_unlock(&j1939_netdev_lock);
 }
 
-struct j1939_priv *j1939_priv_get_by_ndev(struct net_device *ndev)
-{
-	struct j1939_priv *priv;
-
-	if (ndev->type != ARPHRD_CAN)
-		return NULL;
-
-	priv = j1939_ndev_to_priv(ndev);
-	if (priv)
-		j1939_priv_get(priv);
-
-	return priv;
-}
-
 int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb)
 {
 	int ret, dlc;
@@ -286,9 +297,7 @@ static int j1939_netdev_notify(struct notifier_block *nb,
 	struct net_device *ndev = netdev_notifier_info_to_dev(data);
 	struct j1939_priv *priv;
 
-	spin_lock(&j1939_netdev_lock);
 	priv = j1939_priv_get_by_ndev(ndev);
-	spin_unlock(&j1939_netdev_lock);
 	if (!priv)
 		goto notify_done;
 
-- 
2.20.1

