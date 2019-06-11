Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21873CC14
	for <lists+linux-can@lfdr.de>; Tue, 11 Jun 2019 14:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388429AbfFKMsY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jun 2019 08:48:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43417 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388591AbfFKMsY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2019 08:48:24 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCH-0006Eg-N4; Tue, 11 Jun 2019 14:48:17 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCG-0005Ox-Fl; Tue, 11 Jun 2019 14:48:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 02/16] j1939: transport: limit amount of tx retries
Date:   Tue, 11 Jun 2019 14:48:00 +0200
Message-Id: <20190611124814.19908-3-o.rempel@pengutronix.de>
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

If CAN bus damaged, buffers will stall in the CAN driver.
In this case j1939 stack tried to resend the buffers forever.
So, limit amount of retries to 10 for now.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  2 ++
 net/can/j1939/transport.c  | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 21bee33fdbf4..9ebb2c74f4f6 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -239,6 +239,8 @@ struct j1939_session {
 	unsigned int total_message_size; /* Total message size, number of bytes */
 	unsigned int total_queued_size; /* Total number of bytes queue from socket
 					   to the session */
+	unsigned int tx_retry;
+
 	int err;
 	u32 tskey;
 	enum j1939_session_state state;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 7decc38a4d46..06b77de6aa85 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -8,6 +8,8 @@
 
 #include "j1939-priv.h"
 
+#define J1939_XTP_TX_RETRY_LIMIT 100
+
 #define J1939_ETP_PGN_CTL 0xc800
 #define J1939_ETP_PGN_DAT 0xc700
 #define J1939_TP_PGN_CTL 0xec00
@@ -872,6 +874,7 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 {
 	struct j1939_session *session =
 		container_of(hrtimer, struct j1939_session, txtimer);
+	struct j1939_priv *priv = session->priv;
 	int ret = 0;
 
 	if (session->skcb.addr.type == J1939_SIMPLE) {
@@ -889,9 +892,24 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 	}
 
 	if (ret == -ENOBUFS) {
-		j1939_tp_schedule_txtimer(session, 10 + prandom_u32_max(16));
+		/* Retry limit is currently arbitrary chosen */
+		if (session->tx_retry < J1939_XTP_TX_RETRY_LIMIT) {
+			session->tx_retry++;
+			j1939_tp_schedule_txtimer(session,
+						  10 + prandom_u32_max(16));
+		} else {
+			netdev_alert(priv->ndev, "%s: tx retry count reached\n",
+				     __func__);
+			session->err = -ENETUNREACH;
+			j1939_session_rxtimer_cancel(session);
+			j1939_session_deactivate_activate_next(session);
+		}
 	} else if (ret) {
+		netdev_alert(priv->ndev, "%s: tx aborted with unknown reason: %i\n",
+			     __func__, ret);
 		j1939_session_cancel(session, J1939_XTP_ABORT_OTHER);
+	} else {
+		session->tx_retry = 0;
 	}
 
 	j1939_session_put(session);
-- 
2.20.1

