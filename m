Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C7F3CC18
	for <lists+linux-can@lfdr.de>; Tue, 11 Jun 2019 14:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387866AbfFKMs2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jun 2019 08:48:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54013 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388638AbfFKMs1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2019 08:48:27 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCM-0006Er-93; Tue, 11 Jun 2019 14:48:22 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCG-0005S9-Qj; Tue, 11 Jun 2019 14:48:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 13/16] j1939: transport: rename RTS current to active
Date:   Tue, 11 Jun 2019 14:48:11 +0200
Message-Id: <20190611124814.19908-14-o.rempel@pengutronix.de>
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

and add _session_ to the name pattern.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4826b2ad666f..dd8692f507fc 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1244,8 +1244,8 @@ int j1939_session_activate(struct j1939_session *session)
 }
 
 static struct
-j1939_session *j1939_xtp_rx_rts_new(struct j1939_priv *priv,
-				    struct sk_buff *skb)
+j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
+					    struct sk_buff *skb)
 {
 	enum j1939_xtp_abort abort = J1939_XTP_NO_ABORT;
 	struct j1939_sk_buff_cb skcb = *j1939_skb_to_cb(skb);
@@ -1316,8 +1316,8 @@ j1939_session *j1939_xtp_rx_rts_new(struct j1939_priv *priv,
 	return session;
 }
 
-static int j1939_xtp_rx_rts_current(struct j1939_session *session,
-				    struct sk_buff *skb)
+static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
+					   struct sk_buff *skb)
 {
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 	struct j1939_priv *priv = session->priv;
@@ -1326,7 +1326,7 @@ static int j1939_xtp_rx_rts_current(struct j1939_session *session,
 		if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 			return -EBUSY;
 
-		/* RTS on pending connection */
+		/* RTS on active session */
 		j1939_session_timers_cancel(session);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
 	}
@@ -1561,12 +1561,12 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 		 * TP is pending in the other direction
 		 */
 		if (session) {
-			if (j1939_xtp_rx_rts_current(session, skb)) {
+			if (j1939_xtp_rx_rts_session_active(session, skb)) {
 				j1939_session_put(session);
 				break;
 			}
 		} else {
-			session = j1939_xtp_rx_rts_new(priv, skb);
+			session = j1939_xtp_rx_rts_session_new(priv, skb);
 			if (!session)
 				break;
 		}
-- 
2.20.1

