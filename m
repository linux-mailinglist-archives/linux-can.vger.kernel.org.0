Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B033CC1B
	for <lists+linux-can@lfdr.de>; Tue, 11 Jun 2019 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388744AbfFKMs2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jun 2019 08:48:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40609 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388600AbfFKMs2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2019 08:48:28 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCM-0006Eq-97; Tue, 11 Jun 2019 14:48:22 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCG-0005S0-Pr; Tue, 11 Jun 2019 14:48:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 12/16] j1939: transport: rework error handling on commands with wrong PGN
Date:   Tue, 11 Jun 2019 14:48:10 +0200
Message-Id: <20190611124814.19908-13-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611124814.19908-1-o.rempel@pengutronix.de>
References: <20190611124814.19908-1-o.rempel@pengutronix.de>
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
 net/can/j1939/transport.c | 130 ++++++++++++++++++++------------------
 1 file changed, 70 insertions(+), 60 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index de47b719aa4d..4826b2ad666f 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -959,6 +959,59 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 	return HRTIMER_NORESTART;
 }
 
+static bool j1939_xtp_rx_cmd_bad_pgn(struct j1939_session *session,
+				     const struct sk_buff *skb)
+{
+	const struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	pgn_t pgn = j1939_xtp_ctl_to_pgn(skb->data);
+	struct j1939_priv *priv = session->priv;
+	enum j1939_xtp_abort abort;
+	u8 cmd = skb->data[0];
+
+	if (session->skcb.addr.pgn == pgn)
+		return false;
+
+	switch (cmd) {
+	case J1939_TP_CMD_BAM:
+		abort = J1939_XTP_NO_ABORT;
+		break;
+
+	case J1939_ETP_CMD_RTS:
+	case J1939_TP_CMD_RTS: /* falltrough */
+		abort = J1939_XTP_ABORT_BUSY;
+		break;
+
+	case J1939_ETP_CMD_CTS:
+	case J1939_TP_CMD_CTS: /* falltrough */
+		abort = J1939_XTP_ABORT_ECTS_UNXPECTED_PGN;
+		break;
+
+	case J1939_ETP_CMD_DPO:
+		abort = J1939_XTP_ABORT_BAD_EDPO_PGN;
+		break;
+
+	case J1939_ETP_CMD_EOMA:
+	case J1939_TP_CMD_EOMA: /* falltrough */
+		abort = J1939_XTP_ABORT_OTHER;
+		break;
+
+	case J1939_ETP_CMD_ABORT: /* && J1939_TP_CMD_ABORT */
+		abort = J1939_XTP_NO_ABORT;
+		break;
+
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+
+	netdev_warn(priv->ndev, "%s: CMD 0x%02x with PGN 0x%05x for running session with different PGN 0x%05x.\n",
+		    __func__, cmd, pgn, session->skcb.addr.pgn);
+	if (abort != J1939_XTP_NO_ABORT)
+		j1939_xtp_tx_abort(priv, skcb, true, abort, pgn);
+
+	return true;
+}
+
 /* receive packet functions */
 static void j1939_xtp_rx_bad_message_one(struct j1939_priv *priv,
 					 struct sk_buff *skb,
@@ -976,11 +1029,9 @@ static void j1939_xtp_rx_bad_message_one(struct j1939_priv *priv,
 		return;
 	}
 
-	/* FIXME: extend session match to search for PGN? In case of BOM TP.
-	 * (session->skcb.addr.pgn == pgn)
-	 */
-	/* do not allow TP control messages on 2 pgn's */
-	j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
+	if (!j1939_xtp_rx_cmd_bad_pgn(session, skb))
+		j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
+
 	j1939_session_put(session);
 }
 
@@ -1001,17 +1052,13 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 	struct j1939_session *session;
 	u8 abort = skb->data[1];
-	pgn_t pgn;
 
-	pgn = j1939_xtp_ctl_to_pgn(skb->data);
 	session = j1939_session_get_by_addr(priv, &skcb->addr, reverse);
 	if (!session)
 		return;
 
-	if (session->skcb.addr.pgn != pgn) {
-		netdev_warn(priv->ndev, "%s: abort with pgn %05x for running session with different pgn %05x. Ignoring abort\n", __func__, pgn, session->skcb.addr.pgn);
-		return;
-	}
+	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
+		goto abort_put;
 
 	j1939_session_timers_cancel(session);
 	session->err = j1939_xtp_abort_to_errno(priv, abort);
@@ -1020,6 +1067,7 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 					  session->err);
 	j1939_session_deactivate_activate_next(session);
 
