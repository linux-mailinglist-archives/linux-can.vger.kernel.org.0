Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C1963333
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfGII7c (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48353 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfGII7b (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:31 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxx-00085k-AO; Tue, 09 Jul 2019 10:59:13 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000mU-Ud; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 29/34] j1939: transport: add (E)TP self reception support
Date:   Tue,  9 Jul 2019 10:59:04 +0200
Message-Id: <20190709085909.1413-29-o.rempel@pengutronix.de>
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

In some cases we have multiple ECUs on one system. This
ECUs should be able to communicate with remote and local
ECUs over same socket.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 243 ++++++++++++++++++++++++++------------
 1 file changed, 166 insertions(+), 77 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index efaa7c7a10d2..91aa97edab94 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -468,7 +468,7 @@ static struct
 j1939_session *j1939_session_get_by_addr_locked(struct j1939_priv *priv,
 						struct list_head *root,
 						struct j1939_addr *addr,
-						bool reverse)
+						bool reverse, bool transmitter)
 {
 	struct j1939_session *session;
 
@@ -476,7 +476,8 @@ j1939_session *j1939_session_get_by_addr_locked(struct j1939_priv *priv,
 
 	list_for_each_entry(session, root, active_session_list_entry) {
 		j1939_session_get(session);
-		if (j1939_session_match(&session->skcb.addr, addr, reverse))
+		if (j1939_session_match(&session->skcb.addr, addr, reverse) &&
+		    session->transmission == transmitter)
 			return session;
 		j1939_session_put(session);
 	}
@@ -487,14 +488,14 @@ j1939_session *j1939_session_get_by_addr_locked(struct j1939_priv *priv,
 static struct
 j1939_session *j1939_session_get_by_addr(struct j1939_priv *priv,
 					 struct j1939_addr *addr,
-					 bool reverse)
+					 bool reverse, bool transmitter)
 {
 	struct j1939_session *session;
 
 	j1939_session_list_lock(priv);
 	session = j1939_session_get_by_addr_locked(priv,
 						   &priv->active_session_list,
-						   addr, reverse);
+						   addr, reverse, transmitter);
 	j1939_session_list_unlock(priv);
 
 	return session;
@@ -962,7 +963,7 @@ static void j1939_session_cancel(struct j1939_session *session,
 	if (!j1939_cb_is_broadcast(&session->skcb)) {
 		session->state = J1939_SESSION_WAITING_ABORT;
 		j1939_xtp_tx_abort(priv, &session->skcb,
-				   !j1939_tp_im_transmitter(&session->skcb),
+				   !session->transmission,
 				   err, session->skcb.addr.pgn);
 	}
 
@@ -1032,10 +1033,13 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 
 static void j1939_session_completed(struct j1939_session *session)
 {
-	struct sk_buff *skb = j1939_session_skb_find(session);
+	struct sk_buff *skb;
 
-	/* distribute among j1939 receivers */
-	j1939_sk_recv(session->priv, skb);
+	if (!session->transmission) {
+		skb = j1939_session_skb_find(session);
+		/* distribute among j1939 receivers */
+		j1939_sk_recv(session->priv, skb);
+	}
 
 	j1939_session_deactivate_activate_next(session);
 }
@@ -1127,13 +1131,14 @@ static bool j1939_xtp_rx_cmd_bad_pgn(struct j1939_session *session,
 }
 
 static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
-				   bool reverse)
+				   bool reverse, bool transmitter)
 {
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 	struct j1939_session *session;
 	u8 abort = skb->data[1];
 
-	session = j1939_session_get_by_addr(priv, &skcb->addr, reverse);
+	session = j1939_session_get_by_addr(priv, &skcb->addr, reverse,
+					    transmitter);
 	if (!session)
 		return;
 
@@ -1157,14 +1162,15 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 
 /* abort packets may come in 2 directions */
 static void
-j1939_xtp_rx_abort(struct j1939_priv *priv, struct sk_buff *skb)
+j1939_xtp_rx_abort(struct j1939_priv *priv, struct sk_buff *skb,
+		   bool transmitter)
 {
-	j1939_xtp_rx_abort_one(priv, skb, false);
-	j1939_xtp_rx_abort_one(priv, skb, true);
+	j1939_xtp_rx_abort_one(priv, skb, false, transmitter);
+	j1939_xtp_rx_abort_one(priv, skb, true, transmitter);
 }
 
 static void
-j1939_xtp_rx_eoma(struct j1939_session *session, struct sk_buff *skb)
+j1939_xtp_rx_eoma_one(struct j1939_session *session, struct sk_buff *skb)
 {
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
@@ -1176,7 +1182,23 @@ j1939_xtp_rx_eoma(struct j1939_session *session, struct sk_buff *skb)
 }
 
 static void
-j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb)
+j1939_xtp_rx_eoma(struct j1939_priv *priv, struct sk_buff *skb,
+		  bool transmitter)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	struct j1939_session *session;
+
+	session = j1939_session_get_by_addr(priv, &skcb->addr, true,
+					    transmitter);
+	if (!session)
+		return;
+
+	j1939_xtp_rx_eoma_one(session, skb);
+	j1939_session_put(session);
+}
+
+static void
+j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 {
 	enum j1939_xtp_abort err = J1939_XTP_ABORT_FAULT;
 	unsigned int pkt;
@@ -1218,7 +1240,7 @@ j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb)
 	j1939_session_unlock(session);
 	if (dat[1]) {
 		j1939_tp_set_rxtimeout(session, 1250);
-		if (j1939_tp_im_transmitter(&session->skcb)) {
+		if (session->transmission) {
 			if (session->pkt.tx_acked)
 				j1939_sk_errqueue(session, J1939_ERRQUEUE_SCHED);
 			j1939_session_txtimer_cancel(session);
@@ -1237,6 +1259,21 @@ j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb)
 	j1939_session_cancel(session, err);
 }
 
+static void
+j1939_xtp_rx_cts(struct j1939_priv *priv, struct sk_buff *skb, bool transmitter)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	struct j1939_session *session;
+
+	session = j1939_session_get_by_addr(priv, &skcb->addr, true,
+					    transmitter);
+	if (!session)
+		return;
+	j1939_xtp_rx_cts_one(session, skb);
+	j1939_session_put(session);
+}
+
+
 static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 					       struct sk_buff *skb, size_t size)
 {
@@ -1314,7 +1351,8 @@ int j1939_session_activate(struct j1939_session *session)
 
 	j1939_session_list_lock(priv);
 	active = j1939_session_get_by_addr_locked(priv, &priv->active_session_list,
-						   &session->skcb.addr, false);
+						   &session->skcb.addr, false,
+						   session->transmission);
 	if (active) {
 		j1939_session_put(active);
 		ret = -EAGAIN;
@@ -1341,13 +1379,6 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	pgn_t pgn;
 	int len;
 
-	if (j1939_tp_im_transmitter(&skcb)) {
-		netdev_alert(priv->ndev, "%s: I should tx (%02x %02x)\n",
-			     __func__, skcb.addr.sa, skcb.addr.da);
-
-		return NULL;
-	}
-
 	dat = skb->data;
 	pgn = j1939_xtp_ctl_to_pgn(dat);
 	skcb.addr.pgn = pgn;
@@ -1409,7 +1440,7 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 	struct j1939_priv *priv = session->priv;
 
-	if (j1939_tp_im_receiver(skcb)) {
+	if (!session->transmission) {
 		if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 			return -EBUSY;
 
@@ -1448,7 +1479,41 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 	return 0;
 }
 
-static void j1939_xtp_rx_dpo(struct j1939_session *session, struct sk_buff *skb)
+static void j1939_xtp_rx_rts(struct j1939_priv *priv, struct sk_buff *skb,
+			    bool transmitter)
+{
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	struct j1939_session *session;
+	u8 cmd = skb->data[0];
+
+	session = j1939_session_get_by_addr(priv, &skcb->addr, false,
+					    transmitter);
+	/* TODO: abort RTS when a similar
+	 * TP is pending in the other direction
+	 */
+	if (session) {
+		if (j1939_xtp_rx_rts_session_active(session, skb)) {
+			j1939_session_put(session);
+			return;
+		}
+	} else {
+		session = j1939_xtp_rx_rts_session_new(priv, skb);
+		if (!session)
+			return;
+	}
+	session->last_cmd = cmd;
+
+	j1939_tp_set_rxtimeout(session, 1250);
+
+	if (cmd != J1939_TP_CMD_BAM && !session->transmission) {
+		j1939_session_txtimer_cancel(session);
+		j1939_tp_schedule_txtimer(session, 0);
+	}
+
+	j1939_session_put(session);
+}
+
+static void j1939_xtp_rx_dpo_one(struct j1939_session *session, struct sk_buff *skb)
 {
 	const u8 *dat = skb->data;
 
@@ -1461,10 +1526,28 @@ static void j1939_xtp_rx_dpo(struct j1939_session *session, struct sk_buff *skb)
 	j1939_tp_set_rxtimeout(session, 750);
 }
 
-static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb)
+static void j1939_xtp_rx_dpo(struct j1939_priv *priv, struct sk_buff *skb,
+			     bool transmitter)
 {
-	struct j1939_sk_buff_cb *skcb;
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 	struct j1939_session *session;
+
+	session = j1939_session_get_by_addr(priv, &skcb->addr, false,
+					    transmitter);
+	if (!session) {
+		netdev_info(priv->ndev,
+			    "%s: no connection found\n", __func__);
+		return;
+	}
+	j1939_xtp_rx_dpo_one(session, skb);
+	j1939_session_put(session);
+}
+
+
+static void j1939_xtp_rx_dat_one(struct j1939_session *session, struct sk_buff *skb)
+{
+	struct j1939_priv *priv = session->priv;
+	struct j1939_sk_buff_cb *skcb;
 	struct sk_buff *se_skb;
 	const u8 *dat;
 	u8 *tpdat;
@@ -1475,11 +1558,6 @@ static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb)
 	int packet;
 
 	skcb = j1939_skb_to_cb(skb);
-	session = j1939_session_get_by_addr(priv, &skcb->addr, false);
-	if (!session) {
-		netdev_info(priv->ndev, "%s: no connection found\n", __func__);
-		return;
-	}
 	dat = skb->data;
 	if (skb->len <= 1)
 		/* makes no sense */
@@ -1542,7 +1620,7 @@ static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb)
 		j1939_session_completed(session);
 	} else if (do_cts_eoma) {
 		j1939_tp_set_rxtimeout(session, 1250);
-		if (j1939_tp_im_receiver(&session->skcb))
+		if (!session->transmission)
 			j1939_tp_schedule_txtimer(session, 0);
 	} else {
 		j1939_tp_set_rxtimeout(session, 250);
@@ -1562,6 +1640,32 @@ static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb)
 	j1939_session_put(session);
 }
 
