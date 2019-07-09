Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E2963323
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfGII7X (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34859 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfGII7W (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:22 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085c-Ny; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000l2-M9; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 21/34] j1939: j1939_netdev_start(): fix race condition: rx register after priv has been linked to the netdev
Date:   Tue,  9 Jul 2019 10:58:56 +0200
Message-Id: <20190709085909.1413-21-o.rempel@pengutronix.de>
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

As soon as the rx callback has been registered the kernel stack might
receive address claiming frames which use the priv.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/main.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index dee3a1870d76..0382199ceb2d 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -208,11 +208,6 @@ struct j1939_priv *j1939_netdev_start(struct net *net, struct net_device *ndev)
 	INIT_LIST_HEAD(&priv->j1939_socks);
 
 	/* add CAN handler */
-	ret = can_rx_register(net, ndev, J1939_CAN_ID, J1939_CAN_MASK,
-			      j1939_can_recv, priv, "j1939", NULL);
-	if (ret < 0)
-		goto out_dev_put;
-
 	spin_lock(&j1939_netdev_lock);
 	priv_new = j1939_priv_get_by_ndev_locked(ndev);
 	if (priv_new) {
@@ -220,8 +215,6 @@ struct j1939_priv *j1939_netdev_start(struct net *net, struct net_device *ndev)
 		 * back our's.
 		 */
 		spin_unlock(&j1939_netdev_lock);
-		can_rx_unregister(net, ndev, J1939_CAN_ID, J1939_CAN_MASK,
-				  j1939_can_recv, priv);
 		dev_put(ndev);
 		kfree(priv);
 		return priv_new;
@@ -229,9 +222,15 @@ struct j1939_priv *j1939_netdev_start(struct net *net, struct net_device *ndev)
 	j1939_priv_set(ndev, priv);
 	spin_unlock(&j1939_netdev_lock);
 
+	ret = can_rx_register(net, ndev, J1939_CAN_ID, J1939_CAN_MASK,
+			      j1939_can_recv, priv, "j1939", NULL);
+	if (ret < 0)
+		goto out_priv_put;
+
 	return priv;
 
- out_dev_put:
+ out_priv_put:
+	j1939_priv_set(ndev, NULL);
 	dev_put(ndev);
 	kfree(priv);
 
-- 
2.20.1

