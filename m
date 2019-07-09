Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 200276332D
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfGII71 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58523 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfGII70 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:26 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxx-00085g-8o; Tue, 09 Jul 2019 10:59:13 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000lf-Qc; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 25/34] j1939: transport: make sure txtimer is canceled before starting it again
Date:   Tue,  9 Jul 2019 10:59:00 +0200
Message-Id: <20190709085909.1413-25-o.rempel@pengutronix.de>
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

Double starting the timer will brake refcounting.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 79233f7884cc..d9a8795dd0b5 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1220,6 +1220,7 @@ j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb)
 		if (j1939_tp_im_transmitter(&session->skcb)) {
 			if (session->pkt.tx_acked)
 				j1939_sk_errqueue(session, J1939_ERRQUEUE_SCHED);
+			j1939_session_txtimer_cancel(session);
 			j1939_tp_schedule_txtimer(session, 0);
 		}
 	} else {
@@ -1660,8 +1661,10 @@ static void j1939_tp_cmd_recv(struct j1939_priv *priv, struct sk_buff *skb)
 		j1939_tp_set_rxtimeout(session, 1250);
 
 		if (cmd != J1939_TP_CMD_BAM &&
-		    j1939_tp_im_receiver(&session->skcb))
+		    j1939_tp_im_receiver(&session->skcb)) {
+			j1939_session_txtimer_cancel(session);
 			j1939_tp_schedule_txtimer(session, 0);
+		}
 
 		j1939_session_put(session);
 		break;
-- 
2.20.1