+static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb)
+{
+	struct j1939_sk_buff_cb *skcb;
+	struct j1939_session *session;
+
+	skcb = j1939_skb_to_cb(skb);
+
+	if (j1939_tp_im_transmitter(skcb)) {
+		session = j1939_session_get_by_addr(priv, &skcb->addr, false,
+						    true);
+		if (!session)
+			netdev_info(priv->ndev, "%s: no tx connection found\n", __func__);
+		else
+			j1939_xtp_rx_dat_one(session, skb);
+	}
+
+	if (j1939_tp_im_receiver(skcb)) {
+		session = j1939_session_get_by_addr(priv, &skcb->addr, false,
+						    false);
+		if (!session)
+			netdev_info(priv->ndev, "%s: no rx connection found\n", __func__);
+		else
+			j1939_xtp_rx_dat_one(session, skb);
+	}
+}
+
 /* j1939 main intf */
 struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 				    struct sk_buff *skb, size_t size)
@@ -1628,7 +1732,6 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 {
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
-	struct j1939_session *session;
 	int extd = J1939_TP;
 	u8 cmd = skb->data[0];
 
@@ -1646,31 +1749,12 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 			return;
 		}
 
-		session = j1939_session_get_by_addr(priv, &skcb->addr, false);
-		/* TODO: abort RTS when a similar
-		 * TP is pending in the other direction
-		 */
-		if (session) {
-			if (j1939_xtp_rx_rts_session_active(session, skb)) {
-				j1939_session_put(session);
-				break;
-			}
-		} else {
-			session = j1939_xtp_rx_rts_session_new(priv, skb);
-			if (!session)
-				break;
-		}
-		session->last_cmd = cmd;
+		if (j1939_tp_im_transmitter(skcb))
+			j1939_xtp_rx_rts(priv, skb, true);
 
