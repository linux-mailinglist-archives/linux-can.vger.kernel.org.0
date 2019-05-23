Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47AA52797A
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfEWJlq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49957 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfEWJlq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:46 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEI-0001G5-Qn; Thu, 23 May 2019 11:41:42 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-000455-IW; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 12/17] j1939: add session state
Date:   Thu, 23 May 2019 11:41:34 +0200
Message-Id: <20190523094139.15517-13-o.rempel@pengutronix.de>
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

we will needed it for socket session queue

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h | 7 +++++++
 net/can/j1939/transport.c  | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 58bf1eaca6ec..08de30e87779 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -198,6 +198,12 @@ void j1939_tp_init(struct j1939_priv *priv);
 /* decrement pending skb for a j1939 socket */
 void j1939_sock_pending_del(struct sock *sk);
 
+enum j1939_session_state {
+	J1939_SESSION_NEW,
+	J1939_SESSION_ACTIVE,
+	J1939_SESSION_DONE,
+};
+
 struct j1939_session {
 	struct j1939_priv *priv;
 	struct list_head list;
@@ -225,6 +231,7 @@ struct j1939_session {
 	unsigned int total_message_size; /* Total message size, number of bytes */
 	int err;
 	u32 tskey;
+	enum j1939_session_state state;
 
 	/* Packets counters for a (extended) transfer session. The packet is
 	 * maximal of 7 bytes. */
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index e4668979a2a5..5152b5518613 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1083,6 +1083,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	j1939_priv_get(priv);
 	session->priv = priv;
 	session->total_message_size = size;
+	session->state = J1939_SESSION_NEW;
 
 	skb_queue_head_init(&session->skb_queue);
 	skb_queue_tail(&session->skb_queue, skb);
@@ -1146,7 +1147,9 @@ static int j1939_session_insert(struct j1939_session *session)
 		ret = -EAGAIN;
 	} else {
 		j1939_session_list_lock(priv);
+		WARN_ON_ONCE(session->state != J1939_SESSION_NEW);
 		j1939_session_list_add(session);
+		session->state = J1939_SESSION_ACTIVE;
 		j1939_session_list_unlock(priv);
 	}
 
-- 
2.20.1

