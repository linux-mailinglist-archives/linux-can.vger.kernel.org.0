Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF30E848F9
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2019 11:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfHGJzs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Aug 2019 05:55:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54817 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbfHGJzr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Aug 2019 05:55:47 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hvIfY-0005F9-HN; Wed, 07 Aug 2019 11:55:44 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hvIfX-0001iq-8F; Wed, 07 Aug 2019 11:55:43 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 5/5] j1939: transport: refactor j1939_xtp_rx_cts_one()
Date:   Wed,  7 Aug 2019 11:55:41 +0200
Message-Id: <20190807095541.2544-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807095541.2544-1-o.rempel@pengutronix.de>
References: <20190807095541.2544-1-o.rempel@pengutronix.de>
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

Remove one indention level for the non error case.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index a9671e2a5fcf..eebbe898d127 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1302,21 +1302,21 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 		pkt = j1939_etp_ctl_to_packet(dat);
 	else
 		pkt = dat[2];
-	if (!pkt) {
+
+	if (!pkt)
 		goto out_session_cancel;
-	} else if (dat[1] > session->pkt.block /* 0xff for etp */) {
+	else if (dat[1] > session->pkt.block /* 0xff for etp */)
 		goto out_session_cancel;
-	} else {
-		/* set packet counters only when not CTS(0) */
-		session->pkt.tx_acked = pkt - 1;
-		j1939_session_skb_drop_old(session);
-		session->pkt.last = session->pkt.tx_acked + dat[1];
-		if (session->pkt.last > session->pkt.total)
-			/* safety measure */
-			session->pkt.last = session->pkt.total;
-		/* TODO: do not set tx here, do it in txtimer */
-		session->pkt.tx = session->pkt.tx_acked;
-	}
+
+	/* set packet counters only when not CTS(0) */
+	session->pkt.tx_acked = pkt - 1;
+	j1939_session_skb_drop_old(session);
+	session->pkt.last = session->pkt.tx_acked + dat[1];
+	if (session->pkt.last > session->pkt.total)
+		/* safety measure */
+		session->pkt.last = session->pkt.total;
+	/* TODO: do not set tx here, do it in txtimer */
+	session->pkt.tx = session->pkt.tx_acked;
 
 	session->last_cmd = dat[0];
 	if (dat[1]) {
-- 
2.20.1

