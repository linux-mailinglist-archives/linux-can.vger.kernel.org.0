Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 503A227987
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfEWJlx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50813 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbfEWJlw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:52 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEI-0001G8-Q0; Thu, 23 May 2019 11:41:42 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-00045X-L0; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 15/17] j1939: rename j1939_sk_send_multi to j1939_sk_send_loop
Date:   Thu, 23 May 2019 11:41:37 +0200
Message-Id: <20190523094139.15517-16-o.rempel@pengutronix.de>
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

we have no more different path for send multi or send single.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h | 2 +-
 net/can/j1939/socket.c     | 6 +++---
 net/can/j1939/transport.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index b53e2ddd317e..de034dab0bc6 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -164,7 +164,7 @@ static inline struct j1939_sk_buff_cb *j1939_skb_to_cb(struct sk_buff *skb)
 
 int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb);
 void j1939_sk_recv(struct j1939_priv *priv, struct sk_buff *skb);
-void j1939_sk_send_multi_abort(struct j1939_priv *priv, struct sock *sk,
+void j1939_sk_send_loop_abort(struct j1939_priv *priv, struct sock *sk,
 			       int err);
 void j1939_sk_errqueue(struct j1939_session *session,
 		       enum j1939_sk_errqueue_type type);
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 0aa6582f36c3..80ef2329c921 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -879,7 +879,7 @@ void j1939_sk_errqueue(struct j1939_session *session,
 		kfree_skb(skb);
 };
 
-void j1939_sk_send_multi_abort(struct j1939_priv *priv, struct sock *sk,
+void j1939_sk_send_loop_abort(struct j1939_priv *priv, struct sock *sk,
 			       int err)
 {
 	sk->sk_err = err;
@@ -887,7 +887,7 @@ void j1939_sk_send_multi_abort(struct j1939_priv *priv, struct sock *sk,
 	sk->sk_error_report(sk);
 }
 
-static int j1939_sk_send_multi(struct j1939_priv *priv,  struct sock *sk,
+static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 			       struct msghdr *msg, size_t size)
 
 {
@@ -1034,7 +1034,7 @@ static int j1939_sk_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (!priv)
 		return -EINVAL;
 
-	ret = j1939_sk_send_multi(priv, sk, msg, size);
+	ret = j1939_sk_send_loop(priv, sk, msg, size);
 
 	j1939_priv_put(priv);
 
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 16d42752f8f0..ade2937f57cf 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -876,7 +876,7 @@ static void j1939_session_cancel(struct j1939_session *session,
 				   err, session->skcb.addr.pgn);
 
 	if (session->sk)
-		j1939_sk_send_multi_abort(priv, session->sk, session->err);
+		j1939_sk_send_loop_abort(priv, session->sk, session->err);
 }
 
 static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
@@ -987,7 +987,7 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 	j1939_session_timers_cancel(session);
 	session->err = j1939_xtp_abort_to_errno(priv, abort);
 	if (session->sk)
-		j1939_sk_send_multi_abort(priv, session->sk,
+		j1939_sk_send_loop_abort(priv, session->sk,
 					  session->err);
 	j1939_session_deactivate_activate_next(session);
 
-- 
2.20.1

