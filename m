Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28E76332F
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfGII7a (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48575 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfGII7a (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:30 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxx-00085o-Jo; Tue, 09 Jul 2019 10:59:13 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-0000ny-2c; Tue, 09 Jul 2019 10:59:12 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 33/34] j1939: transport: don't create new session for transmitter
Date:   Tue,  9 Jul 2019 10:59:08 +0200
Message-Id: <20190709085909.1413-33-o.rempel@pengutronix.de>
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

In some cases new session can be aborted before we got an loopback rts.
In this rare case we will create invalid session. To avoid it, don't
create a session if we are transmitter.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index cb4e8be7de0a..3e0345122a0c 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1510,6 +1510,20 @@ static void j1939_xtp_rx_rts(struct j1939_priv *priv, struct sk_buff *skb,
 			j1939_session_put(session);
 			return;
 		}
+	} else if (transmitter) {
+		/* If we're the transmitter and this function is called, we
+		 * received our own RTS. A session has already been created.
+		 *
+		 * For some reasons however it might have been destroyed
+		 * already. So don't create a new one here (using
+		 * "j1939_xtp_rx_rts_session_new()") as this will be a receiver
+		 * session.
+		 *
+		 * The reasons the session is already destroyed might be:
+		 * - user space closed socket was and the session was aborted
+		 * - session was aborted due to external abort message
+		 */
+		return;
 	} else {
 		session = j1939_xtp_rx_rts_session_new(priv, skb);
 		if (!session)
-- 
2.20.1

