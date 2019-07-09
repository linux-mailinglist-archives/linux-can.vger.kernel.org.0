Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2696331D
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfGII7U (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:20 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47435 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfGII7T (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:19 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085I-HI; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxu-0000Yr-V5; Tue, 09 Jul 2019 10:59:10 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 01/34] j1939: rename to done to rx
Date:   Tue,  9 Jul 2019 10:58:36 +0200
Message-Id: <20190709085909.1413-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
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
 net/can/j1939/j1939-priv.h |  5 ++---
 net/can/j1939/socket.c     |  2 +-
 net/can/j1939/transport.c  | 36 ++++++++++++++++++------------------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 84d2d540347a..eeefa2f0cbc9 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -261,9 +261,8 @@ struct j1939_session {
 		 * this counter can be set back if responder node didn't
 		 * received all packets send by originator. */
 		unsigned int tx;
-		/* done - number of packets received and confirmed by
-		 * responder */
-		unsigned int done;
+		/* rx - number of packets received */
+		unsigned int rx;
 		/* block - amount of packets expected in one block */
 		unsigned int block;
 		/* dpo - ETP.CM_DPO, Data Packet Offset */
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 68d5894f9e33..0c5de3178e12 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -852,7 +852,7 @@ static struct sk_buff *j1939_sk_get_timestamping_opt_stats(struct j1939_session
 		return NULL;
 
 	nla_put_u32(stats, J1939_NLA_BYTES_ACKED,
-		    min(session->pkt.done * 7, session->total_message_size));
+		    min(session->pkt.rx * 7, session->total_message_size));
 
 	return stats;
 }
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index e862f3d6c4b6..fe9ab330f761 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -301,7 +301,7 @@ static void j1939_session_skb_drop_old(struct j1939_session *session)
 	if (skb_queue_len(&session->skb_queue) < 2)
 		return;
 
-	offset_start = session->pkt.done * 7;
+	offset_start = session->pkt.rx * 7;
 
 	spin_lock_irqsave(&session->skb_queue.lock, flags);
 	do_skb = skb_peek(&session->skb_queue);
@@ -680,11 +680,11 @@ static int j1939_tp_txnext(struct j1939_session *session)
 			break;
  tx_cts:
 		ret = 0;
-		len = session->pkt.total - session->pkt.done;
+		len = session->pkt.total - session->pkt.rx;
 		len = min3(len, session->pkt.block, j1939_tp_block ?: 255);
 
 		if (session->skcb.addr.type == J1939_ETP) {
-			pkt = session->pkt.done + 1;
+			pkt = session->pkt.rx + 1;
 			dat[0] = J1939_ETP_CMD_CTS;
 			dat[1] = len;
 			dat[2] = (pkt >> 0);
@@ -693,7 +693,7 @@ static int j1939_tp_txnext(struct j1939_session *session)
 		} else {
 			dat[0] = J1939_TP_CMD_CTS;
 			dat[1] = len;
-			dat[2] = session->pkt.done + 1;
+			dat[2] = session->pkt.rx + 1;
 		}
 		if (dat[0] == session->last_txcmd)
 			/* done already */
@@ -712,9 +712,9 @@ static int j1939_tp_txnext(struct j1939_session *session)
 		    session->last_txcmd != J1939_ETP_CMD_DPO) {
 			/* do dpo */
 			dat[0] = J1939_ETP_CMD_DPO;
-			session->pkt.dpo = session->pkt.done;
+			session->pkt.dpo = session->pkt.rx;
 			pkt = session->pkt.dpo;
-			dat[1] = session->pkt.last - session->pkt.done;
+			dat[1] = session->pkt.last - session->pkt.rx;
 			dat[2] = (pkt >> 0);
 			dat[3] = (pkt >> 8);
 			dat[4] = (pkt >> 16);
@@ -723,7 +723,7 @@ static int j1939_tp_txnext(struct j1939_session *session)
 				goto failed;
 			session->last_txcmd = dat[0];
 			j1939_tp_set_rxtimeout(session, 1250);
-			session->pkt.tx = session->pkt.done;
+			session->pkt.tx = session->pkt.rx;
 		}
 		/* fallthrough */
 	case J1939_TP_CMD_CTS: /* fallthrough */
@@ -732,7 +732,7 @@ static int j1939_tp_txnext(struct j1939_session *session)
 		if ((session->skcb.addr.type == J1939_ETP ||
 		     !j1939_cb_is_broadcast(&session->skcb)) &&
 		    j1939_tp_im_receiver(&session->skcb)) {
-			if (session->pkt.done >= session->pkt.total) {
+			if (session->pkt.rx >= session->pkt.total) {
 				if (session->skcb.addr.type == J1939_ETP) {
 					dat[0] = J1939_ETP_CMD_EOMA;
 					dat[1] = session->total_message_size >> 0;
@@ -755,7 +755,7 @@ static int j1939_tp_txnext(struct j1939_session *session)
 				j1939_tp_set_rxtimeout(session, 1250);
 				/* wait for the EOMA packet to come in */
 				break;
-			} else if (session->pkt.done >= session->pkt.last) {
+			} else if (session->pkt.rx >= session->pkt.last) {
 				session->last_txcmd = 0;
 				goto tx_cts;
 			}
@@ -1091,14 +1091,14 @@ j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb)
 		goto out_session_unlock;
 	} else {
 		/* set packet counters only when not CTS(0) */
-		session->pkt.done = pkt - 1;
+		session->pkt.rx = pkt - 1;
 		j1939_session_skb_drop_old(session);
-		session->pkt.last = session->pkt.done + dat[1];
+		session->pkt.last = session->pkt.rx + dat[1];
 		if (session->pkt.last > session->pkt.total)
 			/* safety measure */
 			session->pkt.last = session->pkt.total;
 		/* TODO: do not set tx here, do it in txtimer */
-		session->pkt.tx = session->pkt.done;
+		session->pkt.tx = session->pkt.rx;
 	}
 
 	session->last_cmd = dat[0];
@@ -1274,7 +1274,7 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 		session->pkt.block = min(dat[3], dat[4]);
 	}
 
-	session->pkt.done = 0;
+	session->pkt.rx = 0;
 	session->pkt.tx = 0;
 
 	WARN_ON_ONCE(j1939_session_activate(session));
@@ -1382,7 +1382,7 @@ static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb)
 
 	packet = (dat[0] - 1 + session->pkt.dpo);
 	if (packet > session->pkt.total ||
-	    (session->pkt.done + 1) > session->pkt.total) {
+	    (session->pkt.rx + 1) > session->pkt.total) {
 		netdev_info(priv->ndev, "%s: should have been completed\n",
 			    __func__);
 		goto out_session_unlock;
@@ -1401,16 +1401,16 @@ static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb)
 
 	tpdat = se_skb->data;
 	memcpy(&tpdat[offset], &dat[1], nbytes);
-	if (packet == session->pkt.done)
-		++session->pkt.done;
+	if (packet == session->pkt.rx)
+		session->pkt.rx++;
 
 	if (skcb->addr.type != J1939_ETP &&
 	    j1939_cb_is_broadcast(&session->skcb)) {
-		if (session->pkt.done >= session->pkt.total)
+		if (session->pkt.rx >= session->pkt.total)
 			final = true;
 	} else {
 		/* never final, an EOMA must follow */
-		if (session->pkt.done >= session->pkt.last)
+		if (session->pkt.rx >= session->pkt.last)
 			do_cts_eoma = true;
 	}
 	j1939_session_unlock(session);
-- 
2.20.1

