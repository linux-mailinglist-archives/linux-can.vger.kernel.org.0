Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3FE463321
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfGII7W (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46737 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGII7V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:21 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085b-Ny; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000kt-LB; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 20/34] j1939: j1939_sk_bind(): during re-bind(): remove socket temporary from sockets list
Date:   Tue,  9 Jul 2019 10:58:55 +0200
Message-Id: <20190709085909.1413-20-o.rempel@pengutronix.de>
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

... this also fixes the cleanup and reference counting in
j1939_sk_release() if j1939_local_ecu_get() fails.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index c78b41b55d21..813aab534e91 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -409,6 +409,7 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 
 		/* drop old references */
 		priv = j1939_priv_get_by_ndev(ndev);
+		j1939_jsk_del(priv, jsk);
 		j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
 		j1939_priv_put(priv);
 	} else {
@@ -439,8 +440,7 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		goto out_dev_put;
 	}
 
-	if (!(jsk->state & J1939_SOCK_BOUND))
-		j1939_jsk_add(priv, jsk);
+	j1939_jsk_add(priv, jsk);
 
  out_dev_put: /* fallthrough */
 	dev_put(ndev);
-- 
2.20.1

