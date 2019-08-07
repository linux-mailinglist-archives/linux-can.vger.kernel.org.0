Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23AAB848FD
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2019 11:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfHGJzt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Aug 2019 05:55:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53853 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbfHGJzt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Aug 2019 05:55:49 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hvIfY-0005F8-HP; Wed, 07 Aug 2019 11:55:44 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hvIfX-0001ih-7Q; Wed, 07 Aug 2019 11:55:43 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 4/5] j1939: remove session lock
Date:   Wed,  7 Aug 2019 11:55:40 +0200
Message-Id: <20190807095541.2544-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807095541.2544-1-o.rempel@pengutronix.de>
References: <20190807095541.2544-1-o.rempel@pengutronix.de>
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

This lock was used only on rx path for CTS and DATA packages. In current
implementation we should not be able to process messages in parallel for
same interfaces. In case we do, will need more locking then DATA and CTS

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  2 --
 net/can/j1939/transport.c  | 38 ++++++++------------------------------
 2 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 5881e4c86b44..d04f8c2d3658 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -228,8 +228,6 @@ struct j1939_session {
 	struct list_head active_session_list_entry;
 	struct list_head sk_session_queue_entry;
 	struct kref kref;
-	/* session lock */
-	spinlock_t lock;
 	struct sock *sk;
 
 	/* ifindex, src, dst, pgn define the session block
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index c2573d0f0721..a9671e2a5fcf 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -308,17 +308,6 @@ static inline bool j1939_cb_is_broadcast(const struct j1939_sk_buff_cb *skcb)
 	return (!skcb->addr.dst_name && (skcb->addr.da == 0xff));
 }
 
-/* transport status locking */
-static inline void j1939_session_lock(struct j1939_session *session)
-{
-	spin_lock_bh(&session->lock);
-}
-
-static inline void j1939_session_unlock(struct j1939_session *session)
-{
-	spin_unlock_bh(&session->lock);
-}
-
 static void j1939_session_skb_drop_old(struct j1939_session *session)
 {
 	struct sk_buff *do_skb;
@@ -1304,11 +1293,9 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
-	j1939_session_lock(session);
-
 	if (session->last_cmd == dat[0]) {
 		err = J1939_XTP_ABORT_DUP_SEQ;
-		goto out_session_unlock;
+		goto out_session_cancel;
 	}
 
 	if (session->skcb.addr.type == J1939_ETP)
@@ -1316,9 +1303,9 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 	else
 		pkt = dat[2];
 	if (!pkt) {
-		goto out_session_unlock;
+		goto out_session_cancel;
 	} else if (dat[1] > session->pkt.block /* 0xff for etp */) {
-		goto out_session_unlock;
+		goto out_session_cancel;
 	} else {
 		/* set packet counters only when not CTS(0) */
 		session->pkt.tx_acked = pkt - 1;
@@ -1332,7 +1319,6 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 	}
 
 	session->last_cmd = dat[0];
-	j1939_session_unlock(session);
 	if (dat[1]) {
 		j1939_tp_set_rxtimeout(session, 1250);
 		if (session->transmission) {
@@ -1348,8 +1334,7 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 	}
 	return;
 
- out_session_unlock:
-	j1939_session_unlock(session);
+ out_session_cancel:
 	j1939_session_timers_cancel(session);
 	j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
 	j1939_session_cancel(session, err);
@@ -1381,7 +1366,6 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 
 	INIT_LIST_HEAD(&session->active_session_list_entry);
 	INIT_LIST_HEAD(&session->sk_session_queue_entry);
-	spin_lock_init(&session->lock);
 	kref_init(&session->kref);
 
 	j1939_priv_get(priv);
@@ -1688,8 +1672,6 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 		/* makes no sense */
 		goto out_session_cancel;
 
-	j1939_session_lock(session);
-
 	switch (session->last_cmd) {
 	case 0xff:
 		break;
@@ -1703,7 +1685,7 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 	default:
 		netdev_info(priv->ndev, "%s: 0x%p: last %02x\n", __func__,
 			    session, session->last_cmd);
-		goto out_session_unlock;
+		goto out_session_cancel;
 	}
 
 	packet = (dat[0] - 1 + session->pkt.dpo);
@@ -1711,13 +1693,13 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 	    (session->pkt.rx + 1) > session->pkt.total) {
 		netdev_info(priv->ndev, "%s: 0x%p: should have been completed\n",
 			    __func__, session);
-		goto out_session_unlock;
+		goto out_session_cancel;
 	}
 	se_skb = j1939_session_skb_find(session);
 	if (!se_skb) {
 		netdev_warn(priv->ndev, "%s: 0x%p: no skb found\n", __func__,
 			    session);
-		goto out_session_unlock;
+		goto out_session_cancel;
 	}
 
 	skcb = j1939_skb_to_cb(se_skb);
@@ -1728,7 +1710,7 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 	if (nbytes <= 0 || (nbytes + 1) > skb->len) {
 		netdev_info(priv->ndev, "%s: 0x%p: nbytes %i, len %i\n",
 			    __func__, session, nbytes, skb->len);
-		goto out_session_unlock;
+		goto out_session_cancel;
 	}
 
 	tpdat = se_skb->data;
@@ -1745,7 +1727,6 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 		if (session->pkt.rx >= session->pkt.last)
 			do_cts_eoma = true;
 	}
-	j1939_session_unlock(session);
 
 	if (final) {
 		j1939_session_completed(session);
@@ -1761,9 +1742,6 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 
 	return;
 
- out_session_unlock:
-	/* unlock session (spinlock) before trying to send */
-	j1939_session_unlock(session);
  out_session_cancel:
 	j1939_session_timers_cancel(session);
 	j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
-- 
2.20.1

