Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C95B93CC11
	for <lists+linux-can@lfdr.de>; Tue, 11 Jun 2019 14:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbfFKMsY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jun 2019 08:48:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54617 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387802AbfFKMsX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2019 08:48:23 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCH-0006El-Mz; Tue, 11 Jun 2019 14:48:17 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCG-0005QK-KW; Tue, 11 Jun 2019 14:48:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 07/16] j1939: implement early (E)TP rx filter
Date:   Tue, 11 Jun 2019 14:48:05 +0200
Message-Id: <20190611124814.19908-8-o.rempel@pengutronix.de>
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

We have a number of different RX filters which may prevent us from
receiving already accepted transfer. To avoid this kind of situation
we should apply this filter already on RTS. Additionally we should
run this test periodically to notice a situation where we have two
applications running on same SA with different PGNs and one
of this applications closed or crashed before transfer was finished.

Described issues can be tested as following:
Node A: jcat -i /test_100k can0:0x80 :0x90,0x12300
Node B: jcat can0:0x90,0x13400 -r >/tmp/blup1

Node A: jcat -i /test_100k can0:0x80 :0x90,0x12300
Node B: jcat can0:0x90,0x13400 -r >/tmp/blup1 &
Node B: jcat can0:0x90,0x12300 -r >/tmp/blup2 &
Node B: sleep 10 && kill pidof last jcat

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  1 +
 net/can/j1939/socket.c     | 49 ++++++++++++++++++++++++++++----------
 net/can/j1939/transport.c  | 24 ++++++++++---------
 3 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 6f7abd12bc54..65bc91262b23 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -170,6 +170,7 @@ static inline struct j1939_sk_buff_cb *j1939_skb_to_cb(struct sk_buff *skb)
 
 int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb);
 void j1939_sk_recv(struct j1939_priv *priv, struct sk_buff *skb);
