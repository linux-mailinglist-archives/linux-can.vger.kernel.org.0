Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAF56332C
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfGII70 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50607 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfGII70 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:26 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxx-00085i-9Z; Tue, 09 Jul 2019 10:59:13 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000lx-Sa; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 27/34] j1939: transport: print some debug information on session creation and relase
Date:   Tue,  9 Jul 2019 10:59:02 +0200
Message-Id: <20190709085909.1413-27-o.rempel@pengutronix.de>
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
 net/can/j1939/transport.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 75593ec0852a..ca2571bed0de 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -238,6 +238,8 @@ static void j1939_session_destroy(struct j1939_session *session)
 	else
 		j1939_sk_errqueue(session, J1939_ERRQUEUE_ACK);
 
+	netdev_dbg(session->priv->ndev, "j1939_session_destroy: 0x%p\n", session);
+
 	skb_queue_purge(&session->skb_queue);
 	__j1939_session_drop(session);
 	j1939_priv_put(session->priv);
@@ -1267,6 +1269,9 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 		     HRTIMER_MODE_REL_SOFT);
 	session->rxtimer.function = j1939_tp_rxtimer;
 
+	netdev_dbg(priv->ndev, "j1939_session_new: 0x%p: sa: %02x, da: %02x\n",
+		   session, skcb->addr.sa, skcb->addr.da);
+
 	return session;
 }
 
-- 
2.20.1

