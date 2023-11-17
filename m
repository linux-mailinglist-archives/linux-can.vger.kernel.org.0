Return-Path: <linux-can+bounces-31-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B347EF2FD
	for <lists+linux-can@lfdr.de>; Fri, 17 Nov 2023 13:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 830BEB20ACF
	for <lists+linux-can@lfdr.de>; Fri, 17 Nov 2023 12:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B90430329;
	Fri, 17 Nov 2023 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA303D52
	for <linux-can@vger.kernel.org>; Fri, 17 Nov 2023 04:50:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1r3yIL-0005eC-Co; Fri, 17 Nov 2023 13:50:01 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1r3yIK-009gMy-L2; Fri, 17 Nov 2023 13:50:00 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1r3yIK-00423C-1v;
	Fri, 17 Nov 2023 13:50:00 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	syzbot+daa36413a5cedf799ae4@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] net: can: j1939: enhanced error handling for tightly received RTS messages in xtp_rx_rts_session_new
Date: Fri, 17 Nov 2023 13:49:59 +0100
Message-Id: <20231117124959.961171-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

This patch enhances error handling in scenarios with RTS (Request to
Send) messages arriving closely. It replaces the less informative WARN_ON_ONCE
backtraces with a new error handling method. This provides clearer error
messages and allows for the early termination of problematic sessions.
Previously, sessions were only released at the end of j1939_xtp_rx_rts().

Potentially this could be reproduced with something like:
testj1939 -r vcan0:0x80 &
while true; do
	# send first RTS
	cansend vcan0 18EC8090#1014000303002301;
	# send second RTS
	cansend vcan0 18EC8090#1014000303002301;
	# send abort
	cansend vcan0 18EC8090#ff00000000002301;
done

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Reported-by: syzbot+daa36413a5cedf799ae4@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fe3df23a2595..c6569f98d251 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1593,8 +1593,8 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	struct j1939_sk_buff_cb skcb = *j1939_skb_to_cb(skb);
 	struct j1939_session *session;
 	const u8 *dat;
+	int len, ret;
 	pgn_t pgn;
-	int len;
 
 	netdev_dbg(priv->ndev, "%s\n", __func__);
 
@@ -1653,7 +1653,22 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	session->tskey = priv->rx_tskey++;
 	j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_RTS);
 
-	WARN_ON_ONCE(j1939_session_activate(session));
+	ret = j1939_session_activate(session);
+	if (ret) {
+		/* Entering this scope indicates an issue with the J1939 bus.
+		 * Possible scenarios include:
+		 * - A time lapse occurred, and a new session was initiated
+		 *   due to another packet being sent correctly. This could
+		 *   have been caused by too long interrupt, debugger, or being
+		 *   out-scheduled by another task.
+		 * - The bus is receiving numerous erroneous packets, either
+		 *   from a malfunctioning device or during a test scenario.
+		 */
+		netdev_alert(priv->ndev, "%s: 0x%p: concurrent session with same addr (%02x %02x) is already active.\n",
+			     __func__, session, skcb.addr.sa, skcb.addr.da);
+		j1939_session_put(session);
+		return NULL;
+	}
 
 	return session;
 }
-- 
2.39.2


