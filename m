Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8242797C
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbfEWJlv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44821 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbfEWJlv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:51 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEI-0001Fu-Po; Thu, 23 May 2019 11:41:42 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-00043U-8b; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 01/17] j1939: store session type in to session and start to use it
Date:   Thu, 23 May 2019 11:41:23 +0200
Message-Id: <20190523094139.15517-2-o.rempel@pengutronix.de>
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

.. and start to use single list for all sessions.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  10 +-
 net/can/j1939/main.c       |   2 +
 net/can/j1939/socket.c     |   7 +-
 net/can/j1939/transport.c  | 186 +++++++++++++++++--------------------
 4 files changed, 99 insertions(+), 106 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index a3df43919505..780ebbd551e5 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -65,7 +65,6 @@ struct j1939_priv {
 	/* protects both tp_session lists below*/
 	spinlock_t tp_session_list_lock;
 	struct list_head tp_sessionq;
-	struct list_head tp_extsessionq;
 	wait_queue_head_t tp_wait;
 	unsigned int tp_max_packet_size;
 
@@ -114,6 +113,11 @@ struct j1939_ecu *j1939_ecu_get_by_name(struct j1939_priv *priv, name_t name);
 struct j1939_ecu *j1939_ecu_get_by_name_locked(struct j1939_priv *priv,
 					       name_t name);
 
+enum j1939_transfer_type {
+	J1939_TP,
+	J1939_ETP,
+};
+
 struct j1939_addr {
 	name_t src_name;
 	name_t dst_name;
@@ -121,6 +125,8 @@ struct j1939_addr {
 
 	u8 sa;
 	u8 da;
+
+	u8 type;
 };
 
 /* control buffer of the sk_buff */
@@ -249,7 +255,7 @@ void j1939_session_skb_queue(struct j1939_session *session,
 			     struct sk_buff *skb);
 struct j1939_session *j1939_session_get_by_skcb(struct j1939_priv *priv,
 						struct j1939_sk_buff_cb *skcb,
-						bool extd, bool reverse);
+						bool reverse);
 
 #define J1939_MAX_TP_PACKET_SIZE (7 * 0xff)
 #define J1939_MAX_ETP_PACKET_SIZE (7 * 0x00ffffff)
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 00b3c81263fb..33530d450856 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -62,6 +62,8 @@ static void j1939_can_recv(struct sk_buff *iskb, void *data)
 	skcb->priority = (cf->can_id >> 26) & 0x7;
 	skcb->addr.sa = cf->can_id;
 	skcb->addr.pgn = (cf->can_id >> 8) & J1939_PGN_MAX;
+	/* set default message type */
+	skcb->addr.type = J1939_TP;
 	if (j1939_pgn_is_pdu1(skcb->addr.pgn)) {
 		/* Type 1: with destination address */
 		skcb->addr.da = skcb->addr.pgn;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index ea272dcb6682..872216a2d044 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -860,14 +860,13 @@ static int j1939_sk_send_multi(struct j1939_priv *priv,  struct sock *sk,
 
 		if (!session) {
 			if (jsk->etp_tx_done_size) {
-				bool extd = J1939_REGULAR;
-
 				if (jsk->etp_tx_complete_size >
 				    J1939_MAX_TP_PACKET_SIZE)
-					extd = J1939_EXTENDED;
+					skcb->addr.type = J1939_ETP;
+				else
+					skcb->addr.type = J1939_TP;
 
 				session = j1939_session_get_by_skcb(priv, skcb,
-								    extd,
 								    false);
 				if (IS_ERR(session)) {
 					ret = PTR_ERR(session);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 64f2796756f4..4320804062eb 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -211,15 +211,6 @@ static inline void j1939_fix_cb(struct j1939_sk_buff_cb *skcb)
 	skcb->msg_flags &= ~MSG_SYN;
 }
 
-static inline struct list_head *j1939_sessionq(struct j1939_priv *priv,
-					       bool extd)
-{
-	if (extd)
-		return &priv->tp_extsessionq;
-	else
-		return &priv->tp_sessionq;
-}
-
 static inline void j1939_session_list_lock(struct j1939_priv *priv)
 {
 	spin_lock_bh(&priv->tp_session_list_lock);
@@ -232,9 +223,9 @@ static inline void j1939_session_list_unlock(struct j1939_priv *priv)
 
 static void j1939_session_list_add(struct j1939_session *session)
 {
-	struct list_head *list = j1939_sessionq(session->priv, session->extd);
+	struct j1939_priv *priv = session->priv;
 
-	list_add_tail(&session->list, list);
+	list_add_tail(&session->list, &priv->tp_sessionq);
 }
 
 static void j1939_session_list_del(struct j1939_session *session)
@@ -461,6 +452,9 @@ static bool j1939_session_match(struct j1939_session *session,
 	struct j1939_addr *se_addr = &se_skcb->addr;
 	struct j1939_addr *sk_addr = &skcb->addr;
 
+	if (se_addr->type != sk_addr->type)
+		return false;
+
 	if (reverse) {
 		if (se_addr->src_name) {
 			if (se_addr->src_name != sk_addr->dst_name)
@@ -516,13 +510,13 @@ j1939_session *j1939_session_get_by_skcb_locked(struct j1939_priv *priv,
 
 struct j1939_session *j1939_session_get_by_skcb(struct j1939_priv *priv,
 						struct j1939_sk_buff_cb *skcb,
-						bool extd, bool reverse)
+						bool reverse)
 {
-	struct list_head *root = j1939_sessionq(priv, extd);
 	struct j1939_session *session;
 
 	j1939_session_list_lock(priv);
-	session = j1939_session_get_by_skcb_locked(priv, root, skcb, reverse);
+	session = j1939_session_get_by_skcb_locked(priv, &priv->tp_sessionq,
+						   skcb, reverse);
 	j1939_session_list_unlock(priv);
 
 	return session;
@@ -537,7 +531,7 @@ static void j1939_skbcb_swap(struct j1939_sk_buff_cb *skcb)
 
 static struct sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 					   struct j1939_sk_buff_cb *re_skcb,
-					   bool extd, bool ctl,
+					   bool ctl,
 					   bool swap_src_dst)
 {
 	struct sk_buff *skb;
@@ -561,12 +555,12 @@ static struct sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 		j1939_skbcb_swap(skcb);
 
 	if (ctl) {
-		if (extd)
+		if (skcb->addr.type == J1939_ETP)
 			skcb->addr.pgn = J1939_ETP_PGN_CTL;
 		else
 			skcb->addr.pgn = J1939_TP_PGN_CTL;
 	} else {
-		if (extd)
+		if (skcb->addr.type == J1939_ETP)
 			skcb->addr.pgn = J1939_ETP_PGN_DAT;
 		else
 			skcb->addr.pgn = J1939_TP_PGN_DAT;
@@ -582,7 +576,7 @@ static int j1939_tp_tx_dat(struct j1939_session *session,
 	struct j1939_priv *priv = session->priv;
 	struct sk_buff *skb;
 
-	skb = j1939_tp_tx_dat_new(priv, &session->skcb, session->extd,
+	skb = j1939_tp_tx_dat_new(priv, &session->skcb,
 				  false, false);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -595,7 +589,7 @@ static int j1939_tp_tx_dat(struct j1939_session *session,
 }
 
 static int j1939_xtp_do_tx_ctl(struct j1939_priv *priv,
-			       struct j1939_sk_buff_cb *re_skcb, bool extd,
+			       struct j1939_sk_buff_cb *re_skcb,
 			       bool swap_src_dst, pgn_t pgn, const u8 *dat)
 {
 	struct sk_buff *skb;
@@ -604,7 +598,7 @@ static int j1939_xtp_do_tx_ctl(struct j1939_priv *priv,
 	if (!j1939_tp_im_involved(re_skcb, swap_src_dst))
 		return 0;
 
-	skb = j1939_tp_tx_dat_new(priv, re_skcb, extd, true, swap_src_dst);
+	skb = j1939_tp_tx_dat_new(priv, re_skcb, true, swap_src_dst);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -622,14 +616,14 @@ static inline int j1939_tp_tx_ctl(struct j1939_session *session,
 {
 	struct j1939_priv *priv = session->priv;
 
-	return j1939_xtp_do_tx_ctl(priv, &session->skcb, session->extd,
+	return j1939_xtp_do_tx_ctl(priv, &session->skcb,
 				   swap_src_dst,
 				   session->skcb.addr.pgn, dat);
 }
 
 static int j1939_xtp_tx_abort(struct j1939_priv *priv,
 			      struct j1939_sk_buff_cb *re_skcb,
-			      bool extd, bool swap_src_dst,
+			      bool swap_src_dst,
 			      enum j1939_xtp_abort err,
 			      pgn_t pgn)
 {
@@ -641,7 +635,7 @@ static int j1939_xtp_tx_abort(struct j1939_priv *priv,
 	memset(dat, 0xff, sizeof(dat));
 	dat[0] = J1939_TP_CMD_ABORT;
 	dat[1] = err;
-	return j1939_xtp_do_tx_ctl(priv, re_skcb, extd, swap_src_dst, pgn, dat);
+	return j1939_xtp_do_tx_ctl(priv, re_skcb, swap_src_dst, pgn, dat);
 }
 
 static inline void j1939_tp_schedule_txtimer(struct j1939_session *session,
@@ -680,7 +674,7 @@ static int j1939_tp_txnext(struct j1939_session *session)
 		dat[1] = (session->total_message_size >> 0);
 		dat[2] = (session->total_message_size >> 8);
 		dat[3] = session->pkt.total;
-		if (session->extd) {
+		if (session->skcb.addr.type == J1939_ETP) {
 			dat[0] = J1939_ETP_CMD_RTS;
 			dat[1] = (session->total_message_size >> 0);
 			dat[2] = (session->total_message_size >> 8);
@@ -715,7 +709,7 @@ static int j1939_tp_txnext(struct j1939_session *session)
 		len = session->pkt.total - session->pkt.done;
 		len = min3(len, session->pkt.block, j1939_tp_block ?: 255);
 
-		if (session->extd) {
+		if (session->skcb.addr.type == J1939_ETP) {
 			pkt = session->pkt.done + 1;
 			dat[0] = J1939_ETP_CMD_CTS;
 			dat[1] = len;
@@ -740,7 +734,7 @@ static int j1939_tp_txnext(struct j1939_session *session)
 		break;
 	case J1939_ETP_CMD_CTS:
 		if (j1939_tp_im_transmitter(&session->skcb) &&
-		    session->extd &&
+		    session->skcb.addr.type == J1939_ETP &&
 		    session->last_txcmd != J1939_ETP_CMD_DPO) {
 			/* do dpo */
 			dat[0] = J1939_ETP_CMD_DPO;
@@ -761,11 +755,11 @@ static int j1939_tp_txnext(struct j1939_session *session)
 	case J1939_TP_CMD_CTS: /* fallthrough */
 	case 0xff: /* did some data */
 	case J1939_ETP_CMD_DPO: /* fallthrough */
-		if ((session->extd ||
+		if ((session->skcb.addr.type == J1939_ETP ||
 		     !j1939_cb_is_broadcast(&session->skcb)) &&
 		    j1939_tp_im_receiver(&session->skcb)) {
 			if (session->pkt.done >= session->pkt.total) {
-				if (session->extd) {
+				if (session->skcb.addr.type == J1939_ETP) {
 					dat[0] = J1939_ETP_CMD_EOMA;
 					dat[1] = session->total_message_size >> 0;
 					dat[2] = session->total_message_size >> 8;
@@ -804,7 +798,8 @@ static int j1939_tp_txnext(struct j1939_session *session)
 		tpdat = se_skb->data;
 		ret = 0;
 		pkt_done = 0;
-		if (!session->extd && j1939_cb_is_broadcast(&session->skcb))
+		if (session->skcb.addr.type != J1939_ETP &&
+		    j1939_cb_is_broadcast(&session->skcb))
 			pkt_end = session->pkt.total;
 		else
 			pkt_end = session->pkt.last;
@@ -883,7 +878,7 @@ static void j1939_session_cancel(struct j1939_session *session,
 	session->err = j1939_xtp_abort_to_errno(priv, err);
 	/* do not send aborts on incoming broadcasts */
 	if (!j1939_cb_is_broadcast(&session->skcb))
-		j1939_xtp_tx_abort(priv, &session->skcb, session->extd,
+		j1939_xtp_tx_abort(priv, &session->skcb,
 				   !(session->skcb.src_flags & J1939_ECU_LOCAL),
 				   err, session->skcb.addr.pgn);
 
@@ -908,7 +903,7 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 
 /* receive packet functions */
 static void j1939_xtp_rx_bad_message_one(struct j1939_priv *priv,
-					 struct sk_buff *skb, bool extd,
+					 struct sk_buff *skb,
 					 bool reverse)
 {
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
@@ -916,9 +911,9 @@ static void j1939_xtp_rx_bad_message_one(struct j1939_priv *priv,
 	pgn_t pgn;
 
 	pgn = j1939_xtp_ctl_to_pgn(skb->data);
-	session = j1939_session_get_by_skcb(priv, skcb, extd, reverse);
+	session = j1939_session_get_by_skcb(priv, skcb, reverse);
 	if (!session) {
-		j1939_xtp_tx_abort(priv, skcb, extd, false,
+		j1939_xtp_tx_abort(priv, skcb, false,
 				   J1939_XTP_ABORT_FAULT, pgn);
 		return;
 	}
@@ -933,24 +928,24 @@ static void j1939_xtp_rx_bad_message_one(struct j1939_priv *priv,
 
 /* abort packets may come in 2 directions */
 static void j1939_xtp_rx_bad_message(struct j1939_priv *priv,
-				     struct sk_buff *skb, bool extd)
+				     struct sk_buff *skb)
 {
 	netdev_info(priv->ndev, "%s, pgn %05x\n", __func__,
 		    j1939_xtp_ctl_to_pgn(skb->data));
 
-	j1939_xtp_rx_bad_message_one(priv, skb, extd, false);
-	j1939_xtp_rx_bad_message_one(priv, skb, extd, true);
+	j1939_xtp_rx_bad_message_one(priv, skb, false);
+	j1939_xtp_rx_bad_message_one(priv, skb, true);
 }
 
 static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
-				   bool extd, bool reverse)
+				   bool reverse)
 {
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 	struct j1939_session *session;
 	pgn_t pgn;
 
 	pgn = j1939_xtp_ctl_to_pgn(skb->data);
-	session = j1939_session_get_by_skcb(priv, skcb, extd, reverse);
+	session = j1939_session_get_by_skcb(priv, skcb, reverse);
 	if (!session)
 		return;
 
@@ -977,19 +972,19 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 
 /* abort packets may come in 2 directions */
 static void
-j1939_xtp_rx_abort(struct j1939_priv *priv, struct sk_buff *skb, bool extd)
+j1939_xtp_rx_abort(struct j1939_priv *priv, struct sk_buff *skb)
 {
 	u8 abort = skb->data[1];
 
 	netdev_info(priv->ndev, "%s, 0x%05x: (%u) %s\n", __func__,
 		    j1939_xtp_ctl_to_pgn(skb->data), abort,
 		    j1939_xtp_abort_to_str(abort));
-	j1939_xtp_rx_abort_one(priv, skb, extd, false);
-	j1939_xtp_rx_abort_one(priv, skb, extd, true);
+	j1939_xtp_rx_abort_one(priv, skb, false);
+	j1939_xtp_rx_abort_one(priv, skb, true);
 }
 
 static void
-j1939_xtp_rx_eoma(struct j1939_session *session, struct sk_buff *skb, bool extd)
+j1939_xtp_rx_eoma(struct j1939_session *session, struct sk_buff *skb)
 {
 	struct j1939_priv *priv = session->priv;
 	pgn_t pgn;
@@ -1001,7 +996,7 @@ j1939_xtp_rx_eoma(struct j1939_session *session, struct sk_buff *skb, bool extd)
 	if (session->skcb.addr.pgn != pgn) {
 		struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 
-		j1939_xtp_tx_abort(priv, skcb, extd, true, J1939_XTP_ABORT_BUSY,
+		j1939_xtp_tx_abort(priv, skcb, true, J1939_XTP_ABORT_BUSY,
 				   pgn);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
 	} else {
@@ -1011,7 +1006,7 @@ j1939_xtp_rx_eoma(struct j1939_session *session, struct sk_buff *skb, bool extd)
 }
 
 static void
-j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb, bool extd)
+j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb)
 {
 	struct j1939_priv *priv = session->priv;
 	enum j1939_xtp_abort err = J1939_XTP_ABORT_FAULT;
@@ -1026,7 +1021,7 @@ j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb, bool extd)
 	if (session->skcb.addr.pgn != pgn) {
 		struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 		/* what to do? */
-		j1939_xtp_tx_abort(priv, skcb, extd, true, J1939_XTP_ABORT_BUSY,
+		j1939_xtp_tx_abort(priv, skcb, true, J1939_XTP_ABORT_BUSY,
 				   pgn);
 		err = J1939_XTP_ABORT_BUSY;
 		goto out_session_unlock;
@@ -1037,7 +1032,7 @@ j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb, bool extd)
 		goto out_session_unlock;
 	}
 
-	if (extd)
+	if (session->skcb.addr.type == J1939_ETP)
 		pkt = j1939_etp_ctl_to_packet(dat);
 	else
 		pkt = dat[2];
@@ -1148,8 +1143,7 @@ static int j1939_session_insert(struct j1939_session *session)
 	struct j1939_session *pending;
 	int ret = 0;
 
-	pending = j1939_session_get_by_skcb(priv, &session->skcb, session->extd,
-					    false);
+	pending = j1939_session_get_by_skcb(priv, &session->skcb, false);
 	if (pending) {
 		j1939_session_put(pending);
 		ret = -EAGAIN;
@@ -1164,7 +1158,7 @@ static int j1939_session_insert(struct j1939_session *session)
 
 static struct
 j1939_session *j1939_xtp_rx_rts_new(struct j1939_priv *priv,
-				    struct sk_buff *skb, bool extd)
+				    struct sk_buff *skb)
 {
 	enum j1939_xtp_abort abort = J1939_XTP_NO_ABORT;
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
@@ -1183,7 +1177,7 @@ j1939_session *j1939_xtp_rx_rts_new(struct j1939_priv *priv,
 	dat = skb->data;
 	pgn = j1939_xtp_ctl_to_pgn(dat);
 
-	if (extd) {
+	if (skcb->addr.type == J1939_ETP) {
 		len = j1939_etp_ctl_to_size(dat);
 		if (len > J1939_MAX_ETP_PACKET_SIZE)
 			abort = J1939_XTP_ABORT_FAULT;
@@ -1200,22 +1194,21 @@ j1939_session *j1939_xtp_rx_rts_new(struct j1939_priv *priv,
 	}
 
 	if (abort != J1939_XTP_NO_ABORT) {
-		j1939_xtp_tx_abort(priv, skcb, extd, true, abort, pgn);
+		j1939_xtp_tx_abort(priv, skcb, true, abort, pgn);
 		return NULL;
 	}
 
 	session = j1939_session_fresh_new(priv, len, skcb, pgn);
 	if (!session) {
-		j1939_xtp_tx_abort(priv, skcb, extd, true,
+		j1939_xtp_tx_abort(priv, skcb, true,
 				   J1939_XTP_ABORT_RESOURCE, pgn);
 		return NULL;
 	}
-	session->extd = extd;
 
 	/* initialize the control buffer: plain copy */
 	session->pkt.total = (len + 6) / 7;
 	session->pkt.block = 0xff;
-	if (!extd) {
+	if (skcb->addr.type != J1939_ETP) {
 		if (dat[3] != session->pkt.total)
 			netdev_alert(priv->ndev, "%s: strange total, %u != %u\n",
 				     __func__, session->pkt.total,
@@ -1233,7 +1226,7 @@ j1939_session *j1939_xtp_rx_rts_new(struct j1939_priv *priv,
 }
 
 static int j1939_xtp_rx_rts_current(struct j1939_session *session,
-				    struct sk_buff *skb, bool extd)
+				    struct sk_buff *skb)
 {
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 	struct j1939_priv *priv = session->priv;
@@ -1250,7 +1243,7 @@ static int j1939_xtp_rx_rts_current(struct j1939_session *session,
 
 		if (pgn != session->skcb.addr.pgn &&
 		    dat[0] != J1939_TP_CMD_BAM)
-			j1939_xtp_tx_abort(priv, skcb, extd, true,
+			j1939_xtp_tx_abort(priv, skcb, true,
 					   J1939_XTP_ABORT_BUSY, pgn);
 
 		return -EBUSY;
@@ -1295,7 +1288,7 @@ static void j1939_xtp_rx_dpo(struct j1939_session *session, struct sk_buff *skb)
 
 	if (session->skcb.addr.pgn != pgn) {
 		netdev_info(priv->ndev, "%s: different pgn\n", __func__);
-		j1939_xtp_tx_abort(priv, skcb, true, true, J1939_XTP_ABORT_BUSY,
+		j1939_xtp_tx_abort(priv, skcb, true, J1939_XTP_ABORT_BUSY,
 				   pgn);
 		j1939_session_timers_cancel(session);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
@@ -1308,8 +1301,7 @@ static void j1939_xtp_rx_dpo(struct j1939_session *session, struct sk_buff *skb)
 	j1939_tp_set_rxtimeout(session, 750);
 }
 
-static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb,
-			     bool extd)
+static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb)
 {
 	struct j1939_sk_buff_cb *skcb;
 	struct j1939_session *session;
@@ -1323,7 +1315,7 @@ static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb,
 	int packet;
 
 	skcb = j1939_skb_to_cb(skb);
-	session = j1939_session_get_by_skcb(priv, skcb, extd, false);
+	session = j1939_session_get_by_skcb(priv, skcb, false);
 	if (!session) {
 		netdev_info(priv->ndev, "%s: no connection found\n", __func__);
 		return;
@@ -1339,11 +1331,11 @@ static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb,
 	case 0xff:
 		break;
 	case J1939_ETP_CMD_DPO:
-		if (extd)
+		if (skcb->addr.type == J1939_ETP)
 			break;
 	case J1939_TP_CMD_BAM:
 	case J1939_TP_CMD_CTS:
-		if (!extd)
+		if (skcb->addr.type != J1939_ETP)
 			break;
 	default:
 		netdev_info(priv->ndev, "%s: last %02x\n", __func__,
@@ -1375,7 +1367,8 @@ static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb,
 	if (packet == session->pkt.done)
 		++session->pkt.done;
 
-	if (!extd && j1939_cb_is_broadcast(&session->skcb)) {
+	if (skcb->addr.type != J1939_ETP &&
+	    j1939_cb_is_broadcast(&session->skcb)) {
 		if (session->pkt.done >= session->pkt.total)
 			final = true;
 	} else {
@@ -1425,7 +1418,6 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 {
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 	struct j1939_session *session;
-	bool extd = J1939_REGULAR;
 	int ret;
 
 	if (skcb->addr.pgn == J1939_TP_PGN_DAT ||
@@ -1439,9 +1431,12 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 		return ERR_PTR(-EMSGSIZE);
 
 	if (size > J1939_MAX_TP_PACKET_SIZE)
-		extd = J1939_EXTENDED;
+		skcb->addr.type = J1939_ETP;
+	else
+		skcb->addr.type = J1939_TP;
 
-	if (extd && j1939_cb_is_broadcast(skcb))
+	if (skcb->addr.type == J1939_ETP &&
+	    j1939_cb_is_broadcast(skcb))
 		return ERR_PTR(-EDESTADDRREQ);
 
 	/* fill in addresses from names */
@@ -1464,10 +1459,9 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 
 	/* skb is recounted in j1939_session_new() */
 	session->sk = skb->sk;
-	session->extd = extd;
 	session->transmission = true;
 	session->pkt.total = (size + 6) / 7;
-	session->pkt.block = session->extd ? 255 :
+	session->pkt.block = skcb->addr.type == J1939_ETP ? 255 :
 		min(j1939_tp_block ?: 255, session->pkt.total);
 
 	if (j1939_cb_is_broadcast(&session->skcb))
@@ -1498,20 +1492,19 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 	return ERR_PTR(ret);
 }
 
-static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb,
-			      bool extd_pgn)
+static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 {
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 	struct j1939_session *session;
-	bool extd = J1939_REGULAR;
+	int extd = J1939_TP;
 	u8 cmd = skb->data[0];
 
 	switch (cmd) {
 	case J1939_ETP_CMD_RTS:
-		extd = J1939_EXTENDED;
+		extd = J1939_ETP;
 	case J1939_TP_CMD_BAM: /* falltrough */
 	case J1939_TP_CMD_RTS: /* falltrough */
-		if (extd != extd_pgn)
+		if (skcb->addr.type != extd)
 			goto rx_bad_message;
 
 		if (cmd == J1939_TP_CMD_RTS && j1939_cb_is_broadcast(skcb)) {
@@ -1520,15 +1513,15 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb,
 			return;
 		}
 
-		session = j1939_session_get_by_skcb(priv, skcb, extd, false);
+		session = j1939_session_get_by_skcb(priv, skcb, false);
 		/* TODO: abort RTS when a similar
 		 * TP is pending in the other direction
 		 */
 		if (session) {
-			if (j1939_xtp_rx_rts_current(session, skb, extd))
+			if (j1939_xtp_rx_rts_current(session, skb))
 				break;
 		} else {
-			session = j1939_xtp_rx_rts_new(priv, skb, extd);
+			session = j1939_xtp_rx_rts_new(priv, skb);
 			if (!session)
 				break;
 		}
@@ -1544,24 +1537,23 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb,
 		break;
 
 	case J1939_ETP_CMD_CTS:
-		extd = J1939_EXTENDED;
+		extd = J1939_ETP;
 	case J1939_TP_CMD_CTS: /* falltrough */
-		if (extd != extd_pgn)
+		if (skcb->addr.type != extd)
 			goto rx_bad_message;
 
-		session = j1939_session_get_by_skcb(priv, skcb, extd, true);
+		session = j1939_session_get_by_skcb(priv, skcb, true);
 		if (!session)
 			break;
-		j1939_xtp_rx_cts(session, skb, extd_pgn);
+		j1939_xtp_rx_cts(session, skb);
 		j1939_session_put(session);
 		break;
 
 	case J1939_ETP_CMD_DPO:
-		if (!extd_pgn)
+		if (skcb->addr.type != J1939_ETP)
 			goto rx_bad_message;
 
-		session = j1939_session_get_by_skcb(priv, skcb,
-						    J1939_EXTENDED, false);
+		session = j1939_session_get_by_skcb(priv, skcb, false);
 		if (!session) {
 			netdev_info(priv->ndev,
 				    "%s: no connection found\n", __func__);
@@ -1572,20 +1564,20 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb,
 		break;
 
 	case J1939_ETP_CMD_EOMA:
-		extd = J1939_EXTENDED;
+		extd = J1939_ETP;
 	case J1939_TP_CMD_EOMA: /* falltrough */
-		if (extd != extd_pgn)
+		if (skcb->addr.type != extd)
 			goto rx_bad_message;
 
-		session = j1939_session_get_by_skcb(priv, skcb, extd, true);
+		session = j1939_session_get_by_skcb(priv, skcb, true);
 		if (!session)
 			break;
-		j1939_xtp_rx_eoma(session, skb, extd_pgn);
+		j1939_xtp_rx_eoma(session, skb);
 		j1939_session_put(session);
 		break;
 
 	case J1939_ETP_CMD_ABORT: /* && J1939_TP_CMD_ABORT */
-		j1939_xtp_rx_abort(priv, skb, extd_pgn);
+		j1939_xtp_rx_abort(priv, skb);
 		break;
 	default:
 		goto rx_bad_message;
@@ -1594,33 +1586,32 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb,
 	return;
 
 rx_bad_message:
-	j1939_xtp_rx_bad_message(priv, skb, extd_pgn);
+	j1939_xtp_rx_bad_message(priv, skb);
 }
 
 int j1939_tp_recv(struct j1939_priv *priv, struct sk_buff *skb)
 {
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
-	bool extd = J1939_REGULAR;
 
 	if (!j1939_tp_im_involved_anydir(skcb))
 		return 0;
 
 	switch (skcb->addr.pgn) {
 	case J1939_ETP_PGN_DAT:
-		extd = J1939_EXTENDED;
+		skcb->addr.type = J1939_ETP;
 	case J1939_TP_PGN_DAT: /* falltrough */
-		j1939_xtp_rx_dat(priv, skb, extd);
+		j1939_xtp_rx_dat(priv, skb);
 		break;
 
 	case J1939_ETP_PGN_CTL:
-		extd = J1939_EXTENDED;
+		skcb->addr.type = J1939_ETP;
 	case J1939_TP_PGN_CTL: /* falltrough */
 		if (skb->len < 8) {
-			j1939_xtp_rx_bad_message(priv, skb, extd);
+			j1939_xtp_rx_bad_message(priv, skb);
 			break;
 		}
 
-		j1939_tp_cmd_recv(priv, skb, extd);
+		j1939_tp_cmd_recv(priv, skb);
 		break;
 	default:
 		return 0; /* no problem */
@@ -1637,10 +1628,6 @@ int j1939_tp_rmdev_notifier(struct j1939_priv *priv)
 				 &priv->tp_sessionq, list) {
 		j1939_session_timers_cancel(session);
 	}
-	list_for_each_entry_safe(session, saved,
-				 &priv->tp_extsessionq, list) {
-		j1939_session_timers_cancel(session);
-	}
 	j1939_session_list_unlock(priv);
 	return NOTIFY_DONE;
 }
@@ -1649,7 +1636,6 @@ void j1939_tp_init(struct j1939_priv *priv)
 {
 	spin_lock_init(&priv->tp_session_list_lock);
 	INIT_LIST_HEAD(&priv->tp_sessionq);
-	INIT_LIST_HEAD(&priv->tp_extsessionq);
 	init_waitqueue_head(&priv->tp_wait);
 	priv->tp_max_packet_size = J1939_MAX_ETP_PACKET_SIZE;
 }
-- 
2.20.1