-		j1939_tp_set_rxtimeout(session, 1250);
-
-		if (cmd != J1939_TP_CMD_BAM &&
-		    j1939_tp_im_receiver(&session->skcb)) {
-			j1939_session_txtimer_cancel(session);
-			j1939_tp_schedule_txtimer(session, 0);
-		}
+		if (j1939_tp_im_receiver(skcb))
+			j1939_xtp_rx_rts(priv, skb, false);
 
-		j1939_session_put(session);
 		break;
 
 	case J1939_ETP_CMD_CTS:
@@ -1679,25 +1763,24 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 		if (skcb->addr.type != extd)
 			return;
 
-		session = j1939_session_get_by_addr(priv, &skcb->addr, true);
-		if (!session)
-			break;
-		j1939_xtp_rx_cts(session, skb);
-		j1939_session_put(session);
+		if (j1939_tp_im_transmitter(skcb))
+			j1939_xtp_rx_cts(priv, skb, false);
+
+		if (j1939_tp_im_receiver(skcb))
+			j1939_xtp_rx_cts(priv, skb, true);
+
 		break;
 
 	case J1939_ETP_CMD_DPO:
 		if (skcb->addr.type != J1939_ETP)
 			return;
 
-		session = j1939_session_get_by_addr(priv, &skcb->addr, false);
-		if (!session) {
-			netdev_info(priv->ndev,
-				    "%s: no connection found\n", __func__);
-			break;
-		}
-		j1939_xtp_rx_dpo(session, skb);
-		j1939_session_put(session);
+		if (j1939_tp_im_transmitter(skcb))
+			j1939_xtp_rx_dpo(priv, skb, true);
+
+		if (j1939_tp_im_receiver(skcb))
+			j1939_xtp_rx_dpo(priv, skb, false);
+
 		break;
 
 	case J1939_ETP_CMD_EOMA:
@@ -1706,15 +1789,21 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 		if (skcb->addr.type != extd)
 			return;
 
-		session = j1939_session_get_by_addr(priv, &skcb->addr, true);
-		if (!session)
-			break;
-		j1939_xtp_rx_eoma(session, skb);
-		j1939_session_put(session);
+		if (j1939_tp_im_transmitter(skcb))
+			j1939_xtp_rx_eoma(priv, skb, false);
+
+		if (j1939_tp_im_receiver(skcb))
+			j1939_xtp_rx_eoma(priv, skb, true);
+
 		break;
 
 	case J1939_ETP_CMD_ABORT: /* && J1939_TP_CMD_ABORT */
-		j1939_xtp_rx_abort(priv, skb);
+		if (j1939_tp_im_transmitter(skcb))
+			j1939_xtp_rx_abort(priv, skb, true);
+
+		if (j1939_tp_im_receiver(skcb))
+			j1939_xtp_rx_abort(priv, skb, false);
+
 		break;
 	default:
 		return;
-- 
2.20.1

