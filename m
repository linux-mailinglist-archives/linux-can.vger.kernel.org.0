Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FC33A9897
	for <lists+linux-can@lfdr.de>; Wed, 16 Jun 2021 13:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhFPLEp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 07:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbhFPLEO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 07:04:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01914C0611C0
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 04:02:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ltTJ3-0007pX-B6
        for linux-can@vger.kernel.org; Wed, 16 Jun 2021 13:02:01 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4E40963D2B3
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 11:01:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8B5CA63D28D;
        Wed, 16 Jun 2021 11:01:54 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 88f2d04a;
        Wed, 16 Jun 2021 11:01:54 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>,
        Hillf Danton <hdanton@sina.com>,
        linux-stable <stable@vger.kernel.org>,
        syzbot+220c1a29987a9a490903@syzkaller.appspotmail.com,
        syzbot+45199c1b73b4013525cf@syzkaller.appspotmail.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net 1/4] can: j1939: fix Use-after-Free, hold skb ref while in use
Date:   Wed, 16 Jun 2021 13:01:49 +0200
Message-Id: <20210616110152.2456765-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616110152.2456765-1-mkl@pengutronix.de>
References: <20210616110152.2456765-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

This patch fixes a Use-after-Free found by the syzbot.

The problem is that a skb is taken from the per-session skb queue,
without incrementing the ref count. This leads to a Use-after-Free if
the skb is taken concurrently from the session queue due to a CTS.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Link: https://lore.kernel.org/r/20210521115720.7533-1-o.rempel@pengutronix.de
Cc: Hillf Danton <hdanton@sina.com>
Cc: linux-stable <stable@vger.kernel.org>
Reported-by: syzbot+220c1a29987a9a490903@syzkaller.appspotmail.com
Reported-by: syzbot+45199c1b73b4013525cf@syzkaller.appspotmail.com
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 54 +++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index e09d087ba240..c3946c355882 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -330,6 +330,9 @@ static void j1939_session_skb_drop_old(struct j1939_session *session)
 
 	if ((do_skcb->offset + do_skb->len) < offset_start) {
 		__skb_unlink(do_skb, &session->skb_queue);
+		/* drop ref taken in j1939_session_skb_queue() */
+		skb_unref(do_skb);
+
 		kfree_skb(do_skb);
 	}
 	spin_unlock_irqrestore(&session->skb_queue.lock, flags);
@@ -349,12 +352,13 @@ void j1939_session_skb_queue(struct j1939_session *session,
 
 	skcb->flags |= J1939_ECU_LOCAL_SRC;
 
+	skb_get(skb);
 	skb_queue_tail(&session->skb_queue, skb);
 }
 
 static struct
-sk_buff *j1939_session_skb_find_by_offset(struct j1939_session *session,
-					  unsigned int offset_start)
+sk_buff *j1939_session_skb_get_by_offset(struct j1939_session *session,
+					 unsigned int offset_start)
 {
 	struct j1939_priv *priv = session->priv;
 	struct j1939_sk_buff_cb *do_skcb;
@@ -371,6 +375,10 @@ sk_buff *j1939_session_skb_find_by_offset(struct j1939_session *session,
 			skb = do_skb;
 		}
 	}
+
+	if (skb)
+		skb_get(skb);
+
 	spin_unlock_irqrestore(&session->skb_queue.lock, flags);
 
 	if (!skb)
@@ -381,12 +389,12 @@ sk_buff *j1939_session_skb_find_by_offset(struct j1939_session *session,
 	return skb;
 }
 
