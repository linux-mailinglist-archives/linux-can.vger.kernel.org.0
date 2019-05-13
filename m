Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A1E1B639
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2019 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfEMMod (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 May 2019 08:44:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41705 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfEMMod (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 May 2019 08:44:33 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hQAJh-0003Gw-NQ; Mon, 13 May 2019 14:44:29 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <ore@pengutronix.de>)
        id 1hQAJg-000854-8H; Mon, 13 May 2019 14:44:28 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH] j1939: transport: seed retry timeout for (E)TP sessions
Date:   Mon, 13 May 2019 14:44:27 +0200
Message-Id: <20190513124427.30997-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
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

If retry timeout is equal for all systems and/or sockets, it will
collide at some point. In this case, one sender will always have
a chance to send some thing and make the CAN queue full, the other
one will always get -ENOBUS response.
Even if we would implement a scheduler for local system, we can't solve
same problem for multiple identical systems on same bus.

Since the protocol has no other way to avoid this kind of collisions,
we can use random number for retry timer and reduce probability of
colliding retries.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index f469d9e131c7..978f2e194f32 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -116,7 +116,6 @@ enum j1939_xtp_abort {
 };
 
 static unsigned int j1939_tp_block = 255;
-static unsigned int j1939_tp_retry_ms = 20;
 static unsigned int j1939_tp_packet_delay;
 static unsigned int j1939_tp_padding = 1;
 
@@ -873,8 +872,12 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 	int ret;
 
 	ret = j1939_tp_txnext(session);
-	if (ret < 0)
-		j1939_tp_schedule_txtimer(session, j1939_tp_retry_ms ?: 20);
+	if (ret < 0) {
+		u32 random = get_random_u32();
+
+		j1939_tp_schedule_txtimer(session, 10 + (random & 0xf));
+
+	}
 	j1939_session_put(session);
 
 	return HRTIMER_NORESTART;
-- 
2.20.1

