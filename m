Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5226B2797E
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfEWJlw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59895 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730318AbfEWJlv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:51 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEI-0001G6-Qn; Thu, 23 May 2019 11:41:42 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-00045F-JK; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 13/17] j1939: transport: better protect j1939_session_insert with lock
Date:   Thu, 23 May 2019 11:41:35 +0200
Message-Id: <20190523094139.15517-14-o.rempel@pengutronix.de>
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

By stress testing socket session queue I detected a racecondition
in this function. For example two concurrent socket fighting for same
session place in the active list would inject two concurrent session
to it.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 5152b5518613..e2343978f695 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1141,17 +1141,18 @@ static int j1939_session_insert(struct j1939_session *session)
 	struct j1939_session *pending;
 	int ret = 0;
 
-	pending = j1939_session_get_by_skcb(priv, &session->skcb, false);
+	j1939_session_list_lock(priv);
+	pending = j1939_session_get_by_skcb_locked(priv, &priv->tp_sessionq,
+						   &session->skcb, false);
 	if (pending) {
 		j1939_session_put(pending);
 		ret = -EAGAIN;
 	} else {
-		j1939_session_list_lock(priv);
 		WARN_ON_ONCE(session->state != J1939_SESSION_NEW);
 		j1939_session_list_add(session);
 		session->state = J1939_SESSION_ACTIVE;
-		j1939_session_list_unlock(priv);
 	}
+	j1939_session_list_unlock(priv);
 
 	return ret;
 }
-- 
2.20.1