-static struct sk_buff *j1939_session_skb_find(struct j1939_session *session)
+static struct sk_buff *j1939_session_skb_get(struct j1939_session *session)
 {
 	unsigned int offset_start;
 
 	offset_start = session->pkt.dpo * 7;
-	return j1939_session_skb_find_by_offset(session, offset_start);
+	return j1939_session_skb_get_by_offset(session, offset_start);
 }
 
 /* see if we are receiver
@@ -776,7 +784,7 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 	int ret = 0;
 	u8 dat[8];
 
-	se_skb = j1939_session_skb_find_by_offset(session, session->pkt.tx * 7);
+	se_skb = j1939_session_skb_get_by_offset(session, session->pkt.tx * 7);
 	if (!se_skb)
 		return -ENOBUFS;
 
@@ -801,7 +809,8 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 			netdev_err_once(priv->ndev,
 					"%s: 0x%p: requested data outside of queued buffer: offset %i, len %i, pkt.tx: %i\n",
 					__func__, session, skcb->offset, se_skb->len , session->pkt.tx);
-			return -EOVERFLOW;
+			ret = -EOVERFLOW;
+			goto out_free;
 		}
 
 		if (!len) {
@@ -835,6 +844,12 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 	if (pkt_done)
 		j1939_tp_set_rxtimeout(session, 250);
 
+ out_free:
+	if (ret)
+		kfree_skb(se_skb);
+	else
+		consume_skb(se_skb);
+
 	return ret;
 }
 
@@ -1007,7 +1022,7 @@ static int j1939_xtp_txnext_receiver(struct j1939_session *session)
 static int j1939_simple_txnext(struct j1939_session *session)
 {
 	struct j1939_priv *priv = session->priv;
-	struct sk_buff *se_skb = j1939_session_skb_find(session);
+	struct sk_buff *se_skb = j1939_session_skb_get(session);
 	struct sk_buff *skb;
 	int ret;
 
@@ -1015,8 +1030,10 @@ static int j1939_simple_txnext(struct j1939_session *session)
 		return 0;
 
 	skb = skb_clone(se_skb, GFP_ATOMIC);
-	if (!skb)
-		return -ENOMEM;
+	if (!skb) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
 
 	can_skb_set_owner(skb, se_skb->sk);
 
@@ -1024,12 +1041,18 @@ static int j1939_simple_txnext(struct j1939_session *session)
 
 	ret = j1939_send_one(priv, skb);
 	if (ret)
-		return ret;
+		goto out_free;
 
 	j1939_sk_errqueue(session, J1939_ERRQUEUE_SCHED);
 	j1939_sk_queue_activate_next(session);
 
-	return 0;
+ out_free:
+	if (ret)
+		kfree_skb(se_skb);
+	else
+		consume_skb(se_skb);
+
+	return ret;
 }
 
 static bool j1939_session_deactivate_locked(struct j1939_session *session)
@@ -1170,9 +1193,10 @@ static void j1939_session_completed(struct j1939_session *session)
 	struct sk_buff *skb;
 
 	if (!session->transmission) {
-		skb = j1939_session_skb_find(session);
+		skb = j1939_session_skb_get(session);
 		/* distribute among j1939 receivers */
 		j1939_sk_recv(session->priv, skb);
+		consume_skb(skb);
 	}
 
 	j1939_session_deactivate_activate_next(session);
@@ -1744,7 +1768,7 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 {
 	struct j1939_priv *priv = session->priv;
 	struct j1939_sk_buff_cb *skcb;
-	struct sk_buff *se_skb;
+	struct sk_buff *se_skb = NULL;
 	const u8 *dat;
 	u8 *tpdat;
 	int offset;
@@ -1786,7 +1810,7 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 		goto out_session_cancel;
 	}
 
-	se_skb = j1939_session_skb_find_by_offset(session, packet * 7);
+	se_skb = j1939_session_skb_get_by_offset(session, packet * 7);
 	if (!se_skb) {
 		netdev_warn(priv->ndev, "%s: 0x%p: no skb found\n", __func__,
 			    session);
@@ -1848,11 +1872,13 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 		j1939_tp_set_rxtimeout(session, 250);
 	}
 	session->last_cmd = 0xff;
+	consume_skb(se_skb);
 	j1939_session_put(session);
 
 	return;
 
  out_session_cancel:
+	kfree_skb(se_skb);
 	j1939_session_timers_cancel(session);
 	j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
 	j1939_session_put(session);

base-commit: a4f0377db1254373513b992ff31a351a7111f0fd
-- 
2.30.2


