Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD42848FB
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2019 11:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfHGJzt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Aug 2019 05:55:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38145 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfHGJzt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Aug 2019 05:55:49 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hvIfY-0005F4-HO; Wed, 07 Aug 2019 11:55:44 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hvIfX-0001hl-4T; Wed, 07 Aug 2019 11:55:43 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 1/5] j1939: transport: refactor j1939_tp_txtimer()
Date:   Wed,  7 Aug 2019 11:55:37 +0200
Message-Id: <20190807095541.2544-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807095541.2544-1-o.rempel@pengutronix.de>
References: <20190807095541.2544-1-o.rempel@pengutronix.de>
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

and move part of the code to sj1939_simple_txnext() function.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 57 ++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index a9c6273bc237..4d285a92bd41 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -989,6 +989,36 @@ static int j1939_xtp_txnext_receiver(struct j1939_session *session)
 	return ret;
 }
 
+static int j1939_simple_txnext(struct j1939_session *session)
+{
+	struct j1939_priv *priv = session->priv;
+	struct sk_buff *se_skb = j1939_session_skb_find(session);
+	struct sk_buff *skb;
+	int ret;
+
+	if (!se_skb)
+		return 0;
+
+	skb = skb_clone(se_skb, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	can_skb_set_owner(skb, se_skb->sk);
+	skb_shinfo(skb)->tx_flags &= ~SKBTX_ANY_TSTAMP;
+
+	j1939_tp_set_rxtimeout(session,
+			       J1939_XTP_ABORT_TIMEOUT_MS);
+
+	ret = j1939_send_one(priv, skb);
+	if (ret)
+		return ret;
+
+	j1939_sk_errqueue(session, J1939_ERRQUEUE_SCHED);
+	j1939_sk_queue_activate_next(session);
+
+	return 0;
+}
+
 bool j1939_session_deactivate(struct j1939_session *session)
 {
 	bool active = false;
@@ -1042,31 +1072,7 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 	int ret = 0;
 
 	if (session->skcb.addr.type == J1939_SIMPLE) {
-		struct j1939_priv *priv = session->priv;
-		struct sk_buff *se_skb = j1939_session_skb_find(session);
-
-		if (se_skb) {
-			struct sk_buff *skb;
-
-			skb = skb_clone(se_skb, GFP_ATOMIC);
-			if (skb) {
-				can_skb_set_owner(skb, se_skb->sk);
-				skb_shinfo(skb)->tx_flags &= ~SKBTX_ANY_TSTAMP;
-
-				j1939_tp_set_rxtimeout(session,
-						       J1939_XTP_ABORT_TIMEOUT_MS);
-
-				ret = j1939_send_one(priv, skb);
-				if (!ret) {
-					j1939_sk_errqueue(session,
-							  J1939_ERRQUEUE_SCHED);
-					j1939_sk_queue_activate_next(session);
-				}
-			} else {
-				ret = -ENOMEM;
-				session->err = ret;
-			}
-		}
+		ret = j1939_simple_txnext(session);
 	} else {
 		if (session->transmission)
 			ret = j1939_xtp_txnext_transmiter(session);
@@ -1095,6 +1101,7 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 					       J1939_XTP_ABORT_TIMEOUT_MS);
 			j1939_session_cancel(session, J1939_XTP_ABORT_OTHER);
 		} else {
+			session->err = ret;
 			j1939_session_rxtimer_cancel(session);
 			j1939_session_deactivate_activate_next(session);
 		}
-- 
2.20.1

