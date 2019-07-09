Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC38463331
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfGII7c (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50799 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfGII7b (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:31 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxx-00085m-H3; Tue, 09 Jul 2019 10:59:13 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-0000n9-0R; Tue, 09 Jul 2019 10:59:12 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 31/34] j1939: main: unregister priv form ndev on last socket
Date:   Tue,  9 Jul 2019 10:59:06 +0200
Message-Id: <20190709085909.1413-31-o.rempel@pengutronix.de>
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

Since we are using proper kref, there is no way back on last socket.
We should unregister old priv and allow to destroy it. The new one
will be register as soon as socket will need it again.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 315166ef3eb1..ac026a8408c3 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -135,8 +135,6 @@ static void __j1939_priv_release(struct kref *kref)
 	struct j1939_priv *priv = container_of(kref, struct j1939_priv, kref);
 	struct net_device *ndev = priv->ndev;
 
-	/* unlink from netdev */
-	j1939_priv_set(ndev, NULL);
 	netdev_dbg(priv->ndev, "__j1939_priv_release: 0x%p\n", priv);
 
 	dev_put(ndev);
@@ -186,6 +184,7 @@ static void __j1939_rx_release(struct kref *kref)
 
 	j1939_can_rx_unregister(priv);
 	j1939_ecu_unmap_all(priv);
+	j1939_priv_set(priv->ndev, NULL);
 }
 
 /* get pointer to priv without increasing ref counter */
-- 
2.20.1

