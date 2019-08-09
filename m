Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 241D687459
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 10:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405904AbfHIIiC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 04:38:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54009 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfHIIiC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 04:38:02 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NQ-00059F-IT; Fri, 09 Aug 2019 10:35:56 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NO-0004QH-Qr; Fri, 09 Aug 2019 10:35:54 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 14/21] j1939: socket: cancel all socket related active sessions on j1939_sk_release()
Date:   Fri,  9 Aug 2019 10:35:46 +0200
Message-Id: <20190809083553.16687-15-o.rempel@pengutronix.de>
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

Since we may have multiple active sessions started from one socket, we
need to take care of them to properly clean up the resources.

This action is needed only if user space application is send a signal,
i.e. when aborting the application with Ctrl-c.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/socket.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 9308e08d6ba9..e208eaa22ef9 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -560,8 +560,10 @@ static int j1939_sk_release(struct socket *sock)
 		priv = j1939_priv_get_by_ndev(ndev);
 
 		if (wait_event_interruptible(jsk->waitq,
-					     !j1939_sock_pending_get(&jsk->sk)))
+					     !j1939_sock_pending_get(&jsk->sk))) {
+			j1939_cancel_active_session(priv, sk);
 			j1939_sk_queue_drop_all(priv, jsk, ESHUTDOWN);
+		}
 
 		j1939_jsk_del(priv, jsk);
 
-- 
2.20.1

