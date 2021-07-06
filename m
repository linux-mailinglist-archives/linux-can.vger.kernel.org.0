Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B053BD662
	for <lists+linux-can@lfdr.de>; Tue,  6 Jul 2021 14:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242276AbhGFMdT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Jul 2021 08:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245138AbhGFMM3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Jul 2021 08:12:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFBFC041B0D
        for <linux-can@vger.kernel.org>; Tue,  6 Jul 2021 04:58:03 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m0jiC-0006CI-Rg; Tue, 06 Jul 2021 13:58:00 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m0jiC-0002vT-6G; Tue, 06 Jul 2021 13:58:00 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        David Jander <david@protonic.nl>,
        Zhang Changzhong <zhangchangzhong@huawei.com>
Subject: [PATCH v1 1/2] net: j1939: rename J1939_ERRQUEUE_* to J1939_ERRQUEUE_TX_*
Date:   Tue,  6 Jul 2021 13:57:57 +0200
Message-Id: <20210706115758.11196-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Prepare the world for the J1939_ERRQUEUE_RX_ version

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h | 6 +++---
 net/can/j1939/socket.c     | 6 +++---
 net/can/j1939/transport.c  | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 12369b604ce9..93b8ad7f7d04 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -20,9 +20,9 @@
 
 struct j1939_session;
 enum j1939_sk_errqueue_type {
-	J1939_ERRQUEUE_ACK,
-	J1939_ERRQUEUE_SCHED,
-	J1939_ERRQUEUE_ABORT,
+	J1939_ERRQUEUE_TX_ACK,
+	J1939_ERRQUEUE_TX_SCHED,
+	J1939_ERRQUEUE_TX_ABORT,
 };
 
 /* j1939 devices */
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 56aa66147d5a..c2bf1c02597e 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -961,7 +961,7 @@ void j1939_sk_errqueue(struct j1939_session *session,
 	serr = SKB_EXT_ERR(skb);
 	memset(serr, 0, sizeof(*serr));
 	switch (type) {
-	case J1939_ERRQUEUE_ACK:
+	case J1939_ERRQUEUE_TX_ACK:
 		if (!(sk->sk_tsflags & SOF_TIMESTAMPING_TX_ACK)) {
 			kfree_skb(skb);
 			return;
@@ -972,7 +972,7 @@ void j1939_sk_errqueue(struct j1939_session *session,
 		serr->ee.ee_info = SCM_TSTAMP_ACK;
 		state = "ACK";
 		break;
-	case J1939_ERRQUEUE_SCHED:
+	case J1939_ERRQUEUE_TX_SCHED:
 		if (!(sk->sk_tsflags & SOF_TIMESTAMPING_TX_SCHED)) {
 			kfree_skb(skb);
 			return;
@@ -983,7 +983,7 @@ void j1939_sk_errqueue(struct j1939_session *session,
 		serr->ee.ee_info = SCM_TSTAMP_SCHED;
 		state = "SCH";
 		break;
-	case J1939_ERRQUEUE_ABORT:
+	case J1939_ERRQUEUE_TX_ABORT:
 		serr->ee.ee_errno = session->err;
 		serr->ee.ee_origin = SO_EE_ORIGIN_LOCAL;
 		serr->ee.ee_info = J1939_EE_INFO_TX_ABORT;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index e09d087ba240..362cf38cacca 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -261,9 +261,9 @@ static void __j1939_session_drop(struct j1939_session *session)
 static void j1939_session_destroy(struct j1939_session *session)
 {
 	if (session->err)
-		j1939_sk_errqueue(session, J1939_ERRQUEUE_ABORT);
+		j1939_sk_errqueue(session, J1939_ERRQUEUE_TX_ABORT);
 	else
-		j1939_sk_errqueue(session, J1939_ERRQUEUE_ACK);
+		j1939_sk_errqueue(session, J1939_ERRQUEUE_TX_ACK);
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
@@ -1026,7 +1026,7 @@ static int j1939_simple_txnext(struct j1939_session *session)
 	if (ret)
 		return ret;
 
-	j1939_sk_errqueue(session, J1939_ERRQUEUE_SCHED);
+	j1939_sk_errqueue(session, J1939_ERRQUEUE_TX_SCHED);
 	j1939_sk_queue_activate_next(session);
 
 	return 0;
@@ -1405,7 +1405,7 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 		if (session->transmission) {
 			if (session->pkt.tx_acked)
 				j1939_sk_errqueue(session,
-						  J1939_ERRQUEUE_SCHED);
+						  J1939_ERRQUEUE_TX_SCHED);
 			j1939_session_txtimer_cancel(session);
 			j1939_tp_schedule_txtimer(session, 0);
 		}
-- 
2.30.2

