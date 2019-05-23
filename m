Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7308D27985
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfEWJlx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55267 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbfEWJlw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:52 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEI-0001G3-Po; Thu, 23 May 2019 11:41:42 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-00044n-Gq; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 10/17] j1939: transport: cancel session on j1939_tp_txnext error
Date:   Thu, 23 May 2019 11:41:32 +0200
Message-Id: <20190523094139.15517-11-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523094139.15517-1-o.rempel@pengutronix.de>
References: <20190523094139.15517-1-o.rempel@pengutronix.de>
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
 net/can/j1939/transport.c | 42 ++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 93df0c0c8ce2..13ffc7d315b2 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -840,7 +840,24 @@ static int j1939_tp_txnext(struct j1939_session *session)
 	return ret;
 }
 
-/* timer & scheduler functions */
+static void j1939_session_cancel(struct j1939_session *session,
+				 enum j1939_xtp_abort err)
+{
+	struct j1939_priv *priv = session->priv;
+
+	WARN_ON_ONCE(!err);
+
+	session->err = j1939_xtp_abort_to_errno(priv, err);
+	/* do not send aborts on incoming broadcasts */
+	if (!j1939_cb_is_broadcast(&session->skcb))
+		j1939_xtp_tx_abort(priv, &session->skcb,
+				   !(session->skcb.src_flags & J1939_ECU_LOCAL),
+				   err, session->skcb.addr.pgn);
+
+	if (session->sk)
+		j1939_sk_send_multi_abort(priv, session->sk, session->err);
+}
+
 static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 {
 	struct j1939_session *session =
@@ -858,8 +875,11 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		ret = j1939_tp_txnext(session);
 	}
 
-	if (ret < 0)
+	if (ret == -ENOBUFS) {
 		j1939_tp_schedule_txtimer(session, 10 + prandom_u32_max(16));
+	} else if (ret) {
+		j1939_session_cancel(session, J1939_XTP_ABORT_OTHER);
+	}
 
 	j1939_session_put(session);
 
@@ -874,24 +894,6 @@ static void j1939_session_completed(struct j1939_session *session)
 	j1939_sk_recv(session->priv, se_skb);
 }
 
-static void j1939_session_cancel(struct j1939_session *session,
-				 enum j1939_xtp_abort err)
-{
-	struct j1939_priv *priv = session->priv;
-
-	WARN_ON_ONCE(!err);
-
-	session->err = j1939_xtp_abort_to_errno(priv, err);
-	/* do not send aborts on incoming broadcasts */
-	if (!j1939_cb_is_broadcast(&session->skcb))
-		j1939_xtp_tx_abort(priv, &session->skcb,
-				   !(session->skcb.src_flags & J1939_ECU_LOCAL),
-				   err, session->skcb.addr.pgn);
-
-	if (session->sk)
-		j1939_sk_send_multi_abort(priv, session->sk, session->err);
-}
-
 static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 {
 	struct j1939_session *session = container_of(hrtimer,
-- 
2.20.1

