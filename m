Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C9387446
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 10:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405888AbfHIIgE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 04:36:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33365 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405785AbfHIIgB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 04:36:01 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NQ-00059E-IE; Fri, 09 Aug 2019 10:35:56 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NO-0004Q8-Pn; Fri, 09 Aug 2019 10:35:54 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 13/21] j1939: j1939_cancel_all_active_sessions: add option to cancel only one socket
Date:   Fri,  9 Aug 2019 10:35:45 +0200
Message-Id: <20190809083553.16687-14-o.rempel@pengutronix.de>
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

Add option to cancel sessions for only one socket.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  2 +-
 net/can/j1939/main.c       |  2 +-
 net/can/j1939/transport.c  | 12 +++++++-----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 416419890a37..6b8985d40520 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -208,7 +208,7 @@ void j1939_priv_get(struct j1939_priv *priv);
 
 /* notify/alert all j1939 sockets bound to ifindex */
 void j1939_sk_netdev_event(struct net_device *ndev, int error_code);
-int j1939_cancel_all_active_sessions(struct j1939_priv *priv);
+int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk);
 void j1939_tp_init(struct j1939_priv *priv);
 
 /* decrement pending skb for a j1939 socket */
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 41908279933c..68f1fa08cd5d 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -357,7 +357,7 @@ static int j1939_netdev_notify(struct notifier_block *nb,
 		break;
 
 	case NETDEV_DOWN:
-		j1939_cancel_all_active_sessions(priv);
+		j1939_cancel_active_session(priv, NULL);
 		j1939_sk_netdev_event(ndev, ENETDOWN);
 		j1939_ecu_unmap_all(priv);
 		break;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index e8b638e87dca..0af861485649 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1983,18 +1983,20 @@ void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb)
 	j1939_session_put(session);
 }
 
-int j1939_cancel_all_active_sessions(struct j1939_priv *priv)
+int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
 {
 	struct j1939_session *session, *saved;
 
-	netdev_dbg(priv->ndev, "%s\n", __func__);
+	netdev_dbg(priv->ndev, "%s, sk: %p\n", __func__, sk);
 	j1939_session_list_lock(priv);
 	list_for_each_entry_safe(session, saved,
 				 &priv->active_session_list,
 				 active_session_list_entry) {
-		j1939_session_timers_cancel(session);
-		session->err = ESHUTDOWN;
-		j1939_session_deactivate_locked(session);
+		if (!sk || sk == session->sk) {
+			j1939_session_timers_cancel(session);
+			session->err = ESHUTDOWN;
+			j1939_session_deactivate_locked(session);
+		}
 	}
 	j1939_session_list_unlock(priv);
 	return NOTIFY_DONE;
-- 
2.20.1

