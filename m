Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55F6863318
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfGII7S (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50563 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfGII7S (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:18 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085M-HB; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000aq-41; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 05/34] j1939: transport: call J1939_ERRQUEUE_SCHED on CTS
Date:   Tue,  9 Jul 2019 10:58:40 +0200
Message-Id: <20190709085909.1413-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709085909.1413-1-o.rempel@pengutronix.de>
References: <20190709085909.1413-1-o.rempel@pengutronix.de>
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

only here we can really talk about acked part of session

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 858c4587af8f..8b15c5d529a1 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -809,7 +809,7 @@ static int j1939_tp_txnext(struct j1939_session *session)
 			j1939_tp_set_rxtimeout(session, 250);
 		if (ret)
 			goto failed;
-		j1939_sk_errqueue(session, J1939_ERRQUEUE_SCHED);
+
 		break;
 	}
 
@@ -1056,6 +1056,7 @@ j1939_xtp_rx_eoma(struct j1939_session *session, struct sk_buff *skb)
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
 
+	session->pkt.tx_acked = session->pkt.total;
 	j1939_session_timers_cancel(session);
 	/* transmitted without problems */
 	j1939_session_completed(session);
@@ -1104,8 +1105,11 @@ j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb)
 	j1939_session_unlock(session);
 	if (dat[1]) {
 		j1939_tp_set_rxtimeout(session, 1250);
-		if (j1939_tp_im_transmitter(&session->skcb))
+		if (j1939_tp_im_transmitter(&session->skcb)) {
+			if (session->pkt.tx_acked)
+				j1939_sk_errqueue(session, J1939_ERRQUEUE_SCHED);
 			j1939_tp_schedule_txtimer(session, 0);
+		}
 	} else {
 		/* CTS(0) */
 		j1939_tp_set_rxtimeout(session, 550);
-- 
2.20.1

