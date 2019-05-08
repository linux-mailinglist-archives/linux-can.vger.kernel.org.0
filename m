Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19323179D9
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2019 15:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfEHNFW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 May 2019 09:05:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44431 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfEHNFV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2019 09:05:21 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hOMG7-0005R8-BK; Wed, 08 May 2019 15:05:19 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <ore@pengutronix.de>)
        id 1hOMG6-0004qI-A6; Wed, 08 May 2019 15:05:18 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v3 1/3] j1939: transport: store error in to session
Date:   Wed,  8 May 2019 15:05:14 +0200
Message-Id: <20190508130516.3954-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508130516.3954-1-o.rempel@pengutronix.de>
References: <20190508130516.3954-1-o.rempel@pengutronix.de>
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

For the errqueue we need to store error per session. In this
case we can notify the user space about session state even if
we have a queue of multiple sessions.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h | 1 +
 net/can/j1939/transport.c  | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 4cb2e63a86c4..ff59301c9dc3 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -207,6 +207,7 @@ struct j1939_session {
 	bool transmission;
 	bool extd;
 	unsigned int total_message_size; /* Total message size, number of bytes */
+	int err;
 
 	/* Packets counters for a (extended) transfer session. The packet is
 	 * maximal of 7 bytes. */
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 843c772c0659..62838d2e1173 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -874,6 +874,7 @@ static void j1939_session_cancel(struct j1939_session *session,
 
 	WARN_ON_ONCE(!err);
 
+	session->err = j1939_xtp_abort_to_errno(priv, err);
 	/* do not send aborts on incoming broadcasts */
 	if (!j1939_cb_is_broadcast(&session->skcb))
 		j1939_xtp_tx_abort(priv, &session->skcb, session->extd,
@@ -881,8 +882,7 @@ static void j1939_session_cancel(struct j1939_session *session,
 				   err, session->skcb.addr.pgn);
 
 	if (session->sk)
-		j1939_sk_send_multi_abort(priv, session->sk,
-					  j1939_xtp_abort_to_errno(priv, err));
+		j1939_sk_send_multi_abort(priv, session->sk, session->err);
 }
 
 static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
@@ -957,9 +957,10 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 		u8 abort = skb->data[1];
 
 		j1939_session_timers_cancel(session);
+		session->err = j1939_xtp_abort_to_errno(priv, abort);
 		if (session->sk)
 			j1939_sk_send_multi_abort(priv, session->sk,
-						  j1939_xtp_abort_to_errno(priv, abort));
+						  session->err);
 	}
 
 	/* TODO: maybe cancel current connection
-- 
2.20.1