+bool j1939_sk_recv_match(struct j1939_priv *priv, struct j1939_sk_buff_cb *skcb);
 void j1939_sk_send_loop_abort(struct j1939_priv *priv, struct sock *sk,
 			       int err);
 void j1939_sk_errqueue(struct j1939_session *session,
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 9930b2d2ee0b..cb5978b4146c 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -250,28 +250,37 @@ static bool j1939_sk_match_filter(struct j1939_sock *jsk,
 	return false;
 }
 
+static bool j1939_sk_recv_match_one(struct j1939_sock *jsk,
+				    const struct j1939_sk_buff_cb *skcb)
+{
+	if (!(jsk->state & (J1939_SOCK_BOUND | J1939_SOCK_CONNECTED)))
+		return false;
+
+	if (skcb->insock == &jsk->sk && !(jsk->state & J1939_SOCK_RECV_OWN))
+		/* own message */
+		return false;
+
+	if (!j1939_sk_match_dst(jsk, skcb))
+		return false;
+
+	if (!j1939_sk_match_filter(jsk, skcb))
+		return false;
+
+	return true;
+}
+
 static void j1939_sk_recv_one(struct j1939_sock *jsk, struct sk_buff *oskb)
 {
-	struct sk_buff *skb;
 	const struct j1939_sk_buff_cb *oskcb = j1939_skb_to_cb(oskb);
 	const struct can_skb_priv *oskb_prv = can_skb_prv(oskb);
 	struct j1939_sk_buff_cb *skcb;
-
-	if (!(jsk->state & (J1939_SOCK_BOUND | J1939_SOCK_CONNECTED)))
-		return;
+	struct sk_buff *skb;
 
 	if (jsk->ifindex != oskb_prv->ifindex)
 		/* this socket does not take packets from this iface */
 		return;
 
-	if (oskcb->insock == &jsk->sk && !(jsk->state & J1939_SOCK_RECV_OWN))
-		/* own message */
-		return;
-
-	if (!j1939_sk_match_dst(jsk, oskcb))
-		return;
-
-	if (!j1939_sk_match_filter(jsk, oskcb))
+	if (!j1939_sk_recv_match_one(jsk, oskcb))
 		return;
 
 	skb = skb_clone(oskb, GFP_ATOMIC);
@@ -290,6 +299,22 @@ static void j1939_sk_recv_one(struct j1939_sock *jsk, struct sk_buff *oskb)
 		kfree_skb(skb);
 }
 
+bool j1939_sk_recv_match(struct j1939_priv *priv, struct j1939_sk_buff_cb *skcb)
+{
+	struct j1939_sock *jsk;
+	bool match = false;
+
+	spin_lock_bh(&priv->j1939_socks_lock);
+	list_for_each_entry(jsk, &priv->j1939_socks, list) {
+		match = j1939_sk_recv_match_one(jsk, skcb);
+		if (match)
+			break;
+	}
+	spin_unlock_bh(&priv->j1939_socks_lock);
+
+	return match;
+}
+
 void j1939_sk_recv(struct j1939_priv *priv, struct sk_buff *skb)
 {
 	struct j1939_sock *jsk;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index d3d23277f03b..abe289fc550b 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1159,8 +1159,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 static struct
 j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 				       int size,
-				       const struct j1939_sk_buff_cb *rel_skcb,
-				       pgn_t pgn)
+				       const struct j1939_sk_buff_cb *rel_skcb)
 {
 	struct sk_buff *skb;
 	struct j1939_sk_buff_cb *skcb;
@@ -1175,7 +1174,6 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
-	skcb->addr.pgn = pgn;
 
 	session = j1939_session_new(priv, skb, skb->len);
 	if (!session) {
@@ -1218,23 +1216,24 @@ j1939_session *j1939_xtp_rx_rts_new(struct j1939_priv *priv,
 				    struct sk_buff *skb)
 {
 	enum j1939_xtp_abort abort = J1939_XTP_NO_ABORT;
-	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	struct j1939_sk_buff_cb skcb = *j1939_skb_to_cb(skb);
 	struct j1939_session *session;
 	const u8 *dat;
 	pgn_t pgn;
 	int len;
 
-	if (j1939_tp_im_transmitter(skcb)) {
+	if (j1939_tp_im_transmitter(&skcb)) {
 		netdev_alert(priv->ndev, "%s: I should tx (%02x %02x)\n",
-			     __func__, skcb->addr.sa, skcb->addr.da);
+			     __func__, skcb.addr.sa, skcb.addr.da);
 
 		return NULL;
 	}
 
 	dat = skb->data;
 	pgn = j1939_xtp_ctl_to_pgn(dat);
+	skcb.addr.pgn = pgn;
 
-	if (skcb->addr.type == J1939_ETP) {
+	if (skcb.addr.type == J1939_ETP) {
 		len = j1939_etp_ctl_to_size(dat);
 		if (len > J1939_MAX_ETP_PACKET_SIZE)
 			abort = J1939_XTP_ABORT_FAULT;
@@ -1251,13 +1250,16 @@ j1939_session *j1939_xtp_rx_rts_new(struct j1939_priv *priv,
 	}
 
 	if (abort != J1939_XTP_NO_ABORT) {
-		j1939_xtp_tx_abort(priv, skcb, true, abort, pgn);
+		j1939_xtp_tx_abort(priv, &skcb, true, abort, pgn);
 		return NULL;
 	}
 
-	session = j1939_session_fresh_new(priv, len, skcb, pgn);
+	if (!j1939_sk_recv_match(priv, &skcb))
+		return NULL;
+
+	session = j1939_session_fresh_new(priv, len, &skcb);
 	if (!session) {
-		j1939_xtp_tx_abort(priv, skcb, true,
+		j1939_xtp_tx_abort(priv, &skcb, true,
 				   J1939_XTP_ABORT_RESOURCE, pgn);
 		return NULL;
 	}
@@ -1265,7 +1267,7 @@ j1939_session *j1939_xtp_rx_rts_new(struct j1939_priv *priv,
 	/* initialize the control buffer: plain copy */
 	session->pkt.total = (len + 6) / 7;
 	session->pkt.block = 0xff;
-	if (skcb->addr.type != J1939_ETP) {
+	if (skcb.addr.type != J1939_ETP) {
 		if (dat[3] != session->pkt.total)
 			netdev_alert(priv->ndev, "%s: strange total, %u != %u\n",
 				     __func__, session->pkt.total,
-- 
2.20.1

