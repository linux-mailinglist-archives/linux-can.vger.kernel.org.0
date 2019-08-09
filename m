Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C88487445
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 10:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405829AbfHIIgE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 04:36:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57645 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405888AbfHIIgC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 04:36:02 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NQ-00059Q-IG; Fri, 09 Aug 2019 10:35:56 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NP-0004R9-0k; Fri, 09 Aug 2019 10:35:55 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 20/21] j1939: initialize the struct j1939_sock
Date:   Fri,  9 Aug 2019 10:35:52 +0200
Message-Id: <20190809083553.16687-21-o.rempel@pengutronix.de>
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

We need to initialize all, but the struct j1939_sock::sk. Otherwise the
stack will explode in various colors (at our graphics teams used to
say). Add missing memset.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h | 2 +-
 net/can/j1939/socket.c     | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 8fb41fa289ba..e3d1793197fb 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -285,8 +285,8 @@ struct j1939_session {
 };
 
 struct j1939_sock {
-	struct j1939_priv *priv;
 	struct sock sk; /* must be first to skip with memset */
+	struct j1939_priv *priv;
 	struct list_head list;
 
 #define J1939_SOCK_BOUND BIT(0)
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index e6a77badcf73..f2d4dea5b158 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -353,6 +353,12 @@ static int j1939_sk_init(struct sock *sk)
 {
 	struct j1939_sock *jsk = j1939_sk(sk);
 
+	/* Ensure that "sk" is first member in "struct j1939_sock", so that we
+	 * can skip it during memset().
+	 */
+	BUILD_BUG_ON(offsetof(struct j1939_sock, sk) != 0);
+	memset((void *)jsk + sizeof(jsk->sk), 0x0, sizeof(*jsk) - sizeof(jsk->sk));
+
 	INIT_LIST_HEAD(&jsk->list);
 	init_waitqueue_head(&jsk->waitq);
 	jsk->sk.sk_priority = j1939_to_sk_priority(6);
-- 
2.20.1

