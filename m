Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8A627986
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfEWJlw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36363 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfEWJlr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:47 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEI-0001Fv-Pn; Thu, 23 May 2019 11:41:42 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-00043d-9R; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 02/17] j1939: transport: do not send packets from j1939_tp_send
Date:   Thu, 23 May 2019 11:41:24 +0200
Message-Id: <20190523094139.15517-3-o.rempel@pengutronix.de>
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

I case the transmit queue is full, we will fail complete
session without retrying it again.
With this patch we will be able to handle it and unify the
code and error paths.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4320804062eb..e47eff502b6f 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1401,17 +1401,6 @@ static void j1939_xtp_rx_dat(struct j1939_priv *priv, struct sk_buff *skb)
 	j1939_session_put(session);
 }
 
-static inline int j1939_tp_tx_initial(struct j1939_session *session)
-{
-	int ret;
-
-	ret = j1939_tp_txnext(session);
-	/* set nonblocking for further packets */
-	session->skcb.msg_flags |= MSG_DONTWAIT;
-
-	return ret;
-}
-
 /* j1939 main intf */
 struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 				    struct sk_buff *skb, size_t size)
@@ -1478,12 +1467,11 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 	if (ret < 0)
 		goto failed;
 
-	ret = j1939_tp_tx_initial(session);
-	if (ret)
-		goto failed;
-
-	/* transmission started */
 	session->tskey = session->sk->sk_tskey++;
+	session->skcb.msg_flags |= MSG_DONTWAIT;
+	/* transmission started */
+	j1939_tp_schedule_txtimer(session, 0);
+
 	return session;
 
  failed:
-- 
2.20.1

