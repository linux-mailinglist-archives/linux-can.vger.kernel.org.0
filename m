Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8E0127988
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfEWJlx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39581 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730298AbfEWJlw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:52 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEI-0001Fx-Pm; Thu, 23 May 2019 11:41:42 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-00043v-B8; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 04/17] j1939: pack simple messages in to a session
Date:   Thu, 23 May 2019 11:41:26 +0200
Message-Id: <20190523094139.15517-5-o.rempel@pengutronix.de>
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

To support socket fifo queue, we should handle all packets equally.
This means, even simple packet under 9 bytes, should be handled as a
session.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  1 +
 net/can/j1939/socket.c     | 22 +---------------------
 net/can/j1939/transport.c  | 18 +++++++++++++++---
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 780ebbd551e5..cad62665854d 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -116,6 +116,7 @@ struct j1939_ecu *j1939_ecu_get_by_name_locked(struct j1939_priv *priv,
 enum j1939_transfer_type {
 	J1939_TP,
 	J1939_ETP,
+	J1939_SIMPLE,
 };
 
 struct j1939_addr {
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 872216a2d044..be2d32452b64 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -929,22 +929,6 @@ static int j1939_sk_send_multi(struct j1939_priv *priv,  struct sock *sk,
 	return ret;
 }
 
-static int j1939_sk_send_one(struct j1939_priv *priv,  struct sock *sk,
-			     struct msghdr *msg, size_t size)
-
-{
-	struct sk_buff *skb;
-	int ret;
-
-	skb = j1939_sk_alloc_skb(priv->ndev, sk, msg, size, &ret);
-	if (ret)
-		return ret;
-
-	ret = j1939_send_one(priv, skb);
-
-	return ret ? ret : size;
-}
-
 static int j1939_sk_sendmsg(struct socket *sock, struct msghdr *msg,
 			    size_t size)
 {
@@ -1002,11 +986,7 @@ static int j1939_sk_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (!priv)
 		return -EINVAL;
 
-	if (size > 8)
-		/* re-route via transport protocol */
-		ret = j1939_sk_send_multi(priv, sk, msg, size);
-	else
-		ret = j1939_sk_send_one(priv, sk, msg, size);
+	ret = j1939_sk_send_multi(priv, sk, msg, size);
 
 	j1939_priv_put(priv);
 
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 0d2b1998d111..8e73d68fdea3 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -849,9 +849,19 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 {
 	struct j1939_session *session =
 		container_of(hrtimer, struct j1939_session, txtimer);
-	int ret;
+	int ret = 0;
+
+	if (session->skcb.addr.type == J1939_SIMPLE) {
+		struct j1939_priv *priv = session->priv;
+		struct sk_buff *se_skb = j1939_session_skb_find(session);
+
+		if (se_skb)
+			ret = j1939_send_one(priv,
+					     skb_clone(se_skb, GFP_ATOMIC));
+	} else {
+		ret = j1939_tp_txnext(session);
+	}
 
-	ret = j1939_tp_txnext(session);
 	if (ret < 0)
 		j1939_tp_schedule_txtimer(session, 10 + prandom_u32_max(16));
 
@@ -1419,7 +1429,9 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 	if (size > priv->tp_max_packet_size)
 		return ERR_PTR(-EMSGSIZE);
 
-	if (size > J1939_MAX_TP_PACKET_SIZE)
+	if (size <= 8)
+		skcb->addr.type = J1939_SIMPLE;
+	else if (size > J1939_MAX_TP_PACKET_SIZE)
 		skcb->addr.type = J1939_ETP;
 	else
 		skcb->addr.type = J1939_TP;
-- 
2.20.1

