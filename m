Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D906331F
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfGII7V (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34067 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfGII7V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:21 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085L-H2; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000aR-2p; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 04/34] j1939: add pkt.tx_acked and use it in some places instead of pkt.rx
Date:   Tue,  9 Jul 2019 10:58:39 +0200
Message-Id: <20190709085909.1413-4-o.rempel@pengutronix.de>
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

pkt.rx has dual use with different meaning on rx and tx path.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  1 +
 net/can/j1939/socket.c     |  2 +-
 net/can/j1939/transport.c  | 14 +++++++-------
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 612ed17864d0..c9f1b0df4478 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -261,6 +261,7 @@ struct j1939_session {
 		 * this counter can be set back if responder node didn't
 		 * received all packets send by originator. */
 		unsigned int tx;
+		unsigned int tx_acked;
 		/* rx - number of packets received */
 		unsigned int rx;
 		/* block - amount of packets expected in one block */
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 0c5de3178e12..19e662574b5f 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -852,7 +852,7 @@ static struct sk_buff *j1939_sk_get_timestamping_opt_stats(struct j1939_session
 		return NULL;
 
 	nla_put_u32(stats, J1939_NLA_BYTES_ACKED,
-		    min(session->pkt.rx * 7, session->total_message_size));
+		    min(session->pkt.tx_acked * 7, session->total_message_size));
 
 	return stats;
 }
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index e0c8fb469d96..858c4587af8f 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -301,7 +301,7 @@ static void j1939_session_skb_drop_old(struct j1939_session *session)
 	if (skb_queue_len(&session->skb_queue) < 2)
 		return;
 
-	offset_start = session->pkt.rx * 7;
+	offset_start = session->pkt.tx_acked * 7;
 
 	spin_lock_irqsave(&session->skb_queue.lock, flags);
 	do_skb = skb_peek(&session->skb_queue);
@@ -712,9 +712,9 @@ static int j1939_tp_txnext(struct j1939_session *session)
 		    session->last_txcmd != J1939_ETP_CMD_DPO) {
 			/* do dpo */
 			dat[0] = J1939_ETP_CMD_DPO;
-			session->pkt.dpo = session->pkt.rx;
+			session->pkt.dpo = session->pkt.tx_acked;
 			pkt = session->pkt.dpo;
-			dat[1] = session->pkt.last - session->pkt.rx;
+			dat[1] = session->pkt.last - session->pkt.tx_acked;
 			dat[2] = (pkt >> 0);
 			dat[3] = (pkt >> 8);
 			dat[4] = (pkt >> 16);
@@ -723,7 +723,7 @@ static int j1939_tp_txnext(struct j1939_session *session)
 				goto failed;
 			session->last_txcmd = dat[0];
 			j1939_tp_set_rxtimeout(session, 1250);
-			session->pkt.tx = session->pkt.rx;
+			session->pkt.tx = session->pkt.tx_acked;
 		}
 		/* fallthrough */
 	case J1939_TP_CMD_CTS: /* fallthrough */
@@ -1090,14 +1090,14 @@ j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb)
 		goto out_session_unlock;
 	} else {
 		/* set packet counters only when not CTS(0) */
-		session->pkt.rx = pkt - 1;
+		session->pkt.tx_acked = pkt - 1;
 		j1939_session_skb_drop_old(session);
-		session->pkt.last = session->pkt.rx + dat[1];
+		session->pkt.last = session->pkt.tx_acked + dat[1];
 		if (session->pkt.last > session->pkt.total)
 			/* safety measure */
 			session->pkt.last = session->pkt.total;
 		/* TODO: do not set tx here, do it in txtimer */
-		session->pkt.tx = session->pkt.rx;
+		session->pkt.tx = session->pkt.tx_acked;
 	}
 
 	session->last_cmd = dat[0];
-- 
2.20.1

