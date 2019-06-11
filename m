Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB83CC16
	for <lists+linux-can@lfdr.de>; Tue, 11 Jun 2019 14:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbfFKMs0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jun 2019 08:48:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40029 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388619AbfFKMsZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2019 08:48:25 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCH-0006Eh-Mx; Tue, 11 Jun 2019 14:48:17 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCG-0005P7-Gf; Tue, 11 Jun 2019 14:48:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 03/16] j1939: transport: use rxtimer to force session abort
Date:   Tue, 11 Jun 2019 14:48:01 +0200
Message-Id: <20190611124814.19908-4-o.rempel@pengutronix.de>
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

If CAN bus is broken we won't be able to get loop back abort
signal from the bus. So, use rxtimer to force abort directly.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  3 +++
 net/can/j1939/transport.c  | 27 +++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 9ebb2c74f4f6..6f7abd12bc54 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -208,6 +208,9 @@ void j1939_sock_pending_del(struct sock *sk);
 enum j1939_session_state {
 	J1939_SESSION_NEW,
 	J1939_SESSION_ACTIVE,
+	/* waiting for abort signal on the bus */
+	J1939_SESSION_WAITING_ABORT,
+	J1939_SESSION_ACTIVE_MAX,
 	J1939_SESSION_DONE,
 };
 
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 06b77de6aa85..cd68b98fee92 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -833,7 +833,8 @@ bool j1939_session_deactivate(struct j1939_session *session)
 	bool active = false;
 
 	j1939_session_list_lock(session->priv);
-	if (session->state == J1939_SESSION_ACTIVE) {
+	if (session->state >= J1939_SESSION_ACTIVE &&
+	    session->state < J1939_SESSION_ACTIVE_MAX) {
 		active = true;
 
 		list_del_init(&session->active_session_list_entry);
@@ -934,9 +935,27 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 						     rxtimer);
 	struct j1939_priv *priv = session->priv;
 
-	netdev_alert(priv->ndev, "%s: timeout\n", __func__);
-	j1939_session_txtimer_cancel(session);
-	j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
+	if (session->state == J1939_SESSION_WAITING_ABORT) {
+		netdev_alert(priv->ndev, "%s: abort rx timeout. Force session deactivation\n",
+			     __func__);
+
+		j1939_session_deactivate_activate_next(session);
+	} else {
+		netdev_alert(priv->ndev, "%s: rx timeout, send abort\n",
+			     __func__);
+
+		j1939_session_list_lock(session->priv);
+		if (session->state >= J1939_SESSION_ACTIVE &&
+		    session->state < J1939_SESSION_ACTIVE_MAX) {
+			session->state = J1939_SESSION_WAITING_ABORT;
+			j1939_session_get(session);
+			hrtimer_start(&session->rxtimer, ms_to_ktime(1250),
+				      HRTIMER_MODE_REL_SOFT);
+			j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
+		}
+		j1939_session_list_unlock(session->priv);
+	}
+
 	j1939_session_put(session);
 
 	return HRTIMER_NORESTART;
-- 
2.20.1

