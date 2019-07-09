Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 363F56332A
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfGII70 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38915 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfGII7Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:24 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxx-00085j-8e; Tue, 09 Jul 2019 10:59:13 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000mE-Tc; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 28/34] j1939: transport: don't send false abort on rts with enabled socket filter
Date:   Tue,  9 Jul 2019 10:59:03 +0200
Message-Id: <20190709085909.1413-28-o.rempel@pengutronix.de>
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

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index ca2571bed0de..efaa7c7a10d2 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1352,6 +1352,9 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	pgn = j1939_xtp_ctl_to_pgn(dat);
 	skcb.addr.pgn = pgn;
 
+	if (!j1939_sk_recv_match(priv, &skcb))
+		return NULL;
+
 	if (skcb.addr.type == J1939_ETP) {
 		len = j1939_etp_ctl_to_size(dat);
 		if (len > J1939_MAX_ETP_PACKET_SIZE)
@@ -1373,9 +1376,6 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 		return NULL;
 	}
 
-	if (!j1939_sk_recv_match(priv, &skcb))
-		return NULL;
-
 	session = j1939_session_fresh_new(priv, len, &skcb);
 	if (!session) {
 		j1939_xtp_tx_abort(priv, &skcb, true,
-- 
2.20.1

