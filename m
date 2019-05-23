Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A43527984
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfEWJlw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54431 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730284AbfEWJlr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:47 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEI-0001Fw-Po; Thu, 23 May 2019 11:41:42 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-00043m-AJ; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 03/17] j1939: transport: seed retry timeout for (E)TP sessions
Date:   Thu, 23 May 2019 11:41:25 +0200
Message-Id: <20190523094139.15517-4-o.rempel@pengutronix.de>
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
 net/can/j1939/transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index e47eff502b6f..0d2b1998d111 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -116,7 +116,6 @@ enum j1939_xtp_abort {
 };
 
 static unsigned int j1939_tp_block = 255;
-static unsigned int j1939_tp_retry_ms = 20;
 static unsigned int j1939_tp_packet_delay;
 static unsigned int j1939_tp_padding = 1;
 
@@ -854,7 +853,8 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 
 	ret = j1939_tp_txnext(session);
 	if (ret < 0)
-		j1939_tp_schedule_txtimer(session, j1939_tp_retry_ms ?: 20);
+		j1939_tp_schedule_txtimer(session, 10 + prandom_u32_max(16));
+
 	j1939_session_put(session);
 
 	return HRTIMER_NORESTART;
-- 
2.20.1

