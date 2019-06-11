Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4AC3CC0E
	for <lists+linux-can@lfdr.de>; Tue, 11 Jun 2019 14:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbfFKMsW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jun 2019 08:48:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37551 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387931AbfFKMsV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2019 08:48:21 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCH-0006Eu-N0; Tue, 11 Jun 2019 14:48:17 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCG-0005TA-TK; Tue, 11 Jun 2019 14:48:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 16/16] j1939: transport: ignore unknown commands.
Date:   Tue, 11 Jun 2019 14:48:14 +0200
Message-Id: <20190611124814.19908-17-o.rempel@pengutronix.de>
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

Since we have no idea what format it is, we also have no idea about
information which can be extracted from this package.
It is better to ignore them and not produce erroneous aborts.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 47 +++++----------------------------------
 1 file changed, 5 insertions(+), 42 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 5fe919cead29..e862f3d6c4b6 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1012,40 +1012,6 @@ static bool j1939_xtp_rx_cmd_bad_pgn(struct j1939_session *session,
 	return true;
 }
 
-/* receive packet functions */
-static void j1939_xtp_rx_bad_message_one(struct j1939_priv *priv,
-					 struct sk_buff *skb,
-					 bool reverse)
-{
-	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
-	struct j1939_session *session;
-	pgn_t pgn;
-
-	pgn = j1939_xtp_ctl_to_pgn(skb->data);
-	session = j1939_session_get_by_addr(priv, &skcb->addr, reverse);
-	if (!session) {
-		j1939_xtp_tx_abort(priv, skcb, false,
-				   J1939_XTP_ABORT_FAULT, pgn);
-		return;
-	}
-
-	if (!j1939_xtp_rx_cmd_bad_pgn(session, skb))
-		j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
-
-	j1939_session_put(session);
-}
-
-/* abort packets may come in 2 directions */
-static void j1939_xtp_rx_bad_message(struct j1939_priv *priv,
-				     struct sk_buff *skb)
-{
-	netdev_info(priv->ndev, "%s, pgn %05x\n", __func__,
-		    j1939_xtp_ctl_to_pgn(skb->data));
-
-	j1939_xtp_rx_bad_message_one(priv, skb, false);
-	j1939_xtp_rx_bad_message_one(priv, skb, true);
-}
-
 static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 				   bool reverse)
 {
@@ -1548,7 +1514,7 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 	case J1939_TP_CMD_BAM: /* falltrough */
 	case J1939_TP_CMD_RTS: /* falltrough */
 		if (skcb->addr.type != extd)
-			goto rx_bad_message;
+			return;
 
 		if (cmd == J1939_TP_CMD_RTS && j1939_cb_is_broadcast(skcb)) {
 			netdev_alert(priv->ndev, "%s: rts without destination (%02x)\n",
@@ -1585,7 +1551,7 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 		extd = J1939_ETP;
 	case J1939_TP_CMD_CTS: /* falltrough */
 		if (skcb->addr.type != extd)
-			goto rx_bad_message;
+			return;
 
 		session = j1939_session_get_by_addr(priv, &skcb->addr, true);
 		if (!session)
@@ -1596,7 +1562,7 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 
 	case J1939_ETP_CMD_DPO:
 		if (skcb->addr.type != J1939_ETP)
-			goto rx_bad_message;
+			return;
 
 		session = j1939_session_get_by_addr(priv, &skcb->addr, false);
 		if (!session) {
@@ -1612,7 +1578,7 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 		extd = J1939_ETP;
 	case J1939_TP_CMD_EOMA: /* falltrough */
 		if (skcb->addr.type != extd)
-			goto rx_bad_message;
+			return;
 
 		session = j1939_session_get_by_addr(priv, &skcb->addr, true);
 		if (!session)
@@ -1625,13 +1591,10 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 		j1939_xtp_rx_abort(priv, skb);
 		break;
 	default:
-		goto rx_bad_message;
+		return;
 	}
 
 	return;
-
-rx_bad_message:
-	j1939_xtp_rx_bad_message(priv, skb);
 }
 
 int j1939_tp_recv(struct j1939_priv *priv, struct sk_buff *skb)
-- 
2.20.1

