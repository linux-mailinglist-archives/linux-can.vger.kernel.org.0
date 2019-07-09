Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F8263330
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfGII7b (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43153 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfGII7b (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:31 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxx-00085n-6T; Tue, 09 Jul 2019 10:59:13 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-0000nR-1X; Tue, 09 Jul 2019 10:59:12 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 32/34] j1939: main: avoid race condition on priv alloc/destroy
Date:   Tue,  9 Jul 2019 10:59:07 +0200
Message-Id: <20190709085909.1413-32-o.rempel@pengutronix.de>
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

If we run hundreds of socket parallel we may run in to situation
where last socket is about to unregister old priv and the new one
is taking it half usable.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index ac026a8408c3..ac786bde5948 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -185,6 +185,7 @@ static void __j1939_rx_release(struct kref *kref)
 	j1939_can_rx_unregister(priv);
 	j1939_ecu_unmap_all(priv);
 	j1939_priv_set(priv->ndev, NULL);
+	spin_unlock(&j1939_netdev_lock);
 }
 
 /* get pointer to priv without increasing ref counter */
@@ -215,9 +216,9 @@ struct j1939_priv *j1939_priv_get_by_ndev(struct net_device *ndev)
 {
 	struct j1939_priv *priv;
 
-	spin_lock_bh(&j1939_netdev_lock);
+	spin_lock(&j1939_netdev_lock);
 	priv = j1939_priv_get_by_ndev_locked(ndev);
-	spin_unlock_bh(&j1939_netdev_lock);
+	spin_unlock(&j1939_netdev_lock);
 
 	return priv;
 }
@@ -272,7 +273,7 @@ struct j1939_priv *j1939_netdev_start(struct net *net, struct net_device *ndev)
 
 void j1939_netdev_stop(struct j1939_priv *priv)
 {
-	kref_put(&priv->rx_kref, __j1939_rx_release);
+	kref_put_lock(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
 	j1939_priv_put(priv);
 }
 
-- 
2.20.1

