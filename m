Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29FE8147D5
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2019 11:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfEFJv0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 6 May 2019 05:51:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44479 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfEFJv0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 May 2019 05:51:26 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hNaHK-0002NH-Rc; Mon, 06 May 2019 11:51:22 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <ore@pengutronix.de>)
        id 1hNaHJ-0006wJ-Jl; Mon, 06 May 2019 11:51:21 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 1/2] j1939: transport: abort the session if we get double CTS
Date:   Mon,  6 May 2019 11:51:17 +0200
Message-Id: <20190506095118.22805-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506095118.22805-1-o.rempel@pengutronix.de>
References: <20190506095118.22805-1-o.rempel@pengutronix.de>
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

If we get double CTS, network is not properly configured and we
can't guarantee proper transfer any more. So, abort transfer if
we see some thing wrong is happening.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 734b0fd23078..c6d8159c72d3 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1000,6 +1000,7 @@ static void
 j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb, bool extd)
 {
 	struct j1939_priv *priv = session->priv;
+	enum j1939_xtp_abort err = J1939_XTP_ABORT_FAULT;
 	pgn_t pgn;
 	unsigned int pkt;
 	const u8 *dat;
@@ -1018,6 +1019,11 @@ j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb, bool extd)
 	}
 
 	j1939_session_lock(session);
+	if (session->last_cmd == dat[0]) {
+		err = J1939_XTP_ABORT_DUP_SEQ;
+		goto out_session_unlock;
+	}
+
 	if (extd)
 		pkt = j1939_etp_ctl_to_packet(dat);
 	else
@@ -1053,7 +1059,7 @@ j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb, bool extd)
  out_session_unlock:
 	j1939_session_unlock(session);
 	j1939_session_timers_cancel(session);
-	j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
+	j1939_session_cancel(session, err);
  out_session_put:
 	j1939_session_put(session);
 }
-- 
2.20.1

