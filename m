Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7706332B
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfGII70 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51195 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfGII7X (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:23 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085Z-KI; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000kL-It; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 18/34] j1939: j1939_sk_bind(): reduce unneeded reference counting a bit
Date:   Tue,  9 Jul 2019 10:58:53 +0200
Message-Id: <20190709085909.1413-18-o.rempel@pengutronix.de>
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
 net/can/j1939/socket.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 49c2d3601ca0..a94e36d54c2d 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -392,6 +392,7 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		/* drop old references */
 		priv = j1939_priv_get_by_ndev(ndev);
 		j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
+		j1939_priv_put(priv);
 	} else {
 		if (ndev->type != ARPHRD_CAN) {
 			ret = -ENODEV;
@@ -405,7 +406,6 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		}
 
 		jsk->ifindex = addr->can_ifindex;
-		j1939_priv_get(priv);
 	}
 
 	/* set default transmit pgn */
@@ -418,7 +418,7 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	ret = j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa);
 	if (ret) {
 		j1939_netdev_stop(ndev);
-		goto out_priv_put;
+		goto out_dev_put;
 	}
 
 	if (!(jsk->state & J1939_SOCK_BOUND)) {
@@ -429,9 +429,7 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		jsk->state |= J1939_SOCK_BOUND;
 	}
 
- out_priv_put:	/* fallthrough */
-	j1939_priv_put(priv);
- out_dev_put:
+ out_dev_put: /* fallthrough */
 	dev_put(ndev);
  out_release_sock:
 	release_sock(sock->sk);
-- 
2.20.1

