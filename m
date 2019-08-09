Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A204287450
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 10:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405876AbfHIIgH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 04:36:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56505 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405925AbfHIIgF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 04:36:05 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NU-00059M-Lu; Fri, 09 Aug 2019 10:36:00 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NO-0004QZ-Sw; Fri, 09 Aug 2019 10:35:54 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 16/21] j1939: change default timeout for simple sessions
Date:   Fri,  9 Aug 2019 10:35:48 +0200
Message-Id: <20190809083553.16687-17-o.rempel@pengutronix.de>
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

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h | 1 +
 net/can/j1939/transport.c  | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 6b8985d40520..5e9c1e3a3c5e 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -16,6 +16,7 @@
  * bus is open, the timeout should be triggered.
  */
 #define J1939_XTP_ABORT_TIMEOUT_MS 500
+#define J1939_SIMPLE_ECHO_TIMEOUT_MS (10 * 1000)
 
 struct j1939_session;
 enum j1939_sk_errqueue_type {
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 9bb9fbcf5754..a2f3de289387 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -994,8 +994,7 @@ static int j1939_simple_txnext(struct j1939_session *session)
 
 	can_skb_set_owner(skb, se_skb->sk);
 
-	j1939_tp_set_rxtimeout(session,
-			       J1939_XTP_ABORT_TIMEOUT_MS);
+	j1939_tp_set_rxtimeout(session, J1939_SIMPLE_ECHO_TIMEOUT_MS);
 
 	ret = j1939_send_one(priv, skb);
 	if (ret)
-- 
2.20.1

