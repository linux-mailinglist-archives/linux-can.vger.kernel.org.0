Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B416263329
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfGII7Y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42005 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfGII7Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:24 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxx-00085h-37; Tue, 09 Jul 2019 10:59:13 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000lo-Re; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 26/34] j1939: transport: print session pointer if possible
Date:   Tue,  9 Jul 2019 10:59:01 +0200
Message-Id: <20190709085909.1413-26-o.rempel@pengutronix.de>
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
 net/can/j1939/transport.c | 77 +++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index d9a8795dd0b5..75593ec0852a 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -355,8 +355,8 @@ static struct sk_buff *j1939_session_skb_find(struct j1939_session *session)
 	spin_unlock_irqrestore(&session->skb_queue.lock, flags);
 
 	if (!skb)
-		netdev_warn(priv->ndev, "no skb found for start: %i, queue size: %i\n",
-			    offset_start,
+		netdev_warn(priv->ndev, "%s: 0x%p: no skb found for start: %i, queue size: %i\n",
+			    __func__, session, offset_start,
 			    skb_queue_len(&session->skb_queue));
 
 	return skb;
@@ -737,8 +737,8 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 			/* ENOBUS == CAN interface TX queue is full */
 			if (ret != -ENOBUFS)
 				netdev_alert(priv->ndev,
-					     "%s: queue data error: %i\n",
-					     __func__, ret);
+					     "%s: 0x%p: queue data error: %i\n",
+					     __func__, session, ret);
 			break;
 		}
 
@@ -766,8 +766,8 @@ static int j1939_xtp_txnext_transmiter(struct j1939_session *session)
 	int ret = 0;
 
 	if (!j1939_tp_im_transmitter(&session->skcb)) {
-		netdev_alert(priv->ndev, "%s: called by not transmitter!\n",
-			     __func__);
+		netdev_alert(priv->ndev, "%s: 0x%p: called by not transmitter!\n",
+			     __func__, session);
 		return -EINVAL;
 	}
 
@@ -792,8 +792,8 @@ static int j1939_xtp_txnext_transmiter(struct j1939_session *session)
 
 		break;
 	default:
-		netdev_alert(priv->ndev, "%s: unexpected last_cmd: %x\n",
-			     __func__, session->last_cmd);
+		netdev_alert(priv->ndev, "%s: 0x%p: unexpected last_cmd: %x\n",
+			     __func__, session, session->last_cmd);
 
 	}
 
@@ -889,8 +889,8 @@ static int j1939_xtp_txnext_receiver(struct j1939_session *session)
 	int ret = 0;
 
 	if (!j1939_tp_im_receiver(&session->skcb)) {
-		netdev_alert(priv->ndev, "%s: called by not receiver!\n",
-			     __func__);
+		netdev_alert(priv->ndev, "%s: 0x%p: called by not receiver!\n",
+			     __func__, session);
 		return -EINVAL;
 	}
 
@@ -916,8 +916,8 @@ static int j1939_xtp_txnext_receiver(struct j1939_session *session)
 		}
 		break;
 	default:
-		netdev_alert(priv->ndev, "%s: unexpected last_cmd: %x\n",
-			     __func__, session->last_cmd);
+		netdev_alert(priv->ndev, "%s: 0x%p: unexpected last_cmd: %x\n",
+			     __func__, session, session->last_cmd);
 	}
 
 	return ret;
