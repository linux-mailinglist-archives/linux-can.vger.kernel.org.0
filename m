Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08842797B
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfEWJlq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59929 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfEWJlp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:45 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEI-0001G4-Pp; Thu, 23 May 2019 11:41:42 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-00044w-Hg; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 11/17] j1939: transport: abort not started session if requested
Date:   Thu, 23 May 2019 11:41:33 +0200
Message-Id: <20190523094139.15517-12-o.rempel@pengutronix.de>
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

By simulating bad network configuration for example with:
jcat can0:0x90 -r > /tmp/blup1 &
jcat can1:0x90 -r > /tmp/blup2 &
session would stall if we not abort it on abort request.
So, abort any session if we are requested to do so.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 13ffc7d315b2..e4668979a2a5 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -950,6 +950,7 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 {
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 	struct j1939_session *session;
+	u8 abort = skb->data[1];
 	pgn_t pgn;
 
 	pgn = j1939_xtp_ctl_to_pgn(skb->data);
@@ -957,24 +958,12 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
 	if (!session)
 		return;
 
-	if (session->transmission && !session->last_txcmd) {
-		/* empty block:
-		 * do not drop session when a transmit session did not
-		 * start yet
-		 */
-	} else if (session->skcb.addr.pgn == pgn) {
-		u8 abort = skb->data[1];
-
-		j1939_session_timers_cancel(session);
-		session->err = j1939_xtp_abort_to_errno(priv, abort);
-		if (session->sk)
-			j1939_sk_send_multi_abort(priv, session->sk,
-						  session->err);
-	}
+	j1939_session_timers_cancel(session);
+	session->err = j1939_xtp_abort_to_errno(priv, abort);
+	if (session->sk)
+		j1939_sk_send_multi_abort(priv, session->sk,
+					  session->err);
 
-	/* TODO: maybe cancel current connection
-	 * as another pgn was communicated
-	 */
 	j1939_session_put(session);
 }
 
-- 
2.20.1

