Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA273CC1C
	for <lists+linux-can@lfdr.de>; Tue, 11 Jun 2019 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbfFKMs2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jun 2019 08:48:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56103 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388676AbfFKMs2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2019 08:48:28 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCM-0006Eo-8Q; Tue, 11 Jun 2019 14:48:22 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCG-0005RN-Nx; Tue, 11 Jun 2019 14:48:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 10/16] j1939: transport: use addr instead of skbc in j1939_session_match()
Date:   Tue, 11 Jun 2019 14:48:08 +0200
Message-Id: <20190611124814.19908-11-o.rempel@pengutronix.de>
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
 net/can/j1939/j1939-priv.h |  3 ---
 net/can/j1939/transport.c  | 43 ++++++++++++++++++--------------------
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 65bc91262b23..84d2d540347a 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -309,9 +309,6 @@ void j1939_session_get(struct j1939_session *session);
 void j1939_session_put(struct j1939_session *session);
 void j1939_session_skb_queue(struct j1939_session *session,
 			     struct sk_buff *skb);
-struct j1939_session *j1939_session_get_by_skcb(struct j1939_priv *priv,
-						struct j1939_sk_buff_cb *skcb,
-						bool reverse);
 int j1939_session_activate(struct j1939_session *session);
 bool j1939_session_deactivate(struct j1939_session *session);
 void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 1750377ece3f..16a817af8c96 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -423,13 +423,9 @@ static inline unsigned int j1939_etp_ctl_to_size(const u8 *dat)
  * broadcasts (no dst, no da) would never call this
  * with reverse == true
  */
-static bool j1939_session_match(struct j1939_session *session,
-				struct j1939_sk_buff_cb *skcb, bool reverse)
+static bool j1939_session_match(struct j1939_addr *se_addr,
+				struct j1939_addr *sk_addr, bool reverse)
 {
-	struct j1939_sk_buff_cb *se_skcb = &session->skcb;
-	struct j1939_addr *se_addr = &se_skcb->addr;
-	struct j1939_addr *sk_addr = &skcb->addr;
-
 	if (se_addr->type != sk_addr->type)
 		return false;
 
@@ -467,9 +463,9 @@ static bool j1939_session_match(struct j1939_session *session,
 }
 
 static struct
-j1939_session *j1939_session_get_by_skcb_locked(struct j1939_priv *priv,
+j1939_session *j1939_session_get_by_addr_locked(struct j1939_priv *priv,
 						struct list_head *root,
-						struct j1939_sk_buff_cb *skcb,
+						struct j1939_addr *addr,
 						bool reverse)
 {
 	struct j1939_session *session;
@@ -478,7 +474,7 @@ j1939_session *j1939_session_get_by_skcb_locked(struct j1939_priv *priv,
 
 	list_for_each_entry(session, root, active_session_list_entry) {
 		j1939_session_get(session);
-		if (j1939_session_match(session, skcb, reverse))
+		if (j1939_session_match(&session->skcb.addr, addr, reverse))
 			return session;
 		j1939_session_put(session);
 	}
@@ -486,16 +482,17 @@ j1939_session *j1939_session_get_by_skcb_locked(struct j1939_priv *priv,
 	return NULL;
 }
 
-struct j1939_session *j1939_session_get_by_skcb(struct j1939_priv *priv,
-						struct j1939_sk_buff_cb *skcb,
-						bool reverse)
+static struct
+j1939_session *j1939_session_get_by_addr(struct j1939_priv *priv,
+					 struct j1939_addr *addr,
+					 bool reverse)
 {
 	struct j1939_session *session;
 
 	j1939_session_list_lock(priv);
-	session = j1939_session_get_by_skcb_locked(priv,
+	session = j1939_session_get_by_addr_locked(priv,
 						   &priv->active_session_list,
-						   skcb, reverse);
+						   addr, reverse);
 	j1939_session_list_unlock(priv);
 
 	return session;
@@ -972,7 +969,7 @@ static void j1939_xtp_rx_bad_message_one(struct j1939_priv *priv,
 	pgn_t pgn;
 
 	pgn = j1939_xtp_ctl_to_pgn(skb->data);
-	session = j1939_session_get_by_skcb(priv, skcb, reverse);
+	session = j1939_session_get_by_addr(priv, &skcb->addr, reverse);
 	if (!session) {
 		j1939_xtp_tx_abort(priv, skcb, false,
 				   J1939_XTP_ABORT_FAULT, pgn);
@@ -1007,7 +1004,7 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 	pgn_t pgn;
 
 	pgn = j1939_xtp_ctl_to_pgn(skb->data);
-	session = j1939_session_get_by_skcb(priv, skcb, reverse);
+	session = j1939_session_get_by_addr(priv, &skcb->addr, reverse);
 	if (!session)
 		return;
 
@@ -1194,8 +1191,8 @@ int j1939_session_activate(struct j1939_session *session)
 	int ret = 0;
 
 	j1939_session_list_lock(priv);
-	active = j1939_session_get_by_skcb_locked(priv, &priv->active_session_list,
-						   &session->skcb, false);
+	active = j1939_session_get_by_addr_locked(priv, &priv->active_session_list,
+						   &session->skcb.addr, false);
 	if (active) {
 		j1939_session_put(active);
 		ret = -EAGAIN;
@@ -1374,7 +1371,7 @@ static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb)
 	int packet;
 
 	skcb = j1939_skb_to_cb(skb);
-	session = j1939_session_get_by_skcb(priv, skcb, false);
+	session = j1939_session_get_by_addr(priv, &skcb->addr, false);
 	if (!session) {
 		netdev_info(priv->ndev, "%s: no connection found\n", __func__);
 		return;
@@ -1544,7 +1541,7 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 			return;
 		}
 
-		session = j1939_session_get_by_skcb(priv, skcb, false);
+		session = j1939_session_get_by_addr(priv, &skcb->addr, false);
 		/* TODO: abort RTS when a similar
 		 * TP is pending in the other direction
 		 */
@@ -1575,7 +1572,7 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 		if (skcb->addr.type != extd)
 			goto rx_bad_message;
 
-		session = j1939_session_get_by_skcb(priv, skcb, true);
+		session = j1939_session_get_by_addr(priv, &skcb->addr, true);
 		if (!session)
 			break;
 		j1939_xtp_rx_cts(session, skb);
@@ -1586,7 +1583,7 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 		if (skcb->addr.type != J1939_ETP)
 			goto rx_bad_message;
 
-		session = j1939_session_get_by_skcb(priv, skcb, false);
+		session = j1939_session_get_by_addr(priv, &skcb->addr, false);
 		if (!session) {
 			netdev_info(priv->ndev,
 				    "%s: no connection found\n", __func__);
@@ -1602,7 +1599,7 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 		if (skcb->addr.type != extd)
 			goto rx_bad_message;
 
-		session = j1939_session_get_by_skcb(priv, skcb, true);
+		session = j1939_session_get_by_addr(priv, &skcb->addr, true);
 		if (!session)
 			break;
 		j1939_xtp_rx_eoma(session, skb);
-- 
2.20.1