+abort_put:
 	j1939_session_put(session);
 }
 
@@ -1039,23 +1087,12 @@ j1939_xtp_rx_abort(struct j1939_priv *priv, struct sk_buff *skb)
 static void
 j1939_xtp_rx_eoma(struct j1939_session *session, struct sk_buff *skb)
 {
-	struct j1939_priv *priv = session->priv;
-	pgn_t pgn;
-
-	/* end of tx cycle */
-	pgn = j1939_xtp_ctl_to_pgn(skb->data);
+	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
+		return;
 
 	j1939_session_timers_cancel(session);
-	if (session->skcb.addr.pgn != pgn) {
-		struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
-
-		j1939_xtp_tx_abort(priv, skcb, true, J1939_XTP_ABORT_BUSY,
-				   pgn);
-		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
-	} else {
-		/* transmitted without problems */
-		j1939_session_completed(session);
-	}
+	/* transmitted without problems */
+	j1939_session_completed(session);
 }
 
 static void
@@ -1063,22 +1100,15 @@ j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb)
 {
 	struct j1939_priv *priv = session->priv;
 	enum j1939_xtp_abort err = J1939_XTP_ABORT_FAULT;
-	pgn_t pgn;
 	unsigned int pkt;
 	const u8 *dat;
 
 	dat = skb->data;
-	pgn = j1939_xtp_ctl_to_pgn(skb->data);
+
+	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
+		return;
 
 	j1939_session_lock(session);
-	if (session->skcb.addr.pgn != pgn) {
-		struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
-		/* what to do? */
-		j1939_xtp_tx_abort(priv, skcb, true, J1939_XTP_ABORT_BUSY,
-				   pgn);
-		err = J1939_XTP_ABORT_BUSY;
-		goto out_session_unlock;
-	}
 
 	if (session->last_cmd == dat[0]) {
 		err = J1939_XTP_ABORT_DUP_SEQ;
@@ -1291,23 +1321,14 @@ static int j1939_xtp_rx_rts_current(struct j1939_session *session,
 {
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 	struct j1939_priv *priv = session->priv;
-	const u8 *dat;
-	pgn_t pgn;
-
-	dat = skb->data;
-	pgn = j1939_xtp_ctl_to_pgn(dat);
 
 	if (!j1939_tp_im_transmitter(skcb)) {
+		if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
+			return -EBUSY;
+
 		/* RTS on pending connection */
 		j1939_session_timers_cancel(session);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
-
-		if (pgn != session->skcb.addr.pgn &&
-		    dat[0] != J1939_TP_CMD_BAM)
-			j1939_xtp_tx_abort(priv, skcb, true,
-					   J1939_XTP_ABORT_BUSY, pgn);
-
-		return -EBUSY;
 	}
 
 	if (session->last_cmd != 0) {
@@ -1340,21 +1361,10 @@ static int j1939_xtp_rx_rts_current(struct j1939_session *session,
 
 static void j1939_xtp_rx_dpo(struct j1939_session *session, struct sk_buff *skb)
 {
-	struct j1939_priv *priv = session->priv;
-	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 	const u8 *dat = skb->data;
-	pgn_t pgn;
 
-	pgn = j1939_xtp_ctl_to_pgn(dat);
-
-	if (session->skcb.addr.pgn != pgn) {
-		netdev_info(priv->ndev, "%s: different pgn\n", __func__);
-		j1939_xtp_tx_abort(priv, skcb, true, J1939_XTP_ABORT_BUSY,
-				   pgn);
-		j1939_session_timers_cancel(session);
-		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
+	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
-	}
 
 	/* transmitted without problems */
 	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
-- 
2.20.1

