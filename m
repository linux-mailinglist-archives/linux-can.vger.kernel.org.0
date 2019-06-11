Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 032E03CC0D
	for <lists+linux-can@lfdr.de>; Tue, 11 Jun 2019 14:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387931AbfFKMsW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jun 2019 08:48:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45377 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387802AbfFKMsV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2019 08:48:21 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCH-0006Ei-Mx; Tue, 11 Jun 2019 14:48:17 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCG-0005PY-HW; Tue, 11 Jun 2019 14:48:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 04/16] j1939: socket: simplify j1939_sk_queue_activate_next_locked
Date:   Tue, 11 Jun 2019 14:48:02 +0200
Message-Id: <20190611124814.19908-5-o.rempel@pengutronix.de>
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

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/socket.c | 46 +++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 09967e5759e7..9930b2d2ee0b 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -122,9 +122,10 @@ static void j1939_sk_queue_drop_all(struct j1939_sock *jsk)
 static void j1939_sk_queue_activate_next_locked(struct j1939_session *session)
 {
 	struct j1939_sock *jsk;
-	struct j1939_session *cur, *next = NULL;
+	struct j1939_session *first;
 	int err;
 
+	/* RX-Session don't have a socket (yet) */
 	if (!session->sk)
 		return;
 
@@ -133,25 +134,34 @@ static void j1939_sk_queue_activate_next_locked(struct j1939_session *session)
 
 	err = session->err;
 
-	cur = list_first_entry_or_null(&jsk->sk_session_queue,
+	first = list_first_entry_or_null(&jsk->sk_session_queue,
 					struct j1939_session,
 					sk_session_queue_entry);
-	if (cur == session) {
-		list_del_init(&session->sk_session_queue_entry);
-		j1939_session_put(session);
-		next = list_first_entry_or_null(&jsk->sk_session_queue,
-						struct j1939_session,
-						sk_session_queue_entry);
-		if (next) {
-			/* Give receiver some time (arbitrary chosen) to recover */
-			int time_ms = 0;
-
-			if (err)
-				time_ms = 10 + prandom_u32_max(16);
-
-			WARN_ON_ONCE(j1939_session_activate(next));
-			j1939_tp_schedule_txtimer(next, time_ms);
-		}
+
+	/* Some else has already activated the next session */
+	if (first != session)
+		return;
+
+activate_next:
+	list_del_init(&first->sk_session_queue_entry);
+	j1939_session_put(first);
+	first = list_first_entry_or_null(&jsk->sk_session_queue,
+					struct j1939_session,
+					sk_session_queue_entry);
+	if (!first)
+		return;
+
+	if (WARN_ON_ONCE(j1939_session_activate(first))) {
+		first->err = -EBUSY;
+		goto activate_next;
+	} else {
+		/* Give receiver some time (arbitrary chosen) to recover */
+		int time_ms = 0;
+
+		if (err)
+			time_ms = 10 + prandom_u32_max(16);
+
+		j1939_tp_schedule_txtimer(first, time_ms);
 	}
 }
 
-- 
2.20.1