@@ -1005,15 +1005,15 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 			j1939_tp_schedule_txtimer(session,
 						  10 + prandom_u32_max(16));
 		} else {
-			netdev_alert(priv->ndev, "%s: tx retry count reached\n",
-				     __func__);
+			netdev_alert(priv->ndev, "%s: 0x%p: tx retry count reached\n",
+				     __func__, session);
 			session->err = -ENETUNREACH;
 			j1939_session_rxtimer_cancel(session);
 			j1939_session_deactivate_activate_next(session);
 		}
 	} else if (ret) {
-		netdev_alert(priv->ndev, "%s: tx aborted with unknown reason: %i\n",
-			     __func__, ret);
+		netdev_alert(priv->ndev, "%s: 0x%p: tx aborted with unknown reason: %i\n",
+			     __func__, session, ret);
 		if (session->skcb.addr.type != J1939_SIMPLE) {
 			j1939_tp_set_rxtimeout(session,
 					       J1939_XTP_ABORT_TIMEOUT_MS);
@@ -1046,13 +1046,13 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 	struct j1939_priv *priv = session->priv;
 
 	if (session->state == J1939_SESSION_WAITING_ABORT) {
-		netdev_alert(priv->ndev, "%s: abort rx timeout. Force session deactivation\n",
-			     __func__);
+		netdev_alert(priv->ndev, "%s: 0x%p: abort rx timeout. Force session deactivation\n",
+			     __func__, session);
 
 		j1939_session_deactivate_activate_next(session);
 	} else {
-		netdev_alert(priv->ndev, "%s: rx timeout, send abort\n",
-			     __func__);
+		netdev_alert(priv->ndev, "%s: 0x%p: rx timeout, send abort\n",
+			     __func__, session);
 
 		j1939_session_list_lock(session->priv);
 		if (session->state >= J1939_SESSION_ACTIVE &&
@@ -1116,8 +1116,8 @@ static bool j1939_xtp_rx_cmd_bad_pgn(struct j1939_session *session,
 		break;
 	}
 
-	netdev_warn(priv->ndev, "%s: CMD 0x%02x with PGN 0x%05x for running session with different PGN 0x%05x.\n",
-		    __func__, cmd, pgn, session->skcb.addr.pgn);
+	netdev_warn(priv->ndev, "%s: 0x%p: CMD 0x%02x with PGN 0x%05x for running session with different PGN 0x%05x.\n",
+		    __func__, session, cmd, pgn, session->skcb.addr.pgn);
 	if (abort != J1939_XTP_NO_ABORT)
 		j1939_xtp_tx_abort(priv, skcb, true, abort, pgn);
 
@@ -1138,6 +1138,10 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		goto abort_put;
 
+	netdev_info(priv->ndev, "%s: 0x%p: 0x%05x: (%u) %s\n", __func__,
+		    session, j1939_xtp_ctl_to_pgn(skb->data), abort,
+		    j1939_xtp_abort_to_str(abort));
+
 	j1939_session_timers_cancel(session);
 	session->err = j1939_xtp_abort_to_errno(priv, abort);
 	if (session->sk)
@@ -1153,11 +1157,6 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 static void
 j1939_xtp_rx_abort(struct j1939_priv *priv, struct sk_buff *skb)
 {
-	u8 abort = skb->data[1];
-
-	netdev_info(priv->ndev, "%s, 0x%05x: (%u) %s\n", __func__,
-		    j1939_xtp_ctl_to_pgn(skb->data), abort,
-		    j1939_xtp_abort_to_str(abort));
 	j1939_xtp_rx_abort_one(priv, skb, false);
 	j1939_xtp_rx_abort_one(priv, skb, true);
 }
@@ -1384,8 +1383,8 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	session->pkt.block = 0xff;
 	if (skcb.addr.type != J1939_ETP) {
 		if (dat[3] != session->pkt.total)
-			netdev_alert(priv->ndev, "%s: strange total, %u != %u\n",
-				     __func__, session->pkt.total,
+			netdev_alert(priv->ndev, "%s: 0x%p: strange total, %u != %u\n",
+				     __func__, session, session->pkt.total,
 				     dat[3]);
 		session->pkt.total = dat[3];
 		session->pkt.block = min(dat[3], dat[4]);
@@ -1417,8 +1416,8 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 
 	if (session->last_cmd != 0) {
 		/* we received a second rts on the same connection */
-		netdev_alert(priv->ndev, "%s: connection exists (%02x %02x). last cmd: %x\n",
-			     __func__, skcb->addr.sa, skcb->addr.da,
+		netdev_alert(priv->ndev, "%s: 0x%p: connection exists (%02x %02x). last cmd: %x\n",
+			     __func__, session, skcb->addr.sa, skcb->addr.da,
 			     session->last_cmd);
 
 		j1939_session_timers_cancel(session);
@@ -1430,8 +1429,8 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 
 	if (session->skcb.addr.sa != skcb->addr.sa ||
 	    session->skcb.addr.da != skcb->addr.da)
-		netdev_warn(priv->ndev, "%s: session->skcb.addr.sa=0x%02x skcb->addr.sa=0x%02x session->skcb.addr.da=0x%02x skcb->addr.da=0x%02x\n",
-			    __func__,
+		netdev_warn(priv->ndev, "%s: 0x%p: session->skcb.addr.sa=0x%02x skcb->addr.sa=0x%02x session->skcb.addr.da=0x%02x skcb->addr.da=0x%02x\n",
+			    __func__, session,
 			    session->skcb.addr.sa, skcb->addr.sa,
 			    session->skcb.addr.da, skcb->addr.da);
 	/* make sure 'sa' & 'da' are correct !
@@ -1494,16 +1493,16 @@ static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb)
 		if (skcb->addr.type != J1939_ETP)
 			break;
 	default:
-		netdev_info(priv->ndev, "%s: last %02x\n", __func__,
-			    session->last_cmd);
+		netdev_info(priv->ndev, "%s: 0x%p: last %02x\n", __func__,
+			    session, session->last_cmd);
 		goto out_session_unlock;
 	}
 
 	packet = (dat[0] - 1 + session->pkt.dpo);
 	if (packet > session->pkt.total ||
 	    (session->pkt.rx + 1) > session->pkt.total) {
-		netdev_info(priv->ndev, "%s: should have been completed\n",
-			    __func__);
+		netdev_info(priv->ndev, "%s: 0x%p: should have been completed\n",
+			    __func__, session);
 		goto out_session_unlock;
 	}
 	se_skb = j1939_session_skb_find(session);
@@ -1513,8 +1512,8 @@ static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb)
 	if (nbytes > 7)
 		nbytes = 7;
 	if (nbytes <= 0 || (nbytes + 1) > skb->len) {
-		netdev_info(priv->ndev, "%s: nbytes %i, len %i\n", __func__,
-			    nbytes, skb->len);
+		netdev_info(priv->ndev, "%s: 0x%p: nbytes %i, len %i\n",
+			    __func__, session, nbytes, skb->len);
 		goto out_session_unlock;
 	}
 
-- 
2.20.1

