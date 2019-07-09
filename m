Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6328B63325
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGII7Y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49649 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfGII7Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:24 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxx-00085f-5I; Tue, 09 Jul 2019 10:59:13 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000lU-Pb; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 24/34] j1939: transport: wait for abort packet before complete session
Date:   Tue,  9 Jul 2019 10:58:59 +0200
Message-Id: <20190709085909.1413-24-o.rempel@pengutronix.de>
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

Wait for abort on CAN bus before starting new session. If we will
not wait, we will abort next, fresh new session by accident.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  5 ++++-
 net/can/j1939/transport.c  | 17 +++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 1e470a394fff..4c6365804de1 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -9,7 +9,10 @@
 #include <linux/can/j1939.h>
 #include <net/sock.h>
 
-/* TODO: return ENETRESET on busoff. */
+/* Timeout to receive the abort signal over loop back. In case CAN
+ * bus is open, the timeout should be triggered.
+ */
+#define J1939_XTP_ABORT_TIMEOUT_MS 500
 
 struct j1939_session;
 enum j1939_sk_errqueue_type {
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index aaf9bf9fd90e..79233f7884cc 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -957,10 +957,12 @@ static void j1939_session_cancel(struct j1939_session *session,
 
 	session->err = j1939_xtp_abort_to_errno(priv, err);
 	/* do not send aborts on incoming broadcasts */
-	if (!j1939_cb_is_broadcast(&session->skcb))
+	if (!j1939_cb_is_broadcast(&session->skcb)) {
+		session->state = J1939_SESSION_WAITING_ABORT;
 		j1939_xtp_tx_abort(priv, &session->skcb,
 				   !j1939_tp_im_transmitter(&session->skcb),
 				   err, session->skcb.addr.pgn);
+	}
 
 	if (session->sk)
 		j1939_sk_send_loop_abort(priv, session->sk, session->err);
@@ -1012,8 +1014,11 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 	} else if (ret) {
 		netdev_alert(priv->ndev, "%s: tx aborted with unknown reason: %i\n",
 			     __func__, ret);
-		if (session->skcb.addr.type != J1939_SIMPLE)
+		if (session->skcb.addr.type != J1939_SIMPLE) {
+			j1939_tp_set_rxtimeout(session,
+					       J1939_XTP_ABORT_TIMEOUT_MS);
 			j1939_session_cancel(session, J1939_XTP_ABORT_OTHER);
+		}
 	} else {
 		session->tx_retry = 0;
 	}
@@ -1052,9 +1057,9 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 		j1939_session_list_lock(session->priv);
 		if (session->state >= J1939_SESSION_ACTIVE &&
 		    session->state < J1939_SESSION_ACTIVE_MAX) {
-			session->state = J1939_SESSION_WAITING_ABORT;
 			j1939_session_get(session);
-			hrtimer_start(&session->rxtimer, ms_to_ktime(1250),
+			hrtimer_start(&session->rxtimer,
+				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
 				      HRTIMER_MODE_REL_SOFT);
 			j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
 		}
@@ -1226,6 +1231,7 @@ j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb)
  out_session_unlock:
 	j1939_session_unlock(session);
 	j1939_session_timers_cancel(session);
+	j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
 	j1939_session_cancel(session, err);
 }
 
@@ -1404,6 +1410,7 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 
 		/* RTS on active session */
 		j1939_session_timers_cancel(session);
+		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
 	}
 
@@ -1414,6 +1421,7 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 			     session->last_cmd);
 
 		j1939_session_timers_cancel(session);
+		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
 
 		return -EBUSY;
@@ -1544,6 +1552,7 @@ static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb)
 	j1939_session_unlock(session);
  out_session_cancel:
 	j1939_session_timers_cancel(session);
+	j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
 	j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
 	j1939_session_put(session);
 }
-- 
2.20.1

