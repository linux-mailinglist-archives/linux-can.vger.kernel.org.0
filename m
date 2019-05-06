Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F004D147D4
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2019 11:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfEFJv0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 6 May 2019 05:51:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57813 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfEFJv0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 May 2019 05:51:26 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hNaHK-0002NI-Ra; Mon, 06 May 2019 11:51:22 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <ore@pengutronix.de>)
        id 1hNaHJ-0006wc-Kc; Mon, 06 May 2019 11:51:21 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 2/2] j1939: transport: don't put session in j1939_xtp_rx_cts
Date:   Mon,  6 May 2019 11:51:18 +0200
Message-Id: <20190506095118.22805-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506095118.22805-1-o.rempel@pengutronix.de>
References: <20190506095118.22805-1-o.rempel@pengutronix.de>
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

we get and put session outside of this function

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index c6d8159c72d3..4943c390fca3 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1008,17 +1008,16 @@ j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb, bool extd)
 	dat = skb->data;
 	pgn = j1939_xtp_ctl_to_pgn(skb->data);
 
+	j1939_session_lock(session);
 	if (session->skcb.addr.pgn != pgn) {
 		struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 		/* what to do? */
 		j1939_xtp_tx_abort(priv, skcb, extd, true, J1939_XTP_ABORT_BUSY,
 				   pgn);
-		j1939_session_timers_cancel(session);
-		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
-		goto out_session_put;
+		err = J1939_XTP_ABORT_BUSY;
+		goto out_session_unlock;
 	}
 
-	j1939_session_lock(session);
 	if (session->last_cmd == dat[0]) {
 		err = J1939_XTP_ABORT_DUP_SEQ;
 		goto out_session_unlock;
@@ -1060,8 +1059,6 @@ j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb, bool extd)
 	j1939_session_unlock(session);
 	j1939_session_timers_cancel(session);
 	j1939_session_cancel(session, err);
- out_session_put:
-	j1939_session_put(session);
 }
 
 static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
-- 
2.20.1

