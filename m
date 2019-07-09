Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8560E63326
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfGII7Y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35531 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfGII7Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:24 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxx-00085l-EK; Tue, 09 Jul 2019 10:59:13 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000mq-Vf; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 30/34] j1939: transport: add more debugging information
Date:   Tue,  9 Jul 2019 10:59:05 +0200
Message-Id: <20190709085909.1413-30-o.rempel@pengutronix.de>
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
 net/can/j1939/transport.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 91aa97edab94..cb4e8be7de0a 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -671,6 +671,7 @@ static int j1939_session_tx_rts(struct j1939_session *session)
 		j1939_tp_schedule_txtimer(session, 50);
 
 	j1939_tp_set_rxtimeout(session, 1250);
+	netdev_dbg(session->priv->ndev, "j1939_session_tx_rts: 0x%p\n", session);
 
 	return 0;
 }
@@ -698,6 +699,7 @@ static int j1939_session_tx_dpo(struct j1939_session *session)
 	session->last_txcmd = dat[0];
 	j1939_tp_set_rxtimeout(session, 1250);
 	session->pkt.tx = session->pkt.tx_acked;
+	netdev_dbg(session->priv->ndev, "j1939_session_tx_dpo: 0x%p\n", session);
 
 	return 0;
 }
@@ -843,6 +845,8 @@ static int j1939_session_tx_cts(struct j1939_session *session)
 		session->last_txcmd = dat[0];
 	j1939_tp_set_rxtimeout(session, 1250);
 
+	netdev_dbg(session->priv->ndev, "j1939_session_tx_cts: 0x%p\n", session);
+
 	return 0;
 }
 
@@ -883,6 +887,8 @@ static int j1939_session_tx_eoma(struct j1939_session *session)
 	/* wait for the EOMA packet to come in */
 	j1939_tp_set_rxtimeout(session, 1250);
 
+	netdev_dbg(session->priv->ndev, "j1939_session_tx_eoma: 0x%p\n", session);
+
 	return 0;
 }
 
@@ -1175,6 +1181,8 @@ j1939_xtp_rx_eoma_one(struct j1939_session *session, struct sk_buff *skb)
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
 
+	netdev_dbg(session->priv->ndev, "j1939_xtp_rx_eoma_one: 0x%p\n",
+		   session);
 	session->pkt.tx_acked = session->pkt.total;
 	j1939_session_timers_cancel(session);
 	/* transmitted without problems */
@@ -1209,6 +1217,7 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
 
+	netdev_dbg(session->priv->ndev, "j1939_xtp_rx_cts_one: 0x%p\n", session);
 	j1939_session_lock(session);
 
 	if (session->last_cmd == dat[0]) {
@@ -1362,6 +1371,8 @@ int j1939_session_activate(struct j1939_session *session)
 			      &priv->active_session_list);
 		j1939_session_get(session);
 		session->state = J1939_SESSION_ACTIVE;
+		netdev_dbg(session->priv->ndev, "j1939_session_activate: 0x%p\n",
+			   session);
 	}
 	j1939_session_list_unlock(priv);
 
@@ -1379,6 +1390,8 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	pgn_t pgn;
 	int len;
 
+	netdev_dbg(priv->ndev, "j1939_xtp_rx_rts_session_new\n");
+
 	dat = skb->data;
 	pgn = j1939_xtp_ctl_to_pgn(dat);
 	skcb.addr.pgn = pgn;
@@ -1475,6 +1488,7 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 	 */
 	session->skcb.addr.sa = skcb->addr.sa;
 	session->skcb.addr.da = skcb->addr.da;
+	netdev_dbg(session->priv->ndev, "j1939_xtp_rx_rts_session_active: 0x%p\n", session);
 
 	return 0;
 }
@@ -1520,6 +1534,7 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session, struct sk_buff *
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
 
+	netdev_dbg(session->priv->ndev, "j1939_xtp_rx_dpo_one: 0x%p\n", session);
 	/* transmitted without problems */
 	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
 	session->last_cmd = dat[0];
-- 
2.20.1

