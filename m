Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B87048744C
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 10:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405975AbfHIIgF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 04:36:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52787 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405934AbfHIIgE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 04:36:04 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NU-00059R-Ns; Fri, 09 Aug 2019 10:36:00 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NP-0004RI-1p; Fri, 09 Aug 2019 10:35:55 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 21/21] j1939: transport: ignore -ENETDOWN error
Date:   Fri,  9 Aug 2019 10:35:53 +0200
Message-Id: <20190809083553.16687-22-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809083553.16687-1-o.rempel@pengutronix.de>
References: <20190809083553.16687-1-o.rempel@pengutronix.de>
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

it will be handled by j1939_cancel_all_active_sessions()

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index a2f3de289387..ecdcfb77c2e9 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1078,7 +1078,8 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 			ret = j1939_xtp_txnext_receiver(session);
 	}
 
-	if (ret == -ENOBUFS) {
+	switch (ret) {
+	case -ENOBUFS:
 		/* Retry limit is currently arbitrary chosen */
 		if (session->tx_retry < J1939_XTP_TX_RETRY_LIMIT) {
 			session->tx_retry++;
@@ -1091,7 +1092,19 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 			j1939_session_rxtimer_cancel(session);
 			j1939_session_deactivate_activate_next(session);
 		}
-	} else if (ret) {
+		break;
+	case -ENETDOWN:
+		/* In this case we should get a netdev_event(), all active
+		 * sessions will be cleared by
+		 * j1939_cancel_all_active_sessions(). So handle this as an
+		 * error, but let j1939_cancel_all_active_sessions() do the
+		 * cleanup including propagation of the error to user space.
+		 */
+		break;
+	case 0:
+		session->tx_retry = 0;
+		break;
+	default:
 		netdev_alert(priv->ndev, "%s: 0x%p: tx aborted with unknown reason: %i\n",
 			     __func__, session, ret);
 		if (session->skcb.addr.type != J1939_SIMPLE) {
@@ -1103,8 +1116,6 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 			j1939_session_rxtimer_cancel(session);
 			j1939_session_deactivate_activate_next(session);
 		}
-	} else {
-		session->tx_retry = 0;
 	}
 
 	j1939_session_put(session);
-- 
2.20.1

